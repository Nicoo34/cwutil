# GNU Make project makefile autogenerated by Premake
ifndef config
  config=debug
endif

ifndef verbose
  SILENT = @
endif

ifndef CC
  CC = gcc
endif

ifndef CXX
  CXX = g++
endif

ifndef AR
  AR = ar
endif

ifeq ($(config),debug)
  OBJDIR     = obj/Debug/Bootil
  TARGETDIR  = ../../release/bootil
  TARGET     = $(TARGETDIR)/libbootil_static.a
  DEFINES   += -DNDEBUG -DBOOTIL_COMPILE_STATIC
  INCLUDES  += -I../../bootil/include -I../../bootil/src/3rdParty
  CPPFLAGS  += -MMD -MP $(DEFINES) $(INCLUDES)
  CFLAGS    += $(CPPFLAGS) $(ARCH) -g -msse -O3 -ffast-math -m32 -fPIC -L/usr/lib -ldl -static-libgcc -static-libstdc++ -std=c++0x -static
  CXXFLAGS  += $(CFLAGS) 
  LDFLAGS   += -m32 -fPIC -ldl -lpthread -static-libgcc -static-libstdc++ -std=c++0x
  LIBS      += 
  RESFLAGS  += $(DEFINES) $(INCLUDES) 
  LDDEPS    += 
  LINKCMD    = $(AR) -rcs $(TARGET) $(OBJECTS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
endif

ifeq ($(config),release)
  OBJDIR     = obj/Release/Bootil
  TARGETDIR  = ../../release/bootil
  TARGET     = $(TARGETDIR)/libbootil_static.a
  DEFINES   += -DNDEBUG -DBOOTIL_COMPILE_STATIC
  INCLUDES  += -I../../bootil/include -I../../bootil/src/3rdParty
  CPPFLAGS  += -MMD -MP $(DEFINES) $(INCLUDES)
  CFLAGS    += $(CPPFLAGS) $(ARCH) -g -msse -O3 -ffast-math -m32 -fPIC -L/usr/lib -ldl -static-libgcc -static-libstdc++ -std=c++0x -static
  CXXFLAGS  += $(CFLAGS) 
  LDFLAGS   += -m32 -fPIC -ldl -lpthread -static-libgcc -static-libstdc++ -std=c++0x
  LIBS      += 
  RESFLAGS  += $(DEFINES) $(INCLUDES) 
  LDDEPS    += 
  LINKCMD    = $(AR) -rcs $(TARGET) $(OBJECTS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
endif

OBJECTS := \
	$(OBJDIR)/globber.o \
	$(OBJDIR)/fastlz.o \
	$(OBJDIR)/happyhttp.o \
	$(OBJDIR)/jpge.o \
	$(OBJDIR)/Alloc.o \
	$(OBJDIR)/LzFind.o \
	$(OBJDIR)/LzmaDec.o \
	$(OBJDIR)/LzmaEnc.o \
	$(OBJDIR)/LzmaLib.o \
	$(OBJDIR)/crc.o \
	$(OBJDIR)/smhash_md5.o \
	$(OBJDIR)/tinythread.o \
	$(OBJDIR)/unzip.o \
	$(OBJDIR)/zip.o \
	$(OBJDIR)/adler32.o \
	$(OBJDIR)/compress.o \
	$(OBJDIR)/crc32.o \
	$(OBJDIR)/deflate.o \
	$(OBJDIR)/gzclose.o \
	$(OBJDIR)/gzlib.o \
	$(OBJDIR)/gzread.o \
	$(OBJDIR)/gzwrite.o \
	$(OBJDIR)/infback.o \
	$(OBJDIR)/inffast.o \
	$(OBJDIR)/inflate.o \
	$(OBJDIR)/inftrees.o \
	$(OBJDIR)/trees.o \
	$(OBJDIR)/uncompr.o \
	$(OBJDIR)/zutil.o \
	$(OBJDIR)/Base.o \
	$(OBJDIR)/Console.o \
	$(OBJDIR)/ConsoleInput.o \
	$(OBJDIR)/Json.o \
	$(OBJDIR)/Tree.o \
	$(OBJDIR)/Debug.o \
	$(OBJDIR)/Changes.o \
	$(OBJDIR)/File.o \
	$(OBJDIR)/System.o \
	$(OBJDIR)/Image.o \
	$(OBJDIR)/JPEG.o \
	$(OBJDIR)/HTTP.o \
	$(OBJDIR)/Network.o \
	$(OBJDIR)/Socket.o \
	$(OBJDIR)/Platform_LINUX.o \
	$(OBJDIR)/Platform_NULL.o \
	$(OBJDIR)/Platform_OSX.o \
	$(OBJDIR)/Platform_WINDOWS.o \
	$(OBJDIR)/Mutex.o \
	$(OBJDIR)/Thread.o \
	$(OBJDIR)/Utility.o \
	$(OBJDIR)/Buffer.o \
	$(OBJDIR)/Math.o \
	$(OBJDIR)/String.o \
	$(OBJDIR)/String_Convert.o \
	$(OBJDIR)/String_Encode.o \
	$(OBJDIR)/String_File.o \
	$(OBJDIR)/String_Format.o \
	$(OBJDIR)/String_Sanitize.o \
	$(OBJDIR)/String_Test.o \
	$(OBJDIR)/String_To.o \
	$(OBJDIR)/String_URL.o \
	$(OBJDIR)/String_Util.o \
	$(OBJDIR)/CommandLine.o \
	$(OBJDIR)/Compression.o \
	$(OBJDIR)/CompressionLZMA.o \
	$(OBJDIR)/Hasher.o \
	$(OBJDIR)/PackFile.o \
	$(OBJDIR)/Processes.o \
	$(OBJDIR)/Time.o \

RESOURCES := \

SHELLTYPE := msdos
ifeq (,$(ComSpec)$(COMSPEC))
  SHELLTYPE := posix
endif
ifeq (/bin,$(findstring /bin,$(SHELL)))
  SHELLTYPE := posix
endif

.PHONY: clean prebuild prelink

all: $(TARGETDIR) $(OBJDIR) prebuild prelink $(TARGET)
	@:

$(TARGET): $(GCH) $(OBJECTS) $(LDDEPS) $(RESOURCES)
	@echo Linking Bootil
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning Bootil
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild:
	$(PREBUILDCMDS)

prelink:
	$(PRELINKCMDS)

ifneq (,$(PCH))
$(GCH): $(PCH)
	@echo $(notdir $<)
	-$(SILENT) cp $< $(OBJDIR)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
endif

$(OBJDIR)/globber.o: ../../bootil/src/3rdParty/globber.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/fastlz.o: ../../bootil/src/3rdParty/fastlz/fastlz.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/happyhttp.o: ../../bootil/src/3rdParty/happyhttp/happyhttp.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/jpge.o: ../../bootil/src/3rdParty/jpegcompressor/jpge.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Alloc.o: ../../bootil/src/3rdParty/lzma/Alloc.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/LzFind.o: ../../bootil/src/3rdParty/lzma/LzFind.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/LzmaDec.o: ../../bootil/src/3rdParty/lzma/LzmaDec.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/LzmaEnc.o: ../../bootil/src/3rdParty/lzma/LzmaEnc.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/LzmaLib.o: ../../bootil/src/3rdParty/lzma/LzmaLib.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/crc.o: ../../bootil/src/3rdParty/smhasher/crc.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/smhash_md5.o: ../../bootil/src/3rdParty/smhasher/smhash_md5.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/tinythread.o: ../../bootil/src/3rdParty/tinythreadpp/tinythread.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/unzip.o: ../../bootil/src/3rdParty/xzip/unzip.cc
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/zip.o: ../../bootil/src/3rdParty/xzip/zip.cc
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/adler32.o: ../../bootil/src/3rdParty/zlib/adler32.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/compress.o: ../../bootil/src/3rdParty/zlib/compress.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/crc32.o: ../../bootil/src/3rdParty/zlib/crc32.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/deflate.o: ../../bootil/src/3rdParty/zlib/deflate.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/gzclose.o: ../../bootil/src/3rdParty/zlib/gzclose.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/gzlib.o: ../../bootil/src/3rdParty/zlib/gzlib.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/gzread.o: ../../bootil/src/3rdParty/zlib/gzread.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/gzwrite.o: ../../bootil/src/3rdParty/zlib/gzwrite.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/infback.o: ../../bootil/src/3rdParty/zlib/infback.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/inffast.o: ../../bootil/src/3rdParty/zlib/inffast.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/inflate.o: ../../bootil/src/3rdParty/zlib/inflate.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/inftrees.o: ../../bootil/src/3rdParty/zlib/inftrees.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/trees.o: ../../bootil/src/3rdParty/zlib/trees.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/uncompr.o: ../../bootil/src/3rdParty/zlib/uncompr.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/zutil.o: ../../bootil/src/3rdParty/zlib/zutil.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(CFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Base.o: ../../bootil/src/Bootil/Base.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Console.o: ../../bootil/src/Bootil/Console/Console.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/ConsoleInput.o: ../../bootil/src/Bootil/Console/ConsoleInput.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Json.o: ../../bootil/src/Bootil/Data/Json.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Tree.o: ../../bootil/src/Bootil/Data/Tree.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Debug.o: ../../bootil/src/Bootil/Debug/Debug.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Changes.o: ../../bootil/src/Bootil/File/Changes.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/File.o: ../../bootil/src/Bootil/File/File.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/System.o: ../../bootil/src/Bootil/File/System.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Image.o: ../../bootil/src/Bootil/Image/Image.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/JPEG.o: ../../bootil/src/Bootil/Image/JPEG.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/HTTP.o: ../../bootil/src/Bootil/Network/HTTP.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Network.o: ../../bootil/src/Bootil/Network/Network.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Socket.o: ../../bootil/src/Bootil/Network/Socket.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Platform_LINUX.o: ../../bootil/src/Bootil/Platform/Platform_LINUX.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Platform_NULL.o: ../../bootil/src/Bootil/Platform/Platform_NULL.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Platform_OSX.o: ../../bootil/src/Bootil/Platform/Platform_OSX.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Platform_WINDOWS.o: ../../bootil/src/Bootil/Platform/Platform_WINDOWS.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Mutex.o: ../../bootil/src/Bootil/Threads/Mutex.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Thread.o: ../../bootil/src/Bootil/Threads/Thread.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Utility.o: ../../bootil/src/Bootil/Threads/Utility.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Buffer.o: ../../bootil/src/Bootil/Types/Buffer.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Math.o: ../../bootil/src/Bootil/Types/Math.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String.o: ../../bootil/src/Bootil/Types/String.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_Convert.o: ../../bootil/src/Bootil/Types/String_Convert.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_Encode.o: ../../bootil/src/Bootil/Types/String_Encode.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_File.o: ../../bootil/src/Bootil/Types/String_File.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_Format.o: ../../bootil/src/Bootil/Types/String_Format.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_Sanitize.o: ../../bootil/src/Bootil/Types/String_Sanitize.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_Test.o: ../../bootil/src/Bootil/Types/String_Test.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_To.o: ../../bootil/src/Bootil/Types/String_To.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_URL.o: ../../bootil/src/Bootil/Types/String_URL.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/String_Util.o: ../../bootil/src/Bootil/Types/String_Util.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/CommandLine.o: ../../bootil/src/Bootil/Utility/CommandLine.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Compression.o: ../../bootil/src/Bootil/Utility/Compression.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/CompressionLZMA.o: ../../bootil/src/Bootil/Utility/CompressionLZMA.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Hasher.o: ../../bootil/src/Bootil/Utility/Hasher.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/PackFile.o: ../../bootil/src/Bootil/Utility/PackFile.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Processes.o: ../../bootil/src/Bootil/Utility/Processes.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"
$(OBJDIR)/Time.o: ../../bootil/src/Bootil/Utility/Time.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(CXXFLAGS) -o "$@" -c "$<"

-include $(OBJECTS:%.o=%.d)
