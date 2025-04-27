#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <string>
#include <cstring>
#include <sstream>
#include <cstdint>
#include<unordered_map>
#include<unordered_set>
#include <fstream>


using namespace std;

#define CHERARGMAX 20

//ddg
struct cher_varNode {
    uint64_t addr;
    std::string vname;
    int bbnum;
    std::string fname;
    int vlocate;
    std::string user;//函数内定义还是函数外定义
    std::string vartype;//变量类型
    unsigned varsize;//变量空间大小
};
struct cher_cpNode {
    uint64_t addr;
    std::string vname;
    std::string fname;
    std::string user;

    ////对应的原数组
    //std::string ffname;
    //std::string vvname;

    int read =0;//读
    int write=0;//写
    int wor=-1;//当前变量的状态(最新变量的状态) 初始为-1,1为read,2为write
    int cp=0;//需要cp的变量

    std::string type;

    unsigned varsize;
};

//需要cp的变量
struct cher_cpVar {
    uint64_t addr;
    uint64_t vvaddr;
    string vname;
    string fname;
    string vvname;
    string ffname;
    string state;
    string type;
};


///仅存储数组
struct cher_arrNode{
    uint64_t addr;
    std::string vname;
    int bbnum=-1;
    std::string fname;
    int vlocate=-1;
    std::string user;
    std::string vartype;//变量类型
    unsigned dim;///数组维度
    unsigned dimElems[10];///默认数组维度不超过10

    unsigned elemsTotal;

    unsigned elemsWrite = 0; ///被`write`元素个数
    unsigned elemsRead = 0;/// 被`read`元素个数
    /*
     *
     * 用来判断变量是不是连续`write` 后 连续`read` || 一次`write` ,一次 `read`
     */
    int wradd = 0;///`write` +1 ,`read` -1
};

uint64_t cher_Aarg[CHERARGMAX];//传入变量
uint64_t cher_Farg[CHERARGMAX];//函数参数

int cher_argLen = 0;

int cher_arrLenArgs[CHERARGMAX];///循环中数组维度的覆盖长度
int cher_varLenArgs[CHERARGMAX];///循环变量

std::map<int, std::vector<std::vector<cher_varNode>>>cher_ddgNodeMap;

//存储所有的变量 ---
std::unordered_map<uint64_t, cher_varNode > cher_varsMap;

///存储数组变量
std::unordered_map<uint64_t, cher_arrNode > cher_arrVarsMap;


std::unordered_map< uint64_t, cher_cpNode> cher_checkpointList;

std::unordered_map<int,set<vector<uint64_t>>>cher_bbnums; /// 根据参数 以及 bbnum 来判断重复

std::map<string,set<pair<uint64_t,string>>> cher_varTF;//修改变量的out ,in

std::unordered_map<uint64_t ,string>cher_varTFOI;//当前变量 is "out" or "in" (flag == 1)

std::unordered_map<string,int> cher_varTFOI_ForFnameUsed;

std::unordered_set<string> cher_globalUser;

std::unordered_map<uint64_t ,cher_cpVar>cher_CPVar;

std::unordered_map<uint64_t, uint64_t>cher_arrConnPoint; // a = cher_arrConnpoint[a] ,临时变量 对应 原变量

///main loop 相关
std::string cher_funcName="";
int cher_mainloopbegin;
int cher_mainloopend;

int cher_funcNameAppear = 0;///main loop出现的次数
//把 x.addr 与 x地址结合(x为函数参数,x.addr函数内部自定义的x)
std::unordered_map<uint64_t,uint64_t>cher_VarAddrToReal;

int cher_num = 0;


///files data
//std::string LOADFILEADDR = "/home/zwp82/workspace/LLVM-Checker/lib/Data/";
std::string LOADFILEADDR = "/workspace/LLVM-Checker/lib/Data/";

string cher_dataFiles[10] = {"dataMap.txt","varsMap.txt","arrVarsMap.txt","mainloopData.txt"
                               ,"outfile.txt" ,"cp.txt","IO.txt"};



uint64_t cher_findArr(uint64_t addr) {

    //函数参数与传入变量链接
    if (cher_arrConnPoint[addr] == addr || cher_arrConnPoint[addr] == 0) return addr; //本身是数组,或者是指针
    return cher_findArr(cher_arrConnPoint[addr]);

}

