;******************************************************************************
;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 
/*
fiber
 sw1 1234 must be on,off,on,off        
 sw2.321 is the cardNo, on=0, off=1,sw2.4 must be 0
 sw3 must same sw2       

*/

	
 

        .equ __24ep64gp206, 1 ;
        .include "p24ep64gp206.inc"

;BY DEFINE=============================
;	.EQU JS203_39A_F01_02	,1      ;SSPA DRIVER
;	.EQU JS203_39A_L01_02	,1      ;LA
;        .EQU JS203_39A_C01_04  ,1       ;FIBER
;       .EQU JS203_39A_K01_01   ,1      ;io
;        .EQU JS203_39A_K01_02   ,1      ;io
        .EQU JS203_39A_M01_01   ,1      ;RF
;       .EQU JS203_39A_A01_03   ,1      ;IPC
;
;	.EQU DEBUG_SLOT_ID_K	        ,0x0001

;===================================

;===================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'

        .EQU    DEVICE_ID_K             ,0x2536 ;
        .EQU    SON_DEVICE_ID_K         ,0x2537 ;
	.EQU 	SERIAL_ID_K		,0x0000

	.EQU 	PCUI_DEVICE_ID_K	,0x2403	
	.EQU 	PCIO_DEVICE_ID_K	,0x2300	
	.EQU 	SLOT_DEVICE_ID_K	,0x8900	
	.EQU 	SLOTCTR_DEVICE_ID_K	,0x8902
	.EQU 	LEDPNL_DEVICE_ID_K	,0x8904

	.EQU 	F24SET_FADR	,0xA000	;DONT USE THE LAST BLOCK OF FLASH(0x0AF00)
	.EQU 	F24KEY_FADR	,0xA100	;DONT USE THE LAST BLOCK OF FLASH(0x0AF00)
	.EQU 	F24TEST_FADR	,0xA200	;DONT USE THE LAST BLOCK OF FLASH(0x0AF00)
	.EQU 	RX485_SYNC_K	,0xAAC6
;;=====================================================



;====================================
	.include "pindef.s";
;====================================


;..............................................................................
;Global Declarations:
;..............................................................................
    	.global __reset          
    	.global __T1Interrupt    
    	.global __T3Interrupt    
    	.global __T4Interrupt    
    	.global __INT1Interrupt    
  	.global __U1RXInterrupt    
  	.global __U1TXInterrupt  
  	.global __U2RXInterrupt    
  	.global __U2TXInterrupt  
    	.global __IC1Interrupt    
    	.global __IC2Interrupt    
    	.global __IC3Interrupt    
.MACRO 	LDPTR XX
    	MOV #tbloffset(\XX),W1
.ENDM

.MACRO 	LDPTR3 XX
    	MOV #tbloffset(\XX),W3
.ENDM


.MACRO 	BSF XX
	BSET \XX,#&XX&_P
.ENDM
.MACRO 	BCF XX
	BCLR \XX,#&XX&_P
.ENDM
.MACRO 	TG XX
	BTG \XX,#&XX&_P
.ENDM
.MACRO 	BTFSS XX
	BTSS \XX,#&XX&_P
.ENDM
.MACRO 	BTFSC XX
	BTSC \XX,#&XX&_P
.ENDM


.MACRO 	SETIICT	XX
	MOV TMR3,W0
	MOV W0,IICTMRB		
	MOV #\XX,W0		
	MOV W0,IICTMRL		
.ENDM
	
.MACRO 	CHKIICT
	MOV IICTMRB,W0			;;
	SUB TMR3,WREG			;;
	SUBR IICTMRL,WREG		;;
.ENDM



.MACRO 	RETW XX
        RETLW #\XX,W0
.ENDM

.MACRO 	LOFFS0 XX
        MOV #tbloffset(\XX),W0
.ENDM
.MACRO 	LOFFS1 XX
        MOV #tbloffset(\XX),W1
.ENDM
.MACRO 	LOFFS2 XX
        MOV #tbloffset(\XX),W2
.ENDM
.MACRO 	LOFFS3 XX
        MOV #tbloffset(\XX),W3
.ENDM
.MACRO 	LOFFS4 XX
        MOV #tbloffset(\XX),W4
.ENDM
.MACRO 	LOFFS5 XX
        MOV #tbloffset(\XX),W5
.ENDM
.MACRO 	LOFFS6 XX
       	MOV #tbloffset(\XX),W6
.ENDM
.MACRO 	LOFFS7 XX
        MOV #tbloffset(\XX),W7
.ENDM

.MACRO 	MOVLF XX,YY
        MOV #\XX,W0
	MOV W0,\YY
.ENDM

.MACRO 	MOVFF XX,YY
	PUSH \XX
	POP \YY
.ENDM
	

.MACRO 	LTADR XX
        PUSH W0
        MOV #tbloffset(\XX),W0
        MOV W0,TADR
        POP W0
.ENDM

.MACRO 	WRFLD XX,YY
        MOV #\XX,W0
        MOV #\YY,W1
        CALL WRFD8
.ENDM

.MACRO 	WRFWD XX
        MOV #\XX,W1
        CALL WRFD8
.ENDM
        
.MACRO 	RRFDW XX
        MOV #\XX,W1
        CALL RRFD8
.ENDM

.MACRO 	WRFRD XX,YY
        MOV \XX,W0
        MOV #\YY,W1
        CALL WRFD8
.ENDM

.MACRO 	WRFCMD XX
        MOV #\XX,W0
        CALL WRFTRIG
.ENDM



;..............................................................................
;Constants stored in Program space
;..............................................................................

        .section .CONST, code
        .palign 2                ;Align next word stored in Program space to an
                                 ;address that is a multiple of 2

;..............................................................................
;Uninitialized variables in Near data memory (Lower 8Kb of RAM)
;..............................................................................

          .section .nbss, bss, near

ICD2_USE: 		.SPACE 128
START_REG:		.SPACE 0
R0:    			.SPACE 2		
R1:			.SPACE 2		
R2:			.SPACE 2		
R3:			.SPACE 2		
R4:			.SPACE 2		
R5:			.SPACE 2		
R6:			.SPACE 2		
R7:			.SPACE 2		
R8:			.SPACE 2		
R9:			.SPACE 2		
DEBUG_CNT:		.SPACE 2		
DEBUG_CNT1:		.SPACE 2
DEBUG_CNT2:		.SPACE 2
DEBUG_CNT3:		.SPACE 2
DEBUG_CNT4:		.SPACE 2

F24_ADR:		.SPACE 2		
F24_LEN:		.SPACE 2		

MY_SLOT_ID:		.SPACE 2		
MY_ITEM_ID:		.SPACE 2
MY_TYPE_ID:		.SPACE 2		
SON_SERIAL_ID:		.SPACE 2
SLOT_STATUS:		.SPACE 2		
SLOT_TEST_STATUS:	.SPACE 2		
SLOT_TEST_TIM:	        .SPACE 2		
CONN485_TIM:	        .SPACE 2		

RFTXCHA0:	        .SPACE 2		
RFTXCHA1:	        .SPACE 2		
RFRXCHA0:	        .SPACE 2		
RFRXCHA1:	        .SPACE 2		
		


U2TXACT_INX:		.SPACE 2		
U2TXACT_PARA0:		.SPACE 2		
U2TXACT_PARA1:		.SPACE 2		
U2TXACT_PARA2:		.SPACE 2		
U2TXACT_PARA3:		.SPACE 2		
U2RX_PACK_TIME:		.SPACE 2
U2TX_REPEAT_TIM:       .SPACE 2

EMU_U2TX_CNT:       .SPACE 2
EMU_U2TX_TIM:       .SPACE 2
EMU_U2TX_BYTE:       .SPACE 2


UTX_FLAG:		.SPACE 2
SW1_FLAG:		.SPACE 2

SSPA_RFOP:		.SPACE 2
SSPA_TEMP:		.SPACE 2
SSPA_FLAG:		.SPACE 2
V50VADI:		.SPACE 2
I50VADI:		.SPACE 2
T50VADI:		.SPACE 2
V32VADI:		.SPACE 2
I32VADI:		.SPACE 2
T32VADI:		.SPACE 2
PS_FLAG:		.SPACE 2


GPS_DATA_LEN:		.SPACE 2


ADXBUF00:		.SPACE 2
ADXBUF01:		.SPACE 2
ADXBUF02:		.SPACE 2
ADXBUF03:		.SPACE 2

ADXBUF10:		.SPACE 2
ADXBUF11:		.SPACE 2
ADXBUF12:		.SPACE 2
ADXBUF13:		.SPACE 2

ADXBUF20:		.SPACE 2
ADXBUF21:		.SPACE 2
ADXBUF22:		.SPACE 2
ADXBUF23:		.SPACE 2

ADXBUF30:		.SPACE 2
ADXBUF31:		.SPACE 2
ADXBUF32:		.SPACE 2
ADXBUF33:		.SPACE 2

ADWAIT_TIM:		.SPACE 2



;;====================================
TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2
SHIFT_FLAG:		.SPACE 2
SHIFT_TIM:		.SPACE 2
TMR2H_BUF:		.SPACE 2

TMR3_BUF:		.SPACE 2		
TMR3_FLAG:		.SPACE 2		
TMR3_IORF:		.SPACE 2

WG_FREQ_CH:             .SPACE 2
ATTENUATE:		.SPACE 2
IOOUT_FLAG:		.SPACE 2
SYS_STATUS_0L:          .SPACE 2           
SYS_STATUS_0H:          .SPACE 2           
SYS_STATUS_1L:          .SPACE 2           
SYS_STATUS_1H:          .SPACE 2           
SYS_FLAG_0L:            .SPACE 2           
SYS_FLAG_0H:            .SPACE 2           
SYS_FLAG_1L:            .SPACE 2           
SYS_FLAG_1H:            .SPACE 2           

PWRON_TIM:		.SPACE 2
RESET_TIM:		.SPACE 2


MULT_TIM:		.SPACE 2
MULTJ0_CNT:		.SPACE 2
MULTJ1_CNT:		.SPACE 2
MULTJ2_CNT:		.SPACE 2
MULTJ3_CNT:		.SPACE 2
MULTJ4_CNT:		.SPACE 2
MULTJ5_CNT:		.SPACE 2
MULTJ6_CNT:		.SPACE 2
MULTJ7_CNT:		.SPACE 2

UICON_TIM:		.SPACE 2
CTRCON_TIM:		.SPACE 2

DRVSON_CLR_TBUF0:       .SPACE 2        
DRVSON_CLR_TBUF1:       .SPACE 2        
DRVSON_CLR_TBUF2:       .SPACE 2        
DRVSON_CLR_TBUF3:       .SPACE 2        
DRVSON_CLR_TBUF4:       .SPACE 2        
DRVSON_CLR_TBUF5:       .SPACE 2        
DRVSON_CLR_TBUF6:       .SPACE 2        
DRVSON_CLR_TBUF7:       .SPACE 2        

		
;;====================================
FLAGA:	        	.SPACE 2
FLAGB:	        	.SPACE 2
FLAGC:	        	.SPACE 2
FLAGD:	        	.SPACE 2
SPIBUF:			.SPACE 2		
SPIBUFA:		.SPACE 2		
SPIBUFB:		.SPACE 2		
;;====================================
CMDINX:			.SPACE 2
CMDSTEP:		.SPACE 2
CMDTIME:		.SPACE 2
CMDCNT0:		.SPACE 2
CMDCNT1:		.SPACE 2

DELAY_ACT_TIM:		.SPACE 2
DELAY_ACT:		.SPACE 2

TX_DEVICE_ID:		.SPACE 2
TX_SERIAL_ID:		.SPACE 2
TX_GROUP_ID:		.SPACE 2

SLOT_POS:		.SPACE 2




;;====================================
RX_DEVICE_ID:	        .SPACE 2
RX_SERIAL_ID:	        .SPACE 2
RX_GROUP_ID:	        .SPACE 2

CONVAD_CNT:		.SPACE 2
VR1BUF:			.SPACE 2
VR1V:			.SPACE 2
DEBUG_CHKSUM0:		.SPACE 2
DEBUG_CHKSUM1:		.SPACE 2
WRITE_KEY_CNT:		.SPACE 2
SETKEY_ID:		.SPACE 2
;;====================================
;;====================================
FADR0:			.SPACE 2
FADR1:			.SPACE 2
FADR0_BAK:		.SPACE 2
FADR1_BAK:		.SPACE 2
CHKSUM:			.SPACE 2
TEMP_BUF0:		.SPACE 2
TEMP_BUF1:		.SPACE 2
TEMP_BUF2:		.SPACE 2
TEMP_BUF3:		.SPACE 2
TEMP_BUF4:		.SPACE 2
TEMP_BUF5:		.SPACE 2
TEMP_BUF6:		.SPACE 2
TEMP_BUF7:		.SPACE 2
TEMP_BUF8:		.SPACE 2
TEMP_BUF9:		.SPACE 2
TEMP_BUFA:		.SPACE 2
TEMP_BUFB:		.SPACE 2
TEMP_BUFC:		.SPACE 2
TEMP_BUFD:		.SPACE 2
TEMP_BUFE:		.SPACE 2
TEMP_BUFF:		.SPACE 2


IN_FLAG:		.SPACE 2
OUT_FLAG:		.SPACE 2
;WAIT_DUTX_TIM:		.SPACE 2
;F24SET_BUF:		.SPACE 64
;;====================================
;C1DO0:			.SPACE 2
;C1DI0:			.SPACE 2
;C1DO1:			.SPACE 2
;C1DI1:			.SPACE 2
;C1BCLK_CNT:		.SPACE 2
;ICIO_CNT:		.SPACE 2
;ICIO_CNTB:		.SPACE 2
;;====================================
;EDFLAG0:		.SPACE 2
;EDFLAG1:		.SPACE 2
;EDFLAG2:		.SPACE 2
;EDFLAG3:		.SPACE 2
;;====================================
;;====================================
;PP_GROUP:		.SPACE 2
;MID:			.SPACE 2
;SID:			.SPACE 2
;RX_GRP:		.SPACE 2
;RX_FMID:		.SPACE 2
;RX_FSID:		.SPACE 2
;RX_TMID:		.SPACE 2
;RX_TSID:		.SPACE 2
;RX_MCMD:		.SPACE 2
;RX_SCMD:		.SPACE 2
;RX_PARA0:		.SPACE 2
;RX_PARA1:		.SPACE 2
;RX_PARA2:		.SPACE 2
;RX_PARA3:		.SPACE 2
;RX_PARA4:		.SPACE 2
;RX_PARA5:		.SPACE 2
;RX_PARA6:		.SPACE 2
;RX_PARA7:		.SPACE 2
URX_BUF:		.SPACE 64 ;32 WORD
;;====================================
U1RX_BYTE_PTR:		.SPACE 2
U1RXA_LEN:		.SPACE 2
U1RXB_LEN:		.SPACE 2
U1RX_LEN:		.SPACE 2
U1TX_BCNT:		.SPACE 2
U1TX_BTX:		.SPACE 2
U1RX_XORSUM:		.SPACE 2
U1RX_ADDSUM:		.SPACE 2
U1RX_TMP0:		.SPACE 2
U1RX_TMP1:		.SPACE 2
U1RXT:			.SPACE 2
;;====================================
U2RX_BYTE_PTR0:		.SPACE 2
U2RX_BYTE_PTR:		.SPACE 2
U2RXA_LEN:		.SPACE 2
U2RXB_LEN:		.SPACE 2
U2RX_LEN:		.SPACE 2
U2TX_BCNT:		.SPACE 2
U2TX_BTX:		.SPACE 2
U2RX_XORSUM:		.SPACE 2
U2RX_ADDSUM:		.SPACE 2
U2RX_TMP0:		.SPACE 2
U2RX_TMP1:		.SPACE 2
U2RXT:			.SPACE 2
;;====================================
;;====================================
;;====================================
;;====================================


ADCH_CNT:		.SPACE 2		
ADBUF_CNT:		.SPACE 2		
ADBUF0:			.SPACE 2		
ADBUF1:			.SPACE 2		
ADBUF2:			.SPACE 2		
ADBUF3:			.SPACE 2		
ADTEST:			.SPACE 2		



ADI0BUF:	        .SPACE 2	;5VAD	
ADI1BUF:	        .SPACE 2	;ADS0	
ADI2BUF:	        .SPACE 2        ;ADS1			        
ADI3BUF:	        .SPACE 2        ;ADS2			
ADI4BUF:	        .SPACE 2        ;ADS3			
LDFIOBUF:               .SPACE 2	;B15~8:ULN2803 OUT,	
                                        ;B7~4:LDFOOUT
                                        ;B3~0:LDFOIN
;;====================================
RX_CH:			.SPACE 2
RX_ADDR:		.SPACE 2
RX_FLAGS:		.SPACE 2
RX_LEN:			.SPACE 2
RX_CMD:			.SPACE 2
RX_PARA0:		.SPACE 2	
RX_PARA1:		.SPACE 2	
RX_PARA2:		.SPACE 2	
RX_PARA3:		.SPACE 2	

	

UTX_CMD:		.SPACE 2	
UTX_PARA0:		.SPACE 2	
UTX_PARA1:		.SPACE 2	
UTX_PARA2:		.SPACE 2	
UTX_PARA3:		.SPACE 2	
URX_PARA0:		.SPACE 2	
URX_PARA1:		.SPACE 2	
URX_PARA2:		.SPACE 2	
URX_PARA3:		.SPACE 2	
UTX_CHKSUM0:		.SPACE 2	
UTX_CHKSUM1:		.SPACE 2	
UTX_BTX:		.SPACE 2	
UTX_BUFFER_LEN:		.SPACE 2	


RS485_CMD:		.SPACE 2	
RS485_CMD_PARA0:	.SPACE 2	
RS485_CMD_PARA1:	.SPACE 2	
RS485_CMD_PARA2:	.SPACE 2	
RS485_CMD_PARA3:	.SPACE 2	



;;====================================



;######################################
SET_BUF:		.SPACE 0 ;256
PARA0_FSET:		.SPACE 2
PARA1_FSET:		.SPACE 2
PARA2_FSET:		.SPACE 2
PARA3_FSET:		.SPACE 2
PARA4_FSET:		.SPACE 2
PARA5_FSET:		.SPACE 2
PARA6_FSET:		.SPACE 2
PARA7_FSET:		.SPACE 2
PARA8_FSET:		.SPACE 2
PARA9_FSET:		.SPACE 2
PARAA_FSET:		.SPACE 2
PARAB_FSET:		.SPACE 2
PARAC_FSET:		.SPACE 2
PARAD_FSET:		.SPACE 2
PARAE_FSET:		.SPACE 2
PARAF_FSET:		.SPACE 2
;=====================================
SET_END:		.SPACE 0
SET_SPARE:		.SPACE (128+SET_BUF-SET_END)
;=================================

URXTMP:			.SPACE 0
UTXTMP:			.SPACE 64
URXTMP_LEN:		.SPACE 2
UTXTMP_LEN:		.SPACE 2

U2RX_PACK_PTR0:		.SPACE 2
U2RX_PACK_PTR1:		.SPACE 2
U2RX_PACK_BUF:		.SPACE 64
LOOP_ADR_START:         .SPACE 2
LOOP_ADR_END:           .SPACE 2



;BYTE0-BIT3~0 NOWPAGE
;BYTE0-BIT4~0 LOAD OK
;BYTE4 CHKSUM0
;BYTE5 CHKSUM1
;BYTE6 CHKSUM2
;BYTE7 CHKSUM3

;RF MODULE USE
RFERR:                  .SPACE 2
RADR:                   .SPACE 2
TADR:                   .SPACE 2
DADR:                   .SPACE 2
DADR_ST:	        .SPACE 2		
DADR_END:	        .SPACE 2		
BTLIM:                  .SPACE 2
BTCNT:                  .SPACE 2
ANDDATA:                .SPACE 2                 
IORDATA:                .SPACE 2                 
MEM_RH:                 .SPACE 2
MEM_RL:                 .SPACE 2


TMP00:		        .SPACE 2		
TMP01:		        .SPACE 2		
TMP02:		        .SPACE 2		
TMP03:		        .SPACE 2		
TMP04:		        .SPACE 2		
TMP05:		        .SPACE 2		
TMP06:		        .SPACE 2		
TMP07:		        .SPACE 2		
TMP08:		        .SPACE 2		
TMP09:		        .SPACE 2		
TMP0A:		        .SPACE 2		
TMP0B:		        .SPACE 2		
TMP0C:		        .SPACE 2		
TMP0D:		        .SPACE 2		
TMP0E:		        .SPACE 2		
TMP0F:		        .SPACE 2		

RFA_CH:		        .SPACE 2		
RFB_CH:		        .SPACE 2		


END_REG:		.SPACE 2




.EQU STACK_BUF		,0x1E00	
.EQU KEYTBL_BUF		,0X1F00
.EQU U1RX_BUFSIZE	,640	;
.EQU U1RX_BUFA		,0x2000	;
.EQU U1RX_BUFB		,0x2280	;
.EQU U2RX_BUFSIZE	,256	;
.EQU U2RX_BUFA		,0x2500	;512
.EQU U2RX_BUFB		,0x2600	;
.EQU U1TX_BUF		,0x2700	;
.EQU U2TX_BUF		,0x2800	;512
.EQU SLOTINF_BUF	,0x2A00 ; 10WORD x4


;DRIVER
/*
sspaPowerStatusAA[2][36]; 8BIT
sspaPowerV50vAA[2][36];   12BIT      
sspaPowerV50iAA[2][36];   12BIT      
sspaPowerV50tAA[2][36];   12BIT               
sspaPowerV32vAA[2][36];   12BIT      
sspaPowerV32iAA[2][36];   12BIT      
sspaPowerV32tAA[2][36];   12BIT      
sspaModuleStatusAA[2][36];  8BIT      
sspaModuleRfOutAA[2][36];   12BIT      
sspaModuleTemprAA[2][36];   12BIT      
*/








.EQU GPS_DATA_BUF	,0x2B00	;64
.EQU FLASH_TMP		,0x2C00	;512			
.EQU F24TMP_BUF		,0x2C00	;512		

.EQU END_RAM		,0x2FFF		;512W

;END=4FFF

; 0=4S
; 1=8uS
; 2=16uS
; 3=31uS
; 4=62.5uS
; 5=125uS
; 6=250uS
; 7=500US
; 8=1MS
; 9=2 
;10=4
;11=8
;12=16
;13=32
;14=64
;15=128



;TMR2_FLAG
.EQU    T4U_F_P      	,0
.EQU    T8U_F_P      	,1
.EQU    T16U_F_P      	,2
.EQU	T32U_F_P	,3
.EQU	T64U_F_P	,4
.EQU	T128U_F_P	,5
.EQU	T256U_F_P	,6
.EQU	T512U_F_P	,7
.EQU	T1M_F_P		,8
.EQU	T2M_F_P		,9
.EQU	T4M_F_P 	,10
.EQU	T8M_F_P		,11
.EQU	T16M_F_P	,12
.EQU	T32M_F_P	,13
.EQU	T64M_F_P	,14
.EQU	T128M_F_P	,15
.EQU    T4U_F      	,TMR2_FLAG
.EQU    T8U_F      	,TMR2_FLAG
.EQU    T16U_F      	,TMR2_FLAG
.EQU	T32U_F		,TMR2_FLAG
.EQU	T64U_F		,TMR2_FLAG
.EQU	T128U_F		,TMR2_FLAG
.EQU	T256U_F		,TMR2_FLAG
.EQU	T512U_F		,TMR2_FLAG
.EQU	T1M_F		,TMR2_FLAG
.EQU	T2M_F		,TMR2_FLAG
.EQU	T4M_F 		,TMR2_FLAG
.EQU	T8M_F		,TMR2_FLAG
.EQU	T16M_F		,TMR2_FLAG
.EQU	T32M_F		,TMR2_FLAG
.EQU	T64M_F		,TMR2_FLAG
.EQU	T128M_F		,TMR2_FLAG









;FLAGA
.EQU UICON_F		,FLAGA
.EQU UICON_F_P		,0
.EQU CTRCON_F		,FLAGA
.EQU CTRCON_F_P		,1
.EQU U1U2_F		,FLAGA
.EQU U1U2_F_P	        ,2
.EQU U1TXON_F		,FLAGA
.EQU U1TXON_F_P         ,3
.EQU U2TXON_F	        ,FLAGA
.EQU U2TXON_F_P 	,4
.EQU YES_F	        ,FLAGA	
.EQU YES_F_P	        ,5
.EQU CONN485_F	        ,FLAGA
.EQU CONN485_F_P	,6
;.EQU SLOT_ERR_F	,FLAGA
;.EQU SLOT_ERR_F_P	,7
.EQU ERR_F		,FLAGA
.EQU ERR_F_P		,8
.EQU OK_F		,FLAGA
.EQU OK_F_P		,9
.EQU DONE_F		,FLAGA
.EQU DONE_F_P		,10
;.EQU EMU_U2TX_F	,FLAGA
;.EQU EMU_U2TX_F_P	,11
;EQU AICIO_AB_F		,FLAGA
;EQU AICIO_AB_F_P  	,12
.EQU MASTER_U1RX_F	,FLAGA
.EQU MASTER_U1RX_F_P 	,13
.EQU MASTER_U2RX_F	,FLAGA
.EQU MASTER_U2RX_F_P 	,14
.EQU WAIT_DUTX_F	,FLAGA
.EQU WAIT_DUTX_F_P  	,15



;FLAGB
.EQU MCURX1_ALT_F	,FLAGB
.EQU MCURX1_ALT_F_P	,0
.EQU MCURX2_ALT_F	,FLAGB
.EQU MCURX2_ALT_F_P	,1
.EQU MCURX1_PACK_F	,FLAGB
.EQU MCURX1_PACK_F_P	,2
.EQU MCURX2_PACK_F	,FLAGB
.EQU MCURX2_PACK_F_P	,3
.EQU MCURX1_START_F	,FLAGB
.EQU MCURX1_START_F_P	,4
.EQU MCURX2_START_F	,FLAGB
.EQU MCURX2_START_F_P	,5
.EQU MCURX3_START_F	,FLAGB
.EQU MCURX3_START_F_P	,6
.EQU MCURX3_ALT_F	,FLAGB
.EQU MCURX3_ALT_F_P	,7
.EQU MCURX3_PACK_F	,FLAGB
.EQU MCURX3_PACK_F_P	,8
.EQU MCUTX3_EN_F	,FLAGB
.EQU MCUTX3_EN_F_P	,9
.EQU U2TX_WAKE_F	,FLAGB
.EQU U2TX_WAKE_F_P	,10
.EQU MCUTX1_START_F	,FLAGB
.EQU MCUTX1_START_F_P	,11
.EQU MCUTX2_START_F	,FLAGB
.EQU MCUTX2_START_F_P	,12
.EQU MCURX1_START_F	,FLAGB
.EQU MCURX1_START_F_P	,13
.EQU MCURX3_EN_F	,FLAGB
.EQU MCURX3_EN_F_P	,14
;.EQU DIS_KFREE_F	,FLAGB
;.EQU DIS_KFREE_F_P	,15



