#include "llvm/Pass.h"

#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"

#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
#include <llvm/IR/Constants.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/DerivedTypes.h>
#include "llvm/IR/SymbolTableListTraits.h"
#include "llvm/IR/ValueSymbolTable.h"


#include "llvm/IR/DebugLoc.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/Casting.h"


#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/LoopInfo.h"

#include "llvm/Support/CommandLine.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include <stack>
#include <map>
#include <set>
#include <string>
#include <utility>

//#define READFILELIB "/home/zwp82/workspace/LLVM-Checker/lib/Data/"
//#define WRITERFILELIB "/home/zwp82/workspace/LLVM-Checker/lib/Data/"
#define READFILELIB "/workspace/LLVM-Checker/lib/Data/"
#define WRITERFILELIB "/workspace/LLVM-Checker/lib/Data/"

char dataFiles[10][30]={"dataMap.txt","funcNameData.txt","varNameData.txt",
                        "varsMap.txt","loopRangeData.txt"};

using namespace llvm;

extern "C" {
void* malloc(size_t);
}

namespace {
    struct Checker : public FunctionPass {
        static char ID;
        //变量节点
        struct varNode {
            uint64_t addr;
            std::string vname;
            int bbnum;
            std::string fname;
            int vlocate;
            std::string user;
            std::string vartype;//变量类型
            unsigned varsize;//变量空间大小
        };
        //存储自定义函数
        std::vector<Function*>funcs;

        std::map<int, std::vector<std::vector<varNode>>>ddgNodeMap;

        //存储所有的变量 ---
        std::map<uint64_t, varNode > varsMap;

        //根据函数名存储相关变量
//        std::map<std::string,std::set<uint64_t>> funcVarsMap;

        //根据变量名与函数名获取地址(这样可以获取唯一值)
        std::map<std::pair<std::string, std::string>, uint64_t> nametoaddr;

        std::pair<std::string, std::string>vfname;

        //根据变量地址查找出块号
        //std::map< uint64_t, int>addrtobbnum;

        //接收函数名
        std::vector<std::string>funcNameList;
        //接收变量名
        std::vector<std::pair<std::string, std::string>>varNameList;

        //=== 映射
        //原数组
        std::map<std::uint64_t, varNode>arrRoot;
        //函数 + 参数名
        std::map<std::string, std::vector<std::string>>funcArgsName;
        //函数 + 参数地址
        std::map<std::string, std::vector<uint64_t>>funcArgsAddr;

        //把 x.addr 与 x地址结合(x为函数参数,x.addr函数内部自定义的x)
        std::map<uint64_t,uint64_t>VarAddrToReal;

        //存储循环的范围列表(函数名前缀)
        std::map<std::string, std::vector<std::pair<std::pair<unsigned, unsigned>, unsigned>>>loopRangeList;
        //==============================================================================================

        std::string stringtofilename(std::string name,bool state);

        //string --- vector<node>
        Checker() : FunctionPass(ID) {}
        void getAnalysisUsage(AnalysisUsage& AU) const override {
            AU.setPreservesAll();
            AU.addRequired<LoopInfoWrapperPass>();
        }

        //new
        //加载ddgnodemap中的数据和初始化
        void initDDGMap(Module& M);

        int getbbNum(BasicBlock& BB);

        std::string getGlobalVariableName(const llvm::Value* V);

        std::string getGlobalVarNameFromString(Value* Operand);
        unsigned getArrayDimension(Type *Ty);
        ///插入linkddgtoeddg funcs[0]
        void InsertDDgtoEddg(Instruction *Inst,int BBnum,int afterflag1,GlobalVariable *flag,LLVMContext &context);
        ///插入loadfromfile funcs[1]
        void InsertLoadFromFile(Function &F);
        ///插入printcheckpointVar funcs[2]
        void InsertPrintCPVar(Instruction *Inst);
        ///插入resultUsed funcs[3]
        void InsertResultUsed(Instruction *Inst,std::pair<std::string,std::string>&vfname,int BBNum,std::string fname,LLVMContext &context,GlobalVariable *flag,std::string BBname);
        ///插入varUsed funcs[4]
        void InsertVarUsed(Instruction *Inst,int BBNum,int count,GlobalVariable *flag,LLVMContext &context);
        ///插入 poinConnArr funcs[5]
        void InsertPoinConnArr(Instruction *Inst,std::string ciName,CallInst *callInst,
                               std::pair<std::string,std::string>&vfname,LLVMContext &context,
                               std::string fname,GlobalVariable *Aarg,GlobalVariable *Farg,GlobalVariable *flag);
        ///插入 arrlenUsed函数 funcs[6]
        void InsertArrLenUsed(Instruction *Inst,int BBNum,int count,GlobalVariable *flag,LLVMContext &context,std::string fname);
        ///插入 cher_poiSize funcs[7]
        void InsertPoiSize(Instruction *Inst,GlobalVariable *flag,int BBNum,int count,LLVMContext &context);

        void InsertFuncsIO(Function &F,GlobalVariable *flag,LLVMContext &context,std::string fname);

