;******************************************************************************
;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 


	
 

        .equ __24ep64gp206, 1 ;
        .include "p24ep64gp206.inc"

;BY DEFINE=============================
;	.EQU	U2TX_TEST_DK	,1	
;	.EQU 	IICM_DK		,1
;	.EQU 	IICS_DK		,1
;====================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'
	.EQU 	SLOT_DEVICE_ID_K	,0x8900
	.EQU 	SLOTCLR_DEVICE_ID_K	,0x8902

	.EQU 	F24SET_FADR	,0xA000	;DONT USE THE LAST BLOCK OF FLASH(0x0A800)
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
  	.global __T4Interrupt    
  	.global __U1RXInterrupt    
  	.global __U1TXInterrupt  
  	.global __U2RXInterrupt    
  	.global __U2TXInterrupt  

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
	




;*************************
.MACRO 	LXY XX,YY
	MOV #\XX,W0
	MOV W0,LCDX
	MOV #\YY,W0
	MOV W0,LCDY
.ENDM
;-------------------------
.MACRO 	LOXY XX,YY
	MOV #\XX,W0
	MOV W0,LCDX
	MOV #\YY,W0
	MOV W0,LCDY
	CALL GOTOXY
.ENDM


;*************************
.MACRO 	LW10 XX,YY
	MOV #\XX,W1
	MOV #\YY,W0
.ENDM
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
DEBUG_B0:		.SPACE 2		
;;====================================
TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2		
TMR2H_BUF:		.SPACE 2
;;====================================
FLAGA:	        	.SPACE 2
FLAGB:	        	.SPACE 2
FLAGC:	        	.SPACE 2
FLAGD:	        	.SPACE 2
ADBUF:	        	.SPACE 2
;;====================================
CMDINX:			.SPACE 2
CMDSTEP:		.SPACE 2
;;====================================
TARGET_SERIAL_ID:	.SPACE 2

CONVAD_CNT:		.SPACE 2
;ICTXPARA_GRP_CNT:	.SPACE 2
;ICTXPARA_ONCE_CNT:	.SPACE 2
;TPRG1_CNT:		.SPACE 2
;TPRG2_CNT:		.SPACE 2
;;====================================
KEYCODE:		.SPACE 2
KEY_BUF:		.SPACE 2
KEY_TMP:		.SPACE 2
YESKEY_CNT:		.SPACE 2
NOKEY_CNT:		.SPACE 2
CONKEY_CNT:		.SPACE 2


DISPLAY_MOD:		.SPACE 2
dispDelayTime:		.SPACE 2
beepTime:		.SPACE 2
shiftTime:		.SPACE 2
shiftFlag:		.SPACE 2
u1txTime:		.SPACE 2


;;====================================
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


;DUTX_LEN:		.SPACE 2
;WAIT_DUTX_TIM:		.SPACE 2
F24SET_BUF:		.SPACE 64
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
U1RX_BYTE_PBUF:		.SPACE 2
U1RX_BYTE_LEN:		.SPACE 2
U1RX_BYTE_PST:		.SPACE 2
U1RX_PACK_PTR0:		.SPACE 2
U1RX_PACK_PTR1:		.SPACE 2
.EQU U1RX_PACK_BUFLEN_K	,16	
U1RX_PACK_BUF:		.SPACE U1RX_PACK_BUFLEN_K*4

		

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
;;====================================
RX_SERIAL_ID:		.SPACE 2
RX_ADDR:		.SPACE 2
RXBYTE_ADR:
RX_FLAG:		.SPACE 2
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
UTX_CHKSUM0:		.SPACE 2	
UTX_CHKSUM1:		.SPACE 2	
UTX_BTX:		.SPACE 2	
UTX_BUFFER_LEN:		.SPACE 2	



;;====================================
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;;========================================
SLOTINF_ADR:		.SPACE 8*16	
noSlotTimeAdr:		.SPACE 2*16	


LCDX:			.SPACE 2
LCDY:			.SPACE 2
LCDPG_CNT:		.SPACE 2
SCLCD_CNT:		.SPACE 2
LCDCUR_CNT:		.SPACE 2
LCDBUF:			.SPACE 160	


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

END_REG:		.SPACE 2




.EQU STACK_BUF		,0x1F00	
.EQU U1RX_BUFSIZE_K	,512	;
.EQU U1RX_MAXLEN_K	,40	;
.EQU U1RX_BUFFER	,0x2000	;
.EQU U1RX_BUFEND_K	,U1RX_BUFFER+U1RX_BUFSIZE_K



.EQU U1RX_BUFB		,0x2200	;
.EQU U2RX_BUFSIZE	,640	;
.EQU U2RX_BUFA		,0x2500	;
.EQU U2RX_BUFB		,0x2780	;
.EQU U1TX_BUF		,0x2A00	;
.EQU U2TX_BUF		,0x2B00	;
.EQU FLASH_BUF		,0x2A00 ; 
.EQU FLASH_TMP		,0x2C00	;512			
.EQU F24SET_BUF		,0x2C00	;64		

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
.EQU LCD_LINE_F		,FLAGA
.EQU LCD_LINE_F_P	,1
.EQU DISPLAY_F		,FLAGA
.EQU DISPLAY_F_P	,2
;.EQU FLASH_AB_F	,FLAGA
;.EQU FLASH_AB_F_P	,3
;.EQU FLASH_QPI_F	,FLAGA
;.EQU FLASH_QPI_F_P	,4
;.EQU FLASH_QPI2_F	,FLAGA	
;.EQU FLASH_QPI2_F_P	,5
;EQU IICTX_IEN_F	,FLAGA
;EQU IICTX_IEN_F_P	,6
;EQU SLAVE_F		,FLAGA
;EQU SLAVE_F_P		,7
;EQU IICMRST_F		,FLAGA
;EQU IICMRST_F_P	,8
;EQU PREUTX_F		,FLAGA
;EQU PREUTX_F_P		,9
.EQU ERR_F		,FLAGA
.EQU ERR_F_P		,10
.EQU OK_F		,FLAGA
.EQU OK_F_P		,11
;EQU AICIO_AB_F		,FLAGA
;EQU AICIO_AB_F_P  	,12
.EQU U1RX_START_F	,FLAGA
.EQU U1RX_START_F_P 	,13
.EQU U2RX_START_F	,FLAGA
.EQU U2RX_START_F_P 	,14
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
;EQU SYNCP_F		,FLAGB
;EQU SYNCP_F_P		,4
;EQU SYNCN_F		,FLAGB
;EQU SYNCN_F_P		,5
;EQU CHK_SYNC_F		,FLAGB
;EQU CHK_SYNC_F_P	,6
;EQU SLAVE_U2RX_F	,FLAGB
;EQU SLAVE_U2RX_F_P	,7
;EQU SLAVE_U2TX_F	,FLAGB
;EQU SLAVE_U2TX_F_P	,8
;EQU TEST_F		,FLAGB
;EQU TEST_F_P		,9
;EQU LOAD_U1TXPARA_F	,FLAGB
;EQU LOAD_U1TXPARA_F_P	,10
;EQU LOAD_U2TXPARA_F	,FLAGB
;EQU LOAD_U2TXPARA_F_P	,11
;EQU AIC_BEEP_F		,FLAGB
;EQU AIC_BEEP_F_P	,12
;EQU RESTART_F		,FLAGB
;EQU RESTART_F_P	,13
;EQU VOLP_F		,FLAGB
;EQU VOLP_F_P		,14
;EQU HEAD_LINE_F	,FLAGB
;EQU HEAD_LINE_F_P	,15



