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

;;====================================
TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2		
;;====================================
FLAGA:	        	.SPACE 2
FLAGB:	        	.SPACE 2
FLAGC:	        	.SPACE 2
FLAGD:	        	.SPACE 2
;;====================================



CONVAD_CNT:		.SPACE 2
VR1BUF:			.SPACE 2
VR1V:			.SPACE 2
;TPRG2_CNT:		.SPACE 2
;;====================================
KEY_BUF:		.SPACE 2
KEY_TMP:		.SPACE 2
YESKEY_CNT:		.SPACE 2
NOKEY_CNT:		.SPACE 2
CONKEY_CNT:		.SPACE 2
KEYDB_BUF:		.SPACE 2
KEYDB_CNT:		.SPACE 2
KEYDB_TIM:		.SPACE 2


;DUTX_LEN:		.SPACE 2
;WAIT_DUTX_TIM:		.SPACE 2
F24SET_BUF:		.SPACE 64
;;====================================
KEYCODE:		.SPACE 2
TXCODE0:		.SPACE 2
TXCODE1:		.SPACE 2
TXCODE2:		.SPACE 2
KCODE_DATA:		.SPACE 2
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



END_REG:		.SPACE 2




.EQU STACK_BUF		,0x1F00	
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
;.EQU U1U2_F		,FLAGA
;.EQU U1U2_F_P		,0
;.EQU OLEDX12_F		,FLAGA
;.EQU OLEDX12_F_P	,1
;.EQU OLEDXALL_F		,FLAGA
;.EQU OLEDXALL_F_P	,2
;.EQU FLASH_AB_F		,FLAGA
;.EQU FLASH_AB_F_P	,3
;.EQU FLASH_QPI_F	,FLAGA
;.EQU FLASH_QPI_F_P	,4
;.EQU FLASH_QPI2_F	,FLAGA	
;.EQU FLASH_QPI2_F_P	,5
;.EQU SET_DIMS_F		,FLAGA
;.EQU SET_DIMS_F_P	,6
;EQU SLAVE_F		,FLAGA
;EQU SLAVE_F_P		,7
.EQU ERR_F		,FLAGA
.EQU ERR_F_P		,8
.EQU OK_F		,FLAGA
.EQU OK_F_P		,9
.EQU DONE_F		,FLAGA
.EQU DONE_F_P		,10
;.EQU OK_F		,FLAGA
;.EQU OK_F_P		,11
;EQU AICIO_AB_F		,FLAGA
;EQU AICIO_AB_F_P  	,12
;.EQU MASTER_U1RX_F	,FLAGA
;.EQU MASTER_U1RX_F_P 	,13
;.EQU MASTER_U2RX_F	,FLAGA
;.EQU MASTER_U2RX_F_P 	,14
;.EQU WAIT_DUTX_F	,FLAGA
;.EQU WAIT_DUTX_F_P  	,15



