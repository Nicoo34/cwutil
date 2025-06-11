#pragma once

#define _STDINT
#define GMOD_ALLOW_DEPRECATED

#include <iostream>
#include <string>
#include <cstring>
#include <stdio.h>
#include <sstream>
#include <fstream>
#include <memory>

#ifdef _WIN32
    #include <windows.h>
    #include "unistd.h"
#else
    #include <sys/stat.h>
    #include <sys/types.h>
    #include <unistd.h>
    typedef unsigned char BYTE;
#endif

#include "includes/GarrysMod/Lua/Interface.h"
#include "includes/GarrysMod/Lua/LuaBase.h"
#include "includes/GarrysMod/Lua/Types.h"
#include "includes/GarrysMod/Lua/UserData.h"

extern GarrysMod::Lua::ILuaBase* g_Lua;

using namespace std;
using namespace GarrysMod::Lua;

int WebFetchCWUtil(lua_State* state);
int WebPostCWUtil(lua_State* state);
int fileioWriteCWUtil(lua_State* state);
int fileioAppendCWUtil(lua_State* state);
int fileioReadCWUtil(lua_State* state);
int fileioDeleteCWUtil(lua_State* state);
int fileioMakeDirCWUtil(lua_State* state);
string cwSetupFullDirectory(string strPath);
string SimpleFileRead(string fileName);
void SimpleFileWrite(string fileName, string data);
string SimpleMD5(string data);