;******************************************************************************
;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 


	
 

        .equ __24ep64gp206, 1 ;
        .include "p24ep64gp206.inc"

;BY DEFINE=============================
;====================================
	.EQU	VER0_K		,'6'
	.EQU	VER1_K		,'4'

;..............................................................................
;Global Declarations:
;..............................................................................
    	.global __reset          
;    	.global __T1Interrupt    
;  	.global __T4Interrupt    
;	.global __CNInterrupt	 
  	.global __U1RXInterrupt    
  	.global __U1TXInterrupt  
  	.global __U2RXInterrupt    
  	.global __U2TXInterrupt  
	.global __INT1Interrupt
	.global __INT2Interrupt
	.global __IC1Interrupt
	.global __IC2Interrupt
	.global __IC3Interrupt


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

TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2		

FLAGA:	        	.SPACE 2
FLAGB:	        	.SPACE 2
FLAGC:	        	.SPACE 2
FLAGD:	        	.SPACE 2

U1RX_BYTE_PTR:		.SPACE 2
U1RXA_LEN:		.SPACE 2
U1RXB_LEN:		.SPACE 2
U1TX_BTX:		.SPACE 2
U1TX_BCNT:		.SPACE 2
U1RXGRP:		.SPACE 2
U1RXCMD:		.SPACE 2
U1TX_LEN:		.SPACE 2
U1TX_CHKSUM0:		.SPACE 2
U1TX_CHKSUM1:		.SPACE 2

U2RX_BYTE_PTR:		.SPACE 2
U2RXA_LEN:		.SPACE 2
U2RXB_LEN:		.SPACE 2
U2TX_BTX:		.SPACE 2
U2TX_BCNT:		.SPACE 2
U2RXGRP:		.SPACE 2
U2RXCMD:		.SPACE 2
U2TX_LEN:		.SPACE 2
U2TX_CHKSUM0:		.SPACE 2
U2TX_CHKSUM1:		.SPACE 2
CFGRSP:			.SPACE 2



OUTFLAG0:		.SPACE 2
OUTFLAG1:		.SPACE 2
OUTFLAG2:		.SPACE 2
OUTFLAG3:		.SPACE 2
INFLAG0:		.SPACE 2
INFLAG1:		.SPACE 2

	
SPOUT0:			.SPACE 2
SPOUT1:			.SPACE 2
SPOUT2:			.SPACE 2
SPOUT3:			.SPACE 2
SPOUT4:			.SPACE 2


SPGAIN0:		.SPACE 2		
SPGAIN1:		.SPACE 2		
SPGAIN2:		.SPACE 2		
SPGAIN3:		.SPACE 2		
SPGAIN4:		.SPACE 2		


SPGAIN_BUF0:		.SPACE 2		
SPGAIN_BUF1:		.SPACE 2		
SPGAIN_BUF2:		.SPACE 2		
SPGAIN_BUF3:		.SPACE 2		
SPGAIN_BUF4:		.SPACE 2		

MICCUT_BUF0:		.SPACE 2		
MICCUT_BUF1:		.SPACE 2		
MICCUT_BUF2:		.SPACE 2		
MICCUT_BUF3:		.SPACE 2		
MICCUT_BUF4:		.SPACE 2		

MICBGN_BUF0:		.SPACE 2
MICBGN_BUF1:		.SPACE 2
MICBGN_BUF2:		.SPACE 2
MICBGN_BUF3:		.SPACE 2
MICBGN_BUF4:		.SPACE 2

MICDLY_BUF0:		.SPACE 2	
MICDLY_BUF1:		.SPACE 2	
MICDLY_BUF2:		.SPACE 2	
MICDLY_BUF3:		.SPACE 2	
MICDLY_BUF4:		.SPACE 2	

MICCUT_TIM0:		.SPACE 2		
MICCUT_TIM1:		.SPACE 2		
MICCUT_TIM2:		.SPACE 2		
MICCUT_TIM3:		.SPACE 2		
MICCUT_TIM4:		.SPACE 2		




LCD0_DATA:		.SPACE 2
LCD0A_PTR:		.SPACE 2
LCD0B_PTR:		.SPACE 2
LCD0_ACTT:		.SPACE 2
LCD0_INX:		.SPACE 2
LCD0_TEMP:		.SPACE 64
LCD0_BUF:		.SPACE 64

LCD1_DATA:		.SPACE 2
LCD1A_PTR:		.SPACE 2
LCD1B_PTR:		.SPACE 2
LCD1_ACTT:		.SPACE 2
LCD1_INX:		.SPACE 2
LCD1_TEMP:		.SPACE 64
LCD1_BUF:		.SPACE 64


CODEC_TIM:		.SPACE 2



SPOBUF0:		.SPACE 2
SPOBUF1:		.SPACE 2
SPOBUF2:		.SPACE 2
SPOBUF3:		.SPACE 2
SPOBUF4:		.SPACE 2

TEST_CNT:		.SPACE 2
TTONE_CNT:		.SPACE 2
TTONE_BUF:		.SPACE 16
SPIN_BUF:		.SPACE 320 

MICOBUF0:		.SPACE 2
MICOBUF1:		.SPACE 2
MICOBUF2:		.SPACE 2
MICOBUF3:		.SPACE 2
MICOBUF4:		.SPACE 2


MICIBUF0:		.SPACE 2
MICIBUF1:		.SPACE 2
MICIBUF2:		.SPACE 2
MICIBUF3:		.SPACE 2
MICIBUF4:		.SPACE 2


IOPRG_CNT:		.SPACE 2
FREEK0_TIM:		.SPACE 2
FREEK1_TIM:		.SPACE 2
CFGRJ_TIM:		.SPACE 2
CFGRJ_STEP:		.SPACE 2
CONVAD_CNT:		.SPACE 2
VR1BUF:			.SPACE 2
VR2BUF:			.SPACE 2
VR1V:			.SPACE 2
VR2V:			.SPACE 2
GAINA:			.SPACE 2
;U1TX_LEN:		.SPACE 2
;U1TX_LEN:		.SPACE 2
;U1TX_LEN:		.SPACE 2
;U1TX_LEN:		.SPACE 2
;U1TX_LEN:		.SPACE 2
LCDE0H_CNT:		.SPACE 2
LCDE0L_CNT:		.SPACE 2
DEBUG_LCD_CNT:		.SPACE 2
DEBUG_LCD_BUF:		.SPACE 512



.EQU U1TX_BUF		,0x2100
.EQU U1RX_BUFA		,0x2200
.EQU U1RX_BUFB		,0x2300
.EQU U1RX_TEMP		,0x2400
.EQU U2TX_BUF		,0x2500
.EQU U2RX_BUFA		,0x2600
.EQU U2RX_BUFB		,0x2700
.EQU U2RX_TEMP		,0x2800



;EQU TEST_O		,LATC
;EQU TEST_IO		,TRISC
;EQU TEST_O_P		,15
;EQU TEST_IO_P		,15

.EQU TEST_O		,LATD
.EQU TEST_IO		,TRISD
.EQU TEST_O_P		,6
.EQU TEST_IO_P		,6


		
.EQU U1TX_O		,LATB
.EQU U1TX_IO		,TRISB
.EQU U1TX_O_P		,4
.EQU U1TX_IO_P		,4

.EQU U1RX_I		,PORTA
.EQU U1RX_IO		,TRISA
.EQU U1RX_I_P		,8
.EQU U1RX_IO_P		,8

;.EQU U2TX_O		,LATA
;.EQU U2TX_IO		,TRISA
;.EQU U2TX_O_P		,4
;.EQU U2TX_IO_P		,4

;.EQU U2RX_I		,PORTA
;.EQU U2RX_IO		,TRISA
;.EQU U2RX_I_P		,9
;.EQU U2RX_IO_P		,9

;.EQU CFG_O		,LATD
;.EQU CFG_IO		,TRISD
;.EQU CFG_O_P		,5
;.EQU CFG_IO_P		,5


.EQU MCLK_O		,LATB
.EQU MCLK_IO		,TRISB
.EQU MCLK_O_P		,9
.EQU MCLK_IO_P		,9



.EQU SPCHA_I		,PORTE
.EQU SPCHA_IO		,TRISE
.EQU SPCHA_I_P		,14
.EQU SPCHA_IO_P		,14


.EQU SPCHB_I		,PORTE
.EQU SPCHB_IO		,TRISE
.EQU SPCHB_I_P		,15
.EQU SPCHB_IO_P		,15



;.EQU CS0_O		,LATA
;.EQU CS0_IO		,TRISA
;.EQU CS0_O_P		,12
;.EQU CS0_IO_P		,12
;.EQU CS0_O		,LATC
;.EQU CS0_IO		,TRISC
;.EQU CS0_O_P		,11
;.EQU CS0_IO_P		,11


;.EQU CS1_O		,LATA
;.EQU CS1_IO		,TRISA
;.EQU CS1_O_P		,11
;.EQU CS1_IO_P		,11

;.EQU CS2_O		,LATA
;.EQU CS2_IO		,TRISA
;.EQU CS2_O_P		,0 
;.EQU CS2_IO_P		,0 

;.EQU CS3_O		,LATA
;.EQU CS3_IO		,TRISA
;.EQU CS3_O_P		,1
;.EQU CS3_IO_P		,1

;.EQU TRIG1_O		,LATB
;.EQU TRIG1_IO		,TRISB
;.EQU TRIG1_O_P		,0 
;.EQU TRIG1_IO_P		,0 

;.EQU TRIG2_O		,LATB
;.EQU TRIG2_IO		,TRISB
;.EQU TRIG2_O_P		,1
;.EQU TRIG2_IO_P		,1


;.EQU CS4_O		,LATC
;.EQU CS4_IO		,TRISC
;.EQU CS4_O_P		,9
;.EQU CS4_IO_P		,9

;.EQU CS5_O		,LATD
;.EQU CS5_IO		,TRISD
;.EQU CS5_O_P		,6
;.EQU CS5_IO_P		,6

