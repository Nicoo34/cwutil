#include <Bootil/Bootil.h>
#include <memory>
#include "WebEasy.h"
#include "Main.h"

#ifdef _WIN32
#include <windows.h>
#include "unistd.h"
#else
#include <unistd.h>
typedef unsigned char BYTE;
#endif

using namespace GarrysMod::Lua;

#ifdef _WIN32
HMODULE luashared = NULL;
#else
typedef void* lua_shared;
lua_shared luashared = NULL;
#endif

lua_State* luastate = NULL;
GarrysMod::Lua::ILuaBase* g_Lua;

string getcwd()
{
    const size_t chunkSize=255;
    const int maxChunks=10240;

    char stackBuffer[chunkSize];
    if(getcwd(stackBuffer,sizeof(stackBuffer))!=NULL)
        return stackBuffer;

    for(int chunks=2; chunks<maxChunks ; chunks++)
    {
        std::auto_ptr<char> cwd(new char[chunkSize*chunks]); 
        if(getcwd(cwd.get(),chunkSize*chunks)!=NULL)
            return cwd.get();
    }

  return "Cannot determine the current path; the path is apparently unreasonably long";
}

int fileioWriteCWUtil(lua_State* state)
{
	if (LUA->IsType(1, GarrysMod::Lua::Type::STRING)
		&& LUA->IsType(2, GarrysMod::Lua::Type::STRING))
	{
		Bootil::BString strFilename = LUA->GetString(1);
		Bootil::BString strContents = LUA->GetString(2);

		if (!LUA->IsType(3, GarrysMod::Lua::Type::BOOL) || LUA->GetBool() == true)
			strFilename = cwSetupFullDirectory(strFilename);

		bool bStatus = Bootil::File::Write(strFilename, strContents);
		LUA->PushBool(bStatus);

		return 1;
	}

	LUA->PushBool(false);
	return 1;
}

int fileioAppendCWUtil(lua_State* state)
{
	if (LUA->IsType(1, GarrysMod::Lua::Type::STRING) && LUA->IsType(2, GarrysMod::Lua::Type::STRING))
	{
		string strFilename = LUA->GetString(1);
		string strContents = LUA->GetString(2);

		if (!LUA->IsType(3, GarrysMod::Lua::Type::BOOL) || LUA->GetBool() == true)
		{
			strFilename = cwSetupFullDirectory(strFilename);
		}

		ofstream file (strFilename.c_str(), ios::out | ios::app);

		if(file.is_open())
		{
			file << strContents;
			file.close();
			LUA->PushBool(true);
		}
		else
		{
			LUA->PushBool(false);
		}

		return 1;
	}

	LUA->PushBool(false);
	return 1;
}

string cwSetupFullDirectory(string strPath)
{
	string strFullDirectory;

	g_Lua->PushSpecial(GarrysMod::Lua::SPECIAL_GLOB);
	g_Lua->GetField(-1, "Clockwork");
	g_Lua->GetField(-1, "kernel");
	g_Lua->GetField(-1, "SetupFullDirectory");
	g_Lua->PushSpecial(GarrysMod::Lua::SPECIAL_GLOB);
	g_Lua->GetField(-1, "Clockwork");
	g_Lua->GetField(-1, "kernel");
	g_Lua->Remove(-3);
	g_Lua->Remove(-2);
	g_Lua->PushString(strPath.c_str());
	g_Lua->Call(2, 1);

	strFullDirectory = g_Lua->GetString();

	g_Lua->Pop(4);

	return strFullDirectory;
}

string SimpleFileRead(string fileName)
{
	fileName = cwSetupFullDirectory(fileName);

	Bootil::BString strContents;
	bool bStatus = Bootil::File::Read(fileName, strContents);

	if (bStatus == true)
		return strContents;
	else
		return "";
}

string SimpleMD5(string data)
{
	return Bootil::Hasher::MD5::String(data);
}

void SimpleFileWrite(string fileName, string data)
{
	fileName = cwSetupFullDirectory(fileName);

	Bootil::File::Write(fileName, data);
}