        void InsertFreeIO(Instruction *Inst,CallInst *callInst,LLVMContext &context,GlobalVariable *flag);

        void GetArrIdx(Instruction *Inst,std::vector<Value*> idxs,IRBuilder<> builder());

        void InsertArrIdx(Instruction *Inst,int BBNum,int count,GlobalVariable *flag,LLVMContext &context,std::string fname);
        //查找自定义函数
        void getFunctions(Module& M);

        //before
        //把ddgNodeMap中的值传入c中
        void InsertFunction(Module& M);

        //判断函数名
        bool judgeFuncName(std::string fname);
        //判断变量名
        bool judgeVarName(std::string vname,std::string fname);

        bool runOnFunction(Function& F);//执行

        bool doInitialization(Module& M);//初始化

    };

}

//new
std::string Checker::getGlobalVariableName(const llvm::Value* V) {
    if (auto* G = llvm::dyn_cast<llvm::GlobalVariable>(V)) {
        return G->getName().str();
    }
    return "";
}

std::string Checker::getGlobalVarNameFromString(Value* Operand) {
    std::string str;
    llvm::raw_string_ostream destPtrStream(str);
    Operand->print(destPtrStream);
//    errs()<<*Operand << " : " <<str<<"\n";
    size_t pos = str.find("getelementptr");
    if (pos != std::string::npos) {
        pos = str.find("@");
        if (pos != std::string::npos) {
            size_t endPos = str.find(",", pos);
            return str.substr(pos + 1, endPos - pos - 1);
        }
    }
    pos = str.find("bitcast");//除getelementptr外还有bitcast
    if(pos != std::string::npos){
        pos = str.find("@");
        if (pos != std::string::npos) {
            size_t endPos = str.find(" ", pos);
            return str.substr(pos + 1, endPos - pos - 1);
        }
    }
    return "";
}

void Checker::getFunctions(Module& M) {
    ////linkddgtoeddg函数
    //Function* linkddgtoeddgFunc;
    ////loadfromfile函数
    //Function* loadfromfileFunc;
    ////printcheckpointVar函数
    //Function* printcheckpointVar;
    ////resultUsed
    //Function* resultUsed;
    ///sizeAlloca


    funcs.resize(20);
    //获取相关函数指针

    for (auto& F : M) {
        auto fname = F.getName().str();
        if (fname.find("cher_linkddgtoeddg") != std::string::npos) {
            funcs[0] = &F;
        }
        if (fname.find("cher_loadfromfile") != std::string::npos) {
            funcs[1] = &F;
        }
        if (fname.find("cher_printcheckpointVar") != std::string::npos) {
            funcs[2] = &F;
        }
        if (fname.find("cher_resultUsed") != std::string::npos) {
            funcs[3] = &F;
        }
        if (fname.find("cher_varUsed") != std::string::npos) {
            funcs[4] = &F;
        }
        if (fname.find("cher_PoinConnArr") != std::string::npos) {
            funcs[5] = &F;
        }
        if (fname.find("cher_arrLenUsed") != std::string::npos) {
            funcs[6] = &F;
        }
        if (fname.find("cher_poiSize") != std::string::npos) {
            ///指针变量空间大小
            funcs[7] = &F;
        }
        if (fname.find("cher_funcsIO") != std::string::npos) {
            ///对每个函数进行IO判断
            funcs[8] = &F;
        }
        if (fname.find("cher_FreeIO") != std::string::npos) {
            ///对每个函数进行IO判断
            funcs[9] = &F;
        }



        if(fname.find("cher_arrayidx_double")!=std::string::npos){
            funcs[10] = &F;
        }

        if(fname.find("cher_arrayidx_float")!=std::string::npos){
            funcs[11] = &F;
        }

    }
}

std::string Checker::stringtofilename(std::string name,bool state){//read 0,write 1
    std::string filename;
    if(state) filename=WRITERFILELIB;
    else filename = READFILELIB;
    filename+=name;
//    errs()<<filename<<"\n";
    return filename;
}