;.EQU CS6_O		,LATD
;.EQU CS6_IO		,TRISD
;.EQU CS6_O_P		,5
;.EQU CS6_IO_P		,5


;.EQU CS7_O		,LATC
;.EQU CS7_IO		,TRISC
;.EQU CS7_O_P		,8
;.EQU CS7_IO_P		,8


;.EQU DB0_O		,LATC
;.EQU DB0_I		,PORTC
;.EQU DB0_IO		,TRISC
;.EQU DB0_O_P		,0
;.EQU DB0_I_P		,0
;.EQU DB0_IO_P		,0
;/
;.EQU DB1_O		,LATC
;.EQU DB1_I		,PORTC
;.EQU DB1_IO		,TRISC
;.EQU DB1_O_P		,1
;.EQU DB1_I_P		,1
;.EQU DB1_IO_P		,1
;/
;.EQU DB2_O		,LATC
;.EQU DB2_I		,PORTC
;.EQU DB2_IO		,TRISC
;.EQU DB2_O_P		,2
;.EQU DB2_I_P		,2
;.EQU DB2_IO_P		,2
;/
;.EQU DB3_O		,LATC
;.EQU DB3_I		,PORTC
;.EQU DB3_IO		,TRISC
;.EQU DB3_O_P		,3
;.EQU DB3_I_P		,3
;.EQU DB3_IO_P		,3
;/
;.EQU DB4_O		,LATC
;.EQU DB4_I		,PORTC
;.EQU DB4_IO		,TRISC
;;EQU DB4_O_P		,4
;.EQU DB4_I_P		,4
;.EQU DB4_IO_P		,4
;/
;.EQU DB5_O		,LATC
;.EQU DB5_I		,PORTC
;.EQU DB5_IO		,TRISC
;.EQU DB5_O_P		,5
;.EQU DB5_I_P		,5
;.EQU DB5_IO_P		,5
;/
;.EQU DB6_O		,LATC
;.EQU DB6_I		,PORTC
;.EQU DB6_IO		,TRISC
;.EQU DB6_O_P		,6
;.EQU DB6_I_P		,6
;.EQU DB6_IO_P		,6
;/
;.EQU DB7_O		,LATC
;.EQU DB7_I		,PORTC
;.EQU DB7_IO		,TRISC
;.EQU DB7_O_P		,7
;.EQU DB7_I_P		,7
;.EQU DB7_IO_P		,7
;/









;.EQU LCDE0_I		,PORTG
;.EQU LCDE0_IO		,TRISG
;.EQU LCDE0_I_P		,9
;.EQU LCDE0_IO_P		,9

;.EQU LCDRS0_I		,PORTG
;.EQU LCDRS0_IO		,TRISG
;.EQU LCDRS0_I_P		,8 
;.EQU LCDRS0_IO_P	,8 

;.EQU LCDE1_I		,PORTG
;.EQU LCDE1_IO		,TRISG
;.EQU LCDE1_I_P		,7
;.EQU LCDE1_IO_P		,7

;.EQU LCDRS1_I		,PORTG
;.EQU LCDRS1_IO		,TRISG
;.EQU LCDRS1_I_P		,6 
;.EQU LCDRS1_IO_P	,6 


.EQU FSRT_O		,LATC
.EQU FSRT_IO		,TRISC
.EQU FSRT_O_P		,13
.EQU FSRT_IO_P		,13

.EQU PCMR0_O		,LATB
.EQU PCMR0_IO		,TRISB
.EQU PCMR0_O_P		,7 
.EQU PCMR0_IO_P		,7 

.EQU PCMR1_O		,LATC
.EQU PCMR1_IO		,TRISC
.EQU PCMR1_O_P		,10
.EQU PCMR1_IO_P		,10

.EQU PCMR2_O		,LATB
.EQU PCMR2_IO		,TRISB
.EQU PCMR2_O_P		,6 
.EQU PCMR2_IO_P		,6 

.EQU PCMR3_O		,LATB
.EQU PCMR3_IO		,TRISB
.EQU PCMR3_O_P		,5 
.EQU PCMR3_IO_P		,5 

.EQU PCMR4_O		,LATD
.EQU PCMR4_IO		,TRISD
.EQU PCMR4_O_P		,8 
.EQU PCMR4_IO_P		,8 


.EQU PCMT0_I		,PORTF
.EQU PCMT0_IO		,TRISF
.EQU PCMT0_I_P		,0 
.EQU PCMT0_IO_P		,0 

.EQU PCMT1_I		,PORTF
.EQU PCMT1_IO		,TRISF
.EQU PCMT1_I_P		,1 
.EQU PCMT1_IO_P		,1 

.EQU PCMT2_I		,PORTB
.EQU PCMT2_IO		,TRISB
.EQU PCMT2_I_P		,10
.EQU PCMT2_IO_P		,10

.EQU PCMT3_I		,PORTB
.EQU PCMT3_IO		,TRISB
.EQU PCMT3_I_P		,11
.EQU PCMT3_IO_P		,11

.EQU PCMT4_I		,PORTB
.EQU PCMT4_IO		,TRISB
.EQU PCMT4_I_P		,12
.EQU PCMT4_IO_P		,12

.EQU PUI_O		,LATB
.EQU PUI_IO		,TRISB
.EQU PUI_O_P		,13
.EQU PUI_IO_P		,13


;.EQU VOLADJ1_I		,PORTE
;.EQU VOLADJ1_IO	,TRISE
;.EQU VOLADJ1_I_P	,12
;.EQU VOLADJ1_IO_P	,12

;.EQU VOLADJ2_I		,PORTE
;.EQU VOLADJ2_IO	,TRISE
;.EQU VOLADJ2_I_P	,13
;.EQU VOLADJ2_IO_P	,13

.EQU LED_O		,LATB
.EQU LED_IO		,TRISB
.EQU LED_O_P		,14
.EQU LED_IO_P		,14



;FLAGA
.EQU U1RXT_F		,FLAGA
.EQU U1RXT_F_P		,0
.EQU U1RX_BUFAB_F	,FLAGA
.EQU U1RX_BUFAB_F_P	,1
.EQU U1RX_PACKA_F	,FLAGA
.EQU U1RX_PACKA_F_P	,2
.EQU U1RX_PACKB_F	,FLAGA
.EQU U1RX_PACKB_F_P	,3
.EQU U1TX_EN_F		,FLAGA
.EQU U1TX_EN_F_P	,4
.EQU U1TX_WAITTX_F	,FLAGA
.EQU U1TX_WAITTX_F_P	,5
.EQU LCD0HL_F		,FLAGA
.EQU LCD0HL_F_P		,6
.EQU LCD1HL_F		,FLAGA
.EQU LCD1HL_F_P		,7
.EQU MINUS_F		,FLAGA
.EQU MINUS_F_P		,8
.EQU U1TXINF_EN_F	,FLAGA
.EQU U1TXINF_EN_F_P	,9
.EQU CFGRJ_F		,FLAGA
.EQU CFGRJ_F_P		,10
.EQU CFGRSP_F		,FLAGA
.EQU CFGRSP_F_P  	,11

.EQU SPCHA_F		,FLAGA
.EQU SPCHA_F_P  	,12
.EQU SPCHB_F		,FLAGA
.EQU SPCHB_F_P  	,13



;FLAGB
.EQU U2RXT_F		,FLAGB
.EQU U2RXT_F_P		,0
.EQU U2RX_BUFAB_F	,FLAGB
.EQU U2RX_BUFAB_F_P	,1
.EQU U2RX_PACKA_F	,FLAGB
.EQU U2RX_PACKA_F_P	,2
.EQU U2RX_PACKB_F	,FLAGB
.EQU U2RX_PACKB_F_P	,3
.EQU U2TX_EN_F		,FLAGB
.EQU U2TX_EN_F_P	,4
.EQU U2TX_WAITTX_F	,FLAGB
.EQU U2TX_WAITTX_F_P	,5
.EQU U2TXINF_EN_F	,FLAGB
.EQU U2TXINF_EN_F_P	,6





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
POWER_ON:			;;
        MOV #0x1E00,W15       	;;Initalize the Stack Pointer
        MOV #0x1FFE,W0        	;;Initialize the Stack Pointer Limit Register
        MOV W0,SPLIM		;;
        CALL CLR_WREG 		;;
	CALL INIT_IO		;;
	CALL INIT_AD
	CALL INIT_RAM		;;
	CALL INIT_TEST		;;
	CALL INIT_SIO		;;
	CALL INIT_OSC
	MOV #10000,W0
	CALL DLYX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL INIT_TIMER			;;
	CALL INIT_UART1			;;
	CALL INIT_UART2			;;
	CALL INIT_IC			;;
	CALL INIT_INT			;;
	GOTO MAIN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	CLR ANSELC			;;
	CLR ANSELE			;;
	RETURN
;	BSET ANSELE,#12			;;
;	BSET ANSELE,#13			;;
	MOV #0x0004,W0			;;AUTO SAMPLE	
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON1			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON2			;;
	MOV #0x000F,W0			;;	
	MOV W0,AD1CON3			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON4			;;
	MOV #12,W0			;;	
	MOV W0,AD1CHS0			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CHS123		;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CSSH			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CSSL			;;
	BSET AD1CON1,#ADON		;;
	SETM CONVAD_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPCH_PRG:				;;
	BTFSC SPCHA_I			;;
	BRA SPCH_PRG_A 			;;
	BTFSC SPCHB_I			;;
	BRA SPCH_PRG_B 			;;
	CLR SPOUT0			;;
	CLR SPOUT1			;;
	CLR SPOUT2			;;
	CLR SPOUT3			;;
	BCF SPCHA_F			;;
	BCF SPCHB_F			;;
	BTSS TMR2_FLAG,#8		;;2MS
 	RETURN				;;
	CP0 GAINA 			;;
	BRA Z,$+4			;;
	DEC GAINA			;;
 	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPCH_PRG_A:				;;
	BTFSS SPCHA_F			;;
	BRA SPCH_PRG_A1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC TMR2_FLAG,#8		;;2MS
	INC GAINA			;;
	MOV #256,W0			;;
	CP GAINA			;;
	BRA LTU,$+6			;;
	MOV #255,W0			;;
	MOV W0,GAINA			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0003,W0			;;
	MOV W0,SPOUT0			;;
	MOV W0,SPOUT1			;;
	MOV W0,SPOUT2			;;
	MOV W0,SPOUT3			;;
	RETURN				;;