;FLAGC
.EQU EMU_U2TX_F 	,FLAGC
.EQU EMU_U2TX_F_P	,0
.EQU EMU_DATA_F	        ,FLAGC
.EQU EMU_DATA_F_P	,1
.EQU ERROR_F    	,FLAGC
.EQU ERROR_F_P	        ,2
.EQU RFAB_F    	        ,FLAGC
.EQU RFAB_F_P	        ,3
.EQU RF_EN_F    	,FLAGC
.EQU RF_EN_F_P	        ,4
.EQU NEW_DEVSON_F	,FLAGC
.EQU NEW_DEVSON_F_P	,5
;EQU MYMID_F		,FLAGC
;EQU MYMID_F_P		,6
;.EQU SNDPACK_RXAB_F	,FLAGC
;.EQU SNDPACK_RXAB_F_P	,7
;EQU LDU1TX_U2RACRB_F	,FLAGC
;EQU LDU1TX_U2RACRB_F_P	,8
;EQU LDU2TX_U1RACRB_F	,FLAGC
;EQU LDU2TX_U1RACRB_F_P	,9
;EQU LDU1TX_U2RBCRA_F	,FLAGC
;EQU LDU1TX_U2RBCRA_F_P	,10
;EQU LDU2TX_U1RBCRA_F	,FLAGC
;EQU LDU2TX_U1RBCRA_F_P	,11
;EQU IICS_RXED_F	,FLAGC
;EQU IICS_RXED_F_P	,12
;EQU IICRX_ERR_F	,FLAGC
;EQU IICRX_ERR_F_P	,13
;EQU LD_CODTXA_F	,FLAGC
;EQU LD_CODTXA_F_P	,14
;EQU LD_CODTXB_F	,FLAGC
;EQU LD_CODTXB_F_P	,15


;FLAGD
.EQU U1TX_EN_F		,FLAGD
.EQU U1TX_EN_F_P	,0
.EQU U2TX_EN_F		,FLAGD
.EQU U2TX_EN_F_P	,1
.EQU U1RX_BUFAB_F	,FLAGD
.EQU U1RX_BUFAB_F_P	,2
.EQU U2RX_BUFAB_F	,FLAGD
.EQU U2RX_BUFAB_F_P	,3
.EQU U1RXT_F		,FLAGD
.EQU U1RXT_F_P		,4
.EQU U2RXT_F		,FLAGD
.EQU U2RXT_F_P		,5
.EQU U1TX_END_F		,FLAGD
.EQU U1TX_END_F_P	,6 
.EQU U2TX_END_F		,FLAGD
.EQU U2TX_END_F_P	,7 
.EQU U1RX_PACKA_F	,FLAGD
.EQU U1RX_PACKA_F_P	,8 
.EQU U2RX_PACKA_F	,FLAGD
.EQU U2RX_PACKA_F_P	,9 
.EQU U1RX_PACKB_F	,FLAGD
.EQU U1RX_PACKB_F_P	,10
.EQU U2RX_PACKB_F	,FLAGD
.EQU U2RX_PACKB_F_P	,11
.EQU U1RX_EN_F		,FLAGD
.EQU U1RX_EN_F_P	,12
.EQU U2RX_EN_F		,FLAGD
.EQU U2RX_EN_F_P	,13






.text                             ;Start of Code section
__reset:
 	GOTO POWER_ON



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_WREG:			;;
        CLR W0			;;
        MOV W0,W14		;;
        REPEAT #12		;;
        MOV W0,[++W14]		;;
        CLR W14			;;
        RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_ALLREG:			;;
	MOV #START_REG,W1	;;
CLR_ALLREG_1:			;;
	CLR [W1++]		;;
	MOV #END_REG,W0		;;		
	CP W1,W0		;;
	BRA NZ,CLR_ALLREG_1	;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TEST_DLY:
        MOVLF #50,R0
TEST_DLY_1:
        CLRWDT
	MOV #30000,W0		;;
	CALL DLYX		;;
        DEC R0
        BRA NZ,TEST_DLY_1
        RETURN

BLINK_GLED:
        CLRWDT
        BCF LEDG_O
        CALL TEST_DLY
        BSF LEDG_O
        CALL TEST_DLY
        BRA BLINK_GLED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
POWER_ON:			;;
        MOV #STACK_BUF,W15  	;;Initialize the Stack Pointer Limit Register
        MOV #STACK_BUF+254,W0  	;;Initialize the Stack Pointer Limit Register
        MOV W0,SPLIM		;;
        CALL CLR_WREG 		;;
	CALL CLR_ALLREG		;;
	CALL INIT_IO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #100,W1		;;
WAIT_POWER:			;;
	MOV #1000,W0		;;
	CALL DLYUX		;;
	DEC W1,W1		;;
	BRA NZ,WAIT_POWER	;;
	CALL GET_SLOTID		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL CLR_WREG 		;;
	CALL INIT_IO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL INIT_RAM		;;
	CALL INIT_OSC		;;
	MOV #10000,W0		;;
	CALL DLYX		;;
        ;CALL TEST_OSC
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_TIMER2	;;
	CALL INIT_UART1		;;
	;CALL INIT_INT		;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CALL INIT_TIMER1	;;
	;CALL INIT_TIMER3	;;
	;CALL INIT_TIMER4	;;
	;CALL INIT_IC1		;;
	;CALL INIT_IC2		;;
	;CALL INIT_IC3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CALL TEST_MCUTX3	;;	
	;CALL TEST_UART2	;;
	;CALL TEST_TIMER	;;
	;CALL TEST_UART1	        ;;
	;CALL TEST_UART2_I	;;
	;CALL TEST_PWM		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;K01_01	                ;;              
        ;CALL TEST_LDLO         ;;
        ;CALL TEST_LSEO         ;;
        ;CALL TEST_LDFO         ;;
        ;CALL GETSW             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;CALL TEST_FIB_TX       ;;
	MOV #100,W0		;;
	CALL DLYMX		;;
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART2_115200:			;;
	MOV #142,W0	;115200		;;66MHZ
        BRA INIT_UART2_1                ;;
INIT_UART2_38400:			;;
	MOV #426,W0	;38400		;;66MHZ
        BRA INIT_UART2_1                ;;
INIT_UART2_9600:			;;
	MOV #1704,W0	;9600		;;66MHZ
        BRA INIT_UART2_1                ;;
INIT_UART2_460800:			;;
	MOV #35,W0	;460800		;;66MHZ
        BRA INIT_UART2_1                ;;
INIT_UART2_1:                           ;;        
	MOV W0,U2BRG			;;
	MOV #0x8008,W0			;;8BIT
	MOV W0,U2MODE			;;
	MOV #0x0400,W0			;;
	MOV W0,U2STA 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC7,#14 			;;
	BCLR IPC7,#13 			;;
	BSET IPC7,#12 			;;
	BCLR IFS1,#U2TXIF		;;
	BSET IEC1,#U2TXIE		;;UTXINT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	BCLR IFS1,#U2RXIF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC7,#10 			;;
	BCLR IPC7,#9 			;;
	BSET IPC7,#8 			;;
	BCLR IFS1,#U2RXIF		;;
	BSET IEC1,#U2RXIE		;;URXINT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_F24:				;;
	MOV #128,W0			;;	
	MOV #F24TEST_FADR,W1		;;	
	MOV #F24TMP_BUF,W2		;;	
	CALL LOAD_F24			;;	
	NOP				;;	
	NOP				;;
	NOP				;;
	MOV #tbloffset(F24TEST_FADR),W1	;;	
	CALL ERASE_F24			;;
	NOP				;;
	NOP				;;
	NOP				;;
	MOV #128,W0			;;	
	MOV #F24TEST_FADR,W1		;;	
	MOV #F24TMP_BUF,W2		;;	
	CALL LOAD_F24			;;	
	NOP				;;
	NOP				;;	
	NOP				;;
	MOV #0,W7			;;
	MOV #128,W6			;;
	MOV #F24TMP_BUF,W1		;;
TEST_F24_1:				;;
	MOV W7,[W1++]			;;
	INC W7,W7			;;
	DEC W6,W6			;;
	BRA NZ,TEST_F24_1		;;
	NOP				;;
	NOP				;;
	NOP				;;
	MOV #F24TEST_FADR,W0		;;
	MOV W0,F24_ADR			;;
	MOV #128,W0			;;	
	MOV W0,F24_LEN			;;
	CALL SAVE_F24			;;
	NOP				;;
	NOP				;;
	NOP				;;
	MOV #128,W0			;;	
	MOV #F24TEST_FADR,W1		;;	
	MOV #F24TMP_BUF,W2		;;	
	CALL LOAD_F24			;;	
	NOP				;;
	NOP				;;
	NOP				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;66MPS
TEST_OSC:
	TG TP1_O
	TG TP1_O
	TG TP1_O
	TG TP1_O
	TG TP1_O
	TG TP1_O
	TG TP1_O
	TG TP1_O
	CLRWDT
	BRA TEST_OSC	


TEST_PWM:
	MOV #0x0406,W0
	MOV W0,OC1CON1
	MOV #0x000D,W0
	MOV W0,OC1CON2
	MOV #5000,W0
	MOV W0,OC1R
	MOV #10000,W0
	MOV W0,PR3
TEST_PWM_1:
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_PWM_1	

	

TEST_TIMER:
	CLRWDT
	BTSS TMR2,#8			;;/1MS
	BCF TP1_O
	BTSC TMR2,#8
	BSF TP1_O
	BRA TEST_TIMER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART1:				;;
	BSF RS485_DE_O
	MOV #0xAB,W0			;;
	MOV W0,U1TXREG			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART1 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_KEYTBL:				;;
	MOV #128,W0			;;	
	MOV #F24KEY_FADR,W1		;;	
	MOV #KEYTBL_BUF,W2		;;	
	CALL LOAD_F24			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





	 


;SLOT TYPE BI7~4
;01 CTR
;02 SIP
;03 FXO
;04 FXS
;05 T1S
;06 MAG
;07 ROIP
;08 RECORD

;SLOT SERIAL BI1~0





GET_SLOTID:
	SETM MY_SLOT_ID
	CLR W3
GET_SLOTID_0:
	CLR W0
	BTFSC SLOTSW_S3_I
	BSET W0,#0
	BTFSC SLOTSW_S2_I
	BSET W0,#1
	BTFSC SLOTSW_S1_I
	BSET W0,#2
	BTFSC SLOTSW_S0_I
	BSET W0,#3
	;BTFSC SLOTID4_I
	;BSET W0,#4
	.IFDEF DEBUG_SLOT_ID_K
	MOV #DEBUG_SLOT_ID_K,W0
	.ENDIF
	CP MY_SLOT_ID
	BRA Z,GET_SLOTID_1
	MOV W0,MY_SLOT_ID
        CLR MY_ITEM_ID
        BTFSC SWS4_I
        BSET MY_ITEM_ID,#0
        BTFSC SWS5_I
        BSET MY_ITEM_ID,#1
        BTFSC SWS6_I
        BSET MY_ITEM_ID,#2
        BTFSC SWS7_I
        BSET MY_ITEM_ID,#3
	CLR W3
	BRA GET_SLOTID_0
GET_SLOTID_1:
	MOV #1000,W0
	CALL DLYUX
	INC W3,W3
	MOV #500,W0	
	CP W3,W0
	BRA GEU,$+4
	BRA GET_SLOTID_0
	RETURN
	



GET_IDPRG:
	CLR W0
	BTFSC SLOTSW_S3_I
	BSET W0,#0
	BTFSC SLOTSW_S2_I
	BSET W0,#1
	BTFSC SLOTSW_S1_I
	BSET W0,#2
	BTFSC SLOTSW_S0_I
	BSET W0,#3
	MOV W0,MY_SLOT_ID
        CLR W0
        BTFSC SWS4_I
        BSET W0,#0
        BTFSC SWS5_I
        BSET W0,#1
        BTFSC SWS6_I
        BSET W0,#2
        BTFSC SWS7_I
        BSET W0,#3
        MOV W0,MY_ITEM_ID
        RETURN



/*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	BSF U1RX_EN_F			;;
	BSF U2RX_EN_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
	CLRWDT				;;
	CALL TMR2PRG			;;	
	CALL MULTIME_PRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_U2TX_END		;;
	CALL U2TXACT_PRG		;;
	CALL CHK_U1RX			;;
	CALL CHK_U2RX			;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/

	
	


	


	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MCURX1:				;;
	RETURN	  			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DEC_SYSURX:
	RETURN














IONOP:
	NOP
	NOP
	NOP
	NOP
	RETURN
	
IOPRG:

	RETURN














SET_CMDINX:
	MOV W0,CMDINX
	CLR CMDSTEP
	CLR CMDTIME
	RETURN






CHK_LDU1TX:
	RETURN
CHK_LDU2TX:
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OTHPRG:					;;
	BTSC U2STA,#OERR		;;
	BCLR U2STA,#OERR		;;
	BTSC U1STA,#OERR		;;
	BCLR U1STA,#OERR		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	













;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INBUS:					;;
	MOV TRISC,W2			;;
	MOV #0xFFFF,W0			;;
	MOV.B W0,W2			;;
	MOV W2,TRISC			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OUTBUS:					;;
	MOV TRISC,W2			;;
	MOV #0x0000,W0			;;
	MOV.B W0,W2			;;
	MOV W2,TRISC			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
KEYNOP:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RETURN






;66MIPS
; 0=4S
; 1=8uS
; 2=16uS
; 3=31uS
; 4=62.5uS
; 5=125uS
; 6=250uS
; 7=500US
; 8=1MS
; 9=2 
;10=4
;11=8
;12=16
;13=32
;14=64
;15=128



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TMR2PRG:				;;
	CLR SHIFT_FLAG
	CLR TMR2_FLAG			;;	
	MOV TMR2,W0			;;
	XOR TMR2_BUF,WREG		;;	
	BTSC SR,#Z			;;
	RETURN				;;
	MOV W0,TMR2_FLAG		;;	
	IOR TMR2_IORF			;;
	XOR TMR2_BUF			;;
	CLRWDT				;;
	BTFSC T128M_F			;;
	INC TMR2H_BUF			;;	
	BTFSS T1M_F			;;
	RETURN				;;
	INC SHIFT_TIM			;;
	MOV #16,w0			;;
	CP SHIFT_TIM			;;		
	BRA LTU,$+4			;;
	CLR SHIFT_TIM			;;
	MOV SHIFT_TIM,w0		;;
	CALL BIT_TRANS			;;	
	MOV W0,SHIFT_FLAG		;;	
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




	.EQU CMD_NONE_K			,0
	.EQU CMD_STOPALL_K		,1
	.EQU CMD_FLASH_ERASE_K		,2
	.EQU CMD_CHK_FLASH_BLANK_K	,3
	.EQU CMD_ERASE_SCAN_KEY_K	,4
	.EQU CMD_WRITE_SCAN_KEY_K	,5
	.EQU CMD_ERASE_ALL_KEY_K	,6
	.EQU CMD_SET_SCAN_KEY_K		,7
	.EQU CMD_TEST0_K		,8
	.EQU CMD_TEST1_K		,9
	.EQU CMD_TEST2_K		,10
	.EQU CMD_TEST3_K		,11
	.EQU CMD_TEST4_K		,12
	.EQU CMD_TEST5_K		,13
	.EQU CMD_SET_ONE_KEY_K		,14
	.EQU CMD_TEST6_K		,15
	.EQU CMD_TEST7_K		,16
	.EQU CMD_UTXTEST_K		,17
	.EQU CMD_RESET_KB_K		,18





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TIMEACT_PRG:				;;
        BTFSC T16M_F                    ;;
        CALL T16M_PRG                   ;;
	BTFSC T128M_F			;;
        CALL T128M_PRG                  ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


T16M_PRG:
        INC CONN485_TIM
        MOV #20,W0
        CP CONN485_TIM
        BRA LTU,$+4
        BCF CONN485_F
        RETURN
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
T128M_PRG:                              ;;
        CALL LED_PRG                    ;;
        CALL GET_IDPRG                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LED_PRG:                                ;;
        MOV SLOT_TEST_STATUS,W0         ;;
        AND #3,W0                       ;;
        BRA W0                          ;;
        BRA STP_0J                      ;;
        BRA STP_1J                      ;;
        BRA STP_2J                      ;;
        BRA STP_3J                      ;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STP_0J:                                 ;;
        MOV SLOT_STATUS,W0              ;;
        AND #3,W0                       ;;
        BRA W0                          ;;      
        BRA SLOT_STAJ0                  ;;        
        BRA SLOT_STAJ1                  ;;
        BRA SLOT_STAJ2                  ;;
        BRA SLOT_STAJ3                  ;;
SLOT_STAJ0:                             ;;
        BSF LEDG_O                      ;;
        BSF LEDR_O                      ;;
        BSF LEDB_O                      ;;
        RETURN                          ;;
SLOT_STAJ1:                             ;;
        BCF LEDG_O                      ;;
        BCF LEDR_O                      ;;
        BSF LEDB_O                      ;;
        RETURN                          ;;
SLOT_STAJ2:                             ;;
        BTFSC CONN485_F                 ;;
        TG LEDG_O                       ;;
        BTFSS CONN485_F                 ;;
        BCF LEDG_O                      ;;
        BSF LEDR_O                      ;;
        BSF LEDB_O                      ;;
        RETURN                          ;;
SLOT_STAJ3:                             ;;
        BSF LEDG_O                      ;;
        BCF LEDR_O                      ;;
        BSF LEDB_O                      ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STP_1J:                                 ;;
        BSF LEDG_O                      ;;
        BSF LEDR_O                      ;;
        BCF LEDB_O                      ;;
        RETURN                          ;;
STP_2J:                                 ;;
        BSF LEDG_O                      ;;
        BSF LEDR_O                      ;;
        TG LEDB_O                       ;;
        INC SLOT_TEST_TIM               ;;
        MOV #20,W0                      ;;
        CP SLOT_TEST_TIM                ;;
        BRA GEU,$+4                     ;;
        RETURN                          ;;
        CLR SLOT_TEST_STATUS            ;;       
        RETURN                          ;;
STP_3J:                                 ;;
        BSF LEDG_O                      ;;
        BCF LEDR_O                      ;;
        BSF LEDB_O                      ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	






	










	
LOAD_W1_1B:
	BTSC W1,#0
	BRA LOAD_W1_1B_1
	MOV [W1],W0
	AND #255,W0
	INC W1,W1
	RETURN
LOAD_W1_1B_1:
	BCLR W1,#0
	MOV [W1],W0
	SWAP W0
	AND #255,W0
	INC2 W1,W1
	RETURN
 		
LOAD_W1_2B:
	CALL LOAD_W1_1B
	PUSH W0
	CALL LOAD_W1_1B
	SWAP W0
	POP W2
	IOR W0,W2,W0
	RETURN






	






		



	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IC1:				;;
	MOV IC1BUF,W0			;;
	MOV IC1BUF,W0			;;
	MOV IC1BUF,W0			;;
	MOV IC1BUF,W0			;;
	BCLR IFS0,#IC1IF		;;
	MOVLF #0x0402,IC1CON1		;;
	BSET IPC0,#6			;;
	BCLR IPC0,#5			;;
	BCLR IPC0,#4			;;
	BSET IEC0,#IC1IE		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IC2:				;;
	MOV IC2BUF,W0			;;
	MOV IC2BUF,W0			;;
	MOV IC2BUF,W0			;;
	MOV IC2BUF,W0			;;
	BCLR IFS0,#IC2IF		;;
	MOVLF #0x0402,IC2CON1		;;
	BSET IPC0,#6			;;
	BCLR IPC0,#5			;;
	BCLR IPC0,#4			;;
	BSET IEC0,#IC2IE		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IC3:				;;
	MOV IC3BUF,W0			;;
	MOV IC3BUF,W0			;;
	MOV IC3BUF,W0			;;
	MOV IC3BUF,W0			;;
	BCLR IFS2,#IC3IF		;;
	MOVLF #0x0402,IC3CON1		;;
	BSET IPC9,#6			;;
	BCLR IPC9,#5			;;
	BCLR IPC9,#4			;;
	BSET IEC2,#IC3IE		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;INPUT W0
GET_UART_RATE:
	BTSC W0,#4		
	BRA UART_RATE_115200
	BTSC W0,#3		
	BRA UART_RATE_57600
	BRA UART_RATE_9600
UART_RATE_115200:
	MOV #0xA000,W0			;;
        MOV #189,W2                  	;;115200*3
	RETURN
UART_RATE_57600:
	MOV #0xA000,W0			;;
        MOV #378,W2                  	;;57600*3
	RETURN
UART_RATE_9600:
	MOV #0xA000,W0			;;
        MOV #2273,W2                  	;;9600*3
	RETURN
		


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER3:				;;
	MOV #0xA030,W0			;;/256
	MOV W0,T3CON			;;BASE TIME
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER2:				;;
	MOV #0xA030,W0			;;/256
	MOV W0,T2CON			;;BASE TIME
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SIO:		        ;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BCLR OSCCON,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR18		;;
	MOV #42,W0		;;RP42 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR4		;;
	MOV #0x0100,W0		;;RP43 U1TX
	IOR RPOR4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BSET OSCCON,#6		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SIO_SSPA_DRIVER:		;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BCLR OSCCON,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR18		;;
	MOV #42,W0		;;RP42 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR4		;;
	MOV #0x0100,W0		;;RP43 U1TX
	IOR RPOR4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR19		;;
	MOV #40,W0		;;RP40 U2RX
	IOR RPINR19		;;LSB:U2RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR3		;;
	MOV #0x0300,W0		;;RP41 U2TX
	IOR RPOR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BSET OSCCON,#6		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SIO_RF:			;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BCLR OSCCON,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR18		;;
	MOV #42,W0		;;RP42 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR4		;;
	MOV #0x0100,W0		;;RP43 U1TX
	IOR RPOR4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR19		;;
	MOV #55,W0		;;RP55 U2RX
	IOR RPINR19		;;LSB:U2RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR5		;;
	MOV #0x0003,W0		;;RP54 U2TX
	IOR RPOR5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BSET OSCCON,#6		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INIT_SIO_IO:			;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BCLR OSCCON,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR18		;;
	MOV #42,W0		;;RP42 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR4		;;
	MOV #0x0100,W0		;;RP43 U1TX
	IOR RPOR4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR19		;;
	MOV #40,W0		;;RP40 U2RX
	IOR RPINR19		;;LSB:U2RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR3		;;
	MOV #0x0300,W0		;;RP41 U2TX
	IOR RPOR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BSET OSCCON,#6		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_INT:			;;	
	BSET INTCON2,#INT1EP 	;;0:POSITIVE EDAGE,1:NEGTIVE EDGE
	BSET IPC5,#2 		;;
	BCLR IPC5,#1 		;;
	BCLR IPC5,#0 		;;
	BCLR IFS1,#INT1IF	;;	
	BSET IEC1,#INT1IE	;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;FCY=50mHZ
;FCY=66mHZ
;UXBRG=FCY/(4*BOUDRATE) -1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART1:				;;
	;MOV #142,W0	;115200		;;66MHZ
	;MOV #65,W0	;256000		;;66MHZ
	;MOV #47,W0	;345600		;;66MHZ
	MOV #35,W0	;460800		;;66MHZ
        ;;================================
	MOV W0,U1BRG			;;
	MOV #0x8008,W0			;;
	MOV W0,U1MODE			;;
	MOV #0x0400,W0			;;
	MOV W0,U1STA 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC3,#2 			;;
	BSET IPC3,#1 			;;
	BSET IPC3,#0 			;;
	BCLR IFS0,#U1TXIF		;;
	BSET IEC0,#U1TXIE		;;UTXINT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;
	BCLR IFS0,#U1RXIF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC2,#14 			;;
	BSET IPC2,#13 			;;
	BSET IPC2,#12 			;;
	BCLR IFS0,#U1RXIF		;;
	BSET IEC0,#U1RXIE		;;URXINT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;rs485

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DIS_U2RX:				;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	BCLR IFS1,#U2RXIF		;;
	BCLR IEC1,#U2RXIE		;;URXINT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EN_U2RX:				;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	BCLR IFS1,#U2RXIF		;;
	BSET IEC1,#U2RXIE		;;URXINT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OSC_H:					;;
OSC_FRCPLL:				;;
	MOV #1,W0			;;FRCPLL
	BRA OSC_PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
OSC_M:					;;
OSC_FRC:				;;
	MOV #7,W0			;;FRC
	BRA OSC_PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OSC_L:					;;
	MOV #7,W0			;;FRC
	BRA OSC_PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OSC_PRG:				;;
	MOV #OSCCONH,W1			;;
	MOV #0x78,W2			;;
	MOV #0x9A,W3			;;
	DISI #3				;;
	MOV.B W2,[W1]			;;
	MOV.B W3,[W1]			;;	
	MOV.B WREG,OSCCONH		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1			;;
	MOV #0x46,W2			;;
	MOV #0x57,W3			;;
	DISI #3				;;
	MOV.B W2,[W1]			;;
	MOV.B W3,[W1]			;;
	BSET OSCCON,#0			;;
OSC_PRG_1:				;;
	CLRWDT				;;
	BTSC OSCCON,#0			;;
	BRA OSC_PRG_1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_OSC:				;;
	CLR CLKDIV			;;
	MOV #48,W0			;;X*(48+2)/4=50MIPS
;	MOV #64,W0			;;X*(64+2)/4=66MIPS
	MOV #69,W0			;;X*(69+2)/3.685=66MIPS
	MOV W0,PLLFBD			;;PLLDIV
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;BIT40:PLL PREDIV=X+2	MUST BE 1-8MHZ
	IOR CLKDIV			;;
	MOV #0x0000,W0			;;BIT76:PLL POSTDIV=00=2,01=4,10=NO USE 11=8
	IOR CLKDIV			;;
	MOV #0x0000,W0			;;BIT10-8=FRCDIV OSC=7.37MHZ
	IOR CLKDIV			;;
	NOP
	NOP
	NOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10000,W0			;;
	CALL DLYX			;;
	NOP
	NOP
	NOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #7,W0			;;7=Fast RC Oscillator (FRC) with Divide-by-n
	;MOV #6,W0			;;6=Fast RC Oscillator (FRC) with Divide-by-16
	;MOV #5,W0			;;5=Low-Power RC Oscillator (LPRC)
	;MOV #3,W0			;;3=XT,HS,EC WITH PLL
	;MOV #2,W0			;;2=XT,HS,EC
	MOV #1,W0			;;1=FRCPLL
	;MOV #0,W0			;;0=FRC
	CALL OSC_PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;MAX 31
	;NEG W0,W0
	MOV W0,OSCTUN 			;;
	;MOV #0x8800,W0			;;/256 512K REFCLKO
	;MOV #0x8600,W0			;;/64  2.048 REFCLKO
	;MOV W0,REFOCON 			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_U1TX:				;;
	CLRWDT				;;
	MOV #0xAB,W0			;;
	MOV W0,U1TXREG			;;
	MOV #10000,W0			;;
	CALL DLYX			;;
	BRA TEST_U1TX			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.IFDEF JS203_39A_K01_01


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2RXInterrupt:			;;
	PUSH SR				;;
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2RXIF		;;
	MOV U2RXREG,W1			;;
	AND #255,W1			;;
	;BTFSS U2RX_EN_F		;;
	;BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #250,W0                     ;;
        ADD TMR2,WREG                   ;;
        MOV W0,U2TX_REPEAT_TIM          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xEA,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PS			;;	
	MOV #0xEB,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PE			;;	
	MOV #0xEC,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PT			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;; 
	BTFSC U2RXT_F			;;
	XOR W0,W1,W1			;;
	BCF U2RXT_F			;;
	MOV #U2RX_BUFSIZE,W0		;;
	CP U2RX_BYTE_PTR		;;
	BRA GEU,U2RXI_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2RX_BUFA,W0		;;
	BTFSC U2RX_BUFAB_F		;;
	MOV #U2RX_BUFB,W0		;;
	ADD U2RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	BTSC U2RX_BYTE_PTR,#0		;;
	BRA U2RXI_1			;;
	MOV W1,[W0]			;;
	BRA U2RXI_2			;;
U2RXI_1:				;;
	SWAP W1				;;
	ADD W1,[W0],[W0]		;;
	SWAP W1				;;
U2RXI_2:				;;
	MOV U2RX_TMP0,W0		;;
	MOV W0,U2RX_TMP1		;;
	MOV W1,W0			;;
	MOV W0,U2RX_TMP0		;;
	MOV W1,W0			;;
	ADD U2RX_ADDSUM			;;	
	XOR U2RX_XORSUM			;;
	INC U2RX_BYTE_PTR		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PS:				;;
	BCF U2RXT_F			;;
	CLR U2RX_BYTE_PTR		;;
	CLR U2RX_ADDSUM			;;
	CLR U2RX_XORSUM			;;
	BSF MASTER_U2RX_F		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PE:				;;
	BCF U2RXT_F			;;
	MOV #0xAB,W0			;;
	XOR U2RX_XORSUM,WREG		;;	
	XOR U2RX_TMP0,WREG		;;
	BRA NZ,U2RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RX_TMP0,W0		;;
	ADD U2RX_TMP0,WREG		;;
	ADD U2RX_TMP1,WREG		;;
	XOR U2RX_ADDSUM,WREG		;;
	AND #255,W0			;;
	BRA NZ,U2RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RX_BYTE_PTR,W0		;;	
	BTFSS U2RX_BUFAB_F		;;	
	MOV W0,U2RXA_LEN		;;
	BTFSC U2RX_BUFAB_F		;;	
	MOV W0,U2RXB_LEN		;;
	BTFSS U2RX_BUFAB_F		;;	
	BSF U2RX_PACKA_F		;;
	BTFSC U2RX_BUFAB_F		;;	
	BSF U2RX_PACKB_F		;;
	TG U2RX_BUFAB_F			;;	
	MOV TMR2,W0			;;
	MOV W0,U2RX_PACK_TIME		;;	
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PT:				;;
	BSF U2RXT_F			;;
	BRA U2RXI_END			;;
U2RXI_END:				;;	
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
        BSF SWS0_IO                     ;;
	;;PIN2 				;;
        BSF SWS1_IO                     ;;
	;;PIN3 				;;
        BSF SWS2_IO                     ;;
	;;PIN4 				;;
        BSF SWS3_IO                     ;;
	;;PIN5 				;;
        BSF SWS4_IO                     ;;
	;;PIN6 				;;
        BSF SWS5_IO                     ;;
	;;PIN8 				;;
        BSF SWS6_IO                     ;;
	;;PIN11 			;;
        BSF SWS7_IO                     ;;
	;;PIN12 			;;
	BCF NC12_O                      ;;
	BCF NC12_IO                     ;;
	;;PIN13 			;;
	BSF ADI_12V_IO			;;
	;;PIN14 			;;
	BSF ADI_5V_IO			;;
	;;PIN15 			;;
	BSF ADS0_IO			;;
	;;PIN16 			;;
	BSF ADS1_IO			;;
	;;PIN21 			;;
	BCF DB0_O			;;
	BCF DB0_IO			;;
	;;PIN22 			;;
	BCF DB1_O			;;
	BCF DB1_IO			;;
	;;PIN23 			;;
	BCF DB2_O			;;
	BCF DB2_IO			;;
	;;PIN24 			;;
	BCF NC24_O			;;
	BCF NC24_IO			;;
	;;PIN27 			;;
	BSF ADS2_IO			;;
	;;PIN28 			;;
	BSF ADS3_IO			;;
	;;PIN29 			;;
	BSF ADS4_IO			;;
	;;PIN30 			;;
	BSF ADS5_IO			;;
	;;PIN31 			;;
	BCF TP1_O                       ;;
	BCF TP1_IO                       ;;
	;;PIN32 			;;
	BCF TP2_O                       ;;
	BCF TP2_IO                       ;;
	;;PIN33 			;;
	BCF TP3_O                       ;;
	BCF TP3_IO                       ;;
	;;PIN34 			;;
	BCF TP4_O                       ;;
	BCF TP4_IO                       ;;
	;;PIN35 			;;
	BCF DB3_O			;;
	BCF DB3_IO			;;
	;;PIN36 			;;
	BCF DB4_O			;;
	BCF DB4_IO			;;
	;;PIN37 			;;
	BCF DB5_O			;;
	BCF DB5_IO			;;
	;;PIN39 			;;
        BSF SLOTSW_S0_IO                ;;
	;;PIN40 			;;
        BSF SLOTSW_S1_IO                ;;
	;;PIN42 			;;
        BSF SLOTSW_S2_IO                ;;
	;;PIN43 			;;
        BSF SLOTSW_S3_IO                ;;
	;;PIN44 			;;
	BCF LDLO_TR_O			;;
	BCF LDLO_TR_IO			;;
	;;PIN45 			;;
	BCF LSEO_TR_O			;;
	BCF LSEO_TR_IO			;;
	;;PIN46 			;;
	BCF LDFO_TR_O			;;
	BCF LDFO_TR_IO			;;
	;;PIN47				;;
	BCF RS485EX_DE_O		;;
	BCF RS485EX_DE_IO		;;
	;;PIN48 			;;
	BSF RS485EX_RO_IO		;;
	;;PIN49 			;;
	BCF RS485EX_DI_O		;;
	BCF RS485EX_DI_IO		;;
	;;PIN50 			;;
	BCF DB6_O			;;
	BCF DB6_IO			;;
	;;PIN51 			;;
	BCF DB7_O			;;
	BCF DB7_IO			;;
	;;PIN52 			;;
	BSF LSEI_CS_O			;;
	BCF LSEI_CS_IO			;;
	;;PIN53 			;;
	BSF LDFI_CS_O			;;
	BCF LDFI_CS_IO			;;
	;;PIN54 			;;
	BSF SEO_EN_N_O			;;
	BCF SEO_EN_N_IO			;;
	;;PIN55 			;;
	BSF DFO_EN_N_O			;;
	BCF DFO_EN_N_IO			;;
	;;PIN58 			;;
	BCF DFO_EN_P_O			;;
	BCF DFO_EN_P_IO			;;
	;;PIN59 			;;
	BCF RS485_DE_O		        ;;
	BCF RS485_DE_IO		        ;;
	;;PIN60 			;;
	BSF RS485_RO_IO		        ;;
	;;PIN61 			;;
	BCF RS485_DI_O		        ;;
	BCF RS485_DI_IO		        ;;
	;;PIN62 			;;
	BSF LEDB_O                      ;;
	BCF LEDB_IO                     ;;
	;;PIN63 			;;
	BSF LEDG_O                      ;;
	BCF LEDG_IO                     ;;
	;;PIN64 			;;
	BSF LEDR_O                      ;;
	BCF LEDR_IO                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNPUA,#CNPUA7              ;;        
	BSET CNPUB,#CNPUB14             ;;        
	BSET CNPUB,#CNPUB15             ;;        
	BSET CNPUG,#CNPUG6              ;;        
	BSET CNPUG,#CNPUG7              ;;        
	BSET CNPUG,#CNPUG8              ;;        
	BSET CNPUG,#CNPUG9              ;;        
	BSET CNPUA,#CNPUA12             ;;
	BSET CNPUC,#CNPUC12             ;;        
	BSET CNPUC,#CNPUC15             ;;        
	BSET CNPUD,#CNPUD8              ;;        
	BSET CNPUB,#CNPUB5              ;;        

        
        CLR ANSELA                      ;;
        CLR ANSELB                      ;;
        CLR ANSELC                      ;;
        CLR ANSELE                      ;;
        MOVLF #3,MY_TYPE_ID             ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



LDLO_OUT:
        BCF SEO_EN_N_O
        XOR LATC,WREG
        AND #255,W0
        XOR LATC
        PUSH W0
        MOV #0xFF00,W0
        AND TRISC
        POP W0
        NOP
        BSF LDLO_TR_O
        NOP
        NOP
        NOP
        BCF LDLO_TR_O
        RETURN
        

LSEO_OUT:
        BCF SEO_EN_N_O
        XOR LATC,WREG
        AND #255,W0
        XOR LATC
        PUSH W0
        MOV #0xFF00,W0
        AND TRISC
        POP W0
        NOP
        BSF LSEO_TR_O
        NOP
        NOP
        NOP
        BCF LSEO_TR_O
        RETURN


LDFO_OUT:
        BCF SEO_EN_N_O
        BSF DFO_EN_P_O
        BCF DFO_EN_N_O
        XOR LATC,WREG
        AND #255,W0
        XOR LATC
        PUSH W0
        MOV #0xFF00,W0
        AND TRISC
        POP W0
        NOP
        BSF LDFO_TR_O
        NOP
        NOP
        NOP
        BCF LDFO_TR_O
        RETURN


LDFI_IN:
        MOV #0x00FF,W0
        IOR TRISC
        NOP
        NOP
        BCF LDFI_CS_O
        NOP
        NOP
        NOP
        NOP
        MOV PORTC,W0
        NOP
        BSF LDFI_CS_O
        RETURN
        

        
TEST_LDLO:
        MOV #0,W0
        CALL LDLO_OUT
        MOV #10,W0
        CALL DLYMX
        MOV #255,W0
        CALL LDLO_OUT
        MOV #10,W0
        CALL DLYMX
        BRA TEST_LDLO
        
        
TEST_LSEO:
        MOV #0,W0
        CALL LSEO_OUT
        MOV #10,W0
        CALL DLYMX
        MOV #255,W0
        CALL LSEO_OUT
        MOV #10,W0
        CALL DLYMX
        BRA TEST_LSEO

TEST_LDFO:
        MOV #0,W0
        CALL LDFO_OUT
        MOV #10,W0
        CALL DLYMX
        CALL LDFI_IN
        NOP
        NOP
        NOP
        MOV #255,W0
        CALL LDFO_OUT
        MOV #10,W0
        CALL DLYMX
        CALL LDFI_IN
        NOP
        NOP
        NOP

        BRA TEST_LDFO


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART2:				;;
	BSF RS485EX_DE_O                ;;
	MOV #0xAB,W0			;;
	MOV W0,U2TXREG			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART2 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART2_I:				;;
	MOV #0xAB00,W0			;;
	MOV W0,UTX_FLAG			;;
	MOV #0x0123,W0			;;
	MOV W0,UTX_CMD			;;
	MOV #0x4567,W0			;;
	MOV W0,UTX_PARA0		;;
	MOV #0x89AB,W0			;;
	MOV W0,UTX_PARA1		;;
	MOV #0xCDEF,W0			;;
	MOV W0,UTX_PARA2		;;
	MOV #0x2468,W0			;;
	MOV W0,UTX_PARA3		;;
	CALL UTX_STD_ALL		;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART2_I		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
        CALL INIT_SIO                   ;;
        CALL INIT_UART2_9600            ;;
	MOV #0x800A,W0			;;8BIT EVEN PARITY
	MOV W0,U2MODE			;;
	BSF U1RX_EN_F			;;
	BSF U2RX_EN_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
	CLRWDT				;;
	CALL TMR2PRG			;;	
	CALL MULTIME_PRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_U2TX_END		;;
	;CALL U2TXACT_PRG		;;
	CALL CHK_U1RX			;;
	CALL CHK_U2RX			;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.ENDIF



.IFDEF JS203_39A_K01_02


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2RXInterrupt:			;;
	PUSH SR				;;
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2RXIF		;;
	MOV U2RXREG,W1			;;
	AND #255,W1			;;
	;BTFSS U2RX_EN_F		;;
	;BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #250,W0                     ;;
        ADD TMR2,WREG                   ;;
        MOV W0,U2TX_REPEAT_TIM          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xEA,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PS			;;	
	MOV #0xEB,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PE			;;	
	MOV #0xEC,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PT			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;; 
	BTFSC U2RXT_F			;;
	XOR W0,W1,W1			;;
	BCF U2RXT_F			;;
	MOV #U2RX_BUFSIZE,W0		;;
	CP U2RX_BYTE_PTR		;;
	BRA GEU,U2RXI_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2RX_BUFA,W0		;;
	BTFSC U2RX_BUFAB_F		;;
	MOV #U2RX_BUFB,W0		;;
	ADD U2RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	BTSC U2RX_BYTE_PTR,#0		;;
	BRA U2RXI_1			;;
	MOV W1,[W0]			;;
	BRA U2RXI_2			;;
U2RXI_1:				;;
	SWAP W1				;;
	ADD W1,[W0],[W0]		;;
	SWAP W1				;;
U2RXI_2:				;;
	MOV U2RX_TMP0,W0		;;
	MOV W0,U2RX_TMP1		;;
	MOV W1,W0			;;
	MOV W0,U2RX_TMP0		;;
	MOV W1,W0			;;
	ADD U2RX_ADDSUM			;;	
	XOR U2RX_XORSUM			;;
	INC U2RX_BYTE_PTR		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PS:				;;
	BCF U2RXT_F			;;
	CLR U2RX_BYTE_PTR		;;
	CLR U2RX_ADDSUM			;;
	CLR U2RX_XORSUM			;;
	BSF MASTER_U2RX_F		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PE:				;;
	BCF U2RXT_F			;;
	MOV #0xAB,W0			;;
	XOR U2RX_XORSUM,WREG		;;	
	XOR U2RX_TMP0,WREG		;;
	BRA NZ,U2RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RX_TMP0,W0		;;
	ADD U2RX_TMP0,WREG		;;
	ADD U2RX_TMP1,WREG		;;
	XOR U2RX_ADDSUM,WREG		;;
	AND #255,W0			;;
	BRA NZ,U2RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RX_BYTE_PTR,W0		;;	
	BTFSS U2RX_BUFAB_F		;;	
	MOV W0,U2RXA_LEN		;;
	BTFSC U2RX_BUFAB_F		;;	
	MOV W0,U2RXB_LEN		;;
	BTFSS U2RX_BUFAB_F		;;	
	BSF U2RX_PACKA_F		;;
	BTFSC U2RX_BUFAB_F		;;	
	BSF U2RX_PACKB_F		;;
	TG U2RX_BUFAB_F			;;	
	MOV TMR2,W0			;;
	MOV W0,U2RX_PACK_TIME		;;	
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PT:				;;
	BSF U2RXT_F			;;
	BRA U2RXI_END			;;
U2RXI_END:				;;	
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
        BSF SWS0_IO                     ;;
	;;PIN2 				;;
        BSF SWS1_IO                     ;;
	;;PIN3 				;;
        BSF SWS2_IO                     ;;
	;;PIN4 				;;
        BSF SWS3_IO                     ;;
	;;PIN5 				;;
        BSF SWS4_IO                     ;;
	;;PIN6 				;;
        BSF SWS5_IO                     ;;
	;;PIN8 				;;
        BSF SWS6_IO                     ;;
	;;PIN11 			;;
        BSF SWS7_IO                     ;;
	;;PIN12 			;;
	BSF LDFI_A0_IO                  ;;
	;;PIN13 			;;
	;;PIN14 			;;
	BSF ADI_5V_IO			;;
	;;PIN15 			;;
	BSF ADS0_IO			;;
	;;PIN16 			;;
	BSF ADS1_IO			;;
	;;PIN21 			;;
	BCF DB0_O			;;
	BCF DB0_IO			;;
	;;PIN22 			;;
	BCF DB1_O			;;
	BCF DB1_IO			;;
	;;PIN23 			;;
	BCF DB2_O			;;
	BCF DB2_IO			;;
	;;PIN24 			;;
	BCF NC24_O			;;
	BCF NC24_IO			;;
	;;PIN27 			;;
	BSF ADS2_IO			;;
	;;PIN28 			;;
	BSF ADS3_IO			;;
	;;PIN29 			;;
	BSF LDFI_A1_IO			;;
	;;PIN30 			;;
	BSF LDFI_A2_IO			;;
	;;PIN31 			;;
	BCF TP1_O                       ;;
	BCF TP1_IO                       ;;
	;;PIN32 			;;
	BCF TP2_O                       ;;
	BCF TP2_IO                       ;;
	;;PIN33 			;;
	BCF TP3_O                       ;;
	BCF TP3_IO                       ;;
	;;PIN34 			;;
	BCF TP4_O                       ;;
	BCF TP4_IO                       ;;
	;;PIN35 			;;
	BCF DB3_O			;;
	BCF DB3_IO			;;
	;;PIN36 			;;
	BCF DB4_O			;;
	BCF DB4_IO			;;
	;;PIN37 			;;
	BCF DB5_O			;;
	BCF DB5_IO			;;
	;;PIN39 			;;
        BSF SLOTSW_S0_IO                ;;
	;;PIN40 			;;
        BSF SLOTSW_S1_IO                ;;
	;;PIN42 			;;
        BSF SLOTSW_S2_IO                ;;
	;;PIN43 			;;
        BSF SLOTSW_S3_IO                ;;
	;;PIN44 			;;
	BCF LDFO_A0_O			;;
	BCF LDFO_A0_IO			;;
	;;PIN45 			;;
	BSF LDFI_A3_IO			;;
	;;PIN46 			;;
	BCF LDFO_A1_O			;;
	BCF LDFO_A1_IO			;;
	;;PIN47				;;
	BCF RS485EX_DE_O		;;
	BCF RS485EX_DE_IO		;;
	;;PIN48 			;;
	BSF RS485EX_RO_IO		;;
	;;PIN49 			;;
	BCF RS485EX_DI_O		;;
	BCF RS485EX_DI_IO		;;
	;;PIN50 			;;
	BCF DB6_O			;;
	BCF DB6_IO			;;
	;;PIN51 			;;
	BCF DB7_O			;;
	BCF DB7_IO			;;
	;;PIN52 			;;
	BCF LDFO_A2_O			;;
	BCF LDFO_A2_IO			;;
	;;PIN53 			;;
	BCF DFO_EN_N_O			;;
	BCF DFO_EN_N_IO			;;
	;;PIN54 			;;
	;;PIN55 			;;
	BCF LDFO_A3_O			;;
	BCF LDFO_A3_IO			;;
	;;PIN58 			;;
	BSF DFO_EN_P_O			;;
	BCF DFO_EN_P_IO			;;
	;;PIN59 			;;
	BCF RS485_DE_O		        ;;
	BCF RS485_DE_IO		        ;;
	;;PIN60 			;;
	BSF RS485_RO_IO		        ;;
	;;PIN61 			;;
	BCF RS485_DI_O		        ;;
	BCF RS485_DI_IO		        ;;
	;;PIN62 			;;
	BSF LEDB_O                      ;;
	BCF LEDB_IO                     ;;
	;;PIN63 			;;
	BSF LEDG_O                      ;;
	BCF LEDG_IO                     ;;
	;;PIN64 			;;
	BSF LEDR_O                      ;;
	BCF LEDR_IO                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNPUA,#CNPUA7              ;;        
	BSET CNPUB,#CNPUB14             ;;        
	BSET CNPUB,#CNPUB15             ;;        
	BSET CNPUG,#CNPUG6              ;;        
	BSET CNPUG,#CNPUG7              ;;        
	BSET CNPUG,#CNPUG8              ;;        
	BSET CNPUG,#CNPUG9              ;;        
	BSET CNPUA,#CNPUA12             ;;      

	BSET CNPUC,#CNPUC12             ;;        
	BSET CNPUC,#CNPUC15             ;;        
	BSET CNPUD,#CNPUD8              ;;        
	BSET CNPUB,#CNPUB5              ;;        
  
        CLR ANSELA                      ;;
        CLR ANSELB                      ;;
        CLR ANSELC                      ;;
        CLR ANSELE                      ;;
        MOVLF #3,MY_TYPE_ID             ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INIT_RAM:
        RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART2:				;;
	BSF RS485EX_DE_O                ;;
	MOV #0xAB,W0			;;
	MOV W0,U2TXREG			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART2 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	CLR ANSELC			;;
	CLR ANSELE			;;
	BSET ANSELA,#1			;;
	BSET ANSELB,#0			;;
	BSET ANSELB,#1			;;
	BSET ANSELE,#12			;;
	BSET ANSELE,#13			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0004,W0			;;AUTO SAMPLE	
	;MOV #0x000C,W0			;;Enable simultaneous sampling and auto-sample
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON1			;;
	;MOV #0x0300,W0			;;4 CHANNEL	
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON2			;;
	MOV #0x800F,W0			;;	
	MOV W0,AD1CON3			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON4			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CSSH
	MOV #0x0000,W0			;;	
	MOV W0,AD1CSSL
	BSET AD1CON1,#ADON		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART2_I:				;;
	MOV #0xAB00,W0			;;
	MOV W0,UTX_FLAG			;;
	MOV #0x0123,W0			;;
	MOV W0,UTX_CMD			;;
	MOV #0x4567,W0			;;
	MOV W0,UTX_PARA0		;;
	MOV #0x89AB,W0			;;
	MOV W0,UTX_PARA1		;;
	MOV #0xCDEF,W0			;;
	MOV W0,UTX_PARA2		;;
	MOV #0x2468,W0			;;
	MOV W0,UTX_PARA3		;;
	;CALL UTX_STD_ALL		;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART2_I		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
        CALL INIT_SIO_IO                ;;
        CALL INIT_AD                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #1704,W0	;9600		;;66MHZ
	MOV W0,U2BRG			;;
	MOV #0x800A,W0			;;8BIT EVEN
	MOV W0,U2MODE			;;
	MOV #0x0400,W0			;;
	MOV W0,U2STA 			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF U1RX_EN_F			;;
        MOVLF #2,SLOT_STATUS            ;;
        CLR SLOT_TEST_STATUS            ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
        CLRWDT                          ;;
	BTFSC T128M_F			;;
	TG TP1_O			;;
	CLRWDT				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL CHK_U1RX			;;
        CALL CHK_U1TX_END               ;;
        CALL CONVERT_AD                 ;;
        CALL CHK_LDFIO                   ;;
        ;=================================
        CALL EMU_U2TX_PRG               ;;
        CALL IOOUT_PRG                  ;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_LDFIO:                               ;;
        CLR LDFIOBUF                    ;;
        BTFSC LDFI_A0_I                 ;;
        BSET LDFIOBUF,#0                ;;
        BTFSC LDFI_A1_I                 ;;
        BSET LDFIOBUF,#1                ;;
        BTFSC LDFI_A2_I                 ;;
        BSET LDFIOBUF,#2                ;;
        BTFSC LDFI_A3_I                 ;;
        BSET LDFIOBUF,#3                ;;
        BTFSC LDFO_A0_O                 ;;
        BSET LDFIOBUF,#4                ;;
        BTFSC LDFO_A1_O                 ;;
        BSET LDFIOBUF,#5                ;;
        BTFSC LDFO_A2_O                 ;;
        BSET LDFIOBUF,#6                ;;
        BTFSC LDFO_A3_O                 ;;
        BSET LDFIOBUF,#7                ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTFSC DB0_O                     ;;
        BSET LDFIOBUF,#8                ;;
        BTFSC DB1_O                     ;;
        BSET LDFIOBUF,#9                ;;
        BTFSC DB2_O                     ;;
        BSET LDFIOBUF,#10               ;;
        BTFSC DB3_O                     ;;
        BSET LDFIOBUF,#11               ;;
        BTFSC DB4_O                     ;;
        BSET LDFIOBUF,#12               ;;
        BTFSC DB5_O                     ;;
        BSET LDFIOBUF,#13               ;;
        BTFSC DB6_O                     ;;
        BSET LDFIOBUF,#14               ;;
        BTFSC DB7_O                     ;;
        BSET LDFIOBUF,#15               ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IOOUT_PRG:                              ;;
        MOV IOOUT_FLAG,W0               ;;
        XOR LATC,WREG                   ;;
        AND #255,W0                     ;;
        XOR LATC                        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSS IOOUT_FLAG,#8              ;;
        BCF LDFO_A0_O                   ;;
        BTSC IOOUT_FLAG,#8              ;;
        BSF LDFO_A0_O                   ;;
        BTSS IOOUT_FLAG,#9              ;;
        BCF LDFO_A1_O                   ;;
        BTSC IOOUT_FLAG,#9              ;;
        BSF LDFO_A1_O                   ;;
        BTSS IOOUT_FLAG,#10             ;;
        BCF LDFO_A2_O                   ;;
        BTSC IOOUT_FLAG,#10             ;;
        BSF LDFO_A2_O                   ;;
        BTSS IOOUT_FLAG,#11             ;;
        BCF LDFO_A3_O                   ;;
        BTSC IOOUT_FLAG,#11             ;;
        BSF LDFO_A3_O                   ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



EMU1_DATA_TBL:
        BRA W0
        RETLW #0XAA,W0        
        RETLW #0X55,W0        
        RETLW #0X01,W0        
        RETLW #0X01,W0        
        RETLW #0X23,W0        
        RETLW #0X02,W0        
        RETLW #0X25,W0        
        RETLW #0X03,W0        
        RETLW #0X0A,W0        
        RETLW #0X55,W0        
        RETLW #0XAA,W0        


EMU2_DATA_TBL:
        BRA W0
        RETLW #0XAA,W0        
        RETLW #0X55,W0        
        RETLW #0X01,W0        
        RETLW #0X02,W0        
        RETLW #0X34,W0        
        RETLW #0X02,W0        
        RETLW #0X32,W0        
        RETLW #0X03,W0        
        RETLW #0X05,W0        
        RETLW #0X55,W0        
        RETLW #0XAA,W0        


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EMU_U2TX_PRG:                           ;;
	BSF RS485EX_DE_O                ;;
        BTFSC EMU_U2TX_F                ;;
        BRA EMU_U2TX_1                  ;;
        BTFSS T1M_F                     ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC EMU_U2TX_TIM                ;;
        MOV #50,W0                      ;;
        CP EMU_U2TX_TIM                 ;;
        BRA GEU,$+4                     ;;
        RETURN                          ;;
        CLR EMU_U2TX_TIM                ;;        
        BSF EMU_U2TX_F                  ;;
        CLR EMU_U2TX_BYTE               ;;             
        INC EMU_U2TX_CNT                ;;         
        MOV #30,W0                      ;;
        CP EMU_U2TX_CNT                 ;;
        BRA GEU,$+4                     ;;
        RETURN                          ;;
        TG EMU_DATA_F                   ;;
        CLR EMU_U2TX_CNT                ;;        
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EMU_U2TX_1:                             ;;
	BTSS U2STA,#8                   ;;
	RETURN                          ;;
        MOV EMU_U2TX_BYTE,W0            ;;        
        BTFSS EMU_DATA_F                ;;        
        CALL EMU1_DATA_TBL              ;;        
        BTFSC EMU_DATA_F                ;;
        CALL EMU2_DATA_TBL              ;;
	MOV W0,U2TXREG			;;
        INC EMU_U2TX_BYTE               ;;
        MOV #11,W0                      ;;
        CP EMU_U2TX_BYTE                ;;
        BRA GEU,$+4                     ;;
        RETURN                          ;;
        BCF EMU_U2TX_F                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        

CONVAD_TBL:
        AND #7,W0
        BRA W0
        RETLW #1,W0
        RETLW #2,W0
        RETLW #3,W0
        RETLW #12,W0
        RETLW #13,W0
        RETLW #1,W0
        RETLW #1,W0
        RETLW #1,W0

DLYUXI:
        NOP
	DEC W0,W0
	BRA NZ,DLYUXI
	RETURN 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AD_STARTX:                              ;;
        BCF YES_F                       ;;
	MOV W0,AD1CHS0			;;TAD IN RC MODE IS 250 NS
	BSET AD1CON1,#SAMP		;;MUST OVER 3 TIMES TAD
        MOV #20,W0                       ;;
        CALL DLYUXI                     ;;                        
        BCLR AD1CON1,#SAMP              ;;    
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
        CLR ADWAIT_TIM                  ;;                     
AD_STARTX_1:                            ;;
        INC ADWAIT_TIM                  ;;
        BTSC ADWAIT_TIM,#8              ;;              
        RETURN                          ;;
 	BTSS AD1CON1,#DONE		;;      
 	BRA AD_STARTX_1                 ;;
        BSF YES_F                       ;;
        RETURN                          ;;              
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONVERT_AD:				;;
	MOV CONVAD_CNT,W0 		;;
        LSR W0,#2,W0                    ;;
        CALL CONVAD_TBL                 ;;
        CALL AD_STARTX                  ;;
        MOV #ADXBUF00,W1                ;;
	MOV CONVAD_CNT,W0 		;;
        AND #3,W0                       ;;        
        ADD W0,W1,W1                    ;;
        ADD W0,W1,W1                    ;;
	MOV ADC1BUF0,W0			;;
        MOV W0,[W1]                     ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV CONVAD_CNT,W0               ;;
        AND #3,W0                       ;;
        CP W0,#3                        ;;
        BRA NZ,CONVERT_AD_1             ;;
        MOV CONVAD_CNT,W0               ;;
        LSR W0,#2,W0                    ;;
        MOV #ADI0BUF,W1                 ;;
        ADD W0,W1,W1                    ;;        
        ADD W0,W1,W1                    ;;        
	MOVFF ADXBUF00,R0		;;
	MOVFF ADXBUF01,R1		;;
	MOVFF ADXBUF02,R2		;;	
	MOVFF ADXBUF03,R3		;;
	CALL FILTER			;;
        MOV W0,[W1]                     ;;        
CONVERT_AD_1:                           ;;
        INC CONVAD_CNT                  ;;
        MOV #20,W0                      ;;
        CP CONVAD_CNT                   ;;
        BRA LTU,$+4                     ;;
        CLR CONVAD_CNT                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





FILTER:
	MOV R0,W0
	CP R1
	BRA LEU,FILTER_1
	MOV R0,W0
	XOR R1,WREG
	XOR R0
	XOR R1
FILTER_1:
	MOV R1,W0
	CP R2
	BRA LEU,FILTER_2
	MOV R1,W0
	XOR R2,WREG
	XOR R1
	XOR R2
FILTER_2:
	MOV R2,W0
	CP R3
	BRA LEU,FILTER_3
	MOV R2,W0
	XOR R3,WREG
	XOR R2
	XOR R3
FILTER_3:
	MOV R1,W0
	CP R2
	BRA LEU,FILTER_4
	MOV R1,W0
	XOR R2,WREG
	XOR R1
	XOR R2
FILTER_4:
	MOV R0,W0
	CP R1
	BRA LEU,FILTER_5
	MOV R0,W0
	XOR R1,WREG
	XOR R0
	XOR R1
FILTER_5:
	MOV R2,W0
	ADD R1,WREG
	LSR W0,#1,W0
	RETURN





.ENDIF


.IFDEF JS203_39A_C01_04
NOP1PRG:
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        RETURN
TEST_FIB_TX:
        CALL NOP1PRG
        BCF FIB_TX0_CHK_O
        BCF FIB_TX1_CHK_O
        NOP
        CLRWDT
        CALL NOP1PRG
        BSF FIB_TX0_CHK_O
        BSF FIB_TX1_CHK_O
        BRA TEST_FIB_TX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
        
	;;PIN1 				;;
        BSF SWS0_IO                     ;;
	;;PIN2 				;;
        BSF SWS1_IO                     ;;
	;;PIN3 				;;
        BSF SWS2_IO                     ;;
	;;PIN4 				;;
        BSF SWS3_IO                     ;;
	;;PIN5 				;;
        BSF SWS4_IO                     ;;
	;;PIN6 				;;
        BSF SWS5_IO                     ;;
	;;PIN8 				;;
        BSF SWS6_IO                     ;;
	;;PIN11 			;;
        BSF SWS7_IO                     ;;
	;;PIN12 			;;
	BCF NC12_O                      ;;
	BCF NC12_IO                     ;;
	;;PIN13 			;;
	BSF ADI_12V_IO			;;
	;;PIN14 			;;
	BSF ADI_5V_IO			;;
	;;PIN15 			;;
	;BSF ADS0_IO			;;
	;;PIN16 			;;
	;BSF ADS1_IO			;;
	;;PIN21 			;;
	BCF DB0_O			;;
	BCF DB0_IO			;;
	;;PIN22 			;;
	BCF DB1_O			;;
	BCF DB1_IO			;;
	;;PIN23 			;;
	BCF DB2_O			;;
	BCF DB2_IO			;;
	;;PIN24 			;;
	BCF NC24_O			;;
	BCF NC24_IO			;;
	;;PIN27 			;;
	;BSF ADS2_IO			;;
	;;PIN28 			;;
	;BSF ADS3_IO			;;
	;;PIN29 			;;
	BSF FIB_RX0_CHK_IO		;;
	;;PIN30 			;;
	BSF FIB_RX1_CHK_IO		;;
	;;PIN31 			;;
	BCF TP1_O                       ;;
	BCF TP1_IO                       ;;
	;;PIN32 			;;
	BCF TP2_O                       ;;
	BCF TP2_IO                       ;;
	;;PIN33 			;;
	BCF TP3_O                       ;;
	BCF TP3_IO                       ;;
	;;PIN34 			;;
	BCF TP4_O                       ;;
	BCF TP4_IO                       ;;
	;;PIN35 			;;
	BCF DB3_O			;;
	BCF DB3_IO			;;
	;;PIN36 			;;
	BCF DB4_O			;;
	BCF DB4_IO			;;
	;;PIN37 			;;
	BCF DB5_O			;;
	BCF DB5_IO			;;
	;;PIN39 			;;
        BSF SLOTSW_S0_IO                ;;
	;;PIN40 			;;
        BSF SLOTSW_S1_IO                ;;
	;;PIN42 			;;
        BSF SLOTSW_S2_IO                ;;
	;;PIN43 			;;
        BSF SLOTSW_S3_IO                ;;
	;;PIN44 			;;
	;BCF LDLO_TR_O			;;
	;BCF LDLO_TR_IO			;;
	;;PIN45 			;;
	;BCF LSEO_TR_O			;;
	;BCF LSEO_TR_IO			;;
	;;PIN46 			;;
	;BCF LDFO_TR_O			;;
	;BCF LDFO_TR_IO			;;
	;;PIN47				;;
	BCF RS485EX_DE_O		;;
	BCF RS485EX_DE_IO		;;
	;;PIN48 			;;
	;BSF RS485EX_RO_IO		;;
	;;PIN49 			;;
	;BCF RS485EX_DI_O		;;
	;BCF RS485EX_DI_IO		;;
	;;PIN50 			;;
	BCF FIB_TX0_CHK_O		;;
	BSF FIB_TX0_CHK_IO		;;
	;;PIN51 			;;
	BCF FIB_TX1_CHK_O		;;
	BSF FIB_TX1_CHK_IO		;;
	;;PIN52 			;;
	;BSF LSEI_CS_O			;;
	;BCF LSEI_CS_IO			;;
	;;PIN53 			;;
	;BSF LDFI_CS_O			;;
	;BCF LDFI_CS_IO			;;
	;;PIN54 			;;
	;BSF SEO_EN_N_O			;;
	;BCF SEO_EN_N_IO		;;
	;;PIN55 			;;
	;BSF DFO_EN_N_O			;;
	;BCF DFO_EN_N_IO		;;
	;;PIN58 			;;
	;BCF DFO_EN_P_O			;;
	;BCF DFO_EN_P_IO		;;
	;;PIN59 			;;
	BCF RS485_DE_O		        ;;
	BCF RS485_DE_IO		        ;;
	;;PIN60 			;;
	BSF RS485_RO_IO		        ;;
	;;PIN61 			;;
	BCF RS485_DI_O		        ;;
	BCF RS485_DI_IO		        ;;
        
	;;PIN62 			;;
	BSF LEDB_O                      ;;
	BCF LEDB_IO                     ;;
	;;PIN63 			;;
	BSF LEDG_O                      ;;
	BCF LEDG_IO                     ;;
	;;PIN64 			;;
	BSF LEDR_O                      ;;
	BCF LEDR_IO                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNPUA,#CNPUA7              ;;        
	BSET CNPUB,#CNPUB14             ;;        
	BSET CNPUB,#CNPUB15             ;;        
	BSET CNPUG,#CNPUG6              ;;        
	BSET CNPUG,#CNPUG7              ;;        
	BSET CNPUG,#CNPUG8              ;;        
	BSET CNPUG,#CNPUG9              ;;        
	BSET CNPUA,#CNPUA12             ;;      

	BSET CNPUC,#CNPUC12             ;;        
	BSET CNPUC,#CNPUC15             ;;        
	BSET CNPUD,#CNPUD8              ;;        
	BSET CNPUB,#CNPUB5              ;;        
  
        CLR ANSELA                      ;;
        CLR ANSELB                      ;;
        CLR ANSELC                      ;;
        CLR ANSELE                      ;;
        MOVLF #5,MY_TYPE_ID             ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:
        RETURN




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:	                                ;;
        CALL INIT_RAM   		;;
        CALL INIT_SIO                   ;;
	BSF U1RX_EN_F			;;
        MOVLF #2,SLOT_STATUS            ;;
        CLR SLOT_TEST_STATUS            ;;
        ;CALL TEST_FIB_TX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
        CLRWDT                          ;;
	BTFSC T128M_F			;;
	TG TP1_O			;;
	CLRWDT				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL CHK_U1RX			;;
	;CALL DELAY_ACT_PRG              ;;
        CALL CHK_U1TX_END               ;;
        ;=================================
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.ENDIF






;LA
.IFDEF JS203_39A_L01_02


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
        
	;;PIN1 				;;
	;;PIN2 				;;
	;;PIN3 				;;
	;;PIN4 				;;
	;;PIN5 				;;
        BSF SWS4_IO                     ;;
	;;PIN6 				;;
        BSF SWS5_IO                     ;;
	;;PIN8 				;;
        BSF SWS6_IO                     ;;
	;;PIN11 			;;
        BSF SWS7_IO                     ;;
	;;PIN12 			;;
	;;PIN13 			;;
	;;PIN14 			;;
	BSF ADI_5V_IO			;;
	;;PIN15 			;;
	;BSF ADS0_IO			;;
	;;PIN16 			;;
	;BSF ADS1_IO			;;
	;;PIN21 			;;
	BSF TEST_LACH_0_IO		;;
	;;PIN22 			;;
	BSF TEST_LACH_1_IO		;;
	;;PIN23 			;;
	BSF TEST_LACH_2_IO		;;
	;;PIN24 			;;
	;;PIN27 			;;
	;BSF ADS2_IO			;;
	;;PIN28 			;;
	;BSF ADS3_IO			;;
	;;PIN29 			;;
	;;PIN30 			;;
	;;PIN31 			;;
	BCF TP1_O                       ;;
	BCF TP1_IO                      ;;
	;;PIN32 			;;
	BCF TP2_O                       ;;
	BCF TP2_IO                      ;;
	;;PIN33 			;;
	BCF TP3_O                       ;;
	BCF TP3_IO                      ;;
	;;PIN34 			;;
	BCF TP4_O                       ;;
	BCF TP4_IO                      ;;
	;;PIN35 			;;
	BSF TEST_LACH_3_IO		;;
	;;PIN36 			;;
	BSF TEST_LACH_4_IO		;;
	;;PIN37 			;;
	BSF TEST_LACH_5_IO		;;
	;;PIN39 			;;
        BSF SLOTSW_S0_IO                ;;
	;;PIN40 			;;
        BSF SLOTSW_S1_IO                ;;
	;;PIN42 			;;
        BSF SLOTSW_S2_IO                ;;
	;;PIN43 			;;
        BSF SLOTSW_S3_IO                ;;
	;;PIN44 			;;
	;BCF LDLO_TR_O			;;
	;BCF LDLO_TR_IO			;;
	;;PIN45 			;;
	;BCF LSEO_TR_O			;;
	;BCF LSEO_TR_IO			;;
	;;PIN46 			;;
	;BCF LDFO_TR_O			;;
	;BCF LDFO_TR_IO			;;
	;;PIN47				;;
	;BCF RS485EX_DE_O		;;
	;BCF RS485EX_DE_IO		;;
	;;PIN48 			;;
	;BSF RS485EX_RO_IO		;;
	;;PIN49 			;;
	;BCF RS485EX_DI_O		;;
	;BCF RS485EX_DI_IO		;;
	;;PIN50 			;;
	BSF TEST_LACH_6_IO		;;
	;;PIN51 			;;
	BSF TEST_LACH_7_IO		;;
	;;PIN52 			;;
	;BSF LSEI_CS_O			;;
	;BCF LSEI_CS_IO			;;
	;;PIN53 			;;
	;BSF LDFI_CS_O			;;
	;BCF LDFI_CS_IO			;;
	;;PIN54 			;;
	;BSF SEO_EN_N_O			;;
	;BCF SEO_EN_N_IO		;;
	;;PIN55 			;;
	;BSF DFO_EN_N_O			;;
	;BCF DFO_EN_N_IO		;;
	;;PIN58 			;;
	;BCF DFO_EN_P_O			;;
	;BCF DFO_EN_P_IO		;;
	;;PIN59 			;;
	BCF RS485_DE_O		        ;;
	BCF RS485_DE_IO		        ;;
	;;PIN60 			;;
	BSF RS485_RO_IO		        ;;
	;;PIN61 			;;
	BCF RS485_DI_O		        ;;
	BCF RS485_DI_IO		        ;;
        
	;;PIN62 			;;
	BSF LEDB_O                      ;;
	BCF LEDB_IO                     ;;
	;;PIN63 			;;
	BSF LEDG_O                      ;;
	BCF LEDG_IO                     ;;
	;;PIN64 			;;
	BSF LEDR_O                      ;;
	BCF LEDR_IO                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNPUA,#CNPUA7              ;;        
	BSET CNPUB,#CNPUB14             ;;        
	BSET CNPUB,#CNPUB15             ;;        
	BSET CNPUG,#CNPUG6              ;;        
	BSET CNPUG,#CNPUG7              ;;        
	BSET CNPUG,#CNPUG8              ;;        
	BSET CNPUG,#CNPUG9              ;;        
	BSET CNPUA,#CNPUA12             ;;  

	BSET CNPUC,#CNPUC12             ;;        
	BSET CNPUC,#CNPUC15             ;;        
	BSET CNPUD,#CNPUD8              ;;        
	BSET CNPUB,#CNPUB5              ;;        

      
        CLR ANSELA                      ;;
        CLR ANSELB                      ;;
        CLR ANSELC                      ;;
        CLR ANSELE                      ;;
        MOVLF #4,MY_TYPE_ID             ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:
        RETURN



;$2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:	                                ;;
        CALL INIT_RAM   		;;
        CALL INIT_SIO                   ;;
	BSF U1RX_EN_F			;;
        MOVLF #2,SLOT_STATUS            ;;
        CLR SLOT_TEST_STATUS            ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
        CLRWDT                          ;;
	BTFSC T128M_F			;;
	TG TP1_O			;;
	CLRWDT				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL CHK_U1RX			;;
	;CALL DELAY_ACT_PRG             ;;
        CALL CHK_U1TX_END               ;;
        ;=================================
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.ENDIF




;@IPC
.IFDEF JS203_39A_A01_03


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
        
	;;PIN1 				;;
	;;PIN2 				;;
	;;PIN3 				;;
	;;PIN4 				;;
	;;PIN5 				;;
        BSF SWS4_IO                     ;;
	;;PIN6 				;;
        BSF SWS5_IO                     ;;
	;;PIN8 				;;
        BSF SWS6_IO                     ;;
	;;PIN11 			;;
        BSF SWS7_IO                     ;;
	;;PIN12 			;;
	;;PIN13 			;;
	BSF ADI_12V_IO			;;
	;;PIN14 			;;
	BSF ADI_5V_IO			;;
	;;PIN15 			;;
	;BSF ADS0_IO			;;
	;;PIN16 			;;
	;BSF ADS1_IO			;;
	;;PIN21 			;;
	;BSF TEST_LACH_0_IO		;;
	;;PIN22 			;;
	;BSF TEST_LACH_1_IO		;;
	;;PIN23 			;;
	;BSF TEST_LACH_2_IO		;;
	;;PIN24 			;;
	BCF IPC_SYS_RST_O               ;;
	BCF IPC_SYS_RST_IO              ;;
	;;PIN27 			;;
	;BSF ADS2_IO			;;
	;;PIN28 			;;
	;BSF ADS3_IO			;;
	;;PIN29 			;;
	;;PIN30 			;;
	;;PIN31 			;;
	BCF TP1_O                       ;;
	BCF TP1_IO                      ;;
	;;PIN32 			;;
	BCF TP2_O                       ;;
	BCF TP2_IO                      ;;
	;;PIN33 			;;
	BCF TP3_O                       ;;
	BCF TP3_IO                      ;;
	;;PIN34 			;;
	BCF TP4_O                       ;;
	BCF TP4_IO                      ;;
	;;PIN35 			;;
	;BSF TEST_LACH_3_IO		;;
	;;PIN36 			;;
	;BSF TEST_LACH_4_IO		;;
	;;PIN37 			;;
	;BSF TEST_LACH_5_IO		;;
	;;PIN39 			;;
        BSF SLOTSW_S0_IO                ;;
	;;PIN40 			;;
        BSF SLOTSW_S1_IO                ;;
	;;PIN42 			;;
        BSF SLOTSW_S2_IO                ;;
	;;PIN43 			;;
        BSF SLOTSW_S3_IO                ;;
	;;PIN44 			;;
	;BCF LDLO_TR_O			;;
	;BCF LDLO_TR_IO			;;
	;;PIN45 			;;
	;BCF LSEO_TR_O			;;
	;BCF LSEO_TR_IO			;;
	;;PIN46 			;;
	;BCF LDFO_TR_O			;;
	;BCF LDFO_TR_IO			;;
	;;PIN47				;;
	;BCF RS485EX_DE_O		;;
	;BCF RS485EX_DE_IO		;;
	;;PIN48 			;;
	;BSF RS485EX_RO_IO		;;
	;;PIN49 			;;
	;BCF RS485EX_DI_O		;;
	;BCF RS485EX_DI_IO		;;
	;;PIN50 			;;
	;BSF TEST_LACH_6_IO		;;
	;;PIN51 			;;
	;BSF TEST_LACH_7_IO		;;
	;;PIN52 			;;
	;BSF LSEI_CS_O			;;
	;BCF LSEI_CS_IO			;;
	;;PIN53 			;;
	;BSF LDFI_CS_O			;;
	;BCF LDFI_CS_IO			;;
	;;PIN54 			;;
	;BSF SEO_EN_N_O			;;
	;BCF SEO_EN_N_IO		;;
	;;PIN55 			;;
	;BSF DFO_EN_N_O			;;
	;BCF DFO_EN_N_IO		;;
	;;PIN58 			;;
	;BCF DFO_EN_P_O			;;
	;BCF DFO_EN_P_IO		;;
	;;PIN59 			;;
	BCF RS485_DE_O		        ;;
	BCF RS485_DE_IO		        ;;
	;;PIN60 			;;
	BSF RS485_RO_IO		        ;;
	;;PIN61 			;;
	BCF RS485_DI_O		        ;;
	BCF RS485_DI_IO		        ;;
        
	;;PIN62 			;;
	BSF LEDB_O                      ;;
	BCF LEDB_IO                     ;;
	;;PIN63 			;;
	BSF LEDG_O                      ;;
	BCF LEDG_IO                     ;;
	;;PIN64 			;;
	BSF LEDR_O                      ;;
	BCF LEDR_IO                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNPUA,#CNPUA7              ;;        
	BSET CNPUB,#CNPUB14             ;;        
	BSET CNPUB,#CNPUB15             ;;        
	BSET CNPUG,#CNPUG6              ;;        
	BSET CNPUG,#CNPUG7              ;;        
	BSET CNPUG,#CNPUG8              ;;        
	BSET CNPUG,#CNPUG9              ;;        
	BSET CNPUA,#CNPUA12             ;;  
	BSET CNPUC,#CNPUC12             ;;        
	BSET CNPUC,#CNPUC15             ;;        
	BSET CNPUD,#CNPUD8              ;;        
	BSET CNPUB,#CNPUB5              ;;        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR ANSELA                      ;;
        CLR ANSELB                      ;;
        CLR ANSELC                      ;;
        CLR ANSELE                      ;;
        MOVLF #1,MY_TYPE_ID             ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:
        RETURN



;$2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:	                                ;;
        CALL INIT_RAM   		;;
        CALL INIT_SIO                   ;;
	BSF U1RX_EN_F			;;
        MOVLF #2,SLOT_STATUS            ;;
        CLR SLOT_TEST_STATUS            ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
        CLRWDT                          ;;
	BTFSC T128M_F			;;
	TG TP1_O			;;
	CLRWDT				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL CHK_U1RX			;;
	;CALL DELAY_ACT_PRG             ;;
        CALL CHK_U1TX_END               ;;
        ;=================================
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.ENDIF




.IFDEF JS203_39A_M01_01

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART2:				;;
	BCLR IEC1,#U2TXIE		;;UTXINT
	MOV #0xAB,W0			;;
	MOV W0,U2TXREG			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART2 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2RXInterrupt:			;;
	PUSH SR				;;
	PUSH W0				;;
	PUSH W1				;;
	PUSH W2				;;
	BCLR IFS1,#U2RXIF		;;
	MOV U2RXREG,W2			;;
	AND #255,W2			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC U2RX_BYTE_PTR		;;      
	MOV #512,W0		        ;;
	CP U2RX_BYTE_PTR		;;
        BRA LTU,$+4                     ;;
        CLR U2RX_BYTE_PTR               ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #'$',W0                     ;;
        CP W0,W2                        ;;
        BRA Z,U2RXI_00                  ;;
        MOV #0x0D,W0                    ;;
        CP W0,W2                        ;;
        BRA Z,U2RXI_01                  ;;
        BRA U2RXI_02
U2RXI_00:                               ;;
        MOV U2RX_BYTE_PTR,W0            ;;        
        MOV W0,U2RX_BYTE_PTR0           ;;
        BRA U2RXI_02                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_01:                               ;;
	MOV #U2RX_PACK_BUF,W1		;;
        MOV U2RX_PACK_PTR0,W0           ;;
        SL W0,#2,W0                     ;;
        ADD W0,W1,W1                    ;;
        INC U2RX_PACK_PTR0              ;;
        MOV #16,W0                      ;;
        CP U2RX_PACK_PTR0               ;;
        BRA LTU,$+4                     ;;
        CLR U2RX_PACK_PTR0              ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV U2RX_BYTE_PTR0,W0           ;;
        MOV W0,[W1++]                   ;;
        MOV U2RX_BYTE_PTR,W0            ;;
        MOV W0,[W1++]                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_02:                               ;;
	MOV #U2RX_BUFA,W0		;;
	ADD U2RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	BTSC U2RX_BYTE_PTR,#0		;;
	BRA U2RXI_1			;;
	MOV W2,[W0]			;;
	BRA U2RXI_END			;;
U2RXI_1:				;;
	SWAP W2				;;
	ADD W2,[W0],[W0]		;;
	SWAP W2				;;
U2RXI_END:				;;	
	POP W2				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
	;;PIN2 				;;
        BSF RFMA_CKO_IO                 ;;
	;;PIN3 				;;
        BSF RFMA_DIO1_IO                ;;
	;;PIN4 				;;
        BCF RFMA_DIO2_O                 ;;
        BCF RFMA_DIO2_IO                ;;
	;;PIN5 				;;
        BSF SWS4_IO                     ;;
	;;PIN6 				;;
        BSF SWS5_IO                     ;;
	;;PIN8 				;;
        BSF SWS6_IO                     ;;
	;;PIN11 			;;
        BSF SWS7_IO                     ;;
	;;PIN12 			;;
	BCF RFMA_D0_O                   ;;
	BCF RFMA_D0_IO                  ;;
	;;PIN13 			;;
	BSF ADI_24V_IO			;;
	;;PIN14 			;;
	;;PIN15 			;;
	;BSF ADS0_IO			;;
	;;PIN16 			;;
	;BSF ADS1_IO			;;
	;;PIN21 			;;
	BSF RFMA_CS_O			;;
	BCF RFMA_CS_IO			;;
	;;PIN22 			;;
	BSF RFMB_CS_O			;;
	BCF RFMB_CS_IO			;;
	;;PIN23 			;;
	BCF RFM_SCK_O			;;
	BCF RFM_SCK_IO			;;
	;;PIN24 			;;
	BCF RFM_SDIO_O			;;
	BCF RFM_SDIO_IO			;;
	;;PIN27 			;;
	;BSF ADS2_IO			;;
	;;PIN28 			;;
	;BSF ADS3_IO			;;
	;;PIN29 			;;
	;;PIN30 			;;
	;;PIN31 			;;
	BCF TP1_O                       ;;
	BCF TP1_IO                       ;;
	;;PIN32 			;;
	BCF TP2_O                       ;;
	BCF TP2_IO                       ;;
	;;PIN33 			;;
	BCF TP3_O                       ;;
	BCF TP3_IO                       ;;
	;;PIN34 			;;
	BCF TP4_O                       ;;
	BCF TP4_IO                       ;;
	;;PIN35 			;;
	;;PIN36 			;;
	;;PIN37 			;;
	;;PIN39 			;;
        BSF SLOTSW_S0_IO                ;;
	;;PIN40 			;;
        BSF SLOTSW_S1_IO                ;;
	;;PIN42 			;;
        BSF SLOTSW_S2_IO                ;;
	;;PIN43 			;;
        BSF SLOTSW_S3_IO                ;;
	;;PIN44 			;;
	BCF RFMB_DIO2_O			;;
	BCF RFMB_DIO2_IO		        ;;
	;;PIN45 			;;
	BSF RFMB_DIO1_IO		        ;;
	;;PIN46 			;;
	BCF RFMB_CKO_O			;;
	BCF RFMB_CKO_IO			;;
	;;PIN47				;;
	BCF RS485EX_DE_O		;;
	BCF RS485EX_DE_IO		;;
	;;PIN48 			;;
	;BSF RS485EX_RO_IO		;;
	;;PIN49 			;;
	;BCF RS485EX_DI_O		;;
	;BCF RS485EX_DI_IO		;;
	;;PIN50 			;;
	BSF GPS_RX_O    		;;
	BCF GPS_RX_IO		        ;;
	;;PIN51 			;;
	BSF GPS_TX_IO		        ;;
	;;PIN52 			;;
	BSF GPS_RESET_O    		;;
	BCF GPS_RESET_IO	        ;;
	;;PIN53 			;;
	;BSF LDFI_CS_O			;;
	;BCF LDFI_CS_IO			;;
	;;PIN54 			;;
	;BSF SEO_EN_N_O			;;
	;BCF SEO_EN_N_IO		;;
	;;PIN55 			;;
	BCF RFMB_D0_O			;;
	BCF RFMB_D0_IO		        ;;
	;;PIN58 			;;
	;BCF DFO_EN_P_O			;;
	;BCF DFO_EN_P_IO		;;
	;;PIN59 			;;
	BCF RS485_DE_O		        ;;
	BCF RS485_DE_IO		        ;;
	;;PIN60 			;;
	BSF RS485_RO_IO		        ;;
	;;PIN61 			;;
	BCF RS485_DI_O		        ;;
	BCF RS485_DI_IO		        ;;
        
	;;PIN62 			;;
	BSF LEDB_O                      ;;
	BCF LEDB_IO                     ;;
	;;PIN63 			;;
	BSF LEDG_O                      ;;
	BCF LEDG_IO                     ;;
	;;PIN64 			;;
	BSF LEDR_O                      ;;
	BCF LEDR_IO                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNPUA,#CNPUA7              ;;        
	BSET CNPUB,#CNPUB14             ;;        
	BSET CNPUB,#CNPUB15             ;;        
	BSET CNPUG,#CNPUG6              ;;        
	BSET CNPUG,#CNPUG7              ;;        
	BSET CNPUG,#CNPUG8              ;;        
	BSET CNPUG,#CNPUG9              ;;        
	BSET CNPUA,#CNPUA12             ;;     

	BSET CNPUC,#CNPUC12             ;;        
	BSET CNPUC,#CNPUC15             ;;        
	BSET CNPUD,#CNPUD8              ;;        
	BSET CNPUB,#CNPUB5              ;;        
   
        CLR ANSELA                      ;;
        CLR ANSELB                      ;;
        CLR ANSELC                      ;;
        CLR ANSELE                      ;;
        MOVLF #6,MY_TYPE_ID             ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:
        RETURN


GET_W1_BYTE:
        BTSC W1,#0
        BRA GET_W1_BYTE_1
        MOV [W1],W0
        AND #255,W0
        INC W1,W1
        BRA GET_W1_BYTE_2
GET_W1_BYTE_1:
        BCLR W1,#0
        MOV [W1],W0
        SWAP W0
        AND #255,W0
        INC2 W1,W1
GET_W1_BYTE_2:
        PUSH W2
        MOV LOOP_ADR_END,W2
        CP W1,W2
        POP W2
        BRA GEU,$+4
        RETURN
        MOV LOOP_ADR_START,W1
        RETURN


SET_W3_BYTE:
        BTSC W3,#0
        BRA SET_W3_BYTE_1
        MOV.B W0,[W3]
        INC W3,W3
        RETURN
SET_W3_BYTE_1:
        PUSH W2
        BCLR W3,#0
        MOV [W3],W2
        SWAP W2
        MOV.B W0,W2
        SWAP W2
        MOV W2,[W3]
        POP W2
        INC2 W3,W3
        RETURN






GNGGA_STR:
 .ASCII "$GNGGA,\0"
 .ASCII "$GNGLL,\0"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMP_STR:				;;
        TBLRDL [W3],W2		        ;;
	BTSC W3,#0			;;
	SWAP W2				;; 
        INC W3,W3                       ;;
	AND #255,W2			;;
	BRA NZ,CMP_STR_1		;;
        BSF YES_F                      ;;
        RETURN                          ;;
CMP_STR_1:                              ;;
        CALL GET_W1_BYTE                ;;      
        CP W0,W2                        ;;
        BRA Z,CMP_STR                   ;;
        BCF YES_F                       ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LDB_W1_W3:                              ;;      
        CALL GET_W1_BYTE                ;;
        PUSH W0                         ;;
        CALL SET_W3_BYTE                ;;
        POP W0                          ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_GPSRX:                              ;;
        MOV U2RX_PACK_PTR0,W0           ;;
        CP U2RX_PACK_PTR1               ;;
        BRA NZ,$+4                      ;;
        RETURN                          ;;
        MOV #U2RX_PACK_BUF,W1           ;;
        MOV U2RX_PACK_PTR1,W0           ;;
        SL W0,#2,W0                     ;;
        ADD W0,W1,W1                    ;;
        MOV [W1++],W0                   ;;
        MOV W0,R0                       ;;
        MOV [W1++],W0                   ;;
        MOV W0,R1                       ;;
        MOVLF #0X2500,LOOP_ADR_START    ;;
        MOVLF #0X2700,LOOP_ADR_END      ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC U2RX_PACK_PTR1              ;;
        MOV #16,W0                      ;;
        CP U2RX_PACK_PTR1               ;;
        BRA LTU,$+4                     ;;
        CLR U2RX_PACK_PTR1              ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        LDPTR3 GNGGA_STR                ;;
        MOV #U2RX_BUFA,W1               ;;
        MOV R0,W0                       ;;
        ADD W0,W1,W1                    ;;        
        CALL CMP_STR                    ;;
        BTFSS YES_F                     ;;
        RETURN                          ;;
        MOV #GPS_DATA_BUF,W3            ;;
        MOV #U2RX_BUFA,W1               ;;
        MOV R0,W0                       ;;
        ADD W0,W1,W1                    ;;        
        MOV #U2RX_BUFA,W5               ;;
        MOV R1,W0                       ;;
        ADD W0,W5,W5                    ;;    
        CLR R3                          ;;
CHK_GPSRX_1:                            ;;        
        CALL GET_W1_BYTE                ;;
        PUSH W0                         ;;
        CALL SET_W3_BYTE                ;;
        POP W0                          ;;
        INC R3                          ;;
        MOV #'M',W2                     ;;
        CP W0,W2                        ;;
        BRA Z,CHK_GPSRX_2               ;;
        CP W1,W5                        ;;
        BRA NZ,CHK_GPSRX_1              ;;
        RETURN                          ;;
CHK_GPSRX_2:                            ;; 
        NOP                             ;;
        NOP                             ;;
        MOVFF R3,GPS_DATA_LEN           ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   

;@RF


ERR_PRG:
        MOVLF #3,SLOT_STATUS            ;;
        BRA MAIN_LOOP
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:	                                ;;
        CALL INIT_RAM   		;;
        CALL INIT_SIO_RF                ;;      
        CALL INIT_UART2_38400           ;;
	BSF U1RX_EN_F			;;
	BSF U2RX_EN_F			;;
        MOVLF #2,SLOT_STATUS            ;;
        CLR SLOT_TEST_STATUS            ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BSF RF_EN_F                     ;;
        MOVLF #80,RFA_CH                ;;        
        MOVLF #150,RFB_CH                ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BCF RFAB_F                      ;;
        CALL RF_INIT			;;
        CP0 RFERR                       ;;
        BRA NZ,ERR_PRG                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BSF RFAB_F                      ;;
        CALL RF_INIT			;;
        CP0 RFERR                       ;;
        BRA NZ,ERR_PRG                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL SET_RF                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
        CLRWDT                          ;;
	BTFSC T128M_F			;;
	TG TP1_O			;;
	CLRWDT				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL CHK_U1RX			;;
        CALL CHK_U1TX_END               ;;
        ;=================================
        CALL CHK_GPSRX                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC U2STA,#OERR		;;
	BCLR U2STA,#OERR		;;
	BTSC U1STA,#OERR		;;
	BCLR U1STA,#OERR		;;
        BRA MAIN_LOOP                   ;;        
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_RF:                                 ;;
        BTFSS RF_EN_F                   ;;
        BRA SET_RF                      ;;
        BCF RFAB_F                      ;;      
        WRFLD 0X60,MODECTR_REG          ;;      
        MOV RFA_CH,W0                   ;;
        CALL SET_RFCH                   ;;
        WRFLD 0X82,CKO_REG              ;;
        WRFCMD CMD_TX                   ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BSF RFAB_F                      ;;        
        WRFLD 0X60,MODECTR_REG          ;;
        MOV RFB_CH,W0                   ;;
        CALL SET_RFCH                   ;;
        WRFLD 0X82,CKO_REG              ;;
        WRFCMD CMD_RX                   ;;
        RETURN                          ;;
SET_RF_1:                               ;;
        BCF RFAB_F                      ;;      
        WRFCMD CMD_STBY                 ;;
        BSF RFAB_F                      ;;      
        WRFCMD CMD_STBY                 ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TEST_RFTX:
        WRFLD 0X60,MODECTR_REG
        MOV #78,W0
        CALL SET_RFCH
        ;WRFLD 0XAA,CKO_REG
        ;WRFLD 0X1D,GPIO1_REG
        ;WRFLD 0X09,GPIO2_REG
        ;BCF RF_GIO1_O
        ;BCF RF_GIO1_IO
        NOP
        NOP
        NOP
        NOP
        WRFCMD CMD_TX
        MOV #20,W0
        CALL DLYMX
        NOP
        NOP
        NOP
        WRFLD 0X82,CKO_REG
        ;MOV #100,W0
        ;CALL DLYMX
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        

TEST_RFTX_0:
        WRFCMD CMD_TX
        NOP
        NOP
        NOP
        NOP
        MOV #1000,W0
        CALL DLYMX
        WRFCMD CMD_STBY
        NOP
        NOP
        NOP
        NOP
        MOV #100,W0
        CALL DLYMX
        BRA TEST_RFTX_0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RF_INIT:                                ;;
        CLR RFERR                       ;;
        CALL RF_RESET                   ;;        
        MOV #10,W0                      ;;
        CALL DLYMX                      ;;
        CALL A5133_TEST                 ;;
        BTFSS ERROR_F                   ;;        
        BRA $+8                         ;;
        MOV #RF_TEST_ERR_K,W0           ;;
        MOV W0,RFERR                    ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL RF_CONFIG                  ;;
        CALL RF_TRIMMEDVALUE_INI        ;;
        BTFSS ERROR_F                   ;;        
        BRA $+8                         ;;
        MOV #RF_TRIM_ERR_K,W0           ;;
        MOV W0,RFERR                    ;;        
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL RF_CAL                     ;;
        BTFSS ERROR_F                   ;;
        BRA $+8                         ;;
        MOV #RF_CALI_ERR_K,W0           ;;
        MOV W0,RFERR                    ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


RF_CONFIG:
        LTADR A5133CFG_TBL
        MOVLF #0X01,DADR_ST
        MOVLF #0X04,DADR_END
        CALL WRF_REGS
        ;======================
        LTADR A5133CFG_TBL
        MOVLF #0X07,DADR_ST
        MOVLF #0X1F,DADR_END
        CALL WRF_REGS
        ;======================
        LTADR A5133CFG_20_TBL
        MOVLF #0X20,DADR
        MOVLF #13,BTLIM
        CALL WRF_REGPAGE
        ;======================
        LTADR A5133CFG_21_TBL
        MOVLF #0X21,DADR
        MOVLF #13,BTLIM
        CALL WRF_REGPAGE
        ;======================
        LTADR A5133CFG_22_TBL
        MOVLF #0X22,DADR
        MOVLF #6,BTLIM
        CALL WRF_REGPAGE
        ;======================
        LTADR A5133CFG_TBL
        MOVLF #0X23,DADR_ST
        MOVLF #0X29,DADR_END
        CALL WRF_REGS
        ;======================
        LTADR A5133CFG_2A_TBL
        MOVLF #0X2A,DADR
        MOVLF #13,BTLIM
        CALL WRF_REGPAGE
        ;======================
        LTADR A5133CFG_TBL
        MOVLF #0X2B,DADR_ST
        MOVLF #0X35,DADR_END
        CALL WRF_REGS
        ;======================
        LTADR A5133CFG_TBL
        MOVLF #0X37,DADR_ST
        MOVLF #0X37,DADR_END
        CALL WRF_REGS
        ;======================
        LTADR A5133CFG_38_TBL
        MOVLF #0X38,DADR
        MOVLF #12,BTLIM
        CALL WRF_REGPAGE
        ;======================
        LTADR A5133CFG_TBL
        MOVLF #0X39,DADR_ST
        MOVLF #0X3C,DADR_END
        CALL WRF_REGS
        ;======================
        LTADR A5133CFG_TBL
        MOVLF #0X3E,DADR_ST
        MOVLF #0X3E,DADR_END
        CALL WRF_REGS
        ;======================
        RETURN



RF_TRIMMEDVALUE_INI:
        BSF ERROR_F
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #9,BTCNT
        MOVLF #0XFF,ANDDATA
        MOVLF #0XA0,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #5,W0
        CALL DLYMX
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        MOVLF #USID_REG,DADR
        MOVLF #TMP00,RADR
        MOVLF #8,BTLIM
        CALL RRF_TBL
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #9,BTCNT
        MOVLF #0XFF,ANDDATA
        MOVLF #0X00,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV TMP00,W0
        ADD TMP01,WREG
        AND #255,W0
        CP TMP04
        BRA NZ,RTI_1
        CP0 TMP00
        BRA Z,RTI_ERR
        CP0 TMP01
        BRA Z,RTI_ERR
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #1,BTCNT
        MOVLF #0XE0,ANDDATA
        MOVFF TMP00,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #2,BTCNT
        MOVLF #0XC0,ANDDATA
        MOVFF TMP01,IORDATA
        CALL WRF_REGPAGE_ONE
        BCF ERROR_F
        RETURN
RTI_1:
        MOV TMP00,W0
        ADD TMP01,WREG
        ADD TMP02,WREG
        ADD TMP03,WREG
        AND #255,W0
        CP TMP04
        BRA NZ,RTI_2
        CP0 TMP00
        BRA Z,RTI_ERR
        CP0 TMP01
        BRA Z,RTI_ERR
        CP0 TMP02
        BRA Z,RTI_ERR
        CP0 TMP03
        BRA Z,RTI_ERR
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #1,BTCNT
        MOVLF #0XE0,ANDDATA
        MOVFF TMP00,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #2,BTCNT
        MOVLF #0XC0,ANDDATA
        MOVFF TMP01,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #0,BTCNT
        MOVLF #0X03,ANDDATA
        MOV TMP02,W0
        SL W0,#2,W0
        MOV W0,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #4,BTCNT
        MOVLF #0X40,ANDDATA
        MOVFF TMP03,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        BCF ERROR_F
        RETURN

RTI_2:
        CP0 TMP00
        BRA Z,RTI_ERR
        CP0 TMP01
        BRA Z,RTI_ERR
        CP0 TMP02
        BRA Z,RTI_ERR
        CP0 TMP03
        BRA Z,RTI_ERR
        CP0 TMP04
        BRA Z,RTI_ERR
        CP0 TMP06
        BRA Z,RTI_ERR
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #1,BTCNT
        MOVLF #0XE0,ANDDATA
        MOVFF TMP06,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #2,BTCNT
        MOVLF #0XC0,ANDDATA
        MOVFF TMP01,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #0,BTCNT
        MOVLF #0X03,ANDDATA
        MOV TMP02,W0
        SL W0,#2,W0
        MOV W0,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        LTADR A5133CFG_38_TBL
        MOVLF #ROMP_REG,DADR
        MOVLF #4,BTCNT
        MOVLF #0X40,ANDDATA
        MOVFF TMP03,IORDATA
        CALL WRF_REGPAGE_ONE
        ;;;;;;;;;;;;;;;;;;;;;;;;;
        BCF ERROR_F
        RETURN
RTI_ERR:
        RETURN
        
RF_CAL_IF:
        PUSH R0
        BSF ERROR_F
        WRFLD 0x3D,RXGAIN3_REG
        CLR R0
RCI_1:
        INC R0
        MOV #10,W0
        CP R0
        BRA LTU,$+4
        RETURN        
        NOP
        NOP
        NOP
        MOV #0X23,W0
        CALL RF_CAL_DATA
        BTFSC ERROR_F
        RETURN
        NOP
        NOP
        NOP
        NOP
        RRFDW IFCAL1_REG
        AND #15,W0
        CP W0,#3
        BRA LTU,RCI_1                
        CP W0,#9
        BRA GTU,RCI_1                

        BCF ERROR_F
        NOP
        NOP
        NOP
        NOP
        POP R0
        RETURN

        






RF_CAL:
        WRFCMD CMD_PLL
        WRFLD 0X00,RFANALOG_REG
        CALL RF_CAL_IF
        BTFSC ERROR_F
        RETURN
        RRFDW IFCAL1_REG
        NOP
        NOP
        NOP
        NOP
        RRFDW IFCAL1_REG
        NOP
        NOP
        NOP
        NOP
        RRFDW IFCAL1_REG
        NOP
        NOP
        NOP
        NOP





        ;MOV #0X23,W0
        ;CALL RF_CAL_DATA
        ;BTFSC ERROR_F
        ;RETURN
        NOP
        NOP
        NOP
        NOP
        MOV #20,W0
        CALL RF_CAL_CHGP
        BTFSC ERROR_F
        RETURN
        NOP
        NOP
        NOP
        NOP
        MOV #60,W0
        CALL RF_CAL_CHGP
        BTFSC ERROR_F
        RETURN
        NOP
        NOP
        NOP
        NOP

        MOV #100,W0
        CALL RF_CAL_CHGP
        BTFSC ERROR_F
        RETURN

        NOP     
        NOP
        NOP


        
        WRFCMD CMD_STBY
        NOP     
        NOP
        NOP
        MOV #100,W0
        CALL DLYMX
        NOP
        NOP
        RRFDW IFCAL1_REG
        MOV W0,R0
        NOP
        NOP



        RRFDW IFCAL2_REG
        MOV W0,R1
        RRFDW RXGAIN2_REG
        MOV W0,MEM_RH
        RRFDW RXGAIN3_REG
        MOV W0,MEM_RL
        NOP
        NOP
        NOP
        NOP
        BTSC R0,#4
        BSF ERROR_F
        NOP
        NOP
        NOP
        NOP
        RETURN







;W0 CH
RF_CAL_CHGP:
        BSF ERROR_F
        WRFWD PLL1_REG
        MOV #0X1C,W0
        CALL RF_CAL_DATA
        BTFSC ERROR_F
        RETURN
        RRFDW VCOCCAL_REG
        MOV W0,R0       ;VCB
        RRFDW VCOCAL1_REG
        MOV W0,R1       ;VB
        RRFDW VCODEVCAL1_REG
        MOV W0,R2       ;DEVA
        RRFDW VCODEVCAL2_REG
        MOV W0,R3       ;ADEV
        BTSC R0,#4
        RETURN
        BTSC R1,#4
        RETURN
        BCF ERROR_F
        NOP
        NOP
        NOP
        NOP        
        RETURN




RF_CAL_DATA:
        BSF ERROR_F
        PUSH R0
        PUSH R1
        CLR R1
        MOV W0,R0
        WRFRD R0,CALIBRATION_REG
RF_CAL_DATA_1:
        CLRWDT
        INC R1
        BTSC R1,#12
        RETURN
        RRFDW CALIBRATION_REG
        AND R0,WREG
        CP0 W0
        BRA NZ,RF_CAL_DATA_1
        NOP
        NOP
        NOP
        NOP
        NOP
        MOV #10,W0
        CALL DLYMX

        POP R1
        POP R0
        BCF ERROR_F       
        RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_RFPAGE:                             ;;
        PUSH W0                         ;;
        LOFFS1 A5133CFG_TBL             ;;        
        MOV #RFANALOG_REG,W0            ;;
        CALL TBLW                       ;;
        POP W2                          ;;
        SWAP.B W2                       ;;
        IOR W2,W0,W0                    ;;        
        MOV #RFANALOG_REG,W1            ;;        
        CALL WRFD8                      ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRF_REGPAGE:                            ;;
        CLR BTCNT                       ;;
WRF_REGPAGE_1:                          ;;
        MOV BTCNT,W0                    ;;
        CALL SET_RFPAGE                 ;;
        MOV TADR,W1                     ;;
        MOV BTCNT,W0                    ;;
        CALL TBLW                       ;;
        MOV DADR,W1                     ;;
        CALL WRFD8                      ;;
        INC BTCNT                       ;;
        MOV BTLIM,W0                    ;;
        CP BTCNT                        ;;
        BRA LTU,WRF_REGPAGE_1           ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRF_REGPAGE_ONE:                        ;;
        MOV BTCNT,W0                    ;;        
        CALL SET_RFPAGE                 ;;
        MOV TADR,W1                     ;;
        MOV BTCNT,W0                    ;;        
        CALL TBLW                       ;;
        AND ANDDATA,WREG                ;;
        IOR IORDATA,WREG                ;;
        MOV DADR,W1                     ;;
        CALL WRFD8                      ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        

        





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
A5133_TEST:                             ;;
        LTADR A5133CFG_ID_TBL           ;;
        MOVLF #IDDATA_REG,DADR          ;;
        MOVLF #8,BTLIM                  ;;
        CALL WRF_TBL                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOVLF #IDDATA_REG,DADR          ;;
        MOVLF #TMP00,RADR               ;;
        MOVLF #8,BTLIM                  ;;
        CALL RRF_TBL                    ;;
        LTADR A5133CFG_ID_TBL           ;;
        MOVLF #TMP00,RADR               ;;        
        MOVLF #8,BTLIM                  ;;
        CALL CPR_TBL                    ;;
        BTFSC ERROR_F                   ;;
        NOP                             ;;      
        NOP                             ;;
        NOP                             ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RF_RESET:                               ;;
        WRFLD 0,RESET_REG               ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;5725+CH*1(MHZ)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_RFCH:                               ;;
        WRFWD PLL1_REG                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        


;INPUT 
;RADR
;TADR
;BTLIM        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CPR_TBL:                                ;;
        BSF ERROR_F                     ;;
        CLR BTCNT                       ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CPR_TBL_1:                              ;;
        MOV TADR,W1                      ;;
        MOV BTCNT,W0                    ;;
        CALL TBLW                       ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV RADR,W1                     ;;
        MOV BTCNT,W2                    ;;
        SL W2,#1,W2                     ;;
        ADD W2,W1,W1                    ;;
        MOV [W1],W2                     ;;
        CP W0,W2                        ;;
        BRA Z,$+4                       ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC BTCNT                       ;;
        MOV BTLIM,W0                    ;;
        CP BTCNT                        ;;
        BRA LTU,CPR_TBL_1               ;;
        BCF ERROR_F                     ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




        
;INPUT 
;TADR
;DADR
;BTLIM        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRF_TBL:                                ;;
        CLR BTCNT                       ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL RFSPI_START                ;;
        MOV DADR,W0                     ;;
        CALL WSPI                       ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRF_TBL_1:                              ;;
        MOV TADR,W1                     ;;
        MOV BTCNT,W0                    ;;
        CALL TBLW                       ;;
        CALL WSPI                       ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC BTCNT                       ;;
        MOV BTLIM,W0                    ;;
        CP BTCNT                        ;;
        BRA LTU,WRF_TBL_1               ;;
        CALL RFSPI_END                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;INPUT 
;RADR0  A5133 REG ADDRESS
;RADR1  STORE TO REG
;BTLIM        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RRF_TBL:                                ;;
        CLR BTCNT                       ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL RFSPI_START                ;;
        MOV DADR,W0                     ;;
        BSET W0,#6
        CALL WSPI                       ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RRF_TBL_1:                              ;;
        CALL RSPI                       ;;        
        MOV RADR,W1                     ;;
        MOV BTCNT,W2                    ;;
        SL W2,#1,W2                     ;;
        ADD W2,W1,W1                    ;;
        MOV W0,[W1]                     ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC BTCNT                       ;;
        MOV BTLIM,W0                    ;;
        CP BTCNT                        ;;
        BRA LTU,RRF_TBL_1               ;;
        CALL RFSPI_END                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;INPUT 
;TADR
;DADR_ST
;DADR1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
WRF_REGS:                               ;;
        MOV TADR,W1                     ;;
        MOV DADR_ST,W0                  ;;
        CALL TBLW                       ;;
        MOV DADR_ST,W1                  ;;
        CALL WRFD8                      ;;
        INC DADR_ST                     ;;
        MOV DADR_END,W0                 ;;
        CP DADR_ST                      ;;
        BRA LEU,WRF_REGS                ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





        




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
NOPSPI:                                 ;;
        NOP                             ;;
        NOP                             ;;
        NOP                             ;;
        NOP                             ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
WSPI:                                   ;;
        PUSH W2                         ;;
        BCF RFM_SDIO_IO                 ;;
        CALL NOPSPI                     ;;
        MOV #8,W2                       ;;
WSPI_1:                                 ;;
        BCF RFM_SCK_O                   ;;
        BTSS W0,#7                      ;;
        BCF RFM_SDIO_O                  ;;
        BTSC W0,#7                      ;;
        BSF RFM_SDIO_O                  ;;
        CALL NOPSPI                     ;;
        BSF RFM_SCK_O                   ;;
        CALL NOPSPI                     ;;
        SL W0,W0                        ;;
        DEC W2,W2                       ;;
        BRA NZ,WSPI_1                   ;;
        POP W2                          ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RSPI:                                   ;;
        PUSH W2                         ;;
        BSF RFM_SDIO_IO                 ;;
        CALL NOPSPI                     ;;
        MOV #0,W0                       ;;
        MOV #8,W2                       ;;
RSPI_1:                                 ;;
        BCF RFM_SCK_O                   ;;
        CALL NOPSPI                     ;;
        SL W0,#1,W0                     ;;
        BSET W0,#0                      ;;
        BTFSS RFM_SDIO_I                ;;        
        BCLR W0,#0                      ;;
        BSF RFM_SCK_O                   ;;
        CALL NOPSPI                     ;;
        DEC W2,W2                       ;;
        BRA NZ,RSPI_1                   ;;
        POP W2                          ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        


      
;W1 ADDR
;W0 DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
WRFD8:                                  ;;
        CALL RFSPI_START                ;;
        PUSH W0                         ;;
        MOV W1,W0                       ;;
        CALL WSPI                       ;;
        POP W0                          ;;
        CALL WSPI                       ;;
        CALL RFSPI_END                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;W0 DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRFTRIG:                                ;;
        CALL RFSPI_START                ;;        
        CALL WSPI                       ;;
        CALL RFSPI_END                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;W1:ADDR
;OUT: W0:DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RRFD8:                                  ;;      
        CALL RFSPI_START                ;;
        MOV W1,W0                       ;;
        BSET W0,#6                      ;;
        CALL WSPI                       ;;
        CALL RSPI                       ;;
        CALL RFSPI_END                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
RFSPI_START:                            ;;
        BCF RFM_SCK_O                   ;;
        BTFSS RFAB_F                    ;;
        BCF RFMA_CS_O                   ;;
        BTFSC RFAB_F                    ;;
        BCF RFMB_CS_O                   ;;
        CLRWDT                          ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RFSPI_END:                              ;;
        BCF RFM_SCK_O                   ;;      
        BSF RFMA_CS_O                   ;;
        BSF RFMB_CS_O                   ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TBLW:                                   ;;
        SL W0,#1,W0                     ;;
        ADD W0,W1,W1                    ;;                
      	TBLRDL [W1++],W0                ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        


	









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
A5133CFG_TBL:				
	.WORD 0x00;0X00, //RESET register,		Only reset, not use on config
	.WORD 0x62;0X01, //MODE register,
	.WORD 0x00;0X02, //CALIBRATION register,
	.WORD 0x3F;0X03, //FIFO1 register,
	.WORD 0x00;0X04, //FIFO2 register,
	.WORD 0x00;0X05, //FIFO DATAr,			for fifo read/write
	.WORD 0x00;0X06, //IDDATA register,		for idcode
	.WORD 0x00;0X07, //RCOSC1 register,
	.WORD 0x00;0X08, //RCOSC2 register,
	.WORD 0x0C;0X09, //RCOSC3 register,
	.WORD 0x82;0X0A, //CKO register,
	.WORD 0x21;0X0B, //GPIO1 register RXD kevin
	.WORD 0x24;0X0C, //GPIO2 register,TXD kevin
	.WORD 0x1F;0X0D, //DATARATECLOCK register,
	.WORD 0x00;0X0E, //PLL1 register,//RF BASE 5725M+THIS*1M
	.WORD 0x1E;0X0F, //PLL2 register,       
        ;==================================================
	.WORD 0x59;0X10, //PLL3 register,DIRECT MODE kevin
	.WORD 0x74;0X11, //PLL4 register,
	.WORD 0x01;0X12, //PLL5 register,DIRECT MODE kevin
	.WORD 0x28;0X13, //ChannelGroup1 register,
	.WORD 0x50;0X14, //ChannelGroup2 register,
	.WORD 0x2D;0X15, //TX1 register,FIFO MODE
	.WORD 0x40;0X16, //TX2 register,
	.WORD 0x1B;0X17, //DELAY1 register,
	.WORD 0x40;0X18, //DELAY2 register,
	.WORD 0x70;0X19, //RX register,
	.WORD 0x7B;0X1A, //RXGAIN1 register,
	.WORD 0xC0;0X1B, //RXGAIN2 register,
	.WORD 0x3C;0X1C, //RXGAIN3 register,
	.WORD 0xCA;0X1D, //RXGAIN4 register,
	.WORD 0x00;0X1E, //RSSI register,
	.WORD 0xC1;0X1F, //ADC register,
        ;=============================================
	.WORD 0x00;0X20, //CODE1 register,reference
	.WORD 0x00;0X21, //CODE2 register,
	.WORD 0x00;0X22, //CODE3 register,
	.WORD 0xE4;0X23, //IFCAL1 register,//KFVIN CHECK 0X60
	.WORD 0x01;0X24, //IFCAL2 register,
	.WORD 0x4F;0X25, //VCOCCAL register,
	.WORD 0xC0;0X26, //VCOCAL1 register,
	.WORD 0x80;0X27, //VCOCAL2 register,
	.WORD 0x30;0X28, //VCO deviation 1 register,
	.WORD 0x40;0X29, //VCO deviation 2 register,
	.WORD 0x00;0X2A, //DAS register,
	.WORD 0xFF;0X2B, //VCO Modulation delay register,
	.WORD 0x40;0X2C, //BATTERY register,
	.WORD 0xA7;0X2D, //TXTEST register,
	.WORD 0x57;0X2E, //RXDEM1 register,
	.WORD 0x74;0X2F, //RXDEM2 register,
        ;=============================================
	.WORD 0xF3;0X30, //CPC1 register,
	.WORD 0x33;0X31, //CPC2 register,
	.WORD 0x4D;0X32, //CRYSTAL register,
	.WORD 0x15;0X33, //PLLTEST register,
	.WORD 0x0F;0X34, //VCOTEST register,
	.WORD 0x00;0X35, //RF Analog register,
	.WORD 0x00;0X36, //Key data register,
	.WORD 0x33;0X37, //Channel select register,
	.WORD 0x00;0X38, //ROM register,
	.WORD 0x00;0X39, //DataRate register,
	.WORD 0x00;0X3A, //FCR register,
	.WORD 0x00;0X3B, //ARD register,
	.WORD 0x00;0X3C, //AFEP register,
	.WORD 0x00;0X3D, //FCB register,
	.WORD 0x00;0X3E, //KEYC register,
	.WORD 0x00;0X3F, //USID register,
	;===================================


A5133CFG_ID_TBL:
	.WORD 0x01
	.WORD 0x23
	.WORD 0x45
	.WORD 0x67
	.WORD 0x89
	.WORD 0xAB
	.WORD 0xCD
	.WORD 0xEF


A5133CFG_20_TBL:
	.WORD 0x0E      ;page0,
	.WORD 0x00      ;page1,
	.WORD 0x00      ;Page2,
	.WORD 0x00      ;page3,
	.WORD 0x00      ;page4,
	.WORD 0x00      ;page5,
	.WORD 0x00      ;page6,
	.WORD 0x00      ;page7,
	.WORD 0x00      ;page8,
	.WORD 0x00      ;page9,
	.WORD 0x02      ;page10,
	.WORD 0x00      ;page11,
	.WORD 0x00      ;page12,

A5133CFG_21_TBL:
	.WORD 0x09      ;page0,
	.WORD 0x00      ;page1,
	.WORD 0x00      ;Page2,
	.WORD 0x00      ;page3,
	.WORD 0x00      ;page4,
	.WORD 0x00      ;page5,
	.WORD 0xE0      ;page6,
	.WORD 0x00      ;page7,
	.WORD 0x2C      ;page8,
	.WORD 0x4F      ;page9,
	.WORD 0x01      ;page10,
	.WORD 0x42      ;page11,
	.WORD 0x56      ;page12,

A5133CFG_22_TBL:
	.WORD 0x00      ;page0,
	.WORD 0x10      ;page1,//0X10
	.WORD 0x00      ;Page2,
	.WORD 0x10      ;page3,
	.WORD 0x00      ;page4,
	.WORD 0x04      ;page5,



A5133CFG_2A_TBL:
	.WORD 0x00      ;page0,
	.WORD 0x01      ;page1,
	.WORD 0xF0      ;Page2,
	.WORD 0x80      ;page3,
	.WORD 0x80      ;page4,
	.WORD 0x48      ;page5,
	.WORD 0x03      ;page6,
	.WORD 0xC0      ;page7,
	.WORD 0x3A      ;page8,
	.WORD 0x3E      ;page9,
	.WORD 0xE8      ;page10,
	.WORD 0x80      ;page11,
	.WORD 0x00      ;page12,


A5133CFG_38_TBL:
	.WORD 0x80      ;page0,
	.WORD 0x50      ;page1,
	.WORD 0x20      ;Page2,
	.WORD 0x64      ;page3,
	.WORD 0x20      ;page4,
	.WORD 0x40      ;page5,
	.WORD 0x60      ;page6,
	.WORD 0x04      ;page7,
	.WORD 0x00      ;page8,
	.WORD 0x00      ;page9,
	.WORD 0x00      ;page10,
	.WORD 0x00      ;page11,




	



.ENDIF












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY_ACT_PRG:			        ;;
        MOV TMR2,W0                     ;;
        SUB DELAY_ACT_TIM,WREG          ;;
        BTSS W0,#15                     ;;
        RETURN                          ;;  
	MOV DELAY_ACT,W0		;;
        CLR DELAY_ACT                   ;;
        CP W0,#2                        ;;
        BRA LTU,$+4                     ;;
        RETURN                          ;;
	BRA W0				;;
	BRA DELAY_ACT_J0                ;;//RETURN SLOT INF	BRA DELAY_ACT_J1                ;;
	BRA DELAY_ACT_J1                ;;
DELAY_ACT_J0:                           ;;                           
	RETURN                          ;;
DELAY_ACT_J1:                           ;;
        MOV #DEVICE_ID_K,W0             ;;
	MOV W0,TX_DEVICE_ID             ;;
        MOV MY_SLOT_ID,W0               ;;      
	MOV W0,TX_SERIAL_ID             ;;
        MOV #0xAC00,W0                  ;;
	MOV W0,TX_GROUP_ID              ;;
	MOV #0x1000,W0                  ;;
	MOV W0,UTX_CMD                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV MY_TYPE_ID,W2               ;;
        MOV MY_ITEM_ID,W0               ;;
        SL W0,#4,W0                     ;;
        IOR W0,W2,W2                    ;;
        MOV SLOT_STATUS,W0              ;;
        SL W0,#8,W0                     ;;
        IOR W0,W2,W2                    ;;
        MOV SLOT_TEST_STATUS,W0         ;;
        SL W0,#10,W0                    ;;
        IOR W0,W2,W2                    ;;
	MOV W2,W0                       ;;
	MOV W0,UTX_PARA0                ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0
	MOV W0,UTX_PARA1
	MOV #0x0000,W0
	MOV W0,UTX_PARA2
	MOV #0x0000,W0
	MOV W0,UTX_PARA3
        MOVLF #40,UTX_BUFFER_LEN
        MOV #SLOTINF_BUF,W3
	BCF U1U2_F
	CALL UTX_STD
	RETURN




.IFDEF JS203_39A_F01_02



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2RXInterrupt:			;;
	PUSH SR				;;
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2RXIF		;;
	MOV U2RXREG,W1			;;
	AND #255,W1			;;
	;BTFSS U2RX_EN_F		;;
	;BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;MOV #250,W0                     ;;
        ;ADD TMR2,WREG                   ;;
        ;MOV W0,U2TX_REPEAT_TIM          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xEA,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PS			;;	
	MOV #0xEB,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PE			;;	
	MOV #0xEC,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PT			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;; 
	BTFSC U2RXT_F			;;
	XOR W0,W1,W1			;;
	BCF U2RXT_F			;;
	MOV #U2RX_BUFSIZE,W0		;;
	CP U2RX_BYTE_PTR		;;
	BRA GEU,U2RXI_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2RX_BUFA,W0		;;
	BTFSC U2RX_BUFAB_F		;;
	MOV #U2RX_BUFB,W0		;;
	ADD U2RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	BTSC U2RX_BYTE_PTR,#0		;;
	BRA U2RXI_1			;;
	MOV W1,[W0]			;;
	BRA U2RXI_2			;;
U2RXI_1:				;;
	SWAP W1				;;
	ADD W1,[W0],[W0]		;;
	SWAP W1				;;
U2RXI_2:				;;
	MOV U2RX_TMP0,W0		;;
	MOV W0,U2RX_TMP1		;;
	MOV W1,W0			;;
	MOV W0,U2RX_TMP0		;;
	MOV W1,W0			;;
	ADD U2RX_ADDSUM			;;	
	XOR U2RX_XORSUM			;;
	INC U2RX_BYTE_PTR		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PS:				;;
	BCF U2RXT_F			;;
	CLR U2RX_BYTE_PTR		;;
	CLR U2RX_ADDSUM			;;
	CLR U2RX_XORSUM			;;
	BSF MASTER_U2RX_F		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PE:				;;
	BCF U2RXT_F			;;
	MOV #0xAB,W0			;;
	XOR U2RX_XORSUM,WREG		;;	
	XOR U2RX_TMP0,WREG		;;
	BRA NZ,U2RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RX_TMP0,W0		;;
	ADD U2RX_TMP0,WREG		;;
	ADD U2RX_TMP1,WREG		;;
	XOR U2RX_ADDSUM,WREG		;;
	AND #255,W0			;;
	BRA NZ,U2RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RX_BYTE_PTR,W0		;;	
	BTFSS U2RX_BUFAB_F		;;	
	MOV W0,U2RXA_LEN		;;
	BTFSC U2RX_BUFAB_F		;;	
	MOV W0,U2RXB_LEN		;;
	BTFSS U2RX_BUFAB_F		;;	
	BSF U2RX_PACKA_F		;;
	BTFSC U2RX_BUFAB_F		;;	
	BSF U2RX_PACKB_F		;;
	TG U2RX_BUFAB_F			;;	
	MOV TMR2,W0			;;
	MOV W0,U2RX_PACK_TIME		;;	
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PT:				;;
	BSF U2RXT_F			;;
	BRA U2RXI_END			;;
U2RXI_END:				;;	
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
        BSF SWS0_IO                     ;;
	;;PIN2 				;;
        BSF SWS1_IO                     ;;
	;;PIN3 				;;
        BSF SWS2_IO                     ;;
	;;PIN4 				;;
        BSF SWS3_IO                     ;;
	;;PIN5 				;;
        BSF SWS4_IO                     ;;
	;;PIN6 				;;
        BSF SWS5_IO                     ;;
	;;PIN8 				;;
        BSF SWS6_IO                     ;;
	;;PIN11 			;;
        BSF SWS7_IO                     ;;
	;;PIN12 			;;
	BCF NC12_O                      ;;
	BCF NC12_IO                     ;;
	;;PIN13 			;;
	BCF NC13_O                      ;;
	BCF NC13_IO                     ;;
	;;PIN14 			;;
	BSF ADI_5V_IO			;;
	;;PIN15 			;;
	BCF NC15_O                      ;;
	BCF NC15_IO                     ;;
	;;PIN16 			;;
	BCF NC16_O                      ;;
	BCF NC16_IO                     ;;
	;;PIN21 			;;
	BCF NC21_O                      ;;
	BCF NC21_IO                     ;;
	;;PIN22 			;;
	BCF NC22_O                      ;;
	BCF NC22_IO                     ;;
	;;PIN23 			;;
	BCF NC23_O                      ;;
	BCF NC23_IO                     ;;
	;;PIN24 			;;
	BCF NC24_O			;;
	BCF NC24_IO			;;
	;;PIN27 			;;
	BCF NC27_O			;;
	BCF NC27_IO			;;
	;;PIN28 			;;
	BCF NC28_O			;;
	BCF NC28_IO			;;
	;;PIN29 			;;
	BCF NC29_O			;;
	BCF NC29_IO			;;
	;;PIN30 			;;
	BCF NC30_O			;;
	BCF NC30_IO			;;
	;;PIN31 			;;
	BCF TP1_O                       ;;
	BCF TP1_IO                       ;;
	;;PIN32 			;;
	BCF TP2_O                       ;;
	BCF TP2_IO                       ;;
	;;PIN33 			;;
	BCF TP3_O                       ;;
	BCF TP3_IO                       ;;
	;;PIN34 			;;
	BCF TP4_O                       ;;
	BCF TP4_IO                       ;;
	;;PIN35 			;;
	BCF NC35_O			;;
	BCF NC35_IO			;;
	;;PIN36 			;;
	BCF NC36_O			;;
	BCF NC36_IO			;;
	;;PIN37 			;;
	BCF NC37_O			;;
	BCF NC37_IO			;;
	;;PIN39 			;;
        BSF SLOTSW_S0_IO                ;;
	;;PIN40 			;;
        BSF SLOTSW_S1_IO                ;;
	;;PIN42 			;;
        BSF SLOTSW_S2_IO                ;;
	;;PIN43 			;;
        BSF SLOTSW_S3_IO                ;;
	;;PIN44 			;;
	BCF NC44_O			;;
	BCF NC44_IO			;;
	;;PIN45 			;;
	BCF NC45_O			;;
	BCF NC45_IO			;;
	;;PIN46 			;;
	BCF NC46_O			;;
	BCF NC46_IO			;;
	;;PIN47				;;
	BCF RS485EX_DE_O		;;
	BCF RS485EX_DE_IO		;;
	;;PIN48 			;;
	BSF RS485EX_RO_IO		;;
	;;PIN49 			;;
	BCF RS485EX_DI_O		;;
	BCF RS485EX_DI_IO		;;
	;;PIN50 			;;
	BSF WG_TRIG_EN_O	        ;;
	BCF WG_TRIG_EN_IO		;;
	;;PIN51 			;;
	BCF NC51_O			;;
	BCF NC51_IO			;;
	;;PIN52 			;;
	BCF NC52_O			;;
	BCF NC52_IO			;;
	;;PIN53 			;;
	BCF NC53_O			;;
	BCF NC53_IO			;;
	;;PIN54 			;;
	BCF NC54_O			;;
	BCF NC54_IO			;;
	;;PIN55 			;;
	BCF NC55_O			;;
	BCF NC55_IO			;;
	;;PIN58 			;;
	BCF NC58_O			;;
	BCF NC58_IO			;;
	;;PIN59 			;;
	BCF RS485_DE_O		        ;;
	BCF RS485_DE_IO		        ;;
	;;PIN60 			;;
	BSF RS485_RO_IO		        ;;
	;;PIN61 			;;
	BCF RS485_DI_O		        ;;
	BCF RS485_DI_IO		        ;;
	;;PIN62 			;;
	BSF LEDB_O                      ;;
	BCF LEDB_IO                     ;;
	;;PIN63 			;;
	BSF LEDG_O                      ;;
	BCF LEDG_IO                     ;;
	;;PIN64 			;;
	BSF LEDR_O                      ;;
	BCF LEDR_IO                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNPUA,#CNPUA7              ;;        
	BSET CNPUB,#CNPUB14             ;;        
	BSET CNPUB,#CNPUB15             ;;        
	BSET CNPUG,#CNPUG6              ;;        
	BSET CNPUG,#CNPUG7              ;;        
	BSET CNPUG,#CNPUG8              ;;        
	BSET CNPUG,#CNPUG9              ;;        
	BSET CNPUA,#CNPUA12             ;;        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNPUC,#CNPUC12             ;;        
	BSET CNPUC,#CNPUC15             ;;        
	BSET CNPUD,#CNPUD8              ;;        
	BSET CNPUB,#CNPUB5              ;;        
	BSET CNPUB,#CNPUB10             ;;        
        CLR ANSELA                      ;;
        CLR ANSELB                      ;;
        CLR ANSELC                      ;;
        CLR ANSELE                      ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOVLF #8,MY_TYPE_ID             ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:
        MOVLF #1,SON_SERIAL_ID
        MOV #SLOTINF_BUF,W1
        REPEAT #39;
        CLR [W1++]
        RETURN

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET PS_FLAG,#0 		;;PSSON CONNECTED
        BCLR PS_FLAG,#1                 ;;FAUALT_F
	BCLR PS_FLAG,#2			;;P50VEN_F
	BCLR PS_FLAG,#3			;;P32VEN_F
	BCLR PS_FLAG,#4			;;PS_ON_F

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DRVSON_CLR_PRG:                         ;;
        BTFSS NEW_DEVSON_F              ;;
        BRA DRVSON_CLR_PRG_1            ;;
        INC DRVSON_CLR_TBUF0            ;;
        INC DRVSON_CLR_TBUF1            ;;        
        INC DRVSON_CLR_TBUF2            ;;
        INC DRVSON_CLR_TBUF3            ;;
        INC DRVSON_CLR_TBUF4            ;;
        INC DRVSON_CLR_TBUF5            ;;        
        INC DRVSON_CLR_TBUF6            ;;
        INC DRVSON_CLR_TBUF7            ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #SLOTINF_BUF+14,W1          ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF0             ;;                    
        BRA LTU,$+4                     ;;        
        BCLR [W1],#0                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        MOV #20,W0                      ;;
        ADD W0,W1,W1                    ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF1             ;;        
        BRA LTU,$+4                     ;;
        BCLR [W1],#0                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #20,W0                      ;;        
        ADD W0,W1,W1                    ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF2             ;;         
        BRA LTU,$+4                     ;;
        BCLR [W1],#0                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        MOV #20,W0                      ;;
        ADD W0,W1,W1                    ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF3             ;;
        BRA LTU,$+4                     ;;
        BCLR [W1],#0                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #SLOTINF_BUF,W1             ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF4             ;;                    
        BRA LTU,$+4                     ;;        
        CLR [W1]                        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        MOV #20,W0                      ;;
        ADD W0,W1,W1                    ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF5             ;;        
        BRA LTU,$+4                     ;;
        CLR [W1]                        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #20,W0                      ;;        
        ADD W0,W1,W1                    ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF6             ;;         
        BRA LTU,$+4                     ;;
        CLR [W1]                        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        MOV #20,W0                      ;;
        ADD W0,W1,W1                    ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF7             ;;
        BRA LTU,$+4                     ;;
        CLR [W1]                        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DRVSON_CLR_PRG_1:                       ;;
        MOV #SLOTINF_BUF,W1             ;;
        INC DRVSON_CLR_TBUF0            ;;
        INC DRVSON_CLR_TBUF1            ;;        
        INC DRVSON_CLR_TBUF2            ;;
        INC DRVSON_CLR_TBUF3            ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF0             ;;        
        BRA LTU,$+4                     ;;        
        BCLR [W1],#0                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #20,W0                      ;;
        ADD W0,W1,W1                    ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF1             ;;        
        BRA LTU,$+4                     ;;
        BCLR [W1],#0                    ;;        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #20,W0                      ;;
        ADD W0,W1,W1                    ;;        
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF2             ;;        
        BRA LTU,$+4                     ;;
        BCLR [W1],#0                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #20,W0                      ;;
        ADD W0,W1,W1                    ;;
        MOV #30,W0                      ;;
        CP DRVSON_CLR_TBUF3             ;;
        BRA LTU,$+4                     ;;
        BCLR [W1],#0                    ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DEBUG_PRG:
        INC DEBUG_CNT
        MOV #100,W0
        CP DEBUG_CNT
        BRA LTU,$+4
        CLR DEBUG_CNT
        RETURN

;$1 DRV
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:	                                ;;
        CALL INIT_RAM   		;;
        CALL INIT_SIO_SSPA_DRIVER       ;;        
        CALL INIT_UART2_460800          ;;
	BSF U1RX_EN_F			;;
	BSF U2RX_EN_F			;;
        MOVLF #2,SLOT_STATUS            ;;
        CLR SLOT_TEST_STATUS            ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
        CLRWDT                          ;;
        BCF NEW_DEVSON_F
        BTFSS SWS0_I
        BSF NEW_DEVSON_F
        

	BTFSC T128M_F			;;
	TG TP1_O			;;
	CLRWDT				;;
        BTFSC T16M_F                    ;;
        CALL DRVSON_CLR_PRG             ;;

	BTFSC T128M_F			;;
        CALL DEBUG_PRG

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL CHK_U1RX			;;
        CALL CHK_U1TX_END               ;;
        ;=================================
        CALL U2TX_PRG                   ;;
        CALL CHK_U2TX_END               ;;
	CALL CHK_U2RX			;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_PRG:                               ;;
        BTFSC U2TXON_F                  ;;
        RETURN
        MOV TMR2,W0                     ;;
        SUB U2TX_REPEAT_TIM,WREG        ;;
        BTSS W0,#15                     ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #SON_DEVICE_ID_K,W0         ;;
	MOV W0,TX_DEVICE_ID             ;;
        MOV SON_SERIAL_ID,W0            ;;        
        DEC W0,W0
	MOV W0,TX_SERIAL_ID             ;;
        MOV #0xAB00,W0                  ;;
	MOV W0,TX_GROUP_ID              ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CP0 SON_SERIAL_ID               ;;
        BRA NZ,GET_SON_INF              ;;
SON_CMD:                                ;;
	MOVFF RS485_CMD,UTX_CMD         ;;
	MOVFF RS485_CMD_PARA0,UTX_PARA0 ;;
	MOVFF RS485_CMD_PARA1,UTX_PARA1 ;;
	MOVFF RS485_CMD_PARA2,UTX_PARA2 ;;
	MOVFF RS485_CMD_PARA3,UTX_PARA3 ;;
        CLR UTX_BUFFER_LEN              ;;        
        BRA U2TX_PRG_1                  ;;
GET_SON_INF:
	MOV #0x1000,W0                  ;;
	MOV W0,UTX_CMD                  ;;
        CLR UTX_PARA0           
        CLR UTX_PARA1           
        CLR UTX_PARA2           
        CLR UTX_PARA3           
        CLR UTX_BUFFER_LEN              ;;        
U2TX_PRG_1:                              ;;
        CLR RS485_CMD                   ;;
        CLR RS485_CMD_PARA0             ;;
        CLR RS485_CMD_PARA1             ;;
        CLR RS485_CMD_PARA2             ;;
        CLR RS485_CMD_PARA3             ;;
	BSF U1U2_F                      ;;
	CALL UTX_STD                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC SON_SERIAL_ID               ;;
        MOV #9,W0                       ;;
        CP SON_SERIAL_ID                ;;
        BRA GEU,$+4                     ;;
        RETURN                          ;;
        MOVLF #1,SON_SERIAL_ID          ;;
	RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







.ENDIF


















	











	

















;;from fpga
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX:				;;
	BTFSC U1RX_PACKA_F		;;	
	BRA CHK_U1RX_A			;;
	BTFSC U1RX_PACKB_F		;;	
	BRA CHK_U1RX_B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX_A:				;;
	BCF U1RX_PACKA_F		;;
	MOV U1RXA_LEN,W0		;;
	MOV W0,U1RX_LEN			;;
	MOV #U1RX_BUFA,W1		;;
	BRA CHK_U1RX_1			;;
CHK_U1RX_B:				;;
	BCF U1RX_PACKB_F		;;			
	MOV U1RXB_LEN,W0		;;
	MOV W0,U1RX_LEN			;;
	MOV #U1RX_BUFB,W1		;;
	BRA CHK_U1RX_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX_1:				;;
	MOV W1,RX_ADDR			;;
	MOV [W1++],W0			;;
	MOV W0,RX_DEVICE_ID		;;
	MOV #DEVICE_ID_K,W2	        ;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_2		;;
	RETURN				;;
CHK_U1RX_2:				;;
	MOV [W1++],W0			;;
	MOV W0,RX_SERIAL_ID		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV MY_SLOT_ID,W2               ;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_3		;;
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_3		;;
	RETURN				;;
CHK_U1RX_3:				;;
	MOV [W1++],W0			;;
	MOV W0,RX_GROUP_ID		;;
        SWAP W0                         ;;
        AND #255,W0                     ;;
        CP W0,#0xAB                     ;;        
        BRA Z,$+4                       ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,RX_LEN			;;
	MOV [W1++],W0			;;
	MOV W0,RX_CMD			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA0			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA1			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA2			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA3			;;
        MOVFF RX_PARA0,SYS_STATUS_0L    ;;
        MOVFF RX_PARA1,SYS_STATUS_0H    ;;
        MOVFF RX_PARA2,SYS_STATUS_1L    ;;
        MOVFF RX_PARA3,SYS_STATUS_1H    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,SYS_FLAG_0L    	        ;;
	MOV [W1++],W0			;;
	MOV W0,SYS_FLAG_0H    	        ;;
	MOV [W1++],W0			;;
	MOV W0,SYS_FLAG_1L    	        ;;
	MOV [W1++],W0			;;
	MOV W0,SYS_FLAG_1H    	        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
        PUSH W0                         ;;
        AND #255,W0                     ;;
        MOV W0,WG_FREQ_CH               ;;
        POP W0                          ;;
        SWAP W0                         ;;
        AND #255,W0                     ;;
        MOV W0,ATTENUATE                ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
        MOV W0,IOOUT_FLAG               ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
        PUSH W0                         ;;
        AND #255,W0                     ;;
        MOV W0,RFTXCHA0                 ;;
        POP W0                          ;;
        SWAP W0                         ;; 
        AND #255,W0                     ;;
        MOV W0,RFTXCHA1                 ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
        PUSH W0                         ;;
        AND #255,W0                     ;;
        MOV W0,RFRXCHA0                 ;;
        POP W0                          ;;
        SWAP W0                         ;; 
        AND #255,W0                     ;;
        MOV W0,RFRXCHA1                 ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RX_CMD,W0			;;	
	SWAP W0				;;
	AND #255,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x00			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_SYSTEM_ACT		;;
	CP W0,#0x10			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_SLOT_ACT		;;
	CP W0,#0x20			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_CMD_ACT		;;
	RETURN				;;
        RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_SLOT_ACT:			;;
        BSF CONN485_F                   ;;
        CLR CONN485_TIM                 ;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	CP W0,#1			;;
	BRA LTU,$+4			;;
	RETURN				;;
	BRA W0				;;
	BRA U1RX_SLOT_00J		;;RETURN SLOT INF
        RETURN                          ;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_SLOT_00J:				;;
        CLR MY_ITEM_ID                  ;;        
        BTFSC SWS4_I                    ;;        
        BSET MY_ITEM_ID,#0              ;;
        BTFSC SWS5_I                    ;;
        BSET MY_ITEM_ID,#1              ;;
        BTFSC SWS6_I                    ;;
        BSET MY_ITEM_ID,#2              ;;
        BTFSC SWS7_I                    ;;
        BSET MY_ITEM_ID,#3              ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #DEVICE_ID_K,W0             ;;
	MOV W0,TX_DEVICE_ID             ;;
        MOV MY_SLOT_ID,W0               ;;      
	MOV W0,TX_SERIAL_ID             ;;
        MOV #0xAC00,W0                  ;;
	MOV W0,TX_GROUP_ID              ;;
	MOV #0x1000,W0                  ;;
	MOV W0,UTX_CMD                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV MY_TYPE_ID,W2               ;;
        MOV MY_ITEM_ID,W0               ;;
        SL W0,#4,W0                     ;;
        IOR W0,W2,W2                    ;;
        MOV SLOT_STATUS,W0              ;;
        SL W0,#8,W0                     ;;
        IOR W0,W2,W2                    ;;
        MOV SLOT_TEST_STATUS,W0         ;;
        SL W0,#10,W0                    ;;
        IOR W0,W2,W2                    ;;
	MOV W2,W0                       ;;
	MOV W0,UTX_PARA0                ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV MY_TYPE_ID,W0               ;;
        CP W0,#6                        ;;
        BRA Z,RET_RF_SLOT               ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CP W0,#8                        ;;
        BRA Z,RET_SSPADRV_SLOT          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CP W0,#3                        ;;
        BRA Z,RET_IO_SLOT               ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA1                ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA2                ;;        
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA3                ;;
        CLR UTX_BUFFER_LEN              ;;        
	BCF U1U2_F                      ;;
	CALL UTX_STD                    ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
RET_SSPADRV_SLOT:                       ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA1                ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA2                ;;        
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA3                ;;
        MOVLF #40,UTX_BUFFER_LEN        ;;        
        MOV #SLOTINF_BUF,W3             ;;
	BCF U1U2_F                      ;;
	CALL UTX_STD                    ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RET_RF_SLOT:                            ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA1                ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA2                ;;
        MOV #GPS_DATA_BUF,W3            ;;
        MOV GPS_DATA_LEN,W0             ;;
        LSR W0,#1,W0                    ;;
        MOV W0,UTX_PARA3                ;;        
        MOV W0,UTX_BUFFER_LEN           ;;
	BCF U1U2_F                      ;;
	CALL UTX_STD                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV RFTXCHA0,W0                 ;;
        CP RFA_CH                       ;;
        BRA NZ,RET_RF_SLOT_1            ;;
        MOV RFRXCHA0,W0                 ;;
        CP RFB_CH                       ;;
        BRA NZ,RET_RF_SLOT_1            ;;
        RETURN                          ;;
RET_RF_SLOT_1:                          ;;
        MOV RFTXCHA0,W0                 ;;
        MOV W0,RFA_CH                   ;;
        MOV RFRXCHA0,W0                 ;;
        MOV W0,RFB_CH                   ;;
        .IFDEF JS203_39A_M01_01
        CALL SET_RF                     ;;
        .ENDIF
        RETURN                          ;;
;;========================================
RET_IO_SLOT:                            ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA1                ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA2                ;;        
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA3                ;;
        MOVLF #6,UTX_BUFFER_LEN         ;;        
        MOV #ADI0BUF,W3                 ;;
	BCF U1U2_F                      ;;
	CALL UTX_STD                    ;;
        RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CMD_ACT:			        ;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	CP W0,#11			;;
	BRA LTU,$+4			;;
	RETURN				;;
	BRA W0				;;
	BRA U1RX_CMD_00J		;;SSPA POWER ON
	BRA U1RX_CMD_01J		;;SSPA POWER OFF
	BRA U1RX_CMD_02J		;;SSPA MODULE ON
	BRA U1RX_CMD_03J		;;SSPA MOUDLE OFF
	BRA U1RX_CMD_04J		;;LOCAL PULSE ON
	BRA U1RX_CMD_05J		;;LOCAL PULSE OFF
	BRA U1RX_CMD_06J		;;EMERGENCY ON
	BRA U1RX_CMD_07J		;;EMERGENCY OFF
	BRA U1RX_CMD_08J		;;selfTestStartAll
	BRA U1RX_CMD_09J		;;selfTestStopAll
	BRA U1RX_CMD_0AJ		;;selfTestStopAll
        RETURN                          ;;        
U1RX_CMD_00J:				;;
U1RX_CMD_01J:				;;
U1RX_CMD_02J:				;;
U1RX_CMD_03J:				;;
        .IFDEF JS203_39A_F01_02         ;;
        MOVFF RX_CMD,RS485_CMD          ;;
        CALL GET_ACT_BIT                ;;
        CLR RS485_CMD_PARA1             ;;
        CLR RS485_CMD_PARA2             ;;
        MOVFF RX_PARA3,RS485_CMD_PARA3  ;;
        CLR SON_SERIAL_ID               ;;
        .ENDIF                          ;;
        RETURN                          ;;
U1RX_CMD_04J:				;;
U1RX_CMD_05J:				;;
U1RX_CMD_06J:				;;
U1RX_CMD_07J:				;;
        .IFDEF JS203_39A_F01_02         ;;
        MOVFF RX_CMD,RS485_CMD          ;;
        MOVFF RX_PARA0,RS485_CMD_PARA0  ;;
        MOVFF RX_PARA1,RS485_CMD_PARA1  ;;
        MOVFF RX_PARA2,RS485_CMD_PARA2  ;;
        MOVFF RX_PARA3,RS485_CMD_PARA3  ;;
        CLR SON_SERIAL_ID               ;;
        .ENDIF
        RETURN                          ;;
;;========================================
U1RX_CMD_08J:				;;
        MOVLF #1,SLOT_TEST_STATUS       ;;
        RETURN
U1RX_CMD_09J:				;;
        MOVLF #0,SLOT_TEST_STATUS       ;;
        RETURN
U1RX_CMD_0AJ:				;;
        MOV MY_SLOT_ID,W0               ;;
        CP RX_PARA0
        BRA Z,$+4
        RETURN
        MOVLF #2,SLOT_TEST_STATUS       ;;
        CLR SLOT_TEST_TIM
        RETURN





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_ACT_BIT:                            ;;
        MOV MY_ITEM_ID,W0               ;;
        SL W0,#2,W0                     ;;
        DEC2 W0,W0                      ;;
        CP0 MY_ITEM_ID                  ;;
        BRA NZ,$+4                      ;;
        CLR W0                          ;;
        MOV W0,R0                       ;;START_BIT
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR RS485_CMD_PARA0             ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        CLR R2                          ;;
GET_ACT_BIT_1:				;;
        MOV #RX_PARA0,W1                ;;
        MOV R0,W0                       ;;        
        CALL CHK_BIT_ON                 ;;
        INC R0                          ;;
        BTFSC YES_F                      ;;
        MOV #1,W0                       ;;
        MOV R2,W2                       ;;
        SL W0,W2,W0                     ;;
        IOR RS485_CMD_PARA0             ;;
        INC R2                          ;;
        MOV #4,W0                       ;;
        CP R2                           ;;
        BRA LTU,GET_ACT_BIT_1           ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


CHK_BIT_ON:
        BCF YES_F
        PUSH W0 
        MOV #1,W2
        AND #15,W0
        SL W2,W0,W2
        POP W0
        ASR W0,#4,W0
        ADD W0,W1,W1
        ADD W0,W1,W1
        MOV [W1],W0 
        AND W0,W2,W0
        BRA Z,$+4
        BSF YES_F
        RETURN


/*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_MAIN_ACT:			;;	
	MOV RX_CMD,W0			;;
	AND #3,W0			;;
	BRA W0				;;
	BRA MAIN_ACT_J0			;;
	BRA MAIN_ACT_J1			;;
	BRA MAIN_ACT_J2			;;
	BRA MAIN_ACT_J3			;;
MAIN_ACT_J0:				;;
	MOV #3,W0			;;
	AND RX_SERIAL_ID		;;
	MOV #32,W0			;;
	CP URX_PARA3			;;PARA WORD LEN
	BRA LTU,$+4			;;	
	RETURN				;;
	MOVFF URX_PARA3,MONI_DATA_LEN	;;
	MOV #64,W0			;;
	MUL RX_SERIAL_ID		;;	
	MOV #SSPA_DATA_BUF,W1		;;
	ADD W2,W1,W1			;;
	MOV URX_BUF_ADR,W3		;;	
MAIN_ACT_J0_1:				;;
	CP0 URX_PARA3			;;
	BRA Z,MAIN_ACT_J0_2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W3++],W0			;;sspa_rfout
	MOV W0,[W1++]			;;
	DEC URX_PARA3			;;
	BRA MAIN_ACT_J0_1		;;	
MAIN_ACT_J0_2:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_SYSTEM_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #15,W0			;;
	BRA W0				;;
	BRA URXDEC_I_HAVE_REC		;;0
	BRA URXDEC_I_AM_BUZY		;;1
	BRA URXDEC_I_AM_ERR		;;2
	BRA URXDEC_I_AM_DONE		;;3
	BRA URXDEC_YOU_NEXT		;;4
	BRA URXDEC_YOU_WAIT		;;5
	BRA URXDEC_YOU_STOPALL		;;6
	BRA URXDEC_RXDATA_ERR		;;7
	BRA URXDEC_RESERVE		;;8
	BRA URXDEC_RESERVE		;;9
	BRA URXDEC_RESERVE		;;10
	BRA URXDEC_RESERVE		;;11
	BRA URXDEC_RESERVE		;;12
	BRA URXDEC_TEST_TXPACK		;;13
	BRA URXDEC_NODATA_TO_TX		;;14
	BRA URXDEC_TXDATA_OVERFLOW	;;15
URXDEC_RESERVE:				;;
URXDEC_RXDATA_ERR:
URXDEC_TXDATA_OVERFLOW:			;;
	RETURN				;;
URXDEC_NODATA_TO_TX:			;;
	RETURN				;;
URXDEC_I_HAVE_REC:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_I_AM_BUZY:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_I_AM_ERR:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_I_AM_DONE:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_YOU_NEXT:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_YOU_WAIT:			;;
	RETURN				;;
URXDEC_YOU_STOPALL:			;;
	MOV #CMD_STOPALL_K,W0		;;	
	CLR CMDTIME			;;
	MOV W0,CMDINX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TEST_TXPACK:			;;
	DEC RX_LEN			;;
	DEC RX_LEN			;;
	CLR W3				;;
URXDEC_TEST_TXPACK_1:			;;	
	MOV [W1++],W4			;;	
	XOR W4,W3,W0			;;
	AND #255,W0			;;	
	BRA NZ,URXDEC_TEST_TXPACK_2	;;
	INC W3,W3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	SWAP W4				;;
	XOR W4,W3,W0			;;
	AND #255,W0			;;
	BRA NZ,URXDEC_TEST_TXPACK_2	;;
	INC W3,W3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RX_LEN,W0			;;
	CP W3,W0			;;
	BRA LTU,URXDEC_TEST_TXPACK_1	;;
	CALL UTX_I_HAVE_REC		;;				
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TEST_TXPACK_2:			;;
	CALL UTX_RXDATA_ERR		;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_EMURX_ACT:			;;
	DEC RX_LEN			;;
	DEC RX_LEN			;;
	MOV W1,RX_ADDR			;;
	MOV #0x5000,W0			;;
	CP RX_CMD			;;
	BRA Z,URXDEC_EMURX_ACT_0J	;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_EMURX_ACT_0J:			;;
	MOVLF #4,RX_CH			;;
	CALL DEC_SYSURX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;INPUT RX_LEN,RX_ADDR,RX_CH
;RX_CH=0 RS422 CH1
;RX_CH=1 RS422 CH2
;RX_CH=2 USB232 
;RX_CH=4 SYSURX


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX:				;;
	BTFSC U2RX_PACKA_F		;;	
	BRA CHK_U2RX_A			;;
	BTFSC U2RX_PACKB_F		;;	
	BRA CHK_U2RX_B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX_A:				;;
	BCF U2RX_PACKA_F		;;
	MOV U2RXA_LEN,W0		;;
	MOV W0,U2RX_LEN			;;
	MOV #U2RX_BUFA,W1		;;
	BRA CHK_U2RX_1			;;
CHK_U2RX_B:				;;
	BCF U2RX_PACKB_F		;;			
	MOV U2RXB_LEN,W0		;;
	MOV W0,U2RX_LEN			;;
	MOV #U2RX_BUFB,W1		;;
	BRA CHK_U2RX_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX_1:				;;
	MOV W1,RX_ADDR			;;
	MOV [W1++],W0			;;
	MOV W0,RX_DEVICE_ID		;;
	MOV [W1++],W0			;;
	MOV W0,RX_SERIAL_ID		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SON_DEVICE_ID_K,W0	        ;;	
	CP RX_DEVICE_ID		        ;;
	BRA Z,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #8,W0                       ;;
        CP RX_SERIAL_ID	        	;;
        BRA LTU,$+4                     ;;
        RETURN                          ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,RX_GROUP_ID		;;
        MOV #0XAC00,W0                  ;;
        CP RX_GROUP_ID                  ;;
        BRA Z,$+4                       ;;
        RETURN                          ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,RX_LEN			;;
	MOV [W1++],W0			;;
	MOV W0,RX_CMD			;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA0		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA1		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA2		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA3		;;
	MOV RX_CMD,W0			;;
	SWAP W0				;;
	AND #255,W0			;;
	CP W0,#0x10			;;
	BRA NZ,$+6			;;
	GOTO DECU2RX_10XX		;;
	RETURN				;;
CHK_U2RX_END:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU2RX_10XX:				;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	CP W0,#1			;;
	BRA LTU,$+4			;;
	RETURN				;;
	BRA W0				;;
	BRA DECU2RX_1000J		;;BROADCAST ALL SLOT INF AND GET SLOT_INF 
	BRA DECU2RX_1001J		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/*                                      ;;
	MOV PS_FLAG,W0			;;
	MOV V50VADI,W0			;;
	MOV I50VADI,W0			;;
	MOV T50VADI,W0			;;
	MOV V32VADI,W0			;;
	MOV I32VADI,W0			;;
	MOV T32VADI,W0			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SSPA_FLAG,W0		;;
	MOV SSPA_RFOP,W0		;;
	MOV SSPA_TEMP,W0		;;
*/                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU2RX_1000J:				;;
        BTFSS NEW_DEVSON_F              ;;
        BRA DECU2RX_1000J_OLD           ;;
        MOVFF RX_SERIAL_ID,R0           ;;        
        BCLR R0,#2                      ;;
        MOV #20,W0                      ;;
        MUL R0                          ;;                      
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
        MOV #SLOTINF_BUF,W3             ;;
        ADD W2,W3,W3                    ;;
        BTSS RX_SERIAL_ID,#2            ;;
        ADD #14,W3                      ;;
        BTSS RX_SERIAL_ID,#2            ;;
        ADD #14,W1                      ;;
        MOV #7,W2                       ;;
        BTSS RX_SERIAL_ID,#2            ;;       
        MOV #3,W2                       ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU2RX_1000J_1:                        ;;
	MOV [W1++],W0			;;
        MOV W0,[W3++]                   ;;
        DEC W2,W2                       ;;
        BRA NZ,DECU2RX_1000J_1          ;;
        MOV #DRVSON_CLR_TBUF0,W1        ;;        
        MOV RX_SERIAL_ID,W0             ;;
        ADD W0,W1,W1                    ;;
        ADD W0,W1,W1                    ;;
        CLR [W1]                        ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;%2					
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU2RX_1000J_OLD:			;;
        MOV #20,W0                      ;;
        MUL RX_SERIAL_ID                ;;                      
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #SLOTINF_BUF,W3             ;;
        ADD W2,W3,W3                    ;;
        MOV #10,W2                      ;;
DECU2RX_1000J_OLD_1:                    ;;
	MOV [W1++],W0			;;
        MOV W0,[W3++]                   ;;
        DEC W2,W2                       ;;
        BRA NZ,DECU2RX_1000J_OLD_1      ;;
        MOV #DRVSON_CLR_TBUF0,W1        ;;        
        MOV RX_SERIAL_ID,W0             ;;
        ADD W0,W1,W1                    ;;
        ADD W0,W1,W1                    ;;
        CLR [W1]                        ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU2RX_1001J:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

COMBIW3:
        AND #15,W2
        SL W2,#12,W2
        IOR W0,W2,W0
        MOV W0,[W3++]
        










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU2RX:				;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU1RX:				;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_WFLASH_10:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_WFLASH_11:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_WFLASH_12:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_WFLASH_13:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









	

SPIOUT:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_RECOK:				;;
	MOV RX_CMD,W0			;;
	BSET RX_CMD,#15			;;
	MOV W0,UTX_CMD			;;
	CLR UTX_PARA0			;;
	CLR UTX_PARA1			;;
	CLR UTX_PARA2			;;
	CLR UTX_PARA3			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_HAVE_REC:				;;
	MOV #0x0000,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_BUZY:				;;
	MOV #0x0001,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_ERR:				;;
	MOV #0x0002,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_DONE:				;;
	MOV #0x0003,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_YOU_NEXT:				;;
	MOV #0x0004,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_YOU_WAIT:				;;
	MOV #0x0005,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
UTX_YOU_STOPALL:			;;
	MOV #0x0006,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_RXDATA_ERR:				;;
	MOV #0x0007,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




GET_W3_BYTE:
	BTSC W3,#0
	BRA GET_W3_BYTE_1
	MOV [W3],W0
	AND #255,W0	
	INC W3,W3		
	RETURN
GET_W3_BYTE_1:
	BCLR W3,#0
	MOV [W3],W0
	SWAP W0
	AND #255,W0	
	INC2 W3,W3
	RETURN
	






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UTX_WORD:				;;
	PUSH W0				;;
	AND #255,W0			;;
	CALL LOAD_UTX_BYTE		;;	
	POP W0				;;
	SWAP W0				;;	
	AND #255,W0			;;
	CALL LOAD_UTX_BYTE		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;%1
;0xEA,(TARGET DEVICE ID:2B),(TARGET SERIAL ID:2B),
;(FLAG:2B),(PAYLOAD LEN:2B)(PAYLOAD:XB),CHKSUM0,CHKSUM1,0xEB
;PAYLOAD:(CMD:2B,DATA..........)
;CHKSUM0:XOR INIT=0XAB
;CHKSUM1:ADD INIT=0X00


;UTX_BUFFER_LEN				;;
;W3 BUFFER ADDRESS			;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_STD:				;;
	CALL UTX_START			;;
	MOV TX_DEVICE_ID,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TX_SERIAL_ID,W0		;;SERIAL ID
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TX_GROUP_ID,W0		;;SERIAL ID
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0			;;LEN LOW BYTE
	ADD UTX_BUFFER_LEN,WREG		;;
	ADD UTX_BUFFER_LEN,WREG		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_CMD,W0			;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA0,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA1,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA2,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA3,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_STD_1:				;;
	CP0 UTX_BUFFER_LEN		;;	
	BRA Z,UTX_STD_2			;;
	MOV [W3++],W0			;;
	CALL LOAD_UTX_WORD		;;
	DEC UTX_BUFFER_LEN		;;
	BRA UTX_STD_1			;;
