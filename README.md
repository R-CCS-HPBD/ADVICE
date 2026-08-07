# ADVICE

*[English](#advice) · [中文](#advice-中文文档)*

ADVICE is a set of out-of-tree LLVM passes that combine static analysis with IR instrumentation to
identify which variables of an HPC program must be checkpointed.

The build is version-sensitive: the passes are written against the **LLVM 13 legacy PassManager**,
and the generated `.ll` files carry a target triple. Section [Requirements](#requirements) lists the
exact versions that are known to work, and section [Why the versions are pinned](#why-the-versions-are-pinned)
explains what breaks otherwise.

---

## Repository layout

```
lib/                 The three core passes, the instrumentation runtime, and the shared Data/ directory
newlib/              Variant that also inserts checkpoint code (InsertCheckpointCode)
test/benchmarks/     AMG, CoMD, HPCCG, Himeno, NPB, miniAMR
Dockerfile           Reference environment (Ubuntu 22.04 + apt llvm-13, x86_64)
advice-env.sh        Builds and enters the Docker container
environment.yml      Conda package list for the micromamba route
setup-micromamba.sh  Creates the conda environment and rebuilds lib/ for the current architecture
build-lib.sh         Rebuilds only the passes (.so) and IR (.ll)
run-advice.sbatch    Slurm batch script that runs the full pipeline for one benchmark
```

The passes and the instrumented program exchange data through plain text files under **`lib/Data/`**
(`funcNameData.txt`, `dataMap.txt`, `mainloopData.txt`, `cp.txt`, …). This directory is **global
shared state**; see [Known issues](#known-issues).

---

## Requirements

### Toolchain

| Component | Required version | Note |
| --- | --- | --- |
| LLVM / Clang | **13.x** (tested: 13.0.1) | Hard requirement — the passes use the legacy PassManager, removed in LLVM 14 |
| `clang`, `clang++`, `opt`, `llvm-link`, `llvm-config` | must be on `PATH` **without a version suffix** | The Makefiles call `clang`, not `clang-13` |
| libstdc++ headers | **GCC 11.x** (tested: 11.4.0) | Clang 13 cannot parse the libstdc++ headers of GCC ≥ 13 |
| GNU Make | ≥ 4.x (tested: 4.4.1) | |
| zlib | ≥ 1.2 (tested: 1.3.2) | Required by LLVM |
| glibc | ≥ 2.28 | |
| MPI | OpenMPI ≥ 4 (tested: 5.0.10) | Only for AMG, CoMD, NPB and miniAMR MPI builds |
| Python | not required | |

### Platforms

| Platform | Status |
| --- | --- |
| `linux-64` (x86_64) | Supported. Reference environment is the provided Dockerfile |
| `linux-aarch64` (A64FX, Grace, Ampere, …) | Supported. Requires `build-lib.sh` first, see [Why the versions are pinned](#why-the-versions-are-pinned) |
| macOS / Windows | Not supported |

### Choosing an installation route

| Route | Use when | Command |
| --- | --- | --- |
| **Docker** | You have Docker and an x86_64 host | `./advice-env.sh` |
| **micromamba / conda** | No root, or a cluster, or aarch64 | `./setup-micromamba.sh` |
| **System packages** | You already have LLVM 13 installed | See [Using a system LLVM 13](#using-a-system-llvm-13) |

---

## Installation

### Route A — Docker (x86_64)

```bash
./advice-env.sh          # build the image and enter it, mounting the repo at /workspace/LLVM-Checker
./advice-env.sh newlib   # same, but mount newlib/ as lib/
```

The image is Ubuntu 22.04 with `clang-13 llvm-13 llvm-13-dev libclang-13-dev` from apt
(libstdc++ 11 comes with the base image), and sets `CHECKER_HOME=/workspace/LLVM-Checker`.
The `.ll` files committed to the repository were generated on x86_64, so no rebuild is needed here.

### Route B — micromamba / conda (any Linux, no root)

```bash
./setup-micromamba.sh
```

The script is idempotent and will:

1. install micromamba for the current architecture into `~/.local/bin/micromamba-$(uname -m)`
   (skipped if already present);
2. create the `advice` environment from [environment.yml](environment.yml) in
   `~/micromamba-$(uname -m)/envs/advice`;
3. pin the libstdc++ headers to GCC 11 (conda would otherwise install GCC 16 headers);
4. write `advice-activate.sh`, which you `source` in later shells;
5. run [build-lib.sh](build-lib.sh) to regenerate `.so` and `.ll` for the current architecture;
6. verify that `opt -load` can load an out-of-tree pass.

If you are on a Slurm login node and the partition named by `ADVICE_PARTITION` (default `fx700`)
exists, the script re-executes itself on a compute node of that partition first. This matters when
the login node and the compute nodes have different architectures. On any other machine the check
fails harmlessly and the build happens locally.

Conda already offers an equivalent workflow:

```bash
conda env create -f environment.yml
conda activate advice
conda install -c conda-forge "libstdcxx-devel_linux-64=11" "libgcc-devel_linux-64=11"
export CHECKER_HOME=$PWD
./build-lib.sh lib
```

### Route C — using a system LLVM 13

Debian/Ubuntu, via [apt.llvm.org](https://apt.llvm.org):

```bash
sudo apt install clang-13 llvm-13 llvm-13-dev libclang-13-dev zlib1g-dev make
export PATH=/usr/lib/llvm-13/bin:$PATH   # the Makefiles need unsuffixed clang/opt/llvm-config
export CHECKER_HOME=$PWD
./build-lib.sh lib
```

Any LLVM 13 installation works as long as `llvm-config --version` reports `13.x` and the
libstdc++ headers on the include path come from GCC 11 or 12.

### Verifying the installation

```bash
llvm-config --version                 # must print 13.x
echo 'define i32 @main(){ ret i32 0 }' > /tmp/t.ll
opt -enable-new-pm=0 -load $CHECKER_HOME/lib/LoopRange.so -looprange /tmp/t.ll -o /dev/null
```

---

## Configuration

| Variable | Default | Meaning |
| --- | --- | --- |
| `CHECKER_HOME` | `/workspace/LLVM-Checker` | **Root of the source tree.** Used by the passes, the instrumentation runtime and the Makefiles to locate `lib/Data/` |
| `CHECKER_DATA_DIR` | `$CHECKER_HOME/lib/Data/` | Override the data directory alone (useful when working out of `newlib/`) |
| `ADVICE_ENV_NAME` | `advice` | Conda environment name |
| `ADVICE_MAMBA_ROOT` | `$HOME/micromamba-$(uname -m)` | Mamba root, kept separate per architecture |
| `ADVICE_GCC_HEADERS` | `11` | Major GCC version of the libstdc++ headers to install |
| `ADVICE_PARTITION` | `fx700` | Slurm partition to hop onto; ignored if it does not exist |
| `ADVICE_SRUN_OPTS` | empty | Extra options appended to `srun` |
| `ADVICE_HOME` | `$SLURM_SUBMIT_DIR` | Where `run-advice.sbatch` looks for the source tree |
| `RUN_ARGS` | per-benchmark, see the table below | Override a benchmark's runtime arguments |

Path resolution order: `CHECKER_DATA_DIR` → `$CHECKER_HOME/lib/Data/` → fall back to
`/workspace/LLVM-Checker` so that the original Docker flow behaves exactly as before.
Implementation: [lib/CheckerPaths.h](lib/CheckerPaths.h).

---

## Usage

### Running one benchmark by hand

```bash
source ./advice-activate.sh                  # or: export CHECKER_HOME=$PWD

cd $CHECKER_HOME/lib                         # 1. declare where the main loop is
./scope.exe 180 186 main                     #    args: start line, end line, function name
                                             #    (use the mangled name for C++)

cd $CHECKER_HOME/test/benchmarks/NPB/BT      # 2. instrumented build
make clean && make build && make all

./OUTPUT                                     # 3. run; the checkpoint variables are printed
                                             #    after "need checkpoint var :"
```

Expected tail of the output:

```
need checkpoint var :
(WAR)   func GlobalVar , u
the end!!
```

### Running on a Slurm cluster

```bash
sbatch run-advice.sbatch NPB/BT              # submit from the repository root
sbatch -p <partition> run-advice.sbatch Himeno
RUN_ARGS="-problem 2" sbatch --export=ALL run-advice.sbatch AMG
```

`run-advice.sbatch` performs the manual steps above and writes to `advice-<jobid>.log`.
**Do not run two ADVICE jobs concurrently** — see [Known issues](#known-issues).
To queue several benchmarks, chain them:

```bash
J=$(sbatch --parsable run-advice.sbatch NPB/CG)
sbatch --dependency=afterany:$J run-advice.sbatch NPB/MG
```

### What `make all` does

```
*.c ──clang -emit-llvm──▶ *.ll
  └─ llvm-link + addflag.ll ──▶ cher_test.ll
       └─ opt -looprange   ──▶ loopRangeData.txt
       └─ opt -linkchecker ──▶ cher_change_test.ll + funcNameData.txt / dataMap.txt / …
            └─ llvm-link + addother.ll ──▶ cher_full.ll     (links in the instrumentation runtime)
                 └─ opt -checker ──▶ cher_last.ll ──clang++──▶ OUTPUT
```

### Benchmarks

The `scope` column holds the arguments for `./scope.exe`; they come from the `run` script shipped in
each benchmark directory.

| key | directory | scope arguments | default run arguments |
| --- | --- | --- | --- |
| `AMG` | `AMG/test` | `474 570 main` | `-problem 2` |
| `CoMD` | `CoMD/src-mpi` | `113 126 main` | — |
| `HPCCG` | `HPCCG` | `117 145 _Z5HPCCGP24HPC_Sparse_Matrix_STRUCTPKdPdidRiRdS3_` | `3 3 3` |
| `Himeno` | `Himeno` | `186 217 jacobi` | — |
| `NPB/BT` | `NPB/BT` | `180 186 main` | — |
| `NPB/CG` | `NPB/CG` | `296 330 main` | — |
| `NPB/EP` | `NPB/EP` | `168 213 main` | — |
| `NPB/FT` | `NPB/FT` | `109 119 appft` | — |
| `NPB/IS` | `NPB/IS` | `732 736 main` | — |
| `NPB/LU` | `NPB/LU` | `115 267 ssor` | — |
| `NPB/MG` | `NPB/MG` | `266 276 main` | — |
| `NPB/SP` | `NPB/SP` | `184 190 main` | — |
| `miniAMR/openmp` | `miniAMR/openmp` | `63 131 driver` | `--nx 2 --ny 2 --nz 2 --max_blocks 2` |
| `miniAMR/ref` | `miniAMR/ref` | `68 162 driver` | `--nx 2 --ny 2 --nz 2 --max_blocks 2` |

NPB defaults to the smallest size shipped with the artifact (`-DSMALL` plus `npbparams.h`). BT for
instance runs as `Class U / 3x3x3 / 3 iterations` and therefore reports
`Verification = UNSUCCESSFUL`; the preceding line says `No reference values provided`, so this is
expected. Edit `npbparams.h` or supply `inputbt.data` for a real problem class.

---

## Why the versions are pinned

| Constraint | What happens otherwise |
| --- | --- |
| **LLVM 13** | The passes register through the legacy PassManager and are loaded with `opt -enable-new-pm=0 -load`. LLVM 14 removed both, so the passes do not build and `opt` rejects `-load` |
| **libstdc++ headers from GCC 11** | Conda pulls the newest GCC headers (currently 16) by default; clang 13 cannot parse them and emits a wall of `member access into incomplete type '__gnu_cxx::__normal_iterator<...>'` errors |
| **`.so` and `.ll` must be built on the target architecture** | `lib/addflag.ll`, `lib/addother.ll` and `lib/scope.ll` are committed as x86_64 IR (`target triple = "x86_64-unknown-linux-gnu"`). On any other architecture `llvm-link` fails. Run `./build-lib.sh lib` after cloning on non-x86_64 |
| **Unsuffixed `clang` / `opt` on `PATH`** | The Makefiles invoke `clang`, `opt`, `llvm-link` and `llvm-config` without a version suffix; a distro install needs `export PATH=/usr/lib/llvm-13/bin:$PATH` |
| **One mamba root per architecture** | Sharing `$HOME/micromamba` between architectures resolves binaries for the wrong one (`cannot execute binary file: Exec format error`) |

### Reference environment

Package versions verified on `linux-aarch64`; the `linux-64` builds carry the same version numbers.

```
clang / clangxx / llvmdev / llvm-tools / libllvm13 / lld   13.0.1
libstdcxx-devel_linux-* / libgcc-devel_linux-*             11.4.0
libstdcxx-ng / libgcc-ng (runtime)                         16.1.0
binutils_impl_linux-*                                      2.46.1
sysroot_linux-*                                            2.28   (glibc)
make                                                       4.4.1
zlib                                                       1.3.2
openmpi                                                    5.0.10
micromamba                                                 2.8.1
```

---

## Known issues

1. **`lib/Data/` is global shared state.** Every benchmark reads and writes the same
   `funcNameData.txt`, `dataMap.txt` and `mainloopData.txt`. **Only one ADVICE build/run may be in
   flight at a time**; concurrent jobs overwrite each other's data files and produce wrong results
   or crashes.
2. **C++ benchmarks (HPCCG) crash at runtime.** `LinkChecker` records libstdc++ and `__gnu_cxx`
   template instantiations (`_ZNSt…`, `_ZN9__gnu_cxx…`) in `funcNameData.txt` as if they were user
   functions. `Checker` then instruments them with `cher_funcsIO`, which itself compares
   `std::string`s, so the instrumented comparison operators call back into `cher_funcsIO` — unbounded
   recursion and a stack overflow. C benchmarks collect zero such symbols and are unaffected
   (HPCCG collects 96). Reproducible with GCC 11 and GCC 12 headers alike, on both x86_64 and
   aarch64. A fix would skip symbols prefixed with `_ZSt`, `_ZNSt`, `_ZNKSt` and `_ZN9__gnu_cxx`
   in `LinkChecker.cpp` and `Checker.cpp`.
3. **`lib/InsertCheckpointCode.cpp` does not compile** (an extraneous `}` and undeclared `builder` /
   `Buildervar`). The original `lib/makerun` never built it, and `build-lib.sh` skips it as well.
   The copy in `newlib/` is fine.
4. **Binary noise in build logs.** The Makefile rule
   `opt -enable-new-pm=0 -load $(LOOPRANGE) -looprange cher_test.ll` has no `-o`, so the resulting
   bitcode is written to stdout. `run-advice.sbatch` redirects `make` output to `build.log` to keep
   the job log readable.
5. **`scope.exe` takes hardcoded line numbers.** Editing a benchmark's sources invalidates the main
   loop range in the table above.

---

## Troubleshooting

| Symptom | Cause and fix |
| --- | --- |
| `opt: unknown pass` or the plugin fails to load | `llvm-config --version` is not 13.x, or the `.so` was built against a different LLVM. Re-run `./build-lib.sh lib` |
| `clang: command not found` but `clang-13` exists | `export PATH=/usr/lib/llvm-13/bin:$PATH` |
| A wall of `incomplete type` / `__normal_iterator` errors | libstdc++ headers are too new. Reinstall with `ADVICE_GCC_HEADERS=11`, or point clang at a GCC 11/12 toolchain with `--gcc-toolchain` |
| `llvm-link: expected top-level entity` or a target-triple mismatch | The `.ll` files are still x86_64. Run `./build-lib.sh lib` |
| `clang: no such file or directory: 'addflag.c'` | `CHECKER_HOME` points at the wrong directory |
| The instrumented binary segfaults | Check that the `scope.exe` arguments match the benchmark you just built; for C++ benchmarks see Known issues #2 |
| `micromamba: cannot execute binary file: Exec format error` | A micromamba built for a different architecture is on `PATH`. Re-run `setup-micromamba.sh`, which installs `micromamba-$(uname -m)` |
| `bzip2: cannot execute binary file` during setup | Another conda environment for a different architecture leaked into the shell. `conda deactivate` first |
| `micromamba: command not found` when activating | Do not use `micromamba shell hook`; `advice-activate.sh` exports `PATH` from the environment prefix directly |
| Results differ between two runs of the same benchmark | Another ADVICE job overwrote `lib/Data/`. Serialize the runs |

---
---

# ADVICE（中文文档）

*[English](#advice) · [中文](#advice-中文文档)*

ADVICE 是一组 out-of-tree LLVM Pass，通过静态分析 + IR 插桩找出 HPC 程序中必须做检查点
（checkpoint）的变量。

这套代码对版本很敏感：Pass 基于 **LLVM 13 的 legacy PassManager** 编写，生成的 `.ll` 还带有
target triple。[依赖要求](#依赖要求)一节列出了确认可用的精确版本，
[为什么锁定这些版本](#为什么锁定这些版本)一节说明版本不对会出什么问题。

---

## 仓库结构

```
lib/                 三个核心 Pass、插桩运行时，以及共享数据目录 Data/
newlib/              额外插入检查点代码的变体（InsertCheckpointCode）
test/benchmarks/     AMG、CoMD、HPCCG、Himeno、NPB、miniAMR
Dockerfile           参考环境（Ubuntu 22.04 + apt llvm-13，x86_64）
advice-env.sh        构建并进入 Docker 容器
environment.yml      micromamba 路线的 conda 包清单
setup-micromamba.sh  创建 conda 环境并按当前架构重建 lib/
build-lib.sh         只重建 Pass（.so）与 IR（.ll）
run-advice.sbatch    跑单个 benchmark 完整流程的 Slurm 作业脚本
```

Pass 与插桩后的程序之间靠 **`lib/Data/`** 下的纯文本文件通信（`funcNameData.txt`、`dataMap.txt`、
`mainloopData.txt`、`cp.txt` 等）。该目录是**全局共享状态**，见[已知问题](#已知问题)。

---

## 依赖要求

### 工具链

| 组件 | 需要的版本 | 说明 |
| --- | --- | --- |
| LLVM / Clang | **13.x**（已验证 13.0.1） | 硬性要求 —— Pass 用的 legacy PassManager 在 LLVM 14 已被移除 |
| `clang`、`clang++`、`opt`、`llvm-link`、`llvm-config` | 必须以**不带版本后缀**的名字出现在 `PATH` 中 | Makefile 调用的是 `clang` 而非 `clang-13` |
| libstdc++ 头文件 | **GCC 11.x**（已验证 11.4.0） | clang 13 解析不了 GCC ≥ 13 的 libstdc++ 头文件 |
| GNU Make | ≥ 4.x（已验证 4.4.1） | |
| zlib | ≥ 1.2（已验证 1.3.2） | LLVM 需要 |
| glibc | ≥ 2.28 | |
| MPI | OpenMPI ≥ 4（已验证 5.0.10） | 仅 AMG、CoMD、NPB 与 miniAMR 的 MPI 版本需要 |
| Python | 不需要 | |

### 支持的平台

| 平台 | 状态 |
| --- | --- |
| `linux-64`（x86_64） | 支持。参考环境即仓库自带的 Dockerfile |
| `linux-aarch64`（A64FX、Grace、Ampere 等） | 支持。需要先跑 `build-lib.sh`，原因见[为什么锁定这些版本](#为什么锁定这些版本) |
| macOS / Windows | 不支持 |

### 选择安装路线

| 路线 | 适用场景 | 命令 |
| --- | --- | --- |
| **Docker** | 有 Docker 且是 x86_64 主机 | `./advice-env.sh` |
| **micromamba / conda** | 没有 root、在集群上，或者是 aarch64 | `./setup-micromamba.sh` |
| **系统包** | 已经装好了 LLVM 13 | 见[路线 C](#路线-c--使用系统自带的-llvm-13) |

---

## 安装

### 路线 A —— Docker（x86_64）

```bash
./advice-env.sh          # 构建镜像并进入，仓库挂载到 /workspace/LLVM-Checker
./advice-env.sh newlib   # 同上，但把 newlib/ 挂成 lib/
```

镜像是 Ubuntu 22.04，从 apt 装 `clang-13 llvm-13 llvm-13-dev libclang-13-dev`
（libstdc++ 11 由基础镜像提供），并设置 `CHECKER_HOME=/workspace/LLVM-Checker`。
仓库里提交的 `.ll` 就是 x86_64 的，这条路线不需要重建。

### 路线 B —— micromamba / conda（任意 Linux，无需 root）

```bash
./setup-micromamba.sh
```

脚本是幂等的，它会：

1. 按当前架构把 micromamba 装到 `~/.local/bin/micromamba-$(uname -m)`（已存在则跳过）；
2. 用 [environment.yml](environment.yml) 在 `~/micromamba-$(uname -m)/envs/advice` 建环境；
3. 把 libstdc++ 头文件固定到 GCC 11（否则 conda 会装 GCC 16 的头文件）；
4. 生成 `advice-activate.sh`，之后的 shell 里 `source` 它即可；
5. 调 [build-lib.sh](build-lib.sh) 按当前架构重新生成 `.so` 与 `.ll`；
6. 验证 `opt -load` 能加载 out-of-tree Pass。

如果你在 Slurm 登录节点上执行，且 `ADVICE_PARTITION`（默认 `fx700`）指定的分区确实存在，
脚本会先把自己 `srun` 到该分区的计算节点再继续 —— 登录节点与计算节点架构不同时这一步是必需的。
在其他机器上这个判断不成立，脚本直接就地构建。

用 conda 也一样：

```bash
conda env create -f environment.yml
conda activate advice
conda install -c conda-forge "libstdcxx-devel_linux-64=11" "libgcc-devel_linux-64=11"
export CHECKER_HOME=$PWD
./build-lib.sh lib
```

### 路线 C —— 使用系统自带的 LLVM 13

Debian/Ubuntu，经 [apt.llvm.org](https://apt.llvm.org)：

```bash
sudo apt install clang-13 llvm-13 llvm-13-dev libclang-13-dev zlib1g-dev make
export PATH=/usr/lib/llvm-13/bin:$PATH   # Makefile 需要不带后缀的 clang/opt/llvm-config
export CHECKER_HOME=$PWD
./build-lib.sh lib
```

只要 `llvm-config --version` 报 `13.x`，且 include 路径上的 libstdc++ 头文件来自 GCC 11 或 12，
任何 LLVM 13 安装方式都可以。

### 验证安装

```bash
llvm-config --version                 # 必须是 13.x
echo 'define i32 @main(){ ret i32 0 }' > /tmp/t.ll
opt -enable-new-pm=0 -load $CHECKER_HOME/lib/LoopRange.so -looprange /tmp/t.ll -o /dev/null
```

---

## 配置项

| 变量 | 默认值 | 含义 |
| --- | --- | --- |
| `CHECKER_HOME` | `/workspace/LLVM-Checker` | **源码树根目录。** Pass、插桩运行时和 Makefile 都用它定位 `lib/Data/` |
| `CHECKER_DATA_DIR` | `$CHECKER_HOME/lib/Data/` | 单独指定数据目录（基于 `newlib/` 工作时有用） |
| `ADVICE_ENV_NAME` | `advice` | conda 环境名 |
| `ADVICE_MAMBA_ROOT` | `$HOME/micromamba-$(uname -m)` | mamba root，按架构分开 |
| `ADVICE_GCC_HEADERS` | `11` | 要安装的 libstdc++ 头文件对应的 GCC 主版本 |
| `ADVICE_PARTITION` | `fx700` | 要跳转到的 Slurm 分区；不存在则忽略 |
| `ADVICE_SRUN_OPTS` | 空 | 追加给 `srun` 的参数 |
| `ADVICE_HOME` | `$SLURM_SUBMIT_DIR` | `run-advice.sbatch` 用来定位源码树 |
| `RUN_ARGS` | 见下方 benchmark 表 | 覆盖 benchmark 的运行参数 |

路径解析顺序：`CHECKER_DATA_DIR` → `$CHECKER_HOME/lib/Data/` → 回退到 `/workspace/LLVM-Checker`，
以保证原本的 Docker 流程行为完全不变。实现见 [lib/CheckerPaths.h](lib/CheckerPaths.h)。

---

## 使用

### 手动跑一个 benchmark

```bash
source ./advice-activate.sh                  # 或者：export CHECKER_HOME=$PWD

cd $CHECKER_HOME/lib                         # 1. 声明 main loop 的位置
./scope.exe 180 186 main                     #    参数：起始行、结束行、函数名
                                             #    （C++ 要用 mangled 名）

cd $CHECKER_HOME/test/benchmarks/NPB/BT      # 2. 插桩编译
make clean && make build && make all

./OUTPUT                                     # 3. 运行；检查点变量打印在
                                             #    "need checkpoint var :" 之后
```

预期输出末尾：

```
need checkpoint var :
(WAR)   func GlobalVar , u
the end!!
```

### 在 Slurm 集群上运行

```bash
sbatch run-advice.sbatch NPB/BT              # 在仓库根目录提交
sbatch -p <partition> run-advice.sbatch Himeno
RUN_ARGS="-problem 2" sbatch --export=ALL run-advice.sbatch AMG
```

`run-advice.sbatch` 就是把上面的手动步骤串起来，日志写到 `advice-<jobid>.log`。
**不要同时跑两个 ADVICE 作业**，原因见[已知问题](#已知问题)。要排多个 benchmark 就串起来：

```bash
J=$(sbatch --parsable run-advice.sbatch NPB/CG)
sbatch --dependency=afterany:$J run-advice.sbatch NPB/MG
```

### `make all` 做了什么

```
*.c ──clang -emit-llvm──▶ *.ll
  └─ llvm-link + addflag.ll ──▶ cher_test.ll
       └─ opt -looprange   ──▶ loopRangeData.txt
       └─ opt -linkchecker ──▶ cher_change_test.ll + funcNameData.txt / dataMap.txt / …
            └─ llvm-link + addother.ll ──▶ cher_full.ll     （链入插桩运行时）
                 └─ opt -checker ──▶ cher_last.ll ──clang++──▶ OUTPUT
```

### Benchmark 列表

`scope` 一列是 `./scope.exe` 的参数，取自各 benchmark 目录下自带的 `run` 脚本。

| key | 目录 | scope 参数 | 默认运行参数 |
| --- | --- | --- | --- |
| `AMG` | `AMG/test` | `474 570 main` | `-problem 2` |
| `CoMD` | `CoMD/src-mpi` | `113 126 main` | — |
| `HPCCG` | `HPCCG` | `117 145 _Z5HPCCGP24HPC_Sparse_Matrix_STRUCTPKdPdidRiRdS3_` | `3 3 3` |
| `Himeno` | `Himeno` | `186 217 jacobi` | — |
| `NPB/BT` | `NPB/BT` | `180 186 main` | — |
| `NPB/CG` | `NPB/CG` | `296 330 main` | — |
| `NPB/EP` | `NPB/EP` | `168 213 main` | — |
| `NPB/FT` | `NPB/FT` | `109 119 appft` | — |
| `NPB/IS` | `NPB/IS` | `732 736 main` | — |
| `NPB/LU` | `NPB/LU` | `115 267 ssor` | — |
| `NPB/MG` | `NPB/MG` | `266 276 main` | — |
| `NPB/SP` | `NPB/SP` | `184 190 main` | — |
| `miniAMR/openmp` | `miniAMR/openmp` | `63 131 driver` | `--nx 2 --ny 2 --nz 2 --max_blocks 2` |
| `miniAMR/ref` | `miniAMR/ref` | `68 162 driver` | `--nx 2 --ny 2 --nz 2 --max_blocks 2` |

NPB 默认用 artifact 自带的最小规模（`-DSMALL` + `npbparams.h`）。例如 BT 跑的是
`Class U / 3x3x3 / 3 iterations`，因此报 `Verification = UNSUCCESSFUL`；它上一行写着
`No reference values provided`，属正常。要跑真实规模请改 `npbparams.h` 或提供 `inputbt.data`。

---

## 为什么锁定这些版本

| 约束 | 不满足会怎样 |
| --- | --- |
| **LLVM 13** | Pass 通过 legacy PassManager 注册，用 `opt -enable-new-pm=0 -load` 加载。LLVM 14 把两者都删了，Pass 编不过，`opt` 也不认 `-load` |
| **GCC 11 的 libstdc++ 头文件** | conda 默认拉最新的 GCC 头文件（当前是 16），clang 13 解析不了，会刷出大量 `member access into incomplete type '__gnu_cxx::__normal_iterator<...>'` |
| **`.so` 和 `.ll` 必须在目标架构上生成** | `lib/addflag.ll`、`lib/addother.ll`、`lib/scope.ll` 是以 x86_64 IR 形式提交的（`target triple = "x86_64-unknown-linux-gnu"`），换架构后 `llvm-link` 会失败。非 x86_64 平台 clone 之后先跑 `./build-lib.sh lib` |
| **`PATH` 上要有不带后缀的 `clang` / `opt`** | Makefile 直接调 `clang`、`opt`、`llvm-link`、`llvm-config`；发行版安装需要 `export PATH=/usr/lib/llvm-13/bin:$PATH` |
| **每个架构一个 mamba root** | 多架构共用 `$HOME/micromamba` 会解析到错架构的二进制（`cannot execute binary file: Exec format error`） |

### 参考环境

以下版本在 `linux-aarch64` 上验证通过；`linux-64` 的构建版本号相同。

```
clang / clangxx / llvmdev / llvm-tools / libllvm13 / lld   13.0.1
libstdcxx-devel_linux-* / libgcc-devel_linux-*             11.4.0
libstdcxx-ng / libgcc-ng（运行时）                          16.1.0
binutils_impl_linux-*                                      2.46.1
sysroot_linux-*                                            2.28   （glibc）
make                                                       4.4.1
zlib                                                       1.3.2
openmpi                                                    5.0.10
micromamba                                                 2.8.1
```

---

## 已知问题

1. **`lib/Data/` 是全局共享状态。** 所有 benchmark 读写同一份 `funcNameData.txt`、`dataMap.txt`、
   `mainloopData.txt`。**同一时刻只能进行一次 ADVICE 构建/运行**，并发会互相覆盖数据文件，
   导致结果错误甚至崩溃。
2. **C++ benchmark（HPCCG）运行时崩溃。** `LinkChecker` 会把 libstdc++ 和 `__gnu_cxx` 的模板实例
   （`_ZNSt…`、`_ZN9__gnu_cxx…`）当作用户函数写进 `funcNameData.txt`，`Checker` 随后给它们插入
   `cher_funcsIO`；而 `cher_funcsIO` 自己要比较 `std::string`，于是被插桩的比较运算符又回调
   `cher_funcsIO` —— 无限递归、爆栈。C 代码收集到的这类符号为 0，不受影响（HPCCG 是 96 个）。
   GCC 11 和 GCC 12 头文件都能复现，x86_64 与 aarch64 都一样。修法是在 `LinkChecker.cpp` 与
   `Checker.cpp` 中跳过 `_ZSt`、`_ZNSt`、`_ZNKSt`、`_ZN9__gnu_cxx` 前缀的符号。
3. **`lib/InsertCheckpointCode.cpp` 编译不过**（多余的 `}`，以及未声明的 `builder` / `Buildervar`）。
   原始的 `lib/makerun` 本来就没编译它，`build-lib.sh` 同样跳过。`newlib/` 里的那份是好的。
4. **构建日志里有二进制乱码。** Makefile 规则
   `opt -enable-new-pm=0 -load $(LOOPRANGE) -looprange cher_test.ll` 没带 `-o`，bitcode 直接写到了
   stdout。`run-advice.sbatch` 把 `make` 的输出重定向到 `build.log` 以保持作业日志可读。
5. **`scope.exe` 的行号是硬编码的。** 改动 benchmark 源码后，上表里的 main loop 范围就失效了。

---

## 故障排查

| 现象 | 原因与处理 |
| --- | --- |
| `opt: unknown pass` 或插件加载失败 | `llvm-config --version` 不是 13.x，或 `.so` 是针对另一个 LLVM 编的。重跑 `./build-lib.sh lib` |
| 有 `clang-13` 却提示 `clang: command not found` | `export PATH=/usr/lib/llvm-13/bin:$PATH` |
| 大量 `incomplete type` / `__normal_iterator` 报错 | libstdc++ 头文件太新。用 `ADVICE_GCC_HEADERS=11` 重装，或用 `--gcc-toolchain` 把 clang 指向 GCC 11/12 |
| `llvm-link: expected top-level entity` 或 target triple 不匹配 | `.ll` 还是 x86_64 的，跑 `./build-lib.sh lib` |
| `clang: no such file or directory: 'addflag.c'` | `CHECKER_HOME` 指错了目录 |
| 插桩后的程序段错误 | 确认 `scope.exe` 的参数与刚构建的 benchmark 对应；C++ benchmark 见已知问题第 2 条 |
| `micromamba: cannot execute binary file: Exec format error` | `PATH` 上是另一架构的 micromamba。重跑 `setup-micromamba.sh`，它会装 `micromamba-$(uname -m)` |
| 安装过程中报 `bzip2: cannot execute binary file` | shell 里混进了另一架构的 conda 环境，先 `conda deactivate` |
| 激活时 `micromamba: command not found` | 不要用 `micromamba shell hook`；`advice-activate.sh` 是直接按环境 prefix 导出 `PATH` 的 |
| 同一 benchmark 两次运行结果不同 | 有另一个 ADVICE 作业覆盖了 `lib/Data/`，把运行串行化 |