SPCH_PRG_A1:				;;
	BTSS TMR2_FLAG,#8		;;2MS
	RETURN				;;
	CP0 GAINA 			;;
	BRA Z,$+6			;;
	DEC GAINA			;;
	RETURN				;;
	BSF SPCHA_F			;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPCH_PRG_B:				;;
	BTFSS SPCHB_F			;;
	BRA SPCH_PRG_B1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC TMR2_FLAG,#8		;;2MS
	INC GAINA			;;
	MOV #256,W0			;;
	CP GAINA			;;
	BRA LTU,$+6			;;
	MOV #255,W0			;;
	MOV W0,GAINA			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x000C,W0			;;
	MOV W0,SPOUT0			;;
	MOV W0,SPOUT1			;;
	MOV W0,SPOUT2			;;
	MOV W0,SPOUT3			;;
	RETURN				;;
SPCH_PRG_B1:				;;
	BTSS TMR2_FLAG,#8		;;2MS
	RETURN				;;
	CP0 GAINA 			;;
	BRA Z,$+6			;;
	DEC GAINA			;;
	RETURN				;;
	BSF SPCHB_F			;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	

GAIN_PRG:
	MOV GAINA,W0
	MOV W0,SPGAIN0
	MOV W0,SPGAIN1
	MOV W0,SPGAIN2
	MOV W0,SPGAIN3

	MOV W0,SPGAIN_BUF0
	MOV W0,SPGAIN_BUF1
	MOV W0,SPGAIN_BUF2
	MOV W0,SPGAIN_BUF3
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	CALL INIT_TEST			;;
MAIN_LOOP:				;;
	CLRWDT				;;
	CALL TMR2PRG			;;	
	CALL MAINT_PRG			;;
	CALL SPCH_PRG			;;
	CALL GAIN_PRG			;;	
	CALL CHK_U1RX			;;	
	CALL U1TX_INF			;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAINT_PRG:				;;
	BTSC TMR2_FLAG,#15		;;1.3MS
	TG LED_O			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONVERT_AD:				;;
	MOV #255,W0			;;
	CP SPGAIN_BUF0			;;
	BRA GEU,$+8			;;
	MOV SPGAIN_BUF0,W0		;;
	MOV W0,SPGAIN0			;;
	BRA $+6				;;
	MOV VR1V,W0			;;
	MOV W0,SPGAIN0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	MOV #255,W0			;;
	CP SPGAIN_BUF1			;;
	BRA GEU,$+8			;;
	MOV SPGAIN_BUF1,W0		;;
	MOV W0,SPGAIN1			;;
	BRA $+6				;;
	MOV VR1V,W0			;;
	MOV W0,SPGAIN1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	MOV #255,W0			;;
	CP SPGAIN_BUF2			;;
	BRA GEU,$+8			;;
	MOV SPGAIN_BUF2,W0		;;
	MOV W0,SPGAIN2			;;
	BRA $+6				;;
	MOV VR2V,W0			;;
	MOV W0,SPGAIN2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	MOV #255,W0			;;
	CP SPGAIN_BUF3			;;
	BRA GEU,$+8			;;
	MOV SPGAIN_BUF3,W0		;;
	MOV W0,SPGAIN3			;;
	BRA $+6				;;
	MOV VR2V,W0			;;
	MOV W0,SPGAIN3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	MOV SPGAIN_BUF4,W0		;;
	MOV W0,SPGAIN4			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	INC CONVAD_CNT			;;
	MOV #6,W0			;;
	CP CONVAD_CNT			;;	
	BRA LTU,$+4			;;
	CLR CONVAD_CNT	 		;;
	MOV CONVAD_CNT,W0 		;;
	BRA W0				;;
	BRA CONV_J0			;;
	BRA CONV_J1			;;
	BRA CONV_J2			;;
	BRA CONV_J3			;;
	BRA CONV_J4			;;
	BRA CONV_J5			;;
CONV_J0:				;;
	MOV #12,W0			;;	
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
CONV_J3:				;;
	MOV #13,W0			;;	
	MOV W0,AD1CHS0			;;
	BSET AD1CON1,#SAMP		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONV_J4:				;;
	BCLR AD1CON1,#SAMP		;;
	RETURN				;;
CONV_J5:				;;
	BTSS AD1CON1,#DONE		;;
	RETURN				;;
	MOV ADC1BUF0,W0			;;
	MOV W0,VR2BUF			;;
	BCLR AD1CON1,#DONE		;;
	RRC VR2BUF			;;
	RRC VR2BUF			;;
	MOV VR2BUF,W0			;;	
	AND #255,W0			;;
	SWAP W0				;;
	MOV #212,W2			;;
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	MOV W0,VR2V			;;
	SWAP W0				;;
	AND #255,W0			;;
	BRA Z,$+6			;;
	MOV #255,W0			;;
	MOV W0,VR2V			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




	





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
DEBUG_LCD:				;;
	MOV #0x20,W0			;;
	CP W2,W0			;;
	BRA LTU,DEBUG_LCD_1		;;	
	MOV #0x7F,W0			;;
	CP W2,W0			;;
	BRA GTU,DEBUG_LCD_1		;;
	RETURN				;;
DEBUG_LCD_1:				;;
	MOV DEBUG_LCD_CNT,W0		;;
	AND #255,W0			;;	
	MOV #DEBUG_LCD_BUF,W3		;;
	ADD W0,W3,W3			;;
	ADD W0,W3,W3			;;
	MOV W2,[W3]			;;
	INC DEBUG_LCD_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECLCD0:				;;
	MOV LCD0B_PTR,W0		;;
	AND #0x1F,W0			;;
	CP LCD0A_PTR			;;
	BRA NZ,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LCD0_TEMP,W1		;;	
	MOV LCD0B_PTR,W0		;;	
	AND #0x1F,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W2			;;
	INC LCD0B_PTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0101,W0			;;
	CP W0,W2			;;
	BRA NZ,DECLCD0_1		;;
	CALL CLR_LCD0			;;
	BRA DECLCD0			;;
DECLCD0_1:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFFE0,W0			;;
	AND W0,W2,W3			;;
	MOV #0x0180,W0			;;
	CP W0,W3			;;
	BRA NZ,DECLCD0_2		;;
	CALL GOTOXY_LCD0		;;
	BRA DECLCD0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECLCD0_2:				;;
	BTSC W2,#8			;;
	RETURN				;;
	MOV #LCD0_BUF,W1		;;
	MOV LCD0_INX,W0			;;
	AND #0x1F,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TRANS_FASC			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV W2,[W1]			;;
	INC LCD0_INX			;;
	CALL DEBUG_LCD			;;
	BRA DECLCD0			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
TRANS_FASC:				;;
	MOV #0x00,W0			;;
	CP W0,W2			;;
	BRA NZ,$+6			;;
	MOV #0x3E,W2			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF7,W0			;;
	CP W0,W2			;;
	BRA NZ,$+6			;;
	MOV #'*',W2			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xD7,W0			;;
	CP W0,W2			;;
	BRA NZ,$+6			;;
	MOV #'.',W2			;;
	RETURN				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECLCD1:				;;
	MOV LCD1B_PTR,W0		;;
	AND #0x1F,W0			;;
	CP LCD1A_PTR			;;
	BRA NZ,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LCD1_TEMP,W1		;;	
	MOV LCD1B_PTR,W0		;;	
	AND #0x1F,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W2			;;
	INC LCD1B_PTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0101,W0			;;
	CP W0,W2			;;
	BRA NZ,DECLCD1_1		;;
	CALL CLR_LCD1			;;
	BRA DECLCD1			;;
DECLCD1_1:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFFE0,W0			;;
	AND W0,W2,W3			;;
	MOV #0x0180,W0			;;
	CP W0,W3			;;
	BRA NZ,DECLCD1_2		;;
	CALL GOTOXY_LCD1		;;
	BRA DECLCD1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECLCD1_2:				;;
	BTSC W2,#8			;;
	RETURN				;;
	MOV #LCD1_BUF,W1		;;
	MOV LCD1_INX,W0			;;
	AND #0x1F,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TRANS_FASC			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV W2,[W1]			;;
	INC LCD1_INX			;;
	BRA DECLCD1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GOTOXY_LCD0:				;;
	MOV #0x001F,W0			;;
	AND W0,W2,W0			;;
	MOV W0,LCD0_INX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_LCD0:				;;
	CLR LCD0_INX			;;
	MOV #20,W2			;;
	MOV #LCD0_BUF,W1		;;
CLR_LCD0_1:				;;
	MOV #0x20,W0			;;
	MOV W0,[W1++]			;;
	DEC W2,W2			;;	
	BRA NZ,CLR_LCD0_1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GOTOXY_LCD1:				;;
	MOV #0x001F,W0			;;
	AND W0,W2,W0			;;
	MOV W0,LCD1_INX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_LCD1:				;;
	CLR LCD1_INX			;;
	MOV #20,W2			;;
	MOV #LCD1_BUF,W1		;;
CLR_LCD1_1:				;;
	MOV #0x20,W0			;;
	MOV W0,[W1++]			;;
	DEC W2,W2			;;	
	BRA NZ,CLR_LCD1_1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	

	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TEST:				;;
	MOV #0x0000,W0			;;
	MOV W0,OUTFLAG0			;;
	MOV #0x0000,W0			;;
	MOV W0,OUTFLAG1			;;
	MOV #0x0000,W0			;;
	MOV W0,OUTFLAG2			;;
	MOV #0x0000,W0			;;
	MOV W0,OUTFLAG3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0			;;
	MOV W0,INFLAG0			;;
	MOV #0x0000,W0			;;
	MOV W0,INFLAG1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0			;;
	MOV W0,SPOUT0			;;
	MOV #0x0000,W0			;;
	MOV W0,SPOUT1			;;
	MOV #0x0000,W0			;;
	MOV W0,SPOUT2			;;
	MOV #0x0000,W0			;;
	MOV W0,SPOUT3			;;
	MOV #0x0000,W0			;;
	MOV W0,SPOUT4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LCD0_BUF,W3		;;	
	MOV #20,W4			;;
	MOV #0x41,W5			;;
