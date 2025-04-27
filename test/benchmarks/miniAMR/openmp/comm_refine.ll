; ModuleID = 'comm_refine.c'
source_filename = "comm_refine.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ompi_predefined_datatype_t = type opaque
%struct.ompi_predefined_communicator_t = type opaque
%struct.ompi_request_t = type opaque
%struct.block = type { i64, i32, i32, i32, i64, i32, i32, [6 x i32], [6 x i32], [6 x [2 x [2 x i32]]], [3 x i32], double**** }
%struct.parent = type { i64, i32, i64, i32, i32, i32, [8 x i64], [8 x i32], [3 x i32] }
%struct.ompi_status_public_t = type { i32, i32, i32, i32, i64 }
%struct.ompi_datatype_t = type opaque
%struct.ompi_communicator_t = type opaque

@send_buff = external dso_local global double*, align 8
@recv_buff = external dso_local global double*, align 8
@num_comm_partners = external dso_local global [3 x i32], align 4
@comm_index = external dso_local global [3 x i32*], align 16
@comm_num = external dso_local global [3 x i32*], align 16
@ompi_mpi_int = external dso_local global %struct.ompi_predefined_datatype_t, align 1
@comm_partner = external dso_local global [3 x i32*], align 16
@ompi_mpi_comm_world = external dso_local global %struct.ompi_predefined_communicator_t, align 1
@request = external dso_local global %struct.ompi_request_t**, align 8
@blocks = external dso_local global %struct.block*, align 8
@comm_block = external dso_local global [3 x i32*], align 16
@s_req = external dso_local global %struct.ompi_request_t**, align 8
@comm_face_case = external dso_local global [3 x i32*], align 16
@my_pe = external dso_local global i32, align 4
@parents = external dso_local global %struct.parent*, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @comm_refine() #0 !dbg !20 {
entry:
  %i = alloca i32, align 4
  %n = alloca i32, align 4
  %offset = alloca i32, align 4
  %dir = alloca i32, align 4
  %which = alloca i32, align 4
  %face = alloca i32, align 4
  %err = alloca i32, align 4
  %type = alloca i32, align 4
  %send_int = alloca i32*, align 8
  %recv_int = alloca i32*, align 8
  %bp = alloca %struct.block*, align 8
  %status = alloca %struct.ompi_status_public_t, align 8
  call void @llvm.dbg.declare(metadata i32* %i, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %n, metadata !25, metadata !DIExpression()), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %offset, metadata !27, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata i32* %dir, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata i32* %which, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata i32* %face, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata i32* %err, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.declare(metadata i32* %type, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata i32** %send_int, metadata !39, metadata !DIExpression()), !dbg !40
  %0 = load double*, double** @send_buff, align 8, !dbg !41
  %1 = bitcast double* %0 to i32*, !dbg !42
  store i32* %1, i32** %send_int, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata i32** %recv_int, metadata !43, metadata !DIExpression()), !dbg !44
  %2 = load double*, double** @recv_buff, align 8, !dbg !45
  %3 = bitcast double* %2 to i32*, !dbg !46
  store i32* %3, i32** %recv_int, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata %struct.block** %bp, metadata !47, metadata !DIExpression()), !dbg !81
  call void @llvm.dbg.declare(metadata %struct.ompi_status_public_t* %status, metadata !82, metadata !DIExpression()), !dbg !94
  store i32 0, i32* %dir, align 4, !dbg !95
  br label %for.cond, !dbg !97

for.cond:                                         ; preds = %for.inc163, %entry
  %4 = load i32, i32* %dir, align 4, !dbg !98
  %cmp = icmp slt i32 %4, 3, !dbg !100
  br i1 %cmp, label %for.body, label %for.end165, !dbg !101

for.body:                                         ; preds = %for.cond
  %5 = load i32, i32* %dir, align 4, !dbg !102
  %add = add nsw i32 10, %5, !dbg !104
  store i32 %add, i32* %type, align 4, !dbg !105
  store i32 0, i32* %i, align 4, !dbg !106
  br label %for.cond1, !dbg !108

for.cond1:                                        ; preds = %for.inc, %for.body
  %6 = load i32, i32* %i, align 4, !dbg !109
  %7 = load i32, i32* %dir, align 4, !dbg !111
  %idxprom = sext i32 %7 to i64, !dbg !112
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom, !dbg !112
  %8 = load i32, i32* %arrayidx, align 4, !dbg !112
  %cmp2 = icmp slt i32 %6, %8, !dbg !113
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !114

for.body3:                                        ; preds = %for.cond1
  %9 = load i32*, i32** %recv_int, align 8, !dbg !115
  %10 = load i32, i32* %dir, align 4, !dbg !116
  %idxprom4 = sext i32 %10 to i64, !dbg !117
  %arrayidx5 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom4, !dbg !117
  %11 = load i32*, i32** %arrayidx5, align 8, !dbg !117
  %12 = load i32, i32* %i, align 4, !dbg !118
  %idxprom6 = sext i32 %12 to i64, !dbg !117
  %arrayidx7 = getelementptr inbounds i32, i32* %11, i64 %idxprom6, !dbg !117
  %13 = load i32, i32* %arrayidx7, align 4, !dbg !117
  %idxprom8 = sext i32 %13 to i64, !dbg !115
  %arrayidx9 = getelementptr inbounds i32, i32* %9, i64 %idxprom8, !dbg !115
  %14 = bitcast i32* %arrayidx9 to i8*, !dbg !119
  %15 = load i32, i32* %dir, align 4, !dbg !120
  %idxprom10 = sext i32 %15 to i64, !dbg !121
  %arrayidx11 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_num, i64 0, i64 %idxprom10, !dbg !121
  %16 = load i32*, i32** %arrayidx11, align 8, !dbg !121
  %17 = load i32, i32* %i, align 4, !dbg !122
  %idxprom12 = sext i32 %17 to i64, !dbg !121
  %arrayidx13 = getelementptr inbounds i32, i32* %16, i64 %idxprom12, !dbg !121
  %18 = load i32, i32* %arrayidx13, align 4, !dbg !121
  %19 = load i32, i32* %dir, align 4, !dbg !123
  %idxprom14 = sext i32 %19 to i64, !dbg !124
  %arrayidx15 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_partner, i64 0, i64 %idxprom14, !dbg !124
  %20 = load i32*, i32** %arrayidx15, align 8, !dbg !124
  %21 = load i32, i32* %i, align 4, !dbg !125
  %idxprom16 = sext i32 %21 to i64, !dbg !124
  %arrayidx17 = getelementptr inbounds i32, i32* %20, i64 %idxprom16, !dbg !124
  %22 = load i32, i32* %arrayidx17, align 4, !dbg !124
  %23 = load i32, i32* %type, align 4, !dbg !126
  %24 = load %struct.ompi_request_t**, %struct.ompi_request_t*** @request, align 8, !dbg !127
  %25 = load i32, i32* %i, align 4, !dbg !128
  %idxprom18 = sext i32 %25 to i64, !dbg !127
  %arrayidx19 = getelementptr inbounds %struct.ompi_request_t*, %struct.ompi_request_t** %24, i64 %idxprom18, !dbg !127
  %call = call i32 @MPI_Irecv(i8* %14, i32 %18, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i32 %22, i32 %23, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), %struct.ompi_request_t** %arrayidx19), !dbg !129
  br label %for.inc, !dbg !129

for.inc:                                          ; preds = %for.body3
  %26 = load i32, i32* %i, align 4, !dbg !130
  %inc = add nsw i32 %26, 1, !dbg !130
  store i32 %inc, i32* %i, align 4, !dbg !130
  br label %for.cond1, !dbg !131, !llvm.loop !132

for.end:                                          ; preds = %for.cond1
  store i32 0, i32* %i, align 4, !dbg !135
  br label %for.cond20, !dbg !137

for.cond20:                                       ; preds = %for.inc70, %for.end
  %27 = load i32, i32* %i, align 4, !dbg !138
  %28 = load i32, i32* %dir, align 4, !dbg !140
  %idxprom21 = sext i32 %28 to i64, !dbg !141
  %arrayidx22 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom21, !dbg !141
  %29 = load i32, i32* %arrayidx22, align 4, !dbg !141
  %cmp23 = icmp slt i32 %27, %29, !dbg !142
  br i1 %cmp23, label %for.body24, label %for.end72, !dbg !143

for.body24:                                       ; preds = %for.cond20
  %30 = load i32, i32* %dir, align 4, !dbg !144
  %idxprom25 = sext i32 %30 to i64, !dbg !146
  %arrayidx26 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom25, !dbg !146
  %31 = load i32*, i32** %arrayidx26, align 8, !dbg !146
  %32 = load i32, i32* %i, align 4, !dbg !147
  %idxprom27 = sext i32 %32 to i64, !dbg !146
  %arrayidx28 = getelementptr inbounds i32, i32* %31, i64 %idxprom27, !dbg !146
  %33 = load i32, i32* %arrayidx28, align 4, !dbg !146
  store i32 %33, i32* %offset, align 4, !dbg !148
  store i32 0, i32* %n, align 4, !dbg !149
  br label %for.cond29, !dbg !151

for.cond29:                                       ; preds = %for.inc50, %for.body24
  %34 = load i32, i32* %n, align 4, !dbg !152
  %35 = load i32, i32* %dir, align 4, !dbg !154
  %idxprom30 = sext i32 %35 to i64, !dbg !155
  %arrayidx31 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_num, i64 0, i64 %idxprom30, !dbg !155
  %36 = load i32*, i32** %arrayidx31, align 8, !dbg !155
  %37 = load i32, i32* %i, align 4, !dbg !156
  %idxprom32 = sext i32 %37 to i64, !dbg !155
  %arrayidx33 = getelementptr inbounds i32, i32* %36, i64 %idxprom32, !dbg !155
  %38 = load i32, i32* %arrayidx33, align 4, !dbg !155
  %cmp34 = icmp slt i32 %34, %38, !dbg !157
  br i1 %cmp34, label %for.body35, label %for.end52, !dbg !158

for.body35:                                       ; preds = %for.cond29
  %39 = load %struct.block*, %struct.block** @blocks, align 8, !dbg !159
  %40 = load i32, i32* %dir, align 4, !dbg !160
  %idxprom36 = sext i32 %40 to i64, !dbg !161
  %arrayidx37 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_block, i64 0, i64 %idxprom36, !dbg !161
  %41 = load i32*, i32** %arrayidx37, align 8, !dbg !161
  %42 = load i32, i32* %dir, align 4, !dbg !162
  %idxprom38 = sext i32 %42 to i64, !dbg !163
  %arrayidx39 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom38, !dbg !163
  %43 = load i32*, i32** %arrayidx39, align 8, !dbg !163
  %44 = load i32, i32* %i, align 4, !dbg !164
  %idxprom40 = sext i32 %44 to i64, !dbg !163
  %arrayidx41 = getelementptr inbounds i32, i32* %43, i64 %idxprom40, !dbg !163
  %45 = load i32, i32* %arrayidx41, align 4, !dbg !163
  %46 = load i32, i32* %n, align 4, !dbg !165
  %add42 = add nsw i32 %45, %46, !dbg !166
  %idxprom43 = sext i32 %add42 to i64, !dbg !161
  %arrayidx44 = getelementptr inbounds i32, i32* %41, i64 %idxprom43, !dbg !161
  %47 = load i32, i32* %arrayidx44, align 4, !dbg !161
  %idxprom45 = sext i32 %47 to i64, !dbg !159
  %arrayidx46 = getelementptr inbounds %struct.block, %struct.block* %39, i64 %idxprom45, !dbg !159
  %refine = getelementptr inbounds %struct.block, %struct.block* %arrayidx46, i32 0, i32 2, !dbg !167
  %48 = load i32, i32* %refine, align 4, !dbg !167
  %49 = load i32*, i32** %send_int, align 8, !dbg !168
  %50 = load i32, i32* %offset, align 4, !dbg !169
  %51 = load i32, i32* %n, align 4, !dbg !170
  %add47 = add nsw i32 %50, %51, !dbg !171
  %idxprom48 = sext i32 %add47 to i64, !dbg !168
  %arrayidx49 = getelementptr inbounds i32, i32* %49, i64 %idxprom48, !dbg !168
  store i32 %48, i32* %arrayidx49, align 4, !dbg !172
  br label %for.inc50, !dbg !168

for.inc50:                                        ; preds = %for.body35
  %52 = load i32, i32* %n, align 4, !dbg !173
  %inc51 = add nsw i32 %52, 1, !dbg !173
  store i32 %inc51, i32* %n, align 4, !dbg !173
  br label %for.cond29, !dbg !174, !llvm.loop !175

