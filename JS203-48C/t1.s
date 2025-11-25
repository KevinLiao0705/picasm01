;******************************************************************************
;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 


	
 

        .equ __24ep32gp206, 1 ;
        .include "p24ep64MC202.inc"

;BY DEFINE=============================
;====================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'
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
.MACRO 	LW10 XX,YY
	MOV #\XX,W1
	MOV #\YY,W0
.ENDM
;-------------------------



.EQU 	F24SET_FADR	,0xA000	;DONT USE THE LAST BLOCK OF FLASH(0x0A800)

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
LEDFLAG0:		.SPACE 2
LEDFLAG1:		.SPACE 2
UTXCHN_FLAG:		.SPACE 2
UTX_NOKEY_TIM:		.SPACE 2


URX_DEVICE_ID:		.SPACE 2
URX_SERIAL_ID:		.SPACE 2
URX_GROUP_ID:		.SPACE 2

URX_ADR:		.SPACE 2
URX_FLAG:		.SPACE 2
URX_LEN:		.SPACE 2
URX_CMD:		.SPACE 2
URX_PARA0:		.SPACE 2
URX_PARA1:		.SPACE 2
URX_PARA2:		.SPACE 2
URX_PARA3:		.SPACE 2

BLINK_CNT:		.SPACE 2

LEDMODE_FLAG0:		.SPACE 2
LEDMODE_FLAG1:		.SPACE 2
LEDMODE_FLAG2:		.SPACE 2
LEDMODE_FLAG3:		.SPACE 2

DEBUG0_CNT:		.SPACE 2



;;====================================
;SWITCH_KB_FLAG1:	.SPACE 2

;ICTXPARA_GRP_CNT:	.SPACE 2
;ICTXPARA_ONCE_CNT:	.SPACE 2
;TPRG1_CNT:		.SPACE 2
;TPRG2_CNT:		.SPACE 2
;;====================================
;;====================================
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

NOKEY_CNT:		.SPACE 2
YESKEY_CNT:		.SPACE 2
CONKEY_CNT:		.SPACE 2
KEY_TMP:		.SPACE 2
KEY_BUF:		.SPACE 2
KEYCODE:		.SPACE 2


;;====================================
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
;;====================================
UTX_FLAG:		.SPACE 2	
UTX_CMD:		.SPACE 2	
UTX_PARA0:		.SPACE 2	
UTX_PARA1:		.SPACE 2	
UTX_PARA2:		.SPACE 2	
UTX_PARA3:		.SPACE 2	
UTX_CHKSUM0:		.SPACE 2	
UTX_CHKSUM1:		.SPACE 2	
UTX_BTX:		.SPACE 2	
UTX_BUFFER_LEN:		.SPACE 2	




;######################################
F24SET_BUF:		.SPACE 0
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
.EQU U1TX_BUF		,0x2000	;256BYTE
.EQU U1RX_BUFSIZE	,256
.EQU U1RX_BUFA		,0x2100	;256BYTE
.EQU U1RX_BUFB		,0x2200	;256BYTE
.EQU U2TX_BUF		,0x2300	;256BYTE


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
.EQU OK_F		,FLAGA
.EQU OK_F_P		,0
.EQU ERR_F		,FLAGA
.EQU ERR_F_P		,1
.EQU SYSERR_F		,FLAGA
.EQU SYSERR_F_P		,2
;.EQU BLINK_F		,FLAGA
;.EQU BLINK_F_P		,3
;.EQU LED2G_F		,FLAGA
;.EQU LED2G_F_P		,4
;.EQU LED2R_F		,FLAGA
;.EQU LED2R_F_P		,5
.EQU U1TX_EN_F		,FLAGA
.EQU U1TX_EN_F_P	,6
.EQU U2TX_EN_F		,FLAGA
.EQU U2TX_EN_F_P	,7
.EQU NOKEY_F		,FLAGA
.EQU NOKEY_F_P		,8
.EQU DISKR_F		,FLAGA
.EQU DISKR_F_P		,9
.EQU DISKP_F		,FLAGA
.EQU DISKP_F_P		,10
.EQU DISKC_F		,FLAGA
.EQU DISKC_F_P		,11
.EQU KEY_PUSH_F		,FLAGA
.EQU KEY_PUSH_F_P  	,12
.EQU U1RX_EN_F		,FLAGA
.EQU U1RX_EN_F_P 	,13
.EQU U1RX_ALT_F		,FLAGA
.EQU U1RX_ALT_F_P 	,14
.EQU U1RX_BUFAB_F	,FLAGA
.EQU U1RX_BUFAB_F_P  	,15