INIT_TEST_1:				;;
	MOV #0x20,W5			;;			
	MOV W5,[W3++]			;;
	INC W5,W5			;;
	DEC W4,W4			;;	
	BRA NZ,INIT_TEST_1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LCD1_BUF,W3		;;	
	MOV #20,W4			;;
	MOV #0x41,W5			;;
INIT_TEST_2:				;;
	MOV #0x20,W5			;;			
	MOV W5,[W3++]			;;
	INC W5,W5			;;
	DEC W4,W4			;;	
	BRA NZ,INIT_TEST_2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #TTONE_BUF,W1		;;	
	MOV #0x043C,W0			;;
	MOV W0,[W1++]			;;
	MOV #0x0A39,W0			;;
	MOV W0,[W1++]			;;
	MOV #0x0A39,W0			;;
	MOV W0,[W1++]			;;
	MOV #0x043C,W0			;;
	MOV W0,[W1++]			;;
	MOV #0xFBC4,W0			;;
	MOV W0,[W1++]			;;
	MOV #0xF5C7,W0			;;
	MOV W0,[W1++]			;;
	MOV #0xF5C7,W0			;;
	MOV W0,[W1++]			;;
	MOV #0xFBC4,W0			;;
	MOV W0,[W1++]			;;

	RETURN


	MOV #TTONE_BUF,W1		;;	
	MOV #1,W0			;;
	MOV W0,[W1++]			;;
	MOV #1,W0			;;
	MOV W0,[W1++]			;;
	MOV #1,W0			;;
	MOV W0,[W1++]			;;
	MOV #1,W0			;;
	MOV W0,[W1++]			;;
	MOV #0xFFFF,W0			;;
	MOV W0,[W1++]			;;
	MOV #0xFFFF,W0			;;
	MOV W0,[W1++]			;;
	MOV #0xFFFF,W0			;;
	MOV W0,[W1++]			;;
	MOV #0xFFFF,W0			;;
	MOV W0,[W1++]			;;


	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;4


	
	


	


; 0=10S
; 1=20uS
; 2=40S
; 3=81uS
; 4=162uS
; 5=325uS
; 6=650uS
; 7=1.3MS
; 8=2.6
; 9=5.2 
;10=10.4
;11=32mS
;12=64mS
;13=128mS
;14=256mS
;15=512mS
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
INIT_TIMER:				;;
	MOV #0xA030,W0			;;
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
	MOV #0x0018,W0		;;RPI24 U1RX
	MOV W0,RPINR18		;;
	MOV #0xFF00,W0		;;
	AND RPOR1		;;
	MOV #0x0001,W0		;;RP36 U1TX 
	IOR RPOR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #0x0019,W0		;;RPI25 U2RX
;	MOV W0,RPINR19		;;
;	MOV #0xFF00,W0		;;
;	AND RPOR0		;;
;	MOV #0x0003,W0		;;RP20 U2TX 
;	IOR RPOR0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #121,W0		;;
;	SWAP W0			;;	
;	MOV W0,RPINR0		;;INT1
;	MOV #119,W0		;;
;	MOV.B WREG,RPINR1	;;INT2
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR3		;;
	MOV #0x3100,W0		;;REFCLKO
	IOR RPOR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0029,W0		;;IC1 RP41
	MOV.B WREG,RPINR7	;;
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


INIT_IC:
	MOV #0x0003,W0		
	MOV W0,IC1CON1
	MOV #0x0001,W0		
	MOV W0,IC2CON1
	MOV #0x0001,W0		
	MOV W0,IC3CON1
	RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_INT:				;;
	BCLR IPC5,#2 			;;
	BSET IPC5,#1 			;;
	BCLR IPC5,#0 			;;
	BSET INTCON2,#INT1EP		;;
	BCLR IFS1,#INT1IF		;;		
	BSET IEC1,#INT1IE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC7,#6 			;;
	BSET IPC7,#5 			;;
	BCLR IPC7,#4 			;;
	BSET INTCON2,#INT2EP		;;
	BCLR IFS1,#INT2IF		;;		
	BSET IEC1,#INT2IE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET IPC0,#6 			;;
	BCLR IPC0,#5 			;;
	BCLR IPC0,#4 			;;
	BCLR IFS0,#IC1IF		;;		
	BSET IEC0,#IC1IE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC1,#6 			;;
	BSET IPC1,#5 			;;
	BSET IPC1,#4 			;;
	BCLR IFS0,#IC2IF		;;		
	BSET IEC0,#IC2IE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC9,#6 			;;
	BSET IPC9,#5 			;;
	BSET IPC9,#4 			;;
	BCLR IFS2,#IC3IF		;;		
	BSET IEC2,#IC3IE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;FCY=65.536mHZ
;UXBRG=FCY/(4*BOUDRATE) -1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART1:				;;
	MOV #141,W0	;115200		;;
;	MOV #1705,W0	;9600		;;
	MOV W0,U1BRG			;;
	MOV #0x8008,W0			;;
	MOV W0,U1MODE			;;
	MOV #0x0400,W0			;;
	MOV W0,U1STA 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC3,#2 			;;
	BCLR IPC3,#1 			;;
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
	BCLR IPC2,#13 			;;
	BSET IPC2,#12 			;;
	BCLR IFS0,#U1RXIF		;;
	BSET IEC0,#U1RXIE		;;URXINT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART2:				;;
	BCLR IEC1,#U2TXIE		;;UTXINT
	BCLR IEC1,#U2RXIE		;;URXINT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #141,W0	;115200		;;
	BTFSC CFGRJ_F			;;
	MOV #1705,W0	;9600		;;
	MOV W0,U2BRG			;;
	MOV #0x8008,W0			;;
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
	BCLR IPC7,#9  			;;
	BSET IPC7,#8  			;;
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

INIT_OSC:
	CLR CLKDIV			;;
	MOV #70,W0
	MOV W0,PLLFBD			;;PLLDIV
	MOV #0x01,W0			;;
	MOV #0,W0			;;BIT40:PRE
	IOR CLKDIV			;;
	MOV #0x0000,W0			;;BIT76:POST
	IOR CLKDIV			;;
	MOV #0x0000,W0			;;BIT10-8=FRCDIV
	IOR CLKDIV			;;
	MOV #1,W0			;;FRC
	CALL OSC_PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #20,W0			;;MAX 31
	COM W0,W0			;;
	INC W0,W0			;;
	MOV W0,OSCTUN 


;	MOV #0x8E00,W0			;;8K
	MOV #0x8900,W0			;;256K
	MOV W0,REFOCON 
	RETURN	
TEST_OSC:
	CLRWDT
	TG TEST_O
	TG TEST_O
	TG TEST_O
	TG TEST_O	
	TG TEST_O
	TG TEST_O
	TG TEST_O
	TG TEST_O	
	BRA TEST_OSC

TEST_U1TX:
	CLRWDT
	MOV #0xAB,W0
	MOV W0,U1TXREG			;;
;	TG U1TX_O
	MOV #10000,W0
	CALL DLYX
	BRA TEST_U1TX

INIT_RAM:
	CLR FLAGA
	CLR FLAGB
	CLR FLAGC
	CLR OUTFLAG0
	CLR OUTFLAG1
	CLR OUTFLAG2
	CLR OUTFLAG3

	CLR LCD0A_PTR
	CLR LCD0B_PTR
	CLR LCD1A_PTR
	CLR LCD1B_PTR
	BCF LCD0HL_F		
	BCF LCD1HL_F		
	CALL CLR_LCD0		
	CALL CLR_LCD1		
	
	CLR FREEK0_TIM
	CLR FREEK1_TIM

	CLR CODEC_TIM
	
	CLR DEBUG_LCD_CNT

	CLR SPGAIN0
	CLR SPGAIN1
	CLR SPGAIN2
	CLR SPGAIN3
	CLR SPGAIN4

	CLR SPGAIN_BUF0
	CLR SPGAIN_BUF1
	CLR SPGAIN_BUF2
	CLR SPGAIN_BUF3
	CLR SPGAIN_BUF4
	
	CLR GAINA

	MOV #255,W0
	MOV W0,SPGAIN0 
	MOV W0,SPGAIN1 
	MOV W0,SPGAIN2 
	MOV W0,SPGAIN3 
	MOV W0,SPGAIN4 
	

	RETURN

