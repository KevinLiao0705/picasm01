;******************************************************************************
;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 


	
 

        .equ __24ep64gp206, 1 ;
        .include "p24ep64gp206.inc"

;BY DEFINE=============================
	.EQU OLED_AMT_K		,92
	.EQU	SLAVE_DK	,1	
	.EQU	DATEST_DK	,1	
	.EQU	KB_PAGE_LK	,3	
	.EQU	KB_TYPE_LK	,3	



;	.EQU	U2TX_TEST_DK	,1	
;	.EQU 	IICM_DK		,1
;	.EQU 	IICS_DK		,1
;====================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'
	.EQU 	DEVICE_ID_K		,0x2300
	.EQU 	SERIAL_ID_K		,0x0000
	.EQU 	WEB_SERVER_DEVICE_ID_K	,0x2303
	.EQU 	TFT_PANEL_DEVICE_ID_K	,0x2304

	.EQU 	F24SET_FADR	,0xA000	;DONT USE THE LAST BLOCK OF FLASH(0x0AF00)
	.EQU 	F24KEY_FADR	,0xA100	;DONT USE THE LAST BLOCK OF FLASH(0x0AF00)
	.EQU 	F24TEST_FADR	,0xA200	;DONT USE THE LAST BLOCK OF FLASH(0x0AF00)
	.EQU 	FRAM_SIZE_K	,256	
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
    	.global __T5Interrupt    
    	.global __INT1Interrupt    
    	.global __INT2Interrupt    
  	.global __U1RXInterrupt    
  	.global __U1TXInterrupt  
  	.global __U2RXInterrupt    
  	.global __U2TXInterrupt  
    	.global __IC1Interrupt    
    	.global __IC2Interrupt    
    	.global __IC3Interrupt    
    	.global __IC4Interrupt    
.MACRO 	LDPTR XX
    	MOV #tbloffset(\XX),W1
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
	


.MACRO 	W_TFTC XX
	MOV #\XX,W0
	CALL WTFTC
.ENDM

.MACRO 	W_TFTD XX
	MOV #\XX,W0
	CALL WTFTD
.ENDM

.MACRO 	W_TFTCD XX,YY
	MOV #\XX,W0
	CALL WTFTC
	MOV #\YY,W0
	CALL WTFTD
.ENDM

.MACRO 	W_TFTDD XX
	MOV #\XX,W0
	SWAP W0
	CALL WTFTD
	MOV #\XX,W0
	CALL WTFTD
.ENDM

.MACRO 	W_TFTDDW
	SWAP W0
	CALL WTFTD
	SWAP W0
	CALL WTFTD
.ENDM

;*************************
.MACRO 	LXY XX,YY
	MOV #\XX,W0
	MOV W0,LCDX
	MOV #\YY,W0
	MOV W0,LCDY
.ENDM
;-------------------------


;*************************
.MACRO 	LW10 XX,YY
	MOV #\XX,W1
	MOV #\YY,W0
.ENDM
;-------------------------


;*************************
.MACRO 	WRFXS XX,YY
	MOV #\XX,W1
	MOV #\YY,W0
	CALL WR_FXSREG		
 .ENDM
;-------------------------

;*************************
.MACRO 	RRFXS XX
	MOV #\XX,W1
	MOV #0x00,W0
	CALL RD_FXSREG		
 .ENDM
;-------------------------


;*************************
.MACRO 	WMFXS XX,YY,ZZ
	MOV #\XX,W1
	MOV #\YY,W0
	MOV W0,R1
	MOV #\ZZ,W0
	MOV W0,R0
	CALL WM_FXS		
 .ENDM

.MACRO 	RMFXS XX
	MOV #\XX,W1
	CALL RM_FXS		
 .ENDM



;*************************
.MACRO 	WAIC XX,YY
	MOV #\XX,W1
	MOV #\YY,W0
	CALL WSPI		
 .ENDM
;-------------------------

;*************************
.MACRO 	RAIC XX
	MOV #\XX,W1
	CALL RSPI		
 .ENDM
;-------------------------

;*************************
.MACRO 	WAICW XX
	MOV #\XX,W1
	CALL WSPI		
 .ENDM
;-------------------------


;-------------------------


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
UTX_MODE:		.SPACE 2		

I2C_DATA0:		.SPACE 2		
I2C_DATA1:		.SPACE 2		
I2C_DATA2:		.SPACE 2		

I2C_DATA0_B:		.SPACE 2		
I2C_DATA1_B:		.SPACE 2		
I2C_DATA2_B:		.SPACE 2		
F24_ADR:		.SPACE 2		
F24_LEN:		.SPACE 2		



SELF_TEST_INX:		.SPACE 2	
KB_TEST_CNT:		.SPACE 2	
DIM_SET:		.SPACE 2	

;;====================================
TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2		
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

SON_ACTION_CNT:		.SPACE 2
S_CMDINX:		.SPACE 2
S_CMDSTEP:		.SPACE 2
S_CMDTIME:		.SPACE 2
S_CMDCNT0:		.SPACE 2
S_CMDCNT1:		.SPACE 2



KB_KEY_CNT:		.SPACE 2
KB_TYPE_CNT:		.SPACE 2
KB_PAGE_CNT:		.SPACE 2
KB_X256_CNT:		.SPACE 2
KB_X256_TH:		.SPACE 2


MCUTX1_DLY_BIT:         .SPACE 2
MCUTX1_DLY_TH:          .SPACE 2

KBMODE_INX:		.SPACE 2
KBMODE_STEP:		.SPACE 2
KBMODE_TIM:		.SPACE 2
;;====================================
NOWKB_INX:		.SPACE 2
IMAGE_PAG:		.SPACE 2
SPEC_KEY_BUF:		.SPACE 32
SON_DEVICE_ID:		.SPACE 2
SON_SERIAL_ID:		.SPACE 2

CONVAD_CNT:		.SPACE 2
VR1BUF:			.SPACE 2
VR1V:			.SPACE 2
DEBUG_CHKSUM0:		.SPACE 2
DEBUG_CHKSUM1:		.SPACE 2
WRITE_KEY_CNT:		.SPACE 2
SETKEY_ID:		.SPACE 2
;;====================================
KEYSCAN_CNT:		.SPACE 2
KEYCODE:		.SPACE 2
KEYDATA0:		.SPACE 2
KEYDATA1:		.SPACE 2
KEYDATA2:		.SPACE 2
KEYDATA3:		.SPACE 2
KEYDATA4:		.SPACE 2
KEYDATA5:		.SPACE 2
KEYDATA6:		.SPACE 2
KEYDATA7:		.SPACE 2

KEY_BUF:		.SPACE 2
KEY_TMP:		.SPACE 2
YESKEY_CNT:		.SPACE 2
NOKEY_CNT:		.SPACE 2
CONKEY_CNT:		.SPACE 2
KEYDB_BUF:		.SPACE 2
KEYDB_CNT:		.SPACE 2
KEYDB_TIM:		.SPACE 2

EMUKR0:			.SPACE 2
EMUKR1:			.SPACE 2
EMUKR2:			.SPACE 2
EMUKR3:			.SPACE 2

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
U2TX_WAKE_TIM:		.SPACE 2
;;====================================
RX_CH:			.SPACE 2
RX_ADDR:		.SPACE 2
RX_FLAGS:		.SPACE 2
RX_LEN:			.SPACE 2
RX_CMD:			.SPACE 2	
RX_PARA0:		.SPACE 2	



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



;;====================================
TESTOLED_CNT:		.SPACE 2
DIM_CNT:		.SPACE 2
COMV_CNT:		.SPACE 2
OLEDCUR_CNT:		.SPACE 2
PRE_OLED_POS:		.SPACE 2
OLED_POS:		.SPACE 2
OLED_INX:		.SPACE 2
OLED_GROUP_INX:		.SPACE 2

LCDX:			.SPACE 2
LCDY:			.SPACE 2
COLOR_B:		.SPACE 2
COLOR_F:		.SPACE 2




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
NOWKEY_STA0:		.SPACE 2
NOWKEY_STA1:		.SPACE 2
NOWKEY_STA2:		.SPACE 2
NOWKEY_STA3:		.SPACE 2

NOWKEY_STA_BUF:		.SPACE 16*OLED_AMT_K
URX_STA_BUF:		.SPACE 2*OLED_AMT_K

URXTMP:			.SPACE 0
UTXTMP:			.SPACE 64
URXTMP_LEN:		.SPACE 2
UTXTMP_LEN:		.SPACE 2


MCUU1_MODE:		.SPACE 2
MCUTX1_TIM:		.SPACE 2
MCUTX1_BYTE:		.SPACE 2
MCUTX1_BYTE_CNT:	.SPACE 2
MCUTX1_BIT_LEN:		.SPACE 2
MCUTX1_BIT_CNT:		.SPACE 2


MCUU2_MODE:		.SPACE 2
MCUTX2_TIM:		.SPACE 2
MCUTX2_BYTE:		.SPACE 2
MCUTX2_BYTE_CNT:	.SPACE 2
MCUTX2_BIT_LEN:		.SPACE 2
MCUTX2_BIT_CNT:		.SPACE 2

MCUU3_MODE:		.SPACE 2
MCUTX3_TIM:		.SPACE 2
MCUTX3_BYTE:		.SPACE 2
MCUTX3_BYTE_CNT:	.SPACE 2
MCUTX3_BIT_LEN:		.SPACE 2
MCUTX3_BIT_CNT:		.SPACE 2

MCUU45_MODE:		.SPACE 2
MCUTX45_TIM:		.SPACE 2
MCUTX4_BYTE:		.SPACE 2
MCUTX4_BYTE_CNT:	.SPACE 2
MCUTX4_BIT_LEN:		.SPACE 2
MCUTX4_BIT_CNT:		.SPACE 2

MCUU2_TX_PERIOD:	.SPACE 2
MCUU3_TX_PERIOD:	.SPACE 2
MCUU45_TX_PERIOD:	.SPACE 2
MCUU1_TX_PERIOD:	.SPACE 2





MCUTX5_BYTE:		.SPACE 2
MCUTX5_BYTE_CNT:	.SPACE 2
MCUTX5_BIT_LEN:		.SPACE 2
MCUTX5_BIT_CNT:		.SPACE 2



MCURX2_CLR_TIM:		.SPACE 2
MCURX2_END_BIT:		.SPACE 2
MCURX2_TIM:		.SPACE 2
MCURX2_IBUF:		.SPACE 2
MCURX2_BIT:		.SPACE 2
MCURX2_PCNT0:		.SPACE 2
MCURX2_PCNT1:		.SPACE 2
MCURX2_END_CNT:		.SPACE 2


MCURX3_CLR_TIM:		.SPACE 2
MCURX3_END_BIT:		.SPACE 2
MCURX3_TIM:		.SPACE 2
MCURX3_IBUF:		.SPACE 2
MCURX3_BIT:		.SPACE 2
MCURX3_PCNT0:		.SPACE 2
MCURX3_PCNT1:		.SPACE 2
MCURX3_END_CNT:		.SPACE 2


MCURX4_CLR_TIM:		.SPACE 2
MCURX4_END_BIT:		.SPACE 2
MCURX4_TIM:		.SPACE 2
MCURX4_IBUF:		.SPACE 2
MCURX4_BIT:		.SPACE 2
MCURX4_PCNT0:		.SPACE 2
MCURX4_PCNT1:		.SPACE 2
MCURX4_END_CNT:		.SPACE 2


MCURX5_CLR_TIM:		.SPACE 2
MCURX5_END_BIT:		.SPACE 2
MCURX5_TIM:		.SPACE 2
MCURX5_IBUF:		.SPACE 2
MCURX5_BIT:		.SPACE 2
MCURX5_PCNT0:		.SPACE 2
MCURX5_PCNT1:		.SPACE 2
MCURX5_END_CNT:		.SPACE 2




MCURX1_CLR_TIM:		.SPACE 2
MCURX1_END_BIT:		.SPACE 2
MCURX1_TIM:		.SPACE 2
MCURX1_IBUF:		.SPACE 2
MCURX1_BIT:		.SPACE 2
MCURX1_PCNT0:		.SPACE 2
MCURX1_PCNT1:		.SPACE 2
MCURX1_END_CNT:		.SPACE 2




;BYTE0-BIT3~0 NOWPAGE
;BYTE0-BIT4~0 LOAD OK
;BYTE4 CHKSUM0
;BYTE5 CHKSUM1
;BYTE6 CHKSUM2
;BYTE7 CHKSUM3
MCUTX4_BUF:		.SPACE 128
MCURX4_BUF:		.SPACE 128
MCUTX1_BUF:		.SPACE 128
MCURX1_BUF:		.SPACE 128
MCUTX5_BUF:		.SPACE 128
MCURX5_BUF:		.SPACE 128


END_REG:		.SPACE 2




.EQU STACK_BUF		,0x1E00	
.EQU KEYTBL_BUF		,0X1F00
.EQU U1RX_BUFSIZE	,640	;
.EQU U1RX_BUFA		,0x2000	;
.EQU U1RX_BUFB		,0x2280	;
.EQU U2RX_BUFSIZE	,256	;
.EQU U2RX_BUFA		,0x2500	;
.EQU U2RX_BUFB		,0x2600	;
.EQU U1TX_BUF		,0x2700	;
.EQU U2TX_BUF		,0x2800	;512
.EQU FLASH_BUF		,0x2A00 ; 
.EQU MCUTX2_BUF		,0x2A00	;128
.EQU MCURX2_BUF		,0x2A80	;128
.EQU MCUTX3_BUF		,0x2B00	;128
.EQU MCURX3_BUF		,0x2C80	;128

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
.EQU U1U2_F		,FLAGA
.EQU U1U2_F_P		,0
.EQU OLEDX12_F		,FLAGA
.EQU OLEDX12_F_P	,1
.EQU OLEDXALL_F		,FLAGA
.EQU OLEDXALL_F_P	,2
.EQU FLASH_AB_F		,FLAGA
.EQU FLASH_AB_F_P	,3
.EQU FLASH_QPI_F	,FLAGA
.EQU FLASH_QPI_F_P	,4
.EQU FLASH_QPI2_F	,FLAGA	
.EQU FLASH_QPI2_F_P	,5
.EQU SET_DIMS_F		,FLAGA
.EQU SET_DIMS_F_P	,6
.EQU KEYCODE_IN_F	,FLAGA
.EQU KEYCODE_IN_F_P	,7
.EQU ERR_F		,FLAGA
.EQU ERR_F_P		,8
.EQU OK_F		,FLAGA
.EQU OK_F_P		,9
.EQU DONE_F		,FLAGA
.EQU DONE_F_P		,10
.EQU FACTORY_TEST_F	,FLAGA
.EQU FACTORY_TEST_F_P	,11
;EQU AICIO_AB_F		,FLAGA
;EQU AICIO_AB_F_P  	,12
.EQU MASTER_U1RX_F	,FLAGA
.EQU MASTER_U1RX_F_P 	,13
.EQU MASTER_U2RX_F	,FLAGA
.EQU MASTER_U2RX_F_P 	,14
.EQU WAIT_DUTX_F	,FLAGA
.EQU WAIT_DUTX_F_P  	,15



;FLAGB
.EQU DISKP_F		,FLAGB
.EQU DISKP_F_P		,0
.EQU NOKEY_F		,FLAGB
.EQU NOKEY_F_P		,1
.EQU DISKR_F		,FLAGB
.EQU DISKR_F_P		,2
.EQU KEY_PUSH_F		,FLAGB
.EQU KEY_PUSH_F_P	,3
.EQU READ_IMAGE_ERR_F	,FLAGB
.EQU READ_IMAGE_ERR_F_P ,4
.EQU SCANKEY_F		,FLAGB
.EQU SCANKEY_F_P	,5
.EQU ONEKEY_F		,FLAGB
.EQU ONEKEY_F_P		,6
.EQU ALLKEY_F		,FLAGB
.EQU ALLKEY_F_P		,7
.EQU CLRSCR_F		,FLAGB
.EQU CLRSCR_F_P		,8
.EQU SET_KEYID_F	,FLAGB
.EQU SET_KEYID_F_P	,9
.EQU U2TX_WAKE_F	,FLAGB
.EQU U2TX_WAKE_F_P	,10
.EQU MCUTX2_START_F	,FLAGB
.EQU MCUTX2_START_F_P	,11
.EQU MCUTX3_START_F	,FLAGB
.EQU MCUTX3_START_F_P	,12
.EQU MCURX2_START_F	,FLAGB
.EQU MCURX2_START_F_P	,13
.EQU MCURX2_RXIN_F	,FLAGB
.EQU MCURX2_RXIN_F_P	,14
.EQU DIS_KFREE_F	,FLAGB
.EQU DIS_KFREE_F_P	,15



;FLAGC
.EQU MCURX3_START_F	,FLAGC
.EQU MCURX3_START_F_P	,0
.EQU MCURX4_START_F	,FLAGC
.EQU MCURX4_START_F_P	,1
.EQU MCURX3_RXIN_F	,FLAGC
.EQU MCURX3_RXIN_F_P	,2
.EQU MCUTX4_START_F	,FLAGC
.EQU MCUTX4_START_F_P	,3
.EQU MCURX4_RXIN_F	,FLAGC
.EQU MCURX4_RXIN_F_P	,4

.EQU MCUTX1_START_F	,FLAGC
.EQU MCUTX1_START_F_P	,5
.EQU MCURX1_START_F	,FLAGC
.EQU MCURX1_START_F_P	,6
.EQU MCURX1_RXIN_F	,FLAGC
.EQU MCURX1_RXIN_F_P	,7

.EQU MCUTX5_START_F	,FLAGC
.EQU MCUTX5_START_F_P	,8
.EQU MCURX5_RXIN_F	,FLAGC
.EQU MCURX5_RXIN_F_P	,9
.EQU MCURX5_START_F	,FLAGC
.EQU MCURX5_START_F_P	,10
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
POWER_ON:			;;
        MOV #STACK_BUF,W15  	;;Initialize the Stack Pointer Limit Register
        MOV #STACK_BUF+254,W0  	;;Initialize the Stack Pointer Limit Register
        MOV W0,SPLIM		;;
        CALL CLR_WREG 		;;
	CALL CLR_ALLREG		;;
	CALL INIT_IO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #20,W1		;;
WAIT_POWER:			;;
	MOV #500,W0		;;
	CALL DLYX		;;
	DEC W1,W1		;;
	BRA NZ,WAIT_POWER	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL CLR_WREG 		;;
	CALL INIT_IO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL INIT_AD		;;
	CALL INIT_RAM		;;
	CALL INIT_SIO		;;
	CALL INIT_OSC		;;
	MOV #10000,W0		;;
	CALL DLYX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_TIMER2	;;
	CALL INIT_UART1		;;
	CALL INIT_UART2		;;
	CALL INIT_INT		;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CALL INIT_TIMER1	;;
	;CALL INIT_TIMER3	;;
	;CALL INIT_TIMER4	;;
	;CALL INIT_IC1		;;
	;CALL INIT_IC2		;;
	;CALL INIT_IC3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLASH_EXITQPI	;;
	CALL FLASH_RESET	;;
	;CALL ENABLE_FLASH_QPI	;;
	;CALL TEST_TIMER	;;
	;CALL TEST_UART1	;;
	;CALL TEST_UART2_I	;;
	;CALL TEST_FLASH_QPI	;;
	;CALL TEST_FLASH		;;
	;CALL TEST_FLASH_PGM	;;
	;CALL TEST_OLED_A	;;
	;CALL TEST_OLED_G	;;
	;CALL TEST_OLED_H	;;
	;CALL START_TEST	;;
	;CALL TEST_PWM
	MOV #5000,W0		;;
	CALL DLY1000X		;;
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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
	TG MCU_TX5_O
	TG MCU_TX4_O
	TG MCU_TX5_O
	TG MCU_TX4_O
	TG MCU_TX5_O
	TG MCU_TX4_O
	TG MCU_TX5_O
	TG MCU_TX4_O
	TG MCU_TX5_O
	TG MCU_TX4_O
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
	BTSS TMR2,#8
	BCF TP1_O
	BTSC TMR2,#8
	BSF TP1_O
	BRA TEST_TIMER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART1:				;;
	MOV #'B',W0			;;
	MOV W0,U1TXREG			;;
	;CALL U1TX_RSP			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART1 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART2:				;;
	BSF RS485CTL_O
	MOV #'B',W0			;;
	MOV W0,U2TXREG			;;
	;CALL U1TX_RSP			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART2 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART2_I:				;;
	BSF U1U2_F			;;
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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	CLR ANSELC			;;
	CLR ANSELE			;;
;        RETURN				;;
;	BSET ANSELE,#12			;;
;	BSET ANSELE,#13			;;
	BSET ANSELE,#14			;;
	MOV #0x0004,W0			;;AUTO SAMPLE	
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON1			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON2			;;
	MOV #0x000F,W0			;;	
	MOV W0,AD1CON3			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON4			;;
	MOV #15,W0			;;	
	MOV W0,AD1CHS0			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CHS123		;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CSSH			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CSSL			;;
	BSET AD1CON1,#ADON		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SWITCH_KB_FLAG:			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR R2				;;
	MOV #R3,W5			;;
LSKF_00:				;;
	MOVLF #0x0040,FADR0		;;
	MOVLF #0x0000,FADR1		;;
	MOV #16,W0			;;
	MUL R2				;;
	MOV W2,W0			;;
	ADD FADR0			;;
	CALL READ_FLASH_16B		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,R0			;;	
	MOV [W1++],W0			;;
	MOV W0,R1			;;	
	MOV [W1++],W0			;;stopbit:parity
	MOV W0,W2			;;
	AND #3,W0			;;
	MOV W0,[W5]			;;	
	BTSC W2,#0			;;
	BSET [W5],#2 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xE100,W0			;;57600
	CP R0				;;
	BRA NZ,$+4			;;
	BSET [W5],#3 			;;
	MOV #0xC200,W0			;;115200
	CP R0				;;	
	BRA NZ,$+4			;;
	BSET [W5],#4 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;action:packageType
	PUSH W0
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,[W5],[W5]		;;
	POP W0
	BTSC W0,#8			;;
	BSET [W5],#5			;;ENABLE BIT
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #MCUU2_TX_PERIOD,W2         ;;
        MOV R2,W0                       ;;
        ADD W0,W2,W2                    ;;
        ADD W0,W2,W2                    ;;
	MOV [W1++],W0			;;TX_PERIOD_BIT
        MOV W0,[W2]                     ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC R2				;;
	INC2 W5,W5                      ;;
	MOV #4,W0			;;
	CP R2				;;
	BRA LTU,LSKF_00			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF R3,MCUU2_MODE		;;rs422_ch1
	MOVFF R4,MCUU3_MODE		;;rs422_ch2
	MOVFF R5,MCUU45_MODE		;;usbcom
	MOVFF R6,MCUU1_MODE		;;rs232
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;BSET MCUU2_MODE,#5		;;<<DEBUG
	;BSET MCUU3_MODE,#5		;;<<DEBUG
	;BSET MCUU45_MODE,#5		;;<<DEBUG
	;BCLR MCUU2_MODE,#0		;;<<DEBUG
	;BCLR MCUU2_MODE,#1		;;<<DEBUG
	;BCLR MCUU3_MODE,#0		;;<<DEBUG
	;BCLR MCUU3_MODE,#1		;;<<DEBUG
	;BCLR MCUU45_MODE,#0		;;<<DEBUG
	;BCLR MCUU45_MODE,#1		;;<<DEBUG
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS MCUU2_MODE,#5		;;enable bit
	BRA LSKF_01			;;
	CALL INIT_TIMER1		;;
	CALL INIT_IC1			;;
LSKF_01:				;;
	BTSS MCUU3_MODE,#5		;;
	BRA LSKF_02			;;
	CALL INIT_TIMER3		;;
	CALL INIT_IC2			;;
LSKF_02:				;;
	BTSS MCUU45_MODE,#5		;;
	BRA LSKF_03			;;
	CALL INIT_TIMER4		;;
	CALL INIT_IC3			;;
	CALL INIT_INT2			;;
LSKF_03:				;;
	BTSS MCUU1_MODE,#5		;;
	BRA LSKF_04			;;
	CALL INIT_TIMER5		;;
	CALL INIT_IC4			;;
LSKF_04:				;;
	MOV #SPEC_KEY_BUF,W1		;;
	MOV #0,W2			;;
	MOV #15,W0			;;
	REPEAT W0			;;
	MOV W2,[W1++]			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR R0				;;
LSKF_0:					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF #0x1040,FADR0		;;
	MOVLF #0x0000,FADR1		;;
	MOV R0,W0			;;
	SL W0,#5,W0			;;
	ADD FADR0			;;
	CALL READ_FLASH_16B		;;
	MOV #FLASH_TMP,W1		;;
	MOV [W1],W0			;;
	AND #255,W0			;;
	BRA Z,LSKF_1			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W0			;;
	MOV #SPEC_KEY_BUF,W1		;;
	MOV R0,W2			;;
	ADD W2,W1,W1                    ;;
        ADD W2,W1,W1                    ;;
	MOV W0,[W1]			;;
LSKF_1:					;;
	INC R0				;;
	MOV #7,W0			;;
	CP R0				;;
	BRA LTU,LSKF_0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF #0x1020,FADR0		;;
	MOVLF #0x0000,FADR1		;;
	CALL READ_FLASH_16B		;;
	MOV #FLASH_TMP+8,W1		;;
	MOV #SPEC_KEY_BUF+14,W3		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W0			;;
        AND #255,W0                     ;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
        SWAP W0                         ;;
        AND #255,W0                     ;;
	MOV W0,[W3++]			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W0			;;
        AND #255,W0                     ;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
        SWAP W0                         ;;
        AND #255,W0                     ;;
	MOV W0,[W3++]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					


INIT_OLED_ALL:
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OLED_RESTART:				;;
        BCF FACTORY_TEST_F              ;;
	CLR KBMODE_INX			;;
	CLR NOWKB_INX			;;
	CALL INIT_OLED_ALL		;;	
	CALL LOAD_SWITCH_KB_FLAG	;;
	CALL LOAD_ALL_KEY_STATUS	;;		
	CALL DISP_ALL_KEY		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CHK_U2TX_END:
	BTFSS RS485CTL_O
	RETURN
	BTFSC U2TX_WAKE_F		;;
	RETURN
	BTFSS U2TX_END_F
	RETURN
	BTSS U2STA,#8
	RETURN
	BCF U2TX_END_F
	BCF RS485CTL_O
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_KEYTBL:				;;
	MOV #128,W0			;;	
	MOV #F24KEY_FADR,W1		;;	
	MOV #KEYTBL_BUF,W2		;;	
	CALL LOAD_F24			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WAIT_U2TX:	
	CLRWDT
	BTFSC U2TX_EN_F
	BRA WAIT_U2TX
	RETURN


TEST_PRG:
	RETURN
	;MOV #0xFFFF,W0
	;XOR OUT_FLAG
	;RETURN



	MOV #UTXTMP,W1
	MOV #2,W0
	MOV W0,[W1++]
	MOV #0xACAB,W0
	MOV W0,[W1++]
	MOV #UTXTMP,W1
	CALL TRANS_MCUTX2

	MOV #UTXTMP,W1
	MOV #2,W0
	MOV W0,[W1++]
	MOV #0xABAC,W0
	MOV W0,[W1++]
	MOV #UTXTMP,W1
	CALL TRANS_MCUTX3

	MOV #UTXTMP,W1
	MOV #2,W0
	MOV W0,[W1++]
	MOV #0xABAD,W0
	MOV W0,[W1++]
	MOV #UTXTMP,W1
	CALL TRANS_MCUTX4

	RETURN

;MCUTX2_MOD.1~0 PARITY, 0:NONE, 1:ADD, 2:EVEN 
;MCUTX2_MOD.2~0 STOP BIT, 0:1BIT  1:2:BIT 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_MCUTX2:					;;
	MOV [W1++],W0				;;
	AND #127,W0				;;
	CP0 W0					;;	
	BRA NZ,$+4				;;		
	RETURN					;;
	MOV W0,UTXTMP_LEN			;;
	MOV W1,W3				;;
	CLR MCUTX2_BYTE				;;
TRANS_MCUTX2_1:					;;
	MOVLF #10,MCUTX2_BIT_LEN		;;	
	MOV W3,W1				;;
	MOV MCUTX2_BYTE,W0			;;
	ADD W0,W1,W1				;;
	BCLR W1,#0				;;
	MOV [W1],W0				;;
	BTSC MCUTX2_BYTE,#0			;;
	SWAP W0					;;
	AND #255,W0				;;
	MOV W0,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x7F00,W0				;;
	IOR W0,W2,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0				;;	
	SWAP.B W0				;;
	XOR W2,W0,W0				;;
	LSR W0,#2,W4				;;
	XOR W0,W4,W0				;;
	LSR W0,#1,W4				;;
	XOR W0,W4,W0				;;
	BTSC MCUU2_MODE,#0			;;
	BRA MCUTX2_ODD_PARITY			;;
	BTSC MCUU2_MODE,#1			;;	
	BRA MCUTX2_EVEN_PARITY			;;
	BRA MCUTX2_NONE_PARITY			;;
MCUTX2_ODD_PARITY:				;;
	BTSC W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX2_BIT_LEN			;;
	BRA MCUTX2_NONE_PARITY			;;
MCUTX2_EVEN_PARITY:				;;
	BTSS W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX2_BIT_LEN			;;
	BRA MCUTX2_NONE_PARITY			;;
MCUTX2_NONE_PARITY:				;;
	BTSC MCUU2_MODE,#2			;;
	INC MCUTX2_BIT_LEN			;;
	RLNC W2,W2				;;	
	MOV #MCUTX2_BUF,W1			;;
	MOV MCUTX2_BYTE,W0			;;
	ADD W0,W1,W1				;;
	ADD W0,W1,W1				;;
	MOV W2,[W1]				;;
	INC MCUTX2_BYTE				;;
	DEC UTXTMP_LEN				;;
	BRA NZ,TRANS_MCUTX2_1			;;
	CLR MCUTX2_BYTE_CNT			;;
	CLR MCUTX2_BIT_CNT			;;
	BSF MCUTX2_START_F			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;MCUTX3_MOD.1~0 PARITY, 0:NONE, 1:ADD, 2:EVEN 
;MCUTX3_MOD.2~0 STOP BIT, 0:1BIT  1:2:BIT 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_MCUTX3:					;;
	MOV [W1++],W0				;;
	AND #127,W0				;;
	CP0 W0					;;	
	BRA NZ,$+4				;;		
	RETURN					;;
	MOV W0,UTXTMP_LEN			;;
	MOV W1,W3				;;
	CLR MCUTX3_BYTE				;;
TRANS_MCUTX3_1:					;;
	MOVLF #10,MCUTX3_BIT_LEN		;;	
	MOV W3,W1				;;
	MOV MCUTX3_BYTE,W0			;;
	ADD W0,W1,W1				;;
	BCLR W1,#0				;;
	MOV [W1],W0				;;
	BTSC MCUTX3_BYTE,#0			;;
	SWAP W0					;;
	AND #255,W0				;;
	MOV W0,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x7F00,W0				;;
	IOR W0,W2,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0				;;	
	SWAP.B W0				;;
	XOR W2,W0,W0				;;
	LSR W0,#2,W4				;;
	XOR W0,W4,W0				;;
	LSR W0,#1,W4				;;
	XOR W0,W4,W0				;;
	BTSC MCUU3_MODE,#0			;;
	BRA MCUTX3_ODD_PARITY			;;
	BTSC MCUU3_MODE,#1			;;	
	BRA MCUTX3_EVEN_PARITY			;;
	BRA MCUTX3_NONE_PARITY			;;
MCUTX3_ODD_PARITY:				;;
	BTSC W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX3_BIT_LEN			;;
	BRA MCUTX3_NONE_PARITY			;;
MCUTX3_EVEN_PARITY:				;;
	BTSS W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX3_BIT_LEN			;;
	BRA MCUTX3_NONE_PARITY			;;
MCUTX3_NONE_PARITY:				;;
	BTSC MCUU3_MODE,#2			;;
	INC MCUTX3_BIT_LEN			;;
	RLNC W2,W2				;;	
	MOV #MCUTX3_BUF,W1			;;
	MOV MCUTX3_BYTE,W0			;;
	ADD W0,W1,W1				;;
	ADD W0,W1,W1				;;
	MOV W2,[W1]				;;
	INC MCUTX3_BYTE				;;
	DEC UTXTMP_LEN				;;
	BRA NZ,TRANS_MCUTX3_1			;;
	CLR MCUTX3_BYTE_CNT			;;
	CLR MCUTX3_BIT_CNT			;;
	BSF MCUTX3_START_F			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 



;MCUTX4_MOD.1~0 PARITY, 0:NONE, 1:ADD, 2:EVEN 
;MCUTX4_MOD.2~0 STOP BIT, 0:1BIT  1:2:BIT 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_MCUTX4:					;;
	MOV [W1++],W0				;;
	AND #127,W0				;;
	CP0 W0					;;	
	BRA NZ,$+4				;;		
	RETURN					;;
	MOV W0,UTXTMP_LEN			;;
	MOV W1,W3				;;
	CLR MCUTX4_BYTE				;;
TRANS_MCUTX4_1:					;;
	MOVLF #10,MCUTX4_BIT_LEN		;;	
	MOV W3,W1				;;
	MOV MCUTX4_BYTE,W0			;;
	ADD W0,W1,W1				;;
	BCLR W1,#0				;;
	MOV [W1],W0				;;
	BTSC MCUTX4_BYTE,#0			;;
	SWAP W0					;;
	AND #255,W0				;;
	MOV W0,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x7F00,W0				;;
	IOR W0,W2,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0				;;	
	SWAP.B W0				;;
	XOR W2,W0,W0				;;
	LSR W0,#2,W4				;;
	XOR W0,W4,W0				;;
	LSR W0,#1,W4				;;
	XOR W0,W4,W0				;;
	BTSC MCUU45_MODE,#0			;;
	BRA MCUTX4_ODD_PARITY			;;
	BTSC MCUU45_MODE,#1			;;	
	BRA MCUTX4_EVEN_PARITY			;;
	BRA MCUTX4_NONE_PARITY			;;
MCUTX4_ODD_PARITY:				;;
	BTSC W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX4_BIT_LEN			;;
	BRA MCUTX4_NONE_PARITY			;;
MCUTX4_EVEN_PARITY:				;;
	BTSS W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX4_BIT_LEN			;;
	BRA MCUTX4_NONE_PARITY			;;
MCUTX4_NONE_PARITY:				;;
	BTSC MCUU45_MODE,#2			;;
	INC MCUTX4_BIT_LEN			;;
	RLNC W2,W2				;;	
	MOV #MCUTX4_BUF,W1			;;
	MOV MCUTX4_BYTE,W0			;;
	ADD W0,W1,W1				;;
	ADD W0,W1,W1				;;
	MOV W2,[W1]				;;
	INC MCUTX4_BYTE				;;
	DEC UTXTMP_LEN				;;
	BRA NZ,TRANS_MCUTX4_1			;;
	CLR MCUTX4_BYTE_CNT			;;
	CLR MCUTX4_BIT_CNT			;;
	BSF MCUTX4_START_F			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_MCUTX5:					;;
	MOV [W1++],W0				;;
	AND #127,W0				;;
	CP0 W0					;;	
	BRA NZ,$+4				;;		
	RETURN					;;
	MOV W0,UTXTMP_LEN			;;
	MOV W1,W3				;;
	CLR MCUTX5_BYTE				;;
TRANS_MCUTX5_1:					;;
	MOVLF #10,MCUTX5_BIT_LEN		;;	
	MOV W3,W1				;;
	MOV MCUTX5_BYTE,W0			;;
	ADD W0,W1,W1				;;
	BCLR W1,#0				;;
	MOV [W1],W0				;;
	BTSC MCUTX5_BYTE,#0			;;
	SWAP W0					;;
	AND #255,W0				;;
	MOV W0,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x7F00,W0				;;
	IOR W0,W2,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0				;;	
	SWAP.B W0				;;
	XOR W2,W0,W0				;;
	LSR W0,#2,W4				;;
	XOR W0,W4,W0				;;
	LSR W0,#1,W4				;;
	XOR W0,W4,W0				;;
	BTSC MCUU45_MODE,#0			;;
	BRA MCUTX5_ODD_PARITY			;;
	BTSC MCUU45_MODE,#1			;;	
	BRA MCUTX5_EVEN_PARITY			;;
	BRA MCUTX5_NONE_PARITY			;;
MCUTX5_ODD_PARITY:				;;
	BTSC W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX5_BIT_LEN			;;
	BRA MCUTX5_NONE_PARITY			;;
MCUTX5_EVEN_PARITY:				;;
	BTSS W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX5_BIT_LEN			;;
	BRA MCUTX5_NONE_PARITY			;;
MCUTX5_NONE_PARITY:				;;
	BTSC MCUU45_MODE,#2			;;
	INC MCUTX5_BIT_LEN			;;
	RLNC W2,W2				;;	
	MOV #MCUTX5_BUF,W1			;;
	MOV MCUTX5_BYTE,W0			;;
	ADD W0,W1,W1				;;
	ADD W0,W1,W1				;;
	MOV W2,[W1]				;;
	INC MCUTX5_BYTE				;;
	DEC UTXTMP_LEN				;;
	BRA NZ,TRANS_MCUTX5_1			;;
	CLR MCUTX5_BYTE_CNT			;;
	CLR MCUTX5_BIT_CNT			;;
	BSF MCUTX5_START_F			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;MCUTX1_MOD.1~0 PARITY, 0:NONE, 1:ADD, 2:EVEN 
;MCUTX1_MOD.2~0 STOP BIT, 0:1BIT  1:2:BIT 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_MCUTX1:					;;
	MOV [W1++],W0				;;
	AND #127,W0				;;
	CP0 W0					;;	
	BRA NZ,$+4				;;		
	RETURN					;;
	MOV W0,UTXTMP_LEN			;;
	MOV W1,W3				;;
	CLR MCUTX1_BYTE				;;
TRANS_MCUTX1_1:					;;
	MOVLF #10,MCUTX1_BIT_LEN		;;	
	MOV W3,W1				;;
	MOV MCUTX1_BYTE,W0			;;
	ADD W0,W1,W1				;;
	BCLR W1,#0				;;
	MOV [W1],W0				;;
	BTSC MCUTX1_BYTE,#0			;;
	SWAP W0					;;
	AND #255,W0				;;
	MOV W0,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x7F00,W0				;;
	IOR W0,W2,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0				;;	
	SWAP.B W0				;;
	XOR W2,W0,W0				;;
	LSR W0,#2,W4				;;
	XOR W0,W4,W0				;;
	LSR W0,#1,W4				;;
	XOR W0,W4,W0				;;
	BTSC MCUU1_MODE,#0			;;
	BRA MCUTX1_ODD_PARITY			;;
	BTSC MCUU1_MODE,#1			;;	
	BRA MCUTX1_EVEN_PARITY			;;
	BRA MCUTX1_NONE_PARITY			;;
MCUTX1_ODD_PARITY:				;;
	BTSC W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX1_BIT_LEN			;;
	BRA MCUTX1_NONE_PARITY			;;
MCUTX1_EVEN_PARITY:				;;
	BTSS W0,#0				;;
	BCLR W2,#8				;;
	INC MCUTX1_BIT_LEN			;;
	BRA MCUTX1_NONE_PARITY			;;
MCUTX1_NONE_PARITY:				;;
	BTSC MCUU1_MODE,#2			;;
	INC MCUTX1_BIT_LEN			;;
	RLNC W2,W2				;;	
	MOV #MCUTX1_BUF,W1			;;
	MOV MCUTX1_BYTE,W0			;;
	ADD W0,W1,W1				;;
	ADD W0,W1,W1				;;
	MOV W2,[W1]				;;
	INC MCUTX1_BYTE				;;
	DEC UTXTMP_LEN				;;
	BRA NZ,TRANS_MCUTX1_1			;;
	CLR MCUTX1_BYTE_CNT			;;
	CLR MCUTX1_BIT_CNT			;;
	BSF MCUTX1_START_F			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
        BCF FACTORY_TEST_F              ;;
	CALL ENABLE_FLASH_QPI		;;
	CALL LOAD_KEYTBL		;;	
	CALL CLR_ALL_KB_PAGE
	CALL OLED_RESTART		;;
	BSF U1RX_EN_F			;;
	BSF U2RX_EN_F			;;

	;MOV #500,W0		;;
	;CALL DLY1000X		;;
	;CALL OLED_RESTART		;;


	;MOVLF #CMD_TEST2_K,CMDINX	;;
	;CLR CMDTIME			;;	
	;CLR CMDSTEP			;;
	;MOVLF #CMD_TEST1_K,CMDINX	;;
	;CLR CMDTIME			;;	
	;CLR CMDSTEP			;;

	;MOVLF #CMD_TEST1_K,CMDINX	;;
	;CLR CMDTIME			;;	
	;CLR CMDSTEP			;;



	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
	CLRWDT				;;
	BTFSC T128M_F			;;	
	TG LED_O			;;	
	BTFSC T128M_F			;;
	CALL CONVERT_AD			;;
	BTFSC T128M_F			;;	
	CALL TEST_PRG			;;	
	CALL IOPRG
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_U2TX_END		;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL GET_KEYDATA		;;	
	CALL NKEYBO			;;
	CALL MAIN_KEYPRG		;;
	CALL CHK_U1RX			;;
	CALL CHK_U2RX			;;
	CALL CHK_MCURX1			;;
	CALL CHK_MCURX2			;;
	CALL CHK_MCURX3			;;
	CALL CHK_MCURX4			;;
	CALL CHK_MCURX5			;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MCURX2:				;;
	BTFSS MCURX2_RXIN_F		;;	
	RETURN				;;
	BCF MCURX2_RXIN_F		;;
	CLR URXTMP_LEN			;;
CHK_MCURX2_0:				;;
	MOV MCURX2_END_CNT,W0		;;
	CP MCURX2_PCNT1			;;
	BRA NZ,$+4			;;
	BRA CHK_MCURX2_END		;;
	INC MCURX2_PCNT1		;;
	MOV #127,W0			;;
	AND MCURX2_PCNT1		;;
	MOV #MCURX2_BUF,W1		;; 
	MOV MCURX2_PCNT1,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	MOV [W1],W2			;;
	BTSC MCURX2_PCNT1,#0		;;
	SWAP W2				;;
	AND #255,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #URXTMP,W1			;;
	MOV URXTMP_LEN,W0		;;	
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	BTSC URXTMP_LEN,#0		;;
	BRA CHK_MCURX2_1		;;
	MOV W2,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX2_0		;;
CHK_MCURX2_1:				;;
	MOV [W1],W0			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	SWAP W0				;;
	MOV W0,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX2_0		;;
CHK_MCURX2_END:				;;
	CP0 URXTMP_LEN			;;
	BRA NZ,$+4			;;
	RETURN				;;
	MOV #URXTMP,W0			;;
	MOV W0,RX_ADDR			;;
	MOVFF URXTMP_LEN,RX_LEN		;;
	MOVLF #0,RX_CH			;;
	CALL DEC_SYSURX			;;
	RETURN	  			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MCURX3:				;;
	BTFSS MCURX3_RXIN_F		;;	
	RETURN				;;
	BCF MCURX3_RXIN_F		;;
	CLR URXTMP_LEN			;;
CHK_MCURX3_0:				;;
	MOV MCURX3_END_CNT,W0		;;
	CP MCURX3_PCNT1			;;
	BRA NZ,$+4			;;
	BRA CHK_MCURX3_END		;;
	INC MCURX3_PCNT1		;;
	MOV #127,W0			;;
	AND MCURX3_PCNT1		;;
	MOV #MCURX3_BUF,W1		;; 
	MOV MCURX3_PCNT1,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	MOV [W1],W2			;;
	BTSC MCURX3_PCNT1,#0		;;
	SWAP W2				;;
	AND #255,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #URXTMP,W1			;;
	MOV URXTMP_LEN,W0		;;	
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	BTSC URXTMP_LEN,#0		;;
	BRA CHK_MCURX3_1		;;
	MOV W2,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX3_0		;;
CHK_MCURX3_1:				;;
	MOV [W1],W0			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	SWAP W0				;;
	MOV W0,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX3_0		;;
CHK_MCURX3_END:				;;
	CP0 URXTMP_LEN			;;
	BRA NZ,$+4			;;
	RETURN				;;
	MOV #URXTMP,W0			;;
	MOV W0,RX_ADDR			;;
	MOVFF URXTMP_LEN,RX_LEN		;;
	MOVLF #1,RX_CH			;;
	CALL DEC_SYSURX			;;
	RETURN	  			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MCURX4:				;;
	BTFSS MCURX4_RXIN_F		;;	
	RETURN				;;
	BCF MCURX4_RXIN_F		;;
	CLR URXTMP_LEN			;;
CHK_MCURX4_0:				;;
	MOV MCURX4_END_CNT,W0		;;
	CP MCURX4_PCNT1			;;
	BRA NZ,$+4			;;
	BRA CHK_MCURX4_END		;;
	INC MCURX4_PCNT1		;;
	MOV #127,W0			;;
	AND MCURX4_PCNT1		;;
	MOV #MCURX4_BUF,W1		;; 
	MOV MCURX4_PCNT1,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	MOV [W1],W2			;;
	BTSC MCURX4_PCNT1,#0		;;
	SWAP W2				;;
	AND #255,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #URXTMP,W1			;;
	MOV URXTMP_LEN,W0		;;	
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	BTSC URXTMP_LEN,#0		;;
	BRA CHK_MCURX4_1		;;
	MOV W2,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX4_0		;;
CHK_MCURX4_1:				;;
	MOV [W1],W0			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	SWAP W0				;;
	MOV W0,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX4_0		;;
CHK_MCURX4_END:				;;
	CP0 URXTMP_LEN			;;
	BRA NZ,$+4			;;
	RETURN				;;
	MOV #URXTMP,W0			;;
	MOV W0,RX_ADDR			;;
	MOVFF URXTMP_LEN,RX_LEN		;;
	MOVLF #2,RX_CH			;;
	CALL DEC_SYSURX			;;
	RETURN	  			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MCURX5:				;;
	BTFSS MCURX5_RXIN_F		;;	
	RETURN				;;
	BCF MCURX5_RXIN_F		;;
	CLR URXTMP_LEN			;;
CHK_MCURX5_0:				;;
	MOV MCURX5_END_CNT,W0		;;
	CP MCURX5_PCNT1			;;
	BRA NZ,$+4			;;
	BRA CHK_MCURX5_END		;;
	INC MCURX5_PCNT1		;;
	MOV #127,W0			;;
	AND MCURX5_PCNT1		;;
	MOV #MCURX5_BUF,W1		;; 
	MOV MCURX5_PCNT1,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	MOV [W1],W2			;;
	BTSC MCURX5_PCNT1,#0		;;
	SWAP W2				;;
	AND #255,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #URXTMP,W1			;;
	MOV URXTMP_LEN,W0		;;	
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	BTSC URXTMP_LEN,#0		;;
	BRA CHK_MCURX5_1		;;
	MOV W2,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX5_0		;;
CHK_MCURX5_1:				;;
	MOV [W1],W0			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	SWAP W0				;;
	MOV W0,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX5_0		;;
CHK_MCURX5_END:				;;
	CP0 URXTMP_LEN			;;
	BRA NZ,$+4			;;
	RETURN				;;
	MOV #URXTMP,W0			;;
	MOV W0,RX_ADDR			;;
	MOVFF URXTMP_LEN,RX_LEN		;;
	MOVLF #2,RX_CH			;;
	CALL DEC_SYSURX			;;
	RETURN	  			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MCURX1:				;;
	BTFSS MCURX1_RXIN_F		;;	
	RETURN				;;
	BCF MCURX1_RXIN_F		;;
	CLR URXTMP_LEN			;;
CHK_MCURX1_0:				;;
	MOV MCURX1_END_CNT,W0		;;
	CP MCURX1_PCNT1			;;
	BRA NZ,$+4			;;
	BRA CHK_MCURX1_END		;;
	INC MCURX1_PCNT1		;;
	MOV #127,W0			;;
	AND MCURX1_PCNT1		;;
	MOV #MCURX1_BUF,W1		;; 
	MOV MCURX1_PCNT1,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	MOV [W1],W2			;;
	BTSC MCURX1_PCNT1,#0		;;
	SWAP W2				;;
	AND #255,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #URXTMP,W1			;;
	MOV URXTMP_LEN,W0		;;	
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	BTSC URXTMP_LEN,#0		;;
	BRA CHK_MCURX1_1		;;
	MOV W2,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX1_0		;;
CHK_MCURX1_1:				;;
	MOV [W1],W0			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	SWAP W0				;;
	MOV W0,[W1]			;;
	INC URXTMP_LEN			;;
	BRA CHK_MCURX1_0		;;
CHK_MCURX1_END:				;;
	CP0 URXTMP_LEN			;;
	BRA NZ,$+4			;;
	RETURN				;;
	MOV #URXTMP,W0			;;
	MOV W0,RX_ADDR			;;
	MOVFF URXTMP_LEN,RX_LEN		;;
	MOVLF #3,RX_CH			;;
	CALL DEC_SYSURX			;;
	RETURN	  			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;










IONOP:
	NOP
	NOP
	NOP
	NOP
	RETURN
	
IOPRG:

	MOV #0xFF00,W0
	AND TRISC
	MOV OUT_FLAG,W2
	MOV LATC,W0
	XOR W0,W2,W0
	AND #255,W0
	XOR LATC
	BCF IO_DRIVER_O			
	CALL IONOP
	BSF IO_DRIVER_O
	
	MOV OUT_FLAG,W2
	SWAP W2
	MOV LATC,W0
	XOR W0,W2,W0
	AND #255,W0
	XOR LATC

	BCF IO_WRITE_O			
	CALL IONOP
	BSF IO_WRITE_O

	MOV #0xFF,W0
	IOR TRISC
	CALL IONOP
	BCF IO_READ_O
	CALL IONOP
	MOV #255,W0
	AND IN_FLAG
	MOV PORTC,W0
	AND #255,W0
	IOR IN_FLAG
	BSF IO_READ_O
	RETURN







MAIN_KEYPRG:
	CP0 EMUKR0
	BRA Z,$+6
	MOV EMUKR0,W0
	MOV W0,R0

	CP0 EMUKR1
	BRA Z,$+6
	MOV EMUKR1,W0
	MOV W0,R1

	CP0 EMUKR2
	BRA Z,$+6
	MOV EMUKR2,W0
	MOV W0,R2

	CP0 EMUKR3
	BRA Z,$+6
	MOV EMUKR3,W0
	MOV W0,R3

	CP0 R0
	BRA Z,$+8
	CALL MAIN_KPUSH
	BRA MKP_END
	CP0 R1
	BRA Z,$+8
	CALL MAIN_KFREE
	BRA MKP_END
	CP0 R2
	BRA Z,$+8
	CALL MAIN_KCON1
	BRA MKP_END
	CP0 R3
	BRA Z,$+8
	CALL MAIN_KCON2
	BRA MKP_END
MKP_END:
	CLR EMUKR0	
	CLR EMUKR1	
	CLR EMUKR2	
	CLR EMUKR3	
	RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_3BADRX4:				;;
	BTSC W1,#0			;;
	BRA GET_3BADRX4_1		;;	
	MOV [W1++],W0			;;
	MOV W0,FADR0			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,FADR1			;;
	BRA GET_3BADRX4_2		;;
GET_3BADRX4_1:				;;
	BCLR W1,#0
	MOV [W1++],W0			;;
	LSR W0,#8,W0			;;
	MOV W0,FADR0			;;
	MOV [W1],W0			;;
	SL W0,#8,W0			;;
	ADD FADR0			;;
	MOV [W1],W0			;;
	LSR W0,#8,W0			;;
	MOV W0,FADR1			;;
GET_3BADRX4_2:				;;
	BCLR SR,#C			;;
	RLC FADR0			;;
	RLC FADR1			;;
	BCLR SR,#C			;;
	RLC FADR0			;;
	RLC FADR1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;r0=0 ascii
;r1=1 hex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_KEYP_PRG:				;;
	PUSH FADR0			;;;
	PUSH FADR1			;;
	MOV #FLASH_TMP,W1		;;
	CALL READ_FLASH_PAGE		;;
	MOV #FLASH_TMP,W3		;;	
	MOV [W3++],W0			;;
	AND #0x1FF,W0			;;
	MOV W0,UTX_BUFFER_LEN		;;
	MOV #0x4000,W0			;;
	MOV W0,UTX_CMD			;;
	MOV R0,W0			;;
	MOV W0,UTX_PARA0		;;		
	CLR UTX_PARA1			;;
	CLR UTX_PARA2			;;
	CLR UTX_PARA3			;;
	MOV #FLASH_TMP+2,W3		;;
	CALL UTX_BUFFER			;;
	POP FADR1			;;
	POP FADR0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #128,W0			;;	
	CALL READ_FLASH_XB		;;
	MOV #FLASH_TMP,W1		;;
	MOV R1,W0			;;
	AND #3,W0			;;
	BRA W0				;;
	BRA JP_TRANS_MCUTX2		;;		
	BRA JP_TRANS_MCUTX3		;;
	BRA JP_TRANS_MCUTX4		;;
	BRA JP_TRANS_MCUTX1		;;
	NOP				;;
	NOP				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

JP_TRANS_MCUTX2:		;;		
	CALL TRANS_MCUTX2
	RETURN
	
JP_TRANS_MCUTX3:		;;
	CALL TRANS_MCUTX3
	RETURN
JP_TRANS_MCUTX4:	
        PUSH W1
	CALL TRANS_MCUTX4
        POP W1
	CALL TRANS_MCUTX5
	RETURN

JP_TRANS_MCUTX1:		;;
	CALL TRANS_MCUTX1
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SPEC_KEY:				;;
	BCF OK_F			;;
	CLR R0				;;
CHK_SPEC_KEY_0:				;;
	MOV #SPEC_KEY_BUF,W1		;;
	MOV R0,W0			;;
	ADD W0,W1,W1			;;
        ADD W0,W1,W1                    ;;
	MOV [W1],W0			;;
	AND #255,W0			;;
	BRA Z,CHK_SPEC_KEY_1		;;
	DEC W0,W0			;;
	CP OLED_POS			;;
	BRA NZ,CHK_SPEC_KEY_1		;;
	BSF OK_F			;;
	RETURN				;;
CHK_SPEC_KEY_1:				;;
	INC R0				;;
	MOV #11,W0			;;
	CP R0				;;
	BRA LTU,CHK_SPEC_KEY_0		;;
	MOVFF OLED_POS,PRE_OLED_POS	;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_SPEC_KEY:				;;
	BCF OK_F			;;
	MOV R0,W0			;;
	CP W0,#7			;;
	BRA Z,SPEC_KEY_DIM_UP		;;
	CP W0,#8			;;
	BRA Z,SPEC_KEY_DIM_DOWN		;;
	MOVFF OLED_POS,PRE_OLED_POS	;;	
	BTFSS SET_DIMS_F		;;
	BRA SET_SPEC_KEY_0		;;
	BSF OK_F			;;
	RETURN				;;
SET_SPEC_KEY_0:				;;
	CP W0,#9		        ;;      
	BRA Z,SPEC_KEY_TEST_NEXT	;;
	CP W0,#10			;;
	BRA Z,SPEC_KEY_TEST_STOP	;;
SET_SPEC_KEY_1:				;;
	MOV #SPEC_KEY_BUF,W1		;;
	MOV R0,W0			;;
	ADD W0,W1,W1			;;
        ADD W0,W1,W1                    ;;
	MOV [W1],W0			;;
        SWAP W0                         ;;
        AND #7,W0                       ;;
	MOV W0,NOWKB_INX		;;
	CLR OLED_INX			;;
	CALL DISP_ALL_KEY		;;
	BSF OK_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPEC_KEY_TEST_ONOFF:			;;
        CP0 SELF_TEST_INX               ;;
        BRA Z,SPEC_KEY_TEST_START       ;;
        BRA SPEC_KEY_TEST_STOP
SPEC_KEY_TEST_NEXT:			;;
       	CP0 SELF_TEST_INX               ;;
        BRA NZ,$+4
        RETURN
SPEC_KEY_TEST_START:			;;
	CALL KB_TEST_PRG		;;
	RETURN				;;
SPEC_KEY_TEST_STOP:			;;
	CALL KB_STOP_PRG		;;
	RETURN				;;
SPEC_KEY_DIM_UP:			;;
	CALL LIGHT_UP_PRG		;;
	BSF OK_F			;;
	RETURN				;;
SPEC_KEY_DIM_DOWN:			;;
	CALL LIGHT_DOWN_PRG		;;
	BSF OK_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
START_TEST:                             ;;
	MOV #0x001F,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	MOV #50000,W0			;;
	CALL DLYX			;;
	RETURN




					;;
	MOV #0,W0			;;
	CP DEBUG_CNT			;;
	BRA NZ,$+6			;;
	MOV #0xF800,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
					;;
	MOV #1,W0			;;
	CP DEBUG_CNT			;;
	BRA NZ,$+6			;;
	MOV #0x07E0,W0			;;COLOR
	MOV W0,UTX_PARA0		;;

	MOV #2,W0			;;
	CP DEBUG_CNT			;;
	BRA NZ,$+6			;;
	MOV #0x0000,W0			;;COLOR
	MOV W0,UTX_PARA0		;;


					;;
	MOV #0x2000,W0			;;FRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
					;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	CLR KB_TYPE_CNT			;;
	CLR KB_PAGE_CNT			;;

	RETURN				;;
;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEBUG_TEST1:				;;
	INC DEBUG_CNT			;;
	MOV #4,W0			;;
	CP DEBUG_CNT			;;
	BRA LTU,$+4			;;
	CLR DEBUG_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x001F,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
					;;
	MOV #0,W0			;;
	CP DEBUG_CNT			;;
	BRA NZ,$+6			;;
	MOV #0xF800,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
					;;
	MOV #1,W0			;;
	CP DEBUG_CNT			;;
	BRA NZ,$+6			;;
	MOV #0x07E0,W0			;;COLOR
	MOV W0,UTX_PARA0		;;

	MOV #2,W0			;;
	CP DEBUG_CNT			;;
	BRA NZ,$+6			;;
	MOV #0x0000,W0			;;COLOR
	MOV W0,UTX_PARA0		;;


					;;
	MOV #0x2000,W0			;;FRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
					;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	CLR KB_TYPE_CNT			;;
	CLR KB_PAGE_CNT			;;

	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEBUG_TEST2:			
	MOVLF #CMD_WRITE_SCAN_KEY_K,CMDINX
	MOVLF #0,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEBUG_TEST3:			
	MOVLF #CMD_ERASE_ALL_KEY_K,CMDINX
	MOVLF #0,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEBUG_TEST4: ;NEXT IMAGE		;;
	MOV #0x2003,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EMU_KEY_PUSH:				;;
	CP0 EMUKR0			;;
	BRA NZ,$+4			;;
	RETURN				;;
	MOVLF #0,UTX_PARA0		;;
	BRA EMU_KEY_ACTION		;;	
EMU_KEY_FREE:
	CP0 EMUKR1			;;
	BRA NZ,$+4			;;
	RETURN				;;
	MOVLF #1,UTX_PARA0		;;
	BRA EMU_KEY_ACTION		;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EMU_KEY_ACTION:				;;
	MOV #0x2006,W0			;;
	MOV W0,UTX_CMD			;;
	MOV OLED_POS,W0			;;
	MOV W0,SON_SERIAL_ID		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SON_TEST_ALL:				;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;INPUT OLED_POS,KB_TYPE_CNT,KB_PAGE_CNT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHOW_IMAGE_ONE:				;;
	MOV #0x2004,W0			;;
	MOV W0,UTX_CMD			;;
	MOVFF KB_PAGE_CNT,UTX_PARA0	;;
	MOVFF KB_TYPE_CNT,UTX_PARA1	;;
	MOV OLED_POS,W0			;;
	MOV W0,SON_SERIAL_ID		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;INPUT KB_TYPE_CNT,KB_PAGE_CNT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHOW_IMAGE_ALL:				;;
	MOV #0x2005,W0			;;
	MOV W0,UTX_CMD			;;
	MOVFF KB_PAGE_CNT,UTX_PARA0	;;
	MOVFF KB_TYPE_CNT,UTX_PARA1	;;
	MOV KB_TYPE_CNT,W0		;;
	SWAP.B W0			;;
	ADD KB_PAGE_CNT,WREG		;;
	MOV W0,W2			;;
	SWAP W2				;;
	IOR W2,W0,W0			;;
	MOV #FLASH_TMP,W3		;;
	REPEAT #45			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #FLASH_TMP,W3		;;
	MOVLF #92,UTX_BUFFER_LEN	;;
	BSF U1U2_F			;;
	CALL UTX_BUFFER			;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEBUG_TEST5: 				;;
	MOV #0x2004,W0			;;
	MOV W0,UTX_CMD			;;
	MOVFF KB_PAGE_CNT,UTX_PARA0	;;
	MOVFF KB_TYPE_CNT,UTX_PARA1	;;
	MOV #0x0009,W0			;;
	MOV W0,SON_SERIAL_ID		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	INC KB_PAGE_CNT			;;
	MOV #8,W0			;;
	CP KB_PAGE_CNT			;;	
	BRA GEU,$+4			;;
	RETURN				;;
	CLR KB_PAGE_CNT			;;
	INC KB_TYPE_CNT			;;
	MOV #7,W0			;;
	CP KB_TYPE_CNT			;;
	BRA GEU,$+4			;;
	RETURN				;;
	CLR KB_TYPE_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEBUG_TEST6: 				;;
	MOV #0x2005,W0			;;
	MOV W0,UTX_CMD			;;
	MOVFF KB_PAGE_CNT,OLED_POS	;;
	MOVFF KB_TYPE_CNT,NOWKB_INX	;;
	CALL DISP_ALL_KEY		;;
	INC KB_PAGE_CNT			;;
	MOV #8,W0			;;
	CP KB_PAGE_CNT			;;	
	BRA GEU,$+4			;;
	RETURN				;;
	CLR KB_PAGE_CNT			;;
	INC KB_TYPE_CNT			;;
	MOV #7,W0			;;
	CP KB_TYPE_CNT			;;
	BRA GEU,$+4			;;
	RETURN				;;
	CLR KB_TYPE_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KB_DEBUG_PRG:				;;
	MOVLF #46,WRITE_KEY_CNT		;;
	MOV #CMD_SET_ONE_KEY_K,W0	;;	
	MOV W0,CMDINX			;;
	MOVLF #200,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DIMS_UP_PRG:				;;
	MOV #0x200A,W0			;;
	MOV W0,UTX_CMD			;;
	MOV PRE_OLED_POS,W0		;;
	MOV W0,SON_SERIAL_ID		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	RETURN				;;
DIMS_DOWN_PRG:				;;	
	MOV #0x200B,W0			;;
	MOV W0,UTX_CMD			;;
	MOV PRE_OLED_POS,W0		;;
	MOV W0,SON_SERIAL_ID		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LIGHT_UP_PRG:				;;
	BTFSC SET_DIMS_F		;;
	BRA DIMS_UP_PRG
	INC DIM_SET			;;	
	MOV #5,W0			;;
	CP DIM_SET			;;
	BRA LTU,$+4			;;
	CLR DIM_SET			;;	
	BRA SET_LIGHT_PRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x2007,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_LIGHT_PRG:				;;
	MOV #0x2009,W0			;;
	MOV W0,UTX_CMD			;;
	MOV DIM_SET,W0			;;
	MOV W0,UTX_PARA0		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	CALL WAIT_U2TX			;;			
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_KEYID_PRG:				;;
	MOV #0x200E,W0			;;
	MOV W0,UTX_CMD			;;
	MOV SETKEY_ID,W0		;;
	MOV W0,UTX_PARA0		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RESET_ALLKEY_PRG:			;;
	MOV #CMD_RESET_KB_K,W0		;;
	CALL SET_CMDINX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SET_CMDINX:
	MOV W0,CMDINX
	CLR CMDSTEP
	CLR CMDTIME
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LIGHT_DOWN_PRG:				;;
	BTFSC SET_DIMS_F
	BRA DIMS_DOWN_PRG

	DEC DIM_SET			;;	
	MOV #5,W0			;;
	CP DIM_SET			;;
	MOV #4,W0			;;
	BRA LTU,$+4			;;
	MOV W0,DIM_SET			;;	
	BRA SET_LIGHT_PRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x2008,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KB_STOP_PRG:
        BCF FACTORY_TEST_F              ;;        
	BCF SET_DIMS_F	
	CLR SELF_TEST_INX
	BRA KTP_1
KB_TEST_PRG:
	BCF SET_DIMS_F	
	INC SELF_TEST_INX
	MOV #7,W0	
	CP SELF_TEST_INX
	BRA LTU,KTP_1
	MOV #1,W0
	MOV W0,SELF_TEST_INX
KTP_1:
	MOV SELF_TEST_INX,W0
	CALL SET_TEST_X
	RETURN

	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
MAIN_KPUSH:				;;
	DEC R0				;;
	MOV R0,W0			;;
	MOV W0,OLED_POS			;;
	;=================================
	CALL EMU_KEY_PUSH		;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0,W1		;;
	MOV [W1],W2			;;
	MOV #0xCDAB,W0			;;
	CP W2,W0			;;
	BRA Z,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+2,W1		;;
	MOV [W1],W4			;;
	SWAP W4				;;
	SWAP.B W4			;;
	AND #3,W4			;;
	BRA Z,MAIN_KPUSH_1		;;
	MOV [W1],W0			;;
	SWAP W0				;;
	AND #15,W0			;;
	MOV #1,W2			;;
	SL W2,W0,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W4,#1			;;
	BRA Z,IO_TGL			;;
	CP W4,#2			;;
	BRA Z,IO_SET			;;
	CP W4,#3			;;
	BRA Z,IO_CLR			;;
	BRA MAIN_KPUSH_1		;;
IO_TGL:					;;
	MOV W2,W0			;;
	XOR OUT_FLAG			;;
	BRA MAIN_KPUSH_1		;;
IO_SET:					;;
	MOV W2,W0			;;
	IOR OUT_FLAG			;;
	BRA MAIN_KPUSH_1		;;
IO_CLR:					;;
	MOV #0xFFFF,W0			;;
	XOR W2,W0,W0			;;
	AND OUT_FLAG			;;
	BRA MAIN_KPUSH_1		;;
MAIN_KPUSH_1:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+2,W1		;;
	MOV [W1],W0			;;
	AND #255,W0			;;
	MOV W0,R0			;;
	MOV [W1],W0			;;
	LSR W0,#14,W0			;;
	AND #3,W0			;;
	MOV W0,R1			;;SERIAL CHANEL
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+4,W1		;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BRA Z,DSDD			;;;
	CALL UTX_KEYP_PRG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
DSDD:
	NOP
	NOP
	NOP
	NOP
	RETURN


KB_SET_SCAN_PRG:
	CALL SET_SCAN_KEY_START
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
MAIN_KFREE:				;;
	DEC R1				;;
	MOV R1,W0			;;
	MOV W0,OLED_POS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0x03,W0			;;
	;CP OLED_POS			;;
	;BRA NZ,$+10			;;
	;MOV #CMD_UTXTEST_K,W0		;;
	;MOV W0,CMDINX			;;
	;CLR CMDSTEP			;;
	;CLR CMDTIME			;;

        BTFSS FACTORY_TEST_F
        BRA MAIN_KFREE_1
        CP0 OLED_POS
        BRA NZ,MAIN_KFREE_1
        CALL SPEC_KEY_TEST_NEXT
        RETURN
MAIN_KFREE_1:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_SPEC_KEY		;;	
        PUSH R0
        PUSH OLED_POS
	BTFSC OK_F			;;
	CALL SET_SPEC_KEY		;;	
	;BTFSC OK_F			;;
	;RETURN				;;
        POP OLED_POS
        POP R0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL EMU_KEY_FREE		;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0,W1		;;
	MOV [W1],W2			;;
	MOV #0xCDAB,W0			;;
	CP W2,W0			;;
	BRA Z,$+4			;;
	RETURN				;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+2,W1		;;
	MOV [W1],W0			;;
	AND #255,W0			;;
	MOV W0,R0			;;0:ASCII 1:HEX
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W0			;;
	LSR W0,#14,W0			;;
	AND #3,W0			;;
	MOV W0,R1			;;SERIAL CHANEL
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+7,W1		;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BRA Z,$+6			;;
	CALL UTX_KEYP_PRG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
MAIN_KCON1:				;;
	DEC R2				;;
	MOV R2,W0			;;
	MOV W0,OLED_POS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF OLED_POS,PRE_OLED_POS	;;	
	CALL CHK_SPEC_KEY		;;
	BTFSS OK_F			;;
	BRA MAIN_KCON1_1		;;
	MOV R0,W0			;;
	CP W0,#9			;;
	BRA Z,SPEC_KEY_TEST_ONOFF	;;
	CP W0,#10			;;
	BRA NZ,MAIN_KCON1_1		;;
	BCF SET_DIMS_F			;;
	CLR SELF_TEST_INX		;;
	MOV #CMD_RESET_KB_K,W0		;;
	CALL SET_CMDINX			;;
	RETURN
MAIN_KCON1_1:				;;
	CALL LOAD_KEY_ACT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+0,W1		;;
	MOV [W1],W2			;;
	MOV #0xABCD,W0			;;
	CP W2,W0			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV #FLASH_TMP+2,W1		;;
	MOV [W1],W0			;;
	AND #255,W0			;;
	MOV W0,R0			;;
	MOV [W1],W0			;;
	LSR W0,#14,W0			;;
	AND #3,W0			;;
	MOV W0,R1			;;SERIAL CHANEL
	MOV #FLASH_TMP+10,W1		;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BRA Z,$+6			;;
	CALL UTX_KEYP_PRG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
LOAD_KEY_ACT:				;;
	MOV #0x2000,W0			;;
	MUL NOWKB_INX			;;
	MOV W2,FADR0			;;
	MOV W3,FADR1			;;	
	MOV #0x1120,W0			;;
	ADD FADR0			;;
	MOV #0,W0			;;
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #64,W0			;;
	MUL OLED_POS			;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;
	ADDC FADR1			;;
	CALL READ_FLASH_64B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_KCON2:			        ;;
	MOV #1,W0                       ;;
	CP R3                           ;;      
	BRA NZ,MAIN_KCON2_1             ;;
        BSF FACTORY_TEST_F              ;;        
        CALL SPEC_KEY_TEST_ONOFF        ;;
	RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_KCON2_1:			        ;;
	MOV #2,W0                       ;;
	CP R3                           ;;      
	BRA NZ,MAIN_KCON2_2             ;;
        BTFSS FACTORY_TEST_F            ;;        
        RETURN                          ;;
        MOV #3,W0                       ;;
        CP SELF_TEST_INX                ;;
        BRA NZ,MAIN_KCON2_2             ;;
	BCF U1U2_F			;;
        CALL UTX_INIT_IP                ;;
        CALL SPEC_KEY_TEST_ONOFF        ;;
        RETURN

MAIN_KCON2_2:			        ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



DARK_TEST_KEY:
	RETURN

KBMODE3_KPUSH:
	MOV R0,W0
	DEC W0,W0
	MOV W0,TESTOLED_CNT
	CALL DARK_TEST_KEY
	RETURN
	




MAIN_KPUSH_K2:
	INC DIM_CNT
	MOV #32,W0
	CP DIM_CNT
	BRA LTU,$+4
	CLR DIM_CNT
	RETURN

MAIN_KPUSH_K3:
	RETURN


MAIN_KPUSH_K4:
	RETURN





KBTEST_END_PRG:
	;CALL OLED_ALL_OFF
	;MOVLF #0x0000,OLED_DATA 
	;BSF OLEDXALL_F
	;CALL WALL_OLED2B
	;CALL OLED_ALL_ON
	CALL LOAD_ALL_KEY_STATUS
	CALL DISP_ALL_KEY

	RETURN

OLED_ALL_OFF:
	RETURN
OLED_ALL_ON:
	RETURN




	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_ALL_KB_PAGE:			;;
	PUSH OLED_POS			;;
	CLR OLED_POS			;;
	CALL GET_KBSTA_ADR		;;
CAKP_0:					;;
	MOV #0xFFF0,W2			;;
	MOV [W1],W0			;;
	AND W2,W0,W0			;;
	MOV W0,[W1]			;;
	INC2 W1,W1			;;
	INC OLED_POS			;;
	MOV #OLED_AMT_K,W0		;;
	CP OLED_POS			;;
	BRA LTU,CAKP_0			;;
	POP OLED_POS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_ALL_KEY:				;;
	PUSH OLED_POS			;;
	CLR OLED_POS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL GET_KBSTA_ADR		;;
	MOV #FLASH_TMP,W3		;;
DAK_1:					;;
	MOV [W1++],W0			;;
	AND #15,W0			;;
	MOV NOWKB_INX,W2		;;	
	SWAP.B W2			;;
	IOR W0,W2,W2			;;
	BTSC W3,#0			;;
	BRA DAK_2			;;
	MOV W2,[W3]			;;
	INC W3,W3			;;	
	BRA DAK_3			;;
DAK_2:					;;
	BCLR W3,#0			;;
	MOV [W3],W0			;;
	SWAP W2				;;
	IOR W2,W0,W0			;;		
	MOV W0,[W3++]			;;
DAK_3:					;;
	INC OLED_POS			;;
	MOV #OLED_AMT_K,W0		;;
	CP OLED_POS			;;
	BRA LTU,DAK_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x2005,W0			;;
	MOV W0,UTX_CMD			;;
	MOV DIM_SET,W0			;;
	AND #255,W0			;;
	MOV W0,UTX_PARA0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #FLASH_TMP,W3		;;
	MOVLF #OLED_AMT_K,UTX_BUFFER_LEN;;
	BSF U1U2_F			;;
	CALL UTX_BUFFER			;;
	BCF U1U2_F			;;
	POP OLED_POS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_KBSTA_ADR:				;;
	MOV #NOWKEY_STA_BUF,W1		;;
	MOV #OLED_AMT_K,W0		;;
	SL W0,#1,W0			;;
	MUL NOWKB_INX			;;
	ADD W2,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OLED_POS,W0			;;
	SL W0,#1,W0 			;;
	ADD W0,W1,W1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;NOWKB_INX,OLED_POS



        
        
        


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_ALL_KEY_STATUS:			;;
	CLR NOWKB_INX			;;
LOAD_ALL_KEY_STATUS_X:			;;		
	CLR OLED_POS			;;	
LAKS_0:					;;
	CALL LOAD_KEY_ACT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF #0,NOWKEY_STA0		;;	
	MOV #0xCDAB,W0			;;
	MOV #FLASH_TMP,W1		;;
	MOV [W1],W2			;;
	CP W2,W0			;;
	BRA Z,LAKS_1			;;
	MOV #0x000F,W0			;;
	MOV W0,NOWKEY_STA0		;;
	BRA LAKS_2			;;
LAKS_1:					;;
	BSET NOWKEY_STA0,#4		;;YES IMAGE	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+2,W1		;;
	MOV [W1],W2			;;
	BTSC W2,#0			;;
	BSET NOWKEY_STA0,#5		;;ASCII/HEX	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC W2,#14			;;
	BSET NOWKEY_STA0,#6		;;SERIAL CH 				
	BTSC W2,#15			;;
	BSET NOWKEY_STA0,#7		;;SERIAL CH				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(FLASH_TMP+0x0D),W1	;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BTSS SR,#Z			;;
	BSET NOWKEY_STA0,#8		;;SWITCH PAGE0 EXIST				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(FLASH_TMP+0x10),W1	;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BTSS SR,#Z			;;
	BSET NOWKEY_STA0,#9		;;SWITCH PAGE1 EXIST				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(FLASH_TMP+0x13),W1	;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BTSS SR,#Z			;;
	BSET NOWKEY_STA0,#10		;;SWITCH PAGE2 EXIST				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(FLASH_TMP+0x16),W1	;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BTSS SR,#Z			;;
	BSET NOWKEY_STA0,#11		;;SWITCH PAGE3 EXIST				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(FLASH_TMP+0x19),W1	;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BTSS SR,#Z			;;
	BSET NOWKEY_STA0,#12		;;SWITCH PAGE4 EXIST				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(FLASH_TMP+0x1C),W1	;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BTSS SR,#Z			;;
	BSET NOWKEY_STA0,#13		;;SWITCH PAGE5 EXIST				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(FLASH_TMP+0x1F),W1	;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BTSS SR,#Z			;;
	BSET NOWKEY_STA0,#14		;;SWITCH PAGE6 EXIST				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(FLASH_TMP+0x22),W1	;;
	CALL GET_3BADRX4		;;
	MOV FADR0,W0			;;
	IOR FADR1,WREG			;;
	BTSS SR,#Z			;;
	BSET NOWKEY_STA0,#15		;;SWITCH PAGE7 EXIST				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LAKS_2:					;;
	CALL GET_KBSTA_ADR		;;
	MOV NOWKEY_STA0,W0		;;
	MOV W0,[W1++]			;;
	INC OLED_POS			;;
	MOV #OLED_AMT_K,W0		;;
	CP OLED_POS			;;
	BRA LTU,LAKS_0			;;
	CLR OLED_POS			;;
	INC NOWKB_INX			;;	
	MOV #7,W0			;;
	CP NOWKB_INX			;;
	BRA LTU,LAKS_0			;;
	CLR NOWKB_INX			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KBTEST0_PRG:				;;
	MOV #0x3000,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KBTEST1_PRG:				;;
	MOV #0x3001,W1			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KBTEST2_PRG:				;;
	MOV #0x3002,W2			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KBTEST3_PRG:				;;
	MOV #0x3003,W3			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	


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
GET_KEYCODE:				;;
	CLR KEYCODE			;;
	MOV KEYDATA0,W0			;;
	IOR KEYDATA1,WREG		;;
	IOR KEYDATA2,WREG		;;
	IOR KEYDATA3,WREG		;;
	IOR KEYDATA4,WREG		;;
	IOR KEYDATA5,WREG		;;
	IOR KEYDATA6,WREG		;;
	IOR KEYDATA7,WREG		;;
	MOV #0xFFF,W2			;;
	AND W0,W2,W0			;;
	CP0 W0				;;
	BRA NZ,$+4			;;
	RETURN	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W2				;;
KEYPRG_0:				;;
	MOV #KEYDATA0,W1		;;
	ADD W2,W1,W1			;;
	ADD W2,W1,W1			;;
	MOV [W1],W0			;;
	CP0 W0				;;
	BRA NZ,KEYPRG_IN		;;
	INC W2,W2			;;		
	CP W2,#8			;;
	BRA LTU,KEYPRG_0		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPRG_IN:				;;
	MOV W0,W1			;;
	CLR W4				;;
KEYPRG_IN_0:				;;
	MOV #1,W0			;;
	SL W0,W4,W0			;;
	AND W0,W1,W0			;;
	BRA NZ,KEYPRG_IN_1		;;
	INC W4,W4			;;
	MOV #12,W0			;;
	CP W4,W0			;;
	BRA LTU,KEYPRG_IN_0		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPRG_IN_1:
	MOV #12,W0
	MUL.UU W0,W2,W2
	ADD W2,W4,W0
	INC W0,W0
	CALL KEYTBL
	MOV W0,KEYCODE
	NOP
	NOP
	NOP
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				

KEYTBL:
	BRA W0
	RETLW #0x00,W0			;;0x00
	RETLW #0x1D,W0			;;0x01
	RETLW #0x2D,W0			;;0x02
	RETLW #0x3D,W0			;;0x03
	RETLW #0x4D,W0			;;0x04
	RETLW #0x1E,W0			;;0x05
	RETLW #0x2E,W0			;;0x06
	RETLW #0x3E,W0			;;0x07
	RETLW #0x4E,W0			;;0x08
	RETLW #0x1F,W0			;;0x09
	RETLW #0x2F,W0			;;0x0A
	RETLW #0x3F,W0			;;0x0B
	RETLW #0x4F,W0			;;0x0C
	RETLW #0x20,W0			;;0x0D
	RETLW #0x30,W0			;;0x0E
	RETLW #0x40,W0			;;0x0F
					
	RETLW #0x50,W0			;;0x10
	RETLW #0x21,W0			;;0x11
	RETLW #0x31,W0			;;0x12
	RETLW #0x41,W0			;;0x13
	RETLW #0x51,W0			;;0x14
	RETLW #0x22,W0			;;0x15
	RETLW #0x32,W0			;;0x16
	RETLW #0x42,W0			;;0x17
	RETLW #0x52,W0			;;0x18
	RETLW #0x23,W0			;;0x19
	RETLW #0x33,W0			;;0x1A
	RETLW #0x43,W0			;;0x1B
	RETLW #0x53,W0			;;0x1C
	RETLW #0x24,W0			;;0x1D
	RETLW #0x34,W0			;;0x1E
	RETLW #0x44,W0			;;0x1F

	RETLW #0x54,W0			;;0x20
	RETLW #0x25,W0			;;0x21
	RETLW #0x35,W0			;;0x22
	RETLW #0x45,W0			;;0x23
	RETLW #0x55,W0			;;0x24
	RETLW #0x26,W0			;;0x25
	RETLW #0x36,W0			;;0x26
	RETLW #0x46,W0			;;0x27
	RETLW #0x56,W0			;;0x28
	RETLW #0x27,W0			;;0x29
	RETLW #0x37,W0			;;0x2A
	RETLW #0x47,W0			;;0x2B
	RETLW #0x57,W0			;;0x2C
	RETLW #0x28,W0			;;0x2D
	RETLW #0x38,W0			;;0x2E
	RETLW #0x48,W0			;;0x2F

	RETLW #0x58,W0			;;0x30
	RETLW #0x29,W0			;;0x31
	RETLW #0x39,W0			;;0x32
	RETLW #0x49,W0			;;0x33
	RETLW #0x59,W0			;;0x34
	RETLW #0x2A,W0			;;0x35
	RETLW #0x3A,W0			;;0x36
	RETLW #0x4A,W0			;;0x37
	RETLW #0x5A,W0			;;0x38
	RETLW #0x2B,W0			;;0x39
	RETLW #0x3B,W0			;;0x3A
	RETLW #0x4B,W0			;;0x3B
	RETLW #0x00,W0			;;0x3C
	RETLW #0x5B,W0			;;0x3D
	RETLW #0x2C,W0			;;0x3E
	RETLW #0x3C,W0			;;0x3F

	RETLW #0x4C,W0			;;0x40
	RETLW #0x5C,W0			;;0x41
	RETLW #0x01,W0			;;0x42
	RETLW #0x02,W0			;;0x43
	RETLW #0x03,W0			;;0x44
	RETLW #0x04,W0			;;0x45
	RETLW #0x05,W0			;;0x46
	RETLW #0x06,W0			;;0x47
	RETLW #0x00,W0			;;0x48
	RETLW #0x07,W0			;;0x49
	RETLW #0x08,W0			;;0x4A
	RETLW #0x09,W0			;;0x4B
	RETLW #0x0A,W0			;;0x4C
	RETLW #0x0B,W0			;;0x4D
	RETLW #0x0C,W0			;;0x4E
	RETLW #0x0D,W0			;;0x4F

	RETLW #0x0E,W0			;;0x50
	RETLW #0x0F,W0			;;0x51
	RETLW #0x10,W0			;;0x52
	RETLW #0x11,W0			;;0x53
	RETLW #0x00,W0			;;0x54
	RETLW #0x12,W0			;;0x55
	RETLW #0x13,W0			;;0x56
	RETLW #0x14,W0			;;0x57
	RETLW #0x15,W0			;;0x58
	RETLW #0x16,W0			;;0x59
	RETLW #0x17,W0			;;0x5A
	RETLW #0x18,W0			;;0x5B
	RETLW #0x19,W0			;;0x5C
	RETLW #0x1A,W0			;;0x5D
	RETLW #0x1B,W0			;;0x5E
	RETLW #0x1C,W0			;;0x5F















	


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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_KEYDATA:				;;
	MOV #0xABCD,W0			;;
	CP I2C_DATA0			;;
	BRA Z,$+4			;;
	RETURN				;;
	CLR I2C_DATA0			;;
	MOV I2C_DATA1,W0		;;
	MOV W0,KEYCODE			;;
	BSF KEYCODE_IN_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
SETID_KEYIN_PRG:			;;
	BTFSS KEYCODE_IN_F		;;
	RETURN				;;
	RETURN				;;
	MOV KEYCODE,W0			;;
	SWAP W0				;;
	AND #255,W0			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV #KEYTBL_BUF,W1		;;
	MOV KEYCODE,W0			;;
	AND #127,W0			;;
	SL W0,#1,W0			;;
	ADD W0,W1,W1			;;
	MOV SETKEY_ID,W0		;;
	SWAP W0				;;
	IOR KEYCODE,WREG		;;
	MOV W0,[W1]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NKEYBO:					;;
	CLR R0				;;KEY PUSH CODE
	CLR R1				;;KEY RELEASE CODEG
	CLR R2				;;KEY PUSH CONTINUE 1
	CLR R3				;;KEY PUSH CONTINUE 2
	BTFSC SET_KEYID_F		;;
	BRA SETID_KEYIN_PRG		;;	
	BTFSS KEYCODE_IN_F		;;
	RETURN				;;
	BCF KEYCODE_IN_F		;;
	MOV KEYCODE,W0			;;
	MOV #F24KEY_FADR,W1		;;
	MOV KEYCODE,W0			;;
	AND #127,W0			;;
	SL W0,#1,W0			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W2		;;
	SWAP W2				;;
	AND #255,W2			;;
	MOV #OLED_AMT_K,W0		;;
	CP W2,W0			;;
	BRA LTU,$+4			;;
	RETURN				;;
	INC W2,W2			;;
	MOV KEYCODE,W0			;;
	SWAP W0				;;
	AND #3,W0			;;
	BRA W0				;;
	BRA NKEYBO_0			;;
	BRA NKEYBO_1			;;
	BRA NKEYBO_2			;;
	BRA NKEYBO_3			;;
NKEYBO_0:				;;
	BCF DIS_KFREE_F			;;
	MOV W2,R0			;;
	RETURN				;;
NKEYBO_1:				;;
	BTFSC DIS_KFREE_F		;;
	RETURN				;;
	MOV W2,R1			;;
	RETURN				;;
NKEYBO_2:				;;
	BSF DIS_KFREE_F			;;
	MOV W2,R2			;;
	RETURN				;;
NKEYBO_3:				;;
	MOV W2,R3			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	CLR R0				;;KEY PUSH CODE
	CLR R1				;;KEY RELEASE CODEG
	CLR R2				;;KEY PUSH CONTINUE 1
	CLR R3				;;KEY PUSH CONTINUE 2
	BTFSS T8M_F			;;
	RETURN 				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_KEYCODE		;;
	CP0 KEYCODE			;;
	BRA NZ,YESKEY			;; 	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NOKEY:					;;
	INC NOKEY_CNT			;;
	MOV #4,W0			;;
	CP NOKEY_CNT		        ;;
	BTSS SR,#C			;;
	RETURN				;;
	BSF NOKEY_F			;;		
	MOV KEY_BUF,W0			;;
	BTFSS DISKR_F			;;
	MOV W0,R1			;;
	BCF DISKR_F			;;
	BCF DISKP_F			;;
	BCF KEY_PUSH_F			;;
	CLR KEY_BUF			;;
	CLR KEY_TMP			;;
	CLR YESKEY_CNT			;;
	CLR CONKEY_CNT			;;
 	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
YESKEY:					;;
	CLR NOKEY_CNT			;;
	MOV KEY_TMP,W0			;;
	CP KEYCODE			;;
	BRA Z,YESKEY_1			;;
	CLR YESKEY_CNT			;;		
	CLR CONKEY_CNT			;;
	MOV KEYCODE,W0			;;
	MOV W0,KEY_TMP			;;
	RETURN				;;
YESKEY_1:				;;
	INC YESKEY_CNT			;;		
	MOV #2,W0			;;
	CP YESKEY_CNT			;;
	BTSS SR,#C			;;
	RETURN				;;
	BTFSC KEY_PUSH_F		;;
	BRA CONKEY			;; 
	MOV KEYCODE,W0			;;
	MOV W0,KEY_BUF			;;
	MOV W0,R0			;;
	BSF KEY_PUSH_F
   	BCF NOKEY_F			;;		
	DEC YESKEY_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONKEY:					;;
	INC CONKEY_CNT			;;
	MOV #250,W0			;;
	CP CONKEY_CNT 			;;
	BTSS SR,#Z			;;
	BRA CONKEY2			;;
	MOV KEYCODE,W0			;;
	MOV W0,R2			;;
	BSF DISKR_F			;;
	RETURN				;;
CONKEY2:				;;
	MOV #500,W0			;;
	CP CONKEY_CNT 			;;
	BTSS SR,#Z			;;
	RETURN				;;
	MOV KEYCODE,W0			;;
	MOV W0,R3			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	






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
	CLR TMR2_FLAG			;;	
	MOV TMR2,W0			;;
	XOR TMR2_BUF,WREG		;;	
	BTSC SR,#Z			;;
	RETURN				;;
	MOV W0,TMR2_FLAG		;;	
	IOR TMR2_IORF			;;
	XOR TMR2_BUF			;;
	CLRWDT				;;
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
	BTFSS T1M_F			;;
	RETURN				;;
	MOV #0xFFFF,W0			;;
	CP U2TX_WAKE_TIM		;;
	BRA Z,TIMEACT_1			;;
	INC U2TX_WAKE_TIM		;;
	MOV #4,W0			;;
	CP U2TX_WAKE_TIM		;;
	BRA NZ,TIMEACT_1		;;
	BTFSS U2TX_WAKE_F		;;
	BRA TIMEACT_1			;;
	CALL U2TX_END_START		;;
	BCF U2TX_WAKE_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TIMEACT_1:		
	CP0 CMDINX
	BRA Z,CMD_NONE_PRG		
	MOV CMDINX,W0
	BRA W0			
	BRA CMD_NONE_PRG
	BRA CMD_STOPALL_PRG
	BRA CMD_FLASH_ERASE_PRG
	BRA CMD_CHK_FLASH_BLANK_PRG
	BRA CMD_ERASE_SCAN_KEY_PRG
	BRA CMD_WRITE_SCAN_KEY_PRG
	BRA CMD_ERASE_ALL_KEY_PRG
	BRA CMD_SET_SCAN_KEY_PRG
	BRA CMD_TEST0_PRG
	BRA CMD_TEST1_PRG
	BRA CMD_TEST2_PRG
	BRA CMD_TEST3_PRG
	BRA CMD_TEST4_PRG
	BRA CMD_TEST5_PRG
	BRA CMD_SET_ONE_KEY_PRG
	BRA CMD_TEST6_PRG
	BRA CMD_TEST7_PRG
	BRA CMD_UTXTEST_PRG
	BRA CMD_RESET_KB_PRG
	RETURN
	RETURN

CMD_NONE_PRG:
	RETURN
CMD_STOPALL_PRG:
	CLR CMDINX
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TEST0_PRG:				;;
	MOVLF #CMD_STOPALL_K,CMDINX	;;
	CALL DISP_ALL_KEY		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
CMD_UTXTEST_PRG:			;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOVLF #1000,CMDTIME		;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CUTP_0			;;
	BRA CUTP_1			;;
	BRA CUTP_2			;;
CUTP_0:					;;
	MOV #UTXTMP,W1			;;
	MOV #0x2180,W0			;;	
	MOV W0,[W1]			;;
	MOV #2,W0			;;
	MOV W0,UTXTMP_LEN		;;
	CALL TRANS_MCUTX2		;;
	INC CMDSTEP			;;
	RETURN				;;
CUTP_1:					;;
	MOV #UTXTMP,W1			;;
	MOV #0x3180,W0			;;	
	MOV W0,[W1]			;;
	MOV #2,W0			;;
	MOV W0,UTXTMP_LEN		;;
	CALL TRANS_MCUTX2		;;
	INC CMDSTEP			;;
	RETURN				;;
CUTP_2:					;;
	MOV #UTXTMP,W1			;;
	MOV #0x1080,W0			;;	
	MOV W0,[W1]			;;
	MOV #2,W0			;;
	MOV W0,UTXTMP_LEN		;;
	CALL TRANS_MCUTX2		;;
	CLR CMDINX			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
CMD_RESET_KB_PRG:			;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CRKP_0			;;
	BRA CRKP_1			;;
CRKP_0:	
	MOV #0x200F,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	MOVLF #2000,CMDTIME		;;
	INC CMDSTEP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
CRKP_1:					;;
	CALL LOAD_KEYTBL		;;	
	CALL CLR_ALL_KB_PAGE		;;
	CALL OLED_RESTART		;;
	CLR CMDINX			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TEST5_PRG:				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CT5P_0			;;
	BRA CT5P_1			;;
CT5P_0:					;;
	MOV #0x200C,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	INC CMDSTEP			;;
	MOVLF #10,CMDTIME		;;
	RETURN				;;
CT5P_1:					;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TEST6_PRG:				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CT6P_0			;;
	BRA CT6P_1			;;
CT6P_0:					;;
	MOV #0x200D,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	INC CMDSTEP			;;
	MOVLF #10,CMDTIME		;;
	RETURN				;;
CT6P_1:					;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
XCMD_TEST7_PRG:				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA XCT7P_0			;;
	BRA XCT7P_1			;;
XCT7P_0:					;;
        MOVLF #0,KB_TYPE_CNT            ;;
        MOVLF #0,KB_PAGE_CNT
        MOVLF #63,OLED_POS              ;;
        INC CMDSTEP                     ;;
        RETURN
XCT7P_1:					;;
        NOP
        NOP
        NOP
        INC KB_PAGE_CNT
        MOV #8,W0
        CP KB_PAGE_CNT
        BRA LTU,XCT7P_1_0
        CLR KB_PAGE_CNT
        INC KB_TYPE_CNT
        MOV #7,W0
        CP KB_TYPE_CNT
        BRA LTU,$+4
        CLR KB_TYPE_CNT
XCT7P_1_0:					;;
	MOVLF #1000,CMDTIME		;;
	MOV #0x2004,W0			;;
	MOV W0,UTX_CMD			;;
	MOVFF KB_PAGE_CNT,UTX_PARA0	;;
	MOVFF KB_TYPE_CNT,UTX_PARA1	;;
	MOV OLED_POS,W0			;;
	MOV W0,SON_SERIAL_ID		;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
        RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TEST7_PRG:				;;
        ;BRA XCMD_TEST7_PRG
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOVLF #1000,CMDTIME		;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CT7P_0			;;
	BRA CT7P_1			;;
CT7P_0:				        ;;
	MOV #0x2003,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
CT7P_1:				        ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TEST4_PRG:				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CT4P_0			;;
	BRA CT4P_1			;;
CT4P_0:					;;
	LOFFS1 KEY_TEST_STR		;;
	MOVLF #0xFFFF,COLOR_F		;;
	MOVLF #32,LCDX			;;	
	MOVLF #24,LCDY			;;
	BSF CLRSCR_F
	CALL U2TX_DISPSTR_ALL		;;
	BCF CLRSCR_F
	INC CMDSTEP			;;
	MOVLF #10,CMDTIME		;;
	RETURN				;;
CT4P_1:					;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




					
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TEST3_PRG:				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CT3P_0			;;
	BRA CT3P_1			;;
	BRA CT3P_2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CT3P_0:					;;
	CLR KB_TEST_CNT			;;
	MOVLF #10,CMDTIME		;;
	INC CMDSTEP			;;
	RETURN				;;
CT3P_1:					;;
	MOV #0x0000,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	MOV #0x2000,W0			;;DRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	INC CMDSTEP			;;
	MOVLF #100,CMDTIME		;;
	RETURN				;;
CT3P_2:					;;
	MOV #0x001F,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	MOV #0x2000,W0			;;DRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
	MOVFF KB_TEST_CNT,SON_SERIAL_ID	;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	INC KB_TEST_CNT			;;
	MOV #OLED_AMT_K,W0		;;
	CP KB_TEST_CNT			;;
	BRA LTU,$+4			;;
	CLR KB_TEST_CNT			;;	
	MOVLF #1,CMDSTEP		;;
	MOVLF #500,CMDTIME		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TEST2_PRG:				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CT2P_0			;;
	BRA CT2P_1			;;
	BRA CT2P_2			;;
	BRA CT2P_3			;;
	BRA CT2P_4			;;
	BRA CT2P_5			;;
	BRA CT2P_6			;;
	BRA CT2P_7			;;
	BRA CT2P_8			;;
	BRA CT2P_9			;;
	BRA CT2P_0			;;
	BRA CT2P_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CT2P_0:					;;
	MOV #0x0000,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	MOV #0x2000,W0			;;DRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	INC CMDSTEP			;;
	MOVLF #100,CMDTIME		;;
	RETURN				;;
CT2P_1:					;;
	MOVLF #0xFFFF,COLOR_F		;;
	BRA CT2P_8_1			;;
CT2P_2:					;;
	MOVLF #0xF800,COLOR_F		;;
	BRA CT2P_8_1			;;
CT2P_3:					;;
	MOVLF #0x07E0,COLOR_F		;;
	BRA CT2P_8_1			;;
CT2P_4:		
	MOVLF #0x001F,COLOR_F		;;
	BRA CT2P_8_1			;;
CT2P_5:					;;
	MOVLF #0x07FF,COLOR_F		;;
	BRA CT2P_8_1			;;
CT2P_6:					;;
	MOVLF #0xFFE0,COLOR_F		;;
	BRA CT2P_8_1			;;
CT2P_7:					;;
	MOVLF #0x4444,COLOR_F		;;
	BRA CT2P_8_1			;;
CT2P_8:		
	MOVLF #0xCCCC,COLOR_F		;;
CT2P_8_1:				;;
	LOFFS1 ABCD_STR			;;
	MOVLF #0,LCDX			;;	
	MOVLF #0,LCDY			;;
	DEC CMDSTEP	
	MOV #16,W0
	MUL CMDSTEP
	MOV W2,LCDY
	INC CMDSTEP
	CALL U2TX_DISPSTR_ALL		;;
	INC KB_TEST_CNT			;;
	MOV #OLED_AMT_K,W0		;;
	CP KB_TEST_CNT			;;
	BRA LTU,$+4			;;
	CLR KB_TEST_CNT			;;	
	INC CMDSTEP			;;
	MOVLF #100,CMDTIME		;;
	RETURN				;;
CT2P_9:					;;
	CLR CMDSTEP			;;
	MOVLF #500,CMDTIME		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TESTx_PRG:				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOVLF #1000,CMDTIME		;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CT2P_0			;;
CTxP_0:					;;
	MOV #0x2003,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_TEST1_PRG:				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOVLF #1000,CMDTIME		;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CT1P_0			;;
	BRA CT1P_1			;;
	BRA CT1P_2			;;
	BRA CT1P_3			;;
	BRA CT1P_4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CT1P_0:					;;
	MOV #0x001F,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	MOV #0x2000,W0			;;DRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	INC CMDSTEP			;;
	RETURN				;;
CT1P_1:					;;
	MOV #0x07E0,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	MOV #0x2000,W0			;;DRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	INC CMDSTEP			;;
	RETURN				;;
CT1P_2:					;;
	MOV #0xF800,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	MOV #0x2000,W0			;;DRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	INC CMDSTEP			;;
	RETURN				;;
CT1P_3:					;;
	MOV #0xFFFF,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	MOV #0x2000,W0			;;DRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	INC CMDSTEP			;;
	RETURN				;;
CT1P_4:					;;
	MOV #0x0000,W0			;;COLOR
	MOV W0,UTX_PARA0		;;
	MOV #0x2000,W0			;;DRAW ALL KEY PANEL WITH SPEC COLOR
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	MOVLF #0,CMDSTEP		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	


;[W1]->[W3]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_ENBUF_STR_ST:			;;
	CLR UTX_BUFFER_LEN		;;
LOAD_ENBUF_STR:				;;
	MOV #0xABCD,W0			;;
	CALL LOAD_ENBUF_W		;;
	MOV LCDX,W0			;;
	CALL LOAD_ENBUF 		;;
	MOV LCDY,W0			;;
	CALL LOAD_ENBUF 		;;
	MOV COLOR_F,W0			;;
	CALL LOAD_ENBUF_W		;;
LOAD_ENBUF_STR_0:			;;
        TBLRDL [W1],W0		        ;;
	BTSC W1,#0			;;
	SWAP W0				;; 
	AND #255,W0			;;
	BRA Z,LOAD_ENBUF_STR_2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL LOAD_ENBUF			;;
	INC W1,W1			;;
	BRA LOAD_ENBUF_STR_0		;;
LOAD_ENBUF_STR_2:			;;
	INC W1,W1			;;
	CALL LOAD_ENBUF			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_ENBUF:				;;
	AND #255,W0			;;
	BTSC UTX_BUFFER_LEN,#0		;;
	BRA LOAD_ENBUF_1		;;
	MOV W0,[W3] 			;;
	INC UTX_BUFFER_LEN		;;
	RETURN
LOAD_ENBUF_1:				;;
	SWAP W0				;;
	IOR W0,[W3],[W3]		;;
	INC UTX_BUFFER_LEN		;;
	INC2 W3,W3			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_ENBUF_W:				;;
	PUSH W0
	CALL LOAD_ENBUF
	POP W0
	SWAP W0
	CALL LOAD_ENBUF
	RETURN

ABCD_STR:
	.ASCII "0123456789ABCDEF\0"


KEY_TEST_STR:
	.ASCII "Key Test\0"
ERASE_FLASH_STR:
	.ASCII "Erase Flash\0"
PROGRAM_FLASH_STR:
	.ASCII "Program Flash\0"
SET_FLASH_STR:
	.ASCII "Set Flash\0"
TEST_STR:
	.ASCII "TEST...\0"
OK_STR:
	.ASCII "OK\0"

ERR_STR:
	.ASCII "ERR\0"


;$1

;CMP W2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
CHK_URX_STA:				;;
	BTFSS ALLKEY_F			;;
	BRA CHKONE_URX_STA		;;
CHKALL_URX_STA:				;;
	CLR W4				;;
CHKALL_URX_STA_0:			;;	
	MOV #URX_STA_BUF,W1		;;
	ADD W4,W1,W1			;;
	ADD W4,W1,W1			;;
	MOV [W1],W0			;;
	CP W0,W2			;;
	BRA NZ,CHKALL_URX_STA_1		;;
	INC W4,W4			;;
	MOV #OLED_AMT_K,W0		;;	
	MOV #1,W0			;;	
	CP W4,W0			;;
	BRA LTU,CHKALL_URX_STA_0	;;
	BSF DONE_F			;;		
	RETURN				;;			
CHKALL_URX_STA_1:			;;
	BCF DONE_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHKONE_URX_STA:				;;
	MOV KB_KEY_CNT,W0		;;
	MOV #URX_STA_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	CP W0,W2			;;
	BRA NZ,CHKONE_URX_STA_1		;;
	BSF DONE_F			;;		
	RETURN				;;			
CHKONE_URX_STA_1:			;;
	BCF DONE_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_URX_STA_BUF:			;;
	MOV #URX_STA_BUF,W1		;;
	REPEAT #(OLED_AMT_K-1)		;;
	CLR [W1++]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;CMP W2


;$4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_DISPSTR_ALL:			;;
	BSF ALLKEY_F			;;
	BRA U2TX_DISPSTR		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_DISPSTR_ONE:			;;
	BCF ALLKEY_F			;;
U2TX_DISPSTR:
	MOV #FLASH_TMP,W3		;;
	CALL LOAD_ENBUF_STR_ST		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x2001,W0			;;
	BTFSS CLRSCR_F			;;
	MOV #0x2002,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	MOV #FLASH_TMP,W3		;;
	BTFSC ALLKEY_F			;;
	BRA U2TX_DISPSTR_1		;;
	MOVFF KB_KEY_CNT,SON_SERIAL_ID	;;
	CALL UTX_BUFFER_ID		;;
	BCF U1U2_F			;;
	RETURN				;;
U2TX_DISPSTR_1:				;;
	CALL UTX_BUFFER			;;
	BCF U1U2_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERASE_SON_FLASH:			;;
	BCF OK_F			;;
	BCF ERR_F			;;
	CP0 S_CMDTIME			;;
	BRA Z,$+6			;;
	DEC S_CMDTIME			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV S_CMDSTEP,W0		;;
	BRA W0				;;	
	BRA ESF_J0			;;
	BRA ESF_J1			;;
	BRA ESF_J2			;;
ESF_J0:					;;
	LOFFS1 ERASE_FLASH_STR		;;
	MOVLF #0xFFFF,COLOR_F		;;
	MOVLF #0,LCDX			;;	
	MOVLF #0,LCDY			;;
	BSF CLRSCR_F			;;
	CALL U2TX_DISPSTR		;;
	BCF CLRSCR_F			;;
	INC S_CMDSTEP			;;
	MOVLF #10,S_CMDTIME		;;
	RETURN				;;
