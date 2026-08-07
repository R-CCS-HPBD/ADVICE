#!/usr/bin/env bash
# 启动 ADVICE 容器。用法：
#   ./advice-env.sh            使用 lib/
#   ./advice-env.sh newlib     把 newlib/ 挂成 lib/
#   ADVICE_PLATFORM=linux/amd64 ./advice-env.sh    强制 x86-64（QEMU 模拟，慢）
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VARIANT="${1:-lib}"
IMAGE="advice:llvm13"

PLATFORM_ARGS=()
[[ -n "${ADVICE_PLATFORM:-}" ]] && PLATFORM_ARGS=(--platform "$ADVICE_PLATFORM")

docker build "${PLATFORM_ARGS[@]}" -t "$IMAGE" "$HERE"

MOUNTS=(-v "$HERE:/workspace/LLVM-Checker")
if [[ "$VARIANT" == "newlib" ]]; then
    MOUNTS+=(-v "$HERE/newlib:/workspace/LLVM-Checker/lib")
fi

exec docker run --rm -it "${PLATFORM_ARGS[@]}" "${MOUNTS[@]}" \
    -e CHECKER_HOME=/workspace/LLVM-Checker \
    -w /workspace/LLVM-Checker "$IMAGE" bash
