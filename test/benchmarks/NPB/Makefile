export WORKLOAD=main
CHECKER_HOME ?= /workspace/LLVM-Checker

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
#DEBUG = -g ${C_INC}  -O0 
%.ll:%.c 
	$(CC) -S $(DEBUG) -o $*.ll $<

cher_test.ll:$(LLVM_OBJS)
	llvm-link -o $@ $^ $(ADDFLAG)

cher_change_test.ll:cher_test.ll $(LOOPRANGE) $(LINKCHECKER)
	opt -enable-new-pm=0 -load $(LOOPRANGE) -looprange cher_test.ll
	opt -enable-new-pm=0 -load $(LINKCHECKER) -linkchecker<cher_test.ll> $@ -S

cher_full.ll:cher_change_test.ll $(ADDOTHER)
	llvm-link cher_change_test.ll $(ADDOTHER)  -S -o $@

cher_last.ll:cher_full.ll
	opt -enable-new-pm=0 -load $(CHECKER) -checker<cher_full.ll> $@ -S

cher_last.s:cher_last.ll
	#llc -O0 --hexagon-fp-elim -filetype=asm -o $@ $< 
	llc -O0 -o $@ $< 
	#as cher_last.s -o cher_last.o
${EXEC}:cher_last.s
	#${MC}  -O0 -fno-inline  -lstdc++ -o $@  $< -lm -lz

	$(CG) -lm -lz $(MPI_LINK) -O0 -fno-inline -lstdc++ -o $(EXEC) cher_last.ll
#create file
build:
	mkdir -p cher_sourceIRFiles
	mkdir -p cher_processIRFiles

#all:cher_test.ll cher_change_test.ll cher_full.ll cher_last.ll cher_last.bc  cher_last.s cher_last.o ${EXEC}
all:cher_test.ll cher_change_test.ll cher_full.ll cher_last.ll cher_last.s  ${EXEC}
clean:
	rm -f *.ll *.s *.o ${EXEC}