INIT_IO:
	MOV #0x00FF,W0
	IOR TRISC 


	BSF U1TX_O
	BSF U1RX_IO
	BCF U1TX_IO


	BCF TEST_O	
	BCF TEST_IO


 	BCF FSRT_O
	BCF FSRT_IO

	BCF PCMR0_O
	BCF PCMR1_O
	BCF PCMR2_O
	BCF PCMR3_O
	BCF PCMR4_O

	BCF PCMR0_IO
	BCF PCMR1_IO
	BCF PCMR2_IO
	BCF PCMR3_IO
	BCF PCMR4_IO

	BSF PCMT0_IO
	BSF PCMT1_IO
	BSF PCMT2_IO
	BSF PCMT3_IO
	BSF PCMT4_IO

	BSF PUI_O
	BCF PUI_IO		

	BCF LED_O
	BCF LED_IO		
	
	BSF SPCHA_IO
	BSF SPCHB_IO

	RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_START:				;;
	BCF U1TX_EN_F			;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	CLR U1TX_LEN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	MOV W0,U1TX_CHKSUM0		;;
	CLR U1TX_CHKSUM1		;;
	MOV #U1TX_BUF,W1		;;
	MOV #0xEA,W0			;;
	CALL LOAD_U1BYTE_A		;;
	MOV U1TX_LEN,W0			;;
	CALL LOAD_U1BYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1BYTE_A:				;;
	MOV W0,[W1++]			;;
	INC U1TX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1BYTE_B:				;;
	PUSH W2				;;
	AND #255,W0			;;
	MOV #0xEA,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_U1BYTE_B1		;;	
	MOV #0xEB,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_U1BYTE_B1		;;	
	MOV #0xEC,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_U1BYTE_B1		;;	
	MOV W0,[W1++]			;;
	INC U1TX_BTX			;;
	POP W2				;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1BYTE_B1:				;;
	MOV #0xEC,W2			;;
	MOV W2,[W1++]			;;
	INC U1TX_BTX			;;
	MOV #0xAB,W2			;;
	XOR W2,W0,W0			;;
	MOV W0,[W1++]			;;
	INC U1TX_BTX			;;
	POP W2				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1BYTE_C:				;;
	XOR U1TX_CHKSUM0		;;
	ADD U1TX_CHKSUM1		;;
	INC U1TX_LEN			;; 
	CALL LOAD_U1BYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_END:				;;
	MOV U1TX_CHKSUM0,W0		;;
	CALL LOAD_U1BYTE_B		;;
	MOV U1TX_CHKSUM1,W0		;;
	CALL LOAD_U1BYTE_B		;;
	MOV #0xEB,W0			;;
	CALL LOAD_U1BYTE_A		;;
	MOV #U1TX_BUF+2,W1		;;
	MOV U1TX_LEN,W0			;;
	CALL LOAD_U1BYTE_B		;;
	DEC U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BSET IFS0,#U1TXIF		;;
	BCF U1TX_WAITTX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_TEST:				;;
	BCF U2TX_EN_F			;;
	CLR U2TX_BTX			;;
	CLR U2TX_BCNT			;;
	CLR U2TX_LEN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00,W0			;;
	MOV W0,U2TX_CHKSUM0		;;
	MOV #U2TX_BUF,W1		;;
	MOV #'1',W0			;;
	CALL LOAD_U2BYTE_A		;;
	MOV #'2',W0			;;
	CALL LOAD_U2BYTE_A		;;
	CALL U2CFGTX_END		;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2CFGTX_START:				;;
	BCF U2TX_EN_F			;;
	CLR U2TX_BTX			;;
	CLR U2TX_BCNT			;;
	CLR U2TX_LEN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00,W0			;;
	MOV W0,U2TX_CHKSUM0		;;
	MOV #U2TX_BUF,W1		;;
	MOV #0x55,W0			;;
	CALL LOAD_U2BYTE_A		;;
	MOV #0xAA,W0			;;
	CALL LOAD_U2BYTE_A		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2CFGTX_END:				;;
	MOV U2TX_CHKSUM0,W0		;;
	CALL LOAD_U2BYTE_A		;;
	CLR U2TX_BCNT			;;
	BSF U2TX_EN_F			;;
	BSET IFS1,#U2TXIF		;;
	BCF U2TX_WAITTX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_START:				;;
	BCF U2TX_EN_F			;;
	CLR U2TX_BTX			;;
	CLR U2TX_BCNT			;;
	CLR U2TX_LEN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	MOV W0,U2TX_CHKSUM0		;;
	CLR U2TX_CHKSUM1		;;
	MOV #U2TX_BUF,W1		;;
	MOV #0xEA,W0			;;
	CALL LOAD_U2BYTE_A		;;
	MOV U2TX_LEN,W0			;;
	CALL LOAD_U2BYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U2BYTE_AC:				;;
	ADD U2TX_CHKSUM0		;;
	MOV W0,[W1++]			;;
	INC U2TX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U2BYTE_A:				;;
	MOV W0,[W1++]			;;
	INC U2TX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U2BYTE_B:				;;
	PUSH W2				;;
	AND #255,W0			;;
	MOV #0xEA,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_U2BYTE_B1		;;	
	MOV #0xEB,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_U2BYTE_B1		;;	
	MOV #0xEC,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_U2BYTE_B1		;;	
	MOV W0,[W1++]			;;
	INC U2TX_BTX			;;
	POP W2				;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U2BYTE_B1:				;;
	MOV #0xEC,W2			;;
	MOV W2,[W1++]			;;
	INC U2TX_BTX			;;
	MOV #0xAB,W2			;;
	XOR W2,W0,W0			;;
	MOV W0,[W1++]			;;
	INC U2TX_BTX			;;
	POP W2				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U2BYTE_C:				;;
	XOR U2TX_CHKSUM0		;;
	ADD U2TX_CHKSUM1		;;
	INC U2TX_LEN			;; 
	CALL LOAD_U2BYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_END:				;;
	MOV U2TX_CHKSUM0,W0		;;
	CALL LOAD_U2BYTE_B		;;
	MOV U2TX_CHKSUM1,W0		;;
	CALL LOAD_U2BYTE_B		;;
	MOV #0xEB,W0			;;
	CALL LOAD_U2BYTE_A		;;
	MOV #U2TX_BUF+2,W1		;;
	MOV U2TX_LEN,W0			;;
	CALL LOAD_U2BYTE_B		;;
	DEC U2TX_BTX			;;
	CLR U2TX_BCNT			;;
	BSF U2TX_EN_F			;;
	BSET IFS1,#U2TXIF		;;
	BCF U2TX_WAITTX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_RSP:				;;
	BTFSC U1TX_EN_F			;;
	RETURN				;;
	CALL U1TX_START			;;
	MOV #0xA1,W0			;;				
	CALL LOAD_U1BYTE_C		;;
	MOV #0x00,W0			;;
	CALL LOAD_U1BYTE_C		;;
	CALL U1TX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_RSP:				;;
	BTFSC U2TX_EN_F			;;
	RETURN				;;
	CALL U2TX_START			;;
	MOV #0xA1,W0			;;				
	CALL LOAD_U2BYTE_C		;;
	MOV #0x00,W0			;;
	CALL LOAD_U2BYTE_C		;;
	CALL U2TX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_INF:				;;
	BTSS TMR2_FLAG,#12		;;16MS
	RETURN				;;
	BTFSS U1TXINF_EN_F		;;
	RETURN				;;
	BTFSC U1TX_EN_F			;;
	RETURN				;;
	CALL U1TX_START			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA1,W0			;;				
	CALL LOAD_U1BYTE_C		;;
	MOV #0x02,W0			;;
	CALL LOAD_U1BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OUTFLAG0,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV OUTFLAG0,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OUTFLAG1,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV OUTFLAG1,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OUTFLAG2,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV OUTFLAG2,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OUTFLAG3,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV OUTFLAG3,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV INFLAG0,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV INFLAG0,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV INFLAG1,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV INFLAG1,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPOUT0,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV SPOUT0,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;

	MOV SPOUT1,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV SPOUT1,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;

	MOV SPOUT2,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV SPOUT2,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;

	MOV SPOUT3,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV SPOUT3,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;

	MOV SPOUT4,W0			;;
	CALL LOAD_U1BYTE_C		;;
	MOV SPOUT4,W0			;;
	SWAP W0				;;
	CALL LOAD_U1BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LCD0_BUF,W3		;;	
	MOV #20,W4			;;
U1TX_INF_1:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U1BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U1TX_INF_1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LCD1_BUF,W3		;;	
	MOV #20,W4			;;
U1TX_INF_2:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U1BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U1TX_INF_2		;;

	MOV #SPGAIN_BUF0,W3		;;	
	MOV #5,W4			;;
U1TX_INF_3:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U1BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U1TX_INF_3		;;

	MOV #MICCUT_BUF0,W3		;;	
	MOV #5,W4			;;
U1TX_INF_4:				;;
	MOV [W3++],W0			;;
	ASR W0,#4,W0			;;
	CALL LOAD_U1BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U1TX_INF_4		;;

	MOV #MICBGN_BUF0,W3		;;	
	MOV #5,W4			;;
U1TX_INF_5:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U1BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U1TX_INF_5		;;

	MOV #MICDLY_BUF0,W3		;;	
	MOV #5,W4			;;
U1TX_INF_6:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U1BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U1TX_INF_6		;;
	
	CALL U1TX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_INF:				;;
;	BTSS TMR2_FLAG,#12		;;
	BTSS TMR2_FLAG,#15		;;
	RETURN				;;
	BTFSS U2TXINF_EN_F		;;
	RETURN				;;
	BTFSC U2TX_EN_F			;;
	RETURN				;;
	CALL U2TX_TEST			;;
	RETURN				;;

	CALL U2CFGTX_START
	


	CALL U2TX_START			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA1,W0			;;				
	CALL LOAD_U2BYTE_C		;;
	MOV #0x02,W0			;;
	CALL LOAD_U2BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OUTFLAG0,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV OUTFLAG0,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OUTFLAG1,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV OUTFLAG1,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OUTFLAG2,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV OUTFLAG2,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OUTFLAG3,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV OUTFLAG3,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV INFLAG0,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV INFLAG0,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV INFLAG1,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV INFLAG1,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPOUT0,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV SPOUT0,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;

	MOV SPOUT1,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV SPOUT1,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;

	MOV SPOUT2,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV SPOUT2,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;

	MOV SPOUT3,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV SPOUT3,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;

	MOV SPOUT4,W0			;;
	CALL LOAD_U2BYTE_C		;;
	MOV SPOUT4,W0			;;
	SWAP W0				;;
	CALL LOAD_U2BYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LCD0_BUF,W3		;;	
	MOV #20,W4			;;
U2TX_INF_1:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U2BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U2TX_INF_1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LCD1_BUF,W3		;;	
	MOV #20,W4			;;
U2TX_INF_2:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U2BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U2TX_INF_2		;;

	MOV #SPGAIN_BUF0,W3		;;	
	MOV #5,W4			;;
U2TX_INF_3:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U2BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U2TX_INF_3		;;

	MOV #MICCUT_BUF0,W3		;;	
	MOV #5,W4			;;
U2TX_INF_4:				;;
	MOV [W3++],W0			;;
	ASR W0,#4,W0			;;
	CALL LOAD_U2BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U2TX_INF_4		;;

	MOV #MICBGN_BUF0,W3		;;	
	MOV #5,W4			;;
