export WORKLOAD=main
CHECKER_HOME ?= /workspace/LLVM-Checker
#include ../Makefile.include

SRCS = $(wildcard *.c)
HDRS = $(wildcard *.h)
EXEC = OUTPUT
CC=clang
CG=clang++
MC=mpicc
# 从 mpicc 推导 MPI 标志，取不到时回退到 Debian/Ubuntu 的默认位置
MPI_CFLAGS := $(shell $(MC) -showme:compile 2>/dev/null)
MPI_LDFLAGS := $(shell $(MC) -showme:link 2>/dev/null)
C_INC ?= $(or $(MPI_CFLAGS),-I/usr/lib/x86_64-linux-gnu/openmpi/include/)
MPI_LINK ?= $(or $(MPI_LDFLAGS),-lmpi)
LHYPRE=-L/usr/local/hypre/lib

#INCLUDE_CFLAGS = -DTIMER_USE_MPI -DHYPRE_USING_OPENMP -fopenmp -DHYPRE_HOPSCOTCH -DHYPRE_USING_PERSISTENT_COMM -DHYPRE_BIGINT -DHYPRE_TIMING
INCLUDE_CFLAGS = -DTIMER_USE_MPI -DHYPRE_HOPSCOTCH -DHYPRE_USING_PERSISTENT_COMM -DHYPRE_BIGINT -DHYPRE_TIMING 
LLVM_DIR := $(shell llvm-config --prefix)
LLVM_LIBS := $(LLVM_DIR)/lib
LLVM_INCLUDE := $(LLVM_DIR)/include

ADDFLAG = $(CHECKER_HOME)/lib/addflag.ll
ADDOTHER = $(CHECKER_HOME)/lib/addother.ll

LOOPRANGE = $(CHECKER_HOME)/lib/LoopRange.so
LINKCHECKER = $(CHECKER_HOME)/lib/LinkChecker.so
CHECKER = $(CHECKER_HOME)/lib/Checker.so

SFILES = ./cher_sourceIRFiles
PFILES = ./cher_processIRFiles

LLVM_OBJS = $(patsubst %.c, %.ll, $(SRCS))

DEBUG = -g ${C_INC} -fdebug-info-for-profiling -fno-discard-value-names -O0 -static -emit-llvm -DSMALL

%.ll:%.c
	$(CC) -S $(DEBUG) $(INCLUDE_CFLAGS) -o $*.ll $<

cher_test.ll:$(LLVM_OBJS)
	llvm-link -o $@ $^ $(ADDFLAG)

cher_change_test.ll:cher_test.ll $(LOOPRANGE) $(LINKCHECKER)
	opt -enable-new-pm=0 -load $(LOOPRANGE) -looprange cher_test.ll
	opt -enable-new-pm=0 -load $(LINKCHECKER) -linkchecker<cher_test.ll> $@ -S

cher_full.ll:cher_change_test.ll $(ADDOTHER)
	llvm-link cher_change_test.ll $(ADDOTHER)  -S -o $@

cher_last.ll:cher_full.ll
	opt -enable-new-pm=0 -load $(CHECKER) -checker<cher_full.ll> $@ -S


${EXEC}:cher_last.ll
	#$(CG) -lm -fopenmp -lz -lmpi -O0 -fno-inline -lstdc++ -o $(EXEC) cher_last.ll ${LHYPRE} -lHYPRE
	$(CG)  -O0 -fno-inline -lstdc++ -o $(EXEC) cher_last.ll -lm -fopenmp -lz $(MPI_LINK) 

all:cher_test.ll cher_change_test.ll cher_full.ll cher_last.ll   ${EXEC}
clean:
	rm -f *.ll *.s *.o ${EXEC}
