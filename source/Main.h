#pragma once

#define _STDINT

#include <iostream>
#include <string>
#include <cstring>
#include <stdio.h>
#include <sstream>
#include <fstream>

#ifndef _WIN32
	#include <sys/stat.h>
	#include <sys/types.h>
#endif

#include <GarrysMod/Lua/Interface.h>

extern GarrysMod::Lua::ILuaBase* g_Lua;

using namespace std;

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