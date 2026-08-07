#!/usr/bin/env bash
# 为当前架构重新生成 ADVICE 的 Pass 插件(*.so)与需要链接进被测程序的 IR(*.ll)。
# 仓库里自带的 addflag.ll / addother.ll / scope.ll 是 x86_64 的，
# 在 aarch64（例如 GH200）上必须重新生成，否则 llvm-link 会因 target triple 不符而失败。
# 用法：./build-lib.sh [lib|newlib]
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIR="${1:-lib}"
SRC="$HERE/$DIR"

[[ -d "$SRC" ]] || { echo "!! 目录不存在：$SRC"; exit 1; }
command -v llvm-config >/dev/null 2>&1 || { echo "!! 找不到 llvm-config，请先激活 advice 环境"; exit 1; }

LLVM_VER="$(llvm-config --version)"
case "$LLVM_VER" in
    13.*) ;;
    *) echo "!! 需要 LLVM 13（当前 $LLVM_VER）：Pass 用的 legacy PassManager 在 14+ 已被移除"; exit 1 ;;
esac

echo "==> 架构 $(uname -m)   LLVM $LLVM_VER   目标目录 $SRC"
cd "$SRC"
mkdir -p Data

IRFLAGS=(-fdebug-info-for-profiling -fno-discard-value-names -emit-llvm -DSMALL)

echo "==> 生成本机 triple 的 IR"
clang   -S -O0 "${IRFLAGS[@]}" -o addflag.ll  addflag.c
clang++ -S -O0 "${IRFLAGS[@]}" -o addother.ll addother.cpp
clang++ -S -g  "${IRFLAGS[@]}" -o scope.ll    mainloopScope.cpp
clang++ -lm scope.ll -lstdc++ -o scope.exe

echo "==> 编译 Pass 插件"
# lib/InsertCheckpointCode.cpp 源码本身编不过，原始 makerun 也没编它
case "$DIR" in
    newlib) PASSES=(LoopRange LinkChecker Checker InsertCheckpointCode) ;;
    *)      PASSES=(LoopRange LinkChecker Checker findcv) ;;
esac
for pass in "${PASSES[@]}"; do
    [[ -f "$pass.cpp" ]] || continue
    clang $(llvm-config --cxxflags) -Wl,-znodelete -fno-rtti -fPIC -shared \
        "$pass.cpp" -o "$pass.so" $(llvm-config --ldflags)
    echo "    $pass.so"
done

echo "==> 完成。记得 export CHECKER_HOME=$HERE"
