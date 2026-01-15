# MPLAB IDE generated this makefile for use with GNU make.
# Project: tpmstft.mcp
# Date: Wed Jul 21 13:54:07 2010

AS = pic30-as.exe
CC = pic30-gcc.exe
LD = pic30-ld.exe
AR = pic30-ar.exe
HX = pic30-bin2hex.exe
RM = rm

tpmstft.hex : tpmstft.cof
	$(HX) "tpmstft.cof"

tpmstft.cof : tpmstft.o
	$(CC) -mcpu=24FJ64GA004 "tpmstft.o" -o"tpmstft.cof" -Wl,--script="p24FJ64GA004.gld",--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD3=1,--defsym=__ICD2RAM=1,-Map="tpmstft.map",--report-mem

tpmstft.o : DATA.S prog.s tpmstft.h A2.H p24fj64ga004.inc tpmstft.s
	$(CC) -mcpu=24FJ64GA004 -c -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 "tpmstft.s" -o"tpmstft.o" -Wa,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD3=1,-g

clean : 
	$(RM) "tpmstft.o" "tpmstft.cof" "tpmstft.hex"

