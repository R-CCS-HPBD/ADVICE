; ModuleID = 'addflag.c'
source_filename = "addflag.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@cher_flag = dso_local global i32 0, align 4
@cher_start = dso_local global i64 0, align 8
@cher_end = dso_local global i64 0, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @CALLBBNUM(i32 %bbnum) #0 {
entry:
  %bbnum.addr = alloca i32, align 4
  store i32 %bbnum, i32* %bbnum.addr, align 4
  %0 = load i32, i32* %bbnum.addr, align 4
  ret i32 %0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @cher_loop_runTime(i64 %start, i64 %end) #0 {
entry:
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  %0 = load i64, i64* %end.addr, align 8
  %conv = sitofp i64 %0 to double
  %1 = load i64, i64* %start.addr, align 8
  %conv1 = sitofp i64 %1 to double
  %sub = fsub double %conv, %conv1
  %div = fdiv double %sub, 1.000000e+06
  ret double %div
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58"}
