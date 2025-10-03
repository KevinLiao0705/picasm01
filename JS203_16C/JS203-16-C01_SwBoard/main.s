;******************************************************************************
;Copy From JS203_09B
;Establish Date 20162,7,18
;Purpose:


	
 



        .equ __24ep64gp206, 1 ;
        .include "p24ep64gp206.inc"


;BY DEFINE=============================
;====================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'
	.EQU 	DEVICE_ID_K	,0x1845

;..............................................................................
;Global Declarations:
;..............................................................................
    	.global __reset          
    	.global __T1Interrupt    
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

.MACRO 	MOVFF XX,YY
	PUSH \XX
	POP \YY
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

URXCON_TIM:	      	.SPACE 2

SWLED_FLAG:	      	.SPACE 2
SWLED_BUF:	      	.SPACE 2
SWLED_TIM0:	      	.SPACE 2
SWLED_TIM1:	      	.SPACE 2
SWLED_TIM2:	      	.SPACE 2
SWLED_TIM3:	      	.SPACE 2
SWLED_TIM4:	      	.SPACE 2
SWLED_TIM5:	      	.SPACE 2
SWLED_TIM6:	      	.SPACE 2
SWLED_TIM7:	      	.SPACE 2


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
U1RX_TMP0:              .SPACE 2
U1RX_TMP1:              .SPACE 2
U1RX_ADDSUM:            .SPACE 2
U1RX_XORSUM:            .SPACE 2


LEDRGF0:	       	.SPACE 2
LEDRGF1:	       	.SPACE 2
LEDF0:			.SPACE 2	
LEDF1:			.SPACE 2	
LEDF2:			.SPACE 2	
LEDF3:			.SPACE 2	
LEDF4:			.SPACE 2	

LEDRGF0F:	       	.SPACE 2
LEDRGF1F:	       	.SPACE 2
LEDF0F:			.SPACE 2	
LEDF1F:			.SPACE 2	
LEDF2F:			.SPACE 2	
LEDF3F:			.SPACE 2	
LEDF4F:			.SPACE 2	

LED_FLASH_TIM:		.SPACE 2	
SIP_STATUS:		.SPACE 2	
HAND_STATUS:		.SPACE 2	
CONNECT_STATUS:		.SPACE 2	



KEY_SCAN:		.SPACE 2	
KEYIN:			.SPACE 2	
KEYIN_TIM:		.SPACE 2	

YESKEY_TIM:		.SPACE 2	
NOKEY_TIM:		.SPACE 2	
KEY_DATA:		.SPACE 2	


BL_LEVEL:		.SPACE 2	

U1RXB0:			.SPACE 2	
U1RXB1:			.SPACE 2	
U1RXB2:			.SPACE 2	
U1RXB3:			.SPACE 2	
U1RXB4:			.SPACE 2	
U1RXB5:			.SPACE 2	
U1RXB6:			.SPACE 2	
U1RXB7:			.SPACE 2	
U1RXB8:			.SPACE 2	
U1RXB9:			.SPACE 2	
U1RXBA:			.SPACE 2	
U1RXBB:			.SPACE 2	
U1RXBC:			.SPACE 2	
U1RXBD:			.SPACE 2	
U1RXBE:			.SPACE 2	
U1RXBF:			.SPACE 2	

RX_DEVICE_ID:           .SPACE 2
RX_ADDR:                .SPACE 2
RX_LEN:                 .SPACE 2
RX_CMD:                 .SPACE 2
RX_GROUP_ID:            .SPACE 2
RX_SERIAL_ID:           .SPACE 2
SERIAL_ID:              .SPACE 2

U1RX_LEN:               .SPACE 2
URX_PARA0:              .SPACE 2
URX_PARA1:              .SPACE 2
URX_PARA2:              .SPACE 2
URX_PARA3:              .SPACE 2
UTX_CMD:               .SPACE 2
UTX_PARA0:             .SPACE 2
UTX_PARA1:             .SPACE 2
UTX_PARA2:             .SPACE 2
UTX_PARA3:             .SPACE 2
TX_DEVICE_ID:               .SPACE 2
TX_SERIAL_ID:               .SPACE 2
TX_GROUP_ID:               .SPACE 2
UTX_BUFFER_LEN:               .SPACE 2
UTX_BUF:		.SPACE 64	
UTX_CHKSUM0:               .SPACE 2
UTX_CHKSUM1:               .SPACE 2
UTX_BTX:               .SPACE 2


.EQU U1RX_BUFSIZE	,256	;
.EQU U1TX_BUF		,0x2100
.EQU U1RX_BUFA		,0x2200
.EQU U1RX_BUFB		,0x2300
.EQU U1RX_TEMP		,0x2400
;.EQU U2TX_BUF		,0x2500
;.EQU U2RX_BUFA		,0x2600
;.EQU U2RX_BUFB		,0x2700
;.EQU U2RX_TEMP		,0x2800


.EQU DB0_IO		,TRISA
.EQU DB0_IO_P		,7
.EQU DB0_O		,LATA
.EQU DB0_O_P		,7
.EQU DB0_I		,PORTA
.EQU DB0_I_P		,7

.EQU DB1_IO		,TRISB
.EQU DB1_IO_P		,14
.EQU DB1_O		,LATB
.EQU DB1_O_P		,14
.EQU DB1_I		,PORTB
.EQU DB1_I_P		,14

.EQU DB2_IO		,TRISB
.EQU DB2_IO_P		,15
.EQU DB2_O		,LATB
.EQU DB2_O_P		,15
.EQU DB2_I		,PORTB
.EQU DB2_I_P		,15

.EQU DB3_IO		,TRISG
.EQU DB3_IO_P		,6
.EQU DB3_O		,LATG
.EQU DB3_O_P		,6
.EQU DB3_I		,PORTG
.EQU DB3_I_P		,6

.EQU DB4_IO		,TRISG
.EQU DB4_IO_P		,7
.EQU DB4_O		,LATG
.EQU DB4_O_P		,7
.EQU DB4_I		,PORTG
.EQU DB4_I_P		,7

.EQU DB5_IO		,TRISG
.EQU DB5_IO_P		,8
.EQU DB5_O		,LATG
.EQU DB5_O_P		,8
.EQU DB5_I		,PORTG
.EQU DB5_I_P		,8

.EQU DB6_IO		,TRISG
.EQU DB6_IO_P		,9
.EQU DB6_O		,LATG
.EQU DB6_O_P		,9
.EQU DB6_I		,PORTG
.EQU DB6_I_P		,9