;FLAGB
.EQU U1RX_PACKA_F	,FLAGB
.EQU U1RX_PACKA_F_P	,0
.EQU U1RX_PACKB_F	,FLAGB
.EQU U1RX_PACKB_F_P	,1
;.EQU LBLINK_F		,FLAGA
;.EQU LBLINK_F_P		,3
;.EQU KEY_PUSH_F	,FLAGB
;.EQU KEY_PUSH_F_P	,3
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


;




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
	CALL INIT_OSC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #5000,W0		;;
	CALL DLYX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CALL TEST_OSC
	CALL INIT_AD		;;
	CALL INIT_RAM		;;
	CALL INIT_SIO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_TIMER2	;;
	CALL INIT_UART1		;;
	;CALL INIT_TIMER3	;;
	;CALL INIT_UART2	;;
	;CALL TEST_UART1
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INIT_SPI:
    	BCLR SPI1STAT,#SPIEN 		;disable SPI port
    	BCLR  SPI1STAT,#SPISIDL 	;Continue module operation in Idle mode

    	CLR SPI1BUF 			;clear SPI buffer

    	BCLR IFS0,#SPI1IF 		;clear interrupt flag
    	BSET IEC0,#SPI1IE 		;enable interrupt

    	BCLR SPI1CON1,#DISSDO		;SDOx pin is controlled by the module
    	BSET SPI1CON1,#MODE16 		;set in 16-bit mode, clear in 8-bit mode
    	BCLR SPI1CON1,#SMP		;SMP must be cleared when SPIx is used in Slave mode
    	BSET SPI1CON1,#CKP 		;CKP and CKE is subject to change ...
    	BCLR SPI1CON1,#CKE 		;... based on your communication mode.
    	BSET SPI1CON1,#SSEN		;SSx pin is used for Slave mode
    	BCLR SPI1CON1,#MSTEN 		;1 =  Master mode; 0 =  Slave mode

    	CLR SPI1CON2 			;non-framed mode

    	BSF SPI_CS_I			;
    	BSF SPI_CS_IO			;set SS as input
    	BSET SPI1STAT,#SPIEN 		;enable SPI port, clear status
	RETURN



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
TEST_UART1:				;;
	MOV #0xAB,W0			;;
	MOV W0,U1TXREG			;;
	;CALL U1TX_RSP			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART1 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
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
TEST_LED:
	SETM LEDFLAG0
	SETM LEDFLAG1
	CALL LEDPRG
	MOV #1000,W0
	CALL DLYMX
	CLR LEDFLAG0
	CLR LEDFLAG1
	CALL LEDPRG
	MOV #100,W0
	CALL DLYMX
	MOVLF #1,LEDFLAG0
	CLR R0
