# GNU Make solution makefile autogenerated by Premake
# Type "make help" for usage help

ifndef config
  config=debug
endif
export config

PROJECTS := gmsv_cwutil Bootil

.PHONY: all clean help $(PROJECTS)

all: $(PROJECTS)

gmsv_cwutil: Bootil
	@echo "==== Building gmsv_cwutil ($(config)) ===="
	@${MAKE} --no-print-directory -C . -f gmsv_cwutil.make

Bootil: 
	@echo "==== Building Bootil ($(config)) ===="
	@${MAKE} --no-print-directory -C . -f Bootil.make

clean:
	@${MAKE} --no-print-directory -C . -f gmsv_cwutil.make clean
	@${MAKE} --no-print-directory -C . -f Bootil.make clean

help:
	@echo "Usage: make [config=name] [target]"
	@echo ""
	@echo "CONFIGURATIONS:"
	@echo "   debug"
	@echo "   release"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   gmsv_cwutil"
	@echo "   Bootil"
	@echo ""
	@echo "For more information, see http://industriousone.com/premake/quick-start"