//参数列表 与 参数个数 还需要函数参数
void cher_PoinConnArr(int n,int flag,const char *funcName) {

    cher_argLen = n;

//    cout<<"cpca\n";
    for (int i = 0; i < n; ++i) {
        //初始化
        uint64_t addr;
        if(cher_VarAddrToReal.count(cher_Farg[i])){
            //将函数变量与传入变量连接起来
            addr = cher_findArr(cher_Aarg[i]);
            cher_arrConnPoint[cher_VarAddrToReal[cher_Farg[i]]] = addr;
        }
        addr = cher_findArr(cher_Aarg[i]);//将参数对应原数组
        cher_arrConnPoint[cher_Farg[i]] = addr;

        ///
        std::string fname = funcName;

        if(flag == 1){
            if(fname.find("Destroy")!=std::string::npos){
                if(cher_varTFOI[addr] != "in"){
                    cher_varTFOI[addr] = "in";
                }
            }
        }
//        if(flag == 1 && fname.find("Free")!=std::string::npos){
//            if(cher_varTFOI[addr] != "in"){
//                cher_varTFOI[addr] = "in";
//                if(cher_checkpointList[addr].vname .find("pcg_")!=std::string::npos){
//                    cout<<cher_checkpointList[cher_Farg[i]].vname<<","
//                        <<cher_checkpointList[cher_Aarg[i]].vname<<","<<cher_checkpointList[addr].vname<<endl;
//                }
//
//            }
//        }

//        if(cher_varsMap[cher_Farg[i]].vname == "gmres_data" ||cher_varsMap[cher_Aarg[i]].vname == "gmres_data" ||cher_varsMap[addr].vname == "gmres_data")
//            cout<<cher_varsMap[cher_Farg[i]].vname<<" : "<<cher_varsMap[cher_Aarg[i]].vname<<" : "<<cher_varsMap[addr].vname<<endl;
    }

    // 如果 flag == 1,那么把当前函数下的所有定义的变量设为 in
//    if(funcName!=cher_funcName && flag == 1 && cher_varTFOI_ForFnameUsed.count(funcName)){
//        if(cher_varTFOI_ForFnameUsed[funcName]){
//            cher_varTFOI_ForFnameUsed[funcName] = 0;///代表已经判断过了
//
//            for(auto v :cher_varTF[funcName]){
//                v.second="in";
//                cher_varTFOI[v.first] = v.second;
//
//            }
//
//
//        }
//    }


    ///当main loop处于一个函数,这个函数被多次调用 ,需要判断有效性
    /// 如果这个函数每次传入的变量是相同的,那么只需要判断一次,如果传入的变量是不同的,需要多次判断.
    if(funcName == cher_funcName) cher_funcNameAppear++;


}


void cher_funcsIO(int flag,const char *funcName){
      // HPCCG return;
     //return;
    //cout<<"cher_funcsIO\n"<<endl;
    //if(flag != 1 && cher_funcName != "main") return;
     
    if(funcName!=cher_funcName && cher_varTFOI_ForFnameUsed.count(funcName) ){
        if(flag == 1  || cher_funcName == "main"){
		
            if(cher_varTFOI_ForFnameUsed[funcName]){
                cher_varTFOI_ForFnameUsed[funcName] = 0;
                for(auto v :cher_varTF[funcName]){
                    v.second="in";
                    cher_varTFOI[v.first] = v.second;
                }
            }
        }

    }
    
//    string fname = funcName;
//    if(flag == 1 && fname.find("Free")!=std::string::npos ){
//        for (int i = 0; i < cher_argLen; ++i) {
//
//        }
//    }
}

//vod cher_FreeIO(int flag,uint64_t addr1,uint64_t addr2){
//
//}