for.end52:                                        ; preds = %for.cond29
  %53 = load i32*, i32** %send_int, align 8, !dbg !177
  %54 = load i32, i32* %dir, align 4, !dbg !178
  %idxprom53 = sext i32 %54 to i64, !dbg !179
  %arrayidx54 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom53, !dbg !179
  %55 = load i32*, i32** %arrayidx54, align 8, !dbg !179
  %56 = load i32, i32* %i, align 4, !dbg !180
  %idxprom55 = sext i32 %56 to i64, !dbg !179
  %arrayidx56 = getelementptr inbounds i32, i32* %55, i64 %idxprom55, !dbg !179
  %57 = load i32, i32* %arrayidx56, align 4, !dbg !179
  %idxprom57 = sext i32 %57 to i64, !dbg !177
  %arrayidx58 = getelementptr inbounds i32, i32* %53, i64 %idxprom57, !dbg !177
  %58 = bitcast i32* %arrayidx58 to i8*, !dbg !181
  %59 = load i32, i32* %dir, align 4, !dbg !182
  %idxprom59 = sext i32 %59 to i64, !dbg !183
  %arrayidx60 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_num, i64 0, i64 %idxprom59, !dbg !183
  %60 = load i32*, i32** %arrayidx60, align 8, !dbg !183
  %61 = load i32, i32* %i, align 4, !dbg !184
  %idxprom61 = sext i32 %61 to i64, !dbg !183
  %arrayidx62 = getelementptr inbounds i32, i32* %60, i64 %idxprom61, !dbg !183
  %62 = load i32, i32* %arrayidx62, align 4, !dbg !183
  %63 = load i32, i32* %dir, align 4, !dbg !185
  %idxprom63 = sext i32 %63 to i64, !dbg !186
  %arrayidx64 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_partner, i64 0, i64 %idxprom63, !dbg !186
  %64 = load i32*, i32** %arrayidx64, align 8, !dbg !186
  %65 = load i32, i32* %i, align 4, !dbg !187
  %idxprom65 = sext i32 %65 to i64, !dbg !186
  %arrayidx66 = getelementptr inbounds i32, i32* %64, i64 %idxprom65, !dbg !186
  %66 = load i32, i32* %arrayidx66, align 4, !dbg !186
  %67 = load i32, i32* %type, align 4, !dbg !188
  %68 = load %struct.ompi_request_t**, %struct.ompi_request_t*** @s_req, align 8, !dbg !189
  %69 = load i32, i32* %i, align 4, !dbg !190
  %idxprom67 = sext i32 %69 to i64, !dbg !189
  %arrayidx68 = getelementptr inbounds %struct.ompi_request_t*, %struct.ompi_request_t** %68, i64 %idxprom67, !dbg !189
  %call69 = call i32 @MPI_Isend(i8* %58, i32 %62, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i32 %66, i32 %67, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), %struct.ompi_request_t** %arrayidx68), !dbg !191
  br label %for.inc70, !dbg !192

for.inc70:                                        ; preds = %for.end52
  %70 = load i32, i32* %i, align 4, !dbg !193
  %inc71 = add nsw i32 %70, 1, !dbg !193
  store i32 %inc71, i32* %i, align 4, !dbg !193
  br label %for.cond20, !dbg !194, !llvm.loop !195

for.end72:                                        ; preds = %for.cond20
  store i32 0, i32* %i, align 4, !dbg !197
  br label %for.cond73, !dbg !199

for.cond73:                                       ; preds = %for.inc148, %for.end72
  %71 = load i32, i32* %i, align 4, !dbg !200
  %72 = load i32, i32* %dir, align 4, !dbg !202
  %idxprom74 = sext i32 %72 to i64, !dbg !203
  %arrayidx75 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom74, !dbg !203
  %73 = load i32, i32* %arrayidx75, align 4, !dbg !203
  %cmp76 = icmp slt i32 %71, %73, !dbg !204
  br i1 %cmp76, label %for.body77, label %for.end150, !dbg !205

for.body77:                                       ; preds = %for.cond73
  %74 = load i32, i32* %dir, align 4, !dbg !206
  %idxprom78 = sext i32 %74 to i64, !dbg !208
  %arrayidx79 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom78, !dbg !208
  %75 = load i32, i32* %arrayidx79, align 4, !dbg !208
  %76 = load %struct.ompi_request_t**, %struct.ompi_request_t*** @request, align 8, !dbg !209
  %call80 = call i32 @MPI_Waitany(i32 %75, %struct.ompi_request_t** %76, i32* %which, %struct.ompi_status_public_t* %status), !dbg !210
  store i32 %call80, i32* %err, align 4, !dbg !211
  store i32 0, i32* %n, align 4, !dbg !212
  br label %for.cond81, !dbg !214

for.cond81:                                       ; preds = %for.inc145, %for.body77
  %77 = load i32, i32* %n, align 4, !dbg !215
  %78 = load i32, i32* %dir, align 4, !dbg !217
  %idxprom82 = sext i32 %78 to i64, !dbg !218
  %arrayidx83 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_num, i64 0, i64 %idxprom82, !dbg !218
  %79 = load i32*, i32** %arrayidx83, align 8, !dbg !218
  %80 = load i32, i32* %which, align 4, !dbg !219
  %idxprom84 = sext i32 %80 to i64, !dbg !218
  %arrayidx85 = getelementptr inbounds i32, i32* %79, i64 %idxprom84, !dbg !218
  %81 = load i32, i32* %arrayidx85, align 4, !dbg !218
  %cmp86 = icmp slt i32 %77, %81, !dbg !220
  br i1 %cmp86, label %for.body87, label %for.end147, !dbg !221

for.body87:                                       ; preds = %for.cond81
  %82 = load i32, i32* %dir, align 4, !dbg !222
  %mul = mul nsw i32 %82, 2, !dbg !224
  %83 = load i32, i32* %dir, align 4, !dbg !225
  %idxprom88 = sext i32 %83 to i64, !dbg !226
  %arrayidx89 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_face_case, i64 0, i64 %idxprom88, !dbg !226
  %84 = load i32*, i32** %arrayidx89, align 8, !dbg !226
  %85 = load i32, i32* %dir, align 4, !dbg !227
  %idxprom90 = sext i32 %85 to i64, !dbg !228
  %arrayidx91 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom90, !dbg !228
  %86 = load i32*, i32** %arrayidx91, align 8, !dbg !228
  %87 = load i32, i32* %which, align 4, !dbg !229
  %idxprom92 = sext i32 %87 to i64, !dbg !228
  %arrayidx93 = getelementptr inbounds i32, i32* %86, i64 %idxprom92, !dbg !228
  %88 = load i32, i32* %arrayidx93, align 4, !dbg !228
  %89 = load i32, i32* %n, align 4, !dbg !230
  %add94 = add nsw i32 %88, %89, !dbg !231
  %idxprom95 = sext i32 %add94 to i64, !dbg !226
  %arrayidx96 = getelementptr inbounds i32, i32* %84, i64 %idxprom95, !dbg !226
  %90 = load i32, i32* %arrayidx96, align 4, !dbg !226
  %cmp97 = icmp sge i32 %90, 10, !dbg !232
  %conv = zext i1 %cmp97 to i32, !dbg !232
  %add98 = add nsw i32 %mul, %conv, !dbg !233
  store i32 %add98, i32* %face, align 4, !dbg !234
  %91 = load %struct.block*, %struct.block** @blocks, align 8, !dbg !235
  %92 = load i32, i32* %dir, align 4, !dbg !236
  %idxprom99 = sext i32 %92 to i64, !dbg !237
  %arrayidx100 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_block, i64 0, i64 %idxprom99, !dbg !237
  %93 = load i32*, i32** %arrayidx100, align 8, !dbg !237
  %94 = load i32, i32* %dir, align 4, !dbg !238
  %idxprom101 = sext i32 %94 to i64, !dbg !239
  %arrayidx102 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom101, !dbg !239
  %95 = load i32*, i32** %arrayidx102, align 8, !dbg !239
  %96 = load i32, i32* %which, align 4, !dbg !240
  %idxprom103 = sext i32 %96 to i64, !dbg !239
  %arrayidx104 = getelementptr inbounds i32, i32* %95, i64 %idxprom103, !dbg !239
  %97 = load i32, i32* %arrayidx104, align 4, !dbg !239
  %98 = load i32, i32* %n, align 4, !dbg !241
  %add105 = add nsw i32 %97, %98, !dbg !242
  %idxprom106 = sext i32 %add105 to i64, !dbg !237
  %arrayidx107 = getelementptr inbounds i32, i32* %93, i64 %idxprom106, !dbg !237
  %99 = load i32, i32* %arrayidx107, align 4, !dbg !237
  %idxprom108 = sext i32 %99 to i64, !dbg !235
  %arrayidx109 = getelementptr inbounds %struct.block, %struct.block* %91, i64 %idxprom108, !dbg !235
  store %struct.block* %arrayidx109, %struct.block** %bp, align 8, !dbg !243
  %100 = load i32*, i32** %recv_int, align 8, !dbg !244
  %101 = load i32, i32* %dir, align 4, !dbg !246
  %idxprom110 = sext i32 %101 to i64, !dbg !247
  %arrayidx111 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom110, !dbg !247
  %102 = load i32*, i32** %arrayidx111, align 8, !dbg !247
  %103 = load i32, i32* %which, align 4, !dbg !248
  %idxprom112 = sext i32 %103 to i64, !dbg !247
  %arrayidx113 = getelementptr inbounds i32, i32* %102, i64 %idxprom112, !dbg !247
  %104 = load i32, i32* %arrayidx113, align 4, !dbg !247
  %105 = load i32, i32* %n, align 4, !dbg !249
  %add114 = add nsw i32 %104, %105, !dbg !250
  %idxprom115 = sext i32 %add114 to i64, !dbg !244
  %arrayidx116 = getelementptr inbounds i32, i32* %100, i64 %idxprom115, !dbg !244
  %106 = load i32, i32* %arrayidx116, align 4, !dbg !244
  %cmp117 = icmp eq i32 %106, 1, !dbg !251
  br i1 %cmp117, label %land.lhs.true, label %if.else, !dbg !252

land.lhs.true:                                    ; preds = %for.body87
  %107 = load %struct.block*, %struct.block** %bp, align 8, !dbg !253
  %nei_level = getelementptr inbounds %struct.block, %struct.block* %107, i32 0, i32 8, !dbg !254
  %108 = load i32, i32* %face, align 4, !dbg !255
  %idxprom119 = sext i32 %108 to i64, !dbg !253
  %arrayidx120 = getelementptr inbounds [6 x i32], [6 x i32]* %nei_level, i64 0, i64 %idxprom119, !dbg !253
  %109 = load i32, i32* %arrayidx120, align 4, !dbg !253
  %110 = load %struct.block*, %struct.block** %bp, align 8, !dbg !256
  %level = getelementptr inbounds %struct.block, %struct.block* %110, i32 0, i32 1, !dbg !257
  %111 = load i32, i32* %level, align 8, !dbg !257
  %cmp121 = icmp sle i32 %109, %111, !dbg !258
  br i1 %cmp121, label %if.then, label %if.else, !dbg !259

if.then:                                          ; preds = %land.lhs.true
  %112 = load %struct.block*, %struct.block** %bp, align 8, !dbg !260
  %nei_refine = getelementptr inbounds %struct.block, %struct.block* %112, i32 0, i32 7, !dbg !261
  %113 = load i32, i32* %face, align 4, !dbg !262
  %idxprom123 = sext i32 %113 to i64, !dbg !260
  %arrayidx124 = getelementptr inbounds [6 x i32], [6 x i32]* %nei_refine, i64 0, i64 %idxprom123, !dbg !260
  store i32 1, i32* %arrayidx124, align 4, !dbg !263
  br label %if.end144, !dbg !260

if.else:                                          ; preds = %land.lhs.true, %for.body87
  %114 = load i32*, i32** %recv_int, align 8, !dbg !264
  %115 = load i32, i32* %dir, align 4, !dbg !266
  %idxprom125 = sext i32 %115 to i64, !dbg !267
  %arrayidx126 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom125, !dbg !267
  %116 = load i32*, i32** %arrayidx126, align 8, !dbg !267
  %117 = load i32, i32* %which, align 4, !dbg !268
  %idxprom127 = sext i32 %117 to i64, !dbg !267
  %arrayidx128 = getelementptr inbounds i32, i32* %116, i64 %idxprom127, !dbg !267
  %118 = load i32, i32* %arrayidx128, align 4, !dbg !267
  %119 = load i32, i32* %n, align 4, !dbg !269
  %add129 = add nsw i32 %118, %119, !dbg !270
  %idxprom130 = sext i32 %add129 to i64, !dbg !264
  %arrayidx131 = getelementptr inbounds i32, i32* %114, i64 %idxprom130, !dbg !264
  %120 = load i32, i32* %arrayidx131, align 4, !dbg !264
  %cmp132 = icmp sge i32 %120, 0, !dbg !271
  br i1 %cmp132, label %land.lhs.true134, label %if.end, !dbg !272

land.lhs.true134:                                 ; preds = %if.else
  %121 = load %struct.block*, %struct.block** %bp, align 8, !dbg !273
  %nei_refine135 = getelementptr inbounds %struct.block, %struct.block* %121, i32 0, i32 7, !dbg !274
  %122 = load i32, i32* %face, align 4, !dbg !275
  %idxprom136 = sext i32 %122 to i64, !dbg !273
  %arrayidx137 = getelementptr inbounds [6 x i32], [6 x i32]* %nei_refine135, i64 0, i64 %idxprom136, !dbg !273
  %123 = load i32, i32* %arrayidx137, align 4, !dbg !273
  %cmp138 = icmp eq i32 %123, -1, !dbg !276
  br i1 %cmp138, label %if.then140, label %if.end, !dbg !277

if.then140:                                       ; preds = %land.lhs.true134
  %124 = load %struct.block*, %struct.block** %bp, align 8, !dbg !278
  %nei_refine141 = getelementptr inbounds %struct.block, %struct.block* %124, i32 0, i32 7, !dbg !279
  %125 = load i32, i32* %face, align 4, !dbg !280
  %idxprom142 = sext i32 %125 to i64, !dbg !278
  %arrayidx143 = getelementptr inbounds [6 x i32], [6 x i32]* %nei_refine141, i64 0, i64 %idxprom142, !dbg !278
  store i32 0, i32* %arrayidx143, align 4, !dbg !281
  br label %if.end, !dbg !278

if.end:                                           ; preds = %if.then140, %land.lhs.true134, %if.else
  br label %if.end144

if.end144:                                        ; preds = %if.end, %if.then
  br label %for.inc145, !dbg !282

for.inc145:                                       ; preds = %if.end144
  %126 = load i32, i32* %n, align 4, !dbg !283
  %inc146 = add nsw i32 %126, 1, !dbg !283
  store i32 %inc146, i32* %n, align 4, !dbg !283
  br label %for.cond81, !dbg !284, !llvm.loop !285

for.end147:                                       ; preds = %for.cond81
  br label %for.inc148, !dbg !287

for.inc148:                                       ; preds = %for.end147
  %127 = load i32, i32* %i, align 4, !dbg !288
  %inc149 = add nsw i32 %127, 1, !dbg !288
  store i32 %inc149, i32* %i, align 4, !dbg !288
  br label %for.cond73, !dbg !289, !llvm.loop !290

