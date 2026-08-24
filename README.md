# ADVICE

*[English](#advice)

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