;FLAGC
;EQU BEEPL_F		,FLAGC
;EQU BEEPL_F_P		,0
;EQU CODTXA_LDED_F	,FLAGC
;EQU CODTXA_LDED_F_P	,1
;EQU CODTXB_LDED_F	,FLAGC
;EQU CODTXB_LDED_F_P	,2
;EQU RXU1CMD_F		,FLAGC
;EQU RXU1CMD_F_P	,3
;EQU RXU2CMD_F		,FLAGC
;EQU RXU2CMD_F_P	,4
;EQU RXIICCMD_F		,FLAGC
;EQU RXIICCMD_F_P	,5
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
POWER_ON:			;;
        MOV #STACK_BUF,W15  	;;Initialize the Stack Pointer Limit Register
        MOV #STACK_BUF+254,W0  	;;Initialize the Stack Pointer Limit Register
        MOV W0,SPLIM		;;
        CALL CLR_WREG 		;;
	CALL CLR_ALLREG		;;
	CALL INIT_IO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #2,W1		;;
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
	CALL INIT_TIMER3	;;
	CALL INIT_UART1		;;
	CALL INIT_BUZZER	;;	
	;CALL TEST_PWM		;;
	;CALL TEST_UART		;;
	;CALL INIT_UART2	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CALL TEST_TIMER	;;
	;CALL TEST_UART		;;
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BEEP_ON:			;;
	MOV #0x0006,W0		;;
	IOR OC1CON1		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BEEP_OFF:			;;
	MOV #0xFFF0,W0		;;
	AND OC1CON1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF BUZ_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

beepPrg:
	cp0 beepTime
	bra nz,$+8
	call BEEP_OFF
	return
	dec beepTime
	return


beep:
	MOV #8,W0		
	MOV w0,beepTime
	call BEEP_ON
	return
		


INIT_BUZZER:
	MOV #0x0400,W0		;;t3
	MOV W0,OC1CON1
	MOV #0x000D,W0
	MOV W0,OC1CON2
	MOV #2000,W0
	MOV W0,OC1R
	MOV #9000,W0
	MOV W0,PR3
	RETURN
	
TEST_PWM:
	MOV #0x0406,W0		;;t3
	MOV W0,OC1CON1
	MOV #0x000D,W0
	MOV W0,OC1CON2
	MOV #2000,W0
	MOV W0,OC1R
	MOV #9000,W0
	MOV W0,PR3
TEST_PWM_1:
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_PWM_1	








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

TEST_TIMER:
	CLRWDT
	BTSS TMR2,#8
	BCF TP1_O
	BTSC TMR2,#8
	BSF TP1_O
	BRA TEST_TIMER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART:				;;
	MOV #0xAB,W0	;;
	MOV W0,U1TXREG			;;
	;CALL U1TX_RSP			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	CLR ANSELC			;;
	CLR ANSELE			;;
	RETURN				;;
;	BSET ANSELE,#12			;;
;	BSET ANSELE,#13			;;
;	BSET ANSELE,#15			;;
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
TEST_UART1_I:				;;
	BCF U1U2_F			;;
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
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_GET_SLOTINF:			;;
	inc u1txTime			;;16ms
	mov #8,w0			;;
	cp u1txTime			;;
	bra geu,$+4			;;	
	return				;;
	clr u1txTime			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BCF U1U2_F			;;
	MOV #0x1000,W0			;;
	MOV W0,UTX_CMD			;;
	MOV #0x0100,W0			;;UNIT 4US DELAY TX BY OLOT ID MUL
	MOV W0,UTX_PARA0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV CMDINX,W0			;;
	MOV W0,UTX_PARA1		;;
	CLR CMDINX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0			;;
	MOV W0,UTX_PARA2		;;
	MOV #0x0000,W0			;;
	MOV W0,UTX_PARA3		;;
	MOVLF #128,UTX_BUFFER_LEN	;;
	MOV #SLOTINF_ADR,W3 		;;
	CALL UTX_BUFFER			;;
	call chkNoSlotIn		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

chkNoSlotIn:
	clr R0
chkNoSlotIn_1:
	mov R0,w0
	call incSlotTime
	inc R0
	mov #16,w0
	cp R0
	bra ltu,chkNoSlotIn_1
	return
incSlotTime:
	mov w0,w2
	mov #noSlotTimeAdr,w1
	sl w0,#1,w0
	add w0,w1,w1
	inc [w1],[w1]
	mov [w1],w0
	cp w0,#4
	bra geu,$+4
	return
	clr [w1]
	mov #SLOTINF_ADR,w1
	mov w2,w0
	sl w0,#3,w0
	clr [w1++]
	clr [w1++]
	clr [w1++]
	clr [w1++]
	return	
clrSlotTime:
	mov #noSlotTimeAdr,w1
	sl w0,#1,w0
	add w0,w1,w1
	clr [w1]
	return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	BSF U1RX_EN_F			;;
	;BSF U2RX_EN_F			;;
	CALL CLR_LCDBUF			;;
	CALL INIT_LCD			;;
	LOXY 0,0			;;
	LOFFS1 SYSTEM_INIT_STR		;;
	CALL ENSTR			;;
	CALL CLR_LCDBUF			;;
	MOVLF #0,DISPLAY_MOD		;;
	;CALL TEST_LCD
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_1:					;;
	CALL DISPLAY_PRG		;;
	BCF DISPLAY_F			;;
MAIN_LOOP:				;;
	CALL TMR2PRG			;;	
	CLRWDT				;;
	BTFSC T128M_F			;;	
	TG LED1_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTSC shiftFlag,#0		;;16ms
	CALL CONVERT_AD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC shiftFlag,#1		;;
	CALL DISPLAY_SCAN		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC shiftFlag,#2		;;
	CALL beepPrg			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS shiftFlag,#3		;;
	bra $+10
	CALL KEYBO			;;
	CALL MAIN_KEYPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC shiftFlag,#4		;;
	CALL UTX_GET_SLOTINF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SCAN_LCD
	CALL CHK_U1TX_END		;;
	CALL CHK_U1RX			;;
	BTFSC DISPLAY_F			;;
	BRA MAIN_1
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	
DISPLAY_PRG:
	MOV DISPLAY_MOD,W0
	CP W0,#17
	BRA LTU,$+4
	RETURN
	BRA W0
	BRA DISPM0J
	BRA DISPM1J
	BRA DISPM2J
	BRA DISPM3J
	BRA DISPM4J
	BRA DISPM5J
	BRA DISPM6J
	BRA DISPM7J
	BRA DISPM8J
	BRA DISPM9J
	BRA DISPM10J
	BRA DISPM11J
	BRA DISPM12J
	BRA DISPM13J
	BRA DISPM14J
	BRA DISPM15J
	BRA DISPM16J
DISPM1J:
DISPM2J:
DISPM3J:
DISPM4J:
DISPM5J:
DISPM6J:
DISPM7J:
DISPM8J:
DISPM9J:
DISPM10J:
DISPM11J:
DISPM12J:
DISPM13J:
DISPM14J:
DISPM15J:
DISPM16J:
	CALL CLR_LCDBUF			;;
	LOXY 0,0			;;
	MOV DISPLAY_MOD,W0
	call dispDcb2
	MOV #'.',W0
	CALL ENCHR
	LOFFS1 SLOT_STR			;;
	CALL ENSTR
	call dark1
	MOV DISPLAY_MOD,W0
	call dispDcb2
	call dark1
	LOFFS1 STATUS_STR		;;
	CALL ENSTR
	return


SLOT_STR:
	.ascii "SLOT\0"
STATUS_STR:
	.ascii "STATUS>\0"


statusStr:
	.ascii "STATUS:\0"
ipStr:
	.ascii "IP:\0"

	
TYPE_STR:
	.ASCII "TYPE:\0"