for.end150:                                       ; preds = %for.cond73
  store i32 0, i32* %i, align 4, !dbg !292
  br label %for.cond151, !dbg !294

for.cond151:                                      ; preds = %for.inc160, %for.end150
  %128 = load i32, i32* %i, align 4, !dbg !295
  %129 = load i32, i32* %dir, align 4, !dbg !297
  %idxprom152 = sext i32 %129 to i64, !dbg !298
  %arrayidx153 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom152, !dbg !298
  %130 = load i32, i32* %arrayidx153, align 4, !dbg !298
  %cmp154 = icmp slt i32 %128, %130, !dbg !299
  br i1 %cmp154, label %for.body156, label %for.end162, !dbg !300

for.body156:                                      ; preds = %for.cond151
  %131 = load i32, i32* %dir, align 4, !dbg !301
  %idxprom157 = sext i32 %131 to i64, !dbg !302
  %arrayidx158 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom157, !dbg !302
  %132 = load i32, i32* %arrayidx158, align 4, !dbg !302
  %133 = load %struct.ompi_request_t**, %struct.ompi_request_t*** @s_req, align 8, !dbg !303
  %call159 = call i32 @MPI_Waitany(i32 %132, %struct.ompi_request_t** %133, i32* %which, %struct.ompi_status_public_t* %status), !dbg !304
  store i32 %call159, i32* %err, align 4, !dbg !305
  br label %for.inc160, !dbg !306

for.inc160:                                       ; preds = %for.body156
  %134 = load i32, i32* %i, align 4, !dbg !307
  %inc161 = add nsw i32 %134, 1, !dbg !307
  store i32 %inc161, i32* %i, align 4, !dbg !307
  br label %for.cond151, !dbg !308, !llvm.loop !309

for.end162:                                       ; preds = %for.cond151
  br label %for.inc163, !dbg !311

for.inc163:                                       ; preds = %for.end162
  %135 = load i32, i32* %dir, align 4, !dbg !312
  %inc164 = add nsw i32 %135, 1, !dbg !312
  store i32 %inc164, i32* %dir, align 4, !dbg !312
  br label %for.cond, !dbg !313, !llvm.loop !314

for.end165:                                       ; preds = %for.cond
  ret void, !dbg !316
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @MPI_Irecv(i8*, i32, %struct.ompi_datatype_t*, i32, i32, %struct.ompi_communicator_t*, %struct.ompi_request_t**) #2

declare dso_local i32 @MPI_Isend(i8*, i32, %struct.ompi_datatype_t*, i32, i32, %struct.ompi_communicator_t*, %struct.ompi_request_t**) #2