void Checker::initDDGMap(Module& M) {
    //获取ddgNodeMap中数据
    std::string filename = stringtofilename(dataFiles[0],0);//"dataMap.txt"
    std::ifstream file1(filename);

    if (file1.is_open()) {
        std::string line;
        int key = -1;
        while (std::getline(file1, line)) {
            if (line.empty()) {
                continue;
            }
            if (line != "=" && line.find(",") == std::string::npos) {
                //查找块号  (这一行没有 , 和 =)
                key = std::stoi(line);
                //cout << key << "\n";
                ddgNodeMap[key];
            }
            else if (line == "=") {
                std::vector<varNode> vec;
                while (std::getline(file1, line) && line.find(",") != std::string::npos) {
                    //能够找到 ,
                    std::stringstream ss(line);
                    std::string token;
                    std::vector<std::string> tokens;
                    while (std::getline(ss, token, ',')) {
                        tokens.push_back(token);
                        //printf("%s\t", token.c_str());
                    }
                    //printf("\n");
                    if (tokens.size() == 8) {
                        uint64_t addr = std::stoull(tokens[0]);
                        std::string vname = tokens[1];
                        int bbnum = std::stoi(tokens[2]);
                        std::string fname = tokens[3];
                        int vlocate = std::stoi(tokens[4]);
                        std::string user = tokens[5];
                        std::string vartype = tokens[6];
                        unsigned varsize = std::stoi(tokens[7]);
                        vec.push_back({ addr, vname, bbnum, fname, vlocate, user,vartype,varsize });
                    }
                }
                if (key != -1 && !vec.empty()) {
                    ddgNodeMap[key].push_back(vec);
                    //cout << "the line is : " << line << endl;
                    if (line != "=" && line != "") {
                        key = std::stoi(line);
                        //cout << key << "\n";
                        ddgNodeMap[key];
                    }
                }
            }
        }
        file1.close();
    }

    //获取funcNameData中数据
    filename = stringtofilename(dataFiles[1],0);//"funcNameData.txt"
    std::ifstream file2(filename);
    if (file2.is_open()) {
        std::string line;
        //获取main loop所在的范围
        while (std::getline(file2, line)) {
            funcNameList.push_back(line);
//            errs() << line << "\n";
        }
        file2.close();
    }

    //获取varNameData中数据
    filename = stringtofilename(dataFiles[2],0);//"varNameData.txt"
    std::ifstream file3(filename);
    if (file3.is_open()) {
        std::string line;
        //获取main loop所在的范围
        while (std::getline(file3, line)) {
            std::pair<std::string, std::string>PSS;
            std::string str = "";
            for (int i = 0; i < line.size(); ++i) {
                if (line[i] != ',') str += line[i];
                else {
                    PSS.first = str;
                    str = "";
                }
            }
            PSS.second = str;
            varNameList.push_back(PSS);
        }
        file3.close();
    }

    //获取varsMap中数据
    filename = stringtofilename(dataFiles[3],0);//"varsMap.txt"
    std::ifstream file4(filename);
    if (file4.is_open()) {
        std::string line;
        //获取main loop所在的范围
        while (std::getline(file4, line)) {
            std::stringstream ss(line);
            std::string token;
            std::vector<std::string> tokens;
            varNode var;
            while (std::getline(ss, token, ',')) {
                tokens.push_back(token);
            }
            if (tokens.size() == 8) {
                uint64_t addr = std::stoull(tokens[0]);
                std::string vname = tokens[1];
                int bbnum = std::stoi(tokens[2]);
                std::string fname = tokens[3];
                int vlocate = std::stoi(tokens[4]);
                std::string user = tokens[5];
                std::string vartype = tokens[6];
                unsigned varsize = std::stoi(tokens[7]);
                var.addr = addr;
                var.vname=vname;
                var.bbnum = bbnum;
                var.fname = fname;
                var.vlocate = vlocate;
                var.user = user;
                var.vartype = vartype;
                var.varsize = varsize;

                varsMap[addr] = var;

                //当这个变量带 '.' 时,存入 VarAddrToReal
//                size_t pos = vname.find(".");
//                if(fname!="GlobalVar" && =pos !=std::string ::npos){
//                    //变量含有 '.'
//                    VarAddrToReal[addr];
//                }
//                errs()<<addr<<"\n";
                if(bbnum == -2){//key 为参数
                    VarAddrToReal[addr];
                }


            }
        }
        file4.close();
    }


    ///获取loopList中数据
    filename = stringtofilename(dataFiles[4],0);//"loopRangeData.txt"
    std::ifstream file5(filename);
    if (file5.is_open()) {
        std::string line;
        std::string key="";
        while (std::getline(file5, line)) {
            if (line.empty()) {
                continue;
            }
            if (line.find(",") == std::string::npos) {/// 函数名
                key = line;
                loopRangeList[key];
//                    errs()<<key<<"\n";
            }else if (line.find(",") != std::string::npos) {///循环
                std::vector<std::pair<std::pair<unsigned, unsigned>, unsigned>>range;
                std::pair<std::pair<unsigned, unsigned> , unsigned> PII;

                std::stringstream ss(line); // 使用字符串流处理读取的行

                ///跳过 ,
                if(ss>>PII.first.first && ss.ignore() && ss>>PII.first.second && ss.ignore() && ss>>PII.second){
//                        errs()<<PII.first.first<<","<<PII.first.second<<","<<PII.second<<"\n";
                    range.push_back(PII);
                }
                while (std::getline(file5, line) && line.find(",") != std::string::npos) {
                    ///跳过 ,
                    std::stringstream ss(line); // 使用字符串流处理读取的行

                    if(ss>>PII.first.first && ss.ignore() && ss>>PII.first.second && ss.ignore() && ss>>PII.second){
//                            errs()<<PII.first.first<<","<<PII.first.second<<","<<PII.second<<"\n";
                        range.push_back(PII);
                    }
                }
                loopRangeList[key] = range;
            }
        }
        file5.close();
    }

    getFunctions(M);

    //从varsMap中获取数据
    for(auto & var : varsMap){
        auto v = var.second;
        if(v.vname.find("retval") != std::string::npos) continue;//排除掉返回值
        vfname.first = v.vname;
        vfname.second = v.fname;
        if(v.vname.length()>0 ){
//            errs()<<v.vname<<" , "<<v.fname<<","<<v.addr<<"\n";
            nametoaddr[vfname] = v.addr;
        }

        if(v.bbnum == -2){//代表是参数
            funcArgsAddr[v.fname].push_back(v.addr);
        }


        //找出对应的参数[key为参数,value为变量]
        for(auto par: VarAddrToReal) {
            auto p = par.first;
            auto pv = varsMap[p];
            if (pv.fname == v.fname && v.addr != pv.addr) {
                //在一个函数中且不是同一个变量
                //参数
                //其他情况(非结构体情况)
                auto pvName = pv.vname;
                if (v.vname == pvName + ".addr") {
                    //找到对应变量
                    VarAddrToReal[p] = v.addr;
                    break;
                }
            }
//                    errs()<<pv.vname <<" :" <<newVname<<": "<<v.vname<<"\n";
        }

//        funcVarsMap[v.fname].insert(v.addr);//将当前函数中的变量地址存入
    }

}