TEST_LED_1:
	BCLR LEDFLAG1,#0
	BTSS R0,#2
	BSET LEDFLAG1,#0
	BCLR LEDFLAG1,#1
	BTSC R0,#2
	BSET LEDFLAG1,#1

	CALL LEDPRG
	MOV #100,W0
	CALL DLYMX
	RLNC LEDFLAG0
	INC R0
	MOV #16,W0
	CP R0
	BRA LTU,TEST_LED_1

	CLR LEDFLAG0
	CLR LEDFLAG1
	CALL LEDPRG
	MOV #100,W0
	CALL DLYMX
	RETURN

	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	CALL TEST_LED	
	BSF U1RX_EN_F
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
	CLRWDT				;;
	CALL TMR2PRG			;;	
	BTFSC T1M_F			;;	
	CALL T1M_PRG			;;
	BTFSC T128M_F			;;	
	CALL T128M_PRG			;;
	CALL TRANS_LEDMODE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_U1RX			;;
	CALL LEDPRG			;;
	CALL KEYBO			;;
	CALL MAINKEY_PRG		;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


T1M_PRG:
	INC BLINK_CNT
	RETURN

MAINKEY_PRG:
	CLR UTX_PARA0
	BTSC R0,#0
	BSET UTX_PARA0,#0
	BTSC R0,#1
	BSET UTX_PARA0,#1
	BTSC R1,#0
	BSET UTX_PARA0,#2
	BTSC R1,#1
	BSET UTX_PARA0,#3
	BTSC R2,#0
	BSET UTX_PARA0,#4
	BTSC R2,#1
	BSET UTX_PARA0,#5
	BTSC R3,#0
	BSET UTX_PARA0,#6
	BTSC R3,#1
	BSET UTX_PARA0,#7
	CP0 UTX_PARA0
	BRA NZ,$+4
	RETURN 
	CALL UTX_YESKEY
	RETURN

UTX_NOKEY:
	CLR URX_PARA0
UTX_YESKEY:
	MOVLF #1,UTXCHN_FLAG
	MOVLF #0xAB00,UTX_FLAG
	MOVLF #0X1000,UTX_CMD
	CLR UTX_PARA1
	CLR UTX_PARA2
	CLR UTX_PARA3
	CALL UTX_STD
	CLR UTX_NOKEY_TIM
	RETURN
	



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
	MOV W1,URX_ADR			;;
	MOV [W1++],W0			;;
	MOV W0,URX_DEVICE_ID		;;
	MOV [W1++],W0			;;
	MOV W0,URX_SERIAL_ID		;;
	MOV [W1++],W0			;;
	MOV W0,URX_GROUP_ID		;;
	MOV [W1++],W0			;;
	MOV W0,URX_LEN			;;
	MOV [W1++],W0			;;
	MOV W0,URX_CMD			;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA0		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA1		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA2		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX_CMD,W0			;;	
	SWAP W0				;;
	AND #255,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x10			;;
	BRA NZ,$+6			;;
	GOTO U1RXDEC_10XX_ACT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXDEC_10XX_ACT:
	MOV URX_CMD,W0
	AND #255,W0
 	CP W0,#1
	BRA LTU,$+4
	RETURN
	BRA W0
	BRA U1RX_1000
U1RX_1000:
	MOVFF URX_PARA0,LEDMODE_FLAG0
	MOVFF URX_PARA1,LEDMODE_FLAG1
	MOVFF URX_PARA2,LEDMODE_FLAG2
	MOVFF URX_PARA2,LEDMODE_FLAG3
	RETURN


T128M_PRG:
	INC UTX_NOKEY_TIM
	MOV #10,W0
	CP UTX_NOKEY_TIM
	BRA LTU,$+6
	CALL UTX_NOKEY 
	RETURN	
	
NOPP:
	NOP
	NOP
	NOP
	RETURN


GET_LEDF:
	AND #3,W0
	BRA W0
	BRA LEDMODE_0J
	BRA LEDMODE_1J
	BRA LEDMODE_2J
	BRA LEDMODE_3J
LEDMODE_0J:
	RETLW #0,W0
LEDMODE_1J:
	RETLW #1,W0
LEDMODE_2J:
	BTSC BLINK_CNT,#7
	RETLW #1,W0
	BTSS BLINK_CNT,#7
	RETLW #0,W0
	RETURN
LEDMODE_3J:
	BTSC BLINK_CNT,#8
	RETLW #1,W0
	BTSS BLINK_CNT,#8
	RETLW #0,W0
	RETURN


	