.EQU DB7_IO		,TRISA
.EQU DB7_IO_P		,12
.EQU DB7_O		,LATA
.EQU DB7_O_P		,12
.EQU DB7_I		,PORTA
.EQU DB7_I_P		,12

.EQU KEYO1_IO		,TRISA
.EQU KEYO1_IO_P		,11
.EQU KEYO1_O		,LATA
.EQU KEYO1_O_P		,11

.EQU KEYO2_IO		,TRISA
.EQU KEYO2_IO_P		,0
.EQU KEYO2_O		,LATA
.EQU KEYO2_O_P		,0

.EQU KEYO3_IO		,TRISA
.EQU KEYO3_IO_P		,1
.EQU KEYO3_O		,LATA
.EQU KEYO3_O_P		,1

.EQU KEYO4_IO		,TRISB
.EQU KEYO4_IO_P		,0
.EQU KEYO4_O		,LATB
.EQU KEYO4_O_P		,0

.EQU LEDCOM_IO		,TRISC
.EQU LEDCOM_IO_P	,7
.EQU LEDCOM_O		,LATC
.EQU LEDCOM_O_P		,7

.EQU EN7_IO		,TRISD
.EQU EN7_IO_P		,8
.EQU EN7_O		,LATD
.EQU EN7_O_P		,8

.EQU EN8_IO		,TRISB
.EQU EN8_IO_P		,5
.EQU EN8_O		,LATB
.EQU EN8_O_P		,5

.EQU EN9_IO		,TRISB
.EQU EN9_IO_P		,6
.EQU EN9_O		,LATB
.EQU EN9_O_P		,6

.EQU EN10_IO		,TRISC
.EQU EN10_IO_P		,10
.EQU EN10_O		,LATC
.EQU EN10_O_P		,10

.EQU EN11_IO		,TRISB
.EQU EN11_IO_P		,7
.EQU EN11_O		,LATB
.EQU EN11_O_P		,7

.EQU EN12_IO		,TRISC
.EQU EN12_IO_P		,13
.EQU EN12_O		,LATC
.EQU EN12_O_P		,13

.EQU EN13_IO		,TRISB
.EQU EN13_IO_P		,8
.EQU EN13_O		,LATB
.EQU EN13_O_P		,8

.EQU EN14_IO		,TRISB
.EQU EN14_IO_P		,9
.EQU EN14_O		,LATB
.EQU EN14_O_P		,9

.EQU EN15_IO		,TRISC
.EQU EN15_IO_P		,6
.EQU EN15_O		,LATC
.EQU EN15_O_P		,6

.EQU TRIG1_IO		,TRISF
.EQU TRIG1_IO_P		,1
.EQU TRIG1_O		,LATF
.EQU TRIG1_O_P		,1

.EQU TRIG2_IO		,TRISB
.EQU TRIG2_IO_P		,10
.EQU TRIG2_O		,LATB
.EQU TRIG2_O_P		,10

.EQU TRIG3_IO		,TRISB
.EQU TRIG3_IO_P		,11
.EQU TRIG3_O		,LATB
.EQU TRIG3_O_P		,11






.EQU TEST_O		,LATA
.EQU TEST_IO		,TRISA
.EQU TEST_O_P		,10
.EQU TEST_IO_P		,10


		
.EQU U1TX_O		,LATB
.EQU U1TX_IO		,TRISB
.EQU U1TX_O_P		,4
.EQU U1TX_IO_P		,4

.EQU U1RX_I		,PORTA
.EQU U1RX_IO		,TRISA
.EQU U1RX_I_P		,4
.EQU U1RX_IO_P		,4

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


;.EQU MCLK_O		,LATB
;.EQU MCLK_IO		,TRISB
;.EQU MCLK_O_P		,9
;.EQU MCLK_IO_P		,9



;.EQU SPCHA_I		,PORTE
;.EQU SPCHA_IO		,TRISE
;.EQU SPCHA_I_P		,14
;.EQU SPCHA_IO_P		,14


;.EQU SPCHB_I		,PORTE
;.EQU SPCHB_IO		,TRISE
;.EQU SPCHB_I_P		,15
;.EQU SPCHB_IO_P		,15



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


;.EQU FSRT_O		,LATC
;.EQU FSRT_IO		,TRISC
;.EQU FSRT_O_P		,13
;.EQU FSRT_IO_P		,13

;.EQU PCMR0_O		,LATB
;.EQU PCMR0_IO		,TRISB
;.EQU PCMR0_O_P		,7 
;.EQU PCMR0_IO_P		,7 

;.EQU PCMR1_O		,LATC
;.EQU PCMR1_IO		,TRISC
;.EQU PCMR1_O_P		,10
;.EQU PCMR1_IO_P		,10

;.EQU PCMR2_O		,LATB
;.EQU PCMR2_IO		,TRISB
;.EQU PCMR2_O_P		,6 
;.EQU PCMR2_IO_P		,6 

;.EQU PCMR3_O		,LATB
;.EQU PCMR3_IO		,TRISB
;.EQU PCMR3_O_P		,5 
;.EQU PCMR3_IO_P		,5 

;.EQU PCMR4_O		,LATD
;.EQU PCMR4_IO		,TRISD
;.EQU PCMR4_O_P		,8 
;.EQU PCMR4_IO_P		,8 


;.EQU PCMT0_I		,PORTF
;.EQU PCMT0_IO		,TRISF
;.EQU PCMT0_I_P		,0 
;.EQU PCMT0_IO_P		,0 

;.EQU PCMT1_I		,PORTF
;.EQU PCMT1_IO		,TRISF
;.EQU PCMT1_I_P		,1 
;.EQU PCMT1_IO_P		,1 

;.EQU PCMT2_I		,PORTB
;.EQU PCMT2_IO		,TRISB
;.EQU PCMT2_I_P		,10
;.EQU PCMT2_IO_P		,10

;.EQU PCMT3_I		,PORTB
;.EQU PCMT3_IO		,TRISB
;.EQU PCMT3_I_P		,11
;.EQU PCMT3_IO_P		,11

;.EQU PCMT4_I		,PORTB
;.EQU PCMT4_IO		,TRISB
;.EQU PCMT4_I_P		,12
;.EQU PCMT4_IO_P		,12

;.EQU PUI_O		,LATB
;.EQU PUI_IO		,TRISB
;.EQU PUI_O_P		,13
;.EQU PUI_IO_P		,13


;.EQU VOLADJ1_I		,PORTE
;.EQU VOLADJ1_IO	,TRISE
;.EQU VOLADJ1_I_P	,12
;.EQU VOLADJ1_IO_P	,12

;.EQU VOLADJ2_I		,PORTE
;.EQU VOLADJ2_IO	,TRISE
;.EQU VOLADJ2_I_P	,13
;.EQU VOLADJ2_IO_P	,13

;.EQU LED_O		,LATB
;.EQU LED_IO		,TRISB
;.EQU LED_O_P		,14
;.EQU LED_IO_P		,14



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
.EQU KEYIN_F		,FLAGA
.EQU KEYIN_F_P		,6
.EQU KPUSH_F		,FLAGA
.EQU KPUSH_F_P		,7
.EQU U1RX_EN_F		,FLAGA
.EQU U1RX_EN_F_P		,8
.EQU U1TXINF_EN_F	,FLAGA
.EQU U1TXINF_EN_F_P	,9
.EQU LED_FLASH_F	,FLAGA
.EQU LED_FLASH_F_P	,10
.EQU MUTE_F		,FLAGA
.EQU MUTE_F_P  		,11
.EQU U1U2_F		,FLAGA
.EQU U1U2_F_P  	        ,12
.EQU U1TX_EN_F		,FLAGA
.EQU U1TX_EN_F_P  	,13
.EQU U1TX_END_F		,FLAGA
.EQU U1TX_END_F_P  	,14
;.EQU U1TX_EN_F		,FLAGA
;.EQU U1TX_EN_F_P  	,14



;FLAGB
;.EQU U2RXT_F		,FLAGB
;.EQU U2RXT_F_P		,0
;.EQU U2RX_BUFAB_F	,FLAGB
;.EQU U2RX_BUFAB_F_P	,1
;.EQU U2RX_PACKA_F	,FLAGB
;.EQU U2RX_PACKA_F_P	,2
;.EQU U2RX_PACKB_F	,FLAGB
;.EQU U2RX_PACKB_F_P	,3
;.EQU U2TX_EN_F		,FLAGB
;.EQU U2TX_EN_F_P	,4
;.EQU U2TX_WAITTX_F	,FLAGB
;.EQU U2TX_WAITTX_F_P	,5
;.EQU U2TXINF_EN_F	,FLAGB
;.EQU U2TXINF_EN_F_P	,6







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
	CALL INIT_AD		;;
	CALL INIT_RAM		;;
	CALL INIT_TEST		;;
	CALL INIT_SIO		;;
	CALL INIT_OSC
	MOV #10000,W0
	CALL DLYX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL INIT_TIMER			;;
	CALL INIT_UART1			;;
;	CALL INIT_IC			;;
	CALL INIT_INT			;;
	GOTO MAIN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	CLR ANSELC			;;
	CLR ANSELE			;;
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EARPHONE_LED_WHITE:			;;
	BCLR LEDF4,#1			;;
	BSET LEDF2,#0			;; 
	BSET LEDF4F,#1			;;
	RETURN;				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPEAKER_LED_WHITE:			;;
	BCLR LEDF4,#2			;;
	BSET LEDF2,#2			;; 
	BSET LEDF4F,#2			;;
	RETURN;				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MUTE_LED_WHITE:				;;
	BCLR LEDF4,#3			;;
	BSET LEDF2,#5			;; 
	BSET LEDF4F,#3			;;
	RETURN;				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EARPHONE_LED_RED:			;;
	BSET LEDF4,#1			;;
	BCLR LEDF2,#0			;; 
	BSET LEDF4F,#1			;;
	RETURN;				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPEAKER_LED_RED:			;;
	BSET LEDF4,#2			;;
	BCLR LEDF2,#2			;; 
	BSET LEDF4F,#2			;;
	RETURN;				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MUTE_LED_RED:				;;
	BSET LEDF4,#3			;;
	BCLR LEDF2,#5			;; 
	BSET LEDF4F,#3			;;
	RETURN;				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EARPHONE_LED_BLINK:			;;
	BSET LEDF4,#1			;;
	BCLR LEDF2,#0			;; 
	BCLR LEDF4F,#1			;;
	RETURN;				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPEAKER_LED_BLINK:			;;
	BSET LEDF4,#2			;;
	BCLR LEDF2,#2			;; 
	BCLR LEDF4F,#2			;;
	RETURN;				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	
INIT_TEST:
	CLR LEDRGF0 
	CLR LEDRGF1
	MOV #0xFF,W0
	MOV W0,LEDF0
	MOV W0,LEDF1
	MOV W0,LEDF2
	MOV W0,LEDF3
	CLR LEDF4
	CLR KEYIN
	MOV #255,W0
	MOV W0,KEY_DATA
	MOV #2,W0
	MOV W0,BL_LEVEL
	;CALL SPEAKER_LED_BLINK
	;CALL EARPHONE_LED_BLINK
	;CALL MUTE_LED_RED
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	CALL INIT_TEST			;;
        BSF U1RX_EN_F
MAIN_LOOP:				;;
	CLRWDT				;;
	CALL TMR2PRG			;;	
        CALL SWLED_PRG
	CALL KEYBO			;;
	CALL KEYPRG			;;
	CALL CHK_U1RX			;;	
;	CALL U1RXPRG
	CALL U1TXPRG			;;
;	CALL MAINT_PRG			;;
;	CALL CHK_U1RaX			;;	
;	CALL U1TX_INF			;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SWLED_PRG:                              ;;
	BTSS TMR2_FLAG,#8		;;2.6
	RETURN				;;
        INC URXCON_TIM                  ;;
        BRA NZ,$+4                      ;;        
        DEC URXCON_TIM                  ;;
        MOV #100,W0                     ;;
        CP URXCON_TIM                   ;;
        BRA LTU,$+4                     ;;
        CLR SWLED_FLAG                  ;;        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR R0                          ;;
SWLED_P0:                               ;;
        MOV #SWLED_TIM0,W3              ;;      
        MOV R0,W0                       ;;
        ADD W0,W3,W3                    ;;
        ADD W0,W3,W3                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV SWLED_FLAG,W0               ;;
        MOV R0,W2                       ;;        
        LSR W0,W2,W0                    ;;
        LSR W0,W2,W0                    ;;
        AND #3,W0                       ;;
        BRA W0                          ;;
        BRA SWLED_00                    ;;
        BRA SWLED_01                    ;;
        BRA SWLED_10                    ;;
        BRA SWLED_11                    ;;
SWLED_00:                               ;;
        CLR [W3]                        ;;
        MOV #0x00,W0                    ;;
        CALL SET_SWLED                  ;;
        BRA SWLED_P1                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SWLED_01:                               ;;        
        CLR [W3]                        ;;
        MOV #0x01,W0                    ;;
        CALL SET_SWLED                  ;;
        BRA SWLED_P1                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SWLED_10:                               ;;        
        CLR [W3]                        ;;
        MOV #0x02,W0                    ;;
        CALL SET_SWLED                  ;;
        BRA SWLED_P1                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SWLED_11:                               ;;        
        INC [W3],[W3]                   ;;
        MOV #50,W0                      ;;
        CP W0,[W3]                      ;;
        BRA GEU,SWLED_P1                ;;
        CLR [W3]                        ;;
        CALL CPL_SWLED                  ;;
        BRA SWLED_P1                    ;;
SWLED_P1:                               ;;
        INC R0                          ;;
        MOV #8,W0                       ;;
        CP R0                           ;;
        BRA LTU,SWLED_P0                ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV SWLED_BUF,W0                ;;
        AND #255,W0                     ;;
        MOV W0,LEDRGF0                  ;;
        MOV SWLED_BUF,W0                ;;
        SWAP W0                         ;;
        AND #255,W0                     ;;
        MOV W0,LEDRGF1                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_SWLED:                              ;;
        PUSH W0                         ;;
        MOV #0x0003,W2                  ;;
        MOV R0,W0                       ;;
        SL W2,W0,W2                     ;;        
        SL W2,W0,W2                     ;;
        MOV #0xFFFF,W0                  ;;
        XOR W2,W0,W0                    ;;
        AND SWLED_BUF                   ;;
        POP W2                          ;;
        MOV R0,W0                       ;;
        SL W2,W0,W2                     ;;
        SL W2,W0,W0                     ;;
        IOR SWLED_BUF                   ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CPL_SWLED:                              ;;
        MOV #0x0002,W2                  ;;
        MOV R0,W0                       ;;
        SL W2,W0,W2                     ;;        
        SL W2,W0,W0                     ;;
        AND SWLED_BUF,WREG              ;;
        BRA Z,CPL_SWLED_1               ;;
CPL_SWLED_0:                            ;;
        MOV #0x0000,W0                  ;;
        CALL SET_SWLED                  ;;
        RETURN                          ;;
CPL_SWLED_1:                            ;;
        MOV #0x0002,W0                  ;;
        CALL SET_SWLED                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;










        
        
        














        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SIPLED:				;;
	BTFSC MUTE_F			;;
	CALL MUTE_LED_RED		;;
	BTFSS MUTE_F			;;
	CALL MUTE_LED_WHITE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV HAND_STATUS,W0		;;
	CP W0,#0			;;	
	BRA Z,CSLED_H0			;;
	CP W0,#1			;;	
	BRA Z,CSLED_H1			;;
	CP W0,#2			;;	
	BRA Z,CSLED_H2			;;
CSLED_H0:				;;
	MOV CONNECT_STATUS,W0		;;
	CP W0,#2			;;
	BRA Z,CSLED_H0C2		;;
	CALL EARPHONE_LED_WHITE		;;
	CALL SPEAKER_LED_WHITE		;;
	RETURN
CSLED_H0C2:
	CALL EARPHONE_LED_BLINK		;;
	CALL SPEAKER_LED_BLINK		;;
	RETURN;				;;
CSLED_H1:				;;
	CALL EARPHONE_LED_RED		;;
	CALL SPEAKER_LED_WHITE		;;
	RETURN				;;
CSLED_H2:				;;
	CALL EARPHONE_LED_WHITE		;;
	CALL SPEAKER_LED_RED		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXPRG:				;;
	BTSS IFS0,#11			;;
	RETURN				;;	
	BCLR IFS0,#11			;;
	MOV U1RXB1,W0			;;
	MOV W0,U1RXB0			;;
	MOV U1RXB2,W0			;;
	MOV W0,U1RXB1			;;
	MOV U1RXB3,W0			;;
	MOV W0,U1RXB2			;;
	MOV U1RXB4,W0			;;
	MOV W0,U1RXB3			;;
	MOV U1RXB5,W0			;;
	MOV W0,U1RXB4			;;
	MOV U1RXB6,W0			;;
	MOV W0,U1RXB5			;;
	MOV U1RXB7,W0			;;
	MOV W0,U1RXB6			;;
	MOV U1RXREG,W0			;;
	AND #255,W0			;;
	MOV W0,U1RXB7			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFA,W0			;;
	CP U1RXB0			;;
	BRA NZ,U1RXPRG_END		;;
	MOV #0xCE,W0			;;
	CP U1RXB1			;;
	BRA NZ,U1RXPRG_END		;;
	MOV #0xA3,W0			;;
	CP U1RXB2			;;
	BRA NZ,U1RXPRG_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RXB0,W0			;;
	XOR U1RXB1,WREG			;;
	XOR U1RXB2,WREG			;;
	XOR U1RXB3,WREG			;;
	XOR U1RXB4,WREG			;;
	XOR U1RXB5,WREG			;;
	XOR U1RXB6,WREG			;;
	XOR U1RXB7,WREG			;;
	BRA NZ,U1RXPRG_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXPRG_DEC:				;;
	MOV #0xD2,W0			;;
	CP U1RXB2			;;
	BRA Z,U1RXPRG_DECN		;;
	MOV #0xA3,W0			;;
	CP U1RXB2			;;
	BRA NZ,U1RXPRG_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF,W0			;;
	CP U1RXB3			;;	
	BRA Z,U1RXPRG_1			;;
	MOV U1RXB3,W0			;;	
	RRC W0,W0			;;
	XOR U1RXB3,WREG			;;
	CLR W1				;;
	BTSC W0,#0			;;
	BSET W1,#0 			;;
	BTSC W0,#2			;;
	BSET W1,#2 			;;
	BTSC W0,#4			;;
	BSET W1,#4 			;;
	BTSC W0,#6			;;
	BSET W1,#6 			;;
	MOV W1,LEDRGF0			;;
U1RXPRG_1:				;;
	MOV #0xFF,W0			;;
	CP U1RXB4			;;	
	BRA Z,U1RXPRG_2			;;
	MOV U1RXB4,W0			;;	
	RRC W0,W0			;;
	XOR U1RXB4,WREG			;;
	CLR W1				;;
	BTSC W0,#0			;;
	BSET W1,#0 			;;
	BTSC W0,#2			;;
	BSET W1,#2 			;;
	BTSC W0,#4			;;
	BSET W1,#4 			;;
	BTSC W0,#6			;;
	BSET W1,#6 			;;
	MOV W1,LEDRGF1			;;
U1RXPRG_2:				;;
	BTSS U1RXB5,#7			;;
	BCLR LEDF4,#2			;;
	BTSC U1RXB5,#7			;;
	BSET LEDF4,#2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS U1RXB5,#6			;;
	BCLR LEDF4,#3			;;
	BTSC U1RXB5,#6			;;
	BSET LEDF4,#3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS U1RXB5,#0			;;
	BCLR LEDF4,#0			;;
	BTSC U1RXB5,#0			;;
	BSET LEDF4,#0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS U1RXB5,#1			;;
	BCLR LEDF4,#1			;;
	BTSC U1RXB5,#1			;;
	BSET LEDF4,#1			;;
U1RXPRG_END:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXPRG_DECN:				;;
	MOV #0x18,W0			;;
	CP U1RXB3			;;	
	BRA Z,U1RXPRG_D18		;;
	RETURN				;;
U1RXPRG_D18:				;;
	MOV #3,W0			;;
	CP U1RXB4			;;
	BRA LTU,$+4			;;
	RETURN				;;
	MOV U1RXB4,W0			;;	
	BRA W0				;;
	BRA U1RXPRG_D1800		;;cpl led
	BRA U1RXPRG_D1801		;;set led
	BRA U1RXPRG_D1802		;;inc back light
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXPRG_D1800:				;;CPL LED 
 	BTSC U1RXB5,#3			;;
	BRA U1RXPRG_D1800_1		;;
U1RXPRG_D1800_0:			;;
	MOV U1RXB5,W0			;;
	AND #7,W0			;;
	CALL LEDXOR_TBL			;;
	BTSS U1RXB5,#2			;;
	XOR LEDRGF0			;;
	BTSC U1RXB5,#2			;;
	XOR LEDRGF1			;;
	RETURN				;;
U1RXPRG_D1800_1:			;;
	MOV U1RXB5,W0			;;
	AND #7,W0			;;
	CALL LEDXOR_TBL			;;
	SL W0,#1,W0			;;
	BTSS U1RXB5,#2			;;
	XOR LEDRGF0			;;
	BTSC U1RXB5,#2			;;
	XOR LEDRGF1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LEDXOR_TBL:				;;	
	BRA W0 				;;
	RETLW #1,W0  			;;
	RETLW #4,W0  			;;
	RETLW #0x10,W0  		;;
	RETLW #0x40,W0  		;;
	RETLW #1,W0  			;;
	RETLW #4,W0  			;;
	RETLW #0x10,W0  		;;
	RETLW #0x40,W0  		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
U1RXPRG_D1801:				;;SET LED 
	MOV U1RXB5,W0			;;
	MOV W0,LEDRGF0			;; 		
	MOV U1RXB6,W0			;;
	MOV W0,LEDRGF1			;; 		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RXB7,W0			;; 
	AND #0x0F,W0			;;SIP STATUS
	MOV W0,SIP_STATUS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RXB7,W0			;; 
	SWAP.B W0			;;
	AND #0x0F,W0			;;HAND STATUS
	MOV W0,HAND_STATUS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RXB8,W0			;; 
	AND #0x0F,W0			;;CONNECT_STATUS
	MOV W0,CONNECT_STATUS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF MUTE_F			;;
	BTSS U1RXB9,#0			;;sip_flag0
	BCF MUTE_F			;;
 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_SIPLED
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
U1RXPRG_D1802:				;;CHANGE BACK LIGHT LED
	CALL INC_BL_LEVEL		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TXPRG:				;;
	BTSS TMR2_FLAG,#12		;;14
	RETURN				;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #DEVICE_ID_K,W0             ;;
	MOV W0,TX_DEVICE_ID             ;;
        MOV #0xffff,W0                  ;;
	MOV W0,TX_SERIAL_ID             ;;
        MOV #0xAB00,W0                  ;;
	MOV W0,TX_GROUP_ID              ;;
	MOV #0x1000,W0                  ;;              
	MOV W0,UTX_CMD                  ;;
        ;=================================
	MOV KEY_DATA,W0			;;
	MOV W0,UTX_PARA0                ;;
	MOV LEDRGF0,W0			;;
	MOV W0,UTX_PARA1                ;;
	MOV LEDRGF1,W0			;;
        AND #255,W0                     ;;
        SWAP W0                         ;;
        IOR UTX_PARA1                   ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA2                ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA3                ;;
	;=================================
        CLR UTX_BUFFER_LEN              ;;        
	BCF U1U2_F			;;
	MOV #UTX_BUF,W3			;;
	CALL UTX_STD			;;        
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPRG:					;;
	BTFSS KEYIN_F			;;
	RETURN				;;
	MOV #30,W0			;;
	CP KEY_DATA			;;
	BRA Z,KEYPRG_30K		;;
	RETURN				;;
KEYPRG_30K:				;;
INC_BL_LEVEL:				;;
	INC BL_LEVEL			;;
	MOV #3,W0			;;
	CP BL_LEVEL			;;
	BRA LTU,$+4			;;
	CLR BL_LEVEL			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
UTX_START:				;;
	BTFSS U1U2_F			;;
	BCF U1TX_EN_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	CLR UTX_BTX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	MOV W0,UTX_CHKSUM0		;;
	CLR UTX_CHKSUM1			;;
	MOV #U1TX_BUF,W1		;;
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
LOAD_UTX_WORD:				;;
	PUSH W0				;;
	CALL LOAD_UTX_BYTE		;;
	POP W0				;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
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
	MOVFF UTX_BTX,U1TX_BTX		;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BCF U1TX_END_F			;;
	BSET IFS0,#U1TXIF		;;
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