int Checker::getbbNum(BasicBlock& BB) {
    int bbnum = -1;
    for (auto& I : BB) {
        if (I.getOpcode() == Instruction::Call) {
            if (auto* CI = dyn_cast<CallInst>(&I)) {
                if (auto* CF = CI->getCalledFunction()) {
                    if (CF->getName().str() == "CALLBBNUM" && CI->getNumArgOperands() > 0) {
                        Value* Arg = CI->getArgOperand(0);
                        std::vector<Value*> args;
                        if (auto* ArgConst = dyn_cast<ConstantInt>(Arg)) {
                            int ArgVal = ArgConst->getSExtValue();
                            bbnum = ArgVal;
                            break;
                            //errs() << ArgzVal << "\n";
                        }
                    }
                }

            }
        }

    }

    return bbnum;
}

////插入相关函数

void Checker::InsertDDgtoEddg(Instruction *Inst,int BBNum,int afterflag1,GlobalVariable *flag,LLVMContext &context){
    IRBuilder<> builder(Inst);
    builder.SetInsertPoint(Inst);

    Value *bbnumValue = ConstantInt::get(Type::getInt32Ty(context), BBNum);
    Value *flagValue = builder.CreateLoad(flag, "cher_flag");
    Value *afterflag1Value = ConstantInt::get(Type::getInt32Ty(context), afterflag1);

    std::vector<Value *> args;

    args.push_back(bbnumValue);
    args.push_back(flagValue);
    args.push_back(afterflag1Value);

    if (funcs[0]) {
        builder.CreateCall(funcs[0], args);
    }
}



void Checker::InsertLoadFromFile(Function &F){

    BasicBlock &entryBlock = F.getEntryBlock();

    Instruction *firstInstruction = &*entryBlock.begin();

    IRBuilder<> builder(firstInstruction);
    builder.CreateCall(funcs[1], {});

}

void Checker::InsertPrintCPVar(Instruction *Inst){
    IRBuilder<> builder(Inst);
    builder.SetInsertPoint(Inst);
    builder.CreateCall(funcs[2], {});
}

void Checker::InsertResultUsed(Instruction *Inst,std::pair<std::string,std::string>&vfname,int BBNum,std::string fname,LLVMContext &context,GlobalVariable *flag,std::string BBname){

    std::string iiname = Inst->getOperand(0)->getName().str();
    std::string ffname = "GlobalVar";
    //找到变量名
    Instruction *inst;
    if (inst = dyn_cast<Instruction>(Inst->getOperand(0))) {
        while (1) {
            if (auto *it = dyn_cast<Instruction>(inst->getOperand(0))) {
                inst = it;
            } else break;
        }
        if (auto *it = dyn_cast<AllocaInst>(inst)) {
            //在函数内定义的变量
            iiname = it->getName().str();
            ffname = fname;
        }
        else {
            //全局变量
            if (auto gep = dyn_cast_or_null<GetElementPtrInst>(inst)) {
                if (auto globalVar = dyn_cast<GlobalVariable>(
                        gep->getOperand(0)->stripPointerCasts())) {
                    iiname = globalVar->getName().str();
                }
            }
        }
    }
    else {
        //全局变量
        iiname = getGlobalVariableName(Inst->getOperand(0));
        if (iiname == "")
            iiname = getGlobalVarNameFromString(Inst->getOperand(0));
    }
    if (judgeVarName(iiname, ffname)) {
        //errs() << iname << "\n";
        Value *operand = Inst->getOperand(0);
        if (auto *val = dyn_cast<Value>(operand)) {
            auto nextI = Inst->getNextNode();
            IRBuilder<> builder(nextI);
            builder.SetInsertPoint(nextI);

            std::vector<Value *> args;
            //获取此时flag的值,并作为参数传入 flag 为 int
            Value *flagValue = builder.CreateLoad(flag, "cher_flag");

            vfname.first = iiname;
            vfname.second = ffname;

            auto v = nametoaddr[vfname];
            ///指针变量的delete
            if(varsMap[v].vartype == "pointer" && BBname.find("delete.")!=std::string::npos) return;
            Value *vaddr = ConstantInt::get(Type::getInt64Ty(context), v);
            Value *bbNumValue = ConstantInt::get(Type::getInt32Ty(context), BBNum);

            args.push_back(flagValue);
            args.push_back(vaddr);
            ///insert bbNum
            args.push_back(bbNumValue);
            if (funcs[3]) {
                builder.CreateCall(funcs[3], args);
            }

        }
    }
}
unsigned Checker::getArrayDimension(Type *Ty) {
    if (ArrayType *arrayTy = dyn_cast<ArrayType>(Ty)) {
        // 递归调用自身并累加数组的维度
        return 1 + getArrayDimension(arrayTy->getElementType());
    } else {
        // 非数组类型返回0，表示当前层级不是数组
        return 0;
    }
}