U2TX_INF_5:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U2BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U2TX_INF_5		;;

	MOV #MICDLY_BUF0,W3		;;	
	MOV #5,W4			;;
U2TX_INF_6:				;;
	MOV [W3++],W0			;;
	CALL LOAD_U2BYTE_C		;;
	DEC W4,W4			;;	
	BRA NZ,U2TX_INF_6		;;
	
	CALL U2TX_END			;;
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
	MOV #U1RX_BUFA,W1		;;
	BRA CHK_U1RX_1			;;
CHK_U1RX_B:				;;
	BCF U1RX_PACKB_F		;;			
	MOV #U1RX_BUFB,W1		;;
	BRA CHK_U1RX_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX_1:				;;
	MOV [W1++],W3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #80,W0			;;
	CP W3,W0			;;
	BRA GTU,CHK_U1RX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W3,R0			;;
	MOV #0xAB,W5			;;
	CLR W6 				;;
	MOV #U1RX_TEMP,W4		;;
CHK_U1RX_1A:				;;
	MOV [W1++],W3			;;
	MOV W3,[W4++]			;;
	XOR W3,W5,W5			;;
	ADD W3,W6,W6			;;
	DEC R0				;;
	BRA NZ,CHK_U1RX_1A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W3			;;
	XOR W3,W5,W0			;;
	AND #0x00FF,W0			;;
	BRA NZ,CHK_U1RX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W3			;;
	XOR W3,W6,W0			;;
	AND #0x00FF,W0			;;
	BRA NZ,CHK_U1RX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_TEMP,W1		;;
	MOV [W1++],W0			;;
	CALL U1RX_CMD			;;
CHK_U1RX_END:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_CMD:				;;
	MOV #U1RX_TEMP,W1		;;
	MOV [W1++],W0			;;
	MOV W0,U1RXGRP			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXCMD			;;
	MOV #0xA0,W0			;;
	CP U1RXGRP			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV #8,W0			;;
	CP U1RXCMD			;;
	BRA LTU,$+4			;;
	RETURN				;;
	MOV U1RXCMD,W0			;;
	BRA W0				;;
	BRA U1RXCMD_J0			;;
	BRA U1RXCMD_J1			;;
	BRA U1RXCMD_J2			;;
	BRA U1RXCMD_J3			;;
	BRA U1RXCMD_J4			;;
	BRA U1RXCMD_J5			;;
	BRA U1RXCMD_J6			;;
	BRA U1RXCMD_J7			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J0:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J2:				;;
	MOV #U1RX_TEMP+4,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT0			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT1			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT2			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT3			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT4			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SPGAIN_BUF0,W2		;;
	MOV #5,W3			;;
U1RXCMD_J2_1:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,U1RXCMD_J2_1		;;

	MOV #MICCUT_BUF0,W2		;;
	MOV #5,W3			;;
U1RXCMD_J2_2:				;;
	MOV [W1++],W0			;;
	SL W0,#4,W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,U1RXCMD_J2_2		;;

	MOV #MICBGN_BUF0,W2		;;
	MOV #5,W3			;;
U1RXCMD_J2_3:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,U1RXCMD_J2_3		;;

	MOV #MICDLY_BUF0,W2		;;
	MOV #5,W3			;;
U1RXCMD_J2_4:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,U1RXCMD_J2_4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF U1TXINF_EN_F			;;	
	CALL U1TX_RSP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J3:				;;
	MOV #U1RX_TEMP+4,W1		;;
	MOV [W1++],W4			;;PHONE
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV [W1++],W2			;;KEY
	MOV #32,W0			;;
	CP W2,W0			;;
	BRA LTU,$+4			;;
	RETURN				;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OUTFLAG0,W3		;;
	LSR W2,#3,W0			;;
	ADD W0,W3,W3			;;
	ADD W0,W3,W3			;;
	AND #7,W2			;;
	MOV W2,W0			;;	
	CALL BIT_TRANS			;;		
	BTSC W4,#0			;;
	SWAP W0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W2			;;MOD
	BTSC W2,#1			;;
	BRA U1RXCMD_J3_M2		;;
	BTSC W2,#0			;;
	BRA U1RXCMD_J3_M1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J3_M0:				;;KEY FREE
	MOV [W3],W2			;;
	COM W0,W0			;;
	AND W0,W2,W0			;;
	MOV W0,[W3]			;;
	MOV #0,W0			;;		
	BTSS W4,#0			;;
	MOV W0,FREEK0_TIM		;;
	BTSC W4,#0			;;
	MOV W0,FREEK1_TIM		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J3_M1:				;;KEY PUSH
	MOV [W3],W2			;;
	IOR W0,W2,W0			;;
	MOV W0,[W3]			;;
	MOV #2000,W0			;;		
	BTSS W4,#0			;;
	MOV W0,FREEK0_TIM		;;
	BTSC W4,#0			;;
	MOV W0,FREEK1_TIM		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J3_M2:				;;
	MOV [W3],W2			;;
	IOR W0,W2,W0			;;
	MOV W0,[W3]			;;
	MOV [W1++],W0			;;DELAY TIME
	BTSS W4,#0			;;
	MOV W0,FREEK0_TIM		;;
	BTSC W4,#0			;;
	MOV W0,FREEK1_TIM		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J4:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J5:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J6:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J7:				;;
  	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RXCFG:				;;
	BTFSS CFGRSP_F			;;
	RETURN				;;
	BCF CFGRSP_F			;;
	MOV CFGRJ_STEP,W0		;;
	AND #3,W0			;;
	BRA W0				;;
	BRA CUC_J0			;;
	BRA CUC_J1			;;
	BRA CUC_J2			;;
	BRA CUC_J3			;;
CUC_J0:					;;
	MOV #'U',W0			;;
	CP CFGRSP			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV #500,W0			;;1.3M UNIT
	MOV W0,CFGRJ_TIM		;;
	INC CFGRJ_STEP			;;
	CALL U2CFGTX_START		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DES IP
	MOV #46,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0x00,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0xA8,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0xC0,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DES PORT
	MOV #0x2A,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0x20,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MDL IP
	MOV #231,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0x00,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0xA8,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0xC0,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MDL PORT
	MOV #0x8C,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0x4E,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GATEWAY IP
	MOV #0xC9,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0x00,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0xA8,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0xC0,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;TCP MOD
	MOV #0x01,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BAUDRATE
	MOV #0x00,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0xC2,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	MOV #0x01,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RES
	MOV #0x00,W0			;;
	CALL LOAD_U2BYTE_AC		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CHKSUM
	MOV U2TX_CHKSUM0,W0		;;
	CALL LOAD_U2BYTE_A		;;
	CALL U2CFGTX_END		;;
	RETURN				;; 
CUC_J1:					;;
	MOV #'K',W0			;;
	CP CFGRSP			;;
	BRA Z,$+4			;;
	RETURN				;;
	CLR CFGRJ_TIM			;;
	BSF U2TXINF_EN_F
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CUC_J2:					;;
CUC_J3:					;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX:				;;
	BTFSC CFGRJ_F			;;
	BRA CHK_U2RXCFG			;;
	BTFSC U2RX_PACKA_F		;;	
	BRA CHK_U2RX_A			;;
	BTFSC U2RX_PACKB_F		;;	
	BRA CHK_U2RX_B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX_A:				;;
	BCF U2RX_PACKA_F		;;
	MOV #U2RX_BUFA,W1		;;
	BRA CHK_U2RX_1			;;
CHK_U2RX_B:				;;
	BCF U2RX_PACKB_F		;;			
	MOV #U2RX_BUFB,W1		;;
	BRA CHK_U2RX_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX_1:				;;
	MOV [W1++],W3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #80,W0			;;
	CP W3,W0			;;
	BRA GTU,CHK_U2RX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W3,R0			;;
	MOV #0xAB,W5			;;
	CLR W6 				;;
	MOV #U2RX_TEMP,W4		;;
CHK_U2RX_1A:				;;
	MOV [W1++],W3			;;
	MOV W3,[W4++]			;;
	XOR W3,W5,W5			;;
	ADD W3,W6,W6			;;
	DEC R0				;;
	BRA NZ,CHK_U2RX_1A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W3			;;
	XOR W3,W5,W0			;;
	AND #0x00FF,W0			;;
	BRA NZ,CHK_U2RX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W3			;;
	XOR W3,W6,W0			;;
	AND #0x00FF,W0			;;
	BRA NZ,CHK_U2RX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2RX_TEMP,W1		;;
	MOV [W1++],W0			;;
	CALL U2RX_CMD			;;
CHK_U2RX_END:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RX_CMD:				;;
	MOV #U2RX_TEMP,W1		;;
	MOV [W1++],W0			;;
	MOV W0,U2RXGRP			;;
	MOV [W1++],W0			;;
	MOV W0,U2RXCMD			;;
	MOV #0xA0,W0			;;
	CP U2RXGRP			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV #8,W0			;;
	CP U2RXCMD			;;
	BRA LTU,$+4			;;
	RETURN				;;
	MOV U2RXCMD,W0			;;
	BRA W0				;;
	BRA U2RXCMD_J0			;;
	BRA U2RXCMD_J1			;;
	BRA U2RXCMD_J2			;;
	BRA U2RXCMD_J3			;;
	BRA U2RXCMD_J4			;;
	BRA U2RXCMD_J5			;;
	BRA U2RXCMD_J6			;;
	BRA U2RXCMD_J7			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J0:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J2:				;;
	MOV #U2RX_TEMP+4,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT0			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT1			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT2			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT3			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,SPOUT4			;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR SPOUT4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SPGAIN_BUF0,W2		;;
	MOV #5,W3			;;
U2RXCMD_J2_1:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,U2RXCMD_J2_1		;;

	MOV #MICCUT_BUF0,W2		;;
	MOV #5,W3			;;
U2RXCMD_J2_2:				;;
	MOV [W1++],W0			;;
	SL W0,#4,W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,U2RXCMD_J2_2		;;

	MOV #MICBGN_BUF0,W2		;;
	MOV #5,W3			;;