void cher_loadfromfile() {

    std::ifstream file(LOADFILEADDR+cher_dataFiles[0]);//"dataMap.txt"
    if (file.is_open()) {
        std::string line;
        int key = -1;
        while (std::getline(file, line)) {
            if (line.empty()) {
                continue;
            }
            if (line != "=" && line.find(",") == std::string::npos) {
                //查找块号  (这一行没有 , 和 =)
                key = std::stoi(line);

                cher_ddgNodeMap[key];
            }
            else if(line == "=") {
                std::vector<cher_varNode> vec;
                while (std::getline(file, line)&& line.find(",") != std::string::npos) {
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
                    cher_ddgNodeMap[key].push_back(vec);

                    if (line != "="&&line!="") {
                        key = std::stoi(line);

                        cher_ddgNodeMap[key];
                    }
                }
            }
        }
        file.close();
    }

    //获取varsMap中数据
    std::ifstream file4(LOADFILEADDR+cher_dataFiles[1]);//"varsMap.txt"
    if (file4.is_open()) {
        std::string line;
        //获取main loop所在的范围
        while (std::getline(file4, line)) {
            std::stringstream ss(line);
            std::string token;
            std::vector<std::string> tokens;
            cher_varNode var;
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

                cher_varsMap[addr] = var;
                if(vname!=""){///变量名不为空
                    if(vname.find(".") == std::string::npos){///变量名中不含"."
//                        if(vname.find("tmp") == std::string::npos){///变量名中不含有"tmp"
                            //如果该变量不是 地址变量,临时变量
                            pair <uint64_t, string> addruser;
                            addruser.first = addr;
                            addruser.second = user;

                            cher_varTF[fname].insert(addruser);

                            cher_varTFOI[addr] = user;

                            ///判断此函数是否在main loop中出现
                            cher_varTFOI_ForFnameUsed[fname] = 1;
//                        }
                    }
                }


                //参数 === 函数内定义变量
                if(bbnum == -2){//key 为参数
                    cher_VarAddrToReal[addr];
                }

            }
        }
        file4.close();
    }

    //获取arrVarsMap中数据 ???
    std::ifstream file5(LOADFILEADDR+cher_dataFiles[2]);//"arrVarsMap.txt"
    if (file5.is_open()) {
        std::string line;
        //获取main loop所在的范围
        while (std::getline(file5, line)) {
            std::stringstream ss(line);
            std::string token;
            std::vector<std::string> tokens;
            cher_arrNode var;
            while (std::getline(ss, token, ',')) {
                tokens.push_back(token);
            }
            if (tokens.size() >= 8) {
                uint64_t addr = std::stoull(tokens[0]);
                std::string vname = tokens[1];
                int bbnum = std::stoi(tokens[2]);
                std::string fname = tokens[3];
                int vlocate = std::stoi(tokens[4]);
                std::string user = tokens[5];
                std::string vartype = tokens[6];
                unsigned dim = std::stoi(tokens[7]);

                var.addr = addr;
                var.vname=vname;
                var.bbnum = bbnum;
                var.fname = fname;
                var.vlocate = vlocate;
                var.user = user;
                var.vartype = vartype;
                var.dim = dim;
                var.elemsTotal = 1;
                for(int i = 0;i<dim;++i){
                    unsigned dimelem = std::stoi(tokens[8+i]);
                    var.dimElems[i] = dimelem;
                    var.elemsTotal *=dimelem; ///获取元素总数
                }
                cher_arrVarsMap[addr] = var;
            }
        }
        file5.close();
    }

    ///获取main loop相关数据
    std::ifstream file6(LOADFILEADDR+cher_dataFiles[3]);//"mainloopData.txt"
    if(file6.is_open()){
        std::string line;
        if (std::getline(file6, line)) {
            std::string str = "";
            for (int i = 0; i < line.size(); ++i) {
                if (line[i] != ',') str += line[i];
                else {
                    cher_mainloopbegin = std::stoi(str);
                    str = "";
                }
            }
            cher_mainloopend = std::stoi(str);
        }
        if (std::getline(file6, line)) {
            for (int i = 0; i < line.size(); ++i) {
                cher_funcName+=line[i];
            }

        }
    }


    //对checkpointList进行初始化
    for(auto &var : cher_varsMap){
        auto v = var.second;
        if(0 == v.vname.length()) continue;
        uint64_t addr = v.addr;
        cher_checkpointList[addr].vname = v.vname;
        cher_checkpointList[addr].fname = v.fname;
        cher_checkpointList[addr].user = v.user;
        cher_checkpointList[addr].read = 0;//0代表变量未被读入
        cher_checkpointList[addr].write = 0;//0代表变量未被写入
        cher_checkpointList[addr].wor = -1;//初始化值
        cher_checkpointList[addr].cp = 0;
        cher_checkpointList[addr].type = v.vartype;
        cher_checkpointList[addr].varsize = v.varsize;
        //初始化并查集
        if (cher_checkpointList[addr].type != "pointer" && !cher_VarAddrToReal.count(addr)) {
            ///该变量类型不为指针类型  , 该变量不是函数参数
            ///该变量不是.addr
            if(v.vname.find(".")==std::string::npos){
                cher_arrConnPoint[addr] = addr;
            }

        }
        if(cher_checkpointList[addr].fname == "GlobalVar"){
            ///全局变量
            cher_arrConnPoint[addr] = addr;
        }
        //将参数与函数内定义变量连接起来
        //找出对应的参数[key为参数,value为变量]
        for(auto par: cher_VarAddrToReal) {
            auto p = par.first;
            auto pv = cher_varsMap[p];
            if (pv.fname == v.fname && v.addr != pv.addr) {
                //在一个函数中且不是同一个变量
                //参数
                //其他情况(非结构体情况)
                auto pvName = pv.vname;
                if (v.vname == pvName + ".addr") {
                    //找到对应变量
                    cher_VarAddrToReal[p] = v.addr;
                    break;
                }
            }
        }
    }

}