SLOT_STATUS_STR:
	.ASCII "SLOT STATUS>\0"

	RETURN
SLOT_POSITION_STR:
	.ASCII "0.SLOTS INFO>  NO  : 123456789ABCDEFG\0"
SLOT_TYPE_STR:
	.ASCII "               TYPE: \0"
DISPM0J:
	CALL CLR_LCDBUF			;;
	LOXY 0,0			;;
	LOFFS1 SLOT_POSITION_STR	;;
	CALL ENSTR
	LOXY 0,1			;;
	LOFFS1 SLOT_TYPE_STR		;;
	CALL ENSTR
	RETURN
	
DISPLAY_SCAN:
	cp0 dispDelayTime
	bra z,displayScan_1
	dec dispDelayTime
	cp0 dispDelayTime
	bra nz,$+4
	bsf DISPLAY_F
	return
displayScan_1:
	MOV DISPLAY_MOD,W0
	CP W0,#17
	BRA LTU,$+4
	RETURN
	BRA W0
	BRA DISPS0J
	BRA DISPS1J
	BRA DISPS2J
	BRA DISPS3J
	BRA DISPS4J
	BRA DISPS5J
	BRA DISPS6J
	BRA DISPS7J
	BRA DISPS8J
	BRA DISPS9J
	BRA DISPS10J
	BRA DISPS11J
	BRA DISPS12J
	BRA DISPS13J
	BRA DISPS14J
	BRA DISPS15J
	BRA DISPS16J














DISPS0J:
	CLR R0
	LOXY 21,1	
DISPS0J_1:			;;
	MOV #SLOTINF_ADR,W1
	MOV R0,W0
	SL W0,#3,W0
	ADD W0,W1,W1
	MOV [W1],W0
	MOV W0,DEBUG_B0
	SWAP W0
	AND #255,W0
	LSR W0,#4,W0
	CP0 W0
	BRA NZ,DISPS0J_2
	MOV #'x',W0
	CALL ENCHR
	BRA DISPS0J_3	
DISPS0J_2:			;;
	CALL ENNUM
DISPS0J_3:			;;
	INC R0
	MOV #16,W0
	CP R0
	BRA LTU,DISPS0J_1
	RETURN		


DISPS1J:
DISPS2J:
DISPS3J:
DISPS4J:
DISPS5J:
DISPS6J:
DISPS7J:
DISPS8J:
DISPS9J:
DISPS10J:
DISPS11J:
DISPS12J:
DISPS13J:
DISPS14J:
DISPS15J:
DISPS16J:
	MOV #SLOTINF_ADR,W1
	MOV DISPLAY_MOD,W0
	DEC W0,W0
	SL W0,#3,W0
	ADD W0,W1,W1
	MOV [W1++],W0
	MOV W0,R0
	MOV [W1++],W0
	MOV W0,R1
	MOV [W1++],W0
	MOV W0,R2
	MOV [W1++],W0
	MOV W0,R3
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOXY 22,0			;;
	LOFFS1 TYPE_STR			;;
	CALL ENSTR
	MOV R0,W0
	SWAP W0
	AND #255,W0
	LSR W0,#4,W0
	mov w0,R4
	CALL ENNUM
	mov R4,w0
	CALL dispSlotType
	cp0 R4
	bra nz,$+8
	call darkEnd
	bra dispLine2
	;;;;;;;;;;;;;;;;;;;;;
	call dark1
	LOFFS1 noStr			;;
	call ENSTR
	mov R0,w0
	swap w0
	and #3,w0
	inc w0,w0
	call ENNUM
	call darkEnd
dispLine2:
	;==================================
	cp0 R4
	bra z,darkLine2
	mov #9,w0
	cp R4
	bra geu,darkLine2
	LOXY 2,1			;;
	mov #10,w0
	cp DISPLAY_MOD
	bra ltu,$+4
	inc LCDX

	mov R0,w0
	and #15,w0
	call dispSlotStatus
	mov #22,w0
	call darkTo 
	LOFFS1 ipStr		;;
	CALL ENSTR
	call dispIp
	call darkEnd
	return
darkLine2:
	LOXY 0,1			;;
	mov #40,w0
	call lcdDarkX
	return
	
dark1:
	mov ' ',w0
	call ENCHR
	return

lcdDarkX:
	push R0
	mov w0,R0
lcdDarkX_1:
	mov ' ',w0
	call ENCHR
	dec R0
	bra nz,lcdDarkX_1
	pop R0
	return
darkEnd:
	mov #40,w0
	cp LCDX
	bra ltu,$+4
	return
	mov #' ',w0
	call ENCHR
	bra darkEnd

darkTo:
	push R0
	mov w0,R0
darkTo_1:
	mov R0,w0
	cp LCDX
	bra geu,darkTo_2
	mov #' ',w0
	call ENCHR
	bra darkTo_1
darkTo_2:
	pop R0
	return



dispIp:
	MOVFF R2,R6
	MOVFF R3,R7
	
	mov R6,w0
	and #255,w0
	call dispDcb3
	mov #'.',w0
	call ENCHR
	mov R6,w0
	SWAP W0
	and #255,w0
	call dispDcb3
	mov #'.',w0
	call ENCHR
	mov R7,w0
	and #255,w0
	call dispDcb3
	mov #'.',w0
	call ENCHR
	mov R7,w0
	SWAP W0		
	and #255,w0
	call dispDcb3
	return

dispDcb2:
	call L1D_2B
	bra dispDcb_1
dispDcb3:
	call L1D_3B
	cp0 R2
	bra z,dispDcb_1
	mov R2,w0
	call ENNUM
	mov R1,w0
	call ENNUM
	mov R0,w0
	call ENNUM
	return
dispDcb_1:
	cp0 R1
	bra z,dispDcb_2
	mov R1,w0
	call ENNUM
dispDcb_2:
	mov R0,w0
	call ENNUM
	return


dispSlotStatus:
	cp w0,#9
	bra ltu,$+4
	return
	BRA W0
	bra dslotStatusJ0
	bra dslotStatusJ1
	bra dslotStatusJ2
	bra dslotStatusJ3
	bra dslotStatusJ4
	bra dslotStatusJ5
noneStr:
	.ascii "NONE\0"
osLoadStr:
	.ascii "OS LOADING\0"
appLoadStr:
	.ascii "APP LOADING\0"
dataLoadStr:
	.ascii "DATA LOADING\0"
readyStr:
	.ascii "SYS READY\0"
errorStr:
	.ascii "SYS ERROR\0"
noStr:
	.ascii "NO:\0"


dslotStatusJ0:
	LOFFS1 noneStr
	CALL ENSTR
	return
dslotStatusJ1:
	LOFFS1 osLoadStr
	CALL ENSTR
	return
dslotStatusJ2:
	LOFFS1 appLoadStr
	CALL ENSTR
	return
dslotStatusJ3:
	LOFFS1 dataLoadStr
	CALL ENSTR
	return
dslotStatusJ4:
	LOFFS1 readyStr
	CALL ENSTR
	return
dslotStatusJ5:
	LOFFS1 errorStr
	CALL ENSTR
	return
	



dispSlotType:
	CP W0,#9
	BRA LTU,$+4
	bra dispXxx
	BRA W0
	BRA DSLOT_TYPE_J0
	BRA DSLOT_TYPE_J1
	BRA DSLOT_TYPE_J2
	BRA DSLOT_TYPE_J3
	BRA DSLOT_TYPE_J4
	BRA DSLOT_TYPE_J5
	BRA DSLOT_TYPE_J6
	BRA DSLOT_TYPE_J7
	BRA DSLOT_TYPE_J8

NONE_TYPE_STR:
	.ASCII "(NONE)\0"