void Checker::InsertVarUsed(Instruction *Inst,int BBNum,int count,GlobalVariable *flag,LLVMContext &context){
    ///在每个ddgNodeMap中出现的store后面插入
    IRBuilder<> builder(Inst);
    builder.SetInsertPoint(Inst);
    Value *flagValue = builder.CreateLoad(flag, "cher_flag");

    Value *bbNumValue = ConstantInt::get(Type::getInt32Ty(context), BBNum);
    Value *countValue = ConstantInt::get(Type::getInt32Ty(context), count);

    std::vector < Value * > args;
    args.push_back(flagValue);
    args.push_back(bbNumValue);
    args.push_back(countValue);

    if (funcs[4]) {
        builder.CreateCall(funcs[4], args);
    }
}

void Checker::InsertPoinConnArr(Instruction *Inst,std::string ciName,CallInst *callInst,
                                std::pair<std::string,std::string>&vfname,LLVMContext &context,std::string fname,GlobalVariable *Aarg,GlobalVariable *Farg,GlobalVariable *flag) {

    //如果是调用函数
    //1.获取call参数与对应的数组(指针) 与 参数个数
    //2.传参
    std::vector < Value * > args;
    //创建参数列表,对应数组列表
    std::vector < Constant * > aelements;
    std::vector < Constant * > felements;
    //n
    unsigned numArgs = callInst->getNumArgOperands();
    Type *int64Ty = Type::getInt64Ty(context);
    ArrayType *arrayType = ArrayType::get(int64Ty, numArgs);

    //找到函数的所有参数地址
    for (auto &v: funcArgsAddr[ciName]) {
        Constant *vargValue = ConstantInt::get(Type::getInt64Ty(context), v);
        felements.push_back(vargValue);
    }
    std::string variableName = "";

    //寻找传入函数的数组变量地址
    for (unsigned i = 0; i < callInst->getNumArgOperands(); ++i) {
        Value *arg = callInst->getArgOperand(i);
        ///全局变量
        variableName = getGlobalVariableName(arg);
        if (variableName == "")
            variableName = getGlobalVarNameFromString(arg);
        int tinst = 1;
        Instruction *inst = nullptr;
        if (variableName != "") {
            ///如果是全局变量
            tinst = 2;
        } else if (isa<Constant>(arg)) {
            ///如果是常量
            Constant *aargValue = ConstantInt::get(Type::getInt64Ty(context), 0);
            aelements.push_back(aargValue);
            continue;
        } else {
            ///普通变量
            if (inst = dyn_cast<Instruction>(arg)) {
                while (1) {
                    if (auto *it = dyn_cast<Instruction>(inst->getOperand(0))) {
                        inst = it;
                    } else break;
                }
            }

        }

        if (tinst == 1) {
            vfname.second = fname;//函数内变量
            //是一个变量
            if (inst) {
                if (auto *it = dyn_cast<AllocaInst>(inst))
                    variableName = inst->getName().str();
                else {
                    variableName = getGlobalVariableName(inst->getOperand(0));
                    if (variableName == "")
                        variableName = getGlobalVarNameFromString(
                                inst->getOperand(0));
                    //errs()<<variableName<<" inst \n";
                    vfname.second = "GlobalVar";
                }
            }
        } else {
            vfname.second = "GlobalVar";
        }
        vfname.first = variableName;
        if (nametoaddr.count(vfname)) {
            auto addr = nametoaddr[vfname];
            Constant *aargValue = ConstantInt::get(Type::getInt64Ty(context), addr);
            aelements.push_back(aargValue);
        }
    }
    IRBuilder<> builder(Inst);
    builder.SetInsertPoint(Inst);

    Value *n = ConstantInt::get(context, APInt(32, numArgs, false)); //n
    Value *flagValue = builder.CreateLoad(flag, "cher_flag");
    Value *ciNameValue = builder.CreateGlobalStringPtr(ciName, "");

    args.push_back(n);
    args.push_back(flagValue);
    args.push_back(ciNameValue);

    for (int i = 0; i < numArgs; ++i) {

        // 创建GEP指令，获取指向数组第i个元素的指针
        Value *indices[] = {ConstantInt::get(Type::getInt32Ty(context), 0),
                            ConstantInt::get(Type::getInt32Ty(context), i)};
        Value *aptr = GetElementPtrInst::CreateInBounds(Aarg, indices, "", Inst);
        if (i >= aelements.size()) {
            Constant *zero = ConstantInt::get(Type::getInt64Ty(context), 0);
            aelements.push_back(zero);
        }

        builder.CreateStore(aelements[i], aptr);
    }
    builder.SetInsertPoint(Inst);
    for (int i = 0; i < numArgs; ++i) {
        // 创建GEP指令，获取指向数组第i个元素的指针
        Value *indices[] = {ConstantInt::get(Type::getInt32Ty(context), 0),
                            ConstantInt::get(Type::getInt32Ty(context), i)};
        Value *fptr = GetElementPtrInst::CreateInBounds(Farg, indices, "", Inst);

        if (i >= felements.size()) {
            Constant *zero = ConstantInt::get(Type::getInt64Ty(context), 0);
            felements.push_back(zero);

        }

        builder.CreateStore(felements[i], fptr);
    }
    builder.CreateCall(funcs[5], args);


}

