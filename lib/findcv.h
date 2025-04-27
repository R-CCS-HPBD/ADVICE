#ifndef FINDCV_H
#define FINDCV_H

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

#include "llvm/IR/GetElementPtrTypeIterator.h"
#include <unordered_map>
#include <unordered_set>
#include <string>
#include <fstream>
#include <queue>
#include <fstream>
#include <sstream>

struct varNode {
    uint64_t addr;
    std::string vname;
    std::string fname;
    int m_user;
};

class findcv : public llvm::FunctionPass {
public:
    static char ID;
    findcv() : llvm::FunctionPass(ID) {
        functionIter = 0;
        mainloopbegin = 0;
        mainloopend = 0;
        std::string mainLoopFuncName = "";
    }

    bool runOnFunction(llvm::Function &F) override;
    bool doInitialization(llvm::Module &M) override;
    void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

    void getGlobalVarNodeMessage(llvm::Module &M);
    void getLocalVarNodeMessage(llvm::Module &M);
    void writeResultsToFile();
    bool checkedFuncName(std::string funcName);
    void checkVariableInLoop(const llvm::Function &F, const llvm::LoopInfo &LI);
    bool insertFlag(llvm::Module& M);
    bool initData(llvm::Module& M);
    void loadCgData();
    void BFS(std::string fname);

private:
    varNode m_vnode;
    std::unordered_map<uint64_t, varNode> varsData; /// 存储所有变量
    std::unordered_map<uint64_t, varNode> varsGlobalData; /// 存储所有全局变量
    std::unordered_map<uint64_t, varNode> varsTmpData; /// 存储所有局部变量

    std::unordered_map<std::string,llvm::Function*> funcsData;///存储对应的函数
    std::unordered_set<std::string> visited_funcs;
    llvm::GlobalVariable *cher_flag; // 声明 cher_flag 变量
    int functionIter;
    int mainloopbegin;
    int mainloopend;
    std::string mainLoopFuncName;

};

#endif // FINDCV_H