TRANS_KEY:
	BRA W0
	RETLW #0x00,W0
	RETLW #0x04,W0
	RETLW #0x08,W0
	RETLW #0x0C,W0
	RETLW #0x10,W0
	RETLW #0x14,W0
	RETLW #0x18,W0
	RETLW #0x1C,W0

	RETLW #0x01,W0
	RETLW #0x05,W0
	RETLW #0x09,W0
	RETLW #0x0D,W0
	RETLW #0x11,W0
	RETLW #0x15,W0
	RETLW #0x19,W0
	RETLW #0x1D,W0

	RETLW #0x02,W0
	RETLW #0x06,W0
	RETLW #0x0A,W0
	RETLW #0x0E,W0
	RETLW #0x12,W0
	RETLW #0x16,W0
	RETLW #0x1A,W0
	RETLW #0x1E,W0

	RETLW #0x03,W0
	RETLW #0x07,W0
	RETLW #0x0B,W0
	RETLW #0x0F,W0
	RETLW #0x13,W0
	RETLW #0x17,W0
	RETLW #0x1B,W0
	RETLW #0x1F,W0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	BCF KEYIN_F			;;
	BTSS TMR2_FLAG,#8		;;1.4MS
	RETURN				;;
	CP0 KEYIN			;;
	BRA NZ,KEYBO_YES		;;	
	CLR YESKEY_TIM			;;
	INC NOKEY_TIM			;;
	MOV #35,W0			;;80
	CP NOKEY_TIM			;;
	BRA LTU,$+4			;;
	BCF KPUSH_F			;;
	MOV #255,W0			;;
	MOV W0,KEY_DATA			;;	
	RETURN		  		;;
KEYBO_YES:				;;
	CLR NOKEY_TIM			;;
	INC YESKEY_TIM			;;
	MOV #1,W0			;;
	CP YESKEY_TIM			;;
	BRA GEU,$+4			;;
	RETURN				;;
	CLR YESKEY_TIM			;;
	BTFSC KPUSH_F 			;;
	BRA KEYBO_CON			;;
	BSF KPUSH_F 			;;	
	MOV KEYIN,W0			;;
	DEC W0,W0			;;
	AND #0x1F,W0			;;
	CALL TRANS_KEY			;;
	MOV W0,KEY_DATA			;;
	BSF KEYIN_F			;;
KEYBO_CON:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAINT_PRG:				;;
	BTSC TMR2_FLAG,#15		;;1.3MS
	RETURN				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




	







	
	


	


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
	MOV #0xA010,W0			;;/8
;	MOV #0xA000,W0			;;/1
	MOV W0,T1CON			;;
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
	MOV #0x0014,W0		;;RPI24 U1RX
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
;	MOV #0x00FF,W0		;;
;	AND RPOR3		;;
;	MOV #0x3100,W0		;;REFCLKO
;	IOR RPOR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #0x0029,W0		;;IC1 RP41
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
	BSET IPC0,#14 			;;
	BCLR IPC0,#13 			;;
	BCLR IPC0,#12 			;;
	BCLR IFS0,#T1IF			;;
	BSET IEC0,#T1IE			;;URXINT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	
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
	;MOV #107,W0	;115200		;;50MHZ
	MOV #142,W0	;115200		;;66MHZ
	;MOV #65,W0	;256000		;;66MHZ
	;MOV #47,W0	;345600		;;66MHZ
	;MOV #65,W0	;250000		;;66MHZ
	;MOV #54,W0	;250000		;;66MHZ
	;MOV #35,W0	;460800		;;66MHZ



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


TEST_TIMER:
	CLRWDT
	BTSS IFS0,#T1IF
	BRA TEST_TIMER
	BCLR IFS0,#T1IF	
	TG TEST_O
	BRA TEST_TIMER



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

	
	CLR LEDRGF0F
	CLR LEDRGF1F
	CLR LEDF0F	
	CLR LEDF1F	
	CLR LEDF2F	
	CLR LEDF3F	
	CLR LEDF4F	
        CLR SWLED_FLAG


	SETM LEDRGF0F
	SETM LEDRGF1F
	SETM LEDF0F	
	SETM LEDF1F	
	SETM LEDF2F	
	SETM LEDF3F	
	SETM LEDF4F	


	RETURN

INIT_IO:
	BSF U1TX_O
	BSF U1RX_IO
	BCF U1TX_IO
	BCF TEST_O	
	BCF TEST_IO
	
	
	BCF DB0_O
	BCF DB1_O
	BCF DB2_O
	BCF DB3_O
	BCF DB4_O
	BCF DB5_O
	BCF DB6_O
	BCF DB7_O

	BSF DB0_IO
	BSF DB1_IO
	BSF DB2_IO
	BSF DB3_IO
	BSF DB4_IO
	BSF DB5_IO
	BSF DB6_IO
	BSF DB7_IO
 
	BSF EN7_O
	BSF EN8_O
	BSF EN9_O
	BSF EN10_O
	BSF EN11_O
	BSF EN12_O
	BSF EN13_O
	BSF EN14_O
	BSF EN15_O

	BCF EN7_IO
	BCF EN8_IO
	BCF EN9_IO
	BCF EN10_IO
	BCF EN11_IO
	BCF EN12_IO
	BCF EN13_IO
	BCF EN14_IO
	BCF EN15_IO


	BSF KEYO1_O
	BSF KEYO2_O
	BSF KEYO3_O
	BSF KEYO4_O

	BCF KEYO1_IO
	BCF KEYO2_IO
	BCF KEYO3_IO
	BCF KEYO4_IO

	BCF TRIG1_O
	BCF TRIG2_O
	BCF TRIG3_O

	BCF TRIG1_IO
	BCF TRIG2_IO
	BCF TRIG3_IO

	BSF LEDCOM_O
	BCF LEDCOM_IO



	RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;U1TX_START:				;;
	BCF U1TX_EN_F			;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	CLR U1TX_LEN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00,W0			;;
	MOV W0,U1TX_CHKSUM0		;;
	MOV #U1TX_BUF,W1		;;
	MOV #0xFA,W0			;;
	CALL LOAD_U1BYTE_B		;;
	MOV #0xCE,W0			;;
	CALL LOAD_U1BYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LOAD_U1BYTE_A:				;;
	MOV W0,[W1++]			;;
	INC U1TX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LOAD_U1BYTE_B:				;;
	XOR U1TX_CHKSUM0		;;
	CALL LOAD_U1BYTE_A		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;U1TX_END:				;;
	MOV U1TX_CHKSUM0,W0		;;
	CALL LOAD_U1BYTE_B		;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BSET IFS0,#U1TXIF		;;
	BCF U1TX_WAITTX_F		;;
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
        MOV W0,RX_DEVICE_ID             ;;        
	MOV #DEVICE_ID_K,W2		;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_2		;;
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_2		;;
	RETURN				;;