int fileioReadCWUtil(lua_State* state)
{
	if (LUA->IsType(1, GarrysMod::Lua::Type::STRING))
	{
		Bootil::BString strFilename = LUA->GetString(1);

		if (!LUA->IsType(2, GarrysMod::Lua::Type::BOOL) || LUA->GetBool() == true)
			strFilename = cwSetupFullDirectory(strFilename);

		Bootil::BString strContents;
		
		bool bStatus = Bootil::File::Read(strFilename, strContents);
		
		if (bStatus == true)
			LUA->PushString(strContents.c_str());
		else
			LUA->PushBool(false);

		return 1;
	}

	LUA->PushBool(false);
	return 1;
}

int fileioDeleteCWUtil(lua_State* state)
{
	if (LUA->IsType(1, GarrysMod::Lua::Type::STRING))
	{
		Bootil::BString strPath = LUA->GetString(1);

		if (!LUA->IsType(2, GarrysMod::Lua::Type::BOOL) || LUA->GetBool() == true)
			strPath = cwSetupFullDirectory(strPath);

		bool bStatus = Bootil::File::RemoveFolder(strPath, true);

		LUA->PushBool(bStatus);

		return 1;
	}

	LUA->PushBool(false);
	return 1;
}

int fileioMakeDirCWUtil(lua_State* state)
{
	if (LUA->IsType(1, GarrysMod::Lua::Type::STRING))
	{
		Bootil::BString strPath = LUA->GetString(1);
			bool bStatus = Bootil::File::CreateFolder(strPath);
		LUA->PushBool(bStatus);
		
		return 1;
	}

	LUA->PushBool(false);
	return 1;
}

int WebFetchCWUtil(lua_State* state)
{
	if (!LUA->IsType(1, GarrysMod::Lua::Type::STRING))
		return 0;

	Bootil::BString strURL = LUA->GetString(1);

	LUA->PushString(WebEasy::GET(strURL, "").c_str());

	return 1;
}

int WebPostCWUtil(lua_State* state)
{
	if (!LUA->IsType(1, GarrysMod::Lua::Type::STRING))
		return 0;

	if (!LUA->IsType(2, GarrysMod::Lua::Type::STRING))
		return 0;

	Bootil::BString strURL = LUA->GetString(1);
	Bootil::BString strPost = LUA->GetString(2);

	LUA->PushString(WebEasy::POST(strURL, "", strPost).c_str());

	return 1;
}

GMOD_MODULE_OPEN()
{
	g_Lua = LUA;
	
	LUA->CreateTable();
	int iCWUtilTable = LUA->ReferenceCreate();
		LUA->PushSpecial(GarrysMod::Lua::SPECIAL_GLOB);
		LUA->PushString("CWUtil");
		LUA->ReferencePush(iCWUtilTable);
		LUA->SetTable(-3);

		LUA->ReferencePush(iCWUtilTable);
		LUA->PushString("WebFetch");
		LUA->PushCFunction(WebFetchCWUtil);
		LUA->SetTable(-3);

		LUA->ReferencePush(iCWUtilTable);
		LUA->PushString("WebPost");
		LUA->PushCFunction(WebPostCWUtil);
		LUA->SetTable(-3);
	
	LUA->CreateTable();
	int iFileioTable = LUA->ReferenceCreate();
		LUA->PushSpecial(GarrysMod::Lua::SPECIAL_GLOB);
		LUA->PushString("fileio");
		LUA->ReferencePush(iFileioTable);
		LUA->SetTable(-3);

		LUA->ReferencePush(iFileioTable);
		LUA->PushString("Write");
		LUA->PushCFunction(fileioWriteCWUtil);
		LUA->SetTable(-3);

		LUA->ReferencePush(iFileioTable);
		LUA->PushString("Read");
		LUA->PushCFunction(fileioReadCWUtil);
		LUA->SetTable(-3);

		LUA->ReferencePush(iFileioTable);
		LUA->PushString("Delete");
		LUA->PushCFunction(fileioDeleteCWUtil);
		LUA->SetTable(-3);

		LUA->ReferencePush(iFileioTable);
		LUA->PushString("Append");
		LUA->PushCFunction(fileioAppendCWUtil);
		LUA->SetTable(-3);

		LUA->ReferencePush(iFileioTable);
		LUA->PushString("MakeDirectory");
		LUA->PushCFunction(fileioMakeDirCWUtil);
		LUA->SetTable(-3);
	LUA->ReferenceFree(iFileioTable);

	g_Lua->Pop(27);

	return 0;
}

GMOD_MODULE_CLOSE()
{
	return 0;
}