void Checker::InsertArrLenUsed(Instruction *Inst,int BBNum,int count,GlobalVariable *flag,LLVMContext &context,std::string fname) {

    ///是数组||指针
    if (ddgNodeMap[BBNum][count][0].vartype == "array" || ddgNodeMap[BBNum][count][0].vartype == "pointer") {
        ///处于循环中
        if (auto DL = Inst->getDebugLoc()) {
            unsigned Lno = DL.getLine();
            for (auto range: loopRangeList[fname]) {

                ///只需判断最大的循环（最外层的循环）
                if (range.second == 0 &&Lno >= range.first.first && Lno <= range.first.second) {

                    Instruction *nextInst = Inst->getNextNode();

                    IRBuilder<> builder(nextInst);
                    builder.SetInsertPoint(nextInst);

                    ///获取插入的变量
                    Value *flagValue = builder.CreateLoad(flag, "cher_flag");
                    Value *bbnumValue = ConstantInt::get(Type::getInt32Ty(context), BBNum);
                    Value *countValue = ConstantInt::get(Type::getInt32Ty(context), count);

                    std::vector < Value * > args;

                    args.push_back(flagValue);
                    args.push_back(bbnumValue);
                    args.push_back(countValue);

                    if (funcs[6]) {
                        builder.CreateCall(funcs[6], args);
                    }
                    return;
                }
            }
        }

    }

}

void Checker::InsertPoiSize(Instruction *Inst,GlobalVariable *flag,int BBNum,int count,LLVMContext &context) {
//    errs()<<BBNum<<","<<count<<"\n";

    if (ddgNodeMap[BBNum][count][0].vlocate == -3) {
//        errs() << "poisize = ==ds=af=ds=\n";
        ///代表 指针数组开辟空间
        ///向上找出_Znam,_Znaj
        ///call
        Instruction *inst = Inst;
        while (inst = dyn_cast<Instruction>(inst->getOperand(0))) {
//            errs() << "poisize\n";
            if (auto callInst = dyn_cast<CallInst>(inst)) {
                if (auto *cf = callInst->getCalledFunction()) {
                    auto ciName = cf->getName().str();
//                    errs() << ciName << "\n";
                    if (ciName == "_Znam" || ciName == "_Znaj" || ciName == "ma_malloc") {
//                        errs() << "-1\n";
                        Value *op = callInst->getArgOperand(0);
                        IRBuilder<> builder(callInst);
//                        errs() << "0\n";
                        /// size,addr,flag
                        std::vector < Value * > args;
                        Value *flagValue = builder.CreateLoad(flag, "cher_flag");
                        auto v = ddgNodeMap[BBNum][count][0].addr;
                        Value *vaddr = ConstantInt::get(Type::getInt64Ty(context), v);
//                        errs() << "1\n";
                        args.push_back(op);
//                        errs() << "2\n";
                        args.push_back(vaddr);
//                        errs() << "3\n";
                        args.push_back(flagValue);

                        if (funcs[7]) {
//                            errs() << "insert!!\n";
                            builder.CreateCall(funcs[7], args);
                            return;
                        }
                    }
                }
            }
        }
    }
}

void Checker::InsertFuncsIO(Function &F,GlobalVariable *flag,LLVMContext &context,std::string fname) {
    ///在每个函数下插入 funcsIO
    ///在每个函数的开头插入 flag , functionName
    ///如果函数是定义
    if(!F.isDeclaration()){
        if(BasicBlock *entryBlock = &F.getEntryBlock()){
            if(Instruction *firstInst = &(*entryBlock->begin())){

                if(firstInst->getOpcode() == Instruction::Call){
//                    errs()<<fname<< "\n";
                    IRBuilder<> builder(firstInst);
                    std::vector < Value * > args;
                    Value *flagValue = builder.CreateLoad(flag, "cher_flag");
                    Value *fnameValue = builder.CreateGlobalStringPtr(fname, "");

                    args.push_back(flagValue);
                    args.push_back(fnameValue);

                    if (funcs[8]) {
                        builder.CreateCall(funcs[8], args);
                        return;
                    }
                }

            }


        }
    }




}