declare dso_local i32 @MPI_Waitany(i32, %struct.ompi_request_t**, i32*, %struct.ompi_status_public_t*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @comm_reverse_refine() #0 !dbg !317 {
entry:
  %i = alloca i32, align 4
  %n = alloca i32, align 4
  %c = alloca i32, align 4
  %offset = alloca i32, align 4
  %dir = alloca i32, align 4
  %which = alloca i32, align 4
  %face = alloca i32, align 4
  %err = alloca i32, align 4
  %type = alloca i32, align 4
  %send_int = alloca i32*, align 8
  %recv_int = alloca i32*, align 8
  %bp = alloca %struct.block*, align 8
  %status = alloca %struct.ompi_status_public_t, align 8
  call void @llvm.dbg.declare(metadata i32* %i, metadata !318, metadata !DIExpression()), !dbg !319
  call void @llvm.dbg.declare(metadata i32* %n, metadata !320, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.declare(metadata i32* %c, metadata !322, metadata !DIExpression()), !dbg !323
  call void @llvm.dbg.declare(metadata i32* %offset, metadata !324, metadata !DIExpression()), !dbg !325
  call void @llvm.dbg.declare(metadata i32* %dir, metadata !326, metadata !DIExpression()), !dbg !327
  call void @llvm.dbg.declare(metadata i32* %which, metadata !328, metadata !DIExpression()), !dbg !329
  call void @llvm.dbg.declare(metadata i32* %face, metadata !330, metadata !DIExpression()), !dbg !331
  call void @llvm.dbg.declare(metadata i32* %err, metadata !332, metadata !DIExpression()), !dbg !333
  call void @llvm.dbg.declare(metadata i32* %type, metadata !334, metadata !DIExpression()), !dbg !335
  call void @llvm.dbg.declare(metadata i32** %send_int, metadata !336, metadata !DIExpression()), !dbg !337
  %0 = load double*, double** @send_buff, align 8, !dbg !338
  %1 = bitcast double* %0 to i32*, !dbg !339
  store i32* %1, i32** %send_int, align 8, !dbg !337
  call void @llvm.dbg.declare(metadata i32** %recv_int, metadata !340, metadata !DIExpression()), !dbg !341
  %2 = load double*, double** @recv_buff, align 8, !dbg !342
  %3 = bitcast double* %2 to i32*, !dbg !343
  store i32* %3, i32** %recv_int, align 8, !dbg !341
  call void @llvm.dbg.declare(metadata %struct.block** %bp, metadata !344, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.declare(metadata %struct.ompi_status_public_t* %status, metadata !346, metadata !DIExpression()), !dbg !347
  store i32 0, i32* %dir, align 4, !dbg !348
  br label %for.cond, !dbg !350

for.cond:                                         ; preds = %for.inc215, %entry
  %4 = load i32, i32* %dir, align 4, !dbg !351
  %cmp = icmp slt i32 %4, 3, !dbg !353
  br i1 %cmp, label %for.body, label %for.end217, !dbg !354

for.body:                                         ; preds = %for.cond
  %5 = load i32, i32* %dir, align 4, !dbg !355
  %add = add nsw i32 13, %5, !dbg !357
  store i32 %add, i32* %type, align 4, !dbg !358
  store i32 0, i32* %i, align 4, !dbg !359
  br label %for.cond1, !dbg !361

for.cond1:                                        ; preds = %for.inc, %for.body
  %6 = load i32, i32* %i, align 4, !dbg !362
  %7 = load i32, i32* %dir, align 4, !dbg !364
  %idxprom = sext i32 %7 to i64, !dbg !365
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom, !dbg !365
  %8 = load i32, i32* %arrayidx, align 4, !dbg !365
  %cmp2 = icmp slt i32 %6, %8, !dbg !366
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !367

for.body3:                                        ; preds = %for.cond1
  %9 = load i32*, i32** %recv_int, align 8, !dbg !368
  %10 = load i32, i32* %dir, align 4, !dbg !369
  %idxprom4 = sext i32 %10 to i64, !dbg !370
  %arrayidx5 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom4, !dbg !370
  %11 = load i32*, i32** %arrayidx5, align 8, !dbg !370
  %12 = load i32, i32* %i, align 4, !dbg !371
  %idxprom6 = sext i32 %12 to i64, !dbg !370
  %arrayidx7 = getelementptr inbounds i32, i32* %11, i64 %idxprom6, !dbg !370
  %13 = load i32, i32* %arrayidx7, align 4, !dbg !370
  %idxprom8 = sext i32 %13 to i64, !dbg !368
  %arrayidx9 = getelementptr inbounds i32, i32* %9, i64 %idxprom8, !dbg !368
  %14 = bitcast i32* %arrayidx9 to i8*, !dbg !372
  %15 = load i32, i32* %dir, align 4, !dbg !373
  %idxprom10 = sext i32 %15 to i64, !dbg !374
  %arrayidx11 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_num, i64 0, i64 %idxprom10, !dbg !374
  %16 = load i32*, i32** %arrayidx11, align 8, !dbg !374
  %17 = load i32, i32* %i, align 4, !dbg !375
  %idxprom12 = sext i32 %17 to i64, !dbg !374
  %arrayidx13 = getelementptr inbounds i32, i32* %16, i64 %idxprom12, !dbg !374
  %18 = load i32, i32* %arrayidx13, align 4, !dbg !374
  %19 = load i32, i32* %dir, align 4, !dbg !376
  %idxprom14 = sext i32 %19 to i64, !dbg !377
  %arrayidx15 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_partner, i64 0, i64 %idxprom14, !dbg !377
  %20 = load i32*, i32** %arrayidx15, align 8, !dbg !377
  %21 = load i32, i32* %i, align 4, !dbg !378
  %idxprom16 = sext i32 %21 to i64, !dbg !377
  %arrayidx17 = getelementptr inbounds i32, i32* %20, i64 %idxprom16, !dbg !377
  %22 = load i32, i32* %arrayidx17, align 4, !dbg !377
  %23 = load i32, i32* %type, align 4, !dbg !379
  %24 = load %struct.ompi_request_t**, %struct.ompi_request_t*** @request, align 8, !dbg !380
  %25 = load i32, i32* %i, align 4, !dbg !381
  %idxprom18 = sext i32 %25 to i64, !dbg !380
  %arrayidx19 = getelementptr inbounds %struct.ompi_request_t*, %struct.ompi_request_t** %24, i64 %idxprom18, !dbg !380
  %call = call i32 @MPI_Irecv(i8* %14, i32 %18, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i32 %22, i32 %23, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), %struct.ompi_request_t** %arrayidx19), !dbg !382
  br label %for.inc, !dbg !382

for.inc:                                          ; preds = %for.body3
  %26 = load i32, i32* %i, align 4, !dbg !383
  %inc = add nsw i32 %26, 1, !dbg !383
  store i32 %inc, i32* %i, align 4, !dbg !383
  br label %for.cond1, !dbg !384, !llvm.loop !385

for.end:                                          ; preds = %for.cond1
  store i32 0, i32* %i, align 4, !dbg !387
  br label %for.cond20, !dbg !389

for.cond20:                                       ; preds = %for.inc83, %for.end
  %27 = load i32, i32* %i, align 4, !dbg !390
  %28 = load i32, i32* %dir, align 4, !dbg !392
  %idxprom21 = sext i32 %28 to i64, !dbg !393
  %arrayidx22 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom21, !dbg !393
  %29 = load i32, i32* %arrayidx22, align 4, !dbg !393
  %cmp23 = icmp slt i32 %27, %29, !dbg !394
  br i1 %cmp23, label %for.body24, label %for.end85, !dbg !395

for.body24:                                       ; preds = %for.cond20
  %30 = load i32, i32* %dir, align 4, !dbg !396
  %idxprom25 = sext i32 %30 to i64, !dbg !398
  %arrayidx26 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom25, !dbg !398
  %31 = load i32*, i32** %arrayidx26, align 8, !dbg !398
  %32 = load i32, i32* %i, align 4, !dbg !399
  %idxprom27 = sext i32 %32 to i64, !dbg !398
  %arrayidx28 = getelementptr inbounds i32, i32* %31, i64 %idxprom27, !dbg !398
  %33 = load i32, i32* %arrayidx28, align 4, !dbg !398
  store i32 %33, i32* %offset, align 4, !dbg !400
  store i32 0, i32* %n, align 4, !dbg !401
  br label %for.cond29, !dbg !403

for.cond29:                                       ; preds = %for.inc63, %for.body24
  %34 = load i32, i32* %n, align 4, !dbg !404
  %35 = load i32, i32* %dir, align 4, !dbg !406
  %idxprom30 = sext i32 %35 to i64, !dbg !407
  %arrayidx31 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_num, i64 0, i64 %idxprom30, !dbg !407
  %36 = load i32*, i32** %arrayidx31, align 8, !dbg !407
  %37 = load i32, i32* %i, align 4, !dbg !408
  %idxprom32 = sext i32 %37 to i64, !dbg !407
  %arrayidx33 = getelementptr inbounds i32, i32* %36, i64 %idxprom32, !dbg !407
  %38 = load i32, i32* %arrayidx33, align 4, !dbg !407
  %cmp34 = icmp slt i32 %34, %38, !dbg !409
  br i1 %cmp34, label %for.body35, label %for.end65, !dbg !410

for.body35:                                       ; preds = %for.cond29
  %39 = load i32, i32* %dir, align 4, !dbg !411
  %mul = mul nsw i32 %39, 2, !dbg !413
  %40 = load i32, i32* %dir, align 4, !dbg !414
  %idxprom36 = sext i32 %40 to i64, !dbg !415
  %arrayidx37 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_face_case, i64 0, i64 %idxprom36, !dbg !415
  %41 = load i32*, i32** %arrayidx37, align 8, !dbg !415
  %42 = load i32, i32* %dir, align 4, !dbg !416
  %idxprom38 = sext i32 %42 to i64, !dbg !417
  %arrayidx39 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom38, !dbg !417
  %43 = load i32*, i32** %arrayidx39, align 8, !dbg !417
  %44 = load i32, i32* %i, align 4, !dbg !418
  %idxprom40 = sext i32 %44 to i64, !dbg !417
  %arrayidx41 = getelementptr inbounds i32, i32* %43, i64 %idxprom40, !dbg !417
  %45 = load i32, i32* %arrayidx41, align 4, !dbg !417
  %46 = load i32, i32* %n, align 4, !dbg !419
  %add42 = add nsw i32 %45, %46, !dbg !420
  %idxprom43 = sext i32 %add42 to i64, !dbg !415
  %arrayidx44 = getelementptr inbounds i32, i32* %41, i64 %idxprom43, !dbg !415
  %47 = load i32, i32* %arrayidx44, align 4, !dbg !415
  %cmp45 = icmp sge i32 %47, 10, !dbg !421
  %conv = zext i1 %cmp45 to i32, !dbg !421
  %add46 = add nsw i32 %mul, %conv, !dbg !422
  store i32 %add46, i32* %face, align 4, !dbg !423
  %48 = load %struct.block*, %struct.block** @blocks, align 8, !dbg !424
  %49 = load i32, i32* %dir, align 4, !dbg !425
  %idxprom47 = sext i32 %49 to i64, !dbg !426
  %arrayidx48 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_block, i64 0, i64 %idxprom47, !dbg !426
  %50 = load i32*, i32** %arrayidx48, align 8, !dbg !426
  %51 = load i32, i32* %dir, align 4, !dbg !427
  %idxprom49 = sext i32 %51 to i64, !dbg !428
  %arrayidx50 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom49, !dbg !428
  %52 = load i32*, i32** %arrayidx50, align 8, !dbg !428
  %53 = load i32, i32* %i, align 4, !dbg !429
  %idxprom51 = sext i32 %53 to i64, !dbg !428
  %arrayidx52 = getelementptr inbounds i32, i32* %52, i64 %idxprom51, !dbg !428
  %54 = load i32, i32* %arrayidx52, align 4, !dbg !428
  %55 = load i32, i32* %n, align 4, !dbg !430
  %add53 = add nsw i32 %54, %55, !dbg !431
  %idxprom54 = sext i32 %add53 to i64, !dbg !426
  %arrayidx55 = getelementptr inbounds i32, i32* %50, i64 %idxprom54, !dbg !426
  %56 = load i32, i32* %arrayidx55, align 4, !dbg !426
  %idxprom56 = sext i32 %56 to i64, !dbg !424
  %arrayidx57 = getelementptr inbounds %struct.block, %struct.block* %48, i64 %idxprom56, !dbg !424
  %nei_refine = getelementptr inbounds %struct.block, %struct.block* %arrayidx57, i32 0, i32 7, !dbg !432
  %57 = load i32, i32* %face, align 4, !dbg !433
  %idxprom58 = sext i32 %57 to i64, !dbg !424
  %arrayidx59 = getelementptr inbounds [6 x i32], [6 x i32]* %nei_refine, i64 0, i64 %idxprom58, !dbg !424
  %58 = load i32, i32* %arrayidx59, align 4, !dbg !424
  %59 = load i32*, i32** %send_int, align 8, !dbg !434
  %60 = load i32, i32* %offset, align 4, !dbg !435
  %61 = load i32, i32* %n, align 4, !dbg !436
  %add60 = add nsw i32 %60, %61, !dbg !437
  %idxprom61 = sext i32 %add60 to i64, !dbg !434
  %arrayidx62 = getelementptr inbounds i32, i32* %59, i64 %idxprom61, !dbg !434
  store i32 %58, i32* %arrayidx62, align 4, !dbg !438
  br label %for.inc63, !dbg !439

for.inc63:                                        ; preds = %for.body35
  %62 = load i32, i32* %n, align 4, !dbg !440
  %inc64 = add nsw i32 %62, 1, !dbg !440
  store i32 %inc64, i32* %n, align 4, !dbg !440
  br label %for.cond29, !dbg !441, !llvm.loop !442

for.end65:                                        ; preds = %for.cond29
  %63 = load i32*, i32** %send_int, align 8, !dbg !444
  %64 = load i32, i32* %dir, align 4, !dbg !445
  %idxprom66 = sext i32 %64 to i64, !dbg !446
  %arrayidx67 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom66, !dbg !446
  %65 = load i32*, i32** %arrayidx67, align 8, !dbg !446
  %66 = load i32, i32* %i, align 4, !dbg !447
  %idxprom68 = sext i32 %66 to i64, !dbg !446
  %arrayidx69 = getelementptr inbounds i32, i32* %65, i64 %idxprom68, !dbg !446
  %67 = load i32, i32* %arrayidx69, align 4, !dbg !446
  %idxprom70 = sext i32 %67 to i64, !dbg !444
  %arrayidx71 = getelementptr inbounds i32, i32* %63, i64 %idxprom70, !dbg !444
  %68 = bitcast i32* %arrayidx71 to i8*, !dbg !448
  %69 = load i32, i32* %dir, align 4, !dbg !449
  %idxprom72 = sext i32 %69 to i64, !dbg !450
  %arrayidx73 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_num, i64 0, i64 %idxprom72, !dbg !450
  %70 = load i32*, i32** %arrayidx73, align 8, !dbg !450
  %71 = load i32, i32* %i, align 4, !dbg !451
  %idxprom74 = sext i32 %71 to i64, !dbg !450
  %arrayidx75 = getelementptr inbounds i32, i32* %70, i64 %idxprom74, !dbg !450
  %72 = load i32, i32* %arrayidx75, align 4, !dbg !450
  %73 = load i32, i32* %dir, align 4, !dbg !452
  %idxprom76 = sext i32 %73 to i64, !dbg !453
  %arrayidx77 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_partner, i64 0, i64 %idxprom76, !dbg !453
  %74 = load i32*, i32** %arrayidx77, align 8, !dbg !453
  %75 = load i32, i32* %i, align 4, !dbg !454
  %idxprom78 = sext i32 %75 to i64, !dbg !453
  %arrayidx79 = getelementptr inbounds i32, i32* %74, i64 %idxprom78, !dbg !453
  %76 = load i32, i32* %arrayidx79, align 4, !dbg !453
  %77 = load i32, i32* %type, align 4, !dbg !455
  %78 = load %struct.ompi_request_t**, %struct.ompi_request_t*** @s_req, align 8, !dbg !456
  %79 = load i32, i32* %i, align 4, !dbg !457
  %idxprom80 = sext i32 %79 to i64, !dbg !456
  %arrayidx81 = getelementptr inbounds %struct.ompi_request_t*, %struct.ompi_request_t** %78, i64 %idxprom80, !dbg !456
  %call82 = call i32 @MPI_Isend(i8* %68, i32 %72, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i32 %76, i32 %77, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), %struct.ompi_request_t** %arrayidx81), !dbg !458
  br label %for.inc83, !dbg !459

for.inc83:                                        ; preds = %for.end65
  %80 = load i32, i32* %i, align 4, !dbg !460
  %inc84 = add nsw i32 %80, 1, !dbg !460
  store i32 %inc84, i32* %i, align 4, !dbg !460
  br label %for.cond20, !dbg !461, !llvm.loop !462

for.end85:                                        ; preds = %for.cond20
  store i32 0, i32* %i, align 4, !dbg !464
  br label %for.cond86, !dbg !466

for.cond86:                                       ; preds = %for.inc200, %for.end85
  %81 = load i32, i32* %i, align 4, !dbg !467
  %82 = load i32, i32* %dir, align 4, !dbg !469
  %idxprom87 = sext i32 %82 to i64, !dbg !470
  %arrayidx88 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom87, !dbg !470
  %83 = load i32, i32* %arrayidx88, align 4, !dbg !470
  %cmp89 = icmp slt i32 %81, %83, !dbg !471
  br i1 %cmp89, label %for.body91, label %for.end202, !dbg !472

for.body91:                                       ; preds = %for.cond86
  %84 = load i32, i32* %dir, align 4, !dbg !473
  %idxprom92 = sext i32 %84 to i64, !dbg !475
  %arrayidx93 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom92, !dbg !475
  %85 = load i32, i32* %arrayidx93, align 4, !dbg !475
  %86 = load %struct.ompi_request_t**, %struct.ompi_request_t*** @request, align 8, !dbg !476
  %call94 = call i32 @MPI_Waitany(i32 %85, %struct.ompi_request_t** %86, i32* %which, %struct.ompi_status_public_t* %status), !dbg !477
  store i32 0, i32* %n, align 4, !dbg !478
  br label %for.cond95, !dbg !480

for.cond95:                                       ; preds = %for.inc197, %for.body91
  %87 = load i32, i32* %n, align 4, !dbg !481
  %88 = load i32, i32* %dir, align 4, !dbg !483
  %idxprom96 = sext i32 %88 to i64, !dbg !484
  %arrayidx97 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_num, i64 0, i64 %idxprom96, !dbg !484
  %89 = load i32*, i32** %arrayidx97, align 8, !dbg !484
  %90 = load i32, i32* %which, align 4, !dbg !485
  %idxprom98 = sext i32 %90 to i64, !dbg !484
  %arrayidx99 = getelementptr inbounds i32, i32* %89, i64 %idxprom98, !dbg !484
  %91 = load i32, i32* %arrayidx99, align 4, !dbg !484
  %cmp100 = icmp slt i32 %87, %91, !dbg !486
  br i1 %cmp100, label %for.body102, label %for.end199, !dbg !487

for.body102:                                      ; preds = %for.cond95
  %92 = load i32*, i32** %recv_int, align 8, !dbg !488
  %93 = load i32, i32* %dir, align 4, !dbg !490
  %idxprom103 = sext i32 %93 to i64, !dbg !491
  %arrayidx104 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom103, !dbg !491
  %94 = load i32*, i32** %arrayidx104, align 8, !dbg !491
  %95 = load i32, i32* %which, align 4, !dbg !492
  %idxprom105 = sext i32 %95 to i64, !dbg !491
  %arrayidx106 = getelementptr inbounds i32, i32* %94, i64 %idxprom105, !dbg !491
  %96 = load i32, i32* %arrayidx106, align 4, !dbg !491
  %97 = load i32, i32* %n, align 4, !dbg !493
  %add107 = add nsw i32 %96, %97, !dbg !494
  %idxprom108 = sext i32 %add107 to i64, !dbg !488
  %arrayidx109 = getelementptr inbounds i32, i32* %92, i64 %idxprom108, !dbg !488
  %98 = load i32, i32* %arrayidx109, align 4, !dbg !488
  %99 = load %struct.block*, %struct.block** @blocks, align 8, !dbg !495
  %100 = load i32, i32* %dir, align 4, !dbg !496
  %idxprom110 = sext i32 %100 to i64, !dbg !497
  %arrayidx111 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_block, i64 0, i64 %idxprom110, !dbg !497
  %101 = load i32*, i32** %arrayidx111, align 8, !dbg !497
  %102 = load i32, i32* %dir, align 4, !dbg !498
  %idxprom112 = sext i32 %102 to i64, !dbg !499
  %arrayidx113 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom112, !dbg !499
  %103 = load i32*, i32** %arrayidx113, align 8, !dbg !499
  %104 = load i32, i32* %which, align 4, !dbg !500
  %idxprom114 = sext i32 %104 to i64, !dbg !499
  %arrayidx115 = getelementptr inbounds i32, i32* %103, i64 %idxprom114, !dbg !499
  %105 = load i32, i32* %arrayidx115, align 4, !dbg !499
  %106 = load i32, i32* %n, align 4, !dbg !501
  %add116 = add nsw i32 %105, %106, !dbg !502
  %idxprom117 = sext i32 %add116 to i64, !dbg !497
  %arrayidx118 = getelementptr inbounds i32, i32* %101, i64 %idxprom117, !dbg !497
  %107 = load i32, i32* %arrayidx118, align 4, !dbg !497
  %idxprom119 = sext i32 %107 to i64, !dbg !495
  %arrayidx120 = getelementptr inbounds %struct.block, %struct.block* %99, i64 %idxprom119, !dbg !495
  %refine = getelementptr inbounds %struct.block, %struct.block* %arrayidx120, i32 0, i32 2, !dbg !503
  %108 = load i32, i32* %refine, align 4, !dbg !503
  %cmp121 = icmp sgt i32 %98, %108, !dbg !504
  br i1 %cmp121, label %if.then, label %if.end196, !dbg !505

if.then:                                          ; preds = %for.body102
  %109 = load %struct.block*, %struct.block** @blocks, align 8, !dbg !506
  %110 = load i32, i32* %dir, align 4, !dbg !508
  %idxprom123 = sext i32 %110 to i64, !dbg !509
  %arrayidx124 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_block, i64 0, i64 %idxprom123, !dbg !509
  %111 = load i32*, i32** %arrayidx124, align 8, !dbg !509
  %112 = load i32, i32* %dir, align 4, !dbg !510
  %idxprom125 = sext i32 %112 to i64, !dbg !511
  %arrayidx126 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom125, !dbg !511
  %113 = load i32*, i32** %arrayidx126, align 8, !dbg !511
  %114 = load i32, i32* %which, align 4, !dbg !512
  %idxprom127 = sext i32 %114 to i64, !dbg !511
  %arrayidx128 = getelementptr inbounds i32, i32* %113, i64 %idxprom127, !dbg !511
  %115 = load i32, i32* %arrayidx128, align 4, !dbg !511
  %116 = load i32, i32* %n, align 4, !dbg !513
  %add129 = add nsw i32 %115, %116, !dbg !514
  %idxprom130 = sext i32 %add129 to i64, !dbg !509
  %arrayidx131 = getelementptr inbounds i32, i32* %111, i64 %idxprom130, !dbg !509
  %117 = load i32, i32* %arrayidx131, align 4, !dbg !509
  %idxprom132 = sext i32 %117 to i64, !dbg !506
  %arrayidx133 = getelementptr inbounds %struct.block, %struct.block* %109, i64 %idxprom132, !dbg !506
  store %struct.block* %arrayidx133, %struct.block** %bp, align 8, !dbg !515
  %118 = load i32*, i32** %recv_int, align 8, !dbg !516
  %119 = load i32, i32* %dir, align 4, !dbg !517
  %idxprom134 = sext i32 %119 to i64, !dbg !518
  %arrayidx135 = getelementptr inbounds [3 x i32*], [3 x i32*]* @comm_index, i64 0, i64 %idxprom134, !dbg !518
  %120 = load i32*, i32** %arrayidx135, align 8, !dbg !518
  %121 = load i32, i32* %which, align 4, !dbg !519
  %idxprom136 = sext i32 %121 to i64, !dbg !518
  %arrayidx137 = getelementptr inbounds i32, i32* %120, i64 %idxprom136, !dbg !518
  %122 = load i32, i32* %arrayidx137, align 4, !dbg !518
  %123 = load i32, i32* %n, align 4, !dbg !520
  %add138 = add nsw i32 %122, %123, !dbg !521
  %idxprom139 = sext i32 %add138 to i64, !dbg !516
  %arrayidx140 = getelementptr inbounds i32, i32* %118, i64 %idxprom139, !dbg !516
  %124 = load i32, i32* %arrayidx140, align 4, !dbg !516
  %125 = load %struct.block*, %struct.block** %bp, align 8, !dbg !522
  %refine141 = getelementptr inbounds %struct.block, %struct.block* %125, i32 0, i32 2, !dbg !523
  store i32 %124, i32* %refine141, align 4, !dbg !524
  %126 = load %struct.block*, %struct.block** %bp, align 8, !dbg !525
  %parent = getelementptr inbounds %struct.block, %struct.block* %126, i32 0, i32 4, !dbg !527
  %127 = load i64, i64* %parent, align 8, !dbg !527
  %cmp142 = icmp ne i64 %127, -1, !dbg !528
  br i1 %cmp142, label %land.lhs.true, label %if.end195, !dbg !529

land.lhs.true:                                    ; preds = %if.then
  %128 = load %struct.block*, %struct.block** %bp, align 8, !dbg !530
  %parent_node = getelementptr inbounds %struct.block, %struct.block* %128, i32 0, i32 5, !dbg !531
  %129 = load i32, i32* %parent_node, align 8, !dbg !531
  %130 = load i32, i32* @my_pe, align 4, !dbg !532
  %cmp144 = icmp eq i32 %129, %130, !dbg !533
  br i1 %cmp144, label %if.then146, label %if.end195, !dbg !534

if.then146:                                       ; preds = %land.lhs.true
  %131 = load %struct.parent*, %struct.parent** @parents, align 8, !dbg !535
  %132 = load %struct.block*, %struct.block** %bp, align 8, !dbg !537
  %parent147 = getelementptr inbounds %struct.block, %struct.block* %132, i32 0, i32 4, !dbg !538
  %133 = load i64, i64* %parent147, align 8, !dbg !538
  %arrayidx148 = getelementptr inbounds %struct.parent, %struct.parent* %131, i64 %133, !dbg !535
  %refine149 = getelementptr inbounds %struct.parent, %struct.parent* %arrayidx148, i32 0, i32 5, !dbg !539
  %134 = load i32, i32* %refine149, align 8, !dbg !539
  %cmp150 = icmp eq i32 %134, -1, !dbg !540
  br i1 %cmp150, label %if.then152, label %if.end194, !dbg !541

if.then152:                                       ; preds = %if.then146
  %135 = load %struct.parent*, %struct.parent** @parents, align 8, !dbg !542
  %136 = load %struct.block*, %struct.block** %bp, align 8, !dbg !544
  %parent153 = getelementptr inbounds %struct.block, %struct.block* %136, i32 0, i32 4, !dbg !545
  %137 = load i64, i64* %parent153, align 8, !dbg !545
  %arrayidx154 = getelementptr inbounds %struct.parent, %struct.parent* %135, i64 %137, !dbg !542
  %refine155 = getelementptr inbounds %struct.parent, %struct.parent* %arrayidx154, i32 0, i32 5, !dbg !546
  store i32 0, i32* %refine155, align 8, !dbg !547
  store i32 0, i32* %c, align 4, !dbg !548
  br label %for.cond156, !dbg !550

for.cond156:                                      ; preds = %for.inc191, %if.then152
  %138 = load i32, i32* %c, align 4, !dbg !551
  %cmp157 = icmp slt i32 %138, 8, !dbg !553
  br i1 %cmp157, label %for.body159, label %for.end193, !dbg !554

for.body159:                                      ; preds = %for.cond156
  %139 = load %struct.parent*, %struct.parent** @parents, align 8, !dbg !555
  %140 = load %struct.block*, %struct.block** %bp, align 8, !dbg !557
  %parent160 = getelementptr inbounds %struct.block, %struct.block* %140, i32 0, i32 4, !dbg !558
  %141 = load i64, i64* %parent160, align 8, !dbg !558
  %arrayidx161 = getelementptr inbounds %struct.parent, %struct.parent* %139, i64 %141, !dbg !555
  %child_node = getelementptr inbounds %struct.parent, %struct.parent* %arrayidx161, i32 0, i32 7, !dbg !559
  %142 = load i32, i32* %c, align 4, !dbg !560
  %idxprom162 = sext i32 %142 to i64, !dbg !555
  %arrayidx163 = getelementptr inbounds [8 x i32], [8 x i32]* %child_node, i64 0, i64 %idxprom162, !dbg !555
  %143 = load i32, i32* %arrayidx163, align 4, !dbg !555
  %144 = load i32, i32* @my_pe, align 4, !dbg !561
  %cmp164 = icmp eq i32 %143, %144, !dbg !562
  br i1 %cmp164, label %land.lhs.true166, label %if.end, !dbg !563

land.lhs.true166:                                 ; preds = %for.body159
  %145 = load %struct.parent*, %struct.parent** @parents, align 8, !dbg !564
  %146 = load %struct.block*, %struct.block** %bp, align 8, !dbg !565
  %parent167 = getelementptr inbounds %struct.block, %struct.block* %146, i32 0, i32 4, !dbg !566
  %147 = load i64, i64* %parent167, align 8, !dbg !566
  %arrayidx168 = getelementptr inbounds %struct.parent, %struct.parent* %145, i64 %147, !dbg !564
  %child = getelementptr inbounds %struct.parent, %struct.parent* %arrayidx168, i32 0, i32 6, !dbg !567
  %148 = load i32, i32* %c, align 4, !dbg !568
  %idxprom169 = sext i32 %148 to i64, !dbg !564
  %arrayidx170 = getelementptr inbounds [8 x i64], [8 x i64]* %child, i64 0, i64 %idxprom169, !dbg !564
  %149 = load i64, i64* %arrayidx170, align 8, !dbg !564
  %cmp171 = icmp sge i64 %149, 0, !dbg !569
  br i1 %cmp171, label %land.lhs.true173, label %if.end, !dbg !570

land.lhs.true173:                                 ; preds = %land.lhs.true166
  %150 = load %struct.block*, %struct.block** @blocks, align 8, !dbg !571
  %151 = load %struct.parent*, %struct.parent** @parents, align 8, !dbg !572
  %152 = load %struct.block*, %struct.block** %bp, align 8, !dbg !573
  %parent174 = getelementptr inbounds %struct.block, %struct.block* %152, i32 0, i32 4, !dbg !574
  %153 = load i64, i64* %parent174, align 8, !dbg !574
  %arrayidx175 = getelementptr inbounds %struct.parent, %struct.parent* %151, i64 %153, !dbg !572
  %child176 = getelementptr inbounds %struct.parent, %struct.parent* %arrayidx175, i32 0, i32 6, !dbg !575
  %154 = load i32, i32* %c, align 4, !dbg !576
  %idxprom177 = sext i32 %154 to i64, !dbg !572
  %arrayidx178 = getelementptr inbounds [8 x i64], [8 x i64]* %child176, i64 0, i64 %idxprom177, !dbg !572
  %155 = load i64, i64* %arrayidx178, align 8, !dbg !572
  %arrayidx179 = getelementptr inbounds %struct.block, %struct.block* %150, i64 %155, !dbg !571
  %refine180 = getelementptr inbounds %struct.block, %struct.block* %arrayidx179, i32 0, i32 2, !dbg !577
  %156 = load i32, i32* %refine180, align 4, !dbg !577
  %cmp181 = icmp eq i32 %156, -1, !dbg !578
  br i1 %cmp181, label %if.then183, label %if.end, !dbg !579

if.then183:                                       ; preds = %land.lhs.true173
  %157 = load %struct.block*, %struct.block** @blocks, align 8, !dbg !580
  %158 = load %struct.parent*, %struct.parent** @parents, align 8, !dbg !581
  %159 = load %struct.block*, %struct.block** %bp, align 8, !dbg !582
  %parent184 = getelementptr inbounds %struct.block, %struct.block* %159, i32 0, i32 4, !dbg !583
  %160 = load i64, i64* %parent184, align 8, !dbg !583
  %arrayidx185 = getelementptr inbounds %struct.parent, %struct.parent* %158, i64 %160, !dbg !581
  %child186 = getelementptr inbounds %struct.parent, %struct.parent* %arrayidx185, i32 0, i32 6, !dbg !584
  %161 = load i32, i32* %c, align 4, !dbg !585
  %idxprom187 = sext i32 %161 to i64, !dbg !581
  %arrayidx188 = getelementptr inbounds [8 x i64], [8 x i64]* %child186, i64 0, i64 %idxprom187, !dbg !581
  %162 = load i64, i64* %arrayidx188, align 8, !dbg !581
  %arrayidx189 = getelementptr inbounds %struct.block, %struct.block* %157, i64 %162, !dbg !580
  %refine190 = getelementptr inbounds %struct.block, %struct.block* %arrayidx189, i32 0, i32 2, !dbg !586
  store i32 0, i32* %refine190, align 4, !dbg !587
  br label %if.end, !dbg !580

if.end:                                           ; preds = %if.then183, %land.lhs.true173, %land.lhs.true166, %for.body159
  br label %for.inc191, !dbg !588

for.inc191:                                       ; preds = %if.end
  %163 = load i32, i32* %c, align 4, !dbg !589
  %inc192 = add nsw i32 %163, 1, !dbg !589
  store i32 %inc192, i32* %c, align 4, !dbg !589
  br label %for.cond156, !dbg !590, !llvm.loop !591

for.end193:                                       ; preds = %for.cond156
  br label %if.end194, !dbg !593

if.end194:                                        ; preds = %for.end193, %if.then146
  br label %if.end195, !dbg !594

if.end195:                                        ; preds = %if.end194, %land.lhs.true, %if.then
  br label %if.end196, !dbg !595

if.end196:                                        ; preds = %if.end195, %for.body102
  br label %for.inc197, !dbg !503

for.inc197:                                       ; preds = %if.end196
  %164 = load i32, i32* %n, align 4, !dbg !596
  %inc198 = add nsw i32 %164, 1, !dbg !596
  store i32 %inc198, i32* %n, align 4, !dbg !596
  br label %for.cond95, !dbg !597, !llvm.loop !598

for.end199:                                       ; preds = %for.cond95
  br label %for.inc200, !dbg !600

for.inc200:                                       ; preds = %for.end199
  %165 = load i32, i32* %i, align 4, !dbg !601
  %inc201 = add nsw i32 %165, 1, !dbg !601
  store i32 %inc201, i32* %i, align 4, !dbg !601
  br label %for.cond86, !dbg !602, !llvm.loop !603

for.end202:                                       ; preds = %for.cond86
  store i32 0, i32* %i, align 4, !dbg !605
  br label %for.cond203, !dbg !607

for.cond203:                                      ; preds = %for.inc212, %for.end202
  %166 = load i32, i32* %i, align 4, !dbg !608
  %167 = load i32, i32* %dir, align 4, !dbg !610
  %idxprom204 = sext i32 %167 to i64, !dbg !611
  %arrayidx205 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom204, !dbg !611
  %168 = load i32, i32* %arrayidx205, align 4, !dbg !611
  %cmp206 = icmp slt i32 %166, %168, !dbg !612
  br i1 %cmp206, label %for.body208, label %for.end214, !dbg !613

for.body208:                                      ; preds = %for.cond203
  %169 = load i32, i32* %dir, align 4, !dbg !614
  %idxprom209 = sext i32 %169 to i64, !dbg !615
  %arrayidx210 = getelementptr inbounds [3 x i32], [3 x i32]* @num_comm_partners, i64 0, i64 %idxprom209, !dbg !615
  %170 = load i32, i32* %arrayidx210, align 4, !dbg !615
  %171 = load %struct.ompi_request_t**, %struct.ompi_request_t*** @s_req, align 8, !dbg !616
  %call211 = call i32 @MPI_Waitany(i32 %170, %struct.ompi_request_t** %171, i32* %which, %struct.ompi_status_public_t* %status), !dbg !617
  store i32 %call211, i32* %err, align 4, !dbg !618
  br label %for.inc212, !dbg !619

for.inc212:                                       ; preds = %for.body208
  %172 = load i32, i32* %i, align 4, !dbg !620
  %inc213 = add nsw i32 %172, 1, !dbg !620
  store i32 %inc213, i32* %i, align 4, !dbg !620
  br label %for.cond203, !dbg !621, !llvm.loop !622

for.end214:                                       ; preds = %for.cond203
  br label %for.inc215, !dbg !624

for.inc215:                                       ; preds = %for.end214
  %173 = load i32, i32* %dir, align 4, !dbg !625
  %inc216 = add nsw i32 %173, 1, !dbg !625
  store i32 %inc216, i32* %dir, align 4, !dbg !625
  br label %for.cond, !dbg !626, !llvm.loop !627

for.end217:                                       ; preds = %for.cond
  ret void, !dbg !629
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!14, !15, !16, !17, !18}
!llvm.ident = !{!19}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!1 = !DIFile(filename: "comm_refine.c", directory: "/workspace/LLVM-Checker/test/benchmarks/miniAMR/openmp")
!2 = !{}
!3 = !{!4, !6, !10, !11}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !DIDerivedType(tag: DW_TAG_typedef, name: "MPI_Datatype", file: !7, line: 401, baseType: !8)
!7 = !DIFile(filename: "/usr/lib/x86_64-linux-gnu/openmpi/include/mpi.h", directory: "")
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DICompositeType(tag: DW_TAG_structure_type, name: "ompi_datatype_t", file: !7, line: 401, flags: DIFlagFwdDecl)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "MPI_Comm", file: !7, line: 400, baseType: !12)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_structure_type, name: "ompi_communicator_t", file: !7, line: 400, flags: DIFlagFwdDecl)
!14 = !{i32 7, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = !{i32 7, !"uwtable", i32 1}
!18 = !{i32 7, !"frame-pointer", i32 2}
!19 = !{!"Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58"}
!20 = distinct !DISubprogram(name: "comm_refine", scope: !1, file: !1, line: 36, type: !21, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!21 = !DISubroutineType(types: !22)
!22 = !{null}
!23 = !DILocalVariable(name: "i", scope: !20, file: !1, line: 38, type: !5)
!24 = !DILocation(line: 38, column: 8, scope: !20)
!25 = !DILocalVariable(name: "n", scope: !20, file: !1, line: 38, type: !5)
!26 = !DILocation(line: 38, column: 11, scope: !20)
!27 = !DILocalVariable(name: "offset", scope: !20, file: !1, line: 38, type: !5)
!28 = !DILocation(line: 38, column: 14, scope: !20)
!29 = !DILocalVariable(name: "dir", scope: !20, file: !1, line: 38, type: !5)
!30 = !DILocation(line: 38, column: 22, scope: !20)
!31 = !DILocalVariable(name: "which", scope: !20, file: !1, line: 38, type: !5)
!32 = !DILocation(line: 38, column: 27, scope: !20)
!33 = !DILocalVariable(name: "face", scope: !20, file: !1, line: 38, type: !5)
!34 = !DILocation(line: 38, column: 34, scope: !20)
!35 = !DILocalVariable(name: "err", scope: !20, file: !1, line: 38, type: !5)
!36 = !DILocation(line: 38, column: 40, scope: !20)
!37 = !DILocalVariable(name: "type", scope: !20, file: !1, line: 38, type: !5)
!38 = !DILocation(line: 38, column: 45, scope: !20)
!39 = !DILocalVariable(name: "send_int", scope: !20, file: !1, line: 39, type: !4)
!40 = !DILocation(line: 39, column: 9, scope: !20)
!41 = !DILocation(line: 39, column: 28, scope: !20)
!42 = !DILocation(line: 39, column: 20, scope: !20)
!43 = !DILocalVariable(name: "recv_int", scope: !20, file: !1, line: 40, type: !4)
!44 = !DILocation(line: 40, column: 9, scope: !20)
!45 = !DILocation(line: 40, column: 28, scope: !20)
!46 = !DILocation(line: 40, column: 20, scope: !20)
!47 = !DILocalVariable(name: "bp", scope: !20, file: !1, line: 41, type: !48)
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = !DIDerivedType(tag: DW_TAG_typedef, name: "block", file: !50, line: 46, baseType: !51)
!50 = !DIFile(filename: "./block.h", directory: "/workspace/LLVM-Checker/test/benchmarks/miniAMR/openmp")
!51 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !50, line: 31, size: 1664, elements: !52)
!52 = !{!53, !56, !57, !58, !59, !60, !61, !62, !66, !67, !71, !75}
!53 = !DIDerivedType(tag: DW_TAG_member, name: "number", scope: !51, file: !50, line: 32, baseType: !54, size: 64)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "num_sz", file: !50, line: 29, baseType: !55)
!55 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "level", scope: !51, file: !50, line: 33, baseType: !5, size: 32, offset: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "refine", scope: !51, file: !50, line: 34, baseType: !5, size: 32, offset: 96)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "new_proc", scope: !51, file: !50, line: 35, baseType: !5, size: 32, offset: 128)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !51, file: !50, line: 36, baseType: !54, size: 64, offset: 192)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "parent_node", scope: !51, file: !50, line: 39, baseType: !5, size: 32, offset: 256)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "child_number", scope: !51, file: !50, line: 40, baseType: !5, size: 32, offset: 288)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "nei_refine", scope: !51, file: !50, line: 41, baseType: !63, size: 192, offset: 320)
!63 = !DICompositeType(tag: DW_TAG_array_type, baseType: !5, size: 192, elements: !64)
!64 = !{!65}
!65 = !DISubrange(count: 6)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "nei_level", scope: !51, file: !50, line: 42, baseType: !63, size: 192, offset: 512)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "nei", scope: !51, file: !50, line: 43, baseType: !68, size: 768, offset: 704)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !5, size: 768, elements: !69)
!69 = !{!65, !70, !70}
!70 = !DISubrange(count: 2)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "cen", scope: !51, file: !50, line: 44, baseType: !72, size: 96, offset: 1472)
!72 = !DICompositeType(tag: DW_TAG_array_type, baseType: !5, size: 96, elements: !73)
!73 = !{!74}
!74 = !DISubrange(count: 3)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "array", scope: !51, file: !50, line: 45, baseType: !76, size: 64, offset: 1600)
!76 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !79, size: 64)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!81 = !DILocation(line: 41, column: 11, scope: !20)
!82 = !DILocalVariable(name: "status", scope: !20, file: !1, line: 42, type: !83)
!83 = !DIDerivedType(tag: DW_TAG_typedef, name: "MPI_Status", file: !7, line: 409, baseType: !84)
!84 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ompi_status_public_t", file: !7, line: 419, size: 192, elements: !85)
!85 = !{!86, !87, !88, !89, !90}
!86 = !DIDerivedType(tag: DW_TAG_member, name: "MPI_SOURCE", scope: !84, file: !7, line: 422, baseType: !5, size: 32)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "MPI_TAG", scope: !84, file: !7, line: 423, baseType: !5, size: 32, offset: 32)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "MPI_ERROR", scope: !84, file: !7, line: 424, baseType: !5, size: 32, offset: 64)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "_cancelled", scope: !84, file: !7, line: 429, baseType: !5, size: 32, offset: 96)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "_ucount", scope: !84, file: !7, line: 430, baseType: !91, size: 64, offset: 128)
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !92, line: 46, baseType: !93)
!92 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/stddef.h", directory: "")
!93 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!94 = !DILocation(line: 42, column: 15, scope: !20)
!95 = !DILocation(line: 44, column: 13, scope: !96)
!96 = distinct !DILexicalBlock(scope: !20, file: !1, line: 44, column: 4)
!97 = !DILocation(line: 44, column: 9, scope: !96)
!98 = !DILocation(line: 44, column: 18, scope: !99)
!99 = distinct !DILexicalBlock(scope: !96, file: !1, line: 44, column: 4)
!100 = !DILocation(line: 44, column: 22, scope: !99)
!101 = !DILocation(line: 44, column: 4, scope: !96)
!102 = !DILocation(line: 45, column: 19, scope: !103)
!103 = distinct !DILexicalBlock(scope: !99, file: !1, line: 44, column: 34)
!104 = !DILocation(line: 45, column: 17, scope: !103)
!105 = !DILocation(line: 45, column: 12, scope: !103)
!106 = !DILocation(line: 46, column: 14, scope: !107)
!107 = distinct !DILexicalBlock(scope: !103, file: !1, line: 46, column: 7)
!108 = !DILocation(line: 46, column: 12, scope: !107)
!109 = !DILocation(line: 46, column: 19, scope: !110)
!110 = distinct !DILexicalBlock(scope: !107, file: !1, line: 46, column: 7)
!111 = !DILocation(line: 46, column: 41, scope: !110)
!112 = !DILocation(line: 46, column: 23, scope: !110)
!113 = !DILocation(line: 46, column: 21, scope: !110)
!114 = !DILocation(line: 46, column: 7, scope: !107)
!115 = !DILocation(line: 47, column: 21, scope: !110)
!116 = !DILocation(line: 47, column: 41, scope: !110)
!117 = !DILocation(line: 47, column: 30, scope: !110)
!118 = !DILocation(line: 47, column: 46, scope: !110)
!119 = !DILocation(line: 47, column: 20, scope: !110)
!120 = !DILocation(line: 47, column: 60, scope: !110)
!121 = !DILocation(line: 47, column: 51, scope: !110)
!122 = !DILocation(line: 47, column: 65, scope: !110)
!123 = !DILocation(line: 48, column: 42, scope: !110)
!124 = !DILocation(line: 48, column: 29, scope: !110)
!125 = !DILocation(line: 48, column: 47, scope: !110)
!126 = !DILocation(line: 48, column: 51, scope: !110)
!127 = !DILocation(line: 49, column: 21, scope: !110)
!128 = !DILocation(line: 49, column: 29, scope: !110)
!129 = !DILocation(line: 47, column: 10, scope: !110)
!130 = !DILocation(line: 46, column: 48, scope: !110)
!131 = !DILocation(line: 46, column: 7, scope: !110)
!132 = distinct !{!132, !114, !133, !134}
!133 = !DILocation(line: 49, column: 31, scope: !107)
!134 = !{!"llvm.loop.mustprogress"}
!135 = !DILocation(line: 51, column: 14, scope: !136)
!136 = distinct !DILexicalBlock(scope: !103, file: !1, line: 51, column: 7)
!137 = !DILocation(line: 51, column: 12, scope: !136)
!138 = !DILocation(line: 51, column: 19, scope: !139)
!139 = distinct !DILexicalBlock(scope: !136, file: !1, line: 51, column: 7)
!140 = !DILocation(line: 51, column: 41, scope: !139)
!141 = !DILocation(line: 51, column: 23, scope: !139)
!142 = !DILocation(line: 51, column: 21, scope: !139)
!143 = !DILocation(line: 51, column: 7, scope: !136)
!144 = !DILocation(line: 52, column: 30, scope: !145)
!145 = distinct !DILexicalBlock(scope: !139, file: !1, line: 51, column: 52)
!146 = !DILocation(line: 52, column: 19, scope: !145)
!147 = !DILocation(line: 52, column: 35, scope: !145)
!148 = !DILocation(line: 52, column: 17, scope: !145)
!149 = !DILocation(line: 53, column: 17, scope: !150)
!150 = distinct !DILexicalBlock(scope: !145, file: !1, line: 53, column: 10)
!151 = !DILocation(line: 53, column: 15, scope: !150)
!152 = !DILocation(line: 53, column: 22, scope: !153)
!153 = distinct !DILexicalBlock(scope: !150, file: !1, line: 53, column: 10)
!154 = !DILocation(line: 53, column: 35, scope: !153)
!155 = !DILocation(line: 53, column: 26, scope: !153)
!156 = !DILocation(line: 53, column: 40, scope: !153)
!157 = !DILocation(line: 53, column: 24, scope: !153)
!158 = !DILocation(line: 53, column: 10, scope: !150)
!159 = !DILocation(line: 55, column: 27, scope: !153)
!160 = !DILocation(line: 55, column: 45, scope: !153)
!161 = !DILocation(line: 55, column: 34, scope: !153)
!162 = !DILocation(line: 55, column: 61, scope: !153)
!163 = !DILocation(line: 55, column: 50, scope: !153)
!164 = !DILocation(line: 55, column: 66, scope: !153)
!165 = !DILocation(line: 55, column: 69, scope: !153)
!166 = !DILocation(line: 55, column: 68, scope: !153)
!167 = !DILocation(line: 55, column: 73, scope: !153)
!168 = !DILocation(line: 54, column: 13, scope: !153)
!169 = !DILocation(line: 54, column: 22, scope: !153)
!170 = !DILocation(line: 54, column: 29, scope: !153)
!171 = !DILocation(line: 54, column: 28, scope: !153)
!172 = !DILocation(line: 54, column: 32, scope: !153)
!173 = !DILocation(line: 53, column: 45, scope: !153)
!174 = !DILocation(line: 53, column: 10, scope: !153)
!175 = distinct !{!175, !158, !176, !134}
!176 = !DILocation(line: 55, column: 73, scope: !150)
!177 = !DILocation(line: 56, column: 21, scope: !145)
!178 = !DILocation(line: 56, column: 41, scope: !145)
!179 = !DILocation(line: 56, column: 30, scope: !145)
!180 = !DILocation(line: 56, column: 46, scope: !145)
!181 = !DILocation(line: 56, column: 20, scope: !145)
!182 = !DILocation(line: 56, column: 60, scope: !145)
!183 = !DILocation(line: 56, column: 51, scope: !145)
!184 = !DILocation(line: 56, column: 65, scope: !145)
!185 = !DILocation(line: 57, column: 42, scope: !145)
!186 = !DILocation(line: 57, column: 29, scope: !145)
!187 = !DILocation(line: 57, column: 47, scope: !145)
!188 = !DILocation(line: 57, column: 51, scope: !145)
!189 = !DILocation(line: 58, column: 21, scope: !145)
!190 = !DILocation(line: 58, column: 27, scope: !145)
!191 = !DILocation(line: 56, column: 10, scope: !145)
!192 = !DILocation(line: 59, column: 7, scope: !145)
!193 = !DILocation(line: 51, column: 48, scope: !139)
!194 = !DILocation(line: 51, column: 7, scope: !139)
!195 = distinct !{!195, !143, !196, !134}
!196 = !DILocation(line: 59, column: 7, scope: !136)
!197 = !DILocation(line: 61, column: 14, scope: !198)
!198 = distinct !DILexicalBlock(scope: !103, file: !1, line: 61, column: 7)
!199 = !DILocation(line: 61, column: 12, scope: !198)
!200 = !DILocation(line: 61, column: 19, scope: !201)
!201 = distinct !DILexicalBlock(scope: !198, file: !1, line: 61, column: 7)
!202 = !DILocation(line: 61, column: 41, scope: !201)
!203 = !DILocation(line: 61, column: 23, scope: !201)
!204 = !DILocation(line: 61, column: 21, scope: !201)
!205 = !DILocation(line: 61, column: 7, scope: !198)
!206 = !DILocation(line: 62, column: 46, scope: !207)
!207 = distinct !DILexicalBlock(scope: !201, file: !1, line: 61, column: 52)
!208 = !DILocation(line: 62, column: 28, scope: !207)
!209 = !DILocation(line: 62, column: 52, scope: !207)
!210 = !DILocation(line: 62, column: 16, scope: !207)
!211 = !DILocation(line: 62, column: 14, scope: !207)
!212 = !DILocation(line: 63, column: 17, scope: !213)
!213 = distinct !DILexicalBlock(scope: !207, file: !1, line: 63, column: 10)
!214 = !DILocation(line: 63, column: 15, scope: !213)
!215 = !DILocation(line: 63, column: 22, scope: !216)
!216 = distinct !DILexicalBlock(scope: !213, file: !1, line: 63, column: 10)
!217 = !DILocation(line: 63, column: 35, scope: !216)
!218 = !DILocation(line: 63, column: 26, scope: !216)
!219 = !DILocation(line: 63, column: 40, scope: !216)
!220 = !DILocation(line: 63, column: 24, scope: !216)
!221 = !DILocation(line: 63, column: 10, scope: !213)
!222 = !DILocation(line: 64, column: 20, scope: !223)
!223 = distinct !DILexicalBlock(scope: !216, file: !1, line: 63, column: 53)
!224 = !DILocation(line: 64, column: 23, scope: !223)
!225 = !DILocation(line: 64, column: 42, scope: !223)
!226 = !DILocation(line: 64, column: 27, scope: !223)
!227 = !DILocation(line: 64, column: 58, scope: !223)
!228 = !DILocation(line: 64, column: 47, scope: !223)
!229 = !DILocation(line: 64, column: 63, scope: !223)
!230 = !DILocation(line: 64, column: 70, scope: !223)
!231 = !DILocation(line: 64, column: 69, scope: !223)
!232 = !DILocation(line: 64, column: 73, scope: !223)
!233 = !DILocation(line: 64, column: 25, scope: !223)
!234 = !DILocation(line: 64, column: 18, scope: !223)
!235 = !DILocation(line: 65, column: 19, scope: !223)
!236 = !DILocation(line: 65, column: 37, scope: !223)
!237 = !DILocation(line: 65, column: 26, scope: !223)
!238 = !DILocation(line: 65, column: 53, scope: !223)
!239 = !DILocation(line: 65, column: 42, scope: !223)
!240 = !DILocation(line: 65, column: 58, scope: !223)
!241 = !DILocation(line: 65, column: 65, scope: !223)
!242 = !DILocation(line: 65, column: 64, scope: !223)
!243 = !DILocation(line: 65, column: 16, scope: !223)
!244 = !DILocation(line: 66, column: 17, scope: !245)
!245 = distinct !DILexicalBlock(scope: !223, file: !1, line: 66, column: 17)
!246 = !DILocation(line: 66, column: 37, scope: !245)
!247 = !DILocation(line: 66, column: 26, scope: !245)
!248 = !DILocation(line: 66, column: 42, scope: !245)
!249 = !DILocation(line: 66, column: 49, scope: !245)
!250 = !DILocation(line: 66, column: 48, scope: !245)
!251 = !DILocation(line: 66, column: 52, scope: !245)
!252 = !DILocation(line: 66, column: 57, scope: !245)
!253 = !DILocation(line: 67, column: 17, scope: !245)
!254 = !DILocation(line: 67, column: 21, scope: !245)
!255 = !DILocation(line: 67, column: 31, scope: !245)
!256 = !DILocation(line: 67, column: 40, scope: !245)
!257 = !DILocation(line: 67, column: 44, scope: !245)
!258 = !DILocation(line: 67, column: 37, scope: !245)
!259 = !DILocation(line: 66, column: 17, scope: !223)
!260 = !DILocation(line: 68, column: 16, scope: !245)
!261 = !DILocation(line: 68, column: 20, scope: !245)
!262 = !DILocation(line: 68, column: 31, scope: !245)
!263 = !DILocation(line: 68, column: 37, scope: !245)
!264 = !DILocation(line: 69, column: 22, scope: !265)
!265 = distinct !DILexicalBlock(scope: !245, file: !1, line: 69, column: 22)
!266 = !DILocation(line: 69, column: 42, scope: !265)
!267 = !DILocation(line: 69, column: 31, scope: !265)
!268 = !DILocation(line: 69, column: 47, scope: !265)
!269 = !DILocation(line: 69, column: 54, scope: !265)
!270 = !DILocation(line: 69, column: 53, scope: !265)
!271 = !DILocation(line: 69, column: 57, scope: !265)
!272 = !DILocation(line: 69, column: 62, scope: !265)
!273 = !DILocation(line: 70, column: 22, scope: !265)
!274 = !DILocation(line: 70, column: 26, scope: !265)
!275 = !DILocation(line: 70, column: 37, scope: !265)
!276 = !DILocation(line: 70, column: 43, scope: !265)
!277 = !DILocation(line: 69, column: 22, scope: !245)
!278 = !DILocation(line: 71, column: 16, scope: !265)
!279 = !DILocation(line: 71, column: 20, scope: !265)
!280 = !DILocation(line: 71, column: 31, scope: !265)
!281 = !DILocation(line: 71, column: 37, scope: !265)
!282 = !DILocation(line: 72, column: 10, scope: !223)
!283 = !DILocation(line: 63, column: 49, scope: !216)
!284 = !DILocation(line: 63, column: 10, scope: !216)
!285 = distinct !{!285, !221, !286, !134}
!286 = !DILocation(line: 72, column: 10, scope: !213)
!287 = !DILocation(line: 73, column: 7, scope: !207)
!288 = !DILocation(line: 61, column: 48, scope: !201)
!289 = !DILocation(line: 61, column: 7, scope: !201)
!290 = distinct !{!290, !205, !291, !134}
!291 = !DILocation(line: 73, column: 7, scope: !198)
!292 = !DILocation(line: 75, column: 14, scope: !293)
!293 = distinct !DILexicalBlock(scope: !103, file: !1, line: 75, column: 7)
!294 = !DILocation(line: 75, column: 12, scope: !293)
!295 = !DILocation(line: 75, column: 19, scope: !296)
!296 = distinct !DILexicalBlock(scope: !293, file: !1, line: 75, column: 7)
!297 = !DILocation(line: 75, column: 41, scope: !296)
!298 = !DILocation(line: 75, column: 23, scope: !296)
!299 = !DILocation(line: 75, column: 21, scope: !296)
!300 = !DILocation(line: 75, column: 7, scope: !293)
!301 = !DILocation(line: 76, column: 46, scope: !296)
!302 = !DILocation(line: 76, column: 28, scope: !296)
!303 = !DILocation(line: 76, column: 52, scope: !296)
!304 = !DILocation(line: 76, column: 16, scope: !296)
!305 = !DILocation(line: 76, column: 14, scope: !296)
!306 = !DILocation(line: 76, column: 10, scope: !296)
!307 = !DILocation(line: 75, column: 48, scope: !296)
!308 = !DILocation(line: 75, column: 7, scope: !296)
!309 = distinct !{!309, !300, !310, !134}
!310 = !DILocation(line: 76, column: 74, scope: !293)
!311 = !DILocation(line: 77, column: 4, scope: !103)
!312 = !DILocation(line: 44, column: 30, scope: !99)
!313 = !DILocation(line: 44, column: 4, scope: !99)
!314 = distinct !{!314, !101, !315, !134}
!315 = !DILocation(line: 77, column: 4, scope: !96)
!316 = !DILocation(line: 78, column: 1, scope: !20)
!317 = distinct !DISubprogram(name: "comm_reverse_refine", scope: !1, file: !1, line: 80, type: !21, scopeLine: 81, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!318 = !DILocalVariable(name: "i", scope: !317, file: !1, line: 82, type: !5)
!319 = !DILocation(line: 82, column: 8, scope: !317)
!320 = !DILocalVariable(name: "n", scope: !317, file: !1, line: 82, type: !5)
!321 = !DILocation(line: 82, column: 11, scope: !317)
!322 = !DILocalVariable(name: "c", scope: !317, file: !1, line: 82, type: !5)
!323 = !DILocation(line: 82, column: 14, scope: !317)
!324 = !DILocalVariable(name: "offset", scope: !317, file: !1, line: 82, type: !5)
!325 = !DILocation(line: 82, column: 17, scope: !317)
!326 = !DILocalVariable(name: "dir", scope: !317, file: !1, line: 82, type: !5)
!327 = !DILocation(line: 82, column: 25, scope: !317)
!328 = !DILocalVariable(name: "which", scope: !317, file: !1, line: 82, type: !5)
!329 = !DILocation(line: 82, column: 30, scope: !317)
!330 = !DILocalVariable(name: "face", scope: !317, file: !1, line: 82, type: !5)
!331 = !DILocation(line: 82, column: 37, scope: !317)
!332 = !DILocalVariable(name: "err", scope: !317, file: !1, line: 82, type: !5)
!333 = !DILocation(line: 82, column: 43, scope: !317)
!334 = !DILocalVariable(name: "type", scope: !317, file: !1, line: 82, type: !5)
!335 = !DILocation(line: 82, column: 48, scope: !317)
!336 = !DILocalVariable(name: "send_int", scope: !317, file: !1, line: 83, type: !4)
!337 = !DILocation(line: 83, column: 9, scope: !317)
!338 = !DILocation(line: 83, column: 28, scope: !317)
!339 = !DILocation(line: 83, column: 20, scope: !317)
!340 = !DILocalVariable(name: "recv_int", scope: !317, file: !1, line: 84, type: !4)
!341 = !DILocation(line: 84, column: 9, scope: !317)
!342 = !DILocation(line: 84, column: 28, scope: !317)
!343 = !DILocation(line: 84, column: 20, scope: !317)
!344 = !DILocalVariable(name: "bp", scope: !317, file: !1, line: 85, type: !48)
!345 = !DILocation(line: 85, column: 11, scope: !317)
!346 = !DILocalVariable(name: "status", scope: !317, file: !1, line: 86, type: !83)
!347 = !DILocation(line: 86, column: 15, scope: !317)
!348 = !DILocation(line: 88, column: 13, scope: !349)
!349 = distinct !DILexicalBlock(scope: !317, file: !1, line: 88, column: 4)
!350 = !DILocation(line: 88, column: 9, scope: !349)
!351 = !DILocation(line: 88, column: 18, scope: !352)
!352 = distinct !DILexicalBlock(scope: !349, file: !1, line: 88, column: 4)
!353 = !DILocation(line: 88, column: 22, scope: !352)
!354 = !DILocation(line: 88, column: 4, scope: !349)
!355 = !DILocation(line: 89, column: 19, scope: !356)
!356 = distinct !DILexicalBlock(scope: !352, file: !1, line: 88, column: 34)
!357 = !DILocation(line: 89, column: 17, scope: !356)
!358 = !DILocation(line: 89, column: 12, scope: !356)
!359 = !DILocation(line: 90, column: 14, scope: !360)
!360 = distinct !DILexicalBlock(scope: !356, file: !1, line: 90, column: 7)
!361 = !DILocation(line: 90, column: 12, scope: !360)
!362 = !DILocation(line: 90, column: 19, scope: !363)
!363 = distinct !DILexicalBlock(scope: !360, file: !1, line: 90, column: 7)
!364 = !DILocation(line: 90, column: 41, scope: !363)
!365 = !DILocation(line: 90, column: 23, scope: !363)
!366 = !DILocation(line: 90, column: 21, scope: !363)
!367 = !DILocation(line: 90, column: 7, scope: !360)
!368 = !DILocation(line: 91, column: 21, scope: !363)
!369 = !DILocation(line: 91, column: 41, scope: !363)
!370 = !DILocation(line: 91, column: 30, scope: !363)
!371 = !DILocation(line: 91, column: 46, scope: !363)
!372 = !DILocation(line: 91, column: 20, scope: !363)
!373 = !DILocation(line: 91, column: 60, scope: !363)
!374 = !DILocation(line: 91, column: 51, scope: !363)
!375 = !DILocation(line: 91, column: 65, scope: !363)
!376 = !DILocation(line: 92, column: 42, scope: !363)
!377 = !DILocation(line: 92, column: 29, scope: !363)
!378 = !DILocation(line: 92, column: 47, scope: !363)
!379 = !DILocation(line: 92, column: 51, scope: !363)
!380 = !DILocation(line: 93, column: 21, scope: !363)
!381 = !DILocation(line: 93, column: 29, scope: !363)
!382 = !DILocation(line: 91, column: 10, scope: !363)
!383 = !DILocation(line: 90, column: 48, scope: !363)
!384 = !DILocation(line: 90, column: 7, scope: !363)
!385 = distinct !{!385, !367, !386, !134}
!386 = !DILocation(line: 93, column: 31, scope: !360)
!387 = !DILocation(line: 95, column: 14, scope: !388)
!388 = distinct !DILexicalBlock(scope: !356, file: !1, line: 95, column: 7)
!389 = !DILocation(line: 95, column: 12, scope: !388)
!390 = !DILocation(line: 95, column: 19, scope: !391)
!391 = distinct !DILexicalBlock(scope: !388, file: !1, line: 95, column: 7)
!392 = !DILocation(line: 95, column: 41, scope: !391)
!393 = !DILocation(line: 95, column: 23, scope: !391)
!394 = !DILocation(line: 95, column: 21, scope: !391)
!395 = !DILocation(line: 95, column: 7, scope: !388)
!396 = !DILocation(line: 96, column: 30, scope: !397)
!397 = distinct !DILexicalBlock(scope: !391, file: !1, line: 95, column: 52)
!398 = !DILocation(line: 96, column: 19, scope: !397)
!399 = !DILocation(line: 96, column: 35, scope: !397)
!400 = !DILocation(line: 96, column: 17, scope: !397)
!401 = !DILocation(line: 97, column: 17, scope: !402)
!402 = distinct !DILexicalBlock(scope: !397, file: !1, line: 97, column: 10)
!403 = !DILocation(line: 97, column: 15, scope: !402)
!404 = !DILocation(line: 97, column: 22, scope: !405)
!405 = distinct !DILexicalBlock(scope: !402, file: !1, line: 97, column: 10)
!406 = !DILocation(line: 97, column: 35, scope: !405)
!407 = !DILocation(line: 97, column: 26, scope: !405)
!408 = !DILocation(line: 97, column: 40, scope: !405)
!409 = !DILocation(line: 97, column: 24, scope: !405)
!410 = !DILocation(line: 97, column: 10, scope: !402)
!411 = !DILocation(line: 98, column: 20, scope: !412)
!412 = distinct !DILexicalBlock(scope: !405, file: !1, line: 97, column: 49)
!413 = !DILocation(line: 98, column: 23, scope: !412)
!414 = !DILocation(line: 98, column: 44, scope: !412)
!415 = !DILocation(line: 98, column: 29, scope: !412)
!416 = !DILocation(line: 98, column: 60, scope: !412)
!417 = !DILocation(line: 98, column: 49, scope: !412)
!418 = !DILocation(line: 98, column: 65, scope: !412)
!419 = !DILocation(line: 98, column: 68, scope: !412)
!420 = !DILocation(line: 98, column: 67, scope: !412)
!421 = !DILocation(line: 98, column: 71, scope: !412)
!422 = !DILocation(line: 98, column: 26, scope: !412)
!423 = !DILocation(line: 98, column: 18, scope: !412)
!424 = !DILocation(line: 100, column: 17, scope: !412)
!425 = !DILocation(line: 100, column: 35, scope: !412)
!426 = !DILocation(line: 100, column: 24, scope: !412)
!427 = !DILocation(line: 100, column: 51, scope: !412)
!428 = !DILocation(line: 100, column: 40, scope: !412)
!429 = !DILocation(line: 100, column: 56, scope: !412)
!430 = !DILocation(line: 100, column: 59, scope: !412)
!431 = !DILocation(line: 100, column: 58, scope: !412)
!432 = !DILocation(line: 100, column: 63, scope: !412)
!433 = !DILocation(line: 100, column: 74, scope: !412)
!434 = !DILocation(line: 99, column: 13, scope: !412)
!435 = !DILocation(line: 99, column: 22, scope: !412)
!436 = !DILocation(line: 99, column: 29, scope: !412)
!437 = !DILocation(line: 99, column: 28, scope: !412)
!438 = !DILocation(line: 99, column: 32, scope: !412)
!439 = !DILocation(line: 101, column: 10, scope: !412)
!440 = !DILocation(line: 97, column: 45, scope: !405)
!441 = !DILocation(line: 97, column: 10, scope: !405)
!442 = distinct !{!442, !410, !443, !134}
!443 = !DILocation(line: 101, column: 10, scope: !402)
!444 = !DILocation(line: 102, column: 21, scope: !397)
!445 = !DILocation(line: 102, column: 41, scope: !397)
!446 = !DILocation(line: 102, column: 30, scope: !397)
!447 = !DILocation(line: 102, column: 46, scope: !397)
!448 = !DILocation(line: 102, column: 20, scope: !397)
!449 = !DILocation(line: 102, column: 60, scope: !397)
!450 = !DILocation(line: 102, column: 51, scope: !397)
!451 = !DILocation(line: 102, column: 65, scope: !397)
!452 = !DILocation(line: 103, column: 42, scope: !397)
!453 = !DILocation(line: 103, column: 29, scope: !397)
!454 = !DILocation(line: 103, column: 47, scope: !397)
!455 = !DILocation(line: 103, column: 51, scope: !397)
!456 = !DILocation(line: 104, column: 21, scope: !397)
!457 = !DILocation(line: 104, column: 27, scope: !397)
!458 = !DILocation(line: 102, column: 10, scope: !397)
!459 = !DILocation(line: 105, column: 7, scope: !397)
!460 = !DILocation(line: 95, column: 48, scope: !391)
!461 = !DILocation(line: 95, column: 7, scope: !391)
!462 = distinct !{!462, !395, !463, !134}
!463 = !DILocation(line: 105, column: 7, scope: !388)
!464 = !DILocation(line: 107, column: 14, scope: !465)
!465 = distinct !DILexicalBlock(scope: !356, file: !1, line: 107, column: 7)
!466 = !DILocation(line: 107, column: 12, scope: !465)
!467 = !DILocation(line: 107, column: 19, scope: !468)
!468 = distinct !DILexicalBlock(scope: !465, file: !1, line: 107, column: 7)
!469 = !DILocation(line: 107, column: 41, scope: !468)
!470 = !DILocation(line: 107, column: 23, scope: !468)
!471 = !DILocation(line: 107, column: 21, scope: !468)
!472 = !DILocation(line: 107, column: 7, scope: !465)
!473 = !DILocation(line: 108, column: 40, scope: !474)
!474 = distinct !DILexicalBlock(scope: !468, file: !1, line: 107, column: 52)
!475 = !DILocation(line: 108, column: 22, scope: !474)
!476 = !DILocation(line: 108, column: 46, scope: !474)
!477 = !DILocation(line: 108, column: 10, scope: !474)
!478 = !DILocation(line: 109, column: 17, scope: !479)
!479 = distinct !DILexicalBlock(scope: !474, file: !1, line: 109, column: 10)
!480 = !DILocation(line: 109, column: 15, scope: !479)
!481 = !DILocation(line: 109, column: 22, scope: !482)
!482 = distinct !DILexicalBlock(scope: !479, file: !1, line: 109, column: 10)
!483 = !DILocation(line: 109, column: 35, scope: !482)
!484 = !DILocation(line: 109, column: 26, scope: !482)
!485 = !DILocation(line: 109, column: 40, scope: !482)
!486 = !DILocation(line: 109, column: 24, scope: !482)
!487 = !DILocation(line: 109, column: 10, scope: !479)
!488 = !DILocation(line: 110, column: 17, scope: !489)
!489 = distinct !DILexicalBlock(scope: !482, file: !1, line: 110, column: 17)
!490 = !DILocation(line: 110, column: 37, scope: !489)
!491 = !DILocation(line: 110, column: 26, scope: !489)
!492 = !DILocation(line: 110, column: 42, scope: !489)
!493 = !DILocation(line: 110, column: 49, scope: !489)
!494 = !DILocation(line: 110, column: 48, scope: !489)
!495 = !DILocation(line: 111, column: 17, scope: !489)
!496 = !DILocation(line: 111, column: 35, scope: !489)
!497 = !DILocation(line: 111, column: 24, scope: !489)
!498 = !DILocation(line: 111, column: 51, scope: !489)
!499 = !DILocation(line: 111, column: 40, scope: !489)
!500 = !DILocation(line: 111, column: 56, scope: !489)
!501 = !DILocation(line: 111, column: 63, scope: !489)
!502 = !DILocation(line: 111, column: 62, scope: !489)
!503 = !DILocation(line: 111, column: 67, scope: !489)
!504 = !DILocation(line: 110, column: 52, scope: !489)
!505 = !DILocation(line: 110, column: 17, scope: !482)
!506 = !DILocation(line: 112, column: 22, scope: !507)
!507 = distinct !DILexicalBlock(scope: !489, file: !1, line: 111, column: 75)
!508 = !DILocation(line: 112, column: 40, scope: !507)
!509 = !DILocation(line: 112, column: 29, scope: !507)
!510 = !DILocation(line: 112, column: 56, scope: !507)
!511 = !DILocation(line: 112, column: 45, scope: !507)
!512 = !DILocation(line: 112, column: 61, scope: !507)
!513 = !DILocation(line: 112, column: 68, scope: !507)
!514 = !DILocation(line: 112, column: 67, scope: !507)
!515 = !DILocation(line: 112, column: 19, scope: !507)
!516 = !DILocation(line: 113, column: 29, scope: !507)
!517 = !DILocation(line: 113, column: 49, scope: !507)
!518 = !DILocation(line: 113, column: 38, scope: !507)
!519 = !DILocation(line: 113, column: 54, scope: !507)
!520 = !DILocation(line: 113, column: 61, scope: !507)
!521 = !DILocation(line: 113, column: 60, scope: !507)
!522 = !DILocation(line: 113, column: 16, scope: !507)
!523 = !DILocation(line: 113, column: 20, scope: !507)
!524 = !DILocation(line: 113, column: 27, scope: !507)
!525 = !DILocation(line: 114, column: 20, scope: !526)
!526 = distinct !DILexicalBlock(scope: !507, file: !1, line: 114, column: 20)
!527 = !DILocation(line: 114, column: 24, scope: !526)
!528 = !DILocation(line: 114, column: 31, scope: !526)
!529 = !DILocation(line: 114, column: 37, scope: !526)
!530 = !DILocation(line: 114, column: 40, scope: !526)
!531 = !DILocation(line: 114, column: 44, scope: !526)
!532 = !DILocation(line: 114, column: 59, scope: !526)
!533 = !DILocation(line: 114, column: 56, scope: !526)
!534 = !DILocation(line: 114, column: 20, scope: !507)
!535 = !DILocation(line: 115, column: 23, scope: !536)
!536 = distinct !DILexicalBlock(scope: !526, file: !1, line: 115, column: 23)
!537 = !DILocation(line: 115, column: 31, scope: !536)
!538 = !DILocation(line: 115, column: 35, scope: !536)
!539 = !DILocation(line: 115, column: 43, scope: !536)
!540 = !DILocation(line: 115, column: 50, scope: !536)
!541 = !DILocation(line: 115, column: 23, scope: !526)
!542 = !DILocation(line: 116, column: 22, scope: !543)
!543 = distinct !DILexicalBlock(scope: !536, file: !1, line: 115, column: 57)
!544 = !DILocation(line: 116, column: 30, scope: !543)
!545 = !DILocation(line: 116, column: 34, scope: !543)
!546 = !DILocation(line: 116, column: 42, scope: !543)
!547 = !DILocation(line: 116, column: 49, scope: !543)
!548 = !DILocation(line: 117, column: 29, scope: !549)
!549 = distinct !DILexicalBlock(scope: !543, file: !1, line: 117, column: 22)
!550 = !DILocation(line: 117, column: 27, scope: !549)
!551 = !DILocation(line: 117, column: 34, scope: !552)
!552 = distinct !DILexicalBlock(scope: !549, file: !1, line: 117, column: 22)
!553 = !DILocation(line: 117, column: 36, scope: !552)
!554 = !DILocation(line: 117, column: 22, scope: !549)
!555 = !DILocation(line: 118, column: 29, scope: !556)
!556 = distinct !DILexicalBlock(scope: !552, file: !1, line: 118, column: 29)
!557 = !DILocation(line: 118, column: 37, scope: !556)
!558 = !DILocation(line: 118, column: 41, scope: !556)
!559 = !DILocation(line: 118, column: 49, scope: !556)
!560 = !DILocation(line: 118, column: 60, scope: !556)
!561 = !DILocation(line: 118, column: 66, scope: !556)
!562 = !DILocation(line: 118, column: 63, scope: !556)
!563 = !DILocation(line: 118, column: 72, scope: !556)
!564 = !DILocation(line: 119, column: 29, scope: !556)
!565 = !DILocation(line: 119, column: 37, scope: !556)
!566 = !DILocation(line: 119, column: 41, scope: !556)
!567 = !DILocation(line: 119, column: 49, scope: !556)
!568 = !DILocation(line: 119, column: 55, scope: !556)
!569 = !DILocation(line: 119, column: 58, scope: !556)
!570 = !DILocation(line: 119, column: 63, scope: !556)
!571 = !DILocation(line: 120, column: 29, scope: !556)
!572 = !DILocation(line: 120, column: 36, scope: !556)
!573 = !DILocation(line: 120, column: 44, scope: !556)
!574 = !DILocation(line: 120, column: 48, scope: !556)
!575 = !DILocation(line: 120, column: 56, scope: !556)
!576 = !DILocation(line: 120, column: 62, scope: !556)
!577 = !DILocation(line: 120, column: 66, scope: !556)
!578 = !DILocation(line: 120, column: 73, scope: !556)
!579 = !DILocation(line: 118, column: 29, scope: !552)
!580 = !DILocation(line: 121, column: 28, scope: !556)
!581 = !DILocation(line: 121, column: 35, scope: !556)
!582 = !DILocation(line: 121, column: 43, scope: !556)
!583 = !DILocation(line: 121, column: 47, scope: !556)
!584 = !DILocation(line: 121, column: 55, scope: !556)
!585 = !DILocation(line: 121, column: 61, scope: !556)
!586 = !DILocation(line: 121, column: 65, scope: !556)
!587 = !DILocation(line: 121, column: 72, scope: !556)
!588 = !DILocation(line: 120, column: 77, scope: !556)
!589 = !DILocation(line: 117, column: 42, scope: !552)
!590 = !DILocation(line: 117, column: 22, scope: !552)
!591 = distinct !{!591, !554, !592, !134}
!592 = !DILocation(line: 121, column: 74, scope: !549)
!593 = !DILocation(line: 122, column: 19, scope: !543)
!594 = !DILocation(line: 115, column: 54, scope: !536)
!595 = !DILocation(line: 123, column: 13, scope: !507)
!596 = !DILocation(line: 109, column: 49, scope: !482)
!597 = !DILocation(line: 109, column: 10, scope: !482)
!598 = distinct !{!598, !487, !599, !134}
!599 = !DILocation(line: 123, column: 13, scope: !479)
!600 = !DILocation(line: 124, column: 7, scope: !474)
!601 = !DILocation(line: 107, column: 48, scope: !468)
!602 = !DILocation(line: 107, column: 7, scope: !468)
!603 = distinct !{!603, !472, !604, !134}
!604 = !DILocation(line: 124, column: 7, scope: !465)
!605 = !DILocation(line: 126, column: 14, scope: !606)
!606 = distinct !DILexicalBlock(scope: !356, file: !1, line: 126, column: 7)
!607 = !DILocation(line: 126, column: 12, scope: !606)
!608 = !DILocation(line: 126, column: 19, scope: !609)
!609 = distinct !DILexicalBlock(scope: !606, file: !1, line: 126, column: 7)
!610 = !DILocation(line: 126, column: 41, scope: !609)
!611 = !DILocation(line: 126, column: 23, scope: !609)
!612 = !DILocation(line: 126, column: 21, scope: !609)
!613 = !DILocation(line: 126, column: 7, scope: !606)
!614 = !DILocation(line: 127, column: 46, scope: !609)
!615 = !DILocation(line: 127, column: 28, scope: !609)
!616 = !DILocation(line: 127, column: 52, scope: !609)
!617 = !DILocation(line: 127, column: 16, scope: !609)
!618 = !DILocation(line: 127, column: 14, scope: !609)
!619 = !DILocation(line: 127, column: 10, scope: !609)
!620 = !DILocation(line: 126, column: 48, scope: !609)
!621 = !DILocation(line: 126, column: 7, scope: !609)
!622 = distinct !{!622, !613, !623, !134}
!623 = !DILocation(line: 127, column: 74, scope: !606)
!624 = !DILocation(line: 128, column: 4, scope: !356)
!625 = !DILocation(line: 88, column: 30, scope: !352)
!626 = !DILocation(line: 88, column: 4, scope: !352)
!627 = distinct !{!627, !354, !628, !134}
!628 = !DILocation(line: 128, column: 4, scope: !349)
!629 = !DILocation(line: 129, column: 1, scope: !317)
