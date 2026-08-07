// ADVICE 数据目录解析：优先 CHECKER_DATA_DIR，其次 $CHECKER_HOME/lib/Data/，
// 都未设置时回退到容器里的老路径，保证旧的 Docker 流程行为不变。
#ifndef ADVICE_CHECKER_PATHS_H
#define ADVICE_CHECKER_PATHS_H

#include <cstdlib>
#include <string>

inline std::string cher_checkerHome() {
    const char *env = std::getenv("CHECKER_HOME");
    std::string home = (env && *env) ? env : "/workspace/LLVM-Checker";
    while (home.size() > 1 && home[home.size() - 1] == '/') home.erase(home.size() - 1);
    return home;
}

inline std::string cher_dataDir() {
    const char *env = std::getenv("CHECKER_DATA_DIR");
    if (env && *env) {
        std::string dir(env);
        if (dir[dir.size() - 1] != '/') dir += '/';
        return dir;
    }
    return cher_checkerHome() + "/lib/Data/";
}

#endif // ADVICE_CHECKER_PATHS_H