U2RXCMD_J2_3:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,U2RXCMD_J2_3		;;

	MOV #MICDLY_BUF0,W2		;;
	MOV #5,W3			;;
U2RXCMD_J2_4:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,U2RXCMD_J2_4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF U2TXINF_EN_F		;;	
	CALL U2TX_RSP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J3:				;;
	MOV #U2RX_TEMP+4,W1		;;
	MOV [W1++],W4			;;PHONE
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV [W1++],W2			;;KEY
	MOV #32,W0			;;
	CP W2,W0			;;
	BRA LTU,$+4			;;
	RETURN				;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OUTFLAG0,W3		;;
	LSR W2,#3,W0			;;
	ADD W0,W3,W3			;;
	ADD W0,W3,W3			;;
	AND #7,W2			;;
	MOV W2,W0			;;	
	CALL BIT_TRANS			;;		
	BTSC W4,#0			;;
	SWAP W0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W2			;;MOD
	BTSC W2,#1			;;
	BRA U2RXCMD_J3_M2		;;
	BTSC W2,#0			;;
	BRA U2RXCMD_J3_M1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J3_M0:				;;
	MOV [W3],W2			;;
	COM W0,W0			;;
	AND W0,W2,W0			;;
	MOV W0,[W3]			;;
	MOV #0,W0			;;		
	BTSS W4,#0			;;
	MOV W0,FREEK0_TIM		;;
	BTSC W4,#0			;;
	MOV W0,FREEK1_TIM		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J3_M1:				;;
	MOV [W3],W2			;;
	IOR W0,W2,W0			;;
	MOV W0,[W3]			;;
	MOV #2000,W0			;;		
	BTSS W4,#0			;;
	MOV W0,FREEK0_TIM		;;
	BTSC W4,#0			;;
	MOV W0,FREEK1_TIM		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J3_M2:				;;
	MOV [W3],W2			;;
	IOR W0,W2,W0			;;
	MOV W0,[W3]			;;
	MOV [W1++],W0			;;DELAY TIME
	BTSS W4,#0			;;
	MOV W0,FREEK0_TIM		;;
	BTSC W4,#0			;;
	MOV W0,FREEK1_TIM		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J4:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J5:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J6:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXCMD_J7:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANS:				;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__INT1Interrupt:			;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__INT2Interrupt:			;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PCMR_OUT:				;;
	BTSS SPOBUF0,#12		;;
	BCF PCMR0_O			;;
	BTSC SPOBUF0,#12		;;
	BSF PCMR0_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS SPOBUF1,#12		;;
	BCF PCMR1_O			;;
	BTSC SPOBUF1,#12		;;
	BSF PCMR1_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS SPOBUF2,#12		;;
	BCF PCMR2_O			;;
	BTSC SPOBUF2,#12		;;
	BSF PCMR2_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS SPOBUF3,#12		;;
	BCF PCMR3_O			;;
	BTSC SPOBUF3,#12		;;
	BSF PCMR3_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS SPOBUF4,#12		;;
	BCF PCMR4_O			;;
	BTSC SPOBUF4,#12		;;
	BSF PCMR4_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PCMT_IN:				;;
	BCLR MICIBUF0,#0		;; 
	BTFSC PCMT0_I			;;
	BSET MICIBUF0,#0		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR MICIBUF1,#0		;; 
	BTFSC PCMT1_I			;;
	BSET MICIBUF1,#0		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR MICIBUF2,#0		;; 
	BTFSC PCMT2_I			;;
	BSET MICIBUF2,#0		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR MICIBUF3,#0		;; 
	BTFSC PCMT3_I			;;
	BSET MICIBUF3,#0		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR MICIBUF4,#0		;; 
	BTFSC PCMT4_I			;;
	BSET MICIBUF4,#0		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RLC_MICIBUF:				;;
	RLNC MICIBUF0			;;
	RLNC MICIBUF1			;;
	RLNC MICIBUF2			;;
	RLNC MICIBUF3			;;
	RLNC MICIBUF4			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RLC_SPOBUF:				;;
	RLNC SPOBUF0			;;
	RLNC SPOBUF1			;;
	RLNC SPOBUF2			;;
	RLNC SPOBUF3			;;
	RLNC SPOBUF4			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__IC2Interrupt:				;;
	BCLR IFS0,#IC2IF		;;		
	BCF LCD0HL_F			;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__IC3Interrupt:				;;
	BCLR IFS2,#IC3IF		;;		
	BCF LCD1HL_F			;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;$1	
;MICCUT 	BIT9		  
;MICEN  	BIT8		  
;DIRECT		BIT7
;TEST TONE	BIT6
;SILENCE	BIT5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__IC1Interrupt:				;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	PUSH W2				;;
	PUSH W3				;;
	BCLR IFS0,#IC1IF		;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC CODEC_TIM			;;
	MOV #0x001F,W0			;;
	AND CODEC_TIM			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV CODEC_TIM,W0		;;
	BRA W0				;;
	BRA IC1T_J00			;;	
	BRA IC1T_J01			;;	
	BRA IC1T_J02			;;	
	BRA IC1T_J03			;;	
	BRA IC1T_J04			;;	
	BRA IC1T_J05			;;	
	BRA IC1T_J06			;;	
	BRA IC1T_J07			;;	
	BRA IC1T_J08			;;	
	BRA IC1T_J09			;;	
	BRA IC1T_J10			;;	
	BRA IC1T_J11			;;	
	BRA IC1T_J12			;;	
	BRA IC1T_J13			;;	
	BRA IC1T_J14			;;	
	BRA IC1T_J15			;;	
	BRA IC1T_J16			;;	
	BRA IC1T_J17			;;	
	BRA IC1T_J18			;;	
	BRA IC1T_J19			;;	
	BRA IC1T_J20			;;	
	BRA IC1T_J21			;;	
	BRA IC1T_J22			;;	
	BRA IC1T_J23			;;	
	BRA IC1T_J24			;;	
	BRA IC1T_J25			;;	
	BRA IC1T_J26			;;	
	BRA IC1T_J27			;;	
	BRA IC1T_J28			;;	
	BRA IC1T_J29			;;	
	BRA IC1T_J30			;;	
	BRA IC1T_J31			;;	
IC1T_J00:				;;	
	BSF FSRT_O			;;
	CLR MICIBUF0			;;
	CLR MICIBUF1			;;
	CLR MICIBUF2			;;
	CLR MICIBUF3			;;
	CLR MICIBUF4			;;
	BRA IC1INT_END			;;	
IC1T_J01:				;;	
IC1T_J02:				;;	
IC1T_J03:				;;	
IC1T_J04:				;;	
IC1T_J05:				;;	
IC1T_J06:				;;	
IC1T_J07:				;;	
IC1T_J08:				;;	
IC1T_J09:				;;	
IC1T_J10:				;;	
IC1T_J11:				;;	
IC1T_J12:				;;	
IC1T_J13:				;;	
	BCF FSRT_O			;;
	CALL PCMR_OUT			;;
	CALL RLC_MICIBUF		;;
	CALL PCMT_IN			;;
	CALL RLC_SPOBUF 		;;
	BRA IC1INT_END			;;	
IC1T_J14:				;;
	INC TTONE_CNT			;;
	MOV #0x0007,W0			;;
	AND TTONE_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #TTONE_BUF,W1		;;
;	MOV TTONE_CNT,W0		;;
;	ADD W0,W1,W1			;;
;	ADD W0,W1,W1			;;
;	MOV [W1],W0			;;
;	MOV W0,MICIBUF0			;;

					;;	
	

	BRA IC1INT_END			;;	
;	MOV #SPIN_BUF,W1		;;
;	MOV MICIBUF0,W0			;;
;	MOV W0,[W1++]			;;
;	MOV MICIBUF1,W0			;;
;	MOV W0,[W1++]			;;
;	MOV MICIBUF2,W0			;;
;	MOV W0,[W1++]			;;
;	MOV MICIBUF3,W0			;;
;	MOV W0,[W1++]			;;
;	MOV MICIBUF4,W0			;;
;	MOV W0,[W1++]			;;
;	BRA IC1INT_END			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IC1T_J15:				;;
	MOV MICIBUF0,W2			;;
	MOV #0,W3			;;
	CALL MICFUNC			;;
	BRA IC1INT_END			;;	
IC1T_J16:				;;
	MOV MICIBUF1,W2			;;
	MOV #1,W3			;;
	CALL MICFUNC			;;
	BRA IC1INT_END			;;	
IC1T_J17:				;;
	MOV MICIBUF2,W2			;;
	MOV #2,W3			;;
	CALL MICFUNC			;;
	BRA IC1INT_END			;;	
IC1T_J18:				;;
	MOV MICIBUF3,W2			;;
	MOV #3,W3			;;
	CALL MICFUNC			;;
	BRA IC1INT_END			;;	
IC1T_J19:				;;
	MOV MICIBUF4,W2			;;
	MOV #4,W3			;;
	CALL MICFUNC			;;
	BRA IC1INT_END			;;	
IC1T_J20:				;;
	MOV SPOUT0,W2			;;
	MOV #0,W3			;;
	CALL SPFUNC 			;;
	BRA IC1INT_END			;;	
IC1T_J21:				;;	
	MOV SPOUT1,W2			;;
	MOV #1,W3			;;
	CALL SPFUNC 			;;
	BRA IC1INT_END			;;	
IC1T_J22:				;;	
	MOV SPOUT2,W2			;;
	MOV #2,W3			;;
	CALL SPFUNC 			;;
	BRA IC1INT_END			;;	
IC1T_J23:				;;	
	MOV SPOUT3,W2			;;
	MOV #3,W3			;;
	CALL SPFUNC 			;;
	BRA IC1INT_END			;;	
IC1T_J24:				;;	
	MOV SPOUT4,W2			;;
	MOV #4,W3			;;
	CALL SPFUNC 			;;
	BRA IC1INT_END			;;	
