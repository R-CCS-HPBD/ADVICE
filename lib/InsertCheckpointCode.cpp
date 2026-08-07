//
// Created by KLzhang on 2024-01-05.
//

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

#include <sstream>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <vector>
#include <map>
#include <utility>
#include <string>
#include <set>

using namespace llvm;

extern "C" {
void* malloc(size_t);
}

#include "CheckerPaths.h"

#define FILELIB cher_dataDir()
namespace {
    struct InsertCheckpointCode : public FunctionPass {
        static char ID;
        int mainloopbegin = 0;
        int mainloopend = 0;
        std::string mainLoopFuncName;

        GlobalVariable *cpc_Rank;
        GlobalVariable *cpc_Loc;

        Function *readCpFunc;
        Function *writeCpFunc;

        void loadFromFileToMainLoop();
        void loadFromFileToCpVars();

        void findCpVarsAlloca();

        void findCpVarsAlloca(Module& M);
        void insertCheckpointCode(Module& M);
        void dCPCVar(Module& M);

        std::string getTypeToString(Type* valType);

        unsigned vReByte(std::string vtype,unsigned elems);

        struct cpNode{
            std::string vname;
            std::string fname;
            std::string vtype;///实际类型

            unsigned elemsTotal;///元素个数

            unsigned bytes = 0;///字节数
            Value* v = NULL;
        };

        std::set<std::string>cpFnames;
        std::map<std::string ,cpNode>cpVarsMap;///存储所有的cp变量
//        std::vector<cpNode>cpVarsMap;

        InsertCheckpointCode() : FunctionPass(ID) {}
        void getAnalysisUsage(AnalysisUsage& AU) const override {
            AU.setPreservesAll();
            AU.addRequired<LoopInfoWrapperPass>();
        }

        bool runOnFunction(Function& F);
        bool doInitialization(Module& M);
    };

}

void InsertCheckpointCode::dCPCVar(Module& M){
    LLVMContext &Context = M.getContext();
    Type *Int32Ty = Type::getInt32Ty(Context);

    ///创建全局变量 rank、location
    // 创建全局变量 cpc_Rank
    cpc_Rank = new GlobalVariable(M, Int32Ty, false,GlobalValue::ExternalLinkage, nullptr, "cpc_Rank");
    cpc_Rank->setInitializer(ConstantInt::get(Int32Ty, 0)); // 初始化为 0
    // 创建全局变量 cpc_Loc
    cpc_Loc = new GlobalVariable(M, Int32Ty, false,
                                                 GlobalValue::ExternalLinkage, nullptr, "cpc_Loc");
    cpc_Loc->setInitializer(ConstantInt::get(Int32Ty, 0)); // 初始化为 0

    ///找到write_cp和read_cp
    readCpFunc = M.getFunction("read_cp");
    writeCpFunc = M.getFunction("write_cp");

}

void InsertCheckpointCode::loadFromFileToMainLoop() {
    std::string filename = FILELIB+"mainloopData.txt";
    std::ifstream file(filename);
    if (file.is_open()) {
        std::string line;
        //获取main loop所在的范围
        if (std::getline(file, line)) {
            //errs() << "the line is " << line << "\n";
            std::string str = "";
            for (int i = 0; i < line.size(); ++i) {
                if (line[i] != ',') str += line[i];
                else {
                    mainloopbegin = std::stoi(str);
                    str = "";
                }
            }
            mainloopend = std::stoi(str);
        }
        //获取main loop所在的文件名
        if (std::getline(file, line)) {
            mainLoopFuncName = line;
        }

        file.close();
    }
    errs() << mainLoopFuncName << "\n";
}

void InsertCheckpointCode::loadFromFileToCpVars() {
    std::string filename = FILELIB+"cp.txt";
    std::ifstream file(filename);
    if (file.is_open()) {
        std::string line;
        if (std::getline(file, line)) {
            std::stringstream ss(line);
            std::string token;
            std::vector<std::string> tokens;
            while (std::getline(ss, token, ',')) {
                tokens.push_back(token);
                //printf("%s\t", token.c_str());
            }
            if (tokens.size() == 4) {
                std::string fname = tokens[0];
                std::string vname = tokens[1];
                std::string vtype = tokens[2];
                unsigned elemsTotal = std::stoi(tokens[3]);
                cpNode ce ;
                ce.fname = fname;
                ce.vname = vname;
                ce.vtype = vtype;
                ce.elemsTotal = elemsTotal;
                ///初始化cpVarsMap
                cpVarsMap[vname] = ce;
                cpFnames.insert(fname);
            }
        }
        file.close();
    }

    for(auto var : cpVarsMap)
        std::cout<<var.second.vname<<"\n";
    }

}

void InsertCheckpointCode::findCpVarsAlloca(Module& M) {

    ///全局变量
    for (auto& G : M.getGlobalList()) {
        if (G.hasInitializer()) {
            std::string name = G.getName().str();
            ///与对应的Cp变量匹配
            if(cpVarsMap.count(name)&&cpVarsMap[name].fname == "GlobalVar"){
                ///存在当前变量
                cpVarsMap[name].v = &G;

                Type *vType = G.getValueType();
                if (PointerType *ptrType = dyn_cast<PointerType>(vType)) {
                    Type *elementType = ptrType->getElementType();
                    std::string vtype = getTypeToString(elementType);
                    if(cpVarsMap[name].vtype == "pointer")
                        cpVarsMap[name].vtype = vtype;
                }

            }
        }
    }

    ///局部变量
    for (auto& F : M) {
        auto Fname = F.getName().str();
        if(!cpFnames.count(Fname)) continue;
        for (auto& BB : F) {
            for (auto& I : BB) {
                if (I.getOpcode() == Instruction::Alloca) {
                    if (auto* AI = dyn_cast<AllocaInst>(&I)) {
                        std::string Vname = AI->getName().str();
                        if(cpVarsMap.count(Vname) && cpVarsMap[Vname].fname == Fname){
                            ///匹配成功
                            cpVarsMap[Vname].v = AI;
                        }
                    }
                }
            }
        }
    }
    for(auto var : cpVarsMap){
        std::cout<<var.second.vname<<","<<var.second.vtype<<","<<var.second.bytes<<"\n";
    }

}