UTX_STD_2:				;;
	CALL UTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_START:				;;
	CLR UTX_BTX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	MOV W0,UTX_CHKSUM0		;;
	CLR UTX_CHKSUM1			;;
	MOV #U1TX_BUF,W1		;;
	BTFSC U1U2_F    		;;
	MOV #U2TX_BUF,W1		;;
	MOV #0xEA,W0			;;
	CALL LOAD_UBYTE_A		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UTX_BYTE:				;;
	XOR UTX_CHKSUM0			;;
	ADD UTX_CHKSUM1			;;
	CALL LOAD_UBYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_END:				;;
	MOV UTX_CHKSUM0,W0		;;
	CALL LOAD_UBYTE_B		;;
	MOV UTX_CHKSUM1,W0		;;
	CALL LOAD_UBYTE_B		;;
	MOV #0xEB,W0			;;
	CALL LOAD_UBYTE_A		;;
        BTFSS U1U2_F                    ;;
	BRA U1TX_END			;;
	BRA U2TX_END			;;
U1TX_END:				;;
	BSF U1TX_EN_F			;;
	BCF U1RX_EN_F			;;
	BSF RS485_DE_O	        	;;
        BSF U1TXON_F                    ;;
	BCF U1TX_END_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF UTX_BTX,U1TX_BTX		;;
	CLR U1TX_BCNT			;;
	BSET IFS0,#U1TXIF		;;
	RETURN				;;