TRANS_LEDMODE:
	CLR W2
	CLR LEDFLAG0
T_LEDMODE_1:
	MOV LEDMODE_FLAG0,W0
	SL W2,#1,W1
	LSR W0,W1,W0
	CALL GET_LEDF
	CP0 W0
	BRA Z,T_LEDMODE_2
	MOV W2,W0
	CALL BIT_TRANS
	IOR LEDFLAG0	
T_LEDMODE_2:
	INC W2,W2
	CP W2,#8
	BRA LTU,T_LEDMODE_1	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W2
T_LEDMODE_3:
	MOV LEDMODE_FLAG1,W0
	SL W2,#1,W1
	LSR W0,W1,W0
	CALL GET_LEDF
	CP0 W0
	BRA Z,T_LEDMODE_4
	MOV W2,W0
	CALL BIT_TRANS
	SWAP W0
	IOR LEDFLAG0	
T_LEDMODE_4:
	INC W2,W2
	CP W2,#8
	BRA LTU,T_LEDMODE_3	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W2
	CLR LEDFLAG1
T_LEDMODE_5:
	MOV LEDMODE_FLAG2,W0
	SL W2,#1,W1
	LSR W0,W1,W0
	CALL GET_LEDF
	CP0 W0
	BRA Z,T_LEDMODE_6
	MOV W2,W0
	CALL BIT_TRANS
	IOR LEDFLAG1	
T_LEDMODE_6:
	INC W2,W2
	CP W2,#8
	BRA LTU,T_LEDMODE_5	


	RETURN

LEDPRG:
	BTSS LEDFLAG1,#0
	BSF LED2G_O
	BTSC LEDFLAG1,#0
	BCF LED2G_O

	BTSS LEDFLAG1,#1
	BSF LED2R_O
	BTSC LEDFLAG1,#1
	BCF LED2R_O

	MOV #0xFFFF,W1
	MOV #0xFF00,W2
	MOV LEDFLAG0,W0
	XOR W0,W1,W0
	XOR LATB,WREG
	AND W0,W2,W0
	XOR LATB
	BSF LED_TRIG1_O
	CALL NOPP
	BCF LED_TRIG1_O
	;;;;;;;;;;;;;;;;
	MOV LEDFLAG0,W0
	XOR W0,W1,W0
	SWAP W0	
	XOR LATB,WREG
	AND W0,W2,W0
	XOR LATB
	BSF LED_TRIG2_O
	CALL NOPP
	BCF LED_TRIG2_O
	RETURN

	