CHK_U1RX_2:				;;
	MOV [W1++],W0			;;
        MOV W0,RX_SERIAL_ID             ;;        
	MOV SERIAL_ID,W2		;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_3		;;
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U1RX_3		;;
	RETURN				;;
CHK_U1RX_3:				;;
	MOV [W1++],W0			;;
	MOV W0,RX_GROUP_ID		;;
        MOV #0XAB00,W0                  ;;
        CP RX_GROUP_ID                  ;;
        BRA Z,$+4                       ;;
        RETURN                          ;;        
	MOV [W1++],W0			;;
	MOV W0,RX_LEN			;;
	MOV [W1++],W0			;;
	MOV W0,RX_CMD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA0		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA1		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA2		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA3		;;	
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
	GOTO URXDEC_GETINF_ACT		;;
	CP W0,#0x20			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_CMD_ACT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CMD_ACT:			        ;;
	MOV RX_CMD,W0			;;
	AND #0XFF,W0			;;
        CP W0,#8                        ;;
        BRA LTU,$+4                     ;;
        RETURN                          ;;
	BRA W0				;;
	BRA URXDEC_CMD_J0		;;
	BRA URXDEC_CMD_J1		;;
	BRA URXDEC_CMD_J2		;;
	BRA URXDEC_CMD_J3		;;
	BRA URXDEC_CMD_J4		;;
	BRA URXDEC_CMD_J5		;;
	BRA URXDEC_CMD_J6		;;
	BRA URXDEC_CMD_J7		;;
URXDEC_CMD_J0:          		;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CMD_J1:		                ;;      
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CMD_J2:		                ;;
        RETURN                          ;;
URXDEC_CMD_J3:		                ;;
        RETURN                          ;;
URXDEC_CMD_J4:		                ;;
        RETURN                          ;;
URXDEC_CMD_J5:		                ;;
        RETURN                          ;;
URXDEC_CMD_J6:	                        ;;
        RETURN
URXDEC_CMD_J7:		                ;;
        RETURN                          ;;
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
UTX_STD:				;;
	CALL UTX_START			;;
	MOV TX_DEVICE_ID,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TX_SERIAL_ID,W0		;;SERIAL ID
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TX_GROUP_ID,W0		;;GROUP_ID
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
UTX_BUFFER:				;;
	CP0 UTX_BUFFER_LEN		;;
	BRA Z,UTX_BUFFER_END		;;
	MOV [W3++],W0			;;
	CALL LOAD_UTX_WORD		;;
	DEC UTX_BUFFER_LEN		;;
	BRA UTX_BUFFER			;;
UTX_BUFFER_END:				;;
	CALL UTX_END			;;
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



/*
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
	CP0 W3				;;
	BRA Z,CHK_U1RX_END		;;
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
*/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_GETINF_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #0XFF,W0			;;
        CP W0,#1                        ;;
        BRA LTU,$+4                     ;;
        RETURN                          ;;
	BRA W0				;;
	BRA URXDEC_GETINF_J0		;;0X1000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_GETINF_J0:			;;
        CLR URXCON_TIM
	MOV URX_PARA0,W0		;;
        MOV W0,SWLED_FLAG               ;;
        ;AND #255,W0                    ;;
	;MOV W0,LEDRGF0			;; 		
	;MOV URX_PARA0,W0		;;
        ;SWAP W0
        ;AND #255,W0
	;MOV W0,LEDRGF1			;; 		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX_PARA1,W0		;; 
	AND #0x0F,W0			;;SIP STATUS
	MOV W0,SIP_STATUS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX_PARA1,W0		;; 
	SWAP.B W0			;;
	AND #0x0F,W0			;;HAND STATUS
	MOV W0,HAND_STATUS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX_PARA1,W0		;; 
        SWAP W0                         ;;
	AND #0x0F,W0			;;CONNECT_STATUS
	MOV W0,CONNECT_STATUS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF MUTE_F			;;
	BTSS URX_PARA2,#0		;;	;;sip_flag0
	BCF MUTE_F			;;
	CALL CHK_SIPLED                 ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UART0TX_LOAD:                           ;;
        MOV #DEVICE_ID_K,W0             ;;
	MOV W0,TX_DEVICE_ID             ;;
        MOV SERIAL_ID,W0                ;;
	MOV W0,TX_SERIAL_ID             ;;
        MOV #0xAC00,W0                  ;;
	MOV W0,TX_GROUP_ID              ;;
	MOV #0x1000,W0                  ;;              
	MOV W0,UTX_CMD                  ;;
        ;=================================
	MOV KEY_DATA,W0			;;
	MOV W0,UTX_PARA0                ;;
	MOV LEDRGF0,W0			;;
	MOV W0,UTX_PARA1                ;;
	MOV LEDRGF1,W0			;;
	MOV W0,UTX_PARA2                ;;
	MOV #0x0000,W0                  ;;
	MOV W0,UTX_PARA3                ;;
	;=================================
        CLR UTX_BUFFER_LEN              ;;        
	BCF U1U2_F			;;
	MOV #UTX_BUF,W3			;;
	CALL UTX_STD			;;        
	RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RX_CMD:				;;
	MOV #U1RX_TEMP,W1		;;
	MOV [W1++],W0			;;
	MOV W0,U1RXB2			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXB3			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXB4			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXB5			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXB6			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXB7			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXB8			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXB9			;;
	MOV [W1++],W0			;;
	MOV W0,U1RXBA			;;
	CALL U1RXPRG_DEC		;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXCMD_J3:				;;
	RETURN				;;
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
__IC2Interrupt:				;;
	BCLR IFS0,#IC2IF		;;		
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__IC3Interrupt:				;;
	BCLR IFS2,#IC3IF		;;		
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
IC1INT_END:				;;
	POP W3				;;
	POP W2				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OUTDB:
	BSF DB0_O
	BSF DB1_O
	BSF DB2_O
	BSF DB3_O
	BSF DB4_O
	BSF DB5_O
	BSF DB6_O
	BSF DB7_O
	BTSC W0,#0
	BCF DB0_O
	BTSC W0,#1
	BCF DB1_O
	BTSC W0,#2
	BCF DB2_O
	BTSC W0,#3
	BCF DB3_O
	BTSC W0,#4
	BCF DB4_O
	BTSC W0,#5
	BCF DB5_O
	BTSC W0,#6
	BCF DB6_O
	BTSC W0,#7
	BCF DB7_O
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INDB:
	MOV #0,W0
	BTFSS DB0_I
	BSET W0,#0		
	BTFSS DB1_I
	BSET W0,#1		
	BTFSS DB2_I
	BSET W0,#2		
	BTFSS DB3_I
	BSET W0,#3		
	BTFSS DB4_I
	BSET W0,#4		
	BTFSS DB5_I
	BSET W0,#5		
	BTFSS DB6_I
	BSET W0,#6		
	BTFSS DB7_I
	BSET W0,#7		
 	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INDBX:					;;
	BTFSS DB0_I			;;	
	RETLW #1,W0			;;	
	BTFSS DB1_I			;;	
	RETLW #2,W0			;;	
	BTFSS DB2_I			;;	
	RETLW #3,W0			;;	
	BTFSS DB3_I			;;	
	RETLW #4,W0			;;	
	BTFSS DB4_I			;;	
	RETLW #5,W0			;;	
	BTFSS DB5_I			;;	
	RETLW #6,W0			;;	
	BTFSS DB6_I			;;	
	RETLW #7,W0			;;	
	BTFSS DB7_I			;;	
	RETLW #8,W0			;;	
	RETLW #0,W0			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DBUS_OUT:				;;
	BCF DB0_IO			;;
	BCF DB1_IO			;;
	BCF DB2_IO			;;
	BCF DB3_IO			;;
	BCF DB4_IO			;;
	BCF DB5_IO			;;
	BCF DB6_IO			;;
	BCF DB7_IO			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DBUS_IN:				;;
	BSF DB0_IO			;;
	BSF DB1_IO			;;
	BSF DB2_IO			;;
	BSF DB3_IO			;;
	BSF DB4_IO			;;
	BSF DB5_IO			;;
	BSF DB6_IO			;;
	BSF DB7_IO			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BL_PRG:					;;
	BCF EN15_O			;;
	BCF TRIG2_O			;;
	BTSS BL_LEVEL,#1		;;
	BRA BL_PRG_0			;;	
	BCF LEDCOM_O			;;
	RETURN				;;
