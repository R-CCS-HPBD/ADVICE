#!/usr/bin/env bash
# 在计算节点上跑完整 ADVICE 流程（scope → 插桩编译 → 运行）。请在仓库根目录提交。
# 用法：sbatch run-advice.sbatch <benchmark>       例：sbatch run-advice.sbatch NPB/BT
# 覆盖运行参数：RUN_ARGS="-problem 2" sbatch --export=ALL run-advice.sbatch AMG
#SBATCH --job-name=advice
# fx700 是 R-CCS Cloud 的 aarch64 分区；其他站点用 sbatch -p <partition> 覆盖
#SBATCH --partition=fx700
#SBATCH --nodes=1
#SBATCH --time=02:00:00
#SBATCH --output=advice-%j.log
set -euo pipefail

BENCH="${1:-${BENCH:-}}"

# 每个 benchmark 的 main loop 范围取自各自目录下的 run 脚本
case "$BENCH" in
    AMG)            DIR=AMG/test;        SCOPE="474 570 main";        DEF_ARGS="-problem 2" ;;
    CoMD)           DIR=CoMD/src-mpi;    SCOPE="113 126 main";        DEF_ARGS="" ;;
    HPCCG)          DIR=HPCCG;           SCOPE="117 145 _Z5HPCCGP24HPC_Sparse_Matrix_STRUCTPKdPdidRiRdS3_"; DEF_ARGS="3 3 3" ;;
    Himeno)         DIR=Himeno;          SCOPE="186 217 jacobi";      DEF_ARGS="" ;;
    NPB/BT)         DIR=NPB/BT;          SCOPE="180 186 main";        DEF_ARGS="" ;;
    NPB/CG)         DIR=NPB/CG;          SCOPE="296 330 main";        DEF_ARGS="" ;;
    NPB/EP)         DIR=NPB/EP;          SCOPE="168 213 main";        DEF_ARGS="" ;;
    NPB/FT)         DIR=NPB/FT;          SCOPE="109 119 appft";       DEF_ARGS="" ;;
    NPB/IS)         DIR=NPB/IS;          SCOPE="732 736 main";        DEF_ARGS="" ;;
    NPB/LU)         DIR=NPB/LU;          SCOPE="115 267 ssor";        DEF_ARGS="" ;;
    NPB/MG)         DIR=NPB/MG;          SCOPE="266 276 main";        DEF_ARGS="" ;;
    NPB/SP)         DIR=NPB/SP;          SCOPE="184 190 main";        DEF_ARGS="" ;;
    miniAMR/openmp) DIR=miniAMR/openmp;  SCOPE="63 131 driver";       DEF_ARGS="--nx 2 --ny 2 --nz 2 --max_blocks 2" ;;
    miniAMR/ref)    DIR=miniAMR/ref;     SCOPE="68 162 driver";       DEF_ARGS="--nx 2 --ny 2 --nz 2 --max_blocks 2" ;;
    *)
        echo "用法：sbatch run-advice.sbatch <benchmark>"
        echo "可选：AMG CoMD HPCCG Himeno NPB/{BT,CG,EP,FT,IS,LU,MG,SP} miniAMR/{openmp,ref}"
        exit 2 ;;
esac

ADVICE_HOME="${ADVICE_HOME:-${SLURM_SUBMIT_DIR:-$PWD}}"
source "$ADVICE_HOME/advice-activate.sh"
RUN_ARGS="${RUN_ARGS:-$DEF_ARGS}"

echo "== $BENCH on $(hostname) [$(uname -m)]  $(date)"
echo "== clang $(clang --version | head -1)"

# lib/Data 是全局共享状态，同一时刻只能跑一个 ADVICE 作业
cd "$CHECKER_HOME/lib"
./scope.exe $SCOPE
echo "== mainloop: $(tr '\n' ' ' < Data/mainloopData.txt)"

cd "$CHECKER_HOME/test/benchmarks/$DIR"
make clean
make build
# Makefile 里的 opt -looprange 没带 -o，会把 bitcode 打到 stdout，单独存一份
echo "== 插桩编译 =="
time make all > build.log 2>&1 || { echo "!! make 失败"; tail -40 build.log; exit 1; }
grep -aE "^(clang|opt|llvm-link|insert)" build.log | tail -8

echo "== 运行: ./OUTPUT $RUN_ARGS =="
time ./OUTPUT $RUN_ARGS

cp "$CHECKER_HOME/lib/Data/unique_variables.txt" ./ 2>/dev/null || true
echo "== done $(date)"