GET_KEYCODE:
	CLR KEYCODE
	BTFSS SW1_I
	BSET KEYCODE,#0
	BTFSS SW2_I
	BSET KEYCODE,#1
	RETURN

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
	MOV #38,W0		;;RP38 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR2		;;
	MOV #0x0100,W0		;;RP39 U1TX
	IOR RPOR2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN			;;
	
	
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
	;MOV #107,W0	;115200		;;50MHZ
	MOV #1703,W0	;9600		;;66MHZ
	;MOV #142,W0	;115200		;;66MHZ
	;MOV #65,W0	;256000		;;66MHZ
	;MOV #47,W0	;345600		;;66MHZ
	;MOV #65,W0	;250000		;;66MHZ
	;MOV #54,W0	;250000		;;66MHZ
	;MOV #35,W0	;115200		;;66MHZ
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
	;;PIN4 				;;
	;;PIN5 				;;
	;;PIN6 				;;
	BSF LED2R_O			;;
	BCF LED2R_IO			;;
	;;PIN7 				;;
	BSF LED2G_O			;;
	BCF LED2G_IO			;;
	;;PIN8	 			;;
	BCF NC8_O			;;
	BCF NC8_IO			;;
	;;PIN9	 			;;
	BSF SPI_CS_IO			;;
	;;PIN10	 			;;
	;;PIN11	 			;;
	BSF SPI_SCL_IO			;;
	;;PIN12	 			;;
	BSF URX1_IO			;;
	;;PIN13 			;;
	BSF UTX1_O			;;
	BCF UTX1_IO			;;
	;;PIN14 			;;
	BCF DB0_O			;;
	BCF DB0_IO			;;
	;;PIN15 			;;
	BCF DB1_O			;;
	BCF DB1_IO			;;
	;;PIN16 			;;
	;;PIN17 			;;
	;;PIN18 			;;
	BCF DB2_O			;;
	BCF DB2_IO			;;
	;;PIN19 			;;
	BCF DB3_O			;;
	BCF DB3_IO			;;
	;;PIN20 			;;
	BCF DB4_O			;;
	BCF DB4_IO			;;
	;;PIN21 			;;
	BCF DB5_O			;;
	BCF DB5_IO			;;
	;;PIN22 			;;
	BCF DB6_O			;;
	BCF DB6_IO			;;
	;;PIN23 			;;
	BCF DB7_O			;;
	BCF DB7_IO			;;
	;;PIN24 			;;
	;;PIN25 			;;
	;;PIN26 			;;
	BCF LED_TRIG2_O			;;
	BCF LED_TRIG2_IO		;;
	;;PIN27 			;;
	BCF LED_TRIG1_O			;;
	BCF LED_TRIG1_IO		;;
	;;PIN28 			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;























	











	
















;INPUT UTXCHN_FLAG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_START:				;;
	BTSC UTXCHN_FLAG,#0		;;
	BCF U1TX_EN_F			;;
	BTSC UTXCHN_FLAG,#1		;;
	BCF U2TX_EN_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	CLR UTX_BTX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	MOV W0,UTX_CHKSUM0		;;
	CLR UTX_CHKSUM1			;;
	BTSC UTXCHN_FLAG,#0		;;
	MOV #U1TX_BUF,W1		;;
	BTSC UTXCHN_FLAG,#1		;;
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
	BTSC UTXCHN_FLAG,#0		;;
	BRA U1TX_END			;;
	BTSC UTXCHN_FLAG,#1		;;
	BRA U2TX_END			;;
	RETURN				;;
U1TX_END:				;;
	MOVFF UTX_BTX,U1TX_BTX		;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BSET IFS0,#U1TXIF		;;
	RETURN				;;
U2TX_END:				;;
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
UTX_STD:				;;
	CALL UTX_START			;;
	MOV UTX_FLAG,W0			;;FLAG
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
	PUSH.S				;;
	BCLR IFS0,#U1RXIF		;;
	MOV U1RXREG,W1			;;
	AND #255,W1			;;
	BTFSS U1RX_EN_F			;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #U1RX_BUFA,W2		;;
	;MOV DEBUG0_CNT,W0
	;SL W0,#1,W0 
	;ADD W0,W2,W2
	;MOV W1,[W2]
	;INC DEBUG0_CNT
	;MOV #64,W0
	;CP DEBUG0_CNT
	;BRA LTU,$+4
	;CLR DEBUG0_CNT
	

	


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
	BTFSC U1RX_ALT_F		;;
	XOR W0,W1,W1			;;
	BCF U1RX_ALT_F			;;
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
	BCF U1RX_ALT_F			;;
	CLR U1RX_BYTE_PTR		;;
	CLR U1RX_ADDSUM			;;
	CLR U1RX_XORSUM			;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_PE:				;;
	BCF U1RX_ALT_F			;;
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
	BSF U1RX_ALT_F			;;
	BRA U1RXI_END			;;
U1RXI_ERR:				;;	
	NOP				;;
U1RXI_END:				;;	
	POP.S				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2RXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2RXIF		;;
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
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__SPI1Interrupt:			;;	
	PUSH.S				;;PUSH W0,1,2,3,SR.C.Z.N.OV.DC
SPI1I_END:				;;
	POP.S				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			





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


