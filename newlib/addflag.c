//
// Created by KLzhang on 2023-04-29.
//
#include "stdio.h"
#include "time.h"
int  cher_flag = 0;
clock_t cher_start,cher_end;
int CALLBBNUM(int bbnum){
    return bbnum;
}
double cher_loop_runTime(clock_t start,clock_t end){///返回计算时间
    return ((double)end -start) /CLOCKS_PER_SEC;
}


