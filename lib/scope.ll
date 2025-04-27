; ModuleID = 'mainloopScope.cpp'
source_filename = "mainloopScope.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<char>::_Alloc_hider" = type { i8* }
%union.anon = type { i64, [8 x i8] }
%"class.std::basic_ofstream" = type { %"class.std::basic_ostream.base", %"class.std::basic_filebuf", %"class.std::basic_ios" }
%"class.std::basic_ostream.base" = type { i32 (...)** }
%"class.std::basic_filebuf" = type { %"class.std::basic_streambuf", %union.pthread_mutex_t, %"class.std::__basic_file", i32, %struct.__mbstate_t, %struct.__mbstate_t, %struct.__mbstate_t, i8*, i64, i8, i8, i8, i8, i8*, i8*, i8, %"class.std::codecvt"*, i8*, i64, i8*, i8* }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%"class.std::__basic_file" = type <{ %struct._IO_FILE*, i8, [7 x i8] }>
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque
%struct.__mbstate_t = type { i32, %union.anon.0 }
%union.anon.0 = type { i32 }
%"class.std::codecvt" = type { %"class.std::__codecvt_abstract_base.base", %struct.__locale_struct* }
%"class.std::__codecvt_abstract_base.base" = type { %"class.std::locale::facet.base" }
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1, !dbg !0
@__dso_handle = external hidden global i8
@.str = private unnamed_addr constant [50 x i8] c"/workspace/LLVM-Checker/lib/Data/mainloopData.txt\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_mainloopScope.cpp, i8* null }]

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" !dbg !861 {
entry:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit), !dbg !862
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3, !dbg !864
  ret void, !dbg !862
}

declare dso_local void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #3

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) !dbg !865 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %mainloopbegin = alloca %"class.std::__cxx11::basic_string", align 8
  %mainloopend = alloca %"class.std::__cxx11::basic_string", align 8
  %funcName = alloca %"class.std::__cxx11::basic_string", align 8
  %exn.slot = alloca i8*, align 8
  %ehselector.slot = alloca i32, align 4
  %file = alloca %"class.std::basic_ofstream", align 8
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !868, metadata !DIExpression()), !dbg !869
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !870, metadata !DIExpression()), !dbg !871
  call void @llvm.dbg.declare(metadata %"class.std::__cxx11::basic_string"* %mainloopbegin, metadata !872, metadata !DIExpression()), !dbg !878
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopbegin) #3, !dbg !878
  call void @llvm.dbg.declare(metadata %"class.std::__cxx11::basic_string"* %mainloopend, metadata !879, metadata !DIExpression()), !dbg !880
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopend) #3, !dbg !880
  call void @llvm.dbg.declare(metadata %"class.std::__cxx11::basic_string"* %funcName, metadata !881, metadata !DIExpression()), !dbg !882
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %funcName) #3, !dbg !882
  %0 = load i32, i32* %argc.addr, align 4, !dbg !883
  %cmp = icmp sgt i32 %0, 3, !dbg !885
  br i1 %cmp, label %if.then, label %if.end, !dbg !886

if.then:                                          ; preds = %entry
  %1 = load i8**, i8*** %argv.addr, align 8, !dbg !887
  %arrayidx = getelementptr inbounds i8*, i8** %1, i64 1, !dbg !887
  %2 = load i8*, i8** %arrayidx, align 8, !dbg !887
  %call = invoke nonnull align 8 dereferenceable(32) %"class.std::__cxx11::basic_string"* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEaSEPKc(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopbegin, i8* %2)
          to label %invoke.cont unwind label %lpad, !dbg !889

invoke.cont:                                      ; preds = %if.then
  %3 = load i8**, i8*** %argv.addr, align 8, !dbg !890
  %arrayidx1 = getelementptr inbounds i8*, i8** %3, i64 2, !dbg !890
  %4 = load i8*, i8** %arrayidx1, align 8, !dbg !890
  %call3 = invoke nonnull align 8 dereferenceable(32) %"class.std::__cxx11::basic_string"* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEaSEPKc(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopend, i8* %4)
          to label %invoke.cont2 unwind label %lpad, !dbg !891

invoke.cont2:                                     ; preds = %invoke.cont
  %5 = load i8**, i8*** %argv.addr, align 8, !dbg !892
  %arrayidx4 = getelementptr inbounds i8*, i8** %5, i64 3, !dbg !892
  %6 = load i8*, i8** %arrayidx4, align 8, !dbg !892
  %call6 = invoke nonnull align 8 dereferenceable(32) %"class.std::__cxx11::basic_string"* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEaSEPKc(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %funcName, i8* %6)
          to label %invoke.cont5 unwind label %lpad, !dbg !893

invoke.cont5:                                     ; preds = %invoke.cont2
  br label %if.end, !dbg !894

lpad:                                             ; preds = %if.end, %invoke.cont2, %invoke.cont, %if.then
  %7 = landingpad { i8*, i32 }
          cleanup, !dbg !895
  %8 = extractvalue { i8*, i32 } %7, 0, !dbg !895
  store i8* %8, i8** %exn.slot, align 8, !dbg !895
  %9 = extractvalue { i8*, i32 } %7, 1, !dbg !895
  store i32 %9, i32* %ehselector.slot, align 4, !dbg !895
  br label %ehcleanup, !dbg !895

if.end:                                           ; preds = %invoke.cont5, %entry
  call void @llvm.dbg.declare(metadata %"class.std::basic_ofstream"* %file, metadata !896, metadata !DIExpression()), !dbg !901
  invoke void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248) %file, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str, i64 0, i64 0), i32 16)
          to label %invoke.cont7 unwind label %lpad, !dbg !901

invoke.cont7:                                     ; preds = %if.end
  %call10 = invoke zeroext i1 @_ZNSt14basic_ofstreamIcSt11char_traitsIcEE7is_openEv(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248) %file)
          to label %invoke.cont9 unwind label %lpad8, !dbg !902

invoke.cont9:                                     ; preds = %invoke.cont7
  br i1 %call10, label %if.then11, label %if.end25, !dbg !904

if.then11:                                        ; preds = %invoke.cont9
  %10 = bitcast %"class.std::basic_ofstream"* %file to %"class.std::basic_ostream"*, !dbg !905
  %call13 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %10, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopbegin)
          to label %invoke.cont12 unwind label %lpad8, !dbg !907

invoke.cont12:                                    ; preds = %if.then11
  %call15 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call13, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
          to label %invoke.cont14 unwind label %lpad8, !dbg !908

invoke.cont14:                                    ; preds = %invoke.cont12
  %call17 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call15, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopend)
          to label %invoke.cont16 unwind label %lpad8, !dbg !909

invoke.cont16:                                    ; preds = %invoke.cont14
  %call19 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call17, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
          to label %invoke.cont18 unwind label %lpad8, !dbg !910

invoke.cont18:                                    ; preds = %invoke.cont16
  %11 = bitcast %"class.std::basic_ofstream"* %file to %"class.std::basic_ostream"*, !dbg !911
  %call21 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %11, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %funcName)
          to label %invoke.cont20 unwind label %lpad8, !dbg !912

invoke.cont20:                                    ; preds = %invoke.cont18
  %call23 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call21, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
          to label %invoke.cont22 unwind label %lpad8, !dbg !913

invoke.cont22:                                    ; preds = %invoke.cont20
  invoke void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248) %file)
          to label %invoke.cont24 unwind label %lpad8, !dbg !914

invoke.cont24:                                    ; preds = %invoke.cont22
  br label %if.end25, !dbg !915

lpad8:                                            ; preds = %invoke.cont22, %invoke.cont20, %invoke.cont18, %invoke.cont16, %invoke.cont14, %invoke.cont12, %if.then11, %invoke.cont7
  %12 = landingpad { i8*, i32 }
          cleanup, !dbg !916
  %13 = extractvalue { i8*, i32 } %12, 0, !dbg !916
  store i8* %13, i8** %exn.slot, align 8, !dbg !916
  %14 = extractvalue { i8*, i32 } %12, 1, !dbg !916
  store i32 %14, i32* %ehselector.slot, align 4, !dbg !916
  call void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248) %file) #3, !dbg !917
  br label %ehcleanup, !dbg !917

if.end25:                                         ; preds = %invoke.cont24, %invoke.cont9
  store i32 0, i32* %retval, align 4, !dbg !918
  call void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248) %file) #3, !dbg !917
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %funcName) #3, !dbg !917
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopend) #3, !dbg !917
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopbegin) #3, !dbg !917
  %15 = load i32, i32* %retval, align 4, !dbg !917
  ret i32 %15, !dbg !917

ehcleanup:                                        ; preds = %lpad8, %lpad
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %funcName) #3, !dbg !917
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopend) #3, !dbg !917
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %mainloopbegin) #3, !dbg !917
  br label %eh.resume, !dbg !917

eh.resume:                                        ; preds = %ehcleanup
  %exn = load i8*, i8** %exn.slot, align 8, !dbg !917
  %sel = load i32, i32* %ehselector.slot, align 4, !dbg !917
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0, !dbg !917
  %lpad.val28 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1, !dbg !917
  resume { i8*, i32 } %lpad.val28, !dbg !917
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #5

; Function Attrs: nounwind
declare dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) unnamed_addr #2

declare dso_local nonnull align 8 dereferenceable(32) %"class.std::__cxx11::basic_string"* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEaSEPKc(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32), i8*) #1