;FLAGB
.EQU DISKP_F		,FLAGB
.EQU DISKP_F_P		,0
.EQU NOKEY_F		,FLAGB
.EQU NOKEY_F_P		,1
.EQU DISKR_F		,FLAGB
.EQU DISKR_F_P		,2
.EQU KEY_PUSH_F		,FLAGB
.EQU KEY_PUSH_F_P	,3
;.EQU READ_IMAGE_ERR_F	,FLAGB
;.EQU READ_IMAGE_ERR_F_P ,4
;.EQU SCANKEY_F		,FLAGB
;.EQU SCANKEY_F_P	,5
;.EQU ONEKEY_F		,FLAGB
;.EQU ONEKEY_F_P		,6
;.EQU ALLKEY_F		,FLAGB
;.EQU ALLKEY_F_P		,7
;.EQU CLRSCR_F		,FLAGB
;.EQU CLRSCR_F_P		,8
;EQU TEST_F		,FLAGB
;EQU TEST_F_P		,9
;EQU LOAD_U1TXPARA_F	,FLAGB
;EQU LOAD_U1TXPARA_F_P	,10
;EQU LOAD_U2TXPARA_F	,FLAGB
;EQU LOAD_U2TXPARA_F_P	,11
;EQU AIC_BEEP_F		,FLAGB
;EQU AIC_BEEP_F_P	,12
;EQU RESTART_F		,FLAGB
;EQU __F_P	,13
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
;.EQU U1TX_EN_F		,FLAGD
;.EQU U1TX_EN_F_P	,0
;.EQU U2TX_EN_F		,FLAGD
;.EQU U2TX_EN_F_P	,1
;.EQU U1RX_BUFAB_F	,FLAGD
;.EQU U1RX_BUFAB_F_P	,2
;.EQU U2RX_BUFAB_F	,FLAGD
;.EQU U2RX_BUFAB_F_P	,3
;.EQU U1RXT_F		,FLAGD
;.EQU U1RXT_F_P		,4
;.EQU U2RXT_F		,FLAGD
;.EQU U2RXT_F_P		,5
;.EQU U1TX_END_F		,FLAGD
;.EQU U1TX_END_F_P	,6 
;.EQU U2TX_END_F		,FLAGD
;.EQU U2TX_END_F_P	,7 
;.EQU U1RX_PACKA_F	,FLAGD
;.EQU U1RX_PACKA_F_P	,8 
;.EQU U2RX_PACKA_F	,FLAGD
;.EQU U2RX_PACKA_F_P	,9 
;.EQU U1RX_PACKB_F	,FLAGD
;.EQU U1RX_PACKB_F_P	,10
;.EQU U2RX_PACKB_F	,FLAGD
;.EQU U2RX_PACKB_F_P	,11
;.EQU U1RX_EN_F		,FLAGD
;.EQU U1RX_EN_F_P	,12
;.EQU U2RX_EN_F		,FLAGD
;.EQU U2RX_EN_F_P	,13






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
	CALL INIT_TIMER3	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CALL ENABLE_FLASH_QPI	;;
	;CALL TEST_TIMER	;;
	;CALL TEST_UART1	;;
	;CALL TEST_UART2_I	;;
	;CALL TEST_FLASH_QPI
	;CALL TEST_FLASH		;;
	;CALL TEST_FLASH_PGM	;;
	;CALL TEST_OLED_A	;;
	;CALL TEST_OLED_G	;;
	;CALL TEST_OLED_H	;;
	;CALL START_TEST
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;










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
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	CLR ANSELC			;;
	CLR ANSELE			;;
;	RETURN				;;
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
MAIN:			
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
	CLRWDT				;;
	BTFSC T128M_F			;;	
	TG LED_O			;;	
	BTFSC T128M_F			;;
	CALL CONVERT_AD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
	;CALL KBMODE_PRG		;;
	CALL KEYBO			;;
	CALL MAIN_KEYPRG		;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	


	





MAIN_KEYPRG:
	CP0 R0
	BRA NZ,MKEY_PUSH
	CP0 R1
	BRA NZ,MKEY_FREE
	CP0 R2
	BRA NZ,MKEY_CON1
	CP0 R3
	BRA NZ,MKEY_CON2
	RETURN

MKEY_PUSH:
	MOVFF R0,KCODE_DATA
	DEC KCODE_DATA
	BCLR KCODE_DATA,#8
	BCLR KCODE_DATA,#9
	BRA TX_KEYCODE
MKEY_FREE:
	MOVFF R1,KCODE_DATA
	DEC KCODE_DATA
	BSET KCODE_DATA,#8
	BCLR KCODE_DATA,#9
	BRA TX_KEYCODE
MKEY_CON1:
	MOVFF R2,KCODE_DATA
	DEC KCODE_DATA
	BCLR KCODE_DATA,#8
	BSET KCODE_DATA,#9
	BRA TX_KEYCODE
MKEY_CON2:
	MOVFF R3,KCODE_DATA
	DEC KCODE_DATA
	BSET KCODE_DATA,#8
	BSET KCODE_DATA,#9
	BRA TX_KEYCODE
TX_KEYCODE:
	BTFSS SEL1_I
	BSET KCODE_DATA,#5
	BTFSS SEL2_I
	BSET KCODE_DATA,#6
	BRA TXCODE_PRG

TXCODE_PRG:
	MOVLF #0xABCD,TXCODE2
	MOVFF KCODE_DATA,TXCODE1
	MOVFF KCODE_DATA,TXCODE0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF I2C_SDA_O	
	BCF I2C_SCK_O	
	BSF I2C_SDA_IO	
	BSF I2C_SCK_IO	
	MOVLF #48,R0
TXCODE_1:
	BTSC TXCODE2,#15
	CALL TXBIT_HIGH
	BTSS TXCODE2,#15
	CALL TXBIT_LOW
	RLC TXCODE0
	RLC TXCODE1
	RLC TXCODE2
	DEC R0
	BRA NZ,TXCODE_1
	RETURN

I2CSDA_DLY:
	NOP	
	RETURN

I2CCLK_DLY:
	NOP	
	NOP
	NOP
	RETURN

TXBIT_HIGH:
	NOP
	NOP
	BSF I2C_SDA_IO
	CALL I2CSDA_DLY
	BCF I2C_SCK_IO
	CALL I2CCLK_DLY
	BSF I2C_SCK_IO
	CALL I2CCLK_DLY
	BSF I2C_SDA_IO	
 	RETURN
	
TXBIT_LOW:
	BCF I2C_SDA_IO
	CALL I2CSDA_DLY
	BCF I2C_SCK_IO
	CALL I2CCLK_DLY
	BSF I2C_SCK_IO
	CALL I2CCLK_DLY
	BSF I2C_SDA_IO	
 	RETURN
	






	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_KEYDATA:				;;
	BTFSS SW1_I			;;
	RETLW #1,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW2_I			;;
	RETLW #2,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW3_I			;;
	RETLW #3,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW4_I			;;
	RETLW #4,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW5_I			;;
	RETLW #5,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW6_I			;;
	RETLW #6,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW7_I			;;
	RETLW #7,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW8_I			;;
	RETLW #8,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW9_I			;;
	RETLW #9,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW10_I			;;
	RETLW #10,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW11_I			;;
	RETLW #11,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW12_I			;;
	RETLW #12,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW13_I			;;
	RETLW #13,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW14_I			;;
	RETLW #14,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW15_I			;;
	RETLW #15,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW16_I			;;
	RETLW #16,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW17_I			;;
	RETLW #17,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW18_I			;;
	RETLW #18,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW19_I			;;
	RETLW #19,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW20_I			;;
	RETLW #20,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW21_I			;;
	RETLW #21,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW22_I			;;
	RETLW #22,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS SW23_I			;;
	RETLW #23,W0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	RETLW #0,W0			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	CLR R0				;;KEY PUSH CODE
	CLR R1				;;KEY RELEASE CODEG
	CLR R2				;;KEY PUSH CONTINUE 1
	CLR R3				;;KEY PUSH CONTINUE 2
	BTFSS T512U_F			;;X16
	RETURN 				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_KEYDATA		;;
	MOV W0,KEYCODE
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










TIMEACT_PRG:
	BTFSS T1M_F			;;
	RETURN
	RETURN









	




	



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
	/*
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
	*/
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BSET OSCCON,#6		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





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
	;MOV #1,W0			;;1=FRCPLL
	MOV #0,W0			;;0=FRC
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
INIT_RAM:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
	BSF SW1_IO			;;
	;;PIN2 				;;
	BSF SW2_IO			;;
	;;PIN3 				;;
	BSF SW3_IO			;;
	;;PIN4 				;;
	BSF SW4_IO			;;
	;;PIN5 				;;
	BSF SW5_IO			;;
	;;PIN6 				;;
	BSF SW6_IO			;;
	;;PIN8 				;;
	BSF SW7_IO			;;
	;;PIN11 			;;
	BCF TP1_O			;;
	BCF TP1_IO			;;
	;;PIN12 			;;
	BCF TP2_O			;;
	BCF TP2_IO			;;
	;;PIN13 			;;
	BCF TP3_O			;;
	BCF TP3_IO			;;
	;;PIN14 			;;
	BCF TP4_O			;;
	BCF TP4_IO			;;
	;;PIN15 			;;
	BCF TP5_O			;;
	BCF TP5_IO			;;
	;;PIN16 			;;
	BCF TP6_O			;;
	BCF TP6_IO			;;
	;;PIN21 			;;
	BSF SW8_IO			;;
	;;PIN22 			;;
	BSF SW9_IO			;;
	;;PIN23 			;;
	BSF SW10_IO			;;
	;;PIN24 			;;
	BSF SW11_IO			;;
	;;PIN27 			;;
	BSF SW12_IO			;;
	;;PIN28 			;;
	BSF SW13_IO			;;
	;;PIN29 			;;
	BSF V5ADIN_IO			;;
	;;PIN30 			;;
	BSF SW14_IO			;;
	;;PIN31 			;;
	BSF SW15_IO			;;
	;;PIN32 			;;
	BSF SW16_IO			;;
	;;PIN33 			;;
	BSF SW17_IO			;;
	;;PIN34 			;;
	BSF SW18_IO			;;
	;;PIN35 			;;
	BSF SW19_IO			;;
	;;PIN36 			;;
	BSF SW20_IO			;;
	;;PIN37 			;;
	BSF SW21_IO			;;
	;;PIN42 			;;
	BSF SW22_IO			;;
	;;PIN43 			;;
	BCF I2C_SCK_O			;;
	BSF I2C_SCK_IO			;;
	;;PIN44 			;;
	BCF I2C_SDA_O			;;
	BSF I2C_SDA_IO			;;
	;;PIN45 			;;
	BSF SW23_IO			;;
	;;PIN46 			;;
	BCF NC46_O			;;
	BCF NC46_IO			;;
	;;PIN47				;;
	BCF NC47_O			;;
	BCF NC47_IO			;;
	;;PIN48 			;;
	BCF NC48_O			;;
	BCF NC48_IO			;;
	;;PIN49 			;;
	BCF NC49_O			;;
	BCF NC49_IO			;;
	;;PIN50 			;;
	BCF NC50_O			;;
	BCF NC50_IO			;;
	;;PIN51 			;;
	BCF NC51_O			;;
	BCF NC51_IO			;;
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
	BCF NC55_O			;;
	BCF NC55_IO			;;
	;;PIN58 			;;
	BCF NC58_O			;;
	BCF NC58_IO			;;
	;;PIN59 			;;
	BCF NC59_O			;;
	BCF NC59_IO			;;
	;;PIN60 			;;
	BSF SEL1_IO			;;
	;;PIN61 			;;
	BSF SEL2_IO			;;
	;;PIN62 			;;
	BSF SEL3_IO			;;
	;;PIN63 			;;
	BSF SEL4_IO			;;
	;;PIN64 			;;
	BCF NC64_O			;;
	BCF NC64_IO			;;
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