void cher_printcheckpointVar() {
    cout << "\nneed checkpoint var : \n\n";

    for (auto var : cher_CPVar) {
        auto v = var.second;

//        cout<<cher_arrVarsMap[v.addr].vname<<" == \n";
        if( cher_arrVarsMap.count(v.addr) && cher_arrVarsMap[v.addr].user != "out") continue;

        if(cher_varTFOI[v.addr] == "in") continue;


//        if(v.vname == "pcg_precond" || v.vname == "pcg_solver" ) continue;
        cout << "(" << v.state << ")\t";
        cout << "func " << v.fname << " , " << v.vname << endl;
    }
    cout << "\nthe end!!\n";
/*
    for(auto arrVars:cher_arrVarsMap){
//        if(arrVars.second.vname == "from"){
            cout<<arrVars.second.fname<<",";
            cout<<arrVars.second.vname <<","<<arrVars.second.user<<",";
            cout<<arrVars.second.elemsTotal<<","<<arrVars.second.elemsWrite<<endl;
//        }

    }

    for(auto rt:cher_bbnums){
        if(rt.first > 19778 && rt.first< 19987){
            cout<<rt.first<<" : ";
            for(auto r:rt.second){
//            if(cher_varsMap[r[0]].fname == "hypre_GMRESSolve"){
                for(int i=0;i<r.size();++i){
                    cout<<cher_varsMap[r[i]].vname<<",";
                }
//            }
                cout<<" ; ";
            }
            cout<<endl;
        }

    }*/
    std::ofstream file(LOADFILEADDR+cher_dataFiles[4]);//"outfile.txt"
    if (file.is_open()) {
        for (const auto& v : cher_checkpointList) {
//                if(!v.second.cp) continue;
            file << v.first << "\n";
            file << v.second.fname << "," << v.second.vname << "," << v.second.user << "," <<v.second.type<<","<<
                 v.second.read << "," << v.second.write << "," << v.second.wor <<","<< v.second.cp << "\n\n";
        }
        file.close();
    }

    std::ofstream file2(LOADFILEADDR+cher_dataFiles[5]);//"cp.txt"
    if (file2.is_open()) {
        for (const auto& var : cher_CPVar) {
            auto v = var.second;
            if(v.vvname!="") file2<<v.ffname<<","<<v.vvname<<","<<v.state<<endl;
            else file2<<v.fname<<","<<v.vname<<","<<v.state<<endl;
        }
        file2.close();
    }
    int cher_ionum = 0;
    std::ofstream file3(LOADFILEADDR+cher_dataFiles[6]);//"IO.txt"
    if (file3.is_open()) {
	
        for (const auto& var : cher_varTFOI) {
	    if(cher_checkpointList[var.first].vname.find("__")!=std::string::npos) continue;
           // file3 << var.first << ","<<cher_checkpointList[var.first].vname<<","<<cher_checkpointList[var.first].fname<<","<<
            //var.second<<endl;
	    if(var.second == "out"){
	       	file3 <<cher_checkpointList[var.first].vname<<","<<cher_checkpointList[var.first].fname<<endl;
	    }
        }
        file3.close();
    }
       std::ofstream file4(LOADFILEADDR+"user.txt");//"IO.txt"
    if (file4.is_open()) {

        for (const auto& var : cher_varTFOI) {
            if(cher_checkpointList[var.first].vname.find("__")!=std::string::npos) continue;
           // file3 << var.first << ","<<cher_checkpointList[var.first].vname<<","<<cher_checkpointList[var.first].fname<<","<<
            //var.second<<endl;
            if(var.second == "out"){
                file4 << var.first << ","<<cher_checkpointList[var.first].vname<<","<<cher_checkpointList[var.first].fname<<","<<
            var.second<<endl;
		cher_ionum++;
            }
        }
        file4 << cher_ionum;
        file4.close();
    }
   std::ofstream file5(LOADFILEADDR+"globalUser");//"IO.txt"
    if (file5.is_open()) {
	for(const auto &usr:cher_globalUser){
	   file5<<usr<<"\n";
	}
        file5.close();
    }
}

void cher_poiSize(long long int size,uint64_t addr,int flag){
    if(flag > 0) return;
    auto poiVar = cher_varsMap[addr];
    poiVar.varsize = size;

    cher_arrNode pNode ;
    pNode.addr = poiVar.addr;
    pNode.vname = poiVar.vname;
    pNode.bbnum = poiVar.bbnum;
    pNode.fname = poiVar.fname;
    pNode.vlocate =-3;
    pNode.user = poiVar.user;
    pNode.vartype = poiVar.vartype;
    pNode.elemsTotal = poiVar.varsize;

//    cout<<poiVar.vname<<" , "<<poiVar.varsize<<endl;
    cher_arrVarsMap[addr] = pNode;
}