CTR_TYPE_STR:
	.ASCII "(CTR)\0"
SIP_TYPE_STR:
	.ASCII "(SIP)\0"
FXO_TYPE_STR:
	.ASCII "(FXO)\0"
FXS_TYPE_STR:
	.ASCII "(FXS)\0"
T1S_TYPE_STR:
	.ASCII "(T1)\0"
MAG_TYPE_STR:
	.ASCII "(MAG)\0"
ROIP_TYPE_STR:
	.ASCII "(ROIP)\0"
REC_TYPE_STR:
	.ASCII "(REC)\0"
xxx_TYPE_STR:
	.ASCII "(XXX)\0"

dispXxx:
	LOFFS1 xxx_TYPE_STR		;;
	CALL ENSTR
	RETURN
	
	
DSLOT_TYPE_J0:
	LOFFS1 NONE_TYPE_STR		;;
	CALL ENSTR
	RETURN
DSLOT_TYPE_J1:
	LOFFS1 CTR_TYPE_STR		;;
	CALL ENSTR
	RETURN
DSLOT_TYPE_J2:
	LOFFS1 SIP_TYPE_STR		;;
	CALL ENSTR
	RETURN
DSLOT_TYPE_J3:
	LOFFS1 FXO_TYPE_STR		;;
	CALL ENSTR
	RETURN
DSLOT_TYPE_J4:
	LOFFS1 FXS_TYPE_STR		;;
	CALL ENSTR
	RETURN
DSLOT_TYPE_J5:
	LOFFS1 T1S_TYPE_STR		;;
	CALL ENSTR
	RETURN
DSLOT_TYPE_J6:
	LOFFS1 MAG_TYPE_STR		;;
	CALL ENSTR
	RETURN
DSLOT_TYPE_J7:
	LOFFS1 ROIP_TYPE_STR		;;
	CALL ENSTR
	RETURN
DSLOT_TYPE_J8:
	LOFFS1 REC_TYPE_STR		;;
	CALL ENSTR
	RETURN



MAIN_KEYPRG:
	CP0 R0
	BRA Z,$+6
	CALL MAIN_KPUSH
	CP0 R1
	BRA Z,$+6
	CALL MAIN_KFREE
	CP0 R2
	BRA Z,$+6
	CALL MAIN_KCON1
	CP0 R3
	BRA Z,$+6
	CALL MAIN_KCON2
	RETURN

MAIN_KPUSH:
	BTSC R0,#0
	BRA SW1P_PRG
	BTSC R0,#1
	BRA SW2P_PRG
	BTSC R0,#2
	BRA SW3P_PRG
	BTSC R0,#3
	BRA SW4P_PRG
	RETURN
SW2P_PRG:
	INC DISPLAY_MOD
	MOV #17,W0
	CP DISPLAY_MOD
	BRA LTU,$+4
	CLR DISPLAY_MOD	
	BSF DISPLAY_F
	call beep
	RETURN
SW4P_PRG:
	DEC DISPLAY_MOD
	MOV #16,W0
	CP DISPLAY_MOD
	BRA LEU,$+4
	MOV W0,DISPLAY_MOD	
	BSF DISPLAY_F
	call beep
	RETURN


SW1P_PRG:
	RETURN
SW3P_PRG:
	RETURN





MAIN_KFREE:
	RETURN
MAIN_KCON1:
	RETURN
MAIN_KCON2:			
	BTSC R3,#0
	BRA SW1CC_PRG
	BTSC R3,#2
	BRA SW3CC_PRG
	RETURN

;;POWER OFF
SW1CC_PRG:
	CP0 DISPLAY_MOD
	BRA Z,SW1CC_1
	MOVLF #0x1000,CMDINX
	MOV DISPLAY_MOD,W0
	DEC W0,W0
	IOR CMDINX
	call dispPowerOffSlot
	mov #100,w0
	call dispDelay
	call beep
	RETURN
SW1CC_1:
	MOVLF #0x10FF,CMDINX
	call dispPowerOffAll
	mov #100,w0
	call dispDelay
	call beep
	RETURN

;;reset
SW3CC_PRG:
	CP0 DISPLAY_MOD
	BRA Z,SW3CC_1
	MOVLF #0x1100,CMDINX
	MOV DISPLAY_MOD,W0
	DEC W0,W0
	IOR CMDINX
	call dispResetSlot
	mov #100,w0
	call dispDelay
	call beep
	RETURN
SW3CC_1:
	MOVLF #0x11FF,CMDINX
	call dispResetAll
	mov #100,w0
	call dispDelay
	call beep
	RETURN


dispDelay:
	mov w0,dispDelayTime	
	return


powerOffAllStr:
	.ascii "ACTION: POWER OFF ALL\0"
powerOffSlotStr:
	.ascii "ACTION: POWER OFF SLOT \0"

dispPowerOffAll:
	call CLR_LCDBUF
	LOXY 0,0	
	LOFFS1 powerOffAllStr		;;
	CALL ENSTR
	return
dispPowerOffSlot:
	call CLR_LCDBUF
	LOXY 0,0	
	LOFFS1 powerOffSlotStr		;;
	CALL ENSTR
	MOV DISPLAY_MOD,W0
	call ENNUM
	return
			

resetAllStr:
	.ascii "ACTION: RESET ALL\0"
resetSlotStr:
	.ascii "ACTION: RESET SLOT \0"

dispResetAll:
	call CLR_LCDBUF
	LOXY 0,0	
	LOFFS1 resetAllStr		;;
	CALL ENSTR
	return
dispResetSlot:
	call CLR_LCDBUF
	LOXY 0,0	
	LOFFS1 resetSlotStr		;;
	CALL ENSTR
	MOV DISPLAY_MOD,W0
	call ENNUM
	return



	



CHK_U1TX_END:
	BTFSS RS485_CTL_O
	RETURN
	BTFSS U1TX_END_F
	RETURN
	BTSS U1STA,#8
	RETURN
	BCF U1TX_END_F
	BCF RS485_CTL_O
	RETURN


SYSTEM_INIT_STR:
	.ASCII "System Init .....\0"



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GOTOXY:					;;
	MOV #LCDBUF,W8			;;
	MOV LCDX,W0			;;
	BTSC LCDY,#0			;;
	ADD #40,W0			;;
	ADD W0,W8,W8			;;
	ADD W0,W8,W8			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NUM_TRANS:				;;
	CP W0,#16			;;
	BRA NZ,$+6			;;
	MOV #' ',W0			;;
	RETURN				;;
	CP W0,#17			;;
	BRA NZ,$+6			;;
	MOV #'1',W0			;;
	RETURN				;;
	CP W0,#18			;;
	BRA NZ,$+6			;;
	MOV #0,W0			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ADD.B #246,W0       ;-10	;;	
        BTSC SR,#C			;;
	ADD.B #7,W0			;;
	ADD.B #0x3A,W0			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENNUM:					;;
	AND #31,W0			;;
	CALL NUM_TRANS			;;
ENCHR:					;;
	MOV W0,[W8++]			;;
	INC LCDX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
ENSTR:					;;
ENSTR_0:				;;
	MOV #40,W0			;;
	CP LCDX				;;	
	BRA GEU,ENSTR_END		;;	
        TBLRDL [W1],W0		        ;;
	BTSC W1,#0			;;
	SWAP W0				;; 
	AND #255,W0			;;
	BRA Z,ENSTR_END			;;
	MOV W0,[W8++]			;;
	INC W1,W1			;;
	INC LCDX			;;
	BRA ENSTR_0			;;
ENSTR_END:				;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENRAM:					;;
ENRAM_0:				;;
	MOV #40,W0			;;
	CP LCDX				;;	
	BRA GEU,ENRAM_END		;;	
        MOV [W1++],W0		        ;;
	AND #255,W0			;;
	BRA Z,ENSTR_END			;;
	MOV W0,[W8++]			;;
	INC LCDX			;;
	BRA ENRAM_0			;;
ENRAM_END:				;;
	RETURN				;;			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STR2RAM:				;;
        TBLRDL [W1],W0		        ;;
	BTSC W1,#0			;;
	SWAP W0				;; 
	AND #255,W0			;;
	BRA Z,STR2RAM_END		;;
	MOV W0,[W2++]			;;
	INC W1,W1			;;
	BRA STR2RAM			;;
STR2RAM_END:				;;
	MOV W0,[W2++]			;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
D2D_2D:				;;
	CLR R0			;;
D2D_2D_1:			;;
	SUB W0,W2,W4		;;
	SUBB W1,W3,W5		;;
	BRA LTU,D2D_2D_2	;;
	MOV W5,W1		;;
	MOV W4,W0		;;
	INC R0 			;;
	BRA D2D_2D_1		;;
D2D_2D_2:			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
L2D_5B:				;;
	CLR R4			;;
L2D_5B_1:			;;
	MOV #10000,W2		;;
	SUB W0,W2,W4		;;
	MOV #0,W2		;;
	SUBB W1,W2,W5		;;
	BRA LTU,L1D_4B		;;
	MOV W5,W1		;;
	MOV W4,W0		;;
	INC R4 			;;
	BRA L2D_5B_1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
L1D_5B:				;;
	MOV #10000,W2		;;
	REPEAT #17		;;
	DIV.UW W0,W2		;;
	MOV W0,R4		;;
	MOV W1,W0		;;
L1D_4B:				;;
	MOV #1000,W2		;;
	REPEAT #17		;;
	DIV.UW W0,W2		;;
	MOV W0,R3		;;
	MOV W1,W0		;;
L1D_3B:				;;
	MOV #100,W2		;;
	REPEAT #17		;;
	DIV.UW W0,W2		;;
	MOV W0,R2		;;
	MOV W1,W0		;;
L1D_2B:				;;
	MOV #10,W2		;;
	REPEAT #17		;;
	DIV.UW W0,W2		;;
	MOV W0,R1		;;
	MOV W1,R0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_LCD:				;;
	CALL INIT_LCD			;;
TEST_LCD_1:				;;
	MOV #0,W0			;;
	CALL SETDG			;;
	MOV #'A',W0			;;
	CALL WRITE_DR			;;
	CALL LCDDLY			;;
	MOV #'B',W0			;;
	CALL WRITE_DR			;;
	CALL LCDDLY			;;
	MOV #'C',W0			;;
	CALL WRITE_DR			;;
	CALL LCDDLY			;;
	MOV #'D',W0			;;
	CALL WRITE_DR			;;
	MOV #1000,W0			;;
	CALL DLYMX			;;
	MOV #0,W0			;;
	CALL SETDG			;;
	MOV #'1',W0			;;
	CALL WRITE_DR			;;
	CALL LCDDLY			;;
	MOV #'2',W0			;;
	CALL WRITE_DR			;;
	CALL LCDDLY			;;
	MOV #'3',W0			;;
	CALL WRITE_DR			;;
	CALL LCDDLY			;;
	MOV #'4',W0			;;
	CALL WRITE_DR			;;
	MOV #1000,W0			;;
	CALL DLYMX			;;
	BRA TEST_LCD_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_LCD:                       ;;                                
	BSF LCD_BKL_O		;;
	BCF LCD_RW_O		;;
       	MOV #0x30,W0       	;;BU4 4BIT TWO LINE 5X7 DOT       
       	CALL WRITE_IR           ;;                               
       	MOV #2,W0               ;;                               
       	CALL DLYMX              ;;                                
	MOV #0x30,W0       	;;
       	CALL WRITE_IR           ;;                                
       	MOV #2,W0               ;;                               
       	CALL DLYMX              ;;                                
	MOV #0x30,W0       	;;
       	CALL WRITE_IR           ;;                                 
       	MOV #2,W0              ;;                               
       	CALL DLYMX              ;;                                 
       	MOV #0x38,W0       	;;BU4 4BIT TWO LINE 5X7 DOT       
	CALL WRITE_IR           ;;                                 
       	MOV #2,W0              ;;                               
       	CALL DLYMX              ;;                                 
       	MOV #0x01,W0       	;;                               
       	CALL WRITE_IR           ;;                                 
       	MOV #2,W0              ;;                               
       	CALL DLYMX              ;;                                 
       	MOV #0x0C,W0       	;;DISPLAY ON CURSOR ON            
       	CALL WRITE_IR           ;;                                 
       	MOV #2,W0              ;;                               
       	CALL DLYMX              ;;                                 
       	MOV #0x06,W0       	;;                               
       	CALL WRITE_IR           ;;                                 
       	MOV #2,W0              ;;                               
       	CALL DLYMX              ;;                                 
       	RETURN                  ;;                                    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETCG:                        	;;
	BCLR W0,#7		;;
	BSET W0,#6		;;
	BRA WRITE_IR		;;
SETDG:                        	;;
	BSET W0,#7		;;
	BRA WRITE_IR		;;
CURSOR_ON:                     	;;
	MOV #0x0E,W0		;;
	BRA WRITE_IR		;;		
CURSOR_OFF:                    	;;
	MOV #0x0C,W0		;;
	BRA WRITE_IR		;;		
LCD_OFF:                       	;;
	MOV #0x08,W0		;;
	BRA WRITE_IR		;;		
WRITE_IR:                      	;;
       	BCF LCD_EN_O        	;;
       	BCF LCD_RS_O         	;;		
      	BRA WRITE_LCD          	;;
WRITE_DR:                      	;;
        BCF LCD_EN_O         	;;
       	BSF LCD_RS_O	        ;;
WRITE_LCD:                     	;;
	XOR LATC,WREG		;;
	AND #255,W0		;;
	XOR LATC		;;
	CALL LCDDLY		;;
	BSF LCD_EN_O	        ;;
	CALL LCDDLY		;;
       	BCF LCD_EN_O 	        ;;
	CALL LCDWAIT		;;
       	RETURN           	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WDLCDNW:			;;
       	BCF LCD_RW_O	        ;;
        BCF LCD_EN_O         	;;
       	BSF LCD_RS_O	        ;;
	XOR LATC,WREG		;;
	AND #255,W0		;;
	XOR LATC		;;
	CALL LCDDLY		;;
	BSF LCD_EN_O	        ;;
	CALL LCDDLY		;;
       	BCF LCD_EN_O 	        ;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WCLCDNW:			;;
       	BCF LCD_RW_O	        ;;
        BCF LCD_EN_O         	;;
       	BCF LCD_RS_O	        ;;
	XOR LATC,WREG		;;
	AND #255,W0		;;
	XOR LATC		;;
	CALL LCDDLY		;;
	BSF LCD_EN_O	        ;;
	CALL LCDDLY		;;
       	BCF LCD_EN_O 	        ;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_LCD_STATUS:		;;
	PUSH W1			;;
	MOV #0xFF,W0		;;
	IOR TRISC		;;
       	BSF LCD_RW_O	        ;;
        BCF LCD_EN_O         	;;
       	BCF LCD_RS_O	        ;;
	CALL LCDDLY		;;
	BSF LCD_EN_O         	;;	
	CALL LCDDLY		;;
	MOV PORTC,W1		;;
	BCF LCD_EN_O	        ;;
	CALL LCDDLY		;;
	MOV #0xFF,W0		;;
	SWAP W0			;;
	AND TRISC		;;
	MOV W1,W0		;;
	POP W1			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SCAN_LCD:				;;
	CALL READ_LCD_STATUS		;;
	BTSC W0,#7			;;
	RETURN				;;
	CP0 SCLCD_CNT			;;
	BRA NZ,SCAN_LCD_1		;;		
	MOV #0x80,W0			;;
	CALL WCLCDNW			;;
	INC SCLCD_CNT			;;
	RETURN				;;