ESF_J1:					;;
	MOV #0x1004,W0			;;erase_flash
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	BTFSS ALLKEY_F			;;
	CALL UTX_STD_ONE		;;
	BTFSC ALLKEY_F			;;
	CALL UTX_STD_ALL		;;
	BCF U1U2_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #URX_STA_BUF,W1		;;CLE ALL BACK STATUS
	REPEAT #(OLED_AMT_K-1)		;;
	CLR [W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC S_CMDSTEP			;;
	CLR S_CMDCNT0			;;
	MOVLF #200,S_CMDTIME		;;
	RETURN				;;
ESF_J2:					;;
	INC S_CMDCNT0			;;
	MOV #1000,W0			;;
	CP S_CMDCNT0			;;
	BRA LTU,$+8			;;	
	CLR S_CMDINX			;;
	BSF ERR_F			;;
	RETURN 				;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #2,W2			;;COMP STATUS VALUE
	CALL CHK_URX_STA		;;
	BTFSC DONE_F			;;
	BRA ESF_J2_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1005,W0			;;DELAY TX FLASH STATUS
	MOV W0,UTX_CMD			;;
	MOVLF #0,UTX_PARA0		;;DELAY TIME X SERIAL ID
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	MOVLF #10,S_CMDTIME		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ESF_J2_1:				;;
	BSF OK_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRITE_SON_FLASH:			;;
	BCF OK_F			;;
	BCF ERR_F			;;
	CP0 S_CMDTIME			;;
	BRA Z,$+6			;;
	DEC S_CMDTIME			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV S_CMDSTEP,W0		;;
	BRA W0				;;	
	BRA WSF_J0			;;
	BRA WSF_J1			;;
	BRA WSF_J2			;;
	BRA WSF_J3			;;
	BRA WSF_J4			;;
WSF_J0:					;;
	LOFFS1 PROGRAM_FLASH_STR	;;
	MOVLF #0xFFFF,COLOR_F		;;
	MOVLF #0,LCDX			;;	
	MOVLF #0,LCDY			;;
	BSF CLRSCR_F			;;	
	CALL U2TX_DISPSTR		;;
	BCF CLRSCR_F			;;
	INC S_CMDSTEP			;;
	MOVLF #10,S_CMDTIME		;;
	CLR KB_TYPE_CNT			;;
	CLR KB_PAGE_CNT			;;
	CLR KB_X256_CNT			;;
	RETURN				;;
WSF_J1:					;;
        CP0 KB_X256_CNT                 ;;
        BRA NZ,GGHHY
        NOP
        NOP
        NOP
GGHHY:
	CALL LOAD_KEY_DATA		;;
	BTFSC DONE_F			;;
	BRA WSF_J1_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR KB_X256_CNT			;;
	INC KB_PAGE_CNT			;;	
	MOV #8,W0			;;
	CP KB_PAGE_CNT			;;
	BRA LTU,WSF_J1			;;
	CLR KB_PAGE_CNT			;;
	INC KB_TYPE_CNT			;;
	MOV #7,W0			;;
	CP KB_TYPE_CNT			;;
	BRA LTU,WSF_J1			;;
	MOV #3,W0			;;
	MOV W0,S_CMDSTEP		;;	
	MOVLF #10,S_CMDTIME		;;
	RETURN				;;
WSF_J1_1:				;;
	MOV KB_TYPE_CNT,W0		;;
	SWAP W0				;;
	IOR KB_PAGE_CNT,WREG		;;
	MOV W0,UTX_PARA0		;;
	MOVFF KB_X256_CNT,UTX_PARA1	;;
	MOVFF KB_X256_TH,UTX_PARA2	;;
	MOV #0x1007,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	MOV #FLASH_TMP,W3		;;
	MOVFF KB_KEY_CNT,SON_SERIAL_ID	;;
	MOVLF #256,UTX_BUFFER_LEN	;;	
	BSF U1U2_F			;;	
	CALL UTX_BUFFER_ID		;;
	BCF U1U2_F			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC KB_X256_CNT			;;
	MOV KB_X256_TH,W0		;;
	CP KB_X256_CNT			;;
	BRA LTU,WSF_J1_2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR KB_X256_CNT			;;
	INC KB_PAGE_CNT			;;	
	MOV #8,W0			;;
	CP KB_PAGE_CNT			;;
	BRA LTU,WSF_J1_2		;;
	CLR KB_PAGE_CNT			;;
	INC KB_TYPE_CNT			;;
	MOV #7,W0			;;
	CP KB_TYPE_CNT			;;
	BRA LTU,WSF_J1_2		;;
	CLR KB_TYPE_CNT			;;
	MOV #3,W0			;;
	MOV W0,S_CMDSTEP		;;	
	MOVLF #10,S_CMDTIME		;;
	RETURN
WSF_J1_2:				;;
	INC S_CMDSTEP			;;	
	MOVLF #4,S_CMDTIME		;;
	CLR S_CMDCNT0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KB_KEY_CNT,W0		;;
	MOV #URX_STA_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	CLR [W1]			;;
	RETURN				;;
WSF_J2:					;;
	INC S_CMDCNT0			;;
	MOV #100,W0			;;
	CP S_CMDCNT0			;;
	BRA GEU,WSF_J2_TOVER		;;
	MOV KB_KEY_CNT,W0		;;
	MOV #URX_STA_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	CP W0,#1			;;
	BRA Z,WSF_J2_ERR		;;
	CP W0,#2			;;
	BRA Z,WSF_J2_OK			;;
	MOVLF #4,S_CMDTIME		;;
	RETURN				;;
WSF_J2_TOVER:				;;
	BSF ERR_F			;;	
	MOVLF #4,S_CMDSTEP		;;
	RETURN				;;
WSF_J2_ERR:				;;
	BSF ERR_F			;;	
	MOVLF #4,S_CMDSTEP		;;
	RETURN				;;
WSF_J2_OK:				;;
	MOVLF #1,S_CMDSTEP		;;
	MOVLF #10,S_CMDTIME		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WSF_J3:					;;
	MOVFF KB_KEY_CNT,SON_SERIAL_ID	;;
	MOV #0x1008,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	INC S_CMDINX			;;
	MOVLF #10,S_CMDTIME		;;
	BSF OK_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WSF_J4:					;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_URX_STA:				;; 
	MOV KB_KEY_CNT,W0		;;
	MOV #URX_STA_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	CLR [W1]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_URX_STA:				;; 
	MOV KB_KEY_CNT,W0		;;
	MOV #URX_STA_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;$4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_SON_FLASH:				;;
	BCF OK_F			;;
	BCF ERR_F			;;
	CP0 S_CMDTIME			;;
	BRA Z,$+6			;;
	DEC S_CMDTIME			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV S_CMDSTEP,W0		;;
	BRA W0				;;	
	BRA SSF_J0			;;
	BRA SSF_J1			;;
	BRA SSF_J2			;;
	BRA SSF_J3			;;
	BRA SSF_J4			;;
	BRA SSF_J5			;;
	BRA SSF_J6			;;
	BRA SSF_J7			;;
	BRA SSF_J8			;;
	BRA SSF_J9			;;
	BRA SSF_J10			;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SSF_J0:					;;
	MOVFF KB_KEY_CNT,SON_SERIAL_ID	;;
	LOFFS1 SET_FLASH_STR		;;
	MOVLF #0xFFFF,COLOR_F		;;
	MOVLF #0,LCDX			;;	
	MOVLF #0,LCDY			;;
	BSF CLRSCR_F			;;
	CALL U2TX_DISPSTR		;;
	BCF CLRSCR_F			;;
	INC S_CMDSTEP			;;
	MOVLF #12,S_CMDTIME		;;
	CLR KB_TYPE_CNT			;;
	CLR KB_PAGE_CNT			;;
	CLR KB_X256_CNT			;;
	RETURN				;;
SSF_J1:					;;
	MOVFF KB_KEY_CNT,SON_SERIAL_ID	;;
	MOV #0x1009,W0			;;GET CHKSUM
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;	
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;	
	INC S_CMDSTEP			;;
	MOVLF #4,S_CMDTIME		;;
	CALL CLR_URX_STA		;;
	CLR S_CMDCNT0			;;
	RETURN				;;	
SSF_J2:					;;
	MOVLF #100,S_CMDTIME		;;
	INC S_CMDCNT0			;;
	MOV #10,W0			;;
	CP S_CMDCNT0			;;
	BRA GEU,SSF_J2_TOVER		;;
	CALL GET_URX_STA		;;
	CP W0,#2			;;
	BRA Z,$+4			;;
	RETURN				;;		
	CALL LOAD_KEY_CHKSUM		;;
        ;BRA SSF_J2_1			;;<<DEBUG
	BRA NZ,SSF_J2_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 OK_STR			;;
	MOVLF #0x07F0,COLOR_F		;;
	MOVLF #112,LCDX			;;	
	MOVLF #0,LCDY			;;
	BCF CLRSCR_F			;;
	CALL U2TX_DISPSTR		;;
	MOVLF #10,S_CMDSTEP		;;
	BSF OK_F			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SSF_J2_1:				;;
	INC S_CMDSTEP			;;
	MOVLF #4,S_CMDTIME		;;
	RETURN				;;
SSF_J2_TOVER:				;;
	LOFFS1 ERR_STR			;;
	MOVLF #0x001F,COLOR_F		;;
	MOVLF #104,LCDX			;;	
	MOVLF #0,LCDY			;;
	BCF CLRSCR_F			;;
	CALL U2TX_DISPSTR		;;
	MOVLF #10,S_CMDSTEP		;;
	BSF ERR_F			;;
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SSF_J3:					;;
	LOFFS1 ERASE_FLASH_STR		;;
	MOVLF #0xFFFF,COLOR_F		;;
	MOVLF #0,LCDX			;;	
	MOVLF #16,LCDY			;;
	CALL U2TX_DISPSTR		;;
	INC S_CMDSTEP			;;
	MOVLF #20,S_CMDTIME		;;
	RETURN				;;
SSF_J4:					;;
	MOV #0x1004,W0			;;erase_flash
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CLR_URX_STA		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC S_CMDSTEP			;;
	CLR S_CMDCNT0			;;
	MOVLF #20,S_CMDTIME		;;
	RETURN				;;
SSF_J5:					;;
	INC S_CMDCNT0			;;
	MOV #1000,W0			;;
	CP S_CMDCNT0			;;
	BRA LTU,SSF_J5_1		;;	
	CLR S_CMDINX			;;
	MOVLF #20,S_CMDSTEP		;;
	BSF ERR_F			;;
	RETURN 				;;	
SSF_J5_1:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #2,W2			;;COMP STATUS VALUE
	CALL CHK_URX_STA		;;
	BTFSC DONE_F			;;
	BRA SSF_J5_2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1005,W0			;;DELAY TX FLASH STATUS
	MOV W0,UTX_CMD			;;
	MOVLF #0,UTX_PARA0		;;DELAY TIME X SERIAL ID
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	MOVLF #10,S_CMDTIME		;;
	RETURN				;;
SSF_J5_2:				;;
	INC S_CMDSTEP			;;
	CLR S_CMDCNT0			;;
	MOVLF #20,S_CMDTIME		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;$5
SSF_J6:					;;
	LOFFS1 PROGRAM_FLASH_STR	;;
	MOVLF #0xFFFF,COLOR_F		;;
	MOVLF #0,LCDX			;;	
	MOVLF #32,LCDY			;;
	CALL U2TX_DISPSTR		;;
	INC S_CMDSTEP			;;
	MOVLF #10,S_CMDTIME		;;
	CLR KB_TYPE_CNT			;;
	CLR KB_PAGE_CNT			;;
	CLR KB_X256_CNT			;;
	RETURN				;;
SSF_J7:					;;
        CP0 KB_X256_CNT
        BRA NZ,XXX1
        NOP
        NOP
        NOP
XXX1:
	CALL LOAD_KEY_DATA		;;
	BTFSC DONE_F			;;
	BRA SSF_J7_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR KB_X256_CNT			;;
	INC KB_PAGE_CNT			;;	
	MOV #8,W0			;;
	CP KB_PAGE_CNT			;;
	BRA LTU,SSF_J7			;;
	CLR KB_PAGE_CNT			;;
	INC KB_TYPE_CNT			;;
	MOV #7,W0			;;
	CP KB_TYPE_CNT			;;
	BRA LTU,SSF_J7			;;
	MOV #9,W0			;;
	MOV W0,S_CMDSTEP		;;	
	MOVLF #10,S_CMDTIME		;;
	RETURN				;;
SSF_J7_1:				;;
       	MOV KB_TYPE_CNT,W0		;;
	SWAP W0				;;
	IOR KB_PAGE_CNT,WREG		;;
	MOV W0,UTX_PARA0		;;
	MOVFF KB_X256_CNT,UTX_PARA1	;;
	MOVFF KB_X256_TH,UTX_PARA2	;;
	MOV #0x1007,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	MOV #FLASH_TMP,W3		;;
	MOVFF KB_KEY_CNT,SON_SERIAL_ID	;;
	MOVLF #256,UTX_BUFFER_LEN	;;	
	BSF U1U2_F			;;	
	CALL UTX_BUFFER_ID		;;
	BCF U1U2_F			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC KB_X256_CNT			;;
	MOV KB_X256_TH,W0		;;
	CP KB_X256_CNT			;;
	BRA LTU,SSF_J7_2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR KB_X256_CNT			;;
	INC KB_PAGE_CNT			;;	
	MOV #8,W0			;;
	CP KB_PAGE_CNT			;;
	BRA LTU,SSF_J7_2		;;
	CLR KB_PAGE_CNT			;;
	INC KB_TYPE_CNT			;;
	MOV #7,W0			;;
	CP KB_TYPE_CNT			;;
	BRA LTU,SSF_J7_2		;;
	CLR KB_TYPE_CNT			;;
	MOV #9,W0			;;
	MOV W0,S_CMDSTEP		;;	
	MOVLF #10,S_CMDTIME		;;
	RETURN				;;
SSF_J7_2:				;;
	INC S_CMDSTEP			;;	
	MOVLF #4,S_CMDTIME		;;
	CLR S_CMDCNT0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CLR_URX_STA		;;
	RETURN				;;
SSF_J8:					;;
	INC S_CMDCNT0			;;
	MOV #100,W0			;;
	CP S_CMDCNT0			;;
	BRA GEU,SSF_J8_TOVER		;;
	MOV KB_KEY_CNT,W0		;;
	MOV #URX_STA_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	CP W0,#1			;;
	BRA Z,SSF_J8_ERR		;;
	CP W0,#2			;;
	BRA Z,SSF_J8_OK			;;
	MOVLF #4,S_CMDTIME		;;
	RETURN				;;
SSF_J8_TOVER:				;;
SSF_J8_ERR:				;;
	LOFFS1 ERR_STR			;;
	MOVLF #0x001F,COLOR_F		;;
	MOVLF #104,LCDX			;;	
	MOVLF #32,LCDY			;;
	BCF CLRSCR_F			;;
	CALL U2TX_DISPSTR		;;
	MOVLF #10,S_CMDSTEP		;;
	BSF ERR_F			;;
	RETURN				;;
SSF_J8_OK:				;;
	MOVLF #7,S_CMDSTEP		;;
	MOVLF #10,S_CMDTIME		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SSF_J9:					;;
	MOVFF KB_KEY_CNT,SON_SERIAL_ID	;;
	MOV #0x1008,W0			;;
	MOV W0,UTX_CMD			;;
	BSF U1U2_F			;;
	CALL UTX_STD_ONE		;;
	BCF U1U2_F			;;
	INC S_CMDINX			;;
	MOVLF #10,S_CMDTIME		;;
	BSF OK_F			;;
	INC S_CMDSTEP			;;
	RETURN				;;
SSF_J10:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;$6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_KEY_DATA:				;;
	BSF DONE_F			;;
	CP0 KB_X256_CNT			;;
	BRA NZ,LSFD_1			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KB_TYPE_CNT,W0		;;
	MOV #0x2000,W0			;;
	MUL KB_TYPE_CNT			;;
	MOV W2,FADR0			;;
	MOV W3,FADR1			;;
	MOV #0x40,W0			;;
	MUL KB_KEY_CNT			;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;			
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0x1120,W0			;;
	ADD FADR0			;;
	MOV #0,W0			;;
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL READ_FLASH_64B		;;
	MOV #FLASH_TMP,W1		;;
	MOV [W1],W0			;;
	MOV #0xCDAB,W2			;;
	CP W0,W2			;;
	BRA Z,LSFD_0			;;
	BCF DONE_F			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LSFD_0:					;;
	CALL LOAD_FLASH_IMAGE_START	;;
	BTFSC READ_IMAGE_ERR_F		;;
	BCF DONE_F			;;
	RETURN				;;
LSFD_1:					;;
	MOVFF FADR0_BAK,FADR0		;;
	MOVFF FADR1_BAK,FADR1		;;
	CALL READ_FLASH_PAGE		;;
	MOVFF FADR0,FADR0_BAK		;;	
	MOVFF FADR1,FADR1_BAK		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_KEY_CHKSUM:			;;
	CLR KB_TYPE_CNT			;;
	CLR KB_PAGE_CNT			;;
LKC_0:					;;
	MOV KB_TYPE_CNT,W0		;;
	MOV #0x2000,W0			;;
	MUL KB_TYPE_CNT			;;
	MOV W2,FADR0			;;
	MOV W3,FADR1			;;
	MOV #0x40,W0			;;
	MUL KB_KEY_CNT			;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;			
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0x1120,W0			;;
	ADD FADR0			;;
	MOV #0,W0			;;
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL READ_FLASH_64B		;;
	MOV #FLASH_TMP,W1		;;
	MOV [W1],W0			;;
	MOV #0xCDAB,W2			;;
	CP W0,W2			;;
	BRA NZ,LKC_01			;;
	CALL LOAD_FLASH_IMAGE_START	;;
	BTFSC READ_IMAGE_ERR_F		;;
	BRA LKC_01			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+12,W1		;;
	MOV [W1++],W0			;;
	MOV W0,R0			;;
	MOV [W1++],W0			;;
	MOV W0,R1			;;
	BRA LKC_02			;;
LKC_01:					;;
	MOV #32,W0			;;
	MUL KB_TYPE_CNT			;;
	MOV KB_PAGE_CNT,W0		;;
	SL W0,#2,W0			;;
	ADD W0,W2,W2			;;
	MOV RX_ADDR,W3			;;
	ADD #10,W3			;;
	ADD W2,W3,W3			;;
	MOV [W3++],W0			;;
	MOV W0,W4			;;
	MOV [W3++],W0			;;
	MOV W0,W5			;;
	IOR W4,W5,W0			;;
	BRA Z,LKC_1			;;
	MOV #0xFFAB,W0			;;
	CP W0,W4			;;
	BRA NZ,LKC_DIFF			;;
	CP W0,W5			;;
	BRA NZ,LKC_DIFF			;;
	BRA LKC_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LKC_02:					;;
	MOV #32,W0			;;
	MUL KB_TYPE_CNT			;;
	MOV KB_PAGE_CNT,W0		;;
	SL W0,#2,W0			;;
	ADD W0,W2,W2			;;
	MOV RX_ADDR,W3			;;
	ADD #10,W3			;;
	ADD W2,W3,W3			;;
	MOV [W3++],W0			;;
	CP R0				;;
	BRA NZ,LKC_DIFF			;;
	MOV [W3++],W0			;;
	CP R1				;;
	BRA NZ,LKC_DIFF			;;
	NOP
LKC_1:					;;
	INC KB_PAGE_CNT			;;
	MOV #8,W0			;;		
	CP KB_PAGE_CNT			;;
	BRA LTU,LKC_0			;;
	CLR KB_PAGE_CNT			;;
	INC KB_TYPE_CNT			;;
	MOV #3,W0			;;<<DEBUG
	CP KB_TYPE_CNT			;;
	BRA LTU,LKC_0			;;
	CLR KB_TYPE_CNT			;;

	BSET SR,#Z			;;
	RETURN				;;
LKC_DIFF:				;;
	BCLR SR,#Z			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


GET_KB_PAGE_ADDR:
	MOV KB_PAGE_CNT,W0
	AND #7,W0
	BRA W0
	RETLW #0x25,W0
	RETLW #0x28,W0
	RETLW #0x2B,W0
	RETLW #0x2E,W0
	RETLW #0x31,W0
	RETLW #0x34,W0
	RETLW #0x37,W0
	RETLW #0x3A,W0

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_FLASH_IMAGE_START:			;;	
	BCF READ_IMAGE_ERR_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_KB_PAGE_ADDR		;;
	MOV #FLASH_TMP,W1		;;
	ADD W0,W1,W1			;;
	CALL LOAD_W1_2B			;;
	MOV W0,FADR0			;;
	CALL LOAD_W1_1B			;;
	MOV W0,FADR1			;;
        MOV FADR0,W0
        IOR FADR1,WREG
        BRA NZ,LFIS_1
	BSF READ_IMAGE_ERR_F		;;
	RETURN				;;
LFIS_1:
	BCLR SR,#C			;;
	RLC FADR0			;;
	RLC FADR1			;;
	BCLR SR,#C			;;
	RLC FADR0			;;
	RLC FADR1			;;
	CALL READ_FLASH_PAGE		;;
	MOVFF FADR0,FADR0_BAK		;;
	MOVFF FADR1,FADR1_BAK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP,W1		;;
	MOV [W1],W0			;;
	MOV #0xCDAB,W2			;;
	CP W2,W0			;;
	BRA Z,$+6			;;
	BSF READ_IMAGE_ERR_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+4,W1		;;
	CALL LOAD_W1_2B			;;
	MOV W0,W2			;;
	MOV #0,W3			;;
	AND #255,W0			;;
	BTSS SR,#Z			;;
	MOV #1,W3			;;
	MOV W2,W0			;;
	SWAP W0				;;	
	AND #255,W0			;;
	ADD W0,W3,W0			;;
	MOV W0,KB_X256_TH		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



LOAD_FLASH_IMAGE:			;;	
	BCF READ_IMAGE_ERR_F		;;
	CP0 KB_X256_CNT			;;
	BRA NZ,LOAD_FLASH_IMAGE_1	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_KB_PAGE_ADDR		;;
	MOV #FLASH_TMP,W1		;;
	ADD W0,W1,W1			;;
	CALL LOAD_W1_2B			;;
	MOV W0,FADR0			;;
	CALL LOAD_W1_1B			;;
	MOV W0,FADR1			;;
	BCLR SR,#C			;;
	RLC FADR0			;;
	RLC FADR1			;;
	BCLR SR,#C			;;
	RLC FADR0			;;
	RLC FADR1			;;
	CALL READ_FLASH_PAGE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP,W1		;;
	MOV [W1],W0			;;
	MOV #0xCDAB,W2			;;
	CP W2,W0			;;
	BRA Z,$+6			;;
	BSF READ_IMAGE_ERR_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_TMP+4,W1		;;
	CALL LOAD_W1_2B			;;
	MOV W0,W2			;;
	MOV #0,W3			;;
	AND #255,W0			;;
	BTSS SR,#Z			;;
	MOV #1,W3			;;
	MOV W2,W0			;;
	SWAP W0				;;	
	AND #255,W0			;;
	ADD W0,W3,W0			;;
	MOV W0,KB_X256_TH		;;
	INC KB_X256_CNT			;;
	RETURN				;;
LOAD_FLASH_IMAGE_1:			;;
	CALL READ_FLASH_PAGE		;;
	INC KB_X256_CNT			;;
	MOV KB_X256_TH,W0		;;
	CP KB_X256_CNT			;;
	BRA GEU,$+4			;;
	RETURN				;;
	BSF READ_IMAGE_ERR_F		;;
	RETURN				;;
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





;$2
READ_KEYHEAD:
	MOV #FLASH_TMP,W1
	MOV #0x0001,W0
	MOV #128,W2
READ_KEYHEAD_1:
	MOV W0,[W1++]
	ADD #0x101,W0
	DEC W2,W2
	BRA NZ,READ_KEYHEAD_1
	RETURN
	



	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_FLASH_ERASE_PRG:			;;	
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOVLF #16,CMDTIME		;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CFEP_0			;;
	BRA CFEP_1			;;
	BRA CFEP_2			;;
CFEP_0:					;;
	BTFSC U1TX_EN_F			;;
	RETURN				;;
	CLR UTX_PARA0			;;
	SETM UTX_PARA1			;;
	;=================================
	CALL CHK_FLASH_READY		;;
	BTSS SPIBUF,#0			;;
	BRA $+8				;;
	CALL UTX_I_AM_BUZY		;;
	RETURN				;;
	;=================================
	CALL UTX_I_HAVE_REC		;;
	CALL ERASE_FRAM_ALL		;;
	INC CMDSTEP			;;
	RETURN				;;
CFEP_1:					;;
	INC UTX_PARA0			;;
	MOV #0x0ACD,W0			;;0886
	MOV #0x1510,W0			;;
	MOV W0,UTX_PARA1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_FLASH_READY		;;
	BTSS SPIBUF,#0			;;
	BRA $+8				;;
	CALL UTX_I_AM_BUZY		;;
	RETURN				;;
	NOP				;;
	NOP				;;
	CALL UTX_I_AM_DONE		;;
	INC CMDSTEP			;;
	RETURN				;;
CFEP_2:					;;
	MOV #CMD_STOPALL_K,W0		;;
	MOV W0,CMDINX			;;
	CLR CMDTIME
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;$1



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_ERASE_SCAN_KEY_PRG:			;;	
	BCF ALLKEY_F			;;
	BSF SCANKEY_F			;;
	BCF ONEKEY_F			;;
	MOVLF #0,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TTYYY:
	MOVLF #88,WRITE_KEY_CNT
CMD_ERASE_ONE_KEY_PRG:			;;	
        MOVFF RX_PARA0,WRITE_KEY_CNT
	BCF ALLKEY_F			;;
	BCF SCANKEY_F			;;
	BSF ONEKEY_F			;;
	MOVLF #0,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_ERASE_ALL_KEY_PRG:			;;
        MOV #0XFFFF,W0
        CP RX_PARA0
        BRA NZ,CMD_ERASE_ONE_KEY_PRG
	
	BSF ALLKEY_F			;;
	BCF SCANKEY_F			;;
	BCF ONEKEY_F			;;
	MOVLF #0,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_SET_SCAN_KEY_PRG:			;;
        MOV #0XFFFF,W0
        CP RX_PARA0                             
        BRA Z,CMD_SET_SCAN_ALL_KEY_PRG  ;;
        MOVFF RX_PARA0,WRITE_KEY_CNT
        BRA CMD_SET_ONE_KEY_PRG
CMD_SET_SCAN_ALL_KEY_PRG:		;;	
	BCF ALLKEY_F			;;
	BSF SCANKEY_F			;;
	BCF ONEKEY_F			;;
	MOVLF #2,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;;;<<debug
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
XXHHJJ:
	MOVLF #28,WRITE_KEY_CNT		;;	
CMD_SET_ONE_KEY_PRG:			;;	
	BCF ALLKEY_F			;;
	BCF SCANKEY_F			;;
	BSF ONEKEY_F			;;
	MOVLF #2,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_SET_ALL_KEY_PRG:			;;	
	BSF ALLKEY_F			;;
	BCF SCANKEY_F			;;
	BCF ONEKEY_F			;;
	MOVLF #2,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_WRITE_SCAN_KEY_PRG:			;;	
	BCF ALLKEY_F			;;
	BSF SCANKEY_F			;;
	BCF ONEKEY_F			;;
	MOVLF #1,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HHJJ:
	MOVLF #88,WRITE_KEY_CNT		;;	
CMD_WRITE_ONE_KEY_PRG:			;;	
	BCF ALLKEY_F			;;
	BCF SCANKEY_F			;;
	BSF ONEKEY_F			;;
	MOVLF #1,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_WRITE_ALL_KEY_PRG:			;;	
	BSF ALLKEY_F			;;
	BCF SCANKEY_F			;;
	BCF ONEKEY_F			;;
	MOVLF #1,SON_ACTION_CNT		;;
	BRA SON_ACTION			;;
SON_ACTION:
CMD_WRITE_ALL_KEY_0:			;;	
	BTFSC U1TX_EN_F			;;
	RETURN				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CWAKP_0			;;
	BRA CWAKP_1			;;
	BRA CWAKP_2			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CWAKP_0:				;;
	MOVFF WRITE_KEY_CNT,UTX_PARA0	;;
	MOVLF #OLED_AMT_K,UTX_PARA1	;;	
	CALL UTX_I_HAVE_REC		;;
	INC CMDSTEP			;;
	MOVLF #160,CMDTIME		;;
	RETURN				;;
CWAKP_1:				;;
	MOVFF WRITE_KEY_CNT,UTX_PARA0	;;
	MOVLF #OLED_AMT_K,UTX_PARA1	;;	
	CALL UTX_I_AM_BUZY		;;
	INC CMDSTEP			;;
	MOVLF #160,CMDTIME		;;
	CLR S_CMDTIME			;;
	CLR S_CMDSTEP			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CWAKP_2:				;;
	MOVFF WRITE_KEY_CNT,KB_KEY_CNT	;;
;	BRA JJJ
	MOV #0,W0			;;
	CP SON_ACTION_CNT		;;	
	BRA NZ,$+6			;;
 	CALL ERASE_SON_FLASH		;;
	MOV #1,W0			;;
	CP SON_ACTION_CNT		;;
	BRA NZ,$+6			;;
 	CALL WRITE_SON_FLASH		;;
	MOV #2,W0			;;
	CP SON_ACTION_CNT		;;
	BRA NZ,$+6			;;
 	CALL SET_SON_FLASH		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSC SCANKEY_F			;;
	BRA CWAKP_2A			;;
	BTFSC ERR_F			;;
	BRA CWAKP_ERR			;;
	BTFSC OK_F			;;
	BRA CWAKP_OK			;;
	RETURN				;;
CWAKP_2A:				;;
	BTFSC ERR_F			;;
	BRA CWAKP_NEXT			;;
	BTFSC OK_F			;;
	BRA CWAKP_NEXT			;;
	RETURN				;;
CWAKP_NEXT:				;;
	MOVLF #1,CMDSTEP		;;
	MOVLF #300,CMDTIME		;;;
	INC WRITE_KEY_CNT		;;
	MOV #OLED_AMT_K,W0		;;
	CP WRITE_KEY_CNT		;;
	BRA GEU,$+4			;;<<DEBUG
	RETURN 				;;<<DEBUG
	BRA CWAKP_OK			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CWAKP_OK:				;;
	CALL UTX_I_AM_DONE		;;		
	MOV #CMD_STOPALL_K,W0		;;
	MOV W0,CMDINX			;;
	CLR CMDTIME			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CWAKP_ERR:				;;
	CALL UTX_I_AM_ERR		;;		
	MOV #CMD_STOPALL_K,W0		;;
	MOV W0,CMDINX			;;
	CLR CMDTIME			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_CHK_FLASH_BLANK_PRG:		;;	
	BTFSC U1TX_EN_F			;;
	RETURN				;;
	CP0 CMDTIME			;;
	BRA Z,$+6			;;
	DEC CMDTIME			;;
	RETURN				;;
	MOVLF #16,CMDTIME		;;
	MOV CMDSTEP,W0			;;
	BRA W0				;;
	BRA CCFBP_0			;;
	BRA CCFBP_1			;;
	BRA CCFBP_2			;;
	BRA CCFBP_3			;;
CCFBP_0:				;;
	CLR FADR1			;;
	MOVFF FADR1,UTX_PARA0		;;
	MOV #FRAM_SIZE_K,W0		;;
	MOVLF #OLED_AMT_K,UTX_PARA1	;;
	CALL UTX_I_HAVE_REC		;;
	INC CMDSTEP			;;
	RETURN				;;
CCFBP_1:				;;CHECKING 
	CALL CHK_FLASH_BLANK_SEG	;;
	BTFSS ERR_F			;;
	BRA $+6				;;
	INC CMDSTEP			;;
	RETURN				;;
	MOVFF FADR1,UTX_PARA0		;;
	MOV #FRAM_SIZE_K,W0		;;
	MOV W0,UTX_PARA1		;;
	CALL UTX_I_AM_BUZY		;;
	INC FADR1			;;
	MOV #FRAM_SIZE_K,W0		;;
	CP FADR1			;;
	BRA GEU,$+4			;;
	RETURN 				;;
	INC CMDSTEP			;;
	INC CMDSTEP			;;
	RETURN				;;	
CCFBP_2:				;;CHECK ERROR
	CALL UTX_I_AM_ERR		;;		
	MOV #CMD_STOPALL_K,W0		;;
	MOV W0,CMDINX			;;
	CLR CMDTIME			;;
	CLR CMDSTEP			;;
	RETURN				;;
CCFBP_3:				;;CHECK ERROR
	CALL UTX_I_AM_DONE		;;		
	MOV #CMD_STOPALL_K,W0		;;
	MOV W0,CMDINX			;;
	CLR CMDTIME			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		



	


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IC4:				;;
	MOV IC4BUF,W0			;;
	MOV IC4BUF,W0			;;
	MOV IC4BUF,W0			;;
	MOV IC4BUF,W0			;;
	BCLR IFS2,#IC4IF		;;
	MOVLF #0x0402,IC4CON1		;;
	BSET IPC9,#10			;;
	BCLR IPC9,#9			;;
	BCLR IPC9,#8			;;
	BSET IEC2,#IC4IE		;;
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
INIT_TIMER1:				;;
        CLR TMR1                        ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xA000,W0			;;
	;MOV W0,T1CON			;;
        ;MOV #567,W0                   	;;115200
        ;MOV #189,W0                  	;;115200*3
        ;MOV W0,PR1                      ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xA000,W0			;;
	;MOV W0,T1CON			;;
        ;MOV #1136,W0                  	;;57600
        ;MOV #378,W0                  	;;57600*3
        ;MOV W0,PR1                     ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xA000,W0			;;
	;MOV W0,T1CON			;;
        ;MOV #6834,W0                   ;;9600
        ;MOV #2273,W0                   ;;9600*3
        ;MOV W0,PR1                     ;;
	MOV MCUU2_MODE,W0		;;
	CALL GET_UART_RATE
	MOV W0,T1CON
	MOV W2,PR1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET IPC0,#14			;;
	BCLR IPC0,#13			;;
	BSET IPC0,#12			;;
        BCLR IFS0,#T1IF			;;	
        BSET IEC0,#3                    ;;            
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER3:				;;
        CLR TMR3                        ;;
	MOV MCUU3_MODE,W0		;;
	CALL GET_UART_RATE		;;
	MOV W0,T3CON			;;
	MOV W2,PR3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET IPC2,#2			;;
	BCLR IPC2,#1			;;
	BSET IPC2,#0			;;
        BCLR IFS0,#T3IF			;;	
        BSET IEC0,#T3IE                  ;;            
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER2:				;;
	MOV #0xA030,W0			;;/256
	MOV W0,T2CON			;;BASE TIME
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER4:				;;
        CLR TMR4                        ;;
	MOV MCUU45_MODE,W0		;;
	CALL GET_UART_RATE		;;
	MOV W0,T4CON			;;
	MOV W2,PR4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET IPC6,#14			;;
	BCLR IPC6,#13			;;
	BSET IPC6,#12			;;
        BCLR IFS1,#T4IF			;;	
        BSET IEC1,#T4IE                  ;;            
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER5:				;;
        CLR TMR5                        ;;
	MOV MCUU1_MODE,W0		;;
	CALL GET_UART_RATE		;;
	MOV W0,T5CON			;;
	MOV W2,PR5			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET IPC7,#2			;;
	BCLR IPC7,#1			;;
	BSET IPC7,#0			;;
        BCLR IFS1,#T5IF			;;	
        BSET IEC1,#T5IE                 ;;            
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SIO:			;;
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
	AND RPOR7		;;
	MOV #0x0100,W0		;;RP97 U1TX
	IOR RPOR7		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR19		;;
	MOV #40,W0		;;RP40 U1RX
	IOR RPINR19		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR2		;;
	MOV #0x0300,W0		;;RP39 U2TX
	IOR RPOR2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPINR0		;;
	MOV #37,W0		;;
	SWAP W0			;;
	IOR RPINR0		;;INT1
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR1		;;
	MOV #32,W0		;;
	IOR RPINR1		;;INT2
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;RP36
	AND RPOR1		;;
	MOV #0x0010,W0		;;OC1
	IOR RPOR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR7		;;
	MOV #44,W0		;;
	IOR RPINR7		;;IC1
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPINR7		;;
	MOV #119,W0		;;
	SWAP W0			;;
	IOR RPINR7		;;IC2
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR8		;;
	MOV #47,W0		;;
	IOR RPINR8		;;IC3
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPINR8		;;
	MOV #25,W0		;;
	SWAP W0			;;
	IOR RPINR8		;;IC4
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	/*
	MOV #0xFF00,W0		;;
	AND RPINR18		;;
	MOV #37,W0		;;RP40 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR2		;;
	MOV #0x0001,W0		;;RP39 U1TX
	IOR RPOR2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR19		;;
	MOV #97,W0		;;RP119 U2RX PITX
	IOR RPINR19		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR4		;;
	MOV #0x0003,W0		;;RP39 U2TX
	IOR RPOR4		;;
	*/

	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xFF00,W0		;;
	;AND RPINR22		;;
	;MOV #47,W0		;;
	;IOR RPINR22		;;SPI2 DI 
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0x00FF,W0		;;
	;AND RPOR8		;;
	;MOV #0x08,W0		;;
	;SWAP W0		;;
	;IOR RPOR8		;;SPI2 DO 
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xFF00,W0		;;
	;AND RPOR9		;;
	;MOV #0x09,W0		;;
	;IOR RPOR9		;;SPI2 CLK 
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #58,W0		;;
;	SWAP W0			;;	
;	MOV W0,RPINR0		;;INT1
;	MOV #119,W0		;;
;	MOV.B WREG,RPINR1	;;INT2
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #0xFF00,W0		;;
;	AND RPOR5		;;
;	MOV #0x0031,W0		;;REFCLKO
;	IOR RPOR5		;;RP54
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #55,W0		;;IC1 RP97
;	MOV.B WREG,RPINR7	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV RPINR7,W0		;;IC2 RPI120 LCDRS0
;	AND #255,W0		;;
;	SWAP W0			;;
;	ADD #120,W0		;;
;	SWAP W0			;;
;	MOV W0,RPINR7		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #118,W0		;;IC3 118 LCDRS1
;	MOV.B WREG,RPINR8	;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_INT2:			;;	
	BSET INTCON2,#INT2EP 	;;0:POSITIVE EDAGE,1:NEGTIVE EDGE
	BSET IPC7,#6 		;;
	BCLR IPC7,#5 		;;
	BCLR IPC7,#4 		;;
	BCLR IFS1,#INT2IF	;;	
	BSET IEC1,#INT2IE	;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;FCY=50mHZ
;FCY=66mHZ
;UXBRG=FCY/(4*BOUDRATE) -1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART1:				;;
	MOV #107,W0	;115200		;;50MHZ
	MOV #142,W0	;115200		;;66MHZ
	;MOV #65,W0	;256000		;;66MHZ
	;MOV #47,W0	;345600		;;66MHZ
	;MOV #65,W0	;250000		;;66MHZ
	;MOV #54,W0	;250000		;;66MHZ
	MOV #35,W0	;		;;66MHZ
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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART2:				;;
	MOV #107,W0	;115200		;;50MHZ
	MOV #142,W0	;115200		;;66MHZ
	;MOV #65,W0	;256000		;;66MHZ
	;MOV #47,W0	;345600		;;66MHZ
	MOV #35,W0	;		;;66MHZ

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:				;;
	MOVLF #4,DIM_SET		;;
	MOVLF #31,DIM_CNT		;;MAX=31			
	MOVLF #31,COMV_CNT		;;MAX=31			
	MOVLF #15,OLEDCUR_CNT		;;MAX=15		
	SETM MCURX2_CLR_TIM		;;
	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
	BSF IO_WRITE_O			;;
	BCF IO_WRITE_IO			;;
	;;PIN2 				;;
	BSF IO_DRIVER_O			;;
	BCF IO_DRIVER_IO		;;
	;;PIN3 				;;
	BSF MCU_RX4_IO			;;
	;;PIN4 				;;
	BSF MCU_TX4_O			;;
	BCF MCU_TX4_IO			;;
	;;PIN5 				;;
	BSF MCU_RX3_IO			;;
	;;PIN6 				;;
	BSF MCU_TX3_O			;;
	BCF MCU_TX3_IO			;;
	;;PIN8 				;;
	BCF NC8_O			;;
	BCF NC8_IO			;;
	;;PIN11 			;;
	BSF TP1_O			;;
	BCF TP1_IO			;;
	;;PIN12 			;;
	BCF TP2_O			;;
	BSF TP2_IO			;;
	;;PIN13 			;;
	BSF TP3_O			;;
	BCF TP3_IO			;;
	;;PIN14 			;;
	BCF TP4_O			;;
	BCF TP4_IO			;;
	;;PIN15 			;;
	BSF MCU_TX5_O			;;
	BCF MCU_TX5_IO			;;
	;;PIN16 			;;
	BSF MCU_RX5_IO			;;
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
	BCF NC27_O			;;
	BCF NC27_IO			;;
	;;PIN28 			;;
	BCF NC28_O			;;
	BCF NC28_IO			;;
	;;PIN29 			;;
	BSF V12ADIN_IO			;;
	;;PIN30 			;;
	BCF PS2_DATA_O			;;
	BSF PS2_DATA_IO			;;
	;;PIN31 			;;
	BCF PS2_CLK_O			;;
	BSF PS2_CLK_IO			;;
	;;PIN32 			;;
	BCF BUZZER_O			;;
	BCF BUZZER_IO			;;
	;;PIN33 			;;
	BSF MCU_TX1_O			;;
	BCF MCU_TX1_IO			;;
	;;PIN34 			;;
	BSF MCU_RX1_IO			;;
	;;PIN35 			;;
	BCF DB3_O			;;
	BCF DB3_IO			;;
	;;PIN36 			;;
	BCF DB4_O			;;
	BCF DB4_IO			;;
	;;PIN37 			;;
	BCF DB5_O			;;
	BCF DB5_IO			;;
	;;PIN42 			;;
	BCF NC42_O			;;
	BCF NC42_IO			;;
	;;PIN43 			;;
	BCF I2C_SCK_O			;;
	BSF I2C_SCK_IO			;;
	;;PIN44 			;;
	BCF I2C_SDA_O			;;
	BSF I2C_SDA_IO			;;
	;;PIN45 			;;
	BCF NC45_O			;;
	BCF NC45_IO			;;
	;;PIN46 			;;
	BSF RS485DI_O			;;
	BCF RS485DI_IO			;;
	;;PIN47				;;
	BCF RS485CTL_O			;;
	BCF RS485CTL_IO			;;
	;;PIN48 			;;
	BSF RS485RO_IO			;;
	;;PIN49 			;;
	BSF FLASH_SCK_O			;;
	BCF FLASH_SCK_IO		;;
	;;PIN50 			;;
	BCF DB6_O			;;
	BCF DB6_IO			;;
	;;PIN51 			;;
	BCF DB7_O			;;
	BCF DB7_IO			;;
	;;PIN52 			;;
	BCF LED_O			;;
	BCF LED_IO			;;
	;;PIN53 			;;
	BCF NC53_O			;;
	BCF NC53_IO			;;
	;;PIN54 			;;
	BCF NC54_O			;;
	BCF NC54_IO			;;
	;;PIN55 			;;
	BSF FLASHA_CS_O			;;
	BCF FLASHA_CS_IO		;;
	;;PIN58 			;;
	BSF RS232_DET_IO		;;
	;;PIN59 			;;
	BSF PI_RX_O			;;
	BCF PI_RX_IO			;;
	;;PIN60 			;;
	BSF PI_TX_IO			;;
	;;PIN61 			;;
	BSF MCU_TX2_O			;;
	BCF MCU_TX2_IO			;;
	;;PIN62 			;;
	BSF MCU_RX2_IO			;;
	;;PIN63 			;;
	BSF FLASHB_CS_O			;;
	BCF FLASHB_CS_IO		;;
	;;PIN64 			;;
	BSF IO_READ_O			;;
	BCF IO_READ_IO			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;























	











	


















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
	MOV #DEVICE_ID_K,W2		;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_2		;;
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_2		;;
	RETURN				;;
CHK_U1RX_2:				;;
	MOV [W1++],W0			;;
	MOV #SERIAL_ID_K,W2		;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_3		;;
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_3		;;
	RETURN				;;
CHK_U1RX_3:				;;
	MOV [W1++],W0			;;
	MOV W0,RX_FLAGS			;;
	MOV [W1++],W0			;;
	MOV W0,RX_LEN			;;
	MOV [W1++],W0			;;
	MOV W0,RX_CMD			;;

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
	GOTO URXDEC_FLASH_ACT		;;
	CP W0,#0x20			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_SELFTEST_ACT	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x30			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_EMUKR0_ACT		;;EMU KEY PUSH
	CP W0,#0x31			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_EMUKR1_ACT		;;EMU KEY FREE
	CP W0,#0x32			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_EMUKR2_ACT		;;EMU KEY CON1
	CP W0,#0x33			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_EMUKR3_ACT		;;EMU KEY CON2
	CP W0,#0x34			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_SETKEYID_ACT	;;SET_KEYID
	CP W0,#0x35			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_RESET_ALLKEY	;;RESET_ALLKEY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x50			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_EMURX_ACT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

URXDEC_SETKEYID_ACT:
	MOV RX_CMD,W0
	AND #255,W0
	MOV W0,SETKEY_ID		
	CALL SET_KEYID_PRG
	BSF SET_KEYID_F 
	RETURN

URXDEC_RESET_ALLKEY:
	BCF SET_KEYID_F 
	CALL RESET_ALLKEY_PRG
	RETURN




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
	BRA URXDEC_INIT_IP		;;8
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
URXDEC_INIT_IP:			        ;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_EMUKR0_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	INC W0,W0			;;
	MOV W0,EMUKR0			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_EMUKR1_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	INC W0,W0			;;
	MOV W0,EMUKR1			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_EMUKR2_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	INC W0,W0			;;
	MOV W0,EMUKR2			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_EMUKR3_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	INC W0,W0			;;
	MOV W0,EMUKR3			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_SELFTEST_ACT:			;;
	BCF SET_DIMS_F			;;
	MOV RX_CMD,W0			;;
SET_TEST_X:				;;
	AND #7,W0			;;
	BRA W0				;;
	BRA URXDEC_SELF_TEST0		;;
	BRA URXDEC_SELF_TEST1		;;
	BRA URXDEC_SELF_TEST2		;;
	BRA URXDEC_SELF_TEST3		;;
	BRA URXDEC_SELF_TEST4		;;
	BRA URXDEC_SELF_TEST5		;;
	BRA URXDEC_SELF_TEST6		;;
	BRA URXDEC_SELF_TEST7		;;
URXDEC_SELF_TEST0:			;;
SET_TEST0:				;;
	MOVLF #CMD_TEST0_K,CMDINX	;;
	CLR CMDTIME			;;	
	CLR CMDSTEP			;;
	RETURN
URXDEC_SELF_TEST1:
SET_TEST1:				;;
	MOVLF #CMD_TEST1_K,CMDINX	;;
	CLR CMDTIME			;;	
	CLR CMDSTEP			;;
	RETURN
URXDEC_SELF_TEST2:
SET_TEST2:				;;
	MOVLF #CMD_TEST2_K,CMDINX	;;
	CLR CMDTIME			;;	
	CLR CMDSTEP			;;
	RETURN
URXDEC_SELF_TEST3:
SET_TEST3:				;;
	MOVLF #CMD_TEST3_K,CMDINX	;;
	CLR CMDTIME			;;	
	CLR CMDSTEP			;;
	RETURN
URXDEC_SELF_TEST4:
SET_TEST4:				;;
	MOVLF #CMD_TEST4_K,CMDINX	;;
	CLR CMDTIME			;;	
	CLR CMDSTEP			;;
	RETURN
URXDEC_SELF_TEST5:
	MOVLF #CMD_TEST5_K,CMDINX	;;
	CLR CMDTIME			;;	
	CLR CMDSTEP			;;
	RETURN
URXDEC_SELF_TEST6:
	MOVLF #CMD_TEST6_K,CMDINX	;;	
	BSF SET_DIMS_F
	CLR CMDTIME			;;	
	CLR CMDSTEP			;;
	RETURN

URXDEC_SELF_TEST7:
	MOVLF #CMD_TEST7_K,CMDINX	;;
	CLR CMDTIME			;;	
	CLR CMDSTEP			;;
	RETURN





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_FLASH_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #7,W0			;;
	BRA W0				;;
	BRA URXDEC_ERASE_FLASH		;;
	BRA URXDEC_CHK_FLASH_BLANK	;;
	BRA URXDEC_PROGRAM_FLASH	;;
	BRA URXDEC_VERIFY_FLASH		;;
	BRA URXDEC_ERASE_SCAN_KEY	;;
	BRA URXDEC_WRITE_SCAN_KEY	;;
	BRA URXDEC_ERASE_ALL_KEY	;;
	BRA URXDEC_SET_SCAN_KEY		;;
	RETURN
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_SET_KEY_START:			;;
	MOVLF #31,WRITE_KEY_CNT 
	MOV #CMD_SET_SCAN_KEY_K,W0	;;	
	MOV W0,CMDINX			;;
	MOVLF #200,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN				;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_SET_SCAN_KEY:			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA0			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
SET_SCAN_KEY_START:			;;
	CLR WRITE_KEY_CNT		;;
	;MOV #76,W0			;;<<DEBUG
	;MOV W0,WRITE_KEY_CNT		;;<<DEBUG
	MOV #CMD_SET_SCAN_KEY_K,W0	;;	
	MOV W0,CMDINX			;;
	MOVLF #200,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_WRITE_SCAN_KEY:			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
	CLR WRITE_KEY_CNT		;;
	MOV #CMD_WRITE_SCAN_KEY_K,W0	;;	
	MOV W0,CMDINX			;;
	MOVLF #200,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_ERASE_ALL_KEY:			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA0			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
	CLR WRITE_KEY_CNT		;;
	MOV #CMD_ERASE_ALL_KEY_K,W0	;;	
	MOV W0,CMDINX			;;
	MOVLF #200,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_ERASE_SCAN_KEY:			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
	CLR WRITE_KEY_CNT		;;
	MOV #CMD_ERASE_SCAN_KEY_K,W0	;;	
	MOV W0,CMDINX			;;
	MOVLF #200,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




URXDEC_ERASE_FLASH:			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
	MOV #CMD_FLASH_ERASE_K,W0	;;	
	MOV W0,CMDINX			;;
	MOVLF #200,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
URXDEC_CHK_FLASH_BLANK:			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
	MOV #CMD_CHK_FLASH_BLANK_K,W0	;;	
	MOV W0,CMDINX			;;
	MOVLF #16,CMDTIME		;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
URXDEC_PROGRAM_FLASH:			;;
	BCF U1U2_F			;;
	;CALL UTX_I_HAVE_REC		;;
	MOV RX_ADDR,W1			;;
	ADD #10,W1			;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA0		;;//PACK SIZE
	MOV [W1++],W0			;;
	MOV W0,URX_PARA1		;;//PACK CNT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CP0 URX_PARA1
	BRA NZ,$+4
	CLR DEBUG_CNT1
	MOV DEBUG_CNT1,W0
	CP URX_PARA1
	BRA Z,TTYY
	INC W0,W0
	CP URX_PARA1
	BRA Z,TTYY
	NOP
	NOP
	NOP
TTYY:
	MOVFF URX_PARA1,DEBUG_CNT1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX_PARA0,W0		;;
	MUL URX_PARA1			;;
	MOV W2,FADR0			;;
	MOV W3,FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR SR,#C			;;
	RRC FADR1			;;
	RRC FADR0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	MOV #2,W0
	CP FADR1
	BRA NZ,AAAQ1
	MOV #0xAC00,W0
	CP FADR0
	BRA NZ,AAAQ1
	NOP
	NOP
	NOP
	NOP
AAAQ1:




URXDEC_PROGRAM_FLASH_1:			;;
	MOVFF FADR0,R0			;;
	MOVFF FADR1,R1			;;
	MOV W1,R2 			;;
	CLR R3				;;
URXDEC_PROGRAM_FLASH_2:			;;
	MOV R2,W1			;;
	MOVFF R1,FADR1			;;
	MOVFF R0,FADR0			;; 
	CALL FLASH_PGM			;;
	MOV R2,W1			;;
	MOVFF R1,FADR1			;;
	MOVFF R0,FADR0			;; 
	CALL FLASH_VERIFY_QPI		;;
	BTFSS ERR_F			;;
	BRA URXDEC_PROGRAM_FLASH_3	;;
	INC R3				;;
	MOV #3,W0			;;
	CP R3				;;
	BRA LTU,URXDEC_PROGRAM_FLASH_2	;;
	NOP				;;
	NOP				;;
	CALL UTX_I_AM_ERR		;;
	RETURN				;;
URXDEC_PROGRAM_FLASH_3:			;;
	MOVFF URX_PARA1,UTX_PARA0	;;	
	CALL UTX_I_HAVE_REC		;;
	NOP				;;
	NOP				;;
	NOP				;;
	NOP				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_VERIFY_FLASH:			;;
	BCF U1U2_F			;;
	MOV RX_ADDR,W1			;;
	ADD #10,W1			;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA0		;;//PACK SIZE
	MOV [W1++],W0			;;
	MOV W0,URX_PARA1		;;//PACK CNT
	MOV URX_PARA0,W0		;;
	MUL URX_PARA1			;;
	MOV W2,FADR0			;;
	MOV W3,FADR1			;;
	BCLR SR,#C			;;
	RRC FADR1			;;
	RRC FADR0			;;
	CP0 URX_PARA1			;;
	BRA NZ,$+6			;;
	CLR DEBUG_CHKSUM0		;;
	CLR DEBUG_CHKSUM1		;;



	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_VERIFY_FLASH_1:			;;
	CALL FLASH_VERIFY_QPI		;;
	BTFSS ERR_F			;;
	BRA URXDEC_VERIFY_FLASH_2	;;
	NOP
	NOP
	NOP
	CALL UTX_I_AM_ERR		;;
	RETURN				;;	
	;MOV #256,W0			;;
	;SUB URX_PARA0			;;
	;BRA GTU,URXDEC_VERIFY_FLASH_1	;;
URXDEC_VERIFY_FLASH_2:			;;
	MOVFF URX_PARA1,UTX_PARA0	;;	
	NOP
	NOP
	NOP
	NOP
	CALL UTX_I_HAVE_REC		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;INPUT RX_LEN,RX_ADDR,RX_CH
;RX_CH=0 RS422 CH1
;RX_CH=1 RS422 CH2
;RX_CH=2 USBCOM 
;RX_CH=3 RS232


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEC_SYSURX:				;;
	CLR OLED_POS			;;
DEC_SYSURX_1:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLRWDT				;;
	CALL GET_KBSTA_ADR		;;
	MOV [W1],W0			;;
	MOV W0,NOWKEY_STA0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC RX_CH,#2			;;
	BRA DEC_SYSURX_2		;;
	CLR W0				;;
	BTSC NOWKEY_STA0,#6		;;
	BSET W0,#0			;;
	BTSC NOWKEY_STA0,#7		;;
	BSET W0,#1			;;
	CP RX_CH			;;
	BRA NZ,DEC_SYSURX_3		;;
DEC_SYSURX_2:				;;
	BTSC NOWKEY_STA0,#8		;;
	CALL CHK_SWITCH_PAGE0		;;
	BTSC NOWKEY_STA0,#9		;;
	CALL CHK_SWITCH_PAGE1		;;	
	BTSC NOWKEY_STA0,#10		;;
	CALL CHK_SWITCH_PAGE2		;;
	BTSC NOWKEY_STA0,#11		;;
	CALL CHK_SWITCH_PAGE3		;;
	BTSC NOWKEY_STA0,#12		;;
	CALL CHK_SWITCH_PAGE4		;;	
	BTSC NOWKEY_STA0,#13		;;
	CALL CHK_SWITCH_PAGE5		;;
	BTSC NOWKEY_STA0,#14		;;
	CALL CHK_SWITCH_PAGE6		;;	
	BTSC NOWKEY_STA0,#15		;;
	CALL CHK_SWITCH_PAGE7		;;
DEC_SYSURX_3:				;;
	INC OLED_POS			;;
	MOV #OLED_AMT_K,W0		;;		
	CP OLED_POS			;;	
	BRA LTU,DEC_SYSURX_1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SWITCH_PAGE0:			;;
	CALL LOAD_KEY_ACT		;;
	MOVLF #0,IMAGE_PAG		;;
	MOV #FLASH_TMP+0x0D,W1		;;
	BRA CHK_SWITCH_PAGE		;;
CHK_SWITCH_PAGE1:			;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0x10,W1		;;
	MOVLF #1,IMAGE_PAG		;;
	BRA CHK_SWITCH_PAGE		;;
CHK_SWITCH_PAGE2:			;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0x13,W1		;;
	MOVLF #2,IMAGE_PAG		;;
	BRA CHK_SWITCH_PAGE		;;
CHK_SWITCH_PAGE3:			;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0x16,W1		;;
	MOVLF #3,IMAGE_PAG		;;
	BRA CHK_SWITCH_PAGE		;;
CHK_SWITCH_PAGE4:			;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0x19,W1		;;
	MOVLF #4,IMAGE_PAG		;;
	BRA CHK_SWITCH_PAGE		;;
CHK_SWITCH_PAGE5:			;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0x1C,W1		;;
	MOVLF #5,IMAGE_PAG		;;
	BRA CHK_SWITCH_PAGE		;;
CHK_SWITCH_PAGE6:			;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0x1F,W1		;;
	MOVLF #6,IMAGE_PAG		;;
	BRA CHK_SWITCH_PAGE		;;
CHK_SWITCH_PAGE7:			;;
	CALL LOAD_KEY_ACT		;;
	MOV #FLASH_TMP+0x22,W1		;;
	MOVLF #7,IMAGE_PAG		;;
	BRA CHK_SWITCH_PAGE		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SWITCH_PAGE:			;;
	CALL GET_3BADRX4		;;
	MOV RX_LEN,W0			;;
	INC2 W0,W0			;;
	CALL READ_FLASH_XB		;;
	MOV #FLASH_TMP,W1		;;
	MOV [W1++],W0			;;
	CP RX_LEN			;;
	BRA NZ,CHK_SWITCH_PAGE_ERR	;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RX_ADDR,W3			;;
	CLR W4				;;
CHK_SWITCH_PAGE_1:			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,W5			;;
	BCLR W5,#0			;;
	MOV [W5],W0 			;;
	BTSC W1,#0			;;
	SWAP W0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W3,W5			;;
	BCLR W5,#0			;;
	MOV [W5],W2 			;;
	BTSC W3,#0			;;
	SWAP W2				;;
	XOR W0,W2,W2			;;
	AND #255,W2			;;
	BRA NZ,CHK_SWITCH_PAGE_ERR	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC W1,W1			;;
	INC W3,W3			;;
	INC W4,W4			;;
	MOV RX_LEN,W0			;;
	CP W4,W0			;;
	BRA LTU,CHK_SWITCH_PAGE_1	;;	
	;=================================
	CALL GET_KBSTA_ADR		;;
	MOV [W1],W0			;;
	MOV #0xFFF0,W2			;;
	AND W2,W0,W0			;;
	MOV IMAGE_PAG,W2		;;	
	AND #15,W2			;;
	IOR W2,W0,W0			;;
	MOV W0,[W1]			;;
	CALL DISP_ALL_KEY		;;
	RETURN				;;
CHK_SWITCH_PAGE_ERR:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
	MOV W0,SON_DEVICE_ID		;;
	MOV [W1++],W0			;;
	MOV W0,SON_SERIAL_ID		;;
	MOV [W1++],W0			;;
	MOV W0,RX_FLAGS			;;
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
	MOV #0X9005,W0			;;
	CP RX_CMD			;;
	BRA NZ,$+6			;;
	GOTO CHK_SON_FLASH_RET		;;
	MOV #0X9006,W0			;;
	CP RX_CMD			;;
	BRA NZ,$+6			;;
	GOTO CHK_SON_FLASH_RET		;;
	MOV #0X9007,W0			;;
	CP RX_CMD			;;
	BRA NZ,$+6			;;
	GOTO CHK_SON_FLASH_RET		;;
	MOV #0X9009,W0			;;
	CP RX_CMD			;;
	BRA NZ,$+6			;;
	GOTO GET_KEY_CHKSUM_RET		;;
	NOP				;;
	NOP				;;
	RETURN				;;
CHK_U2RX_END:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_KEY_CHKSUM_RET:			;;
	MOV #OLED_AMT_K,W0		;;
	CP SON_SERIAL_ID		;;
	BRA LTU,$+4			;;
	RETURN				;;
	MOV #URX_STA_BUF,W1		;;
	MOV SON_SERIAL_ID,W0		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV #2,W0			;;
	MOV W0,[W1]			;;2=OK
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SON_FLASH_RET:			;;
	MOV #OLED_AMT_K,W0		;;
	CP SON_SERIAL_ID		;;
	BRA LTU,$+4			;;
	RETURN				;;
	MOV #URX_STA_BUF,W1		;;
	MOV SON_SERIAL_ID,W0		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV URX_PARA0,W0		;;
	INC W0,W0			;;
	MOV W0,[W1]			;;0:NOACT,1=BUSY,2=OK
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU2RX:				;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECU1RX:				;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_WFLASH:				;;
	;OV URX_MCMD,W0			;;
	CP W0,#31			;;
	BRA LEU,$+4			;;
	RETURN				;;	
	BRA W0				;;
	BRA U1RX_WFLASH_00		;;I TX TEST CODE	
	BRA U1RX_WFLASH_01		;;I HAVE RECEIVED	
	BRA U1RX_WFLASH_02		;;I AM DONE
	BRA U1RX_WFLASH_03		;;I AM BUZY YOU WAIT
	BRA U1RX_WFLASH_04		;;I HAVE ESCAPED
	BRA U1RX_WFLASH_05		;;I AM ERROR
	BRA U1RX_WFLASH_06		;;YOU KEEP WAITTING
	BRA U1RX_WFLASH_07		;;YOU STOP ALL PROCESS
	BRA U1RX_WFLASH_08		;;YOU DO NEXT
	BRA U1RX_WFLASH_09 		;;
	BRA U1RX_WFLASH_0A 		;;
	BRA U1RX_WFLASH_0B 		;;
	BRA U1RX_WFLASH_0C 		;;
	BRA U1RX_WFLASH_0D 		;;
	BRA U1RX_WFLASH_0E 		;;
	BRA U1RX_WFLASH_0F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BRA U1RX_WFLASH_10		;;ERASE FLASH
	BRA U1RX_WFLASH_11		;;BLANH_CHK 
	BRA U1RX_WFLASH_12		;;PROGRAM FLASH 
	BRA U1RX_WFLASH_13		;;VERIFY FLASH
	BRA U1RX_WFLASH_14		;;
	BRA U1RX_WFLASH_15		;;
	BRA U1RX_WFLASH_16		;;
	BRA U1RX_WFLASH_17		;;
	BRA U1RX_WFLASH_18		;;
	BRA U1RX_WFLASH_19 		;;
	BRA U1RX_WFLASH_1A 		;;
	BRA U1RX_WFLASH_1B 		;;
	BRA U1RX_WFLASH_1C 		;;
	BRA U1RX_WFLASH_1D 		;;
	BRA U1RX_WFLASH_1E 		;;
	BRA U1RX_WFLASH_1F		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_WFLASH_00:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_WFLASH_01:
U1RX_WFLASH_02:
U1RX_WFLASH_03:
U1RX_WFLASH_04:
U1RX_WFLASH_05:
U1RX_WFLASH_06:
U1RX_WFLASH_07:
	RETURN				
U1RX_WFLASH_08:
U1RX_WFLASH_09:
U1RX_WFLASH_0A:
U1RX_WFLASH_0B:
U1RX_WFLASH_0C:
U1RX_WFLASH_0D:
U1RX_WFLASH_0E:
U1RX_WFLASH_0F:
	RETURN	



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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_WFLASH_14:				;;	
U1RX_WFLASH_15:				;;
U1RX_WFLASH_16:
U1RX_WFLASH_17:
U1RX_WFLASH_18:
U1RX_WFLASH_19:
U1RX_WFLASH_1A:
U1RX_WFLASH_1B:
U1RX_WFLASH_1C:
U1RX_WFLASH_1D:
U1RX_WFLASH_1E:
U1RX_WFLASH_1F:
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIOUT_QPI:			;;	
	BSF FLASH_SCK_O		;;
	BTFSS FLASH_QPI2_F	;;
	BRA SPIOUT_QPI_SAME	;;
	MOV W0,W4		;;
	BCF FLASH_SCK_O		;;
 	XOR LATC,WREG		;;
	AND #255,W0		;;
	XOR LATC		;;
	NOP			;;
	NOP			;;
	BSF FLASH_SCK_O		;;
	NOP			;;
	MOV W4,W0		;;
	BCF FLASH_SCK_O		;;
	SWAP W0			;;
 	XOR LATC,WREG		;;
	AND #255,W0		;;
	XOR LATC		;;
	NOP			;;
	NOP			;;	
	BSF FLASH_SCK_O		;;
	RETURN			;;
				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIOUT_QPI_SAME:		;;
	AND #255,W0		;;		
	MOV W0,W4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	MOV #0xFF00,W0		;;
	AND LATC		;;
	MOV W4,W0		;;
	LSR W0,#4,W0		;;
	IOR LATC		;;	
	SWAP.B W0		;;
	IOR LATC		;;
	NOP			;;
	NOP			;;
	BSF FLASH_SCK_O		;;
	NOP			;;
	MOV #0xFF00,W0		;;
	BCF FLASH_SCK_O		;;
	AND LATC		;;	
	MOV W4,W0		;;
	AND #15,W0		;;
	IOR LATC		;;
	SWAP.B W0		;;
	IOR LATC		;;
	NOP			;;
	NOP			;;
	BSF FLASH_SCK_O		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	

SPIOUT:
	BTFSC FLASH_QPI_F
	BRA SPIOUT_QPI
	BTFSC FLASH_AB_F
	BRA SPIOUT_B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIOUT_A:			;;
	BSF FLASH_SCK_O		;;
	MOV W0,SPIBUF		;;
	CLR W0			;;
SPIOUT_A_0:			;;
	BCF FLASH_SCK_O		;;
	BTSS SPIBUF,#7		;;
	BCF FLASHA_DI_O		;;	
	BTSC SPIBUF,#7		;;
	BSF FLASHA_DI_O		;;
	NOP			;;
	BSF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	INC W0,W0		;;
	CP W0,#8		;;
	BRA LTU,SPIOUT_A_0	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIOUT_B:			;;
	BSF FLASH_SCK_O		;;
	MOV W0,SPIBUF		;;
	CLR W0			;;
SPIOUT_B_0:			;;
	BCF FLASH_SCK_O		;;
	BTSS SPIBUF,#7		;;
	BCF FLASHB_DI_O		;;	
	BTSC SPIBUF,#7		;;
	BSF FLASHB_DI_O		;;
	NOP			;;
	NOP			;;
	BSF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	INC W0,W0		;;
	CP W0,#8		;;
	BRA LTU,SPIOUT_B_0	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIIN_QPI:			;;
	MOV #0x00FF,W0		;;
	IOR TRISC		;;
	BCF FLASH_SCK_O		;;
	NOP			;;
	NOP
	BTFSS FLASH_QPI2_F	;;
	BRA SPIIN_QPI_SAME	;;
	MOV PORTC,W0		;;
	BSF FLASH_SCK_O		;;
	AND #255,W0		;;
	MOV W0,W2		;;
	NOP
	BCF FLASH_SCK_O		;;
	NOP			;;
	NOP			;;
	MOV PORTC,W0		;;
	AND #255,W0		;;
	SWAP W0			;;
	IOR W0,W2,W0		;;	
	MOV W0,SPIBUF		;;	
	BSF FLASH_SCK_O		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIIN_QPI_SAME:			;;
	MOV PORTC,W0		;;
	AND #255,W0		;;
	MOV W0,W2		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #15,W0		;;
	SWAP.B W0		;;
	MOV W0,SPIBUFA		;;
	NOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	MOV W2,W0		;;
	LSR W0,#4,W0		;;
	SWAP.B W0		;;
	MOV W0,SPIBUFB		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	NOP			;;
	MOV PORTC,W0		;;
	AND #255,W0		;;
	MOV W0,W2		;;
	BSF FLASH_SCK_O		;;
	AND #15,W0		;;
	IOR SPIBUFA		;;
	MOV W2,W0		;;
	LSR W0,#4,W0		;;
	IOR SPIBUFB		;;
	MOV SPIBUFB,W0		;;
	SWAP W0			;;	
	IOR SPIBUFA,WREG	;;		
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	

SPIIN:
	BTFSC FLASH_QPI_F
	BRA SPIIN_QPI
	BTFSC FLASH_AB_F
	BRA SPIIN_B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIIN_A:			;;
	CLRWDT			;;
	BSF FLASH_SCK_O	;;
	CLR SPIBUF		;;
	;;========================
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPIBUF,W0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIIN_B:			;;
	CLRWDT			;;
	BSF FLASH_SCK_O	;;
	CLR SPIBUF		;;
	;;========================
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHB_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHB_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHB_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHB_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHB_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHB_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHB_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O	;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHB_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPIBUF,W0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FLASH_ID:				;;
	BCF FLASH_QPI2_F		;;
	CALL CLR_FCS			;;
	MOV #0x0090,W0			;;
	CALL SPIOUT			;;
	MOV W0,R0			;;	
	CALL SPIIN			;;
	MOV W0,R1			;;	
	CALL SPIIN			;;
	MOV W0,R2			;;
	CALL SPIIN			;;
	MOV W0,R3			;;
	CALL SPIIN			;;
	MOV W0,R4			;;
	MOV SPIBUFA,W2			;;
	MOV SPIBUFB,W3			;;
	CALL SPIIN			;;
	MOV W0,R5			;;
	CALL SET_FCS			;;
	MOV #0xEFEF,W0			;;
	BTFSS FLASH_QPI_F		;;
	MOV #0x00EF,W0			;;
	CP R4				;;
	BTSC SR,#Z			;;
	RETURN				;;
	MOV #0xC2C2,W0			;;
	BTFSS FLASH_QPI_F		;;
	MOV #0xC2,W0			;;
	CP R4				;;
	BTSC SR,#Z			;;
	RETURN				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH:					;;
	CALL ENABLE_FLASH_QPI			;;
	CALL TEST_FLASH_ID			;;
	CALL CHK_FLASH_BLANK_ALL		;;
	CLR R0
	BCLR R0,#0
	BTFSC ERR_F
	BSET R0,#0
	NOP
	NOP
	NOP
	BTFSC ERR_F
	CALL TEST_FLASH_ERASE
	NOP
	NOP
	NOP
	NOP
	CALL TEST_FLASH_PGM
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BRA TEST_FLASH				;;	
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENABLE_FLASH_QPI:				;;
	CALL FLASH_EXITQPI			;;
	BCF FLASH_QPI_F				;;
	BCF FLASH_QPI2_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_AB_F				;;
	CALL WAIT_FLASH_READY			;;
	CALL FLASH_SETQE			;;
	CALL WAIT_FLASH_READY			;;
	CALL FLASH_SETQE			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF FLASH_AB_F				;;
	CALL WAIT_FLASH_READY			;;
	CALL FLASH_SETQE			;;
	CALL WAIT_FLASH_READY			;;
	CALL FLASH_SETQE			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLASH_ENQPI			;;	
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH_QPI:					;;
	CLRWDT					;;
	CALL ENABLE_FLASH_QPI			;;
	NOP
	NOP
	NOP
	NOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_FLASH_ID
	NOP
	NOP
	NOP
	NOP
	CALL FLASH_EXITQPI	
	NOP
	NOP
	NOP
	NOP
	CALL CHK_FLASH_ID
	NOP
	NOP
	NOP
	NOP

	



	BRA TEST_FLASH_QPI
	RETURN

		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH_ID:					;;
	CALL CHK_FLASH_ID			;;
	BTSS SR,#Z				;;
	BRA TEST_FLASH_ID
	NOP					
	NOP
	NOP
	RETURN
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH_ERASE:				;;
	CALL FLASH_WREN				;;
	CALL FLASH_WRSR				;;
TFF_1:						;;
	CALL FLASH_RDSR				;;
	BTSC W0,#0				;;
	BRA TFF_1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
TFF_2:						;;		
	CALL FLASH_WREN				;;
	CALL FLASH_BE				;;
TFF_3:						;;
	CLRWDT					;;
	CALL FLASH_RDSR				;;
	BTSC W0,#0				;;
	BRA TFF_3				;;
	NOP					;;
	NOP					;;
	NOP					;;
	NOP					;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH_PGM:					;;	
	MOV #FLASH_BUF,W1			;;
	MOV #0x0100,W2				;;
	CLR W3
TFP_1:						;;
	MOV W2,[W1++]				;;
	MOV #0x0101,W0				;;
	ADD W0,W2,W2				;;
	INC W3,W3
	MOV #128,W0				;;
	CP W3,W0				;;
	BRA LTU,TFP_1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_AB_F				;;
	CLR FADR0				;;
	CLR FADR1				;;
TFP_2:						;;
	MOV #FLASH_BUF,W1			;;	
	PUSH FADR0				;;
	PUSH FADR1				;;
	CALL FLASH_PGM				;;
	POP FADR1				;;
	POP FADR0				;;
	MOV #FLASH_BUF,W1			;;	
	CALL FLASH_VERIFY			;;
	BTFSS ERR_F				;;
	NOP					;;
	BTFSC ERR_F				;;	
	NOP					;;
	NOP					;;
	NOP					;;
	MOV #0x0100,W0				;;	
	ADD FADR0				;;		
	MOV #1000,W0				;;
	CALL DLYMX				;;
	BRA TFP_2				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_VERIFY_QPI:			;;
	BCF ERR_F			;;
	CALL WAIT_FLASH_READY		;;
	CALL CLR_FCS			;;
	MOV #0x000B,W0			;;
	CALL SPIOUT			;;
	MOV FADR1,W0			;;
	CALL SPIOUT			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIOUT			;;
	MOV FADR0,W0			;;
	CALL SPIOUT			;;
	CALL SPIIN			;;
	MOV #FLASH_TMP,W3
FLASH_VERIFY_QPI_1:			;;
	BSF FLASH_QPI2_F		;;
	CALL SPIIN			;;
	BCF FLASH_QPI2_F		;;
	MOV SPIBUF,W0
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	;ADD DEBUG_CHKSUM0	
	;MOV SPIBUF,W0
	;ADD DEBUG_CHKSUM1
	;CP SPIBUF			;;
	;BRA NZ,FLASH_VERIFY_QPI_ERR	;;
	CP SPIBUF			;;
	BRA Z,$+4
	BSF ERR_F


	INC FADR0			;;
	BTSC SR,#Z			;;
	INC FADR1			;;
	MOV.B FADR0,WREG		;;
	BRA NZ,FLASH_VERIFY_QPI_1	;;
	CALL SET_FCS			;;
	NOP				;;
	NOP				;;
	RETURN				;;
FLASH_VERIFY_QPI_ERR:			;'
	NOP				;;
	NOP				;;
	NOP				;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_VERIFY:				;;
	MOV #FLASH_TMP,W2		;;
	BSF ERR_F			;;
	CALL WAIT_FLASH_READY		;;
	CALL CLR_FCS			;;
	MOV #0x0003,W0			;;
	CALL SPIOUT			;;
	MOV FADR1,W0			;;
	CALL SPIOUT			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIOUT			;;
	MOV FADR0,W0			;;
	CALL SPIOUT			;;
FLASH_VERIFY_1:				;;
	CALL SPIIN			;;
	BTSC FADR0,#0			;;
	BRA FLASH_VERIFY_2		;;
	MOV SPIBUF,W0			;;
	MOV W0,[W2]			;;
	MOV [W1],W0			;;
	BRA FLASH_VERIFY_3		;;
FLASH_VERIFY_2:				;;
	MOV SPIBUF,W0			;;
	SWAP W0				;;
	ADD W0,[W2],[W2]		;;
	INC2 W2,W2			;;
					;;
	MOV [W1++],W0			;;
	SWAP W0				;;
FLASH_VERIFY_3:				;;
	CP.B SPIBUF			;;
	BRA NZ,FLASH_VERIFY_ERR		;;
	INC FADR0			;;
	BTSC SR,#Z			;;
	INC FADR1			;;
	MOV.B FADR0,WREG		;;
	BRA NZ,FLASH_VERIFY_1		;;
	CALL SET_FCS			;;
	BCF ERR_F			;;
	NOP				;;
	NOP				;;
	RETURN				;;
FLASH_VERIFY_ERR:
	NOP
	NOP
	NOP			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
FLASH_PGM:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	CALL CLR_FCS			;;
	MOV #0x0002,W0			;;
	CALL SPIOUT			;;
	MOV FADR1,W0			;;
	CALL SPIOUT			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIOUT			;;
	MOV FADR0,W0			;;
	CALL SPIOUT			;;
	BTFSC FLASH_QPI_F		;;
	BRA FLASH_PGM_Q1		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_PGM1:				;;
	BTSC FADR0,#0			;;
	BRA FLASH_PGM2			;;
	MOV [W1],W0			;;
	BRA FLASH_PGM3			;;
FLASH_PGM2:				;;
	MOV [W1++],W0			;;
	SWAP W0				;;
	BRA FLASH_PGM3			;;
FLASH_PGM3:				;;
	CALL SPIOUT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC FADR0			;;
	BTSC SR,#Z			;;
	INC FADR1			;;
	MOV.B FADR0,WREG		;;
	BRA NZ,FLASH_PGM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_PGM_Q1:				;;
	MOV [W1++],W0			;;
	BSF FLASH_QPI2_F		;;
	CALL SPIOUT			;;
	BCF FLASH_QPI2_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC FADR0			;;
	BTSC SR,#Z			;;
	INC FADR1			;;
	MOV.B FADR0,WREG		;;
	BRA NZ,FLASH_PGM_Q1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FLASH_BLANK_ALL:			;;
	CLR FADR1			;;
CHK_FLASH_BLANK_ALL_1:			;;
	CALL CHK_FLASH_BLANK_SEG	;;	
	BTFSC ERR_F			;;
	RETURN				;;
	INC FADR1			;;
	MOV #FRAM_SIZE_K,W0		;;
	CP FADR1			;;
	BRA LTU,CHK_FLASH_BLANK_ALL_1	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FLASH_BLANK_SEG:			;;
	BSF ERR_F			;;
	CALL WAIT_FLASH_READY		;;
	CALL CLR_FCS			;;
	MOV #0x000B,W0			;;
	CALL SPIOUT			;;
	MOV FADR1,W0			;;
	CALL SPIOUT			;;
	MOV #0,W0			;;
	CALL SPIOUT			;;
	MOV #0,W0			;;
	CALL SPIOUT			;;	
	CALL SPIIN			;;	
	CLR FADR0			;; 
	BTFSC FLASH_QPI_F		;;
	BRA CHK_FLASH_BLANK_2
CHK_FLASH_BLANK_1:			;;
	CALL SPIIN			;;
	MOV #255,W0			;;
	CP.B SPIBUF			;;
	BRA NZ,CHK_FLASH_BLANK_END	;;
	INC FADR0			;;
	CP0 FADR0			;;
	BRA NZ,CHK_FLASH_BLANK_1	;;
	BCF ERR_F			;;
	CALL SET_FCS			;;
	NOP				;;
	NOP				;;
	NOP				;;
	RETURN				;;
CHK_FLASH_BLANK_2:			;;
	BSF FLASH_QPI2_F		;;	
	CALL SPIIN			;;
	BCF FLASH_QPI2_F		;;	
	MOV #0xFFFF,W0			;;
	CP SPIBUF			;;
	BRA NZ,CHK_FLASH_BLANK_END	;;
	INC FADR0			;;
	CP0 FADR0			;;
	BRA NZ,CHK_FLASH_BLANK_2	;;
	BCF ERR_F			;;
	CALL SET_FCS			;;
	NOP				;;
	NOP				;;
	NOP				;;
	RETURN				;;
CHK_FLASH_BLANK_END:			;;
	CALL SET_FCS			;;
	NOP				;;
	NOP				;;
	NOP				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH_XB:				;;
	MOV #FLASH_TMP,W1		;;
	MOV W0,W2			;;
	BRA READ_FLASH			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH_16B:				;;
	MOV #FLASH_TMP,W1		;;
	MOV #16,W2			;;
	BRA READ_FLASH			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH_32B:				;;
	MOV #FLASH_TMP,W1		;;
	MOV #32,W2			;;
	BRA READ_FLASH			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH_64B:				;;
	MOV #FLASH_TMP,W1		;;
	MOV #64,W2			;;
	BRA READ_FLASH			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH_PAGE:			;;
	MOV #FLASH_TMP,W1		;;
READ_FLASH_PAGE_X:			;;
	MOV #256,W2			;;
	BRA READ_FLASH			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

READ_FLASH_2PAGE:			;;
	MOV #FLASH_TMP,W1		;;
	MOV #512,W2			;;
	BRA READ_FLASH			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH2B:				;;
	MOV #TEMP_BUF0,W1		;;
	MOV #2,W2			;;
	BRA READ_FLASH			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH4B:				;;
	MOV #TEMP_BUF0,W1		;;
	MOV #4,W2			;;
	BRA READ_FLASH			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CLR_FCS:
	BTFSC FLASH_QPI_F
	BRA CLR_FCSAB
	BTFSC FLASH_AB_F
	BRA CLR_FCSB	
CLR_FCSA:
	BSF FLASHA_DO_IO
	BSF FLASHA_WP_O
	BCF FLASHA_WP_IO
	BSF FLASHA_HOLD_O
	BCF FLASHA_HOLD_IO
	BCF FLASHA_CS_O
	BSF FLASHB_CS_O
	RETURN	
CLR_FCSB:
	BSF FLASHB_DO_IO
	BSF FLASHB_WP_O
	BCF FLASHB_WP_IO
	BSF FLASHB_HOLD_O
	BCF FLASHB_HOLD_IO
	BCF FLASHB_CS_O
	BSF FLASHA_CS_O
	RETURN	
CLR_FCSAB:
	PUSH W0
	MOV #0xFF00,W0
	AND TRISC
	BCF FLASHA_CS_O
	BCF FLASHB_CS_O
	POP W0
	RETURN


SET_FCS:
	BTFSC FLASH_QPI_F
	BRA SET_FCSAB
	BTFSC FLASH_AB_F
	BRA SET_FCSB	
SET_FCSA:
	BSF FLASHA_CS_O
	BCF DB0_IO
	BCF DB1_IO
	BCF DB2_IO
	BCF DB3_IO
	RETURN	
SET_FCSB:
	BSF FLASHB_CS_O
	BCF DB4_IO
	BCF DB5_IO
	BCF DB6_IO
	BCF DB7_IO
	RETURN	

SET_FCSAB:
	BSF FLASHA_CS_O
	BSF FLASHB_CS_O
	PUSH W0
	MOV #0xFF00,W0
	AND TRISC
	BCF FLASHA_CS_O
	BCF FLASHB_CS_O
	POP W0
	RETURN	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH:				;;
	PUSH R7				;;
	BTFSS FLASH_QPI_F		;;
	BRA READ_FLASH_0        
        BTSC W2,#0
        INC W2,W2
	LSR W2,#1,W2			;;
	MOV W2,R7			;;
	BCLR SR,#C			;;
	RRC FADR1			;;
	RRC FADR0			;;
READ_FLASH_0:				;;
	CALL WAIT_FLASH_READY		;;
	CALL CLR_FCS			;;
	MOV #0x000B,W0			;;
	CALL SPIOUT			;;
	MOV FADR1,W0			;;
	CALL SPIOUT			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIOUT			;;
	MOV FADR0,W0			;;
	CALL SPIOUT			;;
	CALL SPIIN			;;
	BTFSC FLASH_QPI_F		;;
	BRA READ_FLASH_QPI_1		;;
READ_FLASH_1:				;;
	CALL SPIIN			;;
	BTSC FADR0,#0			;;
	BRA READ_FLASH_2		;;	
	MOV W0,[W1]			;;
	BRA READ_FLASH_3		;;
READ_FLASH_2:				;;
	SWAP W0				;;
	ADD W0,[W1],[W1]		;;
	INC2 W1,W1			;;	
READ_FLASH_3:				;;
	INC FADR0			;;
	BTSC SR,#Z			;;
	INC FADR1			;;
	DEC R7				;;
	BRA NZ,READ_FLASH_1		;;
	CALL SET_FCS			;;
	POP R7				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH_QPI_1:			;;
	MOV R7,W0			;;
	ADD FADR0			;;
	MOV #0,W0			;;
	ADDC FADR1			;;
	BCLR SR,#C			;;
	RLC FADR0			;;
	RLC FADR1			;;
READ_FLASH_QPI_2:			;;
	BSF FLASH_QPI2_F		;;
	CALL SPIIN			;;
	MOV W0,[W1++]			;;
	DEC R7				;;
	BRA NZ,READ_FLASH_QPI_2		;;
	CALL SET_FCS			;;
	BCF FLASH_QPI2_F		;;
	POP R7				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FLASH_READY:			;;
	BTFSC FLASH_QPI_F		;;
	BRA CHK_FLASH_READY_1		;;
	CALL FLASH_RDSR			;;
	RETURN				;;
CHK_FLASH_READY_1:			;;
	CALL FLASH_RDSR			;;
	BTSC SPIBUFA,#0			;;
	BRA CHK_FLASH_READY_2		;;
	BTSC SPIBUFA,#0			;;
	BRA CHK_FLASH_READY_2		;;
	CLR SPIBUF			;;
	RETURN				;;
CHK_FLASH_READY_2:			;;
	MOV #1,W0			;;
	MOV W0,SPIBUF			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WAIT_FLASH_READY:			;;
	CLRWDT
	CALL CHK_FLASH_READY		;;
	BTSC SPIBUF,#0			;;
	BRA WAIT_FLASH_READY		;;
	CALL CHK_FLASH_READY		;;
	BTSC SPIBUF,#0			;;
	BRA WAIT_FLASH_READY		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_RDSR:				;;
	CALL CLR_FCS			;;
	MOV #0x0005,W0			;;
	CALL SPIOUT			;;
	CALL SPIIN			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_WRSR:				;;
	CALL CLR_FCS			;;
	MOV #0x0001,W0			;;
	CALL SPIOUT			;;
	MOV #0x0000,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_SETQE:				;;
	CALL CLR_FCS			;;
	MOV #0x0035,W0			;;
	CALL SPIOUT			;;
	CALL SPIIN			;;
	CALL SET_FCS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET W0,#1			;;
	PUSH W0				;;
	CALL CLR_FCS			;;
	MOV #0x0031,W0			;;
	CALL SPIOUT			;;
	POP W0				;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_CLRQE:				;;
	CALL CLR_FCS			;;
	MOV #0x0035,W0			;;
	CALL SPIOUT			;;
	CALL SPIIN			;;
	CALL SET_FCS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR W0,#1			;;
	PUSH W0				;;
	CALL CLR_FCS			;;
	MOV #0x0031,W0			;;
	CALL SPIOUT			;;
	POP W0				;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_ENQPI:				;;
	BCF FLASH_AB_F			;;
	CALL CLR_FCS			;;
	MOV #0x0038,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	BSF FLASH_AB_F			;;
	CALL CLR_FCS			;;
	MOV #0x0038,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	BSF FLASH_QPI_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_EXITQPI:				;;
	BSF FLASH_QPI_F			;;
	BCF FLASH_QPI2_F		;;
	CALL CLR_FCS			;;
	MOV #0x00FF,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	BCF FLASH_QPI_F			;;
	BCF FLASH_QPI2_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_RESET:				;;
	BSF FLASH_QPI_F			;;
	BCF FLASH_QPI2_F		;;
	CALL CLR_FCS			;;
	MOV #0x0066,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	MOV #50,W0			;;
	CALL DLYUX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CLR_FCS			;;
	MOV #0x0099,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	BCF FLASH_QPI_F			;;
	BCF FLASH_QPI2_F		;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FLASH_WEN:				;;
	CALL FLASH_RDSR			;;
	BTFSC FLASH_QPI_F		;;
	BRA CHK_FLASH_WEN_1	
	BTSC SPIBUF,#0			;;
	BRA CHK_FLASH_WEN		;;
	MOV SPIBUF,W0			;;
	AND #0x001C,W0			;;
	BTSC SR,#Z			;;
	RETURN         			;;
	CALL FLASH_WREN			;;
	CALL FLASH_WRSR			;;
	BRA CHK_FLASH_WEN		;;
CHK_FLASH_WEN_1:			;;
	BTSC SPIBUFA,#0			;;
	BRA CHK_FLASH_WEN		;;
	BTSC SPIBUFB,#0			;;
	BRA CHK_FLASH_WEN		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPIBUFA,W0			;;
	AND #0x001C,W0			;;
	BTSC SR,#Z			;;
	BRA CHK_FLASH_WEN_2 		;;
	CALL FLASH_WREN			;;
	CALL FLASH_WRSR			;;
	BRA CHK_FLASH_WEN		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FLASH_WEN_2:			;;
	MOV SPIBUFB,W0			;;
	AND #0x001C,W0			;;
	BTSC SR,#Z			;;
	BRA CHK_FLASH_WEN_3 		;;
	CALL FLASH_WREN			;;
	CALL FLASH_WRSR			;;
	BRA CHK_FLASH_WEN		;;
CHK_FLASH_WEN_3:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_WREN:				;;
	CALL CLR_FCS			;;
	MOV #0x0006,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_WRDI:				;;
	CALL CLR_FCS			;;
	MOV #0x0004,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_WRSR2B:				;;
	CALL CLR_FCS			;;
	MOV #0x0001,W0			;;
	CALL SPIOUT			;;
	MOV W1,W0			;;
	CALL SPIOUT			;;
	MOV W1,W0			;;
	SWAP W0
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERASE_FRAM_ALL:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	CALL FLASH_BE			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_BE:				;;
	CALL CLR_FCS			;;
	MOV #0x00C7,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_BS:				;;
	PUSH W0				;;
	CALL CLR_FCS			;;
	MOV #0x00D8,W0			;;
	CALL SPIOUT			;;
	POP W0				;;
	CALL SPIOUT			;;
	MOV #0x0000,W0			;;
	CALL SPIOUT			;;
	MOV #0x0000,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URX_ERASE_WFLASH:			;;
	CALL UTX_YOU_WAIT		;;
	CALL ERASE_FRAM_ALL		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_INIT_IP:				;;
	MOV #0x0008,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_RECOK:				;;
	MOV RX_CMD,W0			;;
	BSET RX_CMD,#15			;;
	MOV W0,UTX_CMD			;;
	CLR UTX_PARA0			;;
	CLR UTX_PARA1			;;
	CLR UTX_PARA2			;;
	CLR UTX_PARA3			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_HAVE_REC:				;;
	MOV #0x0000,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_BUZY:				;;
	MOV #0x0001,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_ERR:				;;
	MOV #0x0002,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_DONE:				;;
	MOV #0x0003,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_YOU_NEXT:				;;
	MOV #0x0004,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_YOU_WAIT:				;;
	MOV #0x0005,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
UTX_YOU_STOPALL:			;;
	MOV #0x0006,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_RXDATA_ERR:				;;
	MOV #0x0007,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD_ALL			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_BUFFER_ID:				;;
	CALL UTX_START			;;
	CALL LOAD_UTX_DEVICE_ID		;;
	MOV SON_SERIAL_ID,W0		;;
	CALL LOAD_UTX_WORD		;;
	BRA UTX_BUFFER_0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_BUFFER:				;;
	CALL UTX_START			;;
	CALL LOAD_UTX_DEVICE_ID		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFFFF,W0			;;SERIAL ID
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_BUFFER_0:
	MOV #0x0000,W0			;;FLAG
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_BUFFER_LEN,W0		;;
	ADD #10,W0			;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_CMD,W0			;;
	CALL LOAD_UTX_WORD		;;
	MOV UTX_PARA0,W0		;;
	CALL LOAD_UTX_WORD		;;
	MOV UTX_PARA1,W0		;;
	CALL LOAD_UTX_WORD		;;
	MOV UTX_PARA2,W0		;;
	CALL LOAD_UTX_WORD		;;
	MOV UTX_PARA3,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_BUFFER_1:
	CALL GET_W3_BYTE		;;
	CALL LOAD_UTX_BYTE		;;
	NOP
	NOP
	NOP
	DEC UTX_BUFFER_LEN		;;
	BRA NZ,UTX_BUFFER_1		;;
	CALL UTX_END			;;
	RETURN				;;
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
LOAD_UTX_DEVICE_ID:			;;
	BTFSC U1U2_F			;;
	BRA LUDI_1			;;
	MOV #WEB_SERVER_DEVICE_ID_K,W0	;;
	CALL LOAD_UTX_BYTE		;;
	MOV #WEB_SERVER_DEVICE_ID_K,W0	;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	RETURN				;;
LUDI_1:					;;
	MOV #TFT_PANEL_DEVICE_ID_K,W0	;;
	CALL LOAD_UTX_BYTE		;;
	MOV #TFT_PANEL_DEVICE_ID_K,W0	;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_STD:				;;
	MOV UTX_MODE,W0			;;
	BRA W0
	BRA UTX_STD_ALL			;;
	BRA UTX_STD_ONE			;;	
	BRA UTX_STD_SOME		;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_STD_ONE:				;;
	CALL UTX_START			;;
	CALL LOAD_UTX_DEVICE_ID		;;
	MOV SON_SERIAL_ID,W0		;;
	NOP
	NOP
	NOP
	NOP
	CALL LOAD_UTX_WORD		;;
	BRA UTX_STD_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_STD_ALL:				;;
	CALL UTX_START			;;
	CALL LOAD_UTX_DEVICE_ID		;;
	MOV #0xFFFF,W0			;;SERIAL ID
	CALL LOAD_UTX_WORD		;;
	BRA UTX_STD_1			;;
UTX_STD_SOME:				;;
	CALL UTX_START			;;
	CALL LOAD_UTX_DEVICE_ID		;;
	MOV #0xFFFE,W0			;;SERIAL ID
	CALL LOAD_UTX_WORD		;;
	BRA UTX_STD_1			;;
UTX_STD_1:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0			;;FLAG
	CALL LOAD_UTX_WORD		;;
	MOV #10,W0			;;LEN
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
	CALL UTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_START:				;;
	BTFSS U1U2_F			;;
	BCF U1TX_EN_F			;;
	BTFSC U1U2_F			;;
	BCF U2TX_EN_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	CLR UTX_BTX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	MOV W0,UTX_CHKSUM0		;;
	CLR UTX_CHKSUM1			;;
	MOV #U1TX_BUF,W1		;;
	BTFSC U1U2_F			;;
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
	;MOV #0xFF,W0			;;
	;CALL LOAD_UBYTE_A		;;
	BTFSC U1U2_F			;;
	BRA U2TX_END			;;
U1TX_END:				;;
	MOVFF UTX_BTX,U1TX_BTX		;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BSET IFS0,#U1TXIF		;;
	RETURN				;;
U2TX_END:				;;
	BCF U2RX_EN_F			;;
	BSF RS485CTL_O			;;
	MOVFF UTX_BTX,U2TX_BTX		;;
	CLR U2TX_BCNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #300,W0			;;
	CP U2TX_WAKE_TIM		;;
	BRA LTU,U2TX_END_1		;;
	CLR U2TX_WAKE_TIM		;;	
	MOV #0,W0			;;
	MOV W0,U2TXREG			;;
	BSF U2TX_WAKE_F			;;
	RETURN				;;
U2TX_END_1:				;;
U2TX_END_START:				;;
	BSF U2TX_EN_F			;;
	BCF U2TX_END_F			;;
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
	PUSH SR				;;PUSH W0,1,2,3,SR.C.Z.N.OV.DC
	PUSH W0				;;
	BCLR IFS1,#INT1IF		;;
	BSET SR,#C			;;
	BTFSS I2C_SDA_I			;;
	BCLR SR,#C			;;
	RLC I2C_DATA2_B			;;
	RLC I2C_DATA1_B			;;
	RLC I2C_DATA0_B			;;
	MOV #0xABCD,W0			;;
	CP I2C_DATA0_B			;;
	BRA NZ,INT1I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV I2C_DATA1_B,W0		;;
	CP I2C_DATA2_B			;;
	BRA NZ,INT1I_END		;;	
	MOV I2C_DATA0_B,W0		;;
	MOV W0,I2C_DATA0		;;
	MOV I2C_DATA1_B,W0		;;
	MOV W0,I2C_DATA1		;;
	MOV I2C_DATA2_B,W0		;;
	MOV W0,I2C_DATA2		;;
INT1I_END:				;;
	POP W0				;;
	POP SR				;;
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
__U2RXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2RXIF		;;
	MOV U2RXREG,W1			;;
	AND #255,W1			;;
	BTFSS U2RX_EN_F			;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
__U1TXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS0,#U1TXIF		;;
	BTFSS U1TX_EN_F			;;
	BRA U1TXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	BCF U1TX_EN_F			;;
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
	BTFSS U2TX_EN_F			;;
	BRA U2TXI_END			;;
	CLR U2TX_WAKE_TIM		;;	
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
	BCF U2TX_EN_F			;;
	BSF U2TX_END_F			;;
	BSF U2RX_EN_F			;;
U2TXI_END:				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;










		



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









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONVERT_AD:				;;
	INC CONVAD_CNT			;;
	MOV #3,W0			;;
	CP CONVAD_CNT			;;	
	BRA LTU,$+4			;;
	CLR CONVAD_CNT	 		;;
	MOV CONVAD_CNT,W0 		;;
	BRA W0				;;
	BRA CONV_J0			;;
	BRA CONV_J1			;;
	BRA CONV_J2			;;
CONV_J0:				;;
	MOV #15,W0			;;	
	MOV W0,AD1CHS0			;;
	BSET AD1CON1,#SAMP		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONV_J1:				;;
	BCLR AD1CON1,#SAMP		;;
	RETURN				;;
CONV_J2:				;;
	BTSS AD1CON1,#DONE		;;
	RETURN				;;
	MOV ADC1BUF0,W0			;;
	MOV W0,VR1BUF			;;
	BCLR AD1CON1,#DONE		;;
	RRC VR1BUF			;;
	RRC VR1BUF			;;
	MOV VR1BUF,W0			;;	
	AND #255,W0			;;
	SWAP W0				;;
	MOV #212,W2			;;
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	MOV W0,VR1V			;;
	SWAP W0				;;
	AND #255,W0			;;
	BRA Z,$+6			;;
	MOV #255,W0			;;
	MOV W0,VR1V			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;














;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T1Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	PUSH W2			;;
	BCLR IFS0,#T1IF		;;
	;TG TP1_O		;;	
	;BRA T1I_END		;;
	INC MCUTX2_TIM		;;
	MOV #3,W0		;;
	CP MCUTX2_TIM		;;
	BRA LTU,T1I_1		;;
	CLR MCUTX2_TIM		;;
	BTFSS MCUTX2_START_F	;;
	BRA T1I_1		;;
	MOV #MCUTX2_BUF,W1	;;
	MOV MCUTX2_BYTE_CNT,W0	;;
	ADD W0,W1,W1		;;	
	ADD W0,W1,W1		;;	
	MOV [W1],W0		;;
	MOV MCUTX2_BIT_CNT,W2	;;
	LSR W0,W2,W0		;;
	BTSC  W0,#0		;;
	;BSF TP1_O		;;	
	BSF MCU_TX2_O		;;	
	BTSS  W0,#0		;;
	;BCF TP1_O		;;	
	BCF MCU_TX2_O		;;	
	INC MCUTX2_BIT_CNT	;;
	MOV MCUTX2_BIT_LEN,W0	;;
	CP MCUTX2_BIT_CNT	;;
	BRA LTU,T1I_1	 	;;
	CLR MCUTX2_BIT_CNT	;;
	INC MCUTX2_BYTE_CNT	;;
	MOV MCUTX2_BYTE,W0	;;	
	CP MCUTX2_BYTE_CNT	;;
	BRA LTU,T1I_1		;;
	BCF MCUTX2_START_F	;;
T1I_1:				;;
	INC MCURX2_CLR_TIM	;;
	BRA NZ,$+4		;;
	DEC MCURX2_CLR_TIM	;;
	MOV #48,W0		;;
	ADD MCURX2_END_BIT,WREG	;;
	CP MCURX2_CLR_TIM	;;
	BRA NZ,T1I_2		;;
	BSF MCURX2_RXIN_F	;;
	BCF MCURX2_START_F	;; 	
	MOV MCURX2_PCNT0,W0	;;	
	MOV W0,MCURX2_END_CNT	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
T1I_2:				;;
	BTFSS MCURX2_START_F	;;
	BRA T1I_END		;;
	MOV MCUTX2_TIM,W0	;;	
	CP MCURX2_TIM		;;
	BRA NZ,T1I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RRNC MCURX2_IBUF	;;
	BSET MCURX2_IBUF,#15	;;
	BTFSS MCU_RX2_I		;;
	BCLR MCURX2_IBUF,#15	;;
	INC MCURX2_BIT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0		;;
	BTSC MCUU2_MODE,#0	;;PARITY L
	BRA T1I_ODD		;;
	BTSC MCUU2_MODE,#1	;;PARITY L
	BRA T1I_EVEN		;;
T1I_NONE:			;;
	CP MCURX2_BIT		;;
	BRA LTU,T1I_END		;;
	BCF MCURX2_START_F	;;
	BTSC MCURX2_IBUF,#6	;;
	BRA T1I_END		;;
	BTSS MCURX2_IBUF,#15	;;
	BRA T1I_END		;;
	BRA T1I_BIN		;;
T1I_ODD:			;;
T1I_EVEN:			;;
	INC W0,W0		;;
	CP MCURX2_BIT		;;
	BRA LTU,T1I_END		;;
	BCF MCURX2_START_F	;;
	RLNC MCURX2_IBUF	;;	
	BTSC MCURX2_IBUF,#6	;;
	BRA T1I_END		;;
	BTSS MCURX2_IBUF,#0	;;
	BRA T1I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX2_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #511,W0		;;
	MOV W0,W2		;;
	SWAP.B W0		;;
	XOR W2,W0,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0		;;	
	SWAP.B W0		;;
	XOR W2,W0,W0		;;
	LSR W0,#2,W2		;;
	XOR W0,W2,W0		;;
	LSR W0,#1,W2		;;
	XOR W0,W2,W0		;;
	BTSC MCUU2_MODE,#0	;;
	XOR #1,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC W0,#1		;;
	BRA T1I_END		;;
T1I_BIN:			;;
	INC MCURX2_PCNT0	;;
	MOV #127,W0		;;	
	AND MCURX2_PCNT0	;;
	MOV #MCURX2_BUF,W1	;;
	MOV MCURX2_PCNT0,W0	;;
	ADD W0,W1,W1		;;
	BCLR W1,#0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W2		;;
	MOV #0x00FF,W0		;;
	BTSS MCURX2_PCNT0,#0	;;
	MOV #0xFF00,W0		;;
	AND W0,W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX2_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #255,W0		;;
	BTSC MCURX2_PCNT0,#0	;;
	SWAP W0			;;
	IOR W0,W2,W0		;;
	MOV W0,[W1]		;;	
T1I_END:			;;
	POP W2			;;
	POP W1			;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T3Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	PUSH W2			;;
	BCLR IFS0,#T3IF		;;
	INC MCUTX3_TIM		;;
	MOV #3,W0		;;
	CP MCUTX3_TIM		;;
	BRA LTU,T3I_1		;;
	CLR MCUTX3_TIM		;;
	BTFSS MCUTX3_START_F	;;
	BRA T3I_1		;;
	MOV #MCUTX3_BUF,W1	;;
	MOV MCUTX3_BYTE_CNT,W0	;;
	ADD W0,W1,W1		;;	
	ADD W0,W1,W1		;;	
	MOV [W1],W0		;;
	MOV MCUTX3_BIT_CNT,W2	;;
	LSR W0,W2,W0		;;
	BTSC  W0,#0		;;
	;BSF TP5_O		;;	
	BSF MCU_TX3_O		;;	
	BTSS  W0,#0		;;
	;BCF TP5_O		;;	
	BCF MCU_TX3_O		;;	
	INC MCUTX3_BIT_CNT	;;
	MOV MCUTX3_BIT_LEN,W0	;;
	CP MCUTX3_BIT_CNT	;;
	BRA LTU,T3I_1	 	;;
	CLR MCUTX3_BIT_CNT	;;
	INC MCUTX3_BYTE_CNT	;;
	MOV MCUTX3_BYTE,W0	;;	
	CP MCUTX3_BYTE_CNT	;;
	BRA LTU,T3I_1		;;
	BCF MCUTX3_START_F	;;
T3I_1:				;;
	INC MCURX3_CLR_TIM	;;
	BRA NZ,$+4		;;
	DEC MCURX3_CLR_TIM	;;
	MOV #48,W0		;;
	ADD MCURX3_END_BIT,WREG	;;
	CP MCURX3_CLR_TIM	;;
	BRA NZ,T3I_2		;;
	BSF MCURX3_RXIN_F	;;
	BCF MCURX3_START_F	;; 	
	MOV MCURX3_PCNT0,W0	;;	
	MOV W0,MCURX3_END_CNT	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
T3I_2:				;;
	BTFSS MCURX3_START_F	;;
	BRA T3I_END		;;
	MOV MCUTX3_TIM,W0	;;	
	CP MCURX3_TIM		;;
	BRA NZ,T3I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RRNC MCURX3_IBUF	;;
	BSET MCURX3_IBUF,#15	;;
	BTFSS MCU_RX3_I		;;
	BCLR MCURX3_IBUF,#15	;;
	INC MCURX3_BIT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0		;;
	BTSC MCUU3_MODE,#0	;;PARITY L
	BRA T3I_ODD		;;
	BTSC MCUU3_MODE,#1	;;PARITY L
	BRA T3I_EVEN		;;
T3I_NONE:			;;
	CP MCURX3_BIT		;;
	BRA LTU,T3I_END		;;
	BCF MCURX3_START_F	;;
	BTSC MCURX3_IBUF,#6	;;
	BRA T3I_END		;;
	BTSS MCURX3_IBUF,#15	;;
	BRA T3I_END		;;
	BRA T3I_BIN		;;
T3I_ODD:			;;
T3I_EVEN:			;;
	INC W0,W0		;;
	CP MCURX3_BIT		;;
	BRA LTU,T3I_END		;;
	BCF MCURX3_START_F	;;
	RLNC MCURX3_IBUF	;;	
	BTSC MCURX3_IBUF,#6	;;
	BRA T3I_END		;;
	BTSS MCURX3_IBUF,#0	;;
	BRA T3I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX3_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #511,W0		;;
	MOV W0,W2		;;
	SWAP.B W0		;;
	XOR W2,W0,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0		;;	
	SWAP.B W0		;;
	XOR W2,W0,W0		;;
	LSR W0,#2,W2		;;
	XOR W0,W2,W0		;;
	LSR W0,#1,W2		;;
	XOR W0,W2,W0		;;
	BTSC MCUU3_MODE,#0	;;
	XOR #1,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC W0,#1		;;
	BRA T3I_END		;;
T3I_BIN:			;;
	INC MCURX3_PCNT0	;;
	MOV #127,W0		;;	
	AND MCURX3_PCNT0	;;
	MOV #MCURX3_BUF,W1	;;
	MOV MCURX3_PCNT0,W0	;;
	ADD W0,W1,W1		;;
	BCLR W1,#0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W2		;;
	MOV #0x00FF,W0		;;
	BTSS MCURX3_PCNT0,#0	;;
	MOV #0xFF00,W0		;;
	AND W0,W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX3_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #255,W0		;;
	BTSC MCURX3_PCNT0,#0	;;
	SWAP W0			;;
	IOR W0,W2,W0		;;
	MOV W0,[W1]		;;	
T3I_END:			;;
	POP W2			;;
	POP W1			;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T4Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	PUSH W2			;;
	BCLR IFS1,#T4IF		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC MCUTX45_TIM		;;
	MOV #3,W0		;;
	CP MCUTX45_TIM		;;
	BRA LTU,T4I_RX4		;;
	CLR MCUTX45_TIM		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_TX4:
	BTFSS MCUTX4_START_F	;;
	BRA T4I_TX5		;;
	MOV #MCUTX4_BUF,W1	;;
	MOV MCUTX4_BYTE_CNT,W0	;;
	ADD W0,W1,W1		;;	
	ADD W0,W1,W1		;;	
	MOV [W1],W0		;;
	MOV MCUTX4_BIT_CNT,W2	;;
	LSR W0,W2,W0		;;
	BTSC  W0,#0		;;
	BSF MCU_TX4_O		;;	
	BTSS  W0,#0		;;
	BCF MCU_TX4_O		;;	
	INC MCUTX4_BIT_CNT	;;
	MOV MCUTX4_BIT_LEN,W0	;;
	CP MCUTX4_BIT_CNT	;;
	BRA LTU,T4I_TX5	 	;;
	CLR MCUTX4_BIT_CNT	;;
	INC MCUTX4_BYTE_CNT	;;
	MOV MCUTX4_BYTE,W0	;;	
	CP MCUTX4_BYTE_CNT	;;
	BRA LTU,T4I_TX5		;;
	BCF MCUTX4_START_F	;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_TX5:                        ;;
	BTFSS MCUTX5_START_F	;;
	BRA T4I_RX4		;;
	MOV #MCUTX5_BUF,W1	;;
	MOV MCUTX5_BYTE_CNT,W0	;;
	ADD W0,W1,W1		;;	
	ADD W0,W1,W1		;;	
	MOV [W1],W0		;;
	MOV MCUTX5_BIT_CNT,W2	;;
	LSR W0,W2,W0		;;
	BTSC  W0,#0		;;
	BSF MCU_TX5_O		;;	
	BTSS  W0,#0		;;
	BCF MCU_TX5_O		;;	
	INC MCUTX5_BIT_CNT	;;
	MOV MCUTX5_BIT_LEN,W0	;;
	CP MCUTX5_BIT_CNT	;;
	BRA LTU,T4I_RX4	 	;;
	CLR MCUTX5_BIT_CNT	;;
	INC MCUTX5_BYTE_CNT	;;
	MOV MCUTX5_BYTE,W0	;;	
	CP MCUTX5_BYTE_CNT	;;
	BRA LTU,T4I_RX4		;;
	BCF MCUTX5_START_F	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_RX4:			;;
	INC MCURX4_CLR_TIM	;;
	BRA NZ,$+4		;;
	DEC MCURX4_CLR_TIM	;;
	MOV #48,W0		;;
	ADD MCURX4_END_BIT,WREG	;;
	CP MCURX4_CLR_TIM	;;
	BRA NZ,T4I_RX4_1	;;
	BSF MCURX4_RXIN_F	;;
	BCF MCURX4_START_F	;; 	
	MOV MCURX4_PCNT0,W0	;;	
	MOV W0,MCURX4_END_CNT	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_RX4_1:			;;
	BTFSS MCURX4_START_F	;;
	BRA T4I_RX5		;;
	MOV MCUTX45_TIM,W0	;;	
	CP MCURX4_TIM		;;
	BRA NZ,T4I_RX5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RRNC MCURX4_IBUF	;;
	BSET MCURX4_IBUF,#15	;;
	BTFSS MCU_RX4_I		;;
	BCLR MCURX4_IBUF,#15	;;
	INC MCURX4_BIT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0		;;
	BTSC MCUU45_MODE,#0	;;PARITY L
	BRA T4I_RX4_ODD		;;
	BTSC MCUU45_MODE,#1	;;PARITY L
	BRA T4I_RX4_EVEN	;;
T4I_RX4_NONE:			;;
	CP MCURX4_BIT		;;
	BRA LTU,T4I_RX5		;;
	BCF MCURX4_START_F	;;
	BTSC MCURX4_IBUF,#6	;;
	BRA T4I_RX5		;;
	BTSS MCURX4_IBUF,#15	;;
	BRA T4I_RX5		;;
	BRA T4I_RX4_BIN		;;
T4I_RX4_ODD:			;;
T4I_RX4_EVEN:			;;
	INC W0,W0		;;
	CP MCURX4_BIT		;;
	BRA LTU,T4I_RX5		;;
	BCF MCURX4_START_F	;;
	RLNC MCURX4_IBUF	;;	
	BTSC MCURX4_IBUF,#6	;;
	BRA T4I_RX5		;;
	BTSS MCURX4_IBUF,#0	;;
	BRA T4I_RX5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX4_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #511,W0		;;
	MOV W0,W2		;;
	SWAP.B W0		;;
	XOR W2,W0,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0		;;	
	SWAP.B W0		;;
	XOR W2,W0,W0		;;
	LSR W0,#2,W2		;;
	XOR W0,W2,W0		;;
	LSR W0,#1,W2		;;
	XOR W0,W2,W0		;;
	BTSC MCUU45_MODE,#0	;;
	XOR #1,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC W0,#1		;;
	BRA T4I_RX5		;;
T4I_RX4_BIN:			;;
	INC MCURX4_PCNT0	;;
	MOV #127,W0		;;	
	AND MCURX4_PCNT0	;;
	MOV #MCURX4_BUF,W1	;;
	MOV MCURX4_PCNT0,W0	;;
	ADD W0,W1,W1		;;
	BCLR W1,#0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W2		;;
	MOV #0x00FF,W0		;;
	BTSS MCURX4_PCNT0,#0	;;
	MOV #0xFF00,W0		;;
	AND W0,W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX4_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #255,W0		;;
	BTSC MCURX4_PCNT0,#0	;;
	SWAP W0			;;
	IOR W0,W2,W0		;;
	MOV W0,[W1]		;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_RX5:                        ;;
	INC MCURX5_CLR_TIM	;;
	BRA NZ,$+4		;;
	DEC MCURX5_CLR_TIM	;;
	MOV #48,W0		;;
	ADD MCURX5_END_BIT,WREG	;;
	CP MCURX5_CLR_TIM	;;
	BRA NZ,T4I_RX5_1	;;
	BSF MCURX5_RXIN_F	;;
	BCF MCURX5_START_F	;; 	
	MOV MCURX5_PCNT0,W0	;;	
	MOV W0,MCURX5_END_CNT	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_RX5_1:			;;
	BTFSS MCURX5_START_F	;;
	BRA T4I_END		;;
	MOV MCUTX45_TIM,W0	;;	
	CP MCURX5_TIM		;;
	BRA NZ,T4I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RRNC MCURX5_IBUF	;;
	BSET MCURX5_IBUF,#15	;;
	BTFSS MCU_RX5_I		;;
	BCLR MCURX5_IBUF,#15	;;
	INC MCURX5_BIT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0		;;
	BTSC MCUU45_MODE,#0	;;PARITY L
	BRA T4I_RX5_ODD		;;
	BTSC MCUU45_MODE,#1	;;PARITY L
	BRA T4I_RX5_EVEN	;;
T4I_RX5_NONE:			;;
	CP MCURX5_BIT		;;
	BRA LTU,T4I_END		;;
	BCF MCURX5_START_F	;;
	BTSC MCURX5_IBUF,#6	;;
	BRA T4I_END		;;
	BTSS MCURX5_IBUF,#15	;;
	BRA T4I_END		;;
	BRA T4I_RX5_BIN		;;
T4I_RX5_ODD:			;;
T4I_RX5_EVEN:			;;
	INC W0,W0		;;
	CP MCURX5_BIT		;;
	BRA LTU,T4I_END		;;
	BCF MCURX5_START_F	;;
	RLNC MCURX5_IBUF	;;	
	BTSC MCURX5_IBUF,#6	;;
	BRA T4I_END		;;
	BTSS MCURX5_IBUF,#0	;;
	BRA T4I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX5_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #511,W0		;;
	MOV W0,W2		;;
	SWAP.B W0		;;
	XOR W2,W0,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0		;;	
	SWAP.B W0		;;
	XOR W2,W0,W0		;;
	LSR W0,#2,W2		;;
	XOR W0,W2,W0		;;
	LSR W0,#1,W2		;;
	XOR W0,W2,W0		;;
	BTSC MCUU45_MODE,#0	;;
	XOR #1,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC W0,#1		;;
	BRA T4I_END		;;
T4I_RX5_BIN:			;;
	INC MCURX5_PCNT0	;;
	MOV #127,W0		;;	
	AND MCURX5_PCNT0	;;
	MOV #MCURX5_BUF,W1	;;
	MOV MCURX5_PCNT0,W0	;;
	ADD W0,W1,W1		;;
	BCLR W1,#0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W2		;;
	MOV #0x00FF,W0		;;
	BTSS MCURX5_PCNT0,#0	;;
	MOV #0xFF00,W0		;;
	AND W0,W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX5_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #255,W0		;;
	BTSC MCURX5_PCNT0,#0	;;
	SWAP W0			;;
	IOR W0,W2,W0		;;
	MOV W0,[W1]		;;	
T4I_END:			;;
	POP W2			;;
	POP W1			;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T5Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	PUSH W2			;;
	BCLR IFS1,#T5IF		;;
	INC MCUTX1_TIM		;;
	MOV #3,W0		;;
	CP MCUTX1_TIM		;;
	BRA LTU,T5I_1		;;
	CLR MCUTX1_TIM		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC MCUTX1_DLY_BIT      ;;
        BTSC SR,#Z              ;;
        DEC MCUTX1_DLY_BIT      ;;
        MOV MCUU1_TX_PERIOD,W0   ;;
        CP MCUTX1_DLY_BIT       ;;
        BRA LTU,T5I_1           ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;      
	BTFSS MCUTX1_START_F	;;
	BRA T5I_1		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #MCUTX1_BUF,W1	;;
	MOV MCUTX1_BYTE_CNT,W0	;;
	ADD W0,W1,W1		;;	
	ADD W0,W1,W1		;;	
	MOV [W1],W0		;;
	MOV MCUTX1_BIT_CNT,W2	;;
	LSR W0,W2,W0		;;
	BTSC  W0,#0		;;
	BSF MCU_TX1_O		;;	
	BTSS  W0,#0		;;
	BCF MCU_TX1_O		;;	
	INC MCUTX1_BIT_CNT	;;
	MOV MCUTX1_BIT_LEN,W0	;;
	CP MCUTX1_BIT_CNT	;;
	BRA LTU,T5I_1	 	;;
	CLR MCUTX1_BIT_CNT	;;
	INC MCUTX1_BYTE_CNT	;;
	MOV MCUTX1_BYTE,W0	;;	
	CP MCUTX1_BYTE_CNT	;;
	BRA LTU,T5I_1		;;
	BCF MCUTX1_START_F	;;
        CLR MCUTX1_DLY_BIT      ;;
T5I_1:				;;
	INC MCURX1_CLR_TIM	;;
	BRA NZ,$+4		;;
	DEC MCURX1_CLR_TIM	;;
	MOV #48,W0		;;
	ADD MCURX1_END_BIT,WREG	;;
	CP MCURX1_CLR_TIM	;;
	BRA NZ,T5I_2		;;
	BSF MCURX1_RXIN_F	;;
	BCF MCURX1_START_F	;; 	
	MOV MCURX1_PCNT0,W0	;;	
	MOV W0,MCURX1_END_CNT	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
T5I_2:				;;
	BTFSS MCURX1_START_F	;;
	BRA T5I_END		;;
	MOV MCUTX1_TIM,W0	;;	
	CP MCURX1_TIM		;;
	BRA NZ,T5I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RRNC MCURX1_IBUF	;;
	BSET MCURX1_IBUF,#15	;;
	BTFSS MCU_RX1_I		;;
	BCLR MCURX1_IBUF,#15	;;
	INC MCURX1_BIT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0		;;
	BTSC MCUU1_MODE,#0	;;PARITY L
	BRA T5I_ODD		;;
	BTSC MCUU1_MODE,#1	;;PARITY L
	BRA T5I_EVEN		;;
T5I_NONE:			;;
	CP MCURX1_BIT		;;
	BRA LTU,T5I_END		;;
	BCF MCURX1_START_F	;;
	BTSC MCURX1_IBUF,#6	;;
	BRA T5I_END		;;
	BTSS MCURX1_IBUF,#15	;;
	BRA T5I_END		;;
	BRA T5I_BIN		;;
T5I_ODD:			;;
T5I_EVEN:			;;
	INC W0,W0		;;
	CP MCURX1_BIT		;;
	BRA LTU,T5I_END		;;
	BCF MCURX1_START_F	;;
	RLNC MCURX1_IBUF	;;	
	BTSC MCURX1_IBUF,#6	;;
	BRA T5I_END		;;
	BTSS MCURX1_IBUF,#0	;;
	BRA T5I_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX1_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #511,W0		;;
	MOV W0,W2		;;
	SWAP.B W0		;;
	XOR W2,W0,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0		;;	
	SWAP.B W0		;;
	XOR W2,W0,W0		;;
	LSR W0,#2,W2		;;
	XOR W0,W2,W0		;;
	LSR W0,#1,W2		;;
	XOR W0,W2,W0		;;
	BTSC MCUU1_MODE,#0	;;
	XOR #1,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC W0,#1		;;
	BRA T5I_END		;;
T5I_BIN:			;;
	INC MCURX1_PCNT0	;;
	MOV #127,W0		;;	
	AND MCURX1_PCNT0	;;
	MOV #MCURX1_BUF,W1	;;
	MOV MCURX1_PCNT0,W0	;;
	ADD W0,W1,W1		;;
	BCLR W1,#0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W2		;;
	MOV #0x00FF,W0		;;
	BTSS MCURX1_PCNT0,#0	;;
	MOV #0xFF00,W0		;;
	AND W0,W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX1_IBUF,W0	;;
	LSR W0,#7,W0		;;
	AND #255,W0		;;
	BTSC MCURX1_PCNT0,#0	;;
	SWAP W0			;;
	IOR W0,W2,W0		;;
	MOV W0,[W1]		;;	
T5I_END:			;;
	POP W2			;;
	POP W1			;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__IC1Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	BCLR IFS0,#IC1IF	;;
IC1I_1:				;;
	MOV IC1BUF,W0		;;
	BTSC IC1CON1,#3		;;
	BRA IC1I_1		;;
	CLR MCURX2_CLR_TIM	;;
	BTFSS MCURX2_START_F	;;
	CLR MCURX2_BIT		;;
	MOV MCUTX2_TIM,W0	;;	
	DEC W0,W0		;;
	BTSC W0,#15		;;
	MOV #2,W0		;;
	MOV W0,MCURX2_TIM	;;
	BSF MCURX2_START_F	;;	
	BTSC IC1CON1,#0		;;
	BSF TP3_O		;;
	BTSS IC1CON1,#0		;;
	BCF TP3_O		;;
IC1I_END:			;;
	BTG IC1CON1,#0		;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__IC2Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	BCLR IFS0,#IC2IF	;;
IC2I_1:				;;
	MOV IC2BUF,W0		;;
	BTSC IC2CON1,#3		;;
	BRA IC2I_1		;;
	CLR MCURX3_CLR_TIM	;;
	BTFSS MCURX3_START_F	;;
	CLR MCURX3_BIT		;;
	MOV MCUTX3_TIM,W0	;;	
	DEC W0,W0		;;
	BTSC W0,#15		;;
	MOV #2,W0		;;
	MOV W0,MCURX3_TIM	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF MCURX3_START_F	;;	
	BTSC IC2CON1,#0		;;
	BSF TP4_O		;;
	BTSS IC2CON1,#0		;;
	BCF TP4_O		;;
IC2I_END:			;;
	BTG IC2CON1,#0		;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__IC3Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	BCLR IFS2,#IC3IF	;;
IC3I_1:				;;
	MOV IC3BUF,W0		;;
	BTSC IC3CON1,#3		;;
	BRA IC3I_1		;;
	CLR MCURX4_CLR_TIM	;;
	BTFSS MCURX4_START_F	;;
	CLR MCURX4_BIT		;;
	MOV MCUTX45_TIM,W0	;;	
	DEC W0,W0		;;
	BTSC W0,#15		;;
	MOV #2,W0		;;
	MOV W0,MCURX4_TIM	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF MCURX4_START_F	;;	
IC3I_END:			;;
	BTG IC3CON1,#0		;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__INT2Interrupt:		;;	;;10 US
	PUSH SR			;;
	PUSH W0			;;
	BCLR IFS1,#INT2IF	;;
	CLR MCURX5_CLR_TIM	;;
	BTFSS MCURX5_START_F	;;
	CLR MCURX5_BIT		;;
	MOV MCUTX45_TIM,W0	;;	
	DEC W0,W0		;;
	BTSC W0,#15		;;
	MOV #2,W0		;;
	MOV W0,MCURX5_TIM	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF MCURX5_START_F	;;	
INT2_END:			;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__IC4Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	BCLR IFS2,#IC4IF	;;
IC4I_1:				;;
	MOV IC4BUF,W0		;;
	BTSC IC4CON1,#3		;;
	BRA IC4I_1		;;
	CLR MCURX1_CLR_TIM	;;
	BTFSS MCURX1_START_F	;;
	CLR MCURX1_BIT		;;
	MOV MCUTX1_TIM,W0	;;	
	DEC W0,W0		;;
	BTSC W0,#15		;;
	MOV #2,W0		;;
	MOV W0,MCURX1_TIM	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF MCURX1_START_F	;;	
IC4I_END:			;;
	BTG IC4CON1,#0		;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




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
	.WORD 0x3F12			;;0x12
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



;OLED FLASH DESCRIPTION
;===================================================================
;0x000000~0x000003: oledKbId=0xabcd0001 h2l
;0x000004	  : oledKb Amount
;0x000004	  : defaultKbInx
;0x000020	  : initial kbName		
;rs422 ch1
;0x000040	  :
;0x000040~1B	  : uart port
;0x000041~1B	  : uart data bit
;0x000042~4B	  : uart boudrate l2h
;0x000046~1B	  : uart parity 0:none 1:odd 2:even
;0x000047~1B	  : uart stop bit 
;0x000048~1B	  : packageType 
;0x000049~1B	  : enable/deisable 0:enable 
;0x00004a~2B	  : txPeriodBit
;rs422 ch2
;0x000050	  :
;0x000050~1B	  : uart port
;0x000051~1B	  : uart data bit
;0x000052~4B	  : uart boudrate l2h
;0x000056~1B	  : uart parity 0:none 1:odd 2:even
;0x000057~1B	  : uart stop bit 
;0x000058~1B	  : packageType 
;0x000059~1B	  : enable/deisable 0:enable 
;0x00005a~2B	  : txPeriodBit
;usb232
;0x000060	  :
;0x000060~1B	  : uart port
;0x000061~1B	  : uart data bit
;0x000062~4B	  : uart boudrate l2h
;0x000066~1B	  : uart parity 0:none 1:odd 2:even
;0x000067~1B	  : uart stop bit 
;0x000068~1B	  : packageType 
;0x000069~1B	  : enable/deisable 0:enable 
;0x00005a~2B	  : txPeriodBit
;rs232
;0x000070	  :
;0x000070~1B	  : uart port
;0x000071~1B	  : uart data bit
;0x000072~4B	  : uart boudrate l2h
;0x000076~1B	  : uart parity 0:none 1:odd 2:even
;0x000077~1B	  : uart stop bit 
;0x000078~1B	  : packageType 
;0x000079~1B	  : enable/deisable 0:enable 
;0x00007a~2B	  : txPeriodBit




;===================================================================
;keyboard A
;0x001000~32B	  : keyboard name 
;	
;0x001020~1B	  : uart port
;0x001021~1B	  : uart data bit
;0x001022~4B	  : uart boudrate l2h
;0x001026~1B	  : uart parity 0:none 1:odd 2:even
;0x001027~1B	  : uart stop bit 
;0x001028~1B	  : lightUpKey 
;0x001029~1B	  : lightDownKey 
;0x00102a~1B	  : testKey 
;0x00102b~1B	  : stopKey 
;
;0x001040~1B	  : switch keyboard key ;0=none
;0x001041~1B	  : switch keyboard typeCnt
;0x001042~30B	  : the name of keyboard switch
;
;0x001060~1B	  : switch keyboard key ;0=none
;0x001061~1B	  : switch keyboard typeCnt
;0x001062~30B	  : the name of keyboard switch
;
;0x001080~1B	  : switch keyboard key ;0=none
;0x001081~1B	  : switch keyboard typeCnt
;0x001082~30B	  : the name of keyboard switch
;
;0x0010A0~1B	  : switch keyboard key ;0=none
;0x0010A1~1B	  : switch keyboard typeCnt
;0x0010A2~30B	  : the name of keyboard switch
;
;0x0010c0~1B	  : switch keyboard key ;0=none
;0x0010C1~1B	  : switch keyboard typeCnt
;0x0010c2~30B	  : the name of keyboard switch
;
;0x0010e0~1B	  : switch keyboard key ;0=none
;0x0010E1~1B	  : switch keyboard typeCnt
;0x0010e2~30B	  : the name of keyboard switch
;
;0x001100~1B	  : switch keyboard key ;0=none
;0x001101~1B	  : switch keyboard typeCnt
;0x001102~30B	  : the name of keyboard switch


;
;
;key 1
;0x001120~2B	  : keyId 0xABCD 
;0x001122~1B 	  : ASCII or HEX 0:ASCII, 1:HEX
;0x001123~1B 	  : B76:SERIAL_CHANNEL,B54:OUTPUT MODE,B30:OUTPUT PORT   
;0x001124~3B 	  : press tx code address(l2h), real must x4 
;0x001127~3B 	  : release tx code address(l2h), real must x4 
;0x00112A~3B 	  : continue tx code address(l2h), real must x4 
;0x00112D~3B 	  : rx code address(l2h) of switch to page 1, real must x4 
;0x001130~3B 	  : rx code address(l2h) of switch to page 2, real must x4 
;0x001133~3B 	  : rx code address(l2h) of switch to page 3, real must x4 
;0x001136~3B 	  : rx code address(l2h) of switch to page 4, real must x4 
;0x001139~3B 	  : rx code address(l2h) of switch to page 5, real must x4 
;0x00113C~3B 	  : rx code address(l2h) of switch to page 6, real must x4 
;0x00113F~3B 	  : rx code address(l2h) of switch to page 7, real must x4 
;0x001142~3B 	  : rx code address(l2h) of switch to page 8, real must x4 

;0x001145~3B 	  : image address(l2h) of page 1, real must x4 
;0x001148~3B 	  : image address(l2h) of page 2, real must x4 
;0x00114B~3B 	  : image address(l2h) of page 3, real must x4 
;0x00114E~3B 	  : image address(l2h) of page 4, real must x4 
;0x001151~3B 	  : image address(l2h) of page 5, real must x4 
;0x001154~3B 	  : image address(l2h) of page 6, real must x4 
;0x001157~3B 	  : image address(l2h) of page 7, real must x4 
;0x00115A~3B 	  : image address(l2h) of page 8, real must x4 





;key2
;0x001160~2B	  : keyId 0xABCD 
;0x001162~1B 	  : ASCII or HEX 0:ASCII, 1:HEX
;0x001163~3B 	  : press tx code address(l2h), real must x4 
;0x001166~3B 	  : release tx code address(l2h), real must x4 
;0x001169~3B 	  : continue tx code address(l2h), real must x4 
;0x00116c~3B 	  : rx code address(l2h) of switch to page 1, real must x4 
;0x00116f~3B 	  : rx code address(l2h) of switch to page 2, real must x4 
;0x001172~3B 	  : rx code address(l2h) of switch to page 3, real must x4 
;0x001175~3B 	  : image address(l2h) of page 1, real must x4 
;0x001178~3B 	  : image address(l2h) of page 2, real must x4 
;0x00117b~3B 	  : image address(l2h) of page 3, real must x4 
;0x00117E~1B 	  : RESERVE 
;0x00117F~1B 	  : B76:SERIAL_CHANNEL,B54:OUTPUT MODE,B30:OUTPUT PORT   
;0x001180~3B 	  : rx code address(l2h) of switch to page 4, real must x4 
;0x001183~3B 	  : rx code address(l2h) of switch to page 5, real must x4 
;0x001186~3B 	  : rx code address(l2h) of switch to page 6, real must x4 
;0x001189~3B 	  : rx code address(l2h) of switch to page 7, real must x4 
;0x00118C~3B 	  : rx code address(l2h) of switch to page 8, real must x4 
;0x00118E~1B 	  : RESERVE 
;0x00118F~1B 	  : RESERVE 
;0x001190~3B 	  : image address(l2h) of page 4, real must x4 
;0x001193~3B 	  : image address(l2h) of page 5, real must x4 
;0x001196~3B 	  : image address(l2h) of page 6, real must x4 
;0x001199~3B 	  : image address(l2h) of page 7, real must x4 
;0x00119C~3B 	  : image address(l2h) of page 8, real must x4 
;0x00119E~1B 	  : RESERVE 
;0x00119F~1B 	  : RESERVE 

;key3
;.................
;.................
;.................
;===================================================================
;keyboard B
;0x003000~64B	  : keyboard name
;same as above
;.................
;.................
;.................
;===================================================================
;keyboard C
;.................
;.................
;.................

;dymaddr address 
;0x010000	  : dymaddr start address 