;OLED FLASH DESCRIPTION
;===================================================================
;0x000000~0x000003: oledKbId=0xabcd0001 h2l
;0x000004	  : oledKb Amount
;0x000020	  : initial kbName		
;===================================================================
;keyboard A
;0x001000~32B	  : keyboard name 
;	
;0x001020~1B	  : uart port
;0x001021~1B	  : uart data bit
;0x001022~4B	  : uart boudrate l2h
;0x001026~1B	  : uart parity 0:none 1:odd 2:even
;0x001027~1B	  : uart stop bit 
;
;0x001040~1B	  : switch keyboard key ;0=none
;0x001041~31B	  : the name of keyboard switch
;
;0x001060~1B	  : switch keyboard key ;0=none
;0x001061~31B	  : the name of keyboard switch
;
;0x001080~1B	  : switch keyboard key ;0=none
;0x001081~31B	  : the name of keyboard switch
;
;0x0010A0~1B	  : switch keyboard key ;0=none
;0x0010A1~31B	  : the name of keyboard switch
;
;0x0010C0~1B	  : switch keyboard key ;0=none
;0x0010C1~31B	  : the name of keyboard switch
;
;0x0010E0~1B	  : switch keyboard key ;0=none
;0x0010E1~31B	  : the name of keyboard switch
;
;0x001100~1B	  : switch keyboard key ;0=none
;0x001101~31B	  : the name of keyboard switch
;
;key 1
;0x001120~2B	  : keyId 0xABCD 
;0x001122~1B 	  : ASCII or HEX 0:ASCII, 1:HEX
;0x001123~3B 	  : press tx code address(l2h), real must x4 
;0x001126~3B 	  : release tx code address(l2h), real must x4 
;0x001149~3B 	  : continue tx code address(l2h), real must x4 
;0x00112c~3B 	  : rx code address(l2h) of switch to page 1, real must x4 
;0x00112f~3B 	  : rx code address(l2h) of switch to page 2, real must x4 
;0x001132~3B 	  : rx code address(l2h) of switch to page 3, real must x4 
;0x001135~3B 	  : image address(l2h) of page 1, real must x4 
;0x001138~3B 	  : image address(l2h) of page 2, real must x4 
;0x00113b~3B 	  : image address(l2h) of page 3, real must x4 
;key2
;0x001140~2B	  : keyId 0xABCD 
;0x001142~1B 	  : ASCII or HEX 0:ASCII, 1:HEX
;0x001143~3B 	  : press tx code address(l2h), real must x4 
;0x001146~3B 	  : release tx code address(l2h), real must x4 
;0x001149~3B 	  : continue tx code address(l2h), real must x4 
;0x00114c~3B 	  : rx code address(l2h) of switch to page 1, real must x4 
;0x00114f~3B 	  : rx code address(l2h) of switch to page 2, real must x4 
;0x001152~3B 	  : rx code address(l2h) of switch to page 3, real must x4 
;0x001155~3B 	  : image address(l2h) of page 1, real must x4 
;0x001158~3B 	  : image address(l2h) of page 2, real must x4 
;0x00115b~3B 	  : image address(l2h) of page 3, real must x4 
;key3
;.................
;.................
;.................
;===================================================================
;keyboard B
;0x002000~32B	  : keyboard name
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