///数组的覆盖长度
void cher_arrLenUsed(int flag,int bbNum,int start){
    ///如果不在main loop内 || 变量被读过  || 为cp变量
    if(flag != 1 ) return;

    auto addr0 = cher_ddgNodeMap[bbNum][start][0].addr;
    auto addri = cher_ddgNodeMap[bbNum][start][1].addr;

    for(int i=1;i<cher_ddgNodeMap[bbNum][start].size();++i) {
        uint64_t tmpAddr = addri;

        if (cher_arrConnPoint[tmpAddr] != 0) tmpAddr = cher_arrConnPoint[tmpAddr];

        if (!cher_arrVarsMap.count(tmpAddr)) continue;

        if (cher_CPVar.count(tmpAddr) || cher_arrVarsMap[tmpAddr].user == "in") continue;

        cher_arrVarsMap[tmpAddr].elemsRead++;

    }

    if(cher_arrConnPoint[addr0]!=0) addr0 = cher_arrConnPoint[addr0];

    if(!cher_arrVarsMap.count(addr0)) return;

    if(cher_CPVar.count(addr0) || cher_arrVarsMap[addr0].user == "in" ) return;

    auto varr = cher_arrVarsMap[addr0];

    ///再判断个数
    if((double)varr.elemsWrite/(double)varr.elemsTotal>=0.2 && varr.elemsRead == 0){
        ///全覆盖
        cher_arrVarsMap[addr0].user = "in";
    }else if(varr.elemsWrite == varr.elemsRead  && varr.elemsRead>0){
        ///如果 数组元素被写 与 读的次数相等 ,则为全覆盖(数组元素被读过)
        cher_arrVarsMap[addr0].user = "in";
    }

    cher_arrVarsMap[addr0].elemsWrite++;///已使用元素个数+1

}
//读后写
void cher_linkddgtoeddg(int bbNum,int flag,int afterflag1) {
    //只要在main loop中出现的数组 就需要cp
    //afterflag1 当一个基本块中出现了flag=1,然后后面还有i=0类似情况,只能取flag=1之后的作为main loop内
    //一般情况下为0,当flag=1为这个基本块内第i个等式
    //flag -- mianloop 范围判定
    //!ddgNodeMap.count(bbNum)) ddgNodeMap中有这个块的信息

    if (flag != 1 || !cher_ddgNodeMap.count(bbNum)) return;

    vector <uint64_t> rt;
    rt.resize(cher_argLen);

    for (int i = 0; i < cher_argLen; ++i) {
        rt[i] = cher_Aarg[i];
    }

    if (cher_bbnums.count(bbNum) && cher_bbnums[bbNum].count(rt)) return;


    cher_bbnums[bbNum].insert(rt);

//    if(bbNum == 11161) cout<<"hypre__global_error 11161!!!\n"<<endl;(appear!!)
//    if(bbNum == 11176) cout<<"hypre__global_error 11176!!!\n"<<endl;
//    if(bbNum == 11177) cout<<"hypre__global_error 11177!!!\n"<<endl;
//    cout<<bbNum<<" , ";
//    cout<<cher_ddgNodeMap[bbNum][0][0].fname<<endl;
    //如果变量第一次被使用时为写入[除数组外,结构体],不需要cp
    for (int i = afterflag1; i < cher_ddgNodeMap[bbNum].size(); ++i) {
//        cout<<cher_ddgNodeMap[bbNum][i][0].vname<<endl;
        //1.正常的读后写
        //2.在mainloop中赋予常数值
        //3.输出变量
        int cnt = 0;//等式右边变量个数
        uint64_t addr0, addri, arraddr = 0;;

        cher_cpVar cpvar;
        addr0 = cher_ddgNodeMap[bbNum][i][0].addr;
        addri = cher_ddgNodeMap[bbNum][i][1].addr;

//        cout<<cher_checkpointList[addr0].vname<<" , "<<cher_checkpointList[cher_arrConnPoint[addr0]].vname<<endl;

        if (cher_ddgNodeMap[bbNum][i][0].vname == "") continue;//跳过常数值

        auto vddgsize = cher_ddgNodeMap[bbNum][i].size();

//        if(cher_ddgNodeMap[bbNum][i][0].vname == "rs"){
//            cout<<"rs : "<<vddgsize<<" , ";
//            cout<<cher_checkpointList[addr0].wor<<" , "<<cher_checkpointList[addr0].read<<" , "<<
//            cher_checkpointList[addr0].write<<endl;
//        }

//        if(cher_checkpointList[addr0].vname == "ij_A") cout<<bbNum<<": "<<"1ij_A\n";
//        if(cher_checkpointList[addr0].vname == "R") cout<<bbNum<<": "<<"R\n";
//        if(bbNum ==4380) cout<<"ij_A\n";
//        if(bbNum ==3703) cout<<"ij_A\n";

        if (vddgsize == 2) {
            auto addr0Name = cher_ddgNodeMap[bbNum][i][0].vname;
            auto addr1Name = cher_ddgNodeMap[bbNum][i][1].vname;
            ///x.addr = x
            if (addr1Name + ".addr" == addr0Name) continue;

            ///ij_A_ptr.addr = ij_A
            if(addr0Name.find(addr1Name)!=std::string::npos && addr0Name.find(".addr")!=std::string::npos) {
                if (cher_ddgNodeMap[bbNum][i][0].vname.find(".addr") != std::string::npos &&
                    cher_ddgNodeMap[bbNum][i][1].vname.find(".addr") == std::string::npos) {

                    if (cher_arrConnPoint.count(addri) && cher_arrConnPoint[addri] != 0)
                        cher_arrConnPoint[addr0] = cher_arrConnPoint[addri];
                    else
                        cher_arrConnPoint[addr0] = addri;
//                    cout<<cher_ddgNodeMap[bbNum][i][1].vname<<" , "<<cher_ddgNodeMap[bbNum][i][0].vname<<endl;
                    continue;
                }
            }

            if (cher_ddgNodeMap[bbNum][i][0].vartype == "pointer" &&
                cher_ddgNodeMap[bbNum][i][1].vartype == "pointer") {
                ///void *
                if (cher_ddgNodeMap[bbNum][i][1].vname.find(".addr") != std::string::npos &&
                    cher_ddgNodeMap[bbNum][i][0].vname.find(".addr") == std::string::npos) {
                    ///当两个变量都为指针变量时,视为同一变量 && 其中一个变量为 名.addr,另一个不为.addr

                    if (cher_arrConnPoint.count(addri) && cher_arrConnPoint[addri] != 0)
                        cher_arrConnPoint[addr0] = cher_arrConnPoint[addri];
                    else
                        cher_arrConnPoint[addr0] = addri;
//                    cout<<cher_ddgNodeMap[bbNum][i][1].vname<<" , "<<cher_ddgNodeMap[bbNum][i][0].vname<<endl;
                    continue;
                }
            }
            ///   block *bp;
            ///   bp = &blocks[block_num];
            if (cher_ddgNodeMap[bbNum][i][0].vartype == "pointer" &&
                cher_ddgNodeMap[bbNum][i][0].vlocate != -2 && /// -2 代表不为参数
                cher_ddgNodeMap[bbNum][i][1].vname != "" &&
                    (cher_ddgNodeMap[bbNum][i][1].vartype == "pointer" ||cher_ddgNodeMap[bbNum][i][1].vartype == "array")
                ) {
                /// 指针类型的arrConnPoint[] = 0;(默认)
                uint64_t tmpAddr = addri;

                if (cher_arrConnPoint.count(tmpAddr) && cher_arrConnPoint[tmpAddr] != 0) {
                    tmpAddr = cher_arrConnPoint[tmpAddr];
                }
                ///变量不是.addr
                if (cher_ddgNodeMap[bbNum][i][0].vname.find(".") == std::string::npos) {
                    ///右边变量不是main loop中定义的
                    if (!cher_varTFOI.count(tmpAddr) ||
                        cher_varTFOI.count(tmpAddr) && cher_varTFOI[tmpAddr] == "out") {
                        cher_arrConnPoint[addr0] = tmpAddr;
//                        cout << cher_checkpointList[addr0].vname << "," << cher_checkpointList[tmpAddr].vname << endl;
                        continue;
                    }
                }

            }

        }

//        if(cher_checkpointList[addr0].fname == "hypre_ParKrylovCreateVectorArray"){
//            cout<<bbNum<<": "<<"hypre_ParKrylovCreateVectorArray\n";
//        }

        //// addri  , `=` of right


        for (int j = 1; j < vddgsize; ++j) {

            if (cher_ddgNodeMap[bbNum][i][j].user == "in") continue;///如果变量为循环内定义 视为常量

            if (cher_ddgNodeMap[bbNum][i][j].vname == "" || cher_ddgNodeMap[bbNum][i][j].addr == 0) continue;//跳过常数值

            cnt++;

            addri = cher_ddgNodeMap[bbNum][i][j].addr;
//            if(cher_checkpointList[addri].vname == "ij_A") cout<<bbNum<<": "<<"2ij_A\n";
            ///`PO` === array , struct !!!
            if (cher_checkpointList[addri].type == "pointer" ||
                cher_checkpointList[addri].type == "array" || cher_checkpointList[addri].type == "struct") {

                uint64_t tmpAddr = addri;
                ///最初变量

                if (cher_arrConnPoint.count(tmpAddr) && cher_arrConnPoint[tmpAddr] != 0) {
                    tmpAddr = cher_arrConnPoint[tmpAddr];
                }
                ///当 变量为 .addr 时,排除(可能是传值为 常量情况)
                if (cher_checkpointList[tmpAddr].vname.find(".addr") != std::string::npos) {
                    tmpAddr = cher_arrConnPoint[tmpAddr];
                }


                ///原变量不能是指针变量(除非这个指针变量有大小)
                if (cher_checkpointList[tmpAddr].type == "array" || cher_checkpointList[tmpAddr].type == "struct" ||
                    cher_checkpointList[tmpAddr].type == "pointer"
                    ///如果大小为奇数,或者大小大于8且不为16
                        ) {
                    if (cher_checkpointList[tmpAddr].user == "out" && cher_checkpointList[tmpAddr].wor == 2) {

                        if (!cher_varTFOI.count(tmpAddr) ||
                            cher_varTFOI.count(tmpAddr) && cher_varTFOI[tmpAddr] == "out") {
                            if (!cher_checkpointList[tmpAddr].cp) {

                                ///
                                if (!cher_arrVarsMap.count(tmpAddr) || (
                                cher_arrVarsMap.count(tmpAddr) &&
                                cher_arrVarsMap[tmpAddr].elemsRead > cher_arrVarsMap[tmpAddr].elemsWrite)) {
                                    ///
                                    cher_checkpointList[tmpAddr].cp = 1;
                                    cpvar.addr = tmpAddr;
                                    cpvar.type = cher_checkpointList[tmpAddr].type;
                                    cpvar.vname = cher_checkpointList[tmpAddr].vname;
                                    cpvar.fname = cher_checkpointList[tmpAddr].fname;
                                    cpvar.state = "PO";

                                    cher_CPVar[tmpAddr] = cpvar;
                                } else if (cher_arrConnPoint.count(addr0) && tmpAddr == cher_arrConnPoint[addr0]) {
                                    /// a[i] = a[i]+1;
                                    cher_checkpointList[tmpAddr].cp = 1;
                                    cpvar.addr = tmpAddr;
                                    cpvar.type = cher_checkpointList[tmpAddr].type;
                                    cpvar.vname = cher_checkpointList[tmpAddr].vname;
                                    cpvar.fname = cher_checkpointList[tmpAddr].fname;
                                    cpvar.state = "PO";

                                    cher_CPVar[tmpAddr] = cpvar;
                                }
                            }



                        } else {
                            cher_checkpointList[tmpAddr].wor = 0;///该变量不需要判断
//                            cher_checkpointList[tmpAddr].user = "in";
                        }
                    } else {
                        if (cher_checkpointList[tmpAddr].wor != 0) {
                            cher_checkpointList[tmpAddr].wor = 1; /// 当前状态 `read`

                            if (!cher_checkpointList[tmpAddr].write && !cher_checkpointList[tmpAddr].read) {
                                cher_checkpointList[tmpAddr].read = 1;
                            }

                        }

                    }



                } else if (cher_checkpointList[tmpAddr].type != "pointer") {
                    ///单一变量
                    if (cher_checkpointList[tmpAddr].user == "out") {
                        if (cher_checkpointList[tmpAddr].wor != 0) {
                            cher_checkpointList[tmpAddr].wor = 1; /// 当前状态 `read`

                            if (!cher_checkpointList[tmpAddr].write && !cher_checkpointList[tmpAddr].read) {
                                cher_checkpointList[tmpAddr].read = 1;
                            }
                        }
                    }

                }

            } else {
                ///本地单一变量
                if (cher_checkpointList[addri].user == "out") {
                    if (cher_checkpointList[addri].wor != 0) {
                        cher_checkpointList[addri].wor = 1; /// 当前状态 `read`

                        if (!cher_checkpointList[addri].write && !cher_checkpointList[addri].read) {
                            cher_checkpointList[addri].read = 1;
                        }
                    }
                }
            }
        }



        //// addr0 , `=` of left
        //// wor
        //// `WAR`
        //// `write`
        if (cher_checkpointList[addr0].vname[0] == '.') {
            ///临时变量标志
            continue;
        }
        if (cher_checkpointList[addr0].type == "pointer" || cher_checkpointList[addr0].type == "array" ||
            cher_checkpointList[addr0].type == "struct") {
            ///*a = 1;
            uint64_t tmpAddr = addr0;

            if (cher_arrConnPoint.count(tmpAddr) && cher_arrConnPoint[tmpAddr] != 0) {
//                cout<<"WAR :";
//                cout<<cher_checkpointList[tmpAddr].vname<< " , "<<cher_checkpointList[tmpAddr].fname<<" : ";

                tmpAddr = cher_arrConnPoint[tmpAddr];

//                cout<<cher_checkpointList[tmpAddr].vname<< " , "<<cher_checkpointList[tmpAddr].fname<<"\n";

            } else {
//                cout<<" ?? :";
//                cout<<cher_checkpointList[tmpAddr].vname<< " , "<<cher_checkpointList[tmpAddr].fname<<"\n";
            }
            ///当 变量为 .addr 时,排除(可能是传值为 常量情况)
            if (cher_checkpointList[tmpAddr].vname.find(".addr") != std::string::npos) {
                tmpAddr = cher_arrConnPoint[tmpAddr];
            }
            ////printf
//            if(cher_checkpointList[tmpAddr].vname == "R" && cher_checkpointList[tmpAddr].fname == "BuildIJLaplacian27pt"){
//                cout<<"R : "<<vddgsize<<" , "<<bbNum<<" , ";
//                cout<<" arrConn "<<cher_checkpointList[addr0].vname<<" , ";
//                cout<<cher_checkpointList[tmpAddr].wor<<" , "<<cher_checkpointList[tmpAddr].read<<" , "<<
//                    cher_checkpointList[tmpAddr].write<<endl;
//            }

            ///如果cnt == 0,对于 pointer,strcut,array 不做改变.
            if (cnt > 0) {
                cher_checkpointList[tmpAddr].wor = 2;
                ///WAR
                ///变量第一次为写入
                if (!cher_checkpointList[tmpAddr].read) {
                    cher_checkpointList[tmpAddr].write = 1;
//                    cher_checkpointList[tmpAddr].user = "in"; /// ?? 可能半覆盖当做全覆盖 !!!
                } else {

                    if (!cher_varTFOI.count(tmpAddr) ||
                        cher_varTFOI.count(tmpAddr) && cher_varTFOI[tmpAddr] == "out") {
                        if (cher_checkpointList[tmpAddr].user == "out" && !cher_checkpointList[tmpAddr].cp) {
                            cher_checkpointList[tmpAddr].cp = 1; ///WAR
                            cpvar.addr = tmpAddr;
                            cpvar.type = cher_checkpointList[tmpAddr].type;
                            cpvar.vname = cher_checkpointList[tmpAddr].vname;
                            cpvar.fname = cher_checkpointList[tmpAddr].fname;
                            cpvar.state = "WAR";

                            cher_CPVar[tmpAddr] = cpvar;
                        }
                    } else {
                        cher_checkpointList[tmpAddr].wor = 0;///该变量不需要判断
//                            cher_checkpointList[tmpAddr].user = "in";
                    }
                }

            } else if (cher_checkpointList[tmpAddr].type == "array" ||
                       cher_checkpointList[tmpAddr].type == "struct" ||
                       cher_checkpointList[tmpAddr].type == "pointer") {
                ///不作改变
                      cher_checkpointList[tmpAddr].wor = 2;
                      if(!cher_checkpointList[tmpAddr].write && !cher_checkpointList[tmpAddr].read)
                        cher_checkpointList[tmpAddr].write = 1;
//                    cher_checkpointList[tmpAddr].user = "in"; /// ?? 可能半覆盖当做全覆盖 !!!
            } else {
                ///单变量
                cher_checkpointList[tmpAddr].wor = 0;
                if(!cher_checkpointList[tmpAddr].write && !cher_checkpointList[tmpAddr].read)
                    cher_checkpointList[tmpAddr].write = 1;
            }


        }
        else {
            ///单一变量
            if (cnt > 0) {
                /// a = b+1;
                if (cher_checkpointList[addr0].wor != 0) {
                    cher_checkpointList[addr0].wor = 2;

                    ///WAR
                    ///变量第一次为写入
                    if (!cher_checkpointList[addr0].read) {
                        if(!cher_checkpointList[addr0].write && !cher_checkpointList[addr0].read)
                             cher_checkpointList[addr0].write = 1;
//                    cher_checkpointList[addr0].user = "in";
                        cher_checkpointList[addr0].wor = 0;
                    } else {
                        if (!cher_varTFOI.count(addr0) ||
                            cher_varTFOI.count(addr0) && cher_varTFOI[addr0] == "out") {
                            if (cher_checkpointList[addr0].user == "out" && !cher_checkpointList[addr0].cp &&
                                0 != cher_checkpointList[addr0].wor) {
                                cher_checkpointList[addr0].cp = 1; ///WAR
                                cpvar.addr = addr0;
                                cpvar.type = cher_checkpointList[addr0].type;
                                cpvar.vname = cher_checkpointList[addr0].vname;
                                cpvar.fname = cher_checkpointList[addr0].fname;
                                cpvar.state = "WAR";

                                cher_CPVar[addr0] = cpvar;
                            }
                        } else {
                            cher_checkpointList[addr0].wor = 0;///该变量不需要判断
//                            cher_checkpointList[addr0].user = "in";
                        }
                    }
                }

            }
            else {
                ///单一变量 a = 1;
                if(!cher_checkpointList[addr0].write && !cher_checkpointList[addr0].read)
                    cher_checkpointList[addr0].write = 1;
                cher_checkpointList[addr0].wor = 0; /// 不需要判断
            }
        }
    }
}