U2TX_END:				;;
	BSF U2TX_EN_F			;;
	BCF U2RX_EN_F			;;
	BSF RS485EX_DE_O		;;
        BSF U2TXON_F                    ;;
	BCF U2TX_END_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF UTX_BTX,U2TX_BTX		;;
	CLR U2TX_BCNT			;;
	BSET IFS1,#U2TXIF		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UBYTE_A:				;;
	AND #255,W0			;;
	BTSC UTX_BTX,#0			;;
	BRA LOAD_UBYTE_A1		;;
	MOV W0,[W1]			;;
	INC UTX_BTX			;;
	RETURN
LOAD_UBYTE_A1:				;;
	SWAP W0				;;
	ADD W0,[W1],[W1]		;;
	INC2 W1,W1			;;
	INC UTX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UBYTE_B:				;;
	PUSH W2				;;
	AND #255,W0			;;
	MOV #0xEA,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_UBYTE_B1		;;	
	MOV #0xEB,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_UBYTE_B1		;;	
	MOV #0xEC,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_UBYTE_B1		;;
	POP W2				;;
	BRA LOAD_UBYTE_A		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UBYTE_B1:				;;
	PUSH W0				;;
	MOV #0xEC,W0			;;
	CALL LOAD_UBYTE_A		;;
	MOV #0xAB,W2			;;
	POP W0				;;
	XOR W2,W0,W0			;;
	CALL LOAD_UBYTE_A		;;
	POP W2				;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANS:				;;
	BTSC W0,#3			;;
	BRA BIT_TRANS_1			;;