declare dso_local i32 @__gxx_personality_v0(...)

declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248), i8*, i32) unnamed_addr #1

declare dso_local zeroext i1 @_ZNSt14basic_ofstreamIcSt11char_traitsIcEE7is_openEv(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248)) #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8*) #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) #1

declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248)) #1

; Function Attrs: nounwind
declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248)) unnamed_addr #2

; Function Attrs: nounwind
declare dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) unnamed_addr #2

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_mainloopScope.cpp() #0 section ".text.startup" !dbg !919 {
entry:
  call void @__cxx_global_var_init(), !dbg !921
  ret void
}

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!7}
!llvm.module.flags = !{!855, !856, !857, !858, !859}
!llvm.ident = !{!860}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "__ioinit", linkageName: "_ZStL8__ioinit", scope: !2, file: !3, line: 74, type: !4, isLocal: true, isDefinition: true)
!2 = !DINamespace(name: "std", scope: null)
!3 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/iostream", directory: "")
!4 = !DICompositeType(tag: DW_TAG_class_type, name: "Init", scope: !6, file: !5, line: 608, size: 8, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSNSt8ios_base4InitE")
!5 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/ios_base.h", directory: "")
!6 = !DICompositeType(tag: DW_TAG_class_type, name: "ios_base", scope: !2, file: !5, line: 228, size: 1728, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!7 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !8, producer: "Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !9, globals: !10, imports: !11, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!8 = !DIFile(filename: "mainloopScope.cpp", directory: "/workspace/LLVM-Checker/lib")
!9 = !{}
!10 = !{!0}
!11 = !{!12, !32, !35, !40, !48, !56, !60, !67, !71, !75, !77, !79, !83, !95, !99, !105, !111, !113, !117, !121, !125, !129, !141, !143, !147, !151, !155, !157, !163, !167, !171, !173, !175, !179, !187, !191, !195, !199, !201, !207, !209, !216, !221, !225, !230, !234, !238, !242, !244, !246, !250, !254, !258, !260, !264, !268, !270, !272, !276, !282, !287, !292, !293, !294, !295, !296, !297, !298, !299, !300, !301, !302, !306, !310, !314, !321, !325, !328, !331, !334, !336, !338, !340, !343, !346, !349, !352, !355, !357, !362, !366, !369, !372, !374, !376, !378, !380, !383, !386, !389, !392, !395, !397, !401, !405, !410, !416, !418, !420, !422, !424, !426, !428, !430, !432, !434, !436, !438, !440, !442, !446, !448, !452, !456, !462, !466, !471, !473, !477, !481, !485, !495, !499, !503, !507, !511, !515, !519, !523, !527, !531, !535, !539, !543, !545, !549, !553, !557, !563, !567, !571, !573, !577, !581, !587, !589, !593, !597, !601, !605, !609, !613, !617, !618, !619, !620, !622, !623, !624, !625, !626, !627, !628, !632, !638, !643, !647, !649, !651, !653, !655, !662, !666, !670, !674, !678, !682, !687, !691, !693, !697, !703, !707, !712, !714, !716, !720, !724, !726, !728, !730, !732, !736, !738, !740, !744, !748, !752, !756, !760, !764, !766, !770, !774, !778, !782, !784, !786, !790, !794, !795, !796, !797, !798, !799, !805, !808, !809, !811, !813, !815, !817, !821, !823, !825, !827, !829, !831, !833, !835, !837, !841, !845, !847, !851}
!12 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !13, file: !31, line: 64)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "mbstate_t", file: !14, line: 6, baseType: !15)
!14 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/mbstate_t.h", directory: "")
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mbstate_t", file: !16, line: 21, baseType: !17)
!16 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h", directory: "")
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !16, line: 13, size: 64, flags: DIFlagTypePassByValue, elements: !18, identifier: "_ZTS11__mbstate_t")
!18 = !{!19, !21}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "__count", scope: !17, file: !16, line: 15, baseType: !20, size: 32)
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "__value", scope: !17, file: !16, line: 20, baseType: !22, size: 32, offset: 32)
!22 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !17, file: !16, line: 16, size: 32, flags: DIFlagTypePassByValue, elements: !23, identifier: "_ZTSN11__mbstate_tUt_E")
!23 = !{!24, !26}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "__wch", scope: !22, file: !16, line: 18, baseType: !25, size: 32)
!25 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "__wchb", scope: !22, file: !16, line: 19, baseType: !27, size: 32)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 32, elements: !29)
!28 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!29 = !{!30}
!30 = !DISubrange(count: 4)
!31 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cwchar", directory: "")
!32 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !33, file: !31, line: 141)
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "wint_t", file: !34, line: 20, baseType: !25)
!34 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/wint_t.h", directory: "")
!35 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !36, file: !31, line: 143)
!36 = !DISubprogram(name: "btowc", scope: !37, file: !37, line: 284, type: !38, flags: DIFlagPrototyped, spFlags: 0)
!37 = !DIFile(filename: "/usr/include/wchar.h", directory: "")
!38 = !DISubroutineType(types: !39)
!39 = !{!33, !20}
!40 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !41, file: !31, line: 144)
!41 = !DISubprogram(name: "fgetwc", scope: !37, file: !37, line: 726, type: !42, flags: DIFlagPrototyped, spFlags: 0)
!42 = !DISubroutineType(types: !43)
!43 = !{!33, !44}
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = !DIDerivedType(tag: DW_TAG_typedef, name: "__FILE", file: !46, line: 5, baseType: !47)
!46 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__FILE.h", directory: "")
!47 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !46, line: 4, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS8_IO_FILE")
!48 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !49, file: !31, line: 145)
!49 = !DISubprogram(name: "fgetws", scope: !37, file: !37, line: 755, type: !50, flags: DIFlagPrototyped, spFlags: 0)
!50 = !DISubroutineType(types: !51)
!51 = !{!52, !54, !20, !55}
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!54 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !52)
!55 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !44)
!56 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !57, file: !31, line: 146)
!57 = !DISubprogram(name: "fputwc", scope: !37, file: !37, line: 740, type: !58, flags: DIFlagPrototyped, spFlags: 0)
!58 = !DISubroutineType(types: !59)
!59 = !{!33, !53, !44}
!60 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !61, file: !31, line: 147)
!61 = !DISubprogram(name: "fputws", scope: !37, file: !37, line: 762, type: !62, flags: DIFlagPrototyped, spFlags: 0)
!62 = !DISubroutineType(types: !63)
!63 = !{!20, !64, !55}
!64 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !65)
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !66, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !53)
!67 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !68, file: !31, line: 148)
!68 = !DISubprogram(name: "fwide", scope: !37, file: !37, line: 573, type: !69, flags: DIFlagPrototyped, spFlags: 0)
!69 = !DISubroutineType(types: !70)
!70 = !{!20, !44, !20}
!71 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !72, file: !31, line: 149)
!72 = !DISubprogram(name: "fwprintf", scope: !37, file: !37, line: 580, type: !73, flags: DIFlagPrototyped, spFlags: 0)
!73 = !DISubroutineType(types: !74)
!74 = !{!20, !55, !64, null}
!75 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !76, file: !31, line: 150)
!76 = !DISubprogram(name: "fwscanf", linkageName: "__isoc99_fwscanf", scope: !37, file: !37, line: 640, type: !73, flags: DIFlagPrototyped, spFlags: 0)
!77 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !78, file: !31, line: 151)
!78 = !DISubprogram(name: "getwc", scope: !37, file: !37, line: 727, type: !42, flags: DIFlagPrototyped, spFlags: 0)
!79 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !80, file: !31, line: 152)
!80 = !DISubprogram(name: "getwchar", scope: !37, file: !37, line: 733, type: !81, flags: DIFlagPrototyped, spFlags: 0)
!81 = !DISubroutineType(types: !82)
!82 = !{!33}
!83 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !84, file: !31, line: 153)
!84 = !DISubprogram(name: "mbrlen", scope: !37, file: !37, line: 307, type: !85, flags: DIFlagPrototyped, spFlags: 0)
!85 = !DISubroutineType(types: !86)
!86 = !{!87, !90, !87, !93}
!87 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !88, line: 46, baseType: !89)
!88 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/stddef.h", directory: "")
!89 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!90 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !91)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !28)
!93 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !94)
!94 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!95 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !96, file: !31, line: 154)
!96 = !DISubprogram(name: "mbrtowc", scope: !37, file: !37, line: 296, type: !97, flags: DIFlagPrototyped, spFlags: 0)
!97 = !DISubroutineType(types: !98)
!98 = !{!87, !54, !90, !87, !93}
!99 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !100, file: !31, line: 155)
!100 = !DISubprogram(name: "mbsinit", scope: !37, file: !37, line: 292, type: !101, flags: DIFlagPrototyped, spFlags: 0)
!101 = !DISubroutineType(types: !102)
!102 = !{!20, !103}
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!105 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !106, file: !31, line: 156)
!106 = !DISubprogram(name: "mbsrtowcs", scope: !37, file: !37, line: 337, type: !107, flags: DIFlagPrototyped, spFlags: 0)
!107 = !DISubroutineType(types: !108)
!108 = !{!87, !54, !109, !87, !93}
!109 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !110)
!110 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 64)
!111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !112, file: !31, line: 157)
!112 = !DISubprogram(name: "putwc", scope: !37, file: !37, line: 741, type: !58, flags: DIFlagPrototyped, spFlags: 0)
!113 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !114, file: !31, line: 158)
!114 = !DISubprogram(name: "putwchar", scope: !37, file: !37, line: 747, type: !115, flags: DIFlagPrototyped, spFlags: 0)
!115 = !DISubroutineType(types: !116)
!116 = !{!33, !53}
!117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !118, file: !31, line: 160)
!118 = !DISubprogram(name: "swprintf", scope: !37, file: !37, line: 590, type: !119, flags: DIFlagPrototyped, spFlags: 0)
!119 = !DISubroutineType(types: !120)
!120 = !{!20, !54, !87, !64, null}
!121 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !122, file: !31, line: 162)
!122 = !DISubprogram(name: "swscanf", linkageName: "__isoc99_swscanf", scope: !37, file: !37, line: 647, type: !123, flags: DIFlagPrototyped, spFlags: 0)
!123 = !DISubroutineType(types: !124)
!124 = !{!20, !64, !64, null}
!125 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !126, file: !31, line: 163)
!126 = !DISubprogram(name: "ungetwc", scope: !37, file: !37, line: 770, type: !127, flags: DIFlagPrototyped, spFlags: 0)
!127 = !DISubroutineType(types: !128)
!128 = !{!33, !33, !44}
!129 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !130, file: !31, line: 164)
!130 = !DISubprogram(name: "vfwprintf", scope: !37, file: !37, line: 598, type: !131, flags: DIFlagPrototyped, spFlags: 0)
!131 = !DISubroutineType(types: !132)
!132 = !{!20, !55, !64, !133}
!133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 64)
!134 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", size: 192, flags: DIFlagTypePassByValue, elements: !135, identifier: "_ZTS13__va_list_tag")
!135 = !{!136, !137, !138, !140}
!136 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !134, file: !8, baseType: !25, size: 32)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !134, file: !8, baseType: !25, size: 32, offset: 32)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !134, file: !8, baseType: !139, size: 64, offset: 64)
!139 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !134, file: !8, baseType: !139, size: 64, offset: 128)
!141 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !142, file: !31, line: 166)
!142 = !DISubprogram(name: "vfwscanf", linkageName: "__isoc99_vfwscanf", scope: !37, file: !37, line: 693, type: !131, flags: DIFlagPrototyped, spFlags: 0)
!143 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !144, file: !31, line: 169)
!144 = !DISubprogram(name: "vswprintf", scope: !37, file: !37, line: 611, type: !145, flags: DIFlagPrototyped, spFlags: 0)
!145 = !DISubroutineType(types: !146)
!146 = !{!20, !54, !87, !64, !133}
!147 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !148, file: !31, line: 172)
!148 = !DISubprogram(name: "vswscanf", linkageName: "__isoc99_vswscanf", scope: !37, file: !37, line: 700, type: !149, flags: DIFlagPrototyped, spFlags: 0)
!149 = !DISubroutineType(types: !150)
!150 = !{!20, !64, !64, !133}
!151 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !152, file: !31, line: 174)
!152 = !DISubprogram(name: "vwprintf", scope: !37, file: !37, line: 606, type: !153, flags: DIFlagPrototyped, spFlags: 0)
!153 = !DISubroutineType(types: !154)
!154 = !{!20, !64, !133}
!155 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !156, file: !31, line: 176)
!156 = !DISubprogram(name: "vwscanf", linkageName: "__isoc99_vwscanf", scope: !37, file: !37, line: 697, type: !153, flags: DIFlagPrototyped, spFlags: 0)
!157 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !158, file: !31, line: 178)
!158 = !DISubprogram(name: "wcrtomb", scope: !37, file: !37, line: 301, type: !159, flags: DIFlagPrototyped, spFlags: 0)
!159 = !DISubroutineType(types: !160)
!160 = !{!87, !161, !53, !93}
!161 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !162)
!162 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!163 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !164, file: !31, line: 179)
!164 = !DISubprogram(name: "wcscat", scope: !37, file: !37, line: 97, type: !165, flags: DIFlagPrototyped, spFlags: 0)
!165 = !DISubroutineType(types: !166)
!166 = !{!52, !54, !64}
!167 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !168, file: !31, line: 180)
!168 = !DISubprogram(name: "wcscmp", scope: !37, file: !37, line: 106, type: !169, flags: DIFlagPrototyped, spFlags: 0)
!169 = !DISubroutineType(types: !170)
!170 = !{!20, !65, !65}
!171 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !172, file: !31, line: 181)
!172 = !DISubprogram(name: "wcscoll", scope: !37, file: !37, line: 131, type: !169, flags: DIFlagPrototyped, spFlags: 0)
!173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !174, file: !31, line: 182)
!174 = !DISubprogram(name: "wcscpy", scope: !37, file: !37, line: 87, type: !165, flags: DIFlagPrototyped, spFlags: 0)
!175 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !176, file: !31, line: 183)
!176 = !DISubprogram(name: "wcscspn", scope: !37, file: !37, line: 187, type: !177, flags: DIFlagPrototyped, spFlags: 0)
!177 = !DISubroutineType(types: !178)
!178 = !{!87, !65, !65}
!179 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !180, file: !31, line: 184)
!180 = !DISubprogram(name: "wcsftime", scope: !37, file: !37, line: 834, type: !181, flags: DIFlagPrototyped, spFlags: 0)
!181 = !DISubroutineType(types: !182)
!182 = !{!87, !54, !87, !64, !183}
!183 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !184)
!184 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !185, size: 64)
!185 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !186)
!186 = !DICompositeType(tag: DW_TAG_structure_type, name: "tm", file: !37, line: 83, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS2tm")
!187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !188, file: !31, line: 185)
!188 = !DISubprogram(name: "wcslen", scope: !37, file: !37, line: 222, type: !189, flags: DIFlagPrototyped, spFlags: 0)
!189 = !DISubroutineType(types: !190)
!190 = !{!87, !65}
!191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !192, file: !31, line: 186)
!192 = !DISubprogram(name: "wcsncat", scope: !37, file: !37, line: 101, type: !193, flags: DIFlagPrototyped, spFlags: 0)
!193 = !DISubroutineType(types: !194)
!194 = !{!52, !54, !64, !87}
!195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !196, file: !31, line: 187)
!196 = !DISubprogram(name: "wcsncmp", scope: !37, file: !37, line: 109, type: !197, flags: DIFlagPrototyped, spFlags: 0)
!197 = !DISubroutineType(types: !198)
!198 = !{!20, !65, !65, !87}
!199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !200, file: !31, line: 188)
!200 = !DISubprogram(name: "wcsncpy", scope: !37, file: !37, line: 92, type: !193, flags: DIFlagPrototyped, spFlags: 0)
!201 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !202, file: !31, line: 189)
!202 = !DISubprogram(name: "wcsrtombs", scope: !37, file: !37, line: 343, type: !203, flags: DIFlagPrototyped, spFlags: 0)
!203 = !DISubroutineType(types: !204)
!204 = !{!87, !161, !205, !87, !93}
!205 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !206)
!206 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!207 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !208, file: !31, line: 190)
!208 = !DISubprogram(name: "wcsspn", scope: !37, file: !37, line: 191, type: !177, flags: DIFlagPrototyped, spFlags: 0)
!209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !210, file: !31, line: 191)
!210 = !DISubprogram(name: "wcstod", scope: !37, file: !37, line: 377, type: !211, flags: DIFlagPrototyped, spFlags: 0)
!211 = !DISubroutineType(types: !212)
!212 = !{!213, !64, !214}
!213 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!214 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !215)
!215 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !217, file: !31, line: 193)
!217 = !DISubprogram(name: "wcstof", scope: !37, file: !37, line: 382, type: !218, flags: DIFlagPrototyped, spFlags: 0)
!218 = !DISubroutineType(types: !219)
!219 = !{!220, !64, !214}
!220 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!221 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !222, file: !31, line: 195)
!222 = !DISubprogram(name: "wcstok", scope: !37, file: !37, line: 217, type: !223, flags: DIFlagPrototyped, spFlags: 0)
!223 = !DISubroutineType(types: !224)
!224 = !{!52, !54, !64, !214}
!225 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !226, file: !31, line: 196)
!226 = !DISubprogram(name: "wcstol", scope: !37, file: !37, line: 428, type: !227, flags: DIFlagPrototyped, spFlags: 0)
!227 = !DISubroutineType(types: !228)
!228 = !{!229, !64, !214, !20}
!229 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!230 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !231, file: !31, line: 197)
!231 = !DISubprogram(name: "wcstoul", scope: !37, file: !37, line: 433, type: !232, flags: DIFlagPrototyped, spFlags: 0)
!232 = !DISubroutineType(types: !233)
!233 = !{!89, !64, !214, !20}
!234 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !235, file: !31, line: 198)
!235 = !DISubprogram(name: "wcsxfrm", scope: !37, file: !37, line: 135, type: !236, flags: DIFlagPrototyped, spFlags: 0)
!236 = !DISubroutineType(types: !237)
!237 = !{!87, !54, !64, !87}
!238 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !239, file: !31, line: 199)
!239 = !DISubprogram(name: "wctob", scope: !37, file: !37, line: 288, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!240 = !DISubroutineType(types: !241)
!241 = !{!20, !33}
!242 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !243, file: !31, line: 200)
!243 = !DISubprogram(name: "wmemcmp", scope: !37, file: !37, line: 258, type: !197, flags: DIFlagPrototyped, spFlags: 0)
!244 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !245, file: !31, line: 201)
!245 = !DISubprogram(name: "wmemcpy", scope: !37, file: !37, line: 262, type: !193, flags: DIFlagPrototyped, spFlags: 0)
!246 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !247, file: !31, line: 202)
!247 = !DISubprogram(name: "wmemmove", scope: !37, file: !37, line: 267, type: !248, flags: DIFlagPrototyped, spFlags: 0)
!248 = !DISubroutineType(types: !249)
!249 = !{!52, !52, !65, !87}
!250 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !251, file: !31, line: 203)
!251 = !DISubprogram(name: "wmemset", scope: !37, file: !37, line: 271, type: !252, flags: DIFlagPrototyped, spFlags: 0)
!252 = !DISubroutineType(types: !253)
!253 = !{!52, !52, !53, !87}
!254 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !255, file: !31, line: 204)
!255 = !DISubprogram(name: "wprintf", scope: !37, file: !37, line: 587, type: !256, flags: DIFlagPrototyped, spFlags: 0)
!256 = !DISubroutineType(types: !257)
!257 = !{!20, !64, null}
!258 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !259, file: !31, line: 205)
!259 = !DISubprogram(name: "wscanf", linkageName: "__isoc99_wscanf", scope: !37, file: !37, line: 644, type: !256, flags: DIFlagPrototyped, spFlags: 0)
!260 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !261, file: !31, line: 206)
!261 = !DISubprogram(name: "wcschr", scope: !37, file: !37, line: 164, type: !262, flags: DIFlagPrototyped, spFlags: 0)
!262 = !DISubroutineType(types: !263)
!263 = !{!52, !65, !53}
!264 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !265, file: !31, line: 207)
!265 = !DISubprogram(name: "wcspbrk", scope: !37, file: !37, line: 201, type: !266, flags: DIFlagPrototyped, spFlags: 0)
!266 = !DISubroutineType(types: !267)
!267 = !{!52, !65, !65}
!268 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !269, file: !31, line: 208)
!269 = !DISubprogram(name: "wcsrchr", scope: !37, file: !37, line: 174, type: !262, flags: DIFlagPrototyped, spFlags: 0)
!270 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !271, file: !31, line: 209)
!271 = !DISubprogram(name: "wcsstr", scope: !37, file: !37, line: 212, type: !266, flags: DIFlagPrototyped, spFlags: 0)
!272 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !273, file: !31, line: 210)
!273 = !DISubprogram(name: "wmemchr", scope: !37, file: !37, line: 253, type: !274, flags: DIFlagPrototyped, spFlags: 0)
!274 = !DISubroutineType(types: !275)
!275 = !{!52, !65, !53, !87}
!276 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !278, file: !31, line: 251)
!277 = !DINamespace(name: "__gnu_cxx", scope: null)
!278 = !DISubprogram(name: "wcstold", scope: !37, file: !37, line: 384, type: !279, flags: DIFlagPrototyped, spFlags: 0)
!279 = !DISubroutineType(types: !280)
!280 = !{!281, !64, !214}
!281 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!282 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !283, file: !31, line: 260)
!283 = !DISubprogram(name: "wcstoll", scope: !37, file: !37, line: 441, type: !284, flags: DIFlagPrototyped, spFlags: 0)
!284 = !DISubroutineType(types: !285)
!285 = !{!286, !64, !214, !20}
!286 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!287 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !288, file: !31, line: 261)
!288 = !DISubprogram(name: "wcstoull", scope: !37, file: !37, line: 448, type: !289, flags: DIFlagPrototyped, spFlags: 0)
!289 = !DISubroutineType(types: !290)
!290 = !{!291, !64, !214, !20}
!291 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!292 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !278, file: !31, line: 267)
!293 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !283, file: !31, line: 268)
!294 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !288, file: !31, line: 269)
!295 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !217, file: !31, line: 283)
!296 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !142, file: !31, line: 286)
!297 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !148, file: !31, line: 289)
!298 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !156, file: !31, line: 292)
!299 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !278, file: !31, line: 296)
!300 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !283, file: !31, line: 297)
!301 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !288, file: !31, line: 298)
!302 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !303, file: !304, line: 57)
!303 = !DICompositeType(tag: DW_TAG_class_type, name: "exception_ptr", scope: !305, file: !304, line: 79, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSNSt15__exception_ptr13exception_ptrE")
!304 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/exception_ptr.h", directory: "")
!305 = !DINamespace(name: "__exception_ptr", scope: !2)
!306 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !305, entity: !307, file: !304, line: 73)
!307 = !DISubprogram(name: "rethrow_exception", linkageName: "_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE", scope: !2, file: !304, line: 69, type: !308, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!308 = !DISubroutineType(types: !309)
!309 = !{null, !303}
!310 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !311, entity: !312, file: !313, line: 58)
!311 = !DINamespace(name: "__gnu_debug", scope: null)
!312 = !DINamespace(name: "__debug", scope: !2)
!313 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/debug/debug.h", directory: "")
!314 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !315, file: !320, line: 47)
!315 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !316, line: 24, baseType: !317)
!316 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "")
!317 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !318, line: 37, baseType: !319)
!318 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!319 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!320 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdint", directory: "")
!321 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !322, file: !320, line: 48)
!322 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !316, line: 25, baseType: !323)
!323 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !318, line: 39, baseType: !324)
!324 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!325 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !326, file: !320, line: 49)
!326 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !316, line: 26, baseType: !327)
!327 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !318, line: 41, baseType: !20)
!328 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !329, file: !320, line: 50)
!329 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !316, line: 27, baseType: !330)
!330 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !318, line: 44, baseType: !229)
!331 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !332, file: !320, line: 52)
!332 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !333, line: 58, baseType: !319)
!333 = !DIFile(filename: "/usr/include/stdint.h", directory: "")
!334 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !335, file: !320, line: 53)
!335 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !333, line: 60, baseType: !229)
!336 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !337, file: !320, line: 54)
!337 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !333, line: 61, baseType: !229)
!338 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !339, file: !320, line: 55)
!339 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !333, line: 62, baseType: !229)
!340 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !341, file: !320, line: 57)
!341 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !333, line: 43, baseType: !342)
!342 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least8_t", file: !318, line: 52, baseType: !317)
!343 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !344, file: !320, line: 58)
!344 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !333, line: 44, baseType: !345)
!345 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least16_t", file: !318, line: 54, baseType: !323)
!346 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !347, file: !320, line: 59)
!347 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !333, line: 45, baseType: !348)
!348 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least32_t", file: !318, line: 56, baseType: !327)
!349 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !350, file: !320, line: 60)
!350 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !333, line: 46, baseType: !351)
!351 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least64_t", file: !318, line: 58, baseType: !330)
!352 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !353, file: !320, line: 62)
!353 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !333, line: 101, baseType: !354)
!354 = !DIDerivedType(tag: DW_TAG_typedef, name: "__intmax_t", file: !318, line: 72, baseType: !229)
!355 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !356, file: !320, line: 63)
!356 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !333, line: 87, baseType: !229)
!357 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !358, file: !320, line: 65)
!358 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !359, line: 24, baseType: !360)
!359 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "")
!360 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !318, line: 38, baseType: !361)
!361 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!362 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !363, file: !320, line: 66)
!363 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !359, line: 25, baseType: !364)
!364 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !318, line: 40, baseType: !365)
!365 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!366 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !367, file: !320, line: 67)
!367 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !359, line: 26, baseType: !368)
!368 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !318, line: 42, baseType: !25)
!369 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !370, file: !320, line: 68)
!370 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !359, line: 27, baseType: !371)
!371 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !318, line: 45, baseType: !89)
!372 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !373, file: !320, line: 70)
!373 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !333, line: 71, baseType: !361)
!374 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !375, file: !320, line: 71)
!375 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !333, line: 73, baseType: !89)
!376 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !377, file: !320, line: 72)
!377 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !333, line: 74, baseType: !89)
!378 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !379, file: !320, line: 73)
!379 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !333, line: 75, baseType: !89)
!380 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !381, file: !320, line: 75)
!381 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !333, line: 49, baseType: !382)
!382 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least8_t", file: !318, line: 53, baseType: !360)
!383 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !384, file: !320, line: 76)
!384 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !333, line: 50, baseType: !385)
!385 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least16_t", file: !318, line: 55, baseType: !364)
!386 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !387, file: !320, line: 77)
!387 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !333, line: 51, baseType: !388)
!388 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least32_t", file: !318, line: 57, baseType: !368)
!389 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !390, file: !320, line: 78)
!390 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !333, line: 52, baseType: !391)
!391 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least64_t", file: !318, line: 59, baseType: !371)
!392 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !393, file: !320, line: 80)
!393 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !333, line: 102, baseType: !394)
!394 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uintmax_t", file: !318, line: 73, baseType: !89)
!395 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !396, file: !320, line: 81)
!396 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !333, line: 90, baseType: !89)
!397 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !398, file: !400, line: 53)
!398 = !DICompositeType(tag: DW_TAG_structure_type, name: "lconv", file: !399, line: 51, size: 768, flags: DIFlagFwdDecl, identifier: "_ZTS5lconv")
!399 = !DIFile(filename: "/usr/include/locale.h", directory: "")
!400 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/clocale", directory: "")
!401 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !402, file: !400, line: 54)
!402 = !DISubprogram(name: "setlocale", scope: !399, file: !399, line: 122, type: !403, flags: DIFlagPrototyped, spFlags: 0)
!403 = !DISubroutineType(types: !404)
!404 = !{!162, !20, !91}
!405 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !406, file: !400, line: 55)
!406 = !DISubprogram(name: "localeconv", scope: !399, file: !399, line: 125, type: !407, flags: DIFlagPrototyped, spFlags: 0)
!407 = !DISubroutineType(types: !408)
!408 = !{!409}
!409 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !398, size: 64)
!410 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !411, file: !415, line: 64)
!411 = !DISubprogram(name: "isalnum", scope: !412, file: !412, line: 108, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!412 = !DIFile(filename: "/usr/include/ctype.h", directory: "")
!413 = !DISubroutineType(types: !414)
!414 = !{!20, !20}
!415 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cctype", directory: "")
!416 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !417, file: !415, line: 65)
!417 = !DISubprogram(name: "isalpha", scope: !412, file: !412, line: 109, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!418 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !419, file: !415, line: 66)
!419 = !DISubprogram(name: "iscntrl", scope: !412, file: !412, line: 110, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!420 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !421, file: !415, line: 67)
!421 = !DISubprogram(name: "isdigit", scope: !412, file: !412, line: 111, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!422 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !423, file: !415, line: 68)
!423 = !DISubprogram(name: "isgraph", scope: !412, file: !412, line: 113, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!424 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !425, file: !415, line: 69)
!425 = !DISubprogram(name: "islower", scope: !412, file: !412, line: 112, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!426 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !427, file: !415, line: 70)
!427 = !DISubprogram(name: "isprint", scope: !412, file: !412, line: 114, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!428 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !429, file: !415, line: 71)
!429 = !DISubprogram(name: "ispunct", scope: !412, file: !412, line: 115, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!430 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !431, file: !415, line: 72)
!431 = !DISubprogram(name: "isspace", scope: !412, file: !412, line: 116, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!432 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !433, file: !415, line: 73)
!433 = !DISubprogram(name: "isupper", scope: !412, file: !412, line: 117, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!434 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !435, file: !415, line: 74)
!435 = !DISubprogram(name: "isxdigit", scope: !412, file: !412, line: 118, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!436 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !437, file: !415, line: 75)
!437 = !DISubprogram(name: "tolower", scope: !412, file: !412, line: 122, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!438 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !439, file: !415, line: 76)
!439 = !DISubprogram(name: "toupper", scope: !412, file: !412, line: 125, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!440 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !441, file: !415, line: 87)
!441 = !DISubprogram(name: "isblank", scope: !412, file: !412, line: 130, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!442 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !443, file: !445, line: 44)
!443 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", scope: !2, file: !444, line: 258, baseType: !89)
!444 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/x86_64-linux-gnu/c++/9/bits/c++config.h", directory: "")
!445 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/ext/new_allocator.h", directory: "")
!446 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !447, file: !445, line: 45)
!447 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", scope: !2, file: !444, line: 259, baseType: !229)
!448 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !449, file: !451, line: 52)
!449 = !DISubprogram(name: "abs", scope: !450, file: !450, line: 840, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!450 = !DIFile(filename: "/usr/include/stdlib.h", directory: "")
!451 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/std_abs.h", directory: "")
!452 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !453, file: !455, line: 127)
!453 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !450, line: 62, baseType: !454)
!454 = !DICompositeType(tag: DW_TAG_structure_type, file: !450, line: 58, size: 64, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!455 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdlib", directory: "")
!456 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !457, file: !455, line: 128)
!457 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !450, line: 70, baseType: !458)
!458 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !450, line: 66, size: 128, flags: DIFlagTypePassByValue, elements: !459, identifier: "_ZTS6ldiv_t")
!459 = !{!460, !461}
!460 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !458, file: !450, line: 68, baseType: !229, size: 64)
!461 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !458, file: !450, line: 69, baseType: !229, size: 64, offset: 64)
!462 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !463, file: !455, line: 130)
!463 = !DISubprogram(name: "abort", scope: !450, file: !450, line: 591, type: !464, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!464 = !DISubroutineType(types: !465)
!465 = !{null}
!466 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !467, file: !455, line: 134)
!467 = !DISubprogram(name: "atexit", scope: !450, file: !450, line: 595, type: !468, flags: DIFlagPrototyped, spFlags: 0)
!468 = !DISubroutineType(types: !469)
!469 = !{!20, !470}
!470 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !464, size: 64)
!471 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !472, file: !455, line: 137)
!472 = !DISubprogram(name: "at_quick_exit", scope: !450, file: !450, line: 600, type: !468, flags: DIFlagPrototyped, spFlags: 0)
!473 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !474, file: !455, line: 140)
!474 = !DISubprogram(name: "atof", scope: !450, file: !450, line: 101, type: !475, flags: DIFlagPrototyped, spFlags: 0)
!475 = !DISubroutineType(types: !476)
!476 = !{!213, !91}
!477 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !478, file: !455, line: 141)
!478 = !DISubprogram(name: "atoi", scope: !450, file: !450, line: 104, type: !479, flags: DIFlagPrototyped, spFlags: 0)
!479 = !DISubroutineType(types: !480)
!480 = !{!20, !91}
!481 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !482, file: !455, line: 142)
!482 = !DISubprogram(name: "atol", scope: !450, file: !450, line: 107, type: !483, flags: DIFlagPrototyped, spFlags: 0)
!483 = !DISubroutineType(types: !484)
!484 = !{!229, !91}
!485 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !486, file: !455, line: 143)
!486 = !DISubprogram(name: "bsearch", scope: !450, file: !450, line: 820, type: !487, flags: DIFlagPrototyped, spFlags: 0)
!487 = !DISubroutineType(types: !488)
!488 = !{!139, !489, !489, !87, !87, !491}
!489 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !490, size: 64)
!490 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!491 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !450, line: 808, baseType: !492)
!492 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !493, size: 64)
!493 = !DISubroutineType(types: !494)
!494 = !{!20, !489, !489}
!495 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !496, file: !455, line: 144)
!496 = !DISubprogram(name: "calloc", scope: !450, file: !450, line: 542, type: !497, flags: DIFlagPrototyped, spFlags: 0)
!497 = !DISubroutineType(types: !498)
!498 = !{!139, !87, !87}
!499 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !500, file: !455, line: 145)
!500 = !DISubprogram(name: "div", scope: !450, file: !450, line: 852, type: !501, flags: DIFlagPrototyped, spFlags: 0)
!501 = !DISubroutineType(types: !502)
!502 = !{!453, !20, !20}
!503 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !504, file: !455, line: 146)
!504 = !DISubprogram(name: "exit", scope: !450, file: !450, line: 617, type: !505, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!505 = !DISubroutineType(types: !506)
!506 = !{null, !20}
!507 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !508, file: !455, line: 147)
!508 = !DISubprogram(name: "free", scope: !450, file: !450, line: 565, type: !509, flags: DIFlagPrototyped, spFlags: 0)
!509 = !DISubroutineType(types: !510)
!510 = !{null, !139}
!511 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !512, file: !455, line: 148)
!512 = !DISubprogram(name: "getenv", scope: !450, file: !450, line: 634, type: !513, flags: DIFlagPrototyped, spFlags: 0)
!513 = !DISubroutineType(types: !514)
!514 = !{!162, !91}
!515 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !516, file: !455, line: 149)
!516 = !DISubprogram(name: "labs", scope: !450, file: !450, line: 841, type: !517, flags: DIFlagPrototyped, spFlags: 0)
!517 = !DISubroutineType(types: !518)
!518 = !{!229, !229}
!519 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !520, file: !455, line: 150)
!520 = !DISubprogram(name: "ldiv", scope: !450, file: !450, line: 854, type: !521, flags: DIFlagPrototyped, spFlags: 0)
!521 = !DISubroutineType(types: !522)
!522 = !{!457, !229, !229}
!523 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !524, file: !455, line: 151)
!524 = !DISubprogram(name: "malloc", scope: !450, file: !450, line: 539, type: !525, flags: DIFlagPrototyped, spFlags: 0)
!525 = !DISubroutineType(types: !526)
!526 = !{!139, !87}
!527 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !528, file: !455, line: 153)
!528 = !DISubprogram(name: "mblen", scope: !450, file: !450, line: 922, type: !529, flags: DIFlagPrototyped, spFlags: 0)
!529 = !DISubroutineType(types: !530)
!530 = !{!20, !91, !87}
!531 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !532, file: !455, line: 154)
!532 = !DISubprogram(name: "mbstowcs", scope: !450, file: !450, line: 933, type: !533, flags: DIFlagPrototyped, spFlags: 0)
!533 = !DISubroutineType(types: !534)
!534 = !{!87, !54, !90, !87}
!535 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !536, file: !455, line: 155)
!536 = !DISubprogram(name: "mbtowc", scope: !450, file: !450, line: 925, type: !537, flags: DIFlagPrototyped, spFlags: 0)
!537 = !DISubroutineType(types: !538)
!538 = !{!20, !54, !90, !87}
!539 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !540, file: !455, line: 157)
!540 = !DISubprogram(name: "qsort", scope: !450, file: !450, line: 830, type: !541, flags: DIFlagPrototyped, spFlags: 0)
!541 = !DISubroutineType(types: !542)
!542 = !{null, !139, !87, !87, !491}
!543 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !544, file: !455, line: 160)
!544 = !DISubprogram(name: "quick_exit", scope: !450, file: !450, line: 623, type: !505, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!545 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !546, file: !455, line: 163)
!546 = !DISubprogram(name: "rand", scope: !450, file: !450, line: 453, type: !547, flags: DIFlagPrototyped, spFlags: 0)
!547 = !DISubroutineType(types: !548)
!548 = !{!20}
!549 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !550, file: !455, line: 164)
!550 = !DISubprogram(name: "realloc", scope: !450, file: !450, line: 550, type: !551, flags: DIFlagPrototyped, spFlags: 0)
!551 = !DISubroutineType(types: !552)
!552 = !{!139, !139, !87}
!553 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !554, file: !455, line: 165)
!554 = !DISubprogram(name: "srand", scope: !450, file: !450, line: 455, type: !555, flags: DIFlagPrototyped, spFlags: 0)
!555 = !DISubroutineType(types: !556)
!556 = !{null, !25}
!557 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !558, file: !455, line: 166)
!558 = !DISubprogram(name: "strtod", scope: !450, file: !450, line: 117, type: !559, flags: DIFlagPrototyped, spFlags: 0)
!559 = !DISubroutineType(types: !560)
!560 = !{!213, !90, !561}
!561 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !562)
!562 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !162, size: 64)
!563 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !564, file: !455, line: 167)
!564 = !DISubprogram(name: "strtol", scope: !450, file: !450, line: 176, type: !565, flags: DIFlagPrototyped, spFlags: 0)
!565 = !DISubroutineType(types: !566)
!566 = !{!229, !90, !561, !20}
!567 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !568, file: !455, line: 168)
!568 = !DISubprogram(name: "strtoul", scope: !450, file: !450, line: 180, type: !569, flags: DIFlagPrototyped, spFlags: 0)
!569 = !DISubroutineType(types: !570)
!570 = !{!89, !90, !561, !20}
!571 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !572, file: !455, line: 169)
!572 = !DISubprogram(name: "system", scope: !450, file: !450, line: 784, type: !479, flags: DIFlagPrototyped, spFlags: 0)
!573 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !574, file: !455, line: 171)
!574 = !DISubprogram(name: "wcstombs", scope: !450, file: !450, line: 936, type: !575, flags: DIFlagPrototyped, spFlags: 0)
!575 = !DISubroutineType(types: !576)
!576 = !{!87, !161, !64, !87}
!577 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !578, file: !455, line: 172)
!578 = !DISubprogram(name: "wctomb", scope: !450, file: !450, line: 929, type: !579, flags: DIFlagPrototyped, spFlags: 0)
!579 = !DISubroutineType(types: !580)
!580 = !{!20, !162, !53}
!581 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !582, file: !455, line: 200)
!582 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !450, line: 80, baseType: !583)
!583 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !450, line: 76, size: 128, flags: DIFlagTypePassByValue, elements: !584, identifier: "_ZTS7lldiv_t")
!584 = !{!585, !586}
!585 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !583, file: !450, line: 78, baseType: !286, size: 64)
!586 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !583, file: !450, line: 79, baseType: !286, size: 64, offset: 64)
!587 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !588, file: !455, line: 206)
!588 = !DISubprogram(name: "_Exit", scope: !450, file: !450, line: 629, type: !505, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!589 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !590, file: !455, line: 210)
!590 = !DISubprogram(name: "llabs", scope: !450, file: !450, line: 844, type: !591, flags: DIFlagPrototyped, spFlags: 0)
!591 = !DISubroutineType(types: !592)
!592 = !{!286, !286}
!593 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !594, file: !455, line: 216)
!594 = !DISubprogram(name: "lldiv", scope: !450, file: !450, line: 858, type: !595, flags: DIFlagPrototyped, spFlags: 0)
!595 = !DISubroutineType(types: !596)
!596 = !{!582, !286, !286}
!597 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !598, file: !455, line: 227)
!598 = !DISubprogram(name: "atoll", scope: !450, file: !450, line: 112, type: !599, flags: DIFlagPrototyped, spFlags: 0)
!599 = !DISubroutineType(types: !600)
!600 = !{!286, !91}
!601 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !602, file: !455, line: 228)
!602 = !DISubprogram(name: "strtoll", scope: !450, file: !450, line: 200, type: !603, flags: DIFlagPrototyped, spFlags: 0)
!603 = !DISubroutineType(types: !604)
!604 = !{!286, !90, !561, !20}
!605 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !606, file: !455, line: 229)
!606 = !DISubprogram(name: "strtoull", scope: !450, file: !450, line: 205, type: !607, flags: DIFlagPrototyped, spFlags: 0)
!607 = !DISubroutineType(types: !608)
!608 = !{!291, !90, !561, !20}
!609 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !610, file: !455, line: 231)
!610 = !DISubprogram(name: "strtof", scope: !450, file: !450, line: 123, type: !611, flags: DIFlagPrototyped, spFlags: 0)
!611 = !DISubroutineType(types: !612)
!612 = !{!220, !90, !561}
!613 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !614, file: !455, line: 232)
!614 = !DISubprogram(name: "strtold", scope: !450, file: !450, line: 126, type: !615, flags: DIFlagPrototyped, spFlags: 0)
!615 = !DISubroutineType(types: !616)
!616 = !{!281, !90, !561}
!617 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !582, file: !455, line: 240)
!618 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !588, file: !455, line: 242)
!619 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !590, file: !455, line: 244)
!620 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !621, file: !455, line: 245)
!621 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !277, file: !455, line: 213, type: !595, flags: DIFlagPrototyped, spFlags: 0)
!622 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !594, file: !455, line: 246)
!623 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !598, file: !455, line: 248)
!624 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !610, file: !455, line: 249)
!625 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !602, file: !455, line: 250)
!626 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !606, file: !455, line: 251)
!627 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !614, file: !455, line: 252)
!628 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !629, file: !631, line: 98)
!629 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !630, line: 7, baseType: !47)
!630 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "")
!631 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdio", directory: "")
!632 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !633, file: !631, line: 99)
!633 = !DIDerivedType(tag: DW_TAG_typedef, name: "fpos_t", file: !634, line: 84, baseType: !635)
!634 = !DIFile(filename: "/usr/include/stdio.h", directory: "")
!635 = !DIDerivedType(tag: DW_TAG_typedef, name: "__fpos_t", file: !636, line: 14, baseType: !637)
!636 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h", directory: "")
!637 = !DICompositeType(tag: DW_TAG_structure_type, name: "_G_fpos_t", file: !636, line: 10, size: 128, flags: DIFlagFwdDecl, identifier: "_ZTS9_G_fpos_t")
!638 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !639, file: !631, line: 101)
!639 = !DISubprogram(name: "clearerr", scope: !634, file: !634, line: 757, type: !640, flags: DIFlagPrototyped, spFlags: 0)
!640 = !DISubroutineType(types: !641)
!641 = !{null, !642}
!642 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !629, size: 64)
!643 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !644, file: !631, line: 102)
!644 = !DISubprogram(name: "fclose", scope: !634, file: !634, line: 213, type: !645, flags: DIFlagPrototyped, spFlags: 0)
!645 = !DISubroutineType(types: !646)
!646 = !{!20, !642}
!647 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !648, file: !631, line: 103)
!648 = !DISubprogram(name: "feof", scope: !634, file: !634, line: 759, type: !645, flags: DIFlagPrototyped, spFlags: 0)
!649 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !650, file: !631, line: 104)
!650 = !DISubprogram(name: "ferror", scope: !634, file: !634, line: 761, type: !645, flags: DIFlagPrototyped, spFlags: 0)
!651 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !652, file: !631, line: 105)
!652 = !DISubprogram(name: "fflush", scope: !634, file: !634, line: 218, type: !645, flags: DIFlagPrototyped, spFlags: 0)
!653 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !654, file: !631, line: 106)
!654 = !DISubprogram(name: "fgetc", scope: !634, file: !634, line: 485, type: !645, flags: DIFlagPrototyped, spFlags: 0)
!655 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !656, file: !631, line: 107)
!656 = !DISubprogram(name: "fgetpos", scope: !634, file: !634, line: 731, type: !657, flags: DIFlagPrototyped, spFlags: 0)
!657 = !DISubroutineType(types: !658)
!658 = !{!20, !659, !660}
!659 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !642)
!660 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !661)
!661 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !633, size: 64)
!662 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !663, file: !631, line: 108)
!663 = !DISubprogram(name: "fgets", scope: !634, file: !634, line: 564, type: !664, flags: DIFlagPrototyped, spFlags: 0)
!664 = !DISubroutineType(types: !665)
!665 = !{!162, !161, !20, !659}
!666 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !667, file: !631, line: 109)
!667 = !DISubprogram(name: "fopen", scope: !634, file: !634, line: 246, type: !668, flags: DIFlagPrototyped, spFlags: 0)
!668 = !DISubroutineType(types: !669)
!669 = !{!642, !90, !90}
!670 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !671, file: !631, line: 110)
!671 = !DISubprogram(name: "fprintf", scope: !634, file: !634, line: 326, type: !672, flags: DIFlagPrototyped, spFlags: 0)
!672 = !DISubroutineType(types: !673)
!673 = !{!20, !659, !90, null}
!674 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !675, file: !631, line: 111)
!675 = !DISubprogram(name: "fputc", scope: !634, file: !634, line: 521, type: !676, flags: DIFlagPrototyped, spFlags: 0)
!676 = !DISubroutineType(types: !677)
!677 = !{!20, !20, !642}
!678 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !679, file: !631, line: 112)
!679 = !DISubprogram(name: "fputs", scope: !634, file: !634, line: 626, type: !680, flags: DIFlagPrototyped, spFlags: 0)
!680 = !DISubroutineType(types: !681)
!681 = !{!20, !90, !659}
!682 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !683, file: !631, line: 113)
!683 = !DISubprogram(name: "fread", scope: !634, file: !634, line: 646, type: !684, flags: DIFlagPrototyped, spFlags: 0)
!684 = !DISubroutineType(types: !685)
!685 = !{!87, !686, !87, !87, !659}
!686 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !139)
!687 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !688, file: !631, line: 114)
!688 = !DISubprogram(name: "freopen", scope: !634, file: !634, line: 252, type: !689, flags: DIFlagPrototyped, spFlags: 0)
!689 = !DISubroutineType(types: !690)
!690 = !{!642, !90, !90, !659}
!691 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !692, file: !631, line: 115)
!692 = !DISubprogram(name: "fscanf", linkageName: "__isoc99_fscanf", scope: !634, file: !634, line: 407, type: !672, flags: DIFlagPrototyped, spFlags: 0)
!693 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !694, file: !631, line: 116)
!694 = !DISubprogram(name: "fseek", scope: !634, file: !634, line: 684, type: !695, flags: DIFlagPrototyped, spFlags: 0)
!695 = !DISubroutineType(types: !696)
!696 = !{!20, !642, !229, !20}
!697 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !698, file: !631, line: 117)
!698 = !DISubprogram(name: "fsetpos", scope: !634, file: !634, line: 736, type: !699, flags: DIFlagPrototyped, spFlags: 0)
!699 = !DISubroutineType(types: !700)
!700 = !{!20, !642, !701}
!701 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !702, size: 64)
!702 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !633)
!703 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !704, file: !631, line: 118)
!704 = !DISubprogram(name: "ftell", scope: !634, file: !634, line: 689, type: !705, flags: DIFlagPrototyped, spFlags: 0)
!705 = !DISubroutineType(types: !706)
!706 = !{!229, !642}
!707 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !708, file: !631, line: 119)
!708 = !DISubprogram(name: "fwrite", scope: !634, file: !634, line: 652, type: !709, flags: DIFlagPrototyped, spFlags: 0)
!709 = !DISubroutineType(types: !710)
!710 = !{!87, !711, !87, !87, !659}
!711 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !489)
!712 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !713, file: !631, line: 120)
!713 = !DISubprogram(name: "getc", scope: !634, file: !634, line: 486, type: !645, flags: DIFlagPrototyped, spFlags: 0)
!714 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !715, file: !631, line: 121)
!715 = !DISubprogram(name: "getchar", scope: !634, file: !634, line: 492, type: !547, flags: DIFlagPrototyped, spFlags: 0)
!716 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !717, file: !631, line: 126)
!717 = !DISubprogram(name: "perror", scope: !634, file: !634, line: 775, type: !718, flags: DIFlagPrototyped, spFlags: 0)
!718 = !DISubroutineType(types: !719)
!719 = !{null, !91}
!720 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !721, file: !631, line: 127)
!721 = !DISubprogram(name: "printf", scope: !634, file: !634, line: 332, type: !722, flags: DIFlagPrototyped, spFlags: 0)
!722 = !DISubroutineType(types: !723)
!723 = !{!20, !90, null}
!724 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !725, file: !631, line: 128)
!725 = !DISubprogram(name: "putc", scope: !634, file: !634, line: 522, type: !676, flags: DIFlagPrototyped, spFlags: 0)
!726 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !727, file: !631, line: 129)
!727 = !DISubprogram(name: "putchar", scope: !634, file: !634, line: 528, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!728 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !729, file: !631, line: 130)
!729 = !DISubprogram(name: "puts", scope: !634, file: !634, line: 632, type: !479, flags: DIFlagPrototyped, spFlags: 0)
!730 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !731, file: !631, line: 131)
!731 = !DISubprogram(name: "remove", scope: !634, file: !634, line: 146, type: !479, flags: DIFlagPrototyped, spFlags: 0)
!732 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !733, file: !631, line: 132)
!733 = !DISubprogram(name: "rename", scope: !634, file: !634, line: 148, type: !734, flags: DIFlagPrototyped, spFlags: 0)
!734 = !DISubroutineType(types: !735)
!735 = !{!20, !91, !91}
!736 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !737, file: !631, line: 133)
!737 = !DISubprogram(name: "rewind", scope: !634, file: !634, line: 694, type: !640, flags: DIFlagPrototyped, spFlags: 0)
!738 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !739, file: !631, line: 134)
!739 = !DISubprogram(name: "scanf", linkageName: "__isoc99_scanf", scope: !634, file: !634, line: 410, type: !722, flags: DIFlagPrototyped, spFlags: 0)
!740 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !741, file: !631, line: 135)
!741 = !DISubprogram(name: "setbuf", scope: !634, file: !634, line: 304, type: !742, flags: DIFlagPrototyped, spFlags: 0)
!742 = !DISubroutineType(types: !743)
!743 = !{null, !659, !161}
!744 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !745, file: !631, line: 136)
!745 = !DISubprogram(name: "setvbuf", scope: !634, file: !634, line: 308, type: !746, flags: DIFlagPrototyped, spFlags: 0)
!746 = !DISubroutineType(types: !747)
!747 = !{!20, !659, !161, !20, !87}
!748 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !749, file: !631, line: 137)
!749 = !DISubprogram(name: "sprintf", scope: !634, file: !634, line: 334, type: !750, flags: DIFlagPrototyped, spFlags: 0)
!750 = !DISubroutineType(types: !751)
!751 = !{!20, !161, !90, null}
!752 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !753, file: !631, line: 138)
!753 = !DISubprogram(name: "sscanf", linkageName: "__isoc99_sscanf", scope: !634, file: !634, line: 412, type: !754, flags: DIFlagPrototyped, spFlags: 0)
!754 = !DISubroutineType(types: !755)
!755 = !{!20, !90, !90, null}
!756 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !757, file: !631, line: 139)
!757 = !DISubprogram(name: "tmpfile", scope: !634, file: !634, line: 173, type: !758, flags: DIFlagPrototyped, spFlags: 0)
!758 = !DISubroutineType(types: !759)
!759 = !{!642}
!760 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !761, file: !631, line: 141)
!761 = !DISubprogram(name: "tmpnam", scope: !634, file: !634, line: 187, type: !762, flags: DIFlagPrototyped, spFlags: 0)
!762 = !DISubroutineType(types: !763)
!763 = !{!162, !162}
!764 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !765, file: !631, line: 143)
!765 = !DISubprogram(name: "ungetc", scope: !634, file: !634, line: 639, type: !676, flags: DIFlagPrototyped, spFlags: 0)
!766 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !767, file: !631, line: 144)
!767 = !DISubprogram(name: "vfprintf", scope: !634, file: !634, line: 341, type: !768, flags: DIFlagPrototyped, spFlags: 0)
!768 = !DISubroutineType(types: !769)
!769 = !{!20, !659, !90, !133}
!770 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !771, file: !631, line: 145)
!771 = !DISubprogram(name: "vprintf", scope: !634, file: !634, line: 347, type: !772, flags: DIFlagPrototyped, spFlags: 0)
!772 = !DISubroutineType(types: !773)
!773 = !{!20, !90, !133}
!774 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !775, file: !631, line: 146)
!775 = !DISubprogram(name: "vsprintf", scope: !634, file: !634, line: 349, type: !776, flags: DIFlagPrototyped, spFlags: 0)
!776 = !DISubroutineType(types: !777)
!777 = !{!20, !161, !90, !133}
!778 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !779, file: !631, line: 175)
!779 = !DISubprogram(name: "snprintf", scope: !634, file: !634, line: 354, type: !780, flags: DIFlagPrototyped, spFlags: 0)
!780 = !DISubroutineType(types: !781)
!781 = !{!20, !161, !87, !90, null}
!782 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !783, file: !631, line: 176)
!783 = !DISubprogram(name: "vfscanf", linkageName: "__isoc99_vfscanf", scope: !634, file: !634, line: 451, type: !768, flags: DIFlagPrototyped, spFlags: 0)
!784 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !785, file: !631, line: 177)
!785 = !DISubprogram(name: "vscanf", linkageName: "__isoc99_vscanf", scope: !634, file: !634, line: 456, type: !772, flags: DIFlagPrototyped, spFlags: 0)
!786 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !787, file: !631, line: 178)
!787 = !DISubprogram(name: "vsnprintf", scope: !634, file: !634, line: 358, type: !788, flags: DIFlagPrototyped, spFlags: 0)
!788 = !DISubroutineType(types: !789)
!789 = !{!20, !161, !87, !90, !133}
!790 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !277, entity: !791, file: !631, line: 179)
!791 = !DISubprogram(name: "vsscanf", linkageName: "__isoc99_vsscanf", scope: !634, file: !634, line: 459, type: !792, flags: DIFlagPrototyped, spFlags: 0)
!792 = !DISubroutineType(types: !793)
!793 = !{!20, !90, !90, !133}
!794 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !779, file: !631, line: 185)
!795 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !783, file: !631, line: 186)
!796 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !785, file: !631, line: 187)
!797 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !787, file: !631, line: 188)
!798 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !791, file: !631, line: 189)
!799 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !800, file: !804, line: 82)
!800 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctrans_t", file: !801, line: 48, baseType: !802)
!801 = !DIFile(filename: "/usr/include/wctype.h", directory: "")
!802 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !803, size: 64)
!803 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !327)
!804 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cwctype", directory: "")
!805 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !806, file: !804, line: 83)
!806 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctype_t", file: !807, line: 38, baseType: !89)
!807 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/wctype-wchar.h", directory: "")
!808 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !33, file: !804, line: 84)
!809 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !810, file: !804, line: 86)
!810 = !DISubprogram(name: "iswalnum", scope: !807, file: !807, line: 95, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!811 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !812, file: !804, line: 87)
!812 = !DISubprogram(name: "iswalpha", scope: !807, file: !807, line: 101, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!813 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !814, file: !804, line: 89)
!814 = !DISubprogram(name: "iswblank", scope: !807, file: !807, line: 146, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!815 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !816, file: !804, line: 91)
!816 = !DISubprogram(name: "iswcntrl", scope: !807, file: !807, line: 104, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!817 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !818, file: !804, line: 92)
!818 = !DISubprogram(name: "iswctype", scope: !807, file: !807, line: 159, type: !819, flags: DIFlagPrototyped, spFlags: 0)
!819 = !DISubroutineType(types: !820)
!820 = !{!20, !33, !806}
!821 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !822, file: !804, line: 93)
!822 = !DISubprogram(name: "iswdigit", scope: !807, file: !807, line: 108, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!823 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !824, file: !804, line: 94)
!824 = !DISubprogram(name: "iswgraph", scope: !807, file: !807, line: 112, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!825 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !826, file: !804, line: 95)
!826 = !DISubprogram(name: "iswlower", scope: !807, file: !807, line: 117, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!827 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !828, file: !804, line: 96)
!828 = !DISubprogram(name: "iswprint", scope: !807, file: !807, line: 120, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!829 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !830, file: !804, line: 97)
!830 = !DISubprogram(name: "iswpunct", scope: !807, file: !807, line: 125, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!831 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !832, file: !804, line: 98)
!832 = !DISubprogram(name: "iswspace", scope: !807, file: !807, line: 130, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!833 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !834, file: !804, line: 99)
!834 = !DISubprogram(name: "iswupper", scope: !807, file: !807, line: 135, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!835 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !836, file: !804, line: 100)
!836 = !DISubprogram(name: "iswxdigit", scope: !807, file: !807, line: 140, type: !240, flags: DIFlagPrototyped, spFlags: 0)
!837 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !838, file: !804, line: 101)
!838 = !DISubprogram(name: "towctrans", scope: !801, file: !801, line: 55, type: !839, flags: DIFlagPrototyped, spFlags: 0)
!839 = !DISubroutineType(types: !840)
!840 = !{!33, !33, !800}
!841 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !842, file: !804, line: 102)
!842 = !DISubprogram(name: "towlower", scope: !807, file: !807, line: 166, type: !843, flags: DIFlagPrototyped, spFlags: 0)
!843 = !DISubroutineType(types: !844)
!844 = !{!33, !33}
!845 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !846, file: !804, line: 103)
!846 = !DISubprogram(name: "towupper", scope: !807, file: !807, line: 169, type: !843, flags: DIFlagPrototyped, spFlags: 0)
!847 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !848, file: !804, line: 104)
!848 = !DISubprogram(name: "wctrans", scope: !801, file: !801, line: 52, type: !849, flags: DIFlagPrototyped, spFlags: 0)
!849 = !DISubroutineType(types: !850)
!850 = !{!800, !91}
!851 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !852, file: !804, line: 105)
!852 = !DISubprogram(name: "wctype", scope: !807, file: !807, line: 155, type: !853, flags: DIFlagPrototyped, spFlags: 0)
!853 = !DISubroutineType(types: !854)
!854 = !{!806, !91}
!855 = !{i32 7, !"Dwarf Version", i32 4}
!856 = !{i32 2, !"Debug Info Version", i32 3}
!857 = !{i32 1, !"wchar_size", i32 4}
!858 = !{i32 7, !"uwtable", i32 1}
!859 = !{i32 7, !"frame-pointer", i32 2}
!860 = !{!"Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58"}
!861 = distinct !DISubprogram(name: "__cxx_global_var_init", scope: !8, file: !8, type: !464, flags: DIFlagArtificial, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!862 = !DILocation(line: 74, column: 25, scope: !863)
!863 = !DILexicalBlockFile(scope: !861, file: !3, discriminator: 0)
!864 = !DILocation(line: 0, scope: !861)
!865 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 4, type: !866, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!866 = !DISubroutineType(types: !867)
!867 = !{!20, !20, !562}
!868 = !DILocalVariable(name: "argc", arg: 1, scope: !865, file: !8, line: 4, type: !20)
!869 = !DILocation(line: 4, column: 14, scope: !865)
!870 = !DILocalVariable(name: "argv", arg: 2, scope: !865, file: !8, line: 4, type: !562)
!871 = !DILocation(line: 4, column: 27, scope: !865)
!872 = !DILocalVariable(name: "mainloopbegin", scope: !865, file: !8, line: 8, type: !873)
!873 = !DIDerivedType(tag: DW_TAG_typedef, name: "string", scope: !2, file: !874, line: 79, baseType: !875)
!874 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/stringfwd.h", directory: "")
!875 = !DICompositeType(tag: DW_TAG_class_type, name: "basic_string<char, std::char_traits<char>, std::allocator<char> >", scope: !877, file: !876, line: 1608, size: 256, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE")
!876 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/basic_string.tcc", directory: "")
!877 = !DINamespace(name: "__cxx11", scope: !2, exportSymbols: true)
!878 = !DILocation(line: 8, column: 17, scope: !865)
!879 = !DILocalVariable(name: "mainloopend", scope: !865, file: !8, line: 8, type: !873)
!880 = !DILocation(line: 8, column: 32, scope: !865)
!881 = !DILocalVariable(name: "funcName", scope: !865, file: !8, line: 8, type: !873)
!882 = !DILocation(line: 8, column: 44, scope: !865)
!883 = !DILocation(line: 9, column: 8, scope: !884)
!884 = distinct !DILexicalBlock(scope: !865, file: !8, line: 9, column: 8)
!885 = !DILocation(line: 9, column: 13, scope: !884)
!886 = !DILocation(line: 9, column: 8, scope: !865)
!887 = !DILocation(line: 10, column: 25, scope: !888)
!888 = distinct !DILexicalBlock(scope: !884, file: !8, line: 9, column: 17)
!889 = !DILocation(line: 10, column: 23, scope: !888)
!890 = !DILocation(line: 11, column: 23, scope: !888)
!891 = !DILocation(line: 11, column: 21, scope: !888)
!892 = !DILocation(line: 12, column: 20, scope: !888)
!893 = !DILocation(line: 12, column: 18, scope: !888)
!894 = !DILocation(line: 13, column: 5, scope: !888)
!895 = !DILocation(line: 22, column: 1, scope: !888)
!896 = !DILocalVariable(name: "file", scope: !865, file: !8, line: 15, type: !897)
!897 = !DIDerivedType(tag: DW_TAG_typedef, name: "ofstream", scope: !2, file: !898, line: 165, baseType: !899)
!898 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/iosfwd", directory: "")
!899 = !DICompositeType(tag: DW_TAG_class_type, name: "basic_ofstream<char, std::char_traits<char> >", scope: !2, file: !900, line: 1088, size: 4096, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!900 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/fstream.tcc", directory: "")
!901 = !DILocation(line: 15, column: 19, scope: !865)
!902 = !DILocation(line: 16, column: 14, scope: !903)
!903 = distinct !DILexicalBlock(scope: !865, file: !8, line: 16, column: 9)
!904 = !DILocation(line: 16, column: 9, scope: !865)
!905 = !DILocation(line: 17, column: 9, scope: !906)
!906 = distinct !DILexicalBlock(scope: !903, file: !8, line: 16, column: 25)
!907 = !DILocation(line: 17, column: 14, scope: !906)
!908 = !DILocation(line: 17, column: 31, scope: !906)
!909 = !DILocation(line: 17, column: 38, scope: !906)
!910 = !DILocation(line: 17, column: 53, scope: !906)
!911 = !DILocation(line: 18, column: 9, scope: !906)
!912 = !DILocation(line: 18, column: 14, scope: !906)
!913 = !DILocation(line: 18, column: 26, scope: !906)
!914 = !DILocation(line: 19, column: 14, scope: !906)
!915 = !DILocation(line: 20, column: 5, scope: !906)
!916 = !DILocation(line: 22, column: 1, scope: !903)
!917 = !DILocation(line: 22, column: 1, scope: !865)
!918 = !DILocation(line: 21, column: 5, scope: !865)
!919 = distinct !DISubprogram(linkageName: "_GLOBAL__sub_I_mainloopScope.cpp", scope: !8, file: !8, type: !920, flags: DIFlagArtificial, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!920 = !DISubroutineType(types: !9)
!921 = !DILocation(line: 0, scope: !919)
