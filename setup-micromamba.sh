#!/usr/bin/env bash
# 在无 Docker 的 Linux 节点上用 micromamba 搭建 ADVICE 环境（LLVM 13 + GCC 11 头文件）。
# 全程不需要 sudo：源码路径通过 CHECKER_HOME 传入，不再依赖 /workspace/LLVM-Checker。
# 在 Slurm 登录节点上执行时，如果 ADVICE_PARTITION 指定的分区存在，会自动 srun 到计算节点再继续
# （因为 .so / .ll 带本机 target triple，必须在目标架构上生成）。
# 用法：./setup-micromamba.sh [ADVICE_SRC_DIR]
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SRC="$(cd "${1:-$(dirname "${BASH_SOURCE[0]}")}" && pwd)"
ENV_NAME="${ADVICE_ENV_NAME:-advice}"
ARCH="$(uname -m)"
PARTITION="${ADVICE_PARTITION:-fx700}"

# 只有在登录节点且该分区确实存在时才跳转；其他环境直接就地构建
if [[ -z "${ADVICE_IN_JOB:-}" && -z "${SLURM_JOB_ID:-}" ]] \
   && command -v srun >/dev/null 2>&1 \
   && sinfo -h -p "$PARTITION" -o "%P" 2>/dev/null | grep -q .; then
    echo "==> 当前在 $ARCH 登录节点，转到 $PARTITION 计算节点执行（节点满时会排队）"
    PTY=()
    [[ -t 0 ]] && PTY=(--pty)
    exec srun -p "$PARTITION" ${ADVICE_SRUN_OPTS:-} "${PTY[@]}" \
        env ADVICE_IN_JOB=1 ADVICE_ENV_NAME="$ENV_NAME" bash "$SELF" "$SRC"
fi

echo "==> 架构：$ARCH   源码：$SRC"

# 登录节点的 conda/mamba 环境会把 x86_64 的 bzip2/tar 等带进作业，先清干净
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/bin:/sbin"
unset LD_LIBRARY_PATH PYTHONPATH PYTHONHOME MAMBA_EXE \
      CONDA_PREFIX CONDA_DEFAULT_ENV CONDA_EXE CONDA_PYTHON_EXE CONDA_SHLVL || true

# 每个架构一个 root，避免和登录节点已有的 x86_64 env 混在一起
export MAMBA_ROOT_PREFIX="${ADVICE_MAMBA_ROOT:-$HOME/micromamba-$ARCH}"

# PATH 里现成的 micromamba 可能是登录节点的 x86_64 版，按架构各存一份
MAMBA_BIN="$HOME/.local/bin/micromamba-$ARCH"
if ! "$MAMBA_BIN" --version >/dev/null 2>&1; then
    echo "==> 安装 linux-$ARCH 版 micromamba 到 $MAMBA_BIN"
    mkdir -p "$HOME/.local/bin"
    tmpd="$(mktemp -d)"
    curl -Ls "https://micro.mamba.pm/api/micromamba/linux-$ARCH/latest" \
        | tar -xj -C "$tmpd" bin/micromamba
    install -m 755 "$tmpd/bin/micromamba" "$MAMBA_BIN"
    rm -rf "$tmpd"
fi
echo "==> micromamba: $MAMBA_BIN ($("$MAMBA_BIN" --version))   root: $MAMBA_ROOT_PREFIX"

ENV_PREFIX="$MAMBA_ROOT_PREFIX/envs/$ENV_NAME"
SUBDIR="linux-aarch64"
[[ "$ARCH" == x86_64 ]] && SUBDIR="linux-64"
# 对齐 Dockerfile 的 ubuntu:22.04（GCC 11）：clang 13 解析不了 GCC 13+ 的头文件，
# 而 GCC 12 的 std::__new_allocator 等实例会被 Pass 当成用户函数插桩，导致运行时无限递归
GCC_HDR="${ADVICE_GCC_HEADERS:-11}"

if [[ -x "$ENV_PREFIX/bin/llvm-config" ]]; then
    echo "==> 环境已存在，跳过创建（要重建就删掉 $ENV_PREFIX）"
else
    echo "==> 确认 conda-forge 有本架构的 llvmdev 13"
    "$MAMBA_BIN" search -c conda-forge 'llvmdev=13.0.1' >/dev/null || {
        echo "!! linux-$ARCH 没有 llvmdev 13.0.1，改用 apt.llvm.org 的 llvm-13 或换 x86_64 节点"; exit 1; }
    "$MAMBA_BIN" create -y -n "$ENV_NAME" -f "$SRC/environment.yml"
fi

# clang 13 解析不了 GCC 13+ 的 libstdc++ 头文件，把头文件退回 GCC $GCC_HDR
if ! compgen -G "$ENV_PREFIX/lib/gcc/*/$GCC_HDR.*" >/dev/null; then
    echo "==> 降级 libstdc++ 头文件到 GCC $GCC_HDR"
    "$MAMBA_BIN" install -y -n "$ENV_NAME" -c conda-forge \
        "libstdcxx-devel_$SUBDIR=$GCC_HDR" "libgcc-devel_$SUBDIR=$GCC_HDR"
fi

# shell hook 定义的函数名跟着二进制名走，直接按 prefix 激活更省事
export CONDA_PREFIX="$ENV_PREFIX"
export PATH="$ENV_PREFIX/bin:$PATH"
export LD_LIBRARY_PATH="$ENV_PREFIX/lib:${LD_LIBRARY_PATH:-}"
export CHECKER_HOME="$SRC"

# 后续 shell / 批处理作业里 source 这个文件即可
cat > "$SRC/advice-activate.sh" <<EOF
# source 本文件以进入 ADVICE 环境
export CONDA_PREFIX="$ENV_PREFIX"
export PATH="$ENV_PREFIX/bin:\$PATH"
export LD_LIBRARY_PATH="$ENV_PREFIX/lib:\${LD_LIBRARY_PATH:-}"
export CHECKER_HOME="$SRC"
EOF
echo "==> 已生成 $SRC/advice-activate.sh"

echo "==> 为 $ARCH 重新生成 Pass 与 IR"
bash "$SRC/build-lib.sh" lib

echo "==> 关键验证：opt 能否加载 out-of-tree Pass"
tmp="$(mktemp -d)"
echo 'define i32 @main(){ ret i32 0 }' > "$tmp/t.ll"
if opt -enable-new-pm=0 -load "$SRC/lib/LoopRange.so" -looprange "$tmp/t.ll" -o /dev/null 2>"$tmp/err"; then
    echo "==> OK：插件机制可用"
else
    echo "!! 插件加载失败："; cat "$tmp/err"
fi
rm -rf "$tmp"

cat <<EOF

环境就绪。以后每次使用：
  srun -p $PARTITION --pty bash
  source "$SRC/advice-activate.sh"
  cd "$SRC/test/benchmarks/HPCCG" && make build && make all

CHECKER_HOME 已经取代硬编码的 /workspace/LLVM-Checker：
  - Makefile 里写成 CHECKER_HOME ?= …，环境变量优先
  - Pass 与插桩代码在运行时读 CHECKER_HOME（可用 CHECKER_DATA_DIR 单独指定数据目录）
  - 用 newlib 时：CHECKER_HOME 指向的目录里 lib/ 必须是 newlib 的内容
EOF

# 已经占着 GH200 节点，直接留在激活好的交互 shell 里（exit 释放节点）
if [[ -n "${ADVICE_IN_JOB:-}" && -t 0 ]]; then
    exec bash --rcfile <(echo "source ~/.bashrc 2>/dev/null; source '$SRC/advice-activate.sh'")
fi