SCAN_LCD_1:				;;
	MOV #LCDBUF,W1			;;
	BTSC TMR2H_BUF,#1		;;
	BRA SCAN_LCD_2			;;
	MOV SCLCD_CNT,W0		;;
	CP LCDCUR_CNT			;;
	BRA NZ,SCAN_LCD_2		;;
	MOV #0,W0			;;
	BRA SCAN_LCD_3			;;
SCAN_LCD_2:				;;
	MOV SCLCD_CNT,W0		;;
	DEC W0,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;	
SCAN_LCD_3:				;;
	CALL WDLCDNW			;;
	INC SCLCD_CNT			;;
	MOV #81,W0			;;
	CP SCLCD_CNT			;;	
	BRA GEU,$+4			;;
	RETURN				;;
	CLR SCLCD_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
INIT_LCDBUF:				;;
	MOV #LCDBUF,W1			;;
	CLR W2				;;
INIT_LCDBUF_1:				;;
	MOV #' ',W0			;;
	MOV W0,[W1++]			;;
	INC W2,W2			;;
	MOV #80,W0			;;
	CP W2,W0			;;
	BRA LTU,INIT_LCDBUF_1		;;
	CLR SCLCD_CNT			;;
	BCF LCD_LINE_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;
	CALL SETCG			;;
	CLR R0				;;
INIT_LCDBUF_2:				;;
	MOV #255,W0			;;
	CALL WRITE_DR			;;
	INC R0				;;
	MOV #8,W0			;;
	CP R0				;;
	BRA LTU,INIT_LCDBUF_2		;;
INIT_LCDBUF_3:				;;
	MOV #0x1C,W0			;;
	CALL WRITE_DR			;;
	MOV #0x14,W0			;;
	CALL WRITE_DR			;;
	MOV #0x1C,W0			;;
	CALL WRITE_DR			;;
	MOV #0x00,W0			;;
	CALL WRITE_DR			;;
	MOV #0x00,W0			;;
	CALL WRITE_DR			;;
	MOV #0x00,W0			;;
	CALL WRITE_DR			;;
	MOV #0x00,W0			;;
	CALL WRITE_DR			;;
	MOV #0x00,W0			;;
	CALL WRITE_DR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;
	CALL SETDG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_LCDBUF:				;;
	MOV #LCDBUF,W1			;;
	MOV #' ',W0			;; 	
	MOV #79,W2			;;
	REPEAT W2			;;
	MOV W0,[W1++]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDDLY:				;;
	PUSH W0			;;
	MOV #3,W0		;;
LCDDLY_1:			;;
	DEC W0,W0		;;
	BRA NZ,LCDDLY_1		;;
	POP W0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDWAIT:			;;
	PUSH W0			;;
	MOV #700,W0		;;
LCDWAIT_1:			;;
	DEC W0,W0		;;
	BRA NZ,LCDWAIT_1	;;
	POP W0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
	



GET_KEYCODE:
	CLR KEYCODE
	BTFSS KEY1_I
	BSET KEYCODE,#0
	BTFSS KEY2_I
	BSET KEYCODE,#1
	BTFSS KEY3_I
	BSET KEYCODE,#2
	BTFSS KEY4_I
	BSET KEYCODE,#3
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	CLR R0				;;KEY PUSH CODE
	CLR R1				;;KEY RELEASE CODEG
	CLR R2				;;KEY PUSH CONTINUE 1
	CLR R3				;;KEY PUSH CONTINUE 2
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
	MOV #100,W0			;;
	CP CONKEY_CNT 			;;
	BTSS SR,#Z			;;
	BRA CONKEY2			;;
	MOV KEYCODE,W0			;;
	MOV W0,R2			;;
	BSF DISKR_F			;;
	RETURN				;;
CONKEY2:				;;
	MOV #150,W0			;;
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
	clr shiftFlag
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
	inc shiftTime			;;
	mov #16,w0			;;
	cp shiftTime			;;		
	bra ltu,$+4			;;
	clr shiftTime			;;
	mov shiftTime,w0		;;
	call BIT_TRANS			;;	
	mov w0,shiftFlag		;;	
	return				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





		



	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER3:				;;
	MOV #0xA010,W0			;;0.13US
	MOV W0,T3CON			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER2:				;;
	MOV #0xA030,W0			;;/256
	MOV W0,T2CON			;;BASE TIME
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
	MOV #47,W0		;;RP47 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR8		;;
	MOV #0x0100,W0		;;RP118 U1TX
	IOR RPOR8		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR1		;;
	MOV #0x0010,W0		;;oc1
	IOR RPOR1		;;RP36



	
	
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
	MOV #35,W0	;115200		;;66MHZ
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
	MOV #65,W0	;256000		;;66MHZ
	MOV #47,W0	;345600		;;66MHZ
	MOV W0,U2BRG			;;
	;MOV #0x8008,W0			;;8BIT
	MOV #0x800E,W0			;;8BIT
	MOV W0,U2MODE			;;
	MOV #0x0400,W0			;;
	MOV W0,U2STA 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC7,#14 			;;
	BSET IPC7,#13 			;;
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
	BSET IPC7,#9 			;;
	BSET IPC7,#8 			;;
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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10000,W0			;;
	CALL DLYX			;;
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
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
	BCF NC1_O			;;
	BCF NC1_IO			;;
	;;PIN2 				;;
	BCF RS485_CTL_O			;;
	BCF RS485_CTL_IO		;;
	;;PIN3 				;;
	BSF RS485_TX_IO			;;
	;;PIN4 				;;
	BCF RS485_RX_O			;;
	BCF RS485_RX_IO			;;
	;;PIN5 				;;
	BCF GPIO1_O			;;
	BCF GPIO1_IO			;;
	;;PIN6 				;;
	BCF GPIO2_O			;;
	BCF GPIO2_IO			;;
	;;PIN8 				;;
	BCF NC8_O			;;
	BCF NC8_IO			;;
	;;PIN11 			;;
	BCF NC11_O			;;
	BCF NC11_IO			;;
	;;PIN12 			;;
	BCF NC12_O			;;
	BCF NC12_IO			;;
	;;PIN13 			;;
	BCF NC13_O			;;
	BCF NC13_IO			;;
	;;PIN14 			;;
	BCF NC14_O			;;
	BCF NC14_IO			;;
	;;PIN15 			;;
	BCF GPIO5_O			;;
	BCF GPIO5_IO			;;
	;;PIN16 			;;
	BCF GPIO6_O			;;
	BCF GPIO6_IO			;;
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
	BCF GPIO3_O			;;
	BCF GPIO3_IO			;;
	;;PIN30 			;;
	BCF GPIO4_O
	BCF GPIO4_IO			;;
	;;PIN31 			;;
	BCF LCD_BKL_O			;;
	BCF LCD_BKL_IO			;;
	;;PIN32 			;;
	BCF BUZ_O			;;
	BCF BUZ_IO			;;
	;;PIN33 			;;
	BCF TFT_TE_O			;;
	BCF TFT_TE_IO			;;
	;;PIN34 			;;
	BSF TFT_RESET_O			;;
	BCF TFT_RESET_IO		;;
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
	BCF TFT_EN_O			;;
	BCF TFT_EN_IO			;;
	;;PIN43 			;;
	BCF TFT_BKL_O			;;
	BCF TFT_BKL_IO			;;
	;;PIN44 			;;
	BCF TFT_CLK_O			;;
	BCF TFT_CLK_IO			;;
	;;PIN45 			;;
	BCF TFT_D4_O			;;
	BCF TFT_D4_IO			;;
	;;PIN46 			;;
	BCF TFT_D3_O			;;
	BCF TFT_D3_IO			;;
	;;PIN47				;;
	BCF TFT_D2_O			;;
	BCF TFT_D2_IO			;;
	;;PIN48 			;;
	BCF TFT_D1_O			;;
	BCF TFT_D1_IO			;;
	;;PIN49 			;;
	BCF LCD_RS_O			;;
	BCF LCD_RS_IO			;;
	;;PIN50 			;;
	BCF DB6_O			;;
	BCF DB6_IO			;;
	;;PIN51 			;;
	BCF DB7_O			;;
	BCF DB7_IO			;;
	;;PIN52 			;;
	BCF LCD_RW_O			;;
	BCF LCD_RW_IO			;;
	;;PIN53 			;;
	BCF NC53_O			;;
	BCF NC53_IO			;;
	;;PIN54 			;;
	BCF NC54_O			;;
	BCF NC54_IO			;;
	;;PIN55 			;;
	BCF LCD_EN_O			;;
	BCF LCD_EN_IO			;;
	;;PIN58 			;;
	BSF KEY1_IO			;;
	;;PIN59 			;;
	BSF KEY2_IO			;;
	;;PIN60 			;;
	BSF KEY3_IO			;;
	;;PIN61 			;;
	BSF KEY4_IO			;;
	;;PIN62 			;;
	BCF NC62_O			;;
	BCF NC62_IO			;;
	;;PIN63 			;;
	BSF LED1_O			;;
	BCF LED1_IO			;;
	;;PIN64 			;;
	BSF LED1_O			;;
	BCF LED1_IO			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;























	











	







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LDW1_W:				;;
	MOV #U1RX_BUFEND_K,W0	;;
	CP W1,W0		;;	
	BRA LTU,$+4		;;	
	MOV #U1RX_BUFFER,W1	;;		
	MOV [W1++],W0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	


















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX:				;;
	MOV U1RX_PACK_PTR1,W0		;;
	SL W0,#2,W0			;;
	MOV #U1RX_PACK_BUF,W1		;;	
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	MOV W0,RX_LEN			;;
	CP0 RX_LEN			;;
	BRA NZ,$+4			;;
	RETURN				;;
	CLR [W1++]			;;
	MOV [W1++],W0			;;BYTE_PTR_ST
	MOV W0,RXBYTE_ADR		;;
	INC U1RX_PACK_PTR1		;;
	MOV #U1RX_PACK_BUFLEN_K,W0	;;
	CP U1RX_PACK_PTR1		;;	
	BRA LTU,$+4			;;
	CLR U1RX_PACK_PTR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_BUFFER,W1		;;
	MOV RXBYTE_ADR,W0		;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL LDW1_W			;;
	MOV #SLOT_DEVICE_ID_K,W2	;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_2		;;
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_2		;;
	RETURN				;;