//输出  判断第一次变量被使用是不是重新赋值
void cher_varUsed(int flag,int bbNum,int num){

    return;
    if (flag != 2 || !cher_ddgNodeMap.count(bbNum) || cher_bbnums.count(bbNum)) return;

//    cout<<bbNum<<" , "<<num << " : ";

    auto varaddr = cher_ddgNodeMap[bbNum][num][0].addr;

//    cout<<cher_checkpointList[varaddr].vname<<endl;

//    cout<<cher_ddgNodeMap[bbNum][num][0].vname<<" : \n";

//    cout<<cher_ddgNodeMap[45][num][0].vname<<" , ";
//    cout<<cher_ddgNodeMap[54][num][0].vname<<endl;

    if (cher_checkpointList.count(varaddr) && 0 == cher_checkpointList[varaddr].cp
    && 2 == cher_checkpointList[varaddr].wor &&

        (cher_checkpointList[varaddr].type!="array"||cher_checkpointList[varaddr].type != "pointer"
         ||cher_checkpointList[varaddr].type != "struct")
         ) {

        cher_checkpointList[varaddr].wor = 0;

    }
//    cout<<"varUsed Over!!!\n";
}

//2 输出 (在使用之前没有被赋值)
//判断main loop的输出在后面有没有被使用,有则需要cp
// bbNum 用来排除重复出现的main loop块
void cher_resultUsed(int flag, uint64_t addr,int bbNum) { /// 输出 与变量 "user" 没关系
        if(flag == 1) {
        ///判断有哪些全局变量被使用过
        //std::ofstream file(LOADFILEADDR + "globalUser", std::ios::app); // 以追加模式打开文件
        //if (file.is_open()) {
	    //if(addr >0 && cher_checkpointList.count(addr)>0&& addr < cher_checkpointList.size()){
	    	if(cher_checkpointList[addr].fname == "GlobalVar"){
			cher_globalUser.insert(cher_checkpointList[addr].vname);
		}	
	   // }
            //if (addr > 0 && cher_checkpointList.count(addr)>0 && cher_checkpointList[addr].fname == "GlobalVar") {
                //file << cher_checkpointList[addr].vname << "\n";
		//cher_globalUser.insert(cher_checkpointList[addr].vname);
            //}
          //  file.close();
        //}
      }
     if(cher_funcNameAppear > 1 || flag!=2 ) return;

    if(cher_arrConnPoint.count(addr) &&cher_arrConnPoint[addr]!=0) addr = cher_arrConnPoint[addr];

    if (!cher_checkpointList[addr].cp&&cher_checkpointList[addr].wor == 2  && cher_checkpointList[addr].user == "out") {

        //flag==2 代表在mainloop之后,wor==2代表的是最后状态为写的变量
        cher_cpVar cpvar;

        uint64_t tmpAddr = addr;

        cher_checkpointList[tmpAddr].cp = 1;


        cher_checkpointList[tmpAddr].user = "out";
        cpvar.addr = tmpAddr;
        cpvar.type = cher_checkpointList[tmpAddr].type;


        cpvar.vname = cher_checkpointList[tmpAddr].vname;
        cpvar.fname = cher_checkpointList[tmpAddr].fname;
        cpvar.state = "Outcome";

        cher_CPVar[tmpAddr] = cpvar;

    }
}