void Checker::InsertFreeIO(Instruction *Inst,CallInst *callInst,LLVMContext &context,GlobalVariable *flag) {
//    IRBuilder<> builder(firstInst);
//    std::vector < Value * > args;
//    Value *flagValue = builder.CreateLoad(flag, "cher_flag");
//    args.push_back(flagValue);
    errs()<<"inst : "<<*Inst<<"\n";
    Instruction *inst = nullptr;
    Instruction *callinst = nullptr;


//    errs()<<*inst->getOperand(0)<<"\n";
//    errs()<<*callInst->getOperand(0)<<"\n";
    if(inst = dyn_cast<Instruction>(Inst->getOperand(0)))
        while (1) {
            if (auto *it = dyn_cast<Instruction>(inst->getOperand(0))) {
                inst = it;
            } else break;
        }
    if(callinst = dyn_cast<Instruction>(callInst->getOperand(0)))
        while (1) {
            if (auto *it = dyn_cast<Instruction>(callinst->getOperand(0))) {
                callinst = it;
            } else break;
        }

    //errs()<<*inst<<"\n";
    //errs()<<*callinst<<"\n";
}

void Checker::InsertArrIdx(Instruction *Inst,int BBNum,int count,GlobalVariable *flag,LLVMContext &context,std::string fname) {

    IRBuilder<> builder(Inst);
    std::vector < Value * > args;
    Value *ArrayElementPtr = Inst->getOperand(1); // 假设这是正确的指针
    Value *ArrayElementValue = builder.CreateLoad(ArrayElementPtr);

    unsigned dimCount;
    std::vector<Value*>idxs;

    if (auto *GEPOp = dyn_cast<GetElementPtrInst>(Inst->getOperand(1))) {
        // 获取GetElementPtr指令的源元素类型
        Type *sourceElementType = GEPOp->getSourceElementType();
        if (auto *arrayType = dyn_cast<ArrayType>(sourceElementType)) {
//                        errs() << "Source ElementType: " << *arrayType << " : -> ";
//                        errs()<<getArrayDimension(arrayType)<<"\n";
//                        errs() << "Specific part: [" << arrayType->getNumElements() << "]\n";
            dimCount = getArrayDimension(arrayType);///获取维度
        }

        ///获取idx
        Value* idx = GEPOp->getOperand(2);
        Value* idxValue = builder.CreateLoad(idx);
        idxs.push_back(idx);

        //if(auto* inst = dyn_cast<Instruction>(Inst->getOperand(1)))
          //  GetArrIdx(inst,idxs,builder);

    }


    args.push_back(ArrayElementValue);
    if (Inst->getOperand(1)->getType() == Type::getDoublePtrTy(Inst->getParent()->getContext())) {
        if (funcs[10]) {
            builder.CreateCall(funcs[10], args);
        }
    } else if (Inst->getOperand(1)->getType() == Type::getFloatPtrTy(Inst->getParent()->getContext())) {
        if (funcs[11]) {
            builder.CreateCall(funcs[11], args);
        }
    }

}

void Checker::GetArrIdx(Instruction *Inst,std::vector<Value*> idxs,IRBuilder<> builder()){
    if (auto *GEPOp = dyn_cast<GetElementPtrInst>(Inst->getOperand(0))) {
        //Value* idx = GEPOp->getOperand(2);
        //Value* idxValue = builder.CreateLoad(idx);
        //idxs.push_back(idx);
        //GetArrIdx(Inst->getOperand(0),idxs,builder);
    }
}

//判断函数名
bool Checker::judgeFuncName(std::string fname) {
    for (auto& name : funcNameList) {
        if (fname == name) return true;
    }
    return false;
}
//判断变量名
bool Checker::judgeVarName(std::string vname,std::string fname) {
    for (auto& name : varNameList) {
        if (name.first == vname && name.second == fname) return true;
    }
    return false;
}