CHK_U1RX_2:				;;
	CALL LDW1_W			;;
	MOV W0,RX_SERIAL_ID		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL LDW1_W			;;
	MOV W0,RX_FLAG			;;
	SWAP W0				;;
	AND #255,W0			;;
	CP W0,#0xAB			;;
	BRA Z,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL LDW1_W			;;
	MOV W0,RX_LEN			;;
	CALL LDW1_W			;;
	MOV W0,RX_CMD			;;
	CALL LDW1_W			;;
	MOV W0,RX_PARA0			;;
	CALL LDW1_W			;;
	MOV W0,RX_PARA1			;;
	CALL LDW1_W			;;
	MOV W0,RX_PARA2			;;
	CALL LDW1_W			;;
	MOV W0,RX_PARA3			;;
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
	GOTO URXDEC_SLOTINF_ACT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;0:none(dark), 
;1:exist(y blink) 
;2:ready(y), ;
;3:paraSet loaded(green blink), 
;4:pbx run(greeen) 
;5:error(red),

;;RXPARA0 15:12 : SLOT TYPE 
;;RXPARA0 11:10 : SLOT NO
;;RXPARA0 9:8 :   SPARE 
;;RXPARA0 7:4 :   SPARE 
;;0:none(dark), 1:exist(y blink) ,2: ready(y), 3:paraSet loaded(green blink), 4:pbx run(greeen) 4:error(red),
;;RXPARA0 3:0 :   SLOT STATUS 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_SLOTINF_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	CP W0,#1			;;
	BRA LTU,$+4			;;
	RETURN				;;
	BRA W0				;;
	BRA URXDEC_SLOTINF_00J		;;
URXDEC_SLOTINF_00J:			;;
	MOV #SLOTINF_ADR,W1		;;	
	MOV RX_SERIAL_ID,W0		;;
	AND #0x0F,W0			;;
	SL W0,#3,W0			;;
	ADD W0,W1,W1			;;
	MOV RX_PARA0,W0			;;
	MOV W0,[W1++]			;;	
	MOV RX_PARA1,W0			;;
	MOV W0,[W1++]			;;	
	MOV RX_PARA2,W0			;;
	MOV W0,[W1++]			;;	
	MOV RX_PARA3,W0			;;
	MOV W0,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RX_SERIAL_ID,W0		;;
	AND #0x0F,W0			;;
	call clrSlotTime		;;
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
	;MOV [W1++],W0			;;
	;MOV W0,URX_GRP			;;
	RETURN				;;
CHK_U2RX_END:				;;
	MOV #0x00,W0			;;
	MOV W0,[W1]			;;
	RETURN				;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_BUFFER_ID:				;;
	CALL UTX_START			;;
	CALL LOAD_UTX_DEVICE_ID		;;
	MOV TARGET_SERIAL_ID,W0		;;
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
	MOV #0xAB00,W0			;;FLAG
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
UTX_BUFFER_1:				;;
	CALL GET_W3_BYTE		;;
	CALL LOAD_UTX_BYTE		;;
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
	MOV #SLOT_DEVICE_ID_K,W0	;;
	CALL LOAD_UTX_WORD		;;	
	RETURN				;;
LUDI_1:					;;
	MOV #SLOT_DEVICE_ID_K,W0	;;
	CALL LOAD_UTX_WORD		;;	
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
	CALL UTX_START			;;
	CALL LOAD_UTX_DEVICE_ID		;;
	MOV TARGET_SERIAL_ID,W0		;;
	CALL LOAD_UTX_WORD		;;
	BRA UTX_STD_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_STD_ALL:				;;
	CALL UTX_START			;;
	CALL LOAD_UTX_DEVICE_ID		;;
	MOV #0xFFFF,W0			;;SERIAL ID
	CALL LOAD_UTX_WORD		;;
	BRA UTX_STD_1			;;
UTX_STD_1:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB00,W0			;;FLAG
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
	BTFSC U1U2_F			;;
	BRA U2TX_END			;;
U1TX_END:				;;
	BCF U1RX_EN_F			;;
	BSF RS485_CTL_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF U1TX_END_F			;;
	MOVFF UTX_BTX,U1TX_BTX		;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BSET IFS0,#U1TXIF		;;
	RETURN				;;
