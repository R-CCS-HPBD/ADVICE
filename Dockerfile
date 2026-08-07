FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        clang-13 llvm-13 llvm-13-dev libclang-13-dev \
        build-essential make \
        libopenmpi-dev openmpi-bin \
        zlib1g-dev \
        ca-certificates less vim \
    && rm -rf /var/lib/apt/lists/*

# makerun / Makefile 调用的是无版本后缀的 clang、opt、llvm-link、llvm-config
ENV PATH=/usr/lib/llvm-13/bin:$PATH

# OpenMPI 默认拒绝以 root 启动
ENV OMPI_ALLOW_RUN_AS_ROOT=1 \
    OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

# Pass、插桩代码和 Makefile 都通过 CHECKER_HOME 定位源码树
ENV CHECKER_HOME=/workspace/LLVM-Checker
WORKDIR /workspace/LLVM-Checker
