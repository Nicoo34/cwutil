#include "Main.h"
#include <Bootil/Bootil.h>
#include "WebEasy.h"

#ifdef _WIN32
    HMODULE luashared = NULL;
#else
    typedef void* lua_shared;
    lua_shared luashared = NULL;
#endif

lua_State* luastate = NULL;
ILuaBase* g_Lua = nullptr;

std::string getcwd()
{
#ifdef _WIN32
    char buffer[MAX_PATH];
    return (GetCurrentDirectoryA(MAX_PATH, buffer) ? std::string(buffer) : "");
#else
    char buffer[4096];
    return (getcwd(buffer, sizeof(buffer)) ? std::string(buffer) : "");
#endif
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

int fileioWriteCWUtil(lua_State* state)
{
    if (LUA->IsType(1, GarrysMod::Lua::Type::String) && LUA->IsType(2, GarrysMod::Lua::Type::String))
    {
        Bootil::BString strFilename = LUA->GetString(1);
        Bootil::BString strContents = LUA->GetString(2);

        if (!LUA->IsType(3, GarrysMod::Lua::Type::Bool) || LUA->GetBool(3) == true)
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
    if (LUA->IsType(1, GarrysMod::Lua::Type::String) && LUA->IsType(2, GarrysMod::Lua::Type::String))
    {
        Bootil::BString strFilename = LUA->GetString(1);
        Bootil::BString strContents = LUA->GetString(2);

        if (!LUA->IsType(3, GarrysMod::Lua::Type::Bool) || LUA->GetBool(3) == true)
            strFilename = cwSetupFullDirectory(strFilename);

     
        Bootil::BString currentContent;
        if (Bootil::File::Exists(strFilename) && !Bootil::File::Read(strFilename, currentContent))
        {
            LUA->PushBool(false);
            return 1;
        }

        
        currentContent.append(strContents);

        
        bool bStatus = Bootil::File::Write(strFilename, currentContent);
        LUA->PushBool(bStatus);

        return 1;
    }

    LUA->PushBool(false);
    return 1;
}

int fileioReadCWUtil(lua_State* state)
{
	if (LUA->IsType(1, GarrysMod::Lua::Type::String))
	{
		Bootil::BString strFilename = LUA->GetString(1);

		if (!LUA->IsType(2, GarrysMod::Lua::Type::Bool) || LUA->GetBool(2) == true)
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
    if (LUA->IsType(1, GarrysMod::Lua::Type::String))
    {
        Bootil::BString strPath = LUA->GetString(1);

        if (!LUA->IsType(2, GarrysMod::Lua::Type::Bool) || LUA->GetBool(2) == true)
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
    if (LUA->IsType(1, GarrysMod::Lua::Type::String))
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
    if (!LUA->IsType(1, GarrysMod::Lua::Type::String))
    {
        LUA->PushNil();
        return 1;
    }

    const char* url = LUA->GetString(1);
    if (!url)
    {
        LUA->PushNil();
        return 1;
    }

    try
    {
        std::string result = WebEasy::GET(url, "");
        LUA->PushString(result.c_str());
    }
    catch (...)
    {
        LUA->PushNil();
    }

    return 1;
}

int WebPostCWUtil(lua_State* state)
{
    if (!LUA->IsType(1, GarrysMod::Lua::Type::String) || !LUA->IsType(2, GarrysMod::Lua::Type::String))
    {
        LUA->PushNil();
        return 1;
    }

    const char* url = LUA->GetString(1);
    const char* postData = LUA->GetString(2);
    
    if (!url || !postData)
    {
        LUA->PushNil();
        return 1;
    }

    try
    {
        std::string result = WebEasy::POST(url, "", postData);
        LUA->PushString(result.c_str());
    }
    catch (...)
    {
        LUA->PushNil();
    }

    return 1;
}

GMOD_MODULE_OPEN()
{
    LUA = state->luabase;
    g_Lua = LUA;
    
    // Create CWUtil table
    LUA->CreateTable();
    int cwUtilTable = LUA->ReferenceCreate();
    
    // Register CWUtil table in _G
    LUA->PushSpecial(SPECIAL_GLOB);
    LUA->PushString("CWUtil");
    LUA->ReferencePush(cwUtilTable);
    LUA->SetTable(-3);
    LUA->Pop(1); // Pop _G
    
    // Register functions in CWUtil table
    LUA->ReferencePush(cwUtilTable);
    
    // Web functions
    LUA->PushString("WebFetch");
    LUA->PushCFunction(WebFetchCWUtil);
    LUA->SetTable(-3);
    
    LUA->PushString("WebPost");
    LUA->PushCFunction(WebPostCWUtil);
    LUA->SetTable(-3);
    
    // File I/O functions
    LUA->PushString("FileWrite");
    LUA->PushCFunction(fileioWriteCWUtil);
    LUA->SetTable(-3);
    
    LUA->PushString("FileAppend");
    LUA->PushCFunction(fileioAppendCWUtil);
    LUA->SetTable(-3);
    
    LUA->PushString("FileRead");
    LUA->PushCFunction(fileioReadCWUtil);
    LUA->SetTable(-3);
    
    LUA->PushString("FileDelete");
    LUA->PushCFunction(fileioDeleteCWUtil);
    LUA->SetTable(-3);
    
    LUA->PushString("MakeDir");
    LUA->PushCFunction(fileioMakeDirCWUtil);
    LUA->SetTable(-3);
    
    // Create and register the fileio table
    LUA->CreateTable();
    int iFileioTable = LUA->ReferenceCreate();
    
    // Register fileio table in the global namespace
    LUA->PushSpecial(GarrysMod::Lua::SPECIAL_GLOB);
    LUA->PushString("fileio");
    LUA->ReferencePush(iFileioTable);
    LUA->SetTable(-3);
    LUA->Pop(1); // Pop the global table

    // Register fileio functions
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
    
    // Clean up
    LUA->Pop(1); // Pop the fileio table
    LUA->ReferenceFree(cwUtilTable);
    LUA->ReferenceFree(iFileioTable);

    return 0;
}

GMOD_MODULE_CLOSE()
{
	g_Lua = nullptr;
	return 0;
}