void Checker::InsertFunction(Module& M) {
    LLVMContext &context = M.getContext();
    int BBNum = -1;
    //全局变量flag ,用来判断mainloop
    GlobalVariable *flag = M.getGlobalVariable("cher_flag");
    GlobalVariable *Aarg = M.getGlobalVariable("cher_Aarg");//调用函数传参
    GlobalVariable *Farg = M.getGlobalVariable("cher_Farg");//原函数参数


//    GlobalVariable *Farg = M.getGlobalVariable("cher_ArrayIdx");//数组下标


    for(auto &var : varsMap){
        auto v = var.second;
        if(v.vartype == "array")
            arrRoot[v.addr] = v;
    }

    for (auto &F: M) {
        auto Fname = F.getName().str();

        if (!judgeFuncName(Fname)) continue;
//        errs()<<Fname<<" : \n";
        int mainInsertOutput = 0;
        if (Fname == "main") {
            //在main的第一条指令之前
            ///插入 loadfromfile
            InsertLoadFromFile(F);
            mainInsertOutput = 1;
        }
        ///判断函数是否在flag == 1下运行,对旗下所有变量设置为in
        InsertFuncsIO(F,flag,context,Fname);

        for (auto &BB: F) {
            auto BBname = BB.getName().str();
            if (BBname.find("invoke") != std::string::npos ||
                BBname.find("lpad") != std::string::npos ||
                BBname.find("ehcleanup") != std::string::npos) continue;


            auto fname = F.getName().str();
            Instruction *lastStoreInst = nullptr;
            BBNum = getbbNum(BB);
            int count = 0;//第几个`=`
            int flagcount = 0;//如果flag =1 出现了
            for (auto &I: BB) {

                //在每一个exit()函数前插入printcheckpointVar函数
                //在每个call指令之前插入cher_PoinConnArr
                if (I.getOpcode() == Instruction::Call) {
                    //errs() << I.getName() << "\n";
                    if (auto *callInst = dyn_cast<CallInst>(&I)) {
                        if (auto *CI = callInst->getCalledFunction()) {
                            auto ciName = CI->getName().str();
                            if (ciName == "exit") {
                                InsertPrintCPVar(&I);
                            }
                            if (ciName.find("llvm.memcpy.") != std::string::npos) {
                                //放在最后一个`=`之后
                                lastStoreInst = &I;
                                Instruction *nextInst = I.getNextNode();
                                if (nextInst && count < ddgNodeMap[BBNum].size()) {
                                    ////arrLenUsed
                                    InsertArrLenUsed(&I, BBNum, count,flag,context,fname);
                                    ///varused
                                    InsertVarUsed(nextInst, BBNum, count,flag,context);
                                }
                                count++;
                            }
                            if (funcArgsAddr.count(ciName) && judgeFuncName(ciName)) {
//                            if (judgeFuncName(ciName)) {
//                                if(ciName == "free") errs()<<"free nn\n";
                                InsertPoinConnArr(&I, ciName, callInst, vfname, context,fname,Aarg,Farg,flag);
                            }
//                            if(ciName.find("Free")!=std::string::npos){
//                                InsertFreeIO(&I,callInst, context,flag);
//                            }

                        }
                    }
                }
                //排除掉flag
                if (I.getOpcode() == Instruction::Store) {
                    //排除 store i32 %n1, i32* %n1.addr
                    std::string s1 = I.getOperand(0)->getName().str()+".addr";
                    std::string s2 = I.getOperand(1)->getName().str();
                    if(s2.find("retval")!=std::string::npos){
                        //当第一个 `=`为 retval ,排除
                    }
                    else if(s1 != s2){
                        if (I.getOperand(1)->getName().str() == "cher_flag") {
                            flagcount = count;
                        }
                        else {
                            //获取一个块中的最后一个store指令
                            lastStoreInst = &I;

                            //在每一个store后面插入cher_varused
                            Instruction *nextInst = I.getNextNode();
                            if (nextInst && ddgNodeMap.count(BBNum) &&count < ddgNodeMap[BBNum].size()) {
                                ////arrLenUsed
                                InsertArrLenUsed(&I,BBNum,count,flag,context,fname);
                                ///varused
                                InsertVarUsed(nextInst,BBNum,count,flag,context);
                                ///指针数组 new,malloc etc
                                InsertPoiSize(&I,flag,BBNum,count,context);
                            }

                            count++;
                        }
                    }



                    if(I.getOperand(1)->getName().str().find("arrayidx")!=std::string::npos) {
                        ///插入数组监督指令（用于监督数组元素）
                        //InsertArrIdx(&I,BBNum,count,flag,context,fname);
                        ///%arrayidx  代表是数组中的某个元素
                    }

                }
                //在每一个load函数后面插入函数resultUsed
                if (I.getOpcode() == Instruction::Load) {
                    InsertResultUsed(&I,vfname,BBNum,fname,context,flag,BBname);

                }
                if(Fname == "main" && I.getOpcode() == Instruction::Ret){//在ret之前
                    InsertPrintCPVar(&I);
                    mainInsertOutput = 0;
                }

                //在每个块插入cher_mpused main loop 所处块是否被使用
            }

            //在最后一个store指令之后插入
            if (lastStoreInst) {
                //errs() << Fname << " : " << BB.getName() <<" : "<<BBNum << "\n";

                Instruction *nextInst = lastStoreInst->getNextNode();
                if (nextInst) {
                    InsertDDgtoEddg(nextInst,BBNum,flagcount,flag,context);
                }
            }

            //BBNum++;
        }

        if(Fname == "main" && mainInsertOutput){//如果main 函数中没有ret指令 ,那么把输出函数插在最后一条指令之前
            BasicBlock &lastBB = F.back();
            Instruction &lastInst = lastBB.back();
            InsertPrintCPVar(&lastInst);
        }

    }
}

bool Checker::doInitialization(Module& M) {
    initDDGMap(M);
    InsertFunction(M);
    return true;
}

bool Checker::runOnFunction(Function& F) {
    return false;
}
char Checker::ID = 0;
static RegisterPass<Checker> X("checker", "hello pass", false, false);