U2TX_END:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF U2TX_END_F			;;
	MOVFF UTX_BTX,U2TX_BTX		;;
	CLR U2TX_BCNT			;;
	BSF U2TX_EN_F			;;
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
	RETURN				;;
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
	PUSH SR				;;
	PUSH W0				;;
	BCLR IFS1,#INT1IF		;;
	POP W0				;;
	POP SR				;;
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
	BRA Z,U1RXI_DATA_ST		;;	
	BTFSS U1RX_START_F		;;
	BRA U1RXI_END			;;
	MOV #0xEB,W0			;;
	CP W0,W1			;;
	BRA Z,U1RXI_DATA_END		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xEC,W0			;;
	CP W0,W1			;;
	BRA NZ,U1RXI_DATA		;;	
	BSF U1RXT_F			;;
	BRA U1RXI_END			;;
U1RXI_DATA_ST:				;;
	BSF U1RX_START_F		;;
	BCF U1RXT_F			;;
	BTSC U1RX_BYTE_PTR,#0		;;
	INC U1RX_BYTE_PTR		;; 
	MOV U1RX_BYTE_PTR,W0		;;
	MOV W0,U1RX_BYTE_PST		;;
	MOV W0,U1RX_BYTE_PBUF		;;
	CLR U1RX_BYTE_LEN		;;
	CLR U1RX_ADDSUM			;;
	CLR U1RX_XORSUM			;;
	BRA U1RXI_END			;;
U1RXI_DATA:				;;
	MOV #U1RX_MAXLEN_K,W0		;;
	CP U1RX_BYTE_LEN		;;
	BRA LTU,U1RXI_DATA_0		;;	
	BCF U1RX_START_F		;;
	BRA U1RXI_END			;;
U1RXI_DATA_0:				;;	
	MOV #0xAB,W0			;; 
	BTFSC U1RXT_F			;;
	XOR W0,W1,W1			;;
	BCF U1RXT_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_BUFSIZE_K,W0		;;
	CP U1RX_BYTE_PBUF		;;
	BRA LTU,$+4			;;
	CLR U1RX_BYTE_PBUF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #U1RX_BUFFER,W0		;;
	ADD U1RX_BYTE_PBUF,WREG		;;
	BCLR W0,#0			;;
	BTSC U1RX_BYTE_PBUF,#0		;;
	BRA U1RXI_DATA_1		;;
	MOV W1,[W0]			;;
	BRA U1RXI_DATA_2		;;
U1RXI_DATA_1:				;;
	SWAP W1				;;
	ADD W1,[W0],[W0]		;;
	SWAP W1				;;
U1RXI_DATA_2:				;;
	MOV U1RX_TMP0,W0		;;
	MOV W0,U1RX_TMP1		;;
	MOV W1,W0			;;
	MOV W0,U1RX_TMP0		;;
	MOV W1,W0			;;
	ADD U1RX_ADDSUM			;;	
	XOR U1RX_XORSUM			;;
	INC U1RX_BYTE_PBUF		;;
	INC U1RX_BYTE_LEN		;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_DATA_END:				;;
	BCF U1RX_START_F		;;	
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
U1RX_PACK_OK:				;;
	MOV U1RX_BYTE_LEN,W0		;;
	MOV #U1RX_PACK_BUF,W1		;;	
	MOV U1RX_PACK_PTR0,W0		;;
	SL W0,#2,W0			;;
	ADD W0,W1,W1			;;
	MOV U1RX_BYTE_LEN,W0		;;
	MOV W0,[W1++]			;;
	MOV U1RX_BYTE_PST,W0		;;
	MOV W0,[W1++]			;;
	INC U1RX_PACK_PTR0		;;
	MOV #U1RX_PACK_BUFLEN_K,W0	;;
	CP U1RX_PACK_PTR0		;;	
	BRA LTU,$+4			;;
	CLR U1RX_PACK_PTR0		;;
	MOV U1RX_BYTE_PBUF,W0		;;
 	MOV W0,U1RX_BYTE_PTR		;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	MOV #2,W0			;;
	CP U2RX_BYTE_PTR		;;
	BRA LTU,U2RXI_3			;;
	MOV W1,W0			;;
	ADD U2RX_ADDSUM			;;	
	XOR U2RX_XORSUM			;;
U2RXI_3:				;;
	INC U2RX_BYTE_PTR		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PS:				;;
	BCF U2RXT_F			;;
	CLR U2RX_BYTE_PTR		;;
	CLR U2RX_ADDSUM			;;
	CLR U2RX_XORSUM			;;
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
	BTFSS U2TX_EN_F			;;
	BRA U2TXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2TX_BUF,W1		;;
	MOV U2TX_BCNT,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	MOV [W1],W0			;;
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
	MOV W0,ADBUF			;;
	BCLR AD1CON1,#DONE		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T4Interrupt:			;;250 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	BCLR IFS1,#T4IF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_END:			;;
	POP W1			;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T1Interrupt:			;;10 US
	PUSH.S			;;PUSH W0,1,2,3,SR.C.Z.N.OV.DC
	BCLR IFS0,#T1IF		;;
	POP.S			;;
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



;INTPUT W1,REG ADDR
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
	CALL ERASE_F24SET			;;
	CALL SAVE_F24SET			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LF24_F24SETBUF:					;;
	CLR TBLPAG 				;;	
	MOV #tbloffset(F24SET_FADR),W1		;;
	MOV #F24SET_LEN_K,W3 			;;
	MOV #F24SET_BUF,W2			;;
LF24_F24SETBUF_1:				;;
	TBLRDL [W1++],W0			;;
	MOV W0,[W2++]				;;
	DEC W3,W3				;;
	BRA NZ,LF24_F24SETBUF_1			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VER_F24SET:					;;
	CLR TBLPAG 				;;	
	MOV #tbloffset(F24SET_FADR),W1		;;
	MOV #F24SET_LEN_K,W3 			;;
	MOV #F24SET_BUF,W2			;;
VER_F24SET_1:					;;
	TBLRDL [W1++],W0			;;
	XOR W0,[W2++],W0			;;
	BRA Z,$+4				;;
	RETURN					;;
	DEC W3,W3				;;
	BRA NZ,VER_F24SET_1			;;
	RETURN 					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERASE_F24SET:					;;
	BCLR INTCON2,#GIE			;;
	MOV #0,W0				;;0=FRC
	CALL OSC_PRG				;;
	CALL WAIT_FLASH24_READY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #tblpage(F24SET_FADR),W0		;;
	MOV W0,NVMADRU				;;
	MOV #tbloffset(F24SET_FADR),W0		;;
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
SAVE_F24SET:					;;
	BCLR INTCON2,#GIE			;;
	MOV #0,W0				;;0=FRC
	CALL OSC_PRG				;;
	CALL WAIT_FLASH24_READY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W3					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_F24SET_1:					;;
	MOV #tblpage(F24SET_FADR),W0		;;
	MOV W0,NVMADRU				;;
	MOV #tbloffset(F24SET_FADR),W0		;;
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	MOV W0,NVMADR				;;
	MOV #F24SET_BUF,W2			;;
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
	MOV #F24SET_LEN_K,W0			;;
	INC W0,W0				;;
	ASR W0,#1,W0 				;;
	CP W3,W0				;;				
	BRA LTU,SAVE_F24SET_1			;;
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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0xABCD			;;10	
	.WORD 0x0000			;;11	
	.WORD 0x0000			;;12	
	.WORD 0x0000			;;13	
	.WORD 0x0009			;;14	
	.WORD 0x0001			;;15	
	.WORD 0x0000			;;16
	.WORD 0x0000			;;17
	.WORD 0x0000			;;18
	.WORD 0x0000			;;19
	.WORD 0x0000			;;10
	.WORD 0x0000			;;11
	.WORD 0x0000			;;12
	.WORD 0x0000			;;13
	.WORD 0x0000			;;14
	.WORD 0x0000			;;15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.ORG (F24SET_FADR-0x204+0x800)	;;