BIT_TRANS_0:				;;
	AND #7,W0			;;
	BRA W0 				;;
	RETLW #0x0001,W0		;;
	RETLW #0x0002,W0		;;	
	RETLW #0x0004,W0		;;
	RETLW #0x0008,W0		;;
	RETLW #0x0010,W0		;;
	RETLW #0x0020,W0		;;
	RETLW #0x0040,W0		;;
	RETLW #0x0080,W0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANS_1:				;;
        CALL BIT_TRANS_0		;;
	SWAP W0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANSO:				;;
	BTSC W0,#3			;;
	BRA BIT_TRANS_1			;;
BIT_TRANSO_0:				;;
	AND #7,W0			;;
	BRA W0 				;;
	RETLW #0x0080,W0		;;
	RETLW #0x0040,W0		;;
	RETLW #0x0020,W0		;;
	RETLW #0x0010,W0		;;	
	RETLW #0x0008,W0		;;
	RETLW #0x0004,W0		;;
	RETLW #0x0002,W0		;;
	RETLW #0x0001,W0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANSO_1:				;;
	CALL BIT_TRANSO_0		;;
	SWAP W0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__INT1Interrupt:			;;
	PUSH SR
	PUSH W0
	BCLR IFS1,#INT1IF		;;
INT1I_END:				;;
	POP W0
	POP SR
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__INT2Interrupt:			;;
	BCLR IFS1,#INT1IF		;;	 
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1RXInterrupt:			;;
	PUSH SR				;;
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS0,#U1RXIF		;;
	MOV U1RXREG,W1			;;
	AND #255,W1			;;
	BTFSS U1RX_EN_F			;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xEA,W0			;;
	CP W0,W1			;;
	BRA Z,U1RXI_PS			;;	
	MOV #0xEB,W0			;;
	CP W0,W1			;;
	BRA Z,U1RXI_PE			;;	
	MOV #0xEC,W0			;;
	CP W0,W1			;;
	BRA Z,U1RXI_PT			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;; 
	BTFSC U1RXT_F			;;
	XOR W0,W1,W1			;;
	BCF U1RXT_F			;;
	MOV #U1RX_BUFSIZE,W0		;;
	CP U1RX_BYTE_PTR		;;
	BRA GEU,U1RXI_ERR		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_BUFA,W0		;;
	BTFSC U1RX_BUFAB_F		;;
	MOV #U1RX_BUFB,W0		;;
	ADD U1RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	BTSC U1RX_BYTE_PTR,#0		;;
	BRA U1RXI_1			;;
	MOV W1,[W0]			;;
	BRA U1RXI_2			;;
U1RXI_1:				;;
	SWAP W1				;;
	ADD W1,[W0],[W0]		;;
	SWAP W1				;;
U1RXI_2:				;;
	MOV U1RX_TMP0,W0		;;
	MOV W0,U1RX_TMP1		;;
	MOV W1,W0			;;
	MOV W0,U1RX_TMP0		;;
	MOV W1,W0			;;
	ADD U1RX_ADDSUM			;;	
	XOR U1RX_XORSUM			;;
U1RXI_3:				;;
	INC U1RX_BYTE_PTR		;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_PS:				;;
	BCF U1RXT_F			;;
	CLR U1RX_BYTE_PTR		;;
	CLR U1RX_ADDSUM			;;
	CLR U1RX_XORSUM			;;
	BSF MASTER_U1RX_F		;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_PE:				;;
	BCF U1RXT_F			;;
	MOV #0xAB,W0			;;
	XOR U1RX_XORSUM,WREG		;;	
	XOR U1RX_TMP0,WREG		;;
	BRA NZ,U1RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RX_TMP0,W0		;;
	ADD U1RX_TMP0,WREG		;;
	ADD U1RX_TMP1,WREG		;;
	XOR U1RX_ADDSUM,WREG		;;
	AND #255,W0			;;
	BRA NZ,U1RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RX_BYTE_PTR,W0		;;	
	BTFSS U1RX_BUFAB_F		;;	
	MOV W0,U1RXA_LEN		;;
	BTFSC U1RX_BUFAB_F		;;	
	MOV W0,U1RXB_LEN		;;
	BTFSS U1RX_BUFAB_F		;;	
	BSF U1RX_PACKA_F		;;
	BTFSC U1RX_BUFAB_F		;;	
	BSF U1RX_PACKB_F		;;
	TG U1RX_BUFAB_F			;;	
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_PT:				;;
	BSF U1RXT_F			;;
	BRA U1RXI_END			;;
U1RXI_ERR:				;;	
	NOP				;;
U1RXI_END:				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;	
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1TXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS0,#U1TXIF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTFSS U1TX_EN_F                 ;;
        BRA U1TXI_END                   ;;
	MOV #U1TX_BUF,W1		;;
	MOV U1TX_BCNT,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	MOV [W1],W0			;;
	BTSC U1TX_BCNT,#0		;;
	SWAP W0				;;
	AND #255,W0			;;
	MOV W0,U1TXREG			;;
	INC U1TX_BCNT			;;
	MOV U1TX_BTX,W0			;;
	CP U1TX_BCNT			;;
	BRA LTU,U1TXI_END		;;
        BCF U1TX_EN_F                   ;;
	BSF U1TX_END_F			;;
	BSF U1RX_EN_F			;;
U1TXI_END:				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2TXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2TXIF		;;
        BTFSS U2TX_EN_F                 ;;
        BRA U2TXI_END                   ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2TX_BUF,W1		;;
	MOV U2TX_BCNT,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;; 
	MOV [W1],W0			;;
	BTSC U2TX_BCNT,#0		;;
	SWAP W0				;;
	AND #255,W0			;;
	MOV W0,U2TXREG			;;
	INC U2TX_BCNT			;;
	MOV U2TX_BTX,W0			;;
	CP U2TX_BCNT			;;
	BRA LTU,U2TXI_END		;;
        BCF U2TX_EN_F                   ;;
	BSF U2TX_END_F			;;
	BSF U2RX_EN_F			;;
U2TXI_END:				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


CHK_U1TX_END:
	BTFSS U1TX_END_F
	RETURN
	BTSS U1STA,#8
	RETURN
	BCF U1TX_END_F
	BCF RS485_DE_O
        BCF U1TXON_F                    ;;
	RETURN


CHK_U2TX_END:
	BTFSS U2TX_END_F
	RETURN
	BTSS U2STA,#8
        RETURN
	BCF U2TX_END_F
	BCF RS485EX_DE_O
        BCF U2TXON_F                    ;;
        MOV #500,W0                     ;;
        ADD TMR2,WREG                   ;;
        MOV W0,U2TX_REPEAT_TIM          ;;
	RETURN









		



DLY1000X:
	MOV #1000,W2
DLY1000X_1:
	CLRWDT
	DEC W2,W2
	BRA NZ,DLY1000X_1
	DEC W0,W0
	BRA NZ,DLY1000X
	RETURN



DLYX:
	CLRWDT
	DEC W0,W0
	BRA NZ,DLYX
	RETURN
	
;50MIPS TMR2 UNIT=20*256(DIVIDER)=5.12US
;66MIPS TMR2 UNIT=20*256(DIVIDER)=3.88S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DLYMS:					;;
        MOV #1,W0       		;;
DLYMX:					;;
        PUSH  R0			;;
        PUSH  R1			;;
        MOV W0,R1			;;
DLYMX1:					;;
	MOV TMR2,W0			;;
	MOV W0,R0			;;
	MOV #195,W0			;;50MIPS
	MOV #257,W0			;;66MIPS
	ADD R0				;;
DLYMX2:					;;
	CLRWDT				;;
	MOV R0,W0			;;
	SUB TMR2,WREG			;;
	BTSC W0,#15			;;
	BRA DLYMX2			;;
        DEC R1				;;
        BRA NZ,DLYMX1 			;;
        POP R1				;;
        POP R0				;;
        RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DLYUX:
	REPEAT #14
	NOP
	DEC W0,W0
	BRA NZ,DLYUX
	RETURN 



























	










;$4





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WAIT_FLASH24_READY:				;;
	CLRWDT					;;
	BTSC NVMCON,#15				;;
	BRA WAIT_FLASH24_READY			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	




;EP128 1024 INSTRUCTION,ADRESS+0x800
;DONT USE THE LAST BLOCK,CAUSE THE CONFIGURE BYTES ARE ERASED TOO;










;W2=WFLASH_REGISTER BUFFER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOADLH_FLASH24:				;;
	MOV #0xFA,W0			;;
	MOV W0,TBLPAG			;;
	MOV #0,W1			;; Perform the TBLWT instructions to write the latches; W2 is incremented in the TBLWTH instruction to point to the; next instruction location
	TBLWTL [W2++],[W1]		;;
	TBLWTH [W2++],[W1++]		;;
	TBLWTL [W2++],[W1]		;;
	TBLWTH [W2++],[W1++]		;;
	CLR TBLPAG			;; 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	






/*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LREG_F24SETBUF:					;;
	MOV W1,R5				;;
	CLR R4					;;	
LREG_F24SETBUF_1:				;;
	CLR TBLPAG 				;;
	MOV #tbloffset(FSET_LOC_TBL),W1		;;
	MOV R4,W0				;;
	SL W0,#3,W0				;;
	ADD W0,W1,W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0			;;
	MOV W0,R0				;;
	TBLRDL [W1++],W0			;;
	MOV W0,R1				;;
	TBLRDL [W1++],W0			;;
	MOV W0,R2				;;
	TBLRDL [W1++],W0			;;
	MOV W0,R3				;;
	CP0 R0					;;
	BRA NZ,$+4				;;
	RETURN					;;
	MOV R0,W0				;;
	CP R5					;;
	BRA Z,LREG_F24SETBUF_2			;;
	INC R4					;;
	BRA LREG_F24SETBUF_1			;;
LREG_F24SETBUF_2:				;;
	MOV #F24SET_BUF,W1			;;
	MOV R4,W0				;;
	ADD W0,W1,W1				;;	
	ADD W0,W1,W1				;;	
	MOV R5,W2				;;
	MOV [W2],W0				;;
	MOV W0,[W1]				;;
	RETURN					;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/


;INTPUT W1,REG ADDR
/*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_F24WORD:					;;
	PUSH W1					;;	
	CALL LF24_F24SETBUF			;;
	POP W1					;;
	CALL LREG_F24SETBUF			;;
SAVE_F24EXE:					;;
	CALL VER_F24SET				;;
	BRA NZ,$+4				;;				
	RETURN					;;
	MOV #tbloffset(F24SET_FADR),W1		;;
	CALL ERASE_F24				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #tbloffset(F24SET_FADR),W0		;;
	MOV W0,F24_ADR				;;
	MOV #F24SET_LEN_K,W0			;;	
	MOV W0,F24_LEN				;;
	CALL SAVE_F24				;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/

;W0 LEN
;W1:F24 ADDRESS
;W2:LOAD ADDRESS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_F24:					;;
	CLR TBLPAG 				;;	
	MOV W0,W3 				;;
LOAD_F24_1:					;;
	TBLRDL [W1++],W0			;;
	MOV W0,[W2++]				;;
	DEC W3,W3				;;
	BRA NZ,LOAD_F24_1			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	




;W0 LEN
;W1:F24 ADDRESS
;W2:LOAD ADDRESS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VER_F24:					;;
	CLR TBLPAG 				;;	
	MOV W0,W3 				;;
VER_F24_1:					;;
	TBLRDL [W1++],W0			;;
	XOR W0,[W2++],W0			;;
	BRA Z,$+4				;;
	RETURN					;;
	DEC W3,W3				;;
	BRA NZ,VER_F24_1			;;
	RETURN 					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;W1:F24 ADDRESS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERASE_F24:					;;
	PUSH W1					;;
	BCLR INTCON2,#GIE			;;
	MOV #0,W0				;;0=FRC
	CALL OSC_PRG				;;
	CALL WAIT_FLASH24_READY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0				;;
	MOV W0,NVMADRU				;;
	POP W0					;;
	MOV W0,NVMADRL				;;
	MOV #0x4003,W0 				;;	
	MOV W0,NVMCON 				;;	
	DISI #10				;;
	MOV #0x55,W0				;;				
	MOV W0,NVMKEY 				;;	
	MOV #0xAA,W0 				;;	
	MOV W0,NVMKEY 				;;
	BSET NVMCON,#15 			;;	
	NOP					;;
	NOP 					;;	
	NOP 					;;
	NOP					;;
	NOP					;;
	CALL WAIT_FLASH24_READY			;;
	MOV #0,W0				;;
	MOV W0,NVMCON				;;
	CALL INIT_OSC				;;
	BSET INTCON2,#GIE			;;
 	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_F24:					;;
	BCLR INTCON2,#GIE			;;
	MOV #0,W0				;;0=FRC
	CALL OSC_PRG				;;
	CALL WAIT_FLASH24_READY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W3					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_F24_1:					;;
	MOV #0,W0				;;
	MOV W0,NVMADRU				;;
	MOV F24_ADR,W0
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	MOV W0,NVMADR				;;
	MOV #F24TMP_BUF,W2			;;
	ADD W3,W2,W2				;;
	ADD W3,W2,W2				;;
	ADD W3,W2,W2				;;
	ADD W3,W2,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFA,W0				;;
	MOV W0,TBLPAG				;;
	MOV #0,W1				;; Perform the TBLWT instructions to write the latches; W2 is incremented in the TBLWTH instruction to point to the; next instruction location
	TBLWTL [W2++],[W1]			;;
	TBLWTH W3,[W1++]			;;
	TBLWTL [W2++],[W1]			;;
	TBLWTH W3,[W1++]			;;
	CLR TBLPAG				;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x4001,W0				;;
	MOV W0,NVMCON				;;
	DISI #10				;;
	MOV #0x55,W0				;;				
	MOV W0,NVMKEY 				;;	
	MOV #0xAA,W0 				;;	
	MOV W0,NVMKEY 				;;
	BSET NVMCON,#15 			;;	
	NOP 					;;	
	NOP 					;;
	NOP					;;
	NOP					;;
	NOP					;;
	CALL WAIT_FLASH24_READY			;;
	INC W3,W3				;;
	MOV F24_LEN,W0				;;
	INC W0,W0				;;
	ASR W0,#1,W0 				;;
	CP W3,W0				;;				
	BRA LTU,SAVE_F24_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0				;;
	MOV W0,NVMCON				;;
	CALL INIT_OSC				;;
	BSET INTCON2,#GIE			;;
 	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





GROUP_POS_TBL:
OLED_POS_TBL:
	BRA W0
	RETLW #0x40,W0
	RETLW #0x41,W0
	RETLW #0x42,W0
	RETLW #0x43,W0
	RETLW #0x44,W0
	RETLW #0x45,W0
	RETLW #0x46,W0
	RETLW #0x47,W0
	RETLW #0x48,W0
	RETLW #0x49,W0
	RETLW #0x4A,W0
	RETLW #0x4B,W0
	RETLW #0x4C,W0
	RETLW #0x4D,W0
	RETLW #0x4E,W0
	;
	RETLW #0x4F,W0
	RETLW #0x50,W0
	RETLW #0x51,W0
	RETLW #0x52,W0
	RETLW #0x53,W0
	RETLW #0x54,W0
	RETLW #0x55,W0
	RETLW #0x56,W0
	RETLW #0x57,W0
	RETLW #0x58,W0
	RETLW #0x59,W0
	RETLW #0x5A,W0
	RETLW #0x5B,W0
	;
	RETLW #0x00,W0
	RETLW #0x04,W0
	RETLW #0x08,W0
	RETLW #0x0C,W0
	RETLW #0x10,W0
	RETLW #0x14,W0
	RETLW #0x1C,W0
	RETLW #0x1B,W0
	RETLW #0x20,W0
	RETLW #0x24,W0
	RETLW #0x28,W0
	RETLW #0x2C,W0
	RETLW #0x30,W0
	RETLW #0x34,W0
	RETLW #0x38,W0
	RETLW #0x3C,W0
	;
	RETLW #0x01,W0
	RETLW #0x05,W0
	RETLW #0x09,W0
	RETLW #0x0D,W0
	RETLW #0x11,W0
	RETLW #0x15,W0
	RETLW #0x18,W0
	RETLW #0x1F,W0
	RETLW #0x21,W0
	RETLW #0x25,W0
	RETLW #0x29,W0
	RETLW #0x2D,W0
	RETLW #0x31,W0
	RETLW #0x35,W0
	RETLW #0x39,W0
	RETLW #0x3D,W0
	;
	RETLW #0x02,W0
	RETLW #0x06,W0
	RETLW #0x0A,W0
	RETLW #0x0E,W0
	RETLW #0x12,W0
	RETLW #0x16,W0
	RETLW #0x19,W0
	RETLW #0x1D,W0
	RETLW #0x22,W0
	RETLW #0x26,W0
	RETLW #0x2A,W0
	RETLW #0x2E,W0
	RETLW #0x32,W0
	RETLW #0x36,W0
	RETLW #0x3A,W0
	RETLW #0x3E,W0
	;
	RETLW #0x03,W0
	RETLW #0x07,W0
	RETLW #0x0B,W0
	RETLW #0x0F,W0
	RETLW #0x13,W0
	RETLW #0x17,W0
	RETLW #0x1A,W0
	RETLW #0x1E,W0
	RETLW #0x23,W0
	RETLW #0x27,W0
	RETLW #0x2B,W0
	RETLW #0x2F,W0
	RETLW #0x33,W0
	RETLW #0x37,W0
	RETLW #0x3B,W0
	RETLW #0x3F,W0





.EQU F24SET_LEN_K	,(FSET_LOC_TBL_END-FSET_LOC_TBL)/8
FSET_LOC_TBL:
	;.WORD DALVOL_SET	,0	,0,0	
	;.WORD DARVOL_SET	,1	,0,0
	;.WORD HPLGAIN_SET	,2	,0,0
FSET_LOC_TBL_END:
	.WORD 0		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.ORG (F24SET_FADR-0x204)	;;
F24SET_TBL:				;;
	.WORD 0x1234			;;00	
	.WORD 0x5678			;;01	
	.WORD 0x0000			;;02	
	.WORD 0x0000			;;03	
	.WORD 0x0009			;;04	
	.WORD 0x0001			;;05	
	.WORD 0x0000			;;06
	.WORD 0x0000			;;07
	.WORD 0x0000			;;08
	.WORD 0x0000			;;09
	.WORD 0x0000			;;10
	.WORD 0x0000			;;11
	.WORD 0x0000			;;12
	.WORD 0x0000			;;13
	.WORD 0x0000			;;14
	.WORD 0x0000			;;15
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0000			;;16	
	.WORD 0x0000			;;17	
	.WORD 0x0000			;;18	
	.WORD 0x0000			;;19	
	.WORD 0x0009			;;20	
	.WORD 0x0001			;;21	
	.WORD 0x0000			;;22
	.WORD 0x0000			;;23
	.WORD 0x0000			;;24
	.WORD 0x0000			;;25
	.WORD 0x0000			;;26
	.WORD 0x0000			;;27
	.WORD 0x0000			;;28
	.WORD 0x0000			;;29
	.WORD 0x0000			;;30
	.WORD 0x0000			;;31
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0000			;;32	
	.WORD 0x0000			;;33	
	.WORD 0x0000			;;34	
	.WORD 0x0000			;;35	
	.WORD 0x0009			;;36	
	.WORD 0x0001			;;37	
	.WORD 0x0000			;;38
	.WORD 0x0000			;;39
	.WORD 0x0000			;;40
	.WORD 0x0000			;;41
	.WORD 0x0000			;;42
	.WORD 0x0000			;;43
	.WORD 0x0000			;;44
	.WORD 0x0000			;;45
	.WORD 0x0000			;;46
	.WORD 0x0000			;;47
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0000			;;48	
	.WORD 0x0000			;;49	
	.WORD 0x0000			;;50	
	.WORD 0x0000			;;51	
	.WORD 0x0009			;;52	
	.WORD 0x0001			;;53	
	.WORD 0x0000			;;54
	.WORD 0x0000			;;55
	.WORD 0x0000			;;56
	.WORD 0x0000			;;57
	.WORD 0x0000			;;58
	.WORD 0x0000			;;59
	.WORD 0x0000			;;60
	.WORD 0x0000			;;61
	.WORD 0x0000			;;62
	.WORD 0x0000			;;63
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	.ORG (F24KEY_FADR-0x204)	;;
F24SKEY_TBL:				;;
	.WORD 0x0000			;;0x00
	.WORD 0x0101			;;0x01
	.WORD 0x0202			;;0x02
	.WORD 0x0303			;;0x03
	.WORD 0x1004			;;0x04
	.WORD 0x1105			;;0x05
	.WORD 0x1206			;;0x06
	.WORD 0x1C07			;;0x07
	.WORD 0x1D08			;;0x08
	.WORD 0x1E09			;;0x09
	.WORD 0x1F0A			;;0x0A
	.WORD 0x2C0B			;;0x0B
	.WORD 0x2D0C			;;0x0C
	.WORD 0x2E0D			;;0x0D
	.WORD 0x2F0E			;;0x0E
	.WORD 0x3C0F			;;0x0F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x3D10			;;0x10
	.WORD 0x3E11			;;0x11
	.WORD 0x3D12			;;0x12
	.WORD 0x4C13			;;0x13
	.WORD 0x4D14			;;0x14
	.WORD 0x4E15			;;0x15
	.WORD 0x4F16			;;0x16
	.WORD 0xFF17			;;0x17
	.WORD 0xFF18			;;0x18
	.WORD 0xFF19			;;0x19
	.WORD 0xFF1A			;;0x1A
	.WORD 0xFF1B			;;0x1B
	.WORD 0xFF1C			;;0x1C
	.WORD 0xFF1D			;;0x1D
	.WORD 0xFF1E			;;0x1E
	.WORD 0xFF1F			;;0x1F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0420			;;0x20
	.WORD 0x0521			;;0x21
	.WORD 0x0622			;;0x22
	.WORD 0x0723			;;0x23
	.WORD 0x1324			;;0x24
	.WORD 0x1425			;;0x25
	.WORD 0x1526			;;0x26
	.WORD 0x2027			;;0x27
	.WORD 0x2128			;;0x28
	.WORD 0x2229			;;0x29
	.WORD 0x232A			;;0x2A
	.WORD 0x302B			;;0x2B
	.WORD 0x312C			;;0x2C
	.WORD 0x322D			;;0x2D
	.WORD 0x332E			;;0x2E
	.WORD 0x402F			;;0x2F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x4130			;;0x30
	.WORD 0x4231			;;0x31
	.WORD 0x4332			;;0x32
	.WORD 0x5033			;;0x33
	.WORD 0x5134			;;0x34
	.WORD 0x5235			;;0x35
	.WORD 0x5336			;;0x36
	.WORD 0xFF37			;;0x37
	.WORD 0xFF38			;;0x38
	.WORD 0xFF39			;;0x39
	.WORD 0xFF3A			;;0x3A
	.WORD 0xFF3B			;;0x3B
	.WORD 0xFF3C			;;0x3C
	.WORD 0xFF3D			;;0x3D
	.WORD 0xFF3E			;;0x3E
	.WORD 0xFF3F			;;0x3F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0840			;;0x40
	.WORD 0x0941			;;0x41
	.WORD 0x0A42			;;0x42
	.WORD 0x0B43			;;0x43
	.WORD 0x1644			;;0x44
	.WORD 0x1745			;;0x45
	.WORD 0x1846			;;0x46
	.WORD 0x2447			;;0x47
	.WORD 0x2548			;;0x48
	.WORD 0x2649			;;0x49
	.WORD 0x274A			;;0x4A
	.WORD 0x344B			;;0x4B
	.WORD 0x354C			;;0x4C
	.WORD 0x364D			;;0x4D
	.WORD 0x374E			;;0x4E
	.WORD 0x444F			;;0x4F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x4550			;;0x50
	.WORD 0x4651			;;0x51
	.WORD 0x4752			;;0x52
	.WORD 0x5453			;;0x53
	.WORD 0x5554			;;0x54
	.WORD 0x5655			;;0x55
	.WORD 0x5756			;;0x56
	.WORD 0xFF57			;;0x57
	.WORD 0xFF58			;;0x58
	.WORD 0xFF59			;;0x59
	.WORD 0xFF5A			;;0x5A
	.WORD 0xFF5B			;;0x5B
	.WORD 0xFF5C			;;0x5C
	.WORD 0xFF5D			;;0x5D
	.WORD 0xFF5E			;;0x5E
	.WORD 0xFF5F			;;0x5F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0C60			;;0x60
	.WORD 0x0D61			;;0x61
	.WORD 0x0E62			;;0x62
	.WORD 0x0F63			;;0x63
	.WORD 0x1964			;;0x64
	.WORD 0x1A65			;;0x65
	.WORD 0x1B66			;;0x66
	.WORD 0x2867			;;0x67
	.WORD 0x2968			;;0x68
	.WORD 0x2A69			;;0x69
	.WORD 0x2B6A			;;0x6A
	.WORD 0x386B			;;0x6B
	.WORD 0x396C			;;0x6C
	.WORD 0x3A6D			;;0x6D
	.WORD 0x3B6E			;;0x6E
	.WORD 0x486F			;;0x6F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x4970			;;0x70
	.WORD 0x4A71			;;0x71
	.WORD 0x4B72			;;0x72
	.WORD 0x5873			;;0x73
	.WORD 0x5974			;;0x74
	.WORD 0x5A75			;;0x75
	.WORD 0x5B76			;;0x76
	.WORD 0xFF77			;;0x77
	.WORD 0xFF78			;;0x78
	.WORD 0xFF79			;;0x79
	.WORD 0xFF7A			;;0x7A
	.WORD 0xFF7B			;;0x7B
	.WORD 0xFF7C			;;0x7C
	.WORD 0xFF7D			;;0x7D
	.WORD 0xFF7E			;;0x7E
	.WORD 0xFF7F			;;0x7F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	.ORG (F24TEST_FADR-0x204)	;;
F24TEST_TBL:				;;