IC1T_J25:				;;	
IC1T_J26:				;;	
IC1T_J27:				;;	
IC1T_J28:				;;	
IC1T_J29:				;;	
IC1T_J30:				;;	
IC1T_J31:				;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IC1INT_END:				;;
	POP W3				;;
	POP W2				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;$2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MICFUNC:				;;
	BCF MINUS_F			;;	
	BTSS W2,#12			;;
	BRA MICFUNC_1			;;
	MOV #0xF000,W0			;;
	IOR W0,W2,W2			;;
;	NEG W2,W2			;;	
	BSF MINUS_F 			;;	
MICFUNC_1:				;;
	MOV #MICOBUF0,W1		;;
	ADD W3,W1,W1			;;
	ADD W3,W1,W1			;;
	MOV W2,[W1]			;;
	BTFSC MINUS_F			;;
	NEG W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #MICCUT_BUF0,W1		;;
	ADD W3,W1,W1			;;
	ADD W3,W1,W1			;;
	MOV [W1],W0			;;
	CP W2,W0			;;
	BRA GEU,MICFUNC_2  		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #MICCUT_TIM0,W1		;;
	ADD W3,W1,W1			;;	
	ADD W3,W1,W1			;;
	INC [W1],[W1]			;;
	MOV #100,W0			;;
	MOV [W1],W2			;;
	CP W2,W0			;;
	BRA GTU,$+4			;;
	RETURN				;;
	MOV #SPOUT0,W1			;;
	ADD W3,W1,W1			;;	
	ADD W3,W1,W1			;;
	MOV [W1],W0			;;
	BSET W0,#9			;;
	MOV W0,[W1]			;;
	RETURN				;;
MICFUNC_2:	 			;;
	MOV #MICCUT_TIM0,W1		;;
	ADD W3,W1,W1			;;	
	ADD W3,W1,W1			;;
	CLR [W1]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SPOUT0,W1			;;
	ADD W3,W1,W1			;;	
	ADD W3,W1,W1			;;
	MOV [W1],W0			;;
	BCLR W0,#9			;;
	MOV W0,[W1]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;SPOUT
;B0 MIC0
;B1 MIC1
;B2 MIC2
;B3 MIC3
;B4 MIC4
;B5 SILENCE
;B6 TEST TONE
;B7 DIRECT
;B8 MICX MIC ENABLE
;B9 MICX MIC LOWER CUT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPFUNC:					;;
	BTSC W2,#5			;;SILENCE
	BRA SPFUNC_1			;;
	BTSC W2,#6			;;TEST_TONE
	BRA SPFUNC_2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC SPOUT0,#8			;;
	BCLR W2,#0			;;
	BTSC SPOUT0,#9			;;
	BCLR W2,#0			;;	
	BTSC SPOUT1,#8			;;
	BCLR W2,#1			;;
	BTSC SPOUT1,#9			;;
	BCLR W2,#1			;;	
	BTSC SPOUT2,#8			;;
	BCLR W2,#2			;;
	BTSC SPOUT2,#9			;;
	BCLR W2,#2			;;	
	BTSC SPOUT3,#8			;;
	BCLR W2,#3			;;
	BTSC SPOUT3,#9			;;
	BCLR W2,#3			;;	
	BTSC SPOUT4,#8			;;
	BCLR W2,#4			;;
	BTSC SPOUT4,#9			;;
	BCLR W2,#4			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W0				;;
	BTSC W2,#0			;;		
	ADD MICOBUF0,WREG		;;
	BTSC W2,#1			;;		
	ADD MICOBUF1,WREG		;;
	BTSC W2,#2			;;		
	ADD MICOBUF2,WREG		;;
	BTSC W2,#3			;;		
	ADD MICOBUF3,WREG		;;
	BTSC W2,#4			;;		
	ADD MICOBUF4,WREG		;;
	BTSC W2,#7			;;
	BRA SPFUNC_3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF MINUS_F			;;
	BTSC W0,#15			;;
	BSF MINUS_F			;;
	BTSC W0,#15			;;
	NEG W0,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR W0,#15			;;
	BCLR W0,#14			;;
	BCLR W0,#13			;;
	BCLR W0,#12			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 LOGTBL			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPFUNC_4:				;;
	MOV #SPGAIN0,W1			;;
	ADD W3,W1,W1			;;
	ADD W3,W1,W1			;;
	MOV [W1],W1			;;
	INC W1,W1			;;
	MUL.UU W0,W1,W0			;;
	SWAP W0				;;
	AND #255,W0			;;	
	AND #255,W1			;;
	SWAP W1				;;
	IOR W1,W0,W0			;;
	BTFSC MINUS_F			;;
	NEG W0,W0 			;;
SPFUNC_3:				;;
	MOV #SPOBUF0,W1			;;
	ADD W3,W1,W1			;;
	ADD W3,W1,W1			;;
	MOV W0,[W1]			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPFUNC_2:				;;
	MOV #TTONE_BUF,W1		;;
	MOV TTONE_CNT,W0		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;

	BCF MINUS_F			;;
	BTSC W0,#15			;;
	BSF MINUS_F			;;
	BTSC W0,#15			;;
	NEG W0,W0			;;


	BRA SPFUNC_4
	MOV #SPOBUF0,W1			;;
	ADD W3,W1,W1			;;
	ADD W3,W1,W1			;;
	MOV W0,[W1]			;;
	RETURN				;;
SPFUNC_1:				;;
	MOV #SPOBUF0,W1			;;
	ADD W3,W1,W1			;;
	ADD W3,W1,W1			;;
	CLR [W1]			;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1RXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS0,#11			;;
	MOV U1RXREG,W1			;;
	AND #255,W1			;;
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
	MOV #150,W0			;;
	CP U1RX_BYTE_PTR		;;
	BRA GEU,U1RXI_END		;;
	MOV #U1RX_BUFA,W0		;;
	BTFSC U1RX_BUFAB_F		;;
	MOV #U1RX_BUFB,W0		;;
	ADD U1RX_BYTE_PTR,WREG		;;
	ADD U1RX_BYTE_PTR,WREG		;;
	MOV W1,[W0]			;;
	INC U1RX_BYTE_PTR		;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_PS:				;;
	BCF U1RXT_F			;;
	CLR U1RX_BYTE_PTR		;;
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_PE:				;;
	BCF U1RXT_F			;;
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
	CLR U1RX_BYTE_PTR		;; 
	BRA U1RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_PT:				;;
	BSF U1RXT_F			;;
	BRA U1RXI_END			;;
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
	BTFSC CFGRJ_F			;;
	BRA U2RXI_CFG			;; 
	MOV U2RXREG,W1			;;
	AND #255,W1			;;
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
	MOV #150,W0			;;
	CP U2RX_BYTE_PTR		;;
	BRA GEU,U2RXI_END		;;
	MOV #U2RX_BUFA,W0		;;
	BTFSC U2RX_BUFAB_F		;;
	MOV #U2RX_BUFB,W0		;;
	ADD U2RX_BYTE_PTR,WREG		;;
	ADD U2RX_BYTE_PTR,WREG		;;
	MOV W1,[W0]			;;
	INC U2RX_BYTE_PTR		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PS:				;;
	BCF U2RXT_F			;;
	CLR U2RX_BYTE_PTR		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PE:				;;
	BCF U2RXT_F			;;
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
	CLR U2RX_BYTE_PTR		;; 
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
U2RXI_CFG:				;;
	MOV U2RXREG,W1			;;
	AND #255,W1			;;	
	MOV W1,CFGRSP			;;
	BSF CFGRSP_F			;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1TXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	BCLR IFS0,#12			;;
	BTFSS U1TX_EN_F			;;
	BRA U1TX1_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1TX_BUF,W0		;;
	ADD U1TX_BCNT,WREG		;;
	ADD U1TX_BCNT,WREG		;;
	MOV [W0],W0			;;
	MOV W0,U1TXREG			;;
	INC U1TX_BCNT			;;
	MOV U1TX_BTX,W0			;;
	CP U1TX_BCNT			;;
	BRA LTU,U1TX1_END		;;
	BCF U1TX_EN_F			;;
U1TX1_END:				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2TXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	BCLR IFS1,#U2TXIF		;;	
	BTFSS U2TX_EN_F			;;
	BRA U2TX1_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2TX_BUF,W0		;;
	ADD U2TX_BCNT,WREG		;;
	ADD U2TX_BCNT,WREG		;;
	MOV [W0],W0			;;
	MOV W0,U2TXREG			;;
	INC U2TX_BCNT			;;
	MOV U2TX_BTX,W0			;;
	CP U2TX_BCNT			;;
	BRA LTU,U2TX1_END		;;
	BCF U2TX_EN_F			;;
U2TX1_END:				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




DLYX:
	CLRWDT
	DEC W0,W0
	BRA NZ,DLYX
	RETURN
	
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
DLYMX2:					;;
	CLRWDT				;;
	MOV R0,W0			;;
	SUB TMR2,WREG			;;
	AND #0x00C0,W0			;;
	BRA Z,DLYMX2			;;
        DEC R1				;;
        BRA NZ,DLYMX1 			;;
        POP R1				;;
        POP R0				;;
        RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TEST_LOGTBL:
	MOV #0,W0
	CALL GET_LOGTBL
	MOV #1,W0
	CALL GET_LOGTBL
	MOV #2,W0
	CALL GET_LOGTBL
	MOV #3,W0
	CALL GET_LOGTBL
	MOV #4,W0
	CALL GET_LOGTBL
	BRA TEST_LOGTBL	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_LOGTBL:				;;
	BTSS W0,#15			;;
	BRA GET_LOGTBL_1		;;
	COM W0,W0			;;	
	INC W0,W0			;;
	LOFFS1 LOGTBL			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			
	TBLRDL [W1++],W0		;;
	COM W0,W0
	INC W0,W0
	RETURN
GET_LOGTBL_1:
	LOFFS1 LOGTBL			;;
	ADD W0,W1,W1
	ADD W0,W1,W1
	TBLRDL [W1++],W0		;;
	RETURN
	


        .include "DATA.S"