BL_PRG_0:				;;
	BTSS BL_LEVEL,#0		;;
	BRA BL_PRG_1			;;	
	TG LEDCOM_O			;;
	RETURN				;;	 
BL_PRG_1:				;;
	BSF LEDCOM_O			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;$Q
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T1Interrupt:				;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS0,#T1IF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC LED_FLASH_TIM		;;
	MOV #50,W0			;;
	CP LED_FLASH_TIM		;;	
	BRA LTU,$+6			;;
	TG LED_FLASH_F			;;
	CLR LED_FLASH_TIM		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	BSF KEYO1_O			;;
	BSF KEYO2_O			;;
	BSF KEYO3_O			;;
	BSF KEYO4_O			;;
	INC KEY_SCAN			;;
	BTSC KEY_SCAN,#1		;;	
	BRA T1I_1			;;
	BTSS KEY_SCAN,#0		;;
	BCF KEYO1_O			;;
	BTSC KEY_SCAN,#0		;;
	BCF KEYO2_O			;;
	BRA T1I_2			;;
T1I_1:					;;
	BTSS KEY_SCAN,#0		;;
	BCF KEYO3_O			;;
	BTSC KEY_SCAN,#0		;;
	BCF KEYO4_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
T1I_2:					;;
	CALL DBUS_OUT			;;
	MOV LEDRGF0,W0			;;
	BTFSC LED_FLASH_F		;;
	AND LEDRGF0F,WREG		;;
	CALL OUTDB			;;
	BCF EN13_O			;;
	BSF TRIG3_O			;;
	NOP				;;
	BCF TRIG3_O			;;
	BSF EN13_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LEDRGF1,W0			;;
	BTFSC LED_FLASH_F		;;
	AND LEDRGF1F,WREG		;;
	CALL OUTDB			;;
	BCF EN14_O			;;
	BSF TRIG3_O			;;
	NOP				;;
	BCF TRIG3_O			;;
	BSF EN14_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LEDF0,W0			;;
	BTFSC LED_FLASH_F		;;
	AND LEDF0F,WREG			;;
	CALL OUTDB			;;
	BCF EN8_O			;;
	BSF TRIG3_O			;;
	NOP				;;
	BCF TRIG3_O			;;
	BSF EN8_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LEDF1,W0			;;
	BTFSC LED_FLASH_F		;;
	AND LEDF1F,WREG			;;
	CALL OUTDB			;;
	BCF EN9_O			;;
	BSF TRIG3_O			;;
	NOP				;;
	BCF TRIG3_O			;;
	BSF EN9_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LEDF2,W0			;;
	BTFSC LED_FLASH_F		;;
	AND LEDF2F,WREG			;;
	CALL OUTDB			;;
	BCF EN10_O			;;
	BSF TRIG3_O			;;
	NOP				;;
	BCF TRIG3_O			;;
	BSF EN10_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LEDF3,W0			;;
	BTFSC LED_FLASH_F		;;
	AND LEDF3F,WREG			;;
	CALL OUTDB			;;
	BCF EN11_O			;;
	BSF TRIG3_O			;;
	NOP				;;
	BCF TRIG3_O			;;
	BSF EN11_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LEDF4,W0			;;
	BTFSC LED_FLASH_F		;;
	AND LEDF4F,WREG			;;
	CALL OUTDB			;;
	BCF EN12_O			;;
	BSF TRIG3_O			;;
	NOP				;;
	BCF TRIG3_O			;;
	BSF EN12_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL BL_PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL DBUS_IN			;;
	BCF EN7_O			;;
	BCF TRIG1_O			;;
	CALL INDBX			;;
	BSF EN7_O			;;
	BSF TRIG1_O			;;
	CP0 W0				;;
	BRA NZ,T1I_3			;;
	INC KEYIN_TIM			;;
	MOV #4,W0			;;
	CP KEYIN_TIM			;;
	BRA LTU,T1I_END			;;
	CLR KEYIN 			;;
	BRA T1I_END			;;	
T1I_3:					;;
	MOV W0,KEYIN			;;
	MOV KEY_SCAN,W0			;;
	AND #3,W0			;;
	SL W0,#3,W0			;;
	ADD KEYIN			;;
	CLR KEYIN_TIM			;;
T1I_END:				;;
	POP W1				;;
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


/*
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
*/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2RXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2RXIF		;;
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
	BCLR W1,#0
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
	;BCF RS485_CTL_O		;;
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
	BCLR IFS1,#U2TXIF		;;	
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