void InsertCheckpointCode::insertCheckpointCode(Module& M){
    LLVMContext &Context = M.getContext();
    IRBuilder<> Builder(Context);
    int b = 0;
    for (auto& F : M) {
        if(!F.getName().str().compare(mainLoopFuncName)) continue;
        for (auto &BB: F) {
            for (auto &I: BB) {
                if (auto DL = I.getDebugLoc()) {
                    unsigned lineNo = DL.getLine();
                    ///在main loop前插入 read_cp
                    if(lineNo == mainloopbegin){
                        IRBuilder<> builder(&I);
                        /***
                         * 插入read_cp
                         * 1.rank,location (cpc_Rank,cpc_Locaiton)
                         * 2.iter,data
                         * for（—）找iter Alloca，data从开头找Alloca -- load
                         * 3.size,从file中获取
                        */
                        for(auto &var:cpVarsMap){
                            Value *rank = cpc_Rank;
                            Value *location = cpc_Loc;
                            Value *iter = Builder.CreateAlloca(Type::getInt32Ty(Context));
                            Value *data = var.second.v;
                            
                            var.second.bytes = vReByte(var.second.vtype,var.second.elemsTotal);
                            Value *size = builder.getInt32(Buildervar.second.bytes);
     
                            Builder.CreateCall(readCpFunc, {rank, iter, location, data, size});
                        }

                        b++;
                    }

                    if(auto *BranchInst = dyn_cast<BranchInst>(&I)){
                        if (BranchInst->isConditional()) {
                            BasicBlock *end = BranchInst->getSuccessor(1);
                            ///获取第一条非PHI指令
                            Instruction *firstInst = end->getFirstNonPHI();
                            ///插入write_cp
                            for(auto &var:cpVarsMap){
                                Value *rank = cpc_Rank;
                                Value *iter = Builder.getInt32(1);
                                Value *data = var.second.v;
                                
                                var.second.bytes = vReByte(var.second.vtype,var.second.elemsTotal);
                                Value *size = builder.getInt32(Buildervar.second.bytes);
                                
                                Builder.CreateCall(writeCpFunc, {rank, iter, data, size});
                            }
                            b++;
                            return;
                        }
                    }
                }

            }
        }
    }
    if(b == 2){
        errs()<<"Insert read_cp and write_cp success!!!\n";
    }

}

std::string InsertCheckpointCode::getTypeToString(Type* valType) {
    std::string varty="";
    if (valType->isIntegerTy()) {
        if (valType->isIntegerTy(1)) {
            // val是布尔类型
            varty = "bool";
        }
        else if (valType->isIntegerTy(8)) {
            // val是8位整数类型
            varty = "int8";
        }
        else if (valType->isIntegerTy(16)) {
            // val是16位整数类型
            varty = "int16";
        }
        else if (valType->isIntegerTy(32)) {
            // val是32位整数类型
            varty = "int32";

        }
        else if (valType->isIntegerTy(64)) {
            // val是64位整数类型
            varty = "int64";

        }
        else {
            // 其他整数类型
            varty = "int";
        }
    }
    else if (valType->isFloatingPointTy()) {
        if (valType->isFloatTy()) {
            // val是单精度浮点数类型
            varty = "float";

        }
        else if (valType->isDoubleTy()) {
            // val是双精度浮点数类型
            varty = "double";

        }
        else {
            // 其他浮点数类型
            varty = "fd";

        }
    }
    else if (valType->isPointerTy()) {
        // val是指针类型
        varty = "pointer";

    }
    else if (valType->isVectorTy()) {
        // val是向量类型
        varty = "vector";

    }
    else if (valType->isArrayTy()) {
        // val是数组类型
        varty = "array";

    }
    else if (valType->isStructTy()) {
        // val是结构体类型
        varty = "struct";

    }
    else if (valType->isFunctionTy()) {
        // val是函数类型
        varty = "function";

    }
    else if (valType->isLabelTy()) {
        // val是标签类型
        varty = "label";

    }
    else {
        // 其他类型
        varty = "other";
    }
    return varty;
}

unsigned InsertCheckpointCode::vReByte(std::string vtype,unsigned elems){
    if(vtype == "int") return sizeof(int) * elems;
    if(vtype == "double") return sizeof(double)*elems;
    if(vtype == "float") return sizeof (float )*elems;
}
bool InsertCheckpointCode::doInitialization(Module& M) {
    dCPCVar(M);

    ///load 相关数据
    loadFromFileToMainLoop();
    loadFromFileToCpVars();

    ///找到所有的Cp变量的alloca
    findCpVarsAlloca(M);

    insertCheckpointCode(M);
    return true;
}
bool InsertCheckpointCode::runOnFunction(Function& F) {
    return false;
}
char InsertCheckpointCode::ID = 0;
static RegisterPass<InsertCheckpointCode> X("insertcheckpointcode", "hello pass", false, false);

