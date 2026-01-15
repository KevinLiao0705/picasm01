;MODIUFY 2010,03,31
;  FOR EDIT WIM,TAB,ALT,CTR KEY EN/DISABLE 
	.global _INIT_ASM
	.global _MAIN_ASM
	.global _USBRP_ASM
	.global _POWER_ON
  	.global __T4Interrupt    ;Declare Timer 4 ISR name global
  	.global __U1TXInterrupt    ;Declare Timer 4 ISR name global
  	.global __U1RXInterrupt    ;Declare Timer 4 ISR name global


.EQU OLED_AMT_K		,24	
.EQU AUTO_KEY_K		,1	
.EQU OLEDPRO_TIM_K	,600

.EQU OLED00_ADR		,0x0000	
.EQU OLED01_ADR		,0x0001	
.EQU OLED02_ADR		,0x0002	
.EQU OLED03_ADR		,0x0003	
.EQU OLED04_ADR		,0x0010	
.EQU OLED05_ADR		,0x0011	
.EQU OLED06_ADR		,0x0012	
.EQU OLED07_ADR		,0x0013	

.EQU OLED08_ADR		,0x0020	
.EQU OLED09_ADR		,0x0021	
.EQU OLED10_ADR		,0x0022	
.EQU OLED11_ADR		,0x0023	
.EQU OLED12_ADR		,0x0030	
.EQU OLED13_ADR		,0x0031	
.EQU OLED14_ADR		,0x0032	
.EQU OLED15_ADR		,0x0033	

.EQU OLED16_ADR		,0x0040	
.EQU OLED17_ADR		,0x0041	
.EQU OLED18_ADR		,0x0042	
.EQU OLED19_ADR		,0x0043	
.EQU OLED20_ADR		,0x0050	
.EQU OLED21_ADR		,0x0051	
.EQU OLED22_ADR		,0x0052	
.EQU OLED23_ADR		,0x0053	

.EQU OLED24_ADR		,0x0060	
.EQU OLED25_ADR		,0x0061	
.EQU OLED26_ADR		,0x0062	
.EQU OLED27_ADR		,0x0063	
.EQU OLED28_ADR		,0x0070	
.EQU OLED29_ADR		,0x0071	
.EQU OLED30_ADR		,0x0072	
.EQU OLED31_ADR		,0x0073	

.EQU OLED32_ADR		,0x0080	
.EQU OLED33_ADR		,0x0081	
.EQU OLED34_ADR		,0x0082	
.EQU OLED35_ADR		,0x0083	
.EQU OLED36_ADR		,0x0090	
.EQU OLED37_ADR		,0x0091	
.EQU OLED38_ADR		,0x0092	
.EQU OLED39_ADR		,0x0093	

.EQU OLED40_ADR		,0x00A0	
.EQU OLED41_ADR		,0x00A1	
.EQU OLED42_ADR		,0x00A2	
.EQU OLED43_ADR		,0x00A3	
.EQU OLED44_ADR		,0x00B0	
.EQU OLED45_ADR		,0x00B1	
.EQU OLED46_ADR		,0x00B2	
.EQU OLED47_ADR		,0x00B3	

.EQU OLEDOFF_ADR	,0x00E0	


.MACRO LOFFS1 XX
        MOV #tbloffset(\XX),W1
	.ENDM


.EQU     C		,0
.EQU     Z		,1

.EQU     T4IE		,11
.EQU     T4IF		,11

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;EQU  B
.EQU     FLSCS1		,LATB
.EQU     PMAH		,LATB
.EQU     PMAL		,LATB
.EQU     PMRD		,LATB
.EQU     PMCS		,LATB
.EQU     PMWR		,LATB
.EQU     AB16		,LATB
.EQU     KEY0		,LATB
.EQU     KEY1		,LATB
.EQU     OLRST		,LATB
.EQU     OLDC		,LATB


;EQU  C
.EQU     TTEST	,LATC


;EQU  D
.EQU     IOA0		,LATD
.EQU     IOA1		,LATD
.EQU     IOA2		,LATD
.EQU     IOA3		,LATD
.EQU     IOA4		,LATD
.EQU     IOA5		,LATD


;EQU  E
.EQU     DB0		,LATE
.EQU     DB1		,LATE
.EQU     DB2		,LATE
.EQU     DB3		,LATE
.EQU     DB4		,LATE
.EQU     DB5		,LATE
.EQU     DB6		,LATE
.EQU     DB7		,LATE


;EQU  F
.EQU     PS2DATA	,LATF
.EQU     PS2CLK	,LATF

.EQU     PS2DATA_IN	,PORTF
.EQU     PS2CLK_IN	,PORTF
.EQU     PS2VCC		,PORTC


;EQU  G
.EQU     FLSCK	,LATG
.EQU     FLSDI	,LATG
.EQU     FLSCS0	,LATG
.EQU     FLSDO	,PORTG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LATB
.EQU     FLSCS1_P		,4
.EQU     PMAH_P		,6
.EQU     PMAL_P		,7
.EQU     PMRD_P		,8
.EQU     PMCS_P		,9
.EQU     PMWR_P		,10
.EQU     AB16_P		,11
.EQU     KEY0_P		,12
.EQU     KEY1_P		,13
.EQU     OLRST_P		,14
.EQU     OLDC_P		,15


;LATC
.EQU     TTEST_P		,14
.EQU     PS2VCC_P		,14


;LATD
.EQU     IOA0_P		,0
.EQU     IOA1_P		,1
.EQU     IOA2_P		,4
.EQU     IOA3_P		,5
.EQU     IOA4_P		,6
.EQU     IOA5_P		,7


;LATE
.EQU     DB0_P		,0
.EQU     DB1_P		,1
.EQU     DB2_P		,2
.EQU     DB3_P		,3
.EQU     DB4_P		,4
.EQU     DB5_P		,5
.EQU     DB6_P		,6
.EQU     DB7_P		,7


;LATF
.EQU     PS2DATA_P	,4
.EQU     PS2CLK_P		,5


;LATG
.EQU     FLSCK_P		,6
.EQU     FLSDI_P		,7
.EQU     FLSCS0_P		,9


;PORTG
.EQU     FLSDO_P		,8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;FLAGA
.EQU INTK_F		,0		
.EQU J6_F		,1		
.EQU DISKP_F		,2
.EQU DISKR_F		,3		
.EQU DISKC_F		,4		
.EQU DEBUG_F		,5		
.EQU PS2_TXBYTE_F	,6		
.EQU PS2_RXERR_F	,7	

.EQU LED_SCROLL_F	,8
.EQU LED_NUM_F		,9
.EQU LED_CAPS_F  	,10
.EQU KEYB_SCAN_DF	,11	
.EQU KEYB_TYPE_DF	,12	
.EQU KEYB_MAKE_DF	,13	
.EQU KEYB_BREAK_DF	,14	
.EQU KEYB_RESET_F	,15

;FLAGB
.EQU DLYI_RET_F		,0		
.EQU PS2_RXDATA_F	,1		
.EQU PS2_TX_F		,2
.EQU DARK_OLED_F	,3		
.EQU TEST_F		,4		
.EQU KEY_RPOFF_F	,5		
.EQU FLASH_ERR_F	,6
.EQU FLASH_AB_F		,7

.EQU FLASH_BLANK_CHKA_F	,8
.EQU U1RX_PACK_F	,9
.EQU CHK_U1RX_F  	,10
.EQU FLASH_PGM_F	,11	
.EQU LKEY_F		,12	
.EQU RKEY_F		,13	
.EQU U1RXPRG_F		,14	
;EQU KEYB_RESET_F	,15


;FLAGC 
.EQU UR_B01_F  		,0		
.EQU UR_BALL_F   	,1		
.EQU OLED2PSKEY_F	,2
.EQU WKEY_F		,3		
.EQU KEYBO_OK_F		,4		
.EQU UART_H_F		,5		
.EQU TEST_OLEDKEY_F	,6
.EQU KEYAB_F    	,7

.EQU EDKEY_F0          	,8
.EQU EDKEY_F1   	,9
.EQU EDKEY_F2    	,10
.EQU EDKEY_F3   	,11	
.EQU ALT_F		,12	
.EQU CTRL_F		,13	
.EQU SWSYSTX_STA_F	,14	
;EQU KEYB_RESET_F	,15



;TMR5_FLAG
.EQU T1M_F		,6		
.EQU T2M_F		,7		
.EQU T4M_F		,8		
.EQU T8M_F		,9		
.EQU T16M_F		,10		
.EQU T32M_F		,11		
.EQU T64M_F		,12		
.EQU T128M_F		,13		
.EQU T256M_F		,14		
.EQU T512M_F		,15		




.EQU LED00_P		,15		
.EQU LED01_P		,14		
.EQU LED02_P		,13		
.EQU LED03_P		,12		
.EQU LED04_P		,11		
.EQU LED05_P		,10		
.EQU LED06_P		,9 		
.EQU LED07_P		,8 		
.EQU LED08_P		,7 		
.EQU LED09_P		,6 		
.EQU LED10_P		,5 		
.EQU LED11_P		,4 		
.EQU LED12_P		,3 		
.EQU LED13_P		,2 		
.EQU LED14_P		,1 		
.EQU LED15_P		,0 		
.EQU LED16_P		,15		
.EQU LED17_P		,14		
.EQU LED18_P		,13		
.EQU LED19_P		,12		
.EQU LED20_P		,11		
.EQU LED21_P		,10		
.EQU LED22_P		,9 		
.EQU LED23_P		,8 		
.EQU LED24_P		,7 		
.EQU LED25_P		,6 		
.EQU LED26_P		,5 		
.EQU LED27_P		,4 		
.EQU LED28_P		,3 		
.EQU LED29_P		,2 		
.EQU LED30_P		,1 		
.EQU LED31_P		,0 		
.EQU LED32_P		,15		
.EQU LED33_P		,14		
.EQU LED34_P		,13		
.EQU LED35_P		,12		


          .section .nbss, bss, near

R0:    			.SPACE 2		;08D0
R1:				.SPACE 2
R2:				.SPACE 2		
R3:				.SPACE 2		
R4:				.SPACE 2		
R5:				.SPACE 2		
R6:				.SPACE 2		
R7:				.SPACE 2	
	
R8:				.SPACE 2		;08E0
R9:				.SPACE 2
FLAGA:			.SPACE 2
FLAGB:			.SPACE 2
FLAGC:			.SPACE 2

TMR5_BUF:		.SPACE 2
TMR5_FLAG:		.SPACE 2

FLASH_LIM:			.SPACE 2


LEDFG0:			.SPACE 2
LEDFG1:			.SPACE 2
LEDFG2:			.SPACE 2
LEDFG3:			.SPACE 2
LEDFG4:			.SPACE 2
SCANLED_CNT:		.SPACE 2

SCANK_CNT:		.SPACE 2
KEYFG:			.SPACE 2	
KEYFG0:			.SPACE 2	
KEYFG1:			.SPACE 2	
KEYFG2:			.SPACE 2	
KEYFB0:			.SPACE 2	
KEYFB1:			.SPACE 2	
KEYFB2:			.SPACE 2	
KEYFP0:			.SPACE 2	
KEYFP1:			.SPACE 2	
KEYFP2:			.SPACE 2	
KEYFR0:			.SPACE 2	
KEYFR1:			.SPACE 2	
KEYFR2:			.SPACE 2	
KEYFC0:			.SPACE 2	
KEYFC1:			.SPACE 2	
KEYFC2:			.SPACE 2	
KEYFRB0:		.SPACE 2	
KEYFRB1:		.SPACE 2	
KEYFRB2:		.SPACE 2	


YESKEY_TIM:		.SPACE 2
NOKEY_TIM:		.SPACE 2
CONKEY_TIM:		.SPACE 2

OLEDPSK0:		.SPACE 2
OLEDPSK1:		.SPACE 2
OLEDPSK2:		.SPACE 2
OLEDPSK3:		.SPACE 2


FADR0:			.SPACE 2
FADR1:			.SPACE 2
FADR2:			.SPACE 2
FLASH0_CNT:		.SPACE 2

OLED_CNT:		.SPACE 2
TEST_OLEDKEY_TIM:	.SPACE 2

SET_V0:			.SPACE 2
FIRST_PG:		.SPACE 2
EDKEY_FLAG:		.SPACE 2
SET_CUR0:		.SPACE 2
SET_CUR1:		.SPACE 2
SET_CUR2:		.SPACE 2
SET_CUR3:		.SPACE 2
SET_CUR4:		.SPACE 2
SET_CUR5:		.SPACE 2
SET_CUR6:		.SPACE 2
SET_CUR7:		.SPACE 2
SET_CUR8:		.SPACE 2
SET_OLEDPRO:		.SPACE 2
SET_V2:			.SPACE 2
SET_V3:			.SPACE 2
SET_V4:			.SPACE 2



PS2_PARITY:		.SPACE 2
PS2_BITCNT:		.SPACE 2
PS2_TXDATA0:		.SPACE 2
PS2_TXDATA1:		.SPACE 2
PS2_TXDATA2:		.SPACE 2
PS2_TXDATA3:		.SPACE 2
PS2_TXDATA4:		.SPACE 2
PS2_TXDATA5:		.SPACE 2
PS2_TXDATA6:		.SPACE 2
PS2_TXDATA7:		.SPACE 2
PS2_TXDATA8:		.SPACE 2
PS2_TXDATA9:		.SPACE 2
PS2_TXDATAA:		.SPACE 2
PS2_TXDATAB:		.SPACE 2
PS2_TXDATAC:		.SPACE 2
PS2_TXDATAD:		.SPACE 2
PS2_TXDATAE:		.SPACE 2
PS2_TXDATAF:		.SPACE 2

PS2_RXDATA:		.SPACE 2
PS2_TXTEMP:		.SPACE 2
PS2_TXBUF:		.SPACE 2
TYPEMATIC:		.SPACE 2

PS2_CMD:		.SPACE 2
CLRPS2_CMD_TIM:		.SPACE 2

DLYI_RET0:		.SPACE 2
DLYI_RET1:		.SPACE 2
PS2_TXBYTE:		.SPACE 2
PS2_TXLIM:		.SPACE 2
KEY_REPEAT_TIM:		.SPACE 2
KB_REPEAT_B0:		.SPACE 2
KB_REPEAT_B1:		.SPACE 2
PS2VCC_TIM:		.SPACE 2


KEYDDD0:   		.SPACE 2
KEYDDD1:   		.SPACE 2
KEYDDD2:   		.SPACE 2
KEYDDD3:   		.SPACE 2
KEYDDD4:   		.SPACE 2
KEYDDD5:   		.SPACE 2
KEYDDD6:   		.SPACE 2
KEYDDD7:   		.SPACE 2
KEYDDD8:   		.SPACE 2
KEYDDD9:   		.SPACE 2
KEYDDD10:   		.SPACE 2
KEYDDD11:   		.SPACE 2
KEYDDD12:   		.SPACE 2
KEYDDD13:   		.SPACE 2


KEYDDD_B:		.SPACE 28	

USBKD:   		.SPACE 2
U1TX_BUF:		.SPACE 32
U1TX_BCNT:		.SPACE 2
U1TX_BTX:		.SPACE 2
U1RX_BUF:		.SPACE 128
U1RX_TEMP:		.SPACE 128
U1RX_FIFO:		.SPACE 1280
U1RX_PCNT0: 		.SPACE 2
U1RX_PCNT1: 		.SPACE 2


U1RX_BYTE_PTR:		.SPACE 2
U1RX_BYTE:		.SPACE 2
PACK_BYTE:		.SPACE 2

TXKEY_CNT:		.SPACE 2
TXPAGE_CNT:		.SPACE 2
TXLINE_CNT:		.SPACE 2
TXBMP_CNT:		.SPACE 2
BMP_CNT:		.SPACE 2


FADR1_S:		.SPACE 2
FADR0_S:		.SPACE 2
FADR1_D:		.SPACE 2
FADR0_D:		.SPACE 2
FACT_AMT:		.SPACE 2

FLASH_BUF:		.SPACE 256
FLASH_READ_BUF:		.SPACE 256
FADR1_BUF:		.SPACE 2
FLASH_STATUS:		.SPACE 256
DEBUG_CNT:		.SPACE 2
KEY_CNT:		.SPACE 2
KEYV_BUF:		.SPACE 144

WKEY_CNT:		.SPACE 2
WPAGE_CNT:		.SPACE 2
KEY_ACTION:		.SPACE 2
KEYPFV:			.SPACE 2
KEY10V:			.SPACE 2
PAGE_CNT:		.SPACE 2
WKEY_BUF:		.SPACE 2
UART_H_TIM:		.SPACE 2
CHGPG_TIM:		.SPACE 2
EDKEY_B0:		.SPACE 2
EDKEY_B1:		.SPACE 2
EDKEY_B2:		.SPACE 2
EDKEY_B:		.SPACE 2

U1TXED_TIM:		.SPACE 2
DEBUGF:			.SPACE 2
OLEDPRO_TIM:		.SPACE 2

	.text                           ;;Start of Code section


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_OSC:				;;
	MOV #0x0000,W0			;;
	MOV W0,CLKDIV			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OUTADR:
	BCLR PMWR,#PMWR_P 
	XOR LATD,WREG
	AND #0x00F3,W0
	XOR LATD
	MOV W1,LATE
	BSET PMWR,#PMWR_P 
	MOV #0x00E0,W0
	IOR LATD	
	RETURN

LEDADR_TBL:
	BRA W0
	RETLW #OLED40_ADR,W0
	RETLW #OLED41_ADR,W0
	RETLW #OLED42_ADR,W0
	RETLW #OLED43_ADR,W0
	RETLW #OLED44_ADR,W0

SCAN_LED:
	BTSS TMR5,#T16M_F
	RETURN
	INC SCANLED_CNT
	MOV #5,W0
	CP SCANLED_CNT
	BRA LTU,$+4
	CLR SCANLED_CNT	
	;;;;;;;;;;;;;;;;;;;;;
	MOV SCANLED_CNT,W1
	BCLR W1,#0	
	MOV #LEDFG0,W0
	ADD W1,W0,W1
	MOV [W1],W1	
	BTSS SCANLED_CNT,#0
	SWAP W1
	COM W1,W1
	MOV SCANLED_CNT,W0
	CALL LEDADR_TBL
	CALL OUTADR
	RETURN

LED_PRG:
	MOV #OLED40_ADR,W0
	MOV LEDFG0,W1
	SWAP W1
	COM W1,W1
	CALL OUTADR
	MOV #OLED41_ADR,W0
	MOV LEDFG0,W1
	COM W1,W1
	CALL OUTADR

	MOV #OLED42_ADR,W0
	MOV LEDFG1,W1
	SWAP W1
	COM W1,W1
	CALL OUTADR
	MOV #OLED43_ADR,W0
	MOV LEDFG1,W1
	COM W1,W1
	CALL OUTADR

	MOV #OLED44_ADR,W0
	MOV LEDFG2,W1
	SWAP W1
	COM W1,W1
	CALL OUTADR

	RETURN
TEST_LED:
	MOV #4,W0
	MOV W0,R0
TEST_LED1:
	CALL U1TX_W			;;
	CLR LEDFG0
	CLR LEDFG1
	CLR LEDFG2
	CALL LED_PRG
	MOV #200,W0
	CALL DLYMX
	SETM LEDFG0
	SETM LEDFG1
	SETM LEDFG2
	CALL LED_PRG
	MOV #200,W0
	CALL DLYMX
	DEC R0
	BRA NZ,TEST_LED1

	CLR LEDFG0 
	CLR LEDFG1 
	CLR LEDFG2 
	BSET LEDFG0,#15
	MOV #OLED_AMT_K,W0
	MOV W0,R0
	CLR R1
TEST_LED2:
	CALL U1TX_W			;;
	MOV R1,W0
	CALL SETX_LED 	
	CALL LED_PRG
	MOV #150,W0
	CALL DLYMX
	CLR LEDFG0 
	CLR LEDFG1 
	CLR LEDFG2 
	INC R1
	DEC R0
	BRA NZ,TEST_LED2
	CALL LED_PRG
	CALL U1TX_D		;;
	RETURN
	 

;B0	:16
;B1	:32
;B2	:64
;B3	:128
;B4	:256
;B5	:512
;B6	:1.024
;B7	:2.048
;B8	:4.096
;B9	:8.192
;B10	:16.384
;B11	:32.768
;B12	:65.536
;B13	:131.072
;B14	:262.144
;B15	:524.288

TMR5PRG:
	CLR TMR5_FLAG		
	MOV TMR5,W0
	XOR TMR5_BUF,WREG
	BTSC SR,#Z
	RETURN
	MOV W0,TMR5_FLAG
	XOR TMR5_BUF
	BTSS TMR5_FLAG,#T512M_F		;;
	RETURN
	INC OLEDPRO_TIM 			;;
	MOV #OLEDPRO_TIM_K,W0
	CP OLEDPRO_TIM  
	BRA Z,$+4
	RETURN
	CALL DARK_OLED
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER:				;;
	BSET INTCON1,#15		;;
	MOV #0xA010,W0			;;
	MOV W0,T4CON			;;
	CLR TMR4			;;45US = 700
	MOV #4000,W0			;;60US = 970
	MOV W0,PR4			;;70US = 1200
	BCLR IPC6,#12			;;
	BCLR IPC6,#13   		;;
	BSET IPC6,#14   		;;
	BSET IEC1,#T4IE			;;PS2 USE
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA030,W0			;;/256
	MOV W0,T5CON			;;
	RETURN				;;				
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


BIT_TRANS:
	BRA W0
	RETLW #0x1,W0
	RETLW #0x2,W0
	RETLW #0x4,W0
	RETLW #0x8,W0
	RETLW #0x10,W0
	RETLW #0x20,W0
	RETLW #0x40,W0
	RETLW #0x80,W0
	RETLW #0x1,W0
	RETLW #0x2,W0
	RETLW #0x4,W0
	RETLW #0x8,W0
	RETLW #0x10,W0
	RETLW #0x20,W0
	RETLW #0x40,W0
	RETLW #0x80,W0
	
BITO_TRANS:
	BRA W0
	RETLW #0x80,W0
	RETLW #0x40,W0
	RETLW #0x20,W0
	RETLW #0x10,W0
	RETLW #0x8,W0
	RETLW #0x4,W0
	RETLW #0x2,W0
	RETLW #0x1,W0

					;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SPI:				;;
	MOV #OSCCON,W1			;;
	MOV #0x46,W2			;;
	MOV #0x57,W3			;;
	MOV.B W2,[W1] 			;;
	MOV.B W3,[W1]			;;
	BCLR OSCCON,#6			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x3F13,W0			;;SPI1_FLASH INPUT
	MOV W0,RPINR20			;;
	MOV #0x0007,W0			;;
	MOV W0,RPOR13			;;
	MOV #0x0800,W0			;;
	MOV W0,RPOR10			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x000A,W0			;;SPI2_OLED
	MOV W0,RPOR6			;;
	MOV #0x0B00,W0			;;
	MOV W0,RPOR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x3F17,W0			;;UART1
	MOV W0,RPINR18			;;
	MOV #0x0003,W0			;;
	MOV W0,RPOR11			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1			;;
	MOV #0x46,W2			;;
	MOV #0x57,W3			;;
	MOV.B W2,[W1] 			;;
	MOV.B W3,[W1]			;;
	BSET OSCCON,#6			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x027B,W0			;;SPI1START
	MOV W0,SPI1CON1			;;
	MOV #0x0000,W0			;;
	MOV W0,SPI1CON2			;;
	MOV #0x8000,W0			;;
	MOV W0,SPI1STAT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0273,W0			;;SPI2START
;	MOV #0x0323,W0			;;SPI2START
	MOV W0,SPI2CON1			;;
	MOV #0x0000,W0			;;
	MOV W0,SPI2CON2			;;
	MOV #0x8000,W0			;;
	MOV W0,SPI2STAT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SPI2_H:				;;
	RETURN
	MOV #0x0260,W0			;;SPI2START
	MOV W0,SPI2CON1			;;
	MOV #0x0000,W0			;;
	MOV W0,SPI2CON2			;;
	MOV #0x8000,W0			;;
	MOV W0,SPI2STAT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SPI2_L:				;;
	RETURN
	MOV #0x0263,W0			;;SPI2START
	MOV W0,SPI2CON1			;;
	MOV #0x0000,W0			;;
	MOV W0,SPI2CON2			;;
	MOV #0x8000,W0			;;
	MOV W0,SPI2STAT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_FLASH_ADR:				;;
	MOV #0x2000,W0
	MUL FLASH0_CNT
	MOV W2,FADR0
	MOV W3,FADR1
	INC FADR1
	RETURN

	MOV #0x0000,W0
	MOV W0,FADR0
	MOV #1,W0
	MOV W0,FADR1
	RETURN

	LOFFS1 TESTBMP_ADR		;;
	MOV FLASH0_CNT,W0		;;
	SL W0,#2,W0			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W0		;;
	MOV W0,FADR1			;;
	TBLRDL [W1++],W0		;;
	MOV W0,FADR2			;;
	CLR FADR0			;;
	MOV #0x0020,W0			;;
	BTSC FLAGA,#DEBUG_F		;;	
	ADD FADR1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_BLANK_CHKA:			;;
	BSET FLAGB,#FLASH_BLANK_CHKA_F	;;
	MOV #0,W0			;;
	BRA FLASH_BLANK_CHK0		;;
FLASH_BLANK_CHKS:			;;
	BCLR FLAGB,#FLASH_BLANK_CHKA_F	;;
FLASH_BLANK_CHK0:			;;
	CALL WAIT_FLASH_READY		;;
	BCLR FLAGB,#FLASH_ERR_F		;;
	CLR FADR0			;;
	CALL FLASH_CS			;;
	MOV #0x03,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	BCLR W0,#6			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;	
	CALL SPI1PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_BLANK_CHK1:			;;
	CALL SPI1PRG
	XOR #255,W0			;;
	AND #255,W0			;;
	BRA NZ,FLASH_NO_BLANK		;;
	INC FADR0			;;
	BTSS SR,#Z			;;
	BRA FLASH_BLANK_CHK1		;;
	INC FADR1			;;
	BTSS FLAGB,#FLASH_BLANK_CHKA_F	;;
	BRA FLASH_BLANK_END		;;
	BTSS FADR1,#6			;;
	BRA FLASH_BLANK_CHK1		;;
	BRA FLASH_BLANK_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_NO_BLANK:				;;
	BSET FLAGB,#FLASH_ERR_F		;;
FLASH_BLANK_END:			;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH_BYTE:			;;		;;
	CALL WAIT_FLASH_READY		;;
	CALL FLASH_CS			;;
	MOV #0x03,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	BCLR W0,#6			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;	
	CALL SPI1PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SPI1PRG			;;
	INC FADR0			;; 
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH:				;;
	CALL WAIT_FLASH_READY		;;
	CALL FLASH_CS			;;
	MOV #FLASH_BUF,W1		;;
	MOV #0x03,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	BCLR W0,#6			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;	
	CALL SPI1PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W0,SPI1BUF			;;
READ_FLASH1:				;;
	BTSC SPI1STAT,#1		;;
	BRA READ_FLASH1			;;
	BTSS SPI1STAT,#0		;;
	BRA READ_FLASH1			;;
	MOV.B SPI1BUF,WREG		;;
	AND #255,W0			;;
	BTSC FADR0,#0			;;
	BRA READ_FLASH2			;;
	SWAP W0				;;
	MOV W0,[W1]			;;
	BRA READ_FLASH3			;;
READ_FLASH2:				;;
	MOV [W1],W2			;;
	IOR W0,W2,W0			;;
	MOV W0,[W1++]			;;
READ_FLASH3:				;;
	MOV W0,SPI1BUF			;;
	INC FADR0			;;
	MOV FADR0,W0			;;
	AND #255,W0			;;
	BTSS SR,#Z			;;
	BRA READ_FLASH1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL WAIT_SPI1RDY		;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;














;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FLASH_WEN:				;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA CHK_FLASH_WEN		;;
	AND #0x001C,W0			;;
	BTSC SR,#Z			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLASH_WREN			;;
	CALL FLASH_WRSR			;;
	BRA CHK_FLASH_WEN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_WREN:				;;
	CALL FLASH_CS			;;
	MOV #0x0006,W0			;;
	CALL SPI1PRG			;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_RDSR:				;;
	CALL FLASH_CS			;;
	MOV #0x0005,W0			;;
	CALL SPI1PRG			;;
	CALL SPI1PRG			;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_WRSR:				;;
	CALL FLASH_CS			;;
	MOV #0x0001,W0			;;
	CALL SPI1PRG			;;
	MOV #0x0000,W0			;;
	CALL SPI1PRG			;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_BE:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	CALL FLASH_CS			;;
	MOV #0x00C7,W0			;;
	CALL SPI1PRG			;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_SE:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	CALL FLASH_CS			;;
	MOV #0x00D8,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	BCLR W0,#6			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;	
	CALL SPI1PRG			;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_CS:				;;
	BTSS FLAGB,#FLASH_AB_F		;;
	BCLR FLSCS0,#FLSCS0_P		;;
	BTSC FLAGB,#FLASH_AB_F		;;
	BCLR FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPI1PRG:				;;
	MOV W0,SPI1BUF			;;
SPI1PRG_0:				;;
	BTSC SPI1STAT,#1		;;
	BRA SPI1PRG_0			;;
	BTSS SPI1STAT,#0		;;
	BRA SPI1PRG_0			;;
	MOV.B SPI1BUF,WREG		;;
	AND #255,W0			;;
	RETURN
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




KEY_PRG:
	BRA W0
	BRA KEY0P
	BRA KEY1P
	BRA KEY2P
	BRA KEY3P
	BRA KEY4P
	BRA KEY5P
	BRA KEY6P
	BRA KEY7P
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY0P:				;;
	BSET KEYFG0,#15		;;
	BTSS KEYFG,#4		;;	
	BCLR KEYFG0,#15		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG0,#7		;;
	BTSS KEYFG,#3		;;
	BCLR KEYFG0,#7		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET KEYFG1,#15		;;
	BTSS KEYFG,#2		;;
	BCLR KEYFG1,#15		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG1,#7		;;
	BTSS KEYFG,#1		;;
	BCLR KEYFG1,#7		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG2,#15		;;
	BTSS KEYFG,#0		;;
	BCLR KEYFG2,#15		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY1P:				;;
	BSET KEYFG0,#14		;;
	BTSS KEYFG,#4		;;	
	BCLR KEYFG0,#14		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG0,#6		;;
	BTSS KEYFG,#3		;;
	BCLR KEYFG0,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET KEYFG1,#14		;;
	BTSS KEYFG,#2		;;
	BCLR KEYFG1,#14		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG1,#6		;;
	BTSS KEYFG,#1		;;
	BCLR KEYFG1,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG2,#14		;;
	BTSS KEYFG,#0		;;
	BCLR KEYFG2,#14 	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY2P:				;;
	BSET KEYFG0,#13		;;
	BTSS KEYFG,#4		;;	
	BCLR KEYFG0,#13		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG0,#5		;;
	BTSS KEYFG,#3		;;
	BCLR KEYFG0,#5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET KEYFG1,#13		;;
	BTSS KEYFG,#2		;;
	BCLR KEYFG1,#13		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG1,#5		;;
	BTSS KEYFG,#1		;;
	BCLR KEYFG1,#5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG2,#13		;;
	BTSS KEYFG,#0		;;
	BCLR KEYFG2,#13		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY3P:				;;
	BSET KEYFG0,#12		;;
	BTSS KEYFG,#4		;;	
	BCLR KEYFG0,#12		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG0,#4		;;
	BTSS KEYFG,#3		;;
	BCLR KEYFG0,#4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET KEYFG1,#12		;;
	BTSS KEYFG,#2		;;
	BCLR KEYFG1,#12		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG1,#4		;;
	BTSS KEYFG,#1		;;
	BCLR KEYFG1,#4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG2,#12		;;
	BTSS KEYFG,#0		;;
	BCLR KEYFG2,#12		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY4P:				;;
	BSET KEYFG0,#11		;;
	BTSS KEYFG,#4		;;	
	BCLR KEYFG0,#11		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG0,#3		;;
	BTSS KEYFG,#3		;;
	BCLR KEYFG0,#3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET KEYFG1,#11		;;
	BTSS KEYFG,#2		;;
	BCLR KEYFG1,#11		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG1,#3		;;
	BTSS KEYFG,#1		;;
	BCLR KEYFG1,#3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BSET KEYFG2,#11		;;
;	BTSS KEYFG,#0		;;
;	BCLR KEYFG2,#11		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY5P:				;;
	BSET KEYFG0,#10		;;
	BTSS KEYFG,#4		;;	
	BCLR KEYFG0,#10		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG0,#2		;;
	BTSS KEYFG,#3		;;
	BCLR KEYFG0,#2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET KEYFG1,#10		;;
	BTSS KEYFG,#2		;;
	BCLR KEYFG1,#10		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG1,#2		;;
	BTSS KEYFG,#1		;;
	BCLR KEYFG1,#2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BSET KEYFG2,#10		;;
;	BTSS KEYFG,#0		;;
;	BCLR KEYFG2,#10		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY6P:				;;
	BSET KEYFG0,#9 		;;
	BTSS KEYFG,#4		;;	
	BCLR KEYFG0,#9 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG0,#1		;;
	BTSS KEYFG,#3		;;
	BCLR KEYFG0,#1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET KEYFG1,#9 		;;
	BTSS KEYFG,#2		;;
	BCLR KEYFG1,#9 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG1,#1		;;
	BTSS KEYFG,#1		;;
	BCLR KEYFG1,#1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BSET KEYFG2,#9 		;;
;	BTSS KEYFG,#0		;;
;	BCLR KEYFG2,#9 		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY7P:				;;
	BSET KEYFG0,#8 		;;
	BTSS KEYFG,#4		;;	
	BCLR KEYFG0,#8 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG0,#0		;;
	BTSS KEYFG,#3		;;
	BCLR KEYFG0,#0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET KEYFG1,#8 		;;
	BTSS KEYFG,#2		;;
	BCLR KEYFG1,#8 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET KEYFG1,#0		;;
	BTSS KEYFG,#1		;;
	BCLR KEYFG1,#0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BSET KEYFG2,#8 		;;
;	BTSS KEYFG,#0		;;
;	BCLR KEYFG2,#8 		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SCANK_PRG:				;;
	MOV #0xFFFF,W0			;;
	MOV W0,TRISE			;; 
	BCLR KEY1,#KEY1_P		;;
	BCLR PMRD,#PMRD_P		;;
	NOP				;;
	NOP				;;
	NOP				;;
	NOP				;;
	NOP				;;
	NOP				;;
	MOV PORTE,W0			;;
	COM W0,W0			;;
	MOV W0,KEYFG			;;
	BSET PMRD,#PMRD_P		;;
	BSET KEY1,#KEY1_P		;;
	MOV #0x0000,W0			;;
	MOV W0,TRISE			;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SCANK_CNT,W0		;;
	CALL KEY_PRG 			;;
	INC SCANK_CNT			;;
	MOV #7,W0
	AND SCANK_CNT			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR KEY0,#KEY0_P		;;
	BCLR PMWR,#PMWR_P		;;
	MOV SCANK_CNT,W0		;;	
	CALL BIT_TRANS			;;
	COM W0,W0			;;
	MOV W0,LATE			;;
	BSET PMWR,#PMWR_P		;;
	BSET KEY0,#KEY0_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


INIT_RAM:
	CLR U1RX_PCNT0
	CLR U1RX_PCNT1
	CLR SCANK_CNT
	CLR PS2_TXBYTE
	CLR PS2_TXLIM
	CLR KEYFG0
	CLR KEYFG1
	CLR KEYFG2
	CLR LEDFG0
	CLR LEDFG1
	CLR LEDFG2
	CLR FLAGA
	CLR FLAGB
	CLR FLAGC
	CLR U1TX_BTX		
	CLR CHGPG_TIM
	MOV #14,W0
	MOV #KEYDDD_B,W1
	MOV #KEYDDD0,W2
INIT_RAM1:
	CLR [W1++]
	CLR [W2++]
	DEC W0,W0 
	BRA NZ,INIT_RAM1
	CLR DEBUGF 
	CLR FIRST_PG
	CALL INIT_KEYV
	RETURN


INIT_ALLKEY:
	CALL LOAD_SET
	MOV #24,W0
	CP FIRST_PG
	BRA LTU,$+4
	CLR FIRST_PG 
	CALL INIT_KEYV
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_KEYV:				;;
	MOV #36,W2			;;
	MOV #KEYV_BUF,W1		;;
INIT_KEYV1:				;;
	MOV #0,W0			;;
	MOV W0,[W1++]			;;
	DEC W2,W2			;;
	BRA NZ,INIT_KEYV1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #36,W2			;;
	MOV #KEYV_BUF+72,W1		;;
INIT_KEYV2:				;;
	MOV FIRST_PG,W0			;;
	MOV W0,[W1++]			;;
	DEC W2,W2			;;
	BRA NZ,INIT_KEYV2		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_KEYV:				;;
	MOV #36,W2			;;
	MOV #KEYV_BUF+72,W1		;;
	BTSS FLAGC,#KEYAB_F		;;
	MOV #KEYV_BUF,W1		;;
LOAD_KEYV1:				;;
	MOV W0,[W1++]			;;
	DEC W2,W2			;;
	BRA NZ,LOAD_KEYV1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







SET_UART_L:
;	MOV #415,W0	;9600
	MOV #68,W0	;57600
	MOV W0,U1BRG
	MOV #0x8008,W0
	MOV W0,U1MODE
	MOV #0x0400,W0
	MOV W0,U1STA 
	BCLR FLAGC,#UART_H_F
	RETURN
SET_UART_H:
	MOV #34,W0	;115200
	MOV W0,U1BRG
	MOV #0x8008,W0
	MOV W0,U1MODE
	MOV #0x0400,W0
	MOV W0,U1STA 
	BSET FLAGC,#UART_H_F
	RETURN
INIT_UART:
;;	MOV #415,W0	;9600
	MOV #68,W0	;57600
	MOV W0,U1BRG
	MOV #0x8008,W0
	MOV W0,U1MODE
	MOV #0x0400,W0
	MOV W0,U1STA 
	BCLR FLAGC,#UART_H_F
	BCLR IPC3,#2 
	BCLR IPC3,#1 
	BSET IPC3,#0 
	BCLR IFS0,#12		;;
	BSET IEC0,#12
	BCLR IPC2,#14 
	BCLR IPC2,#13 
	BSET IPC2,#12 
	BCLR IFS0,#11		;;
	BSET IEC0,#11
 	RETURN
	


	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_INIT_ASM:				;;
	CLRWDT				;;
	CALL INIT_OSC			;;
	CALL INIT_IO			;;
	CALL INIT_RAM			;;
	CALL INIT_SPI			;;
	CALL INIT_UART			;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	CALL LED_PRG			;;
	CALL INIT_OLED			;;
	CALL INIT_TIMER			;;
	CALL INIT_ALLKEY		
	MOV #10,W0			;;
	CALL DLYMX			;;
	CALL SETCUR_OLED
;	CALL WKP_ALL_OLED		;;
;	BSET FLAGC,#SWSYSTX_STA_F	;;
;	CLR  U1TXED_TIM			;;

	BSET FLAGC,#KEYAB_F		;;
	BTSS PS2VCC,#PS2VCC_P		;;<<
	BCLR FLAGC,#KEYAB_F		;;

	BSET RCON,#5			;;WDTEN
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_POWER_ON:				;;
;;	MOV #0x1E00,W15			;;Initalize the Stack Pointer
;;	MOV #0x1FFE,W0			;;Initialize the Stack Pointer Limit Register
;;	MOV W0,SPLIM			;;
	CALL INIT_OSC			;;
	CALL INIT_IO			;;
	CALL INIT_RAM			;;
	CALL INIT_SPI			;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	CALL LED_PRG
	CALL INIT_OLED			;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	CALL SETCUR_OLED			;;
	BRA MAIN_START



	MOV #2000,W0
	CALL DLYMX
	NOP
	NOP
	

;	BSET U1PWRC,#0
;	BSET U1CON,#3

;	MOV #0x19,W0
;	MOV W0,U1CON
;	MOV #0xB2,W0
;	MOV W0,U1CNFG1
;	CLR  U1CNFG2

;	MOV #0x0034,W0
;	MOV W0,U1OTGCON
;	MOV #0xB2,W0
;	MOV W0,U1CNFG1


;TTYY:
;	BRA TTYY

;	CALL INIT_UART1			;;
	CALL INIT_OLED			;;
;	CALL PS2INPUT			;;
TESTP:
	BCLR FLAGA,#DEBUG_F		;;
	CALL WALL_OLED			;;
	MOV #100,W0
	CALL DLYMX
;	BRA TTYY
	BSET FLAGA,#DEBUG_F		;;
	CALL SEND_FLASH0_OLED_BE	;;
	MOV #100,W0
	CALL DLYMX
	BRA TESTP
	 
MAIN_START:
	CALL INIT_TIMER			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	CALL TMR5PRG			;;
	CALL MAIN_TIME			;;
	CALL SCAN_LED			;;
	CALL SCANK_PRG			;;
	CALL KEYBO			;;
	CALL KEYPRG			;;
	BRA MAIN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERASE_FLASH:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	CALL FLASH_BE			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_FLASH_AB:				;;
	BCLR FLAGB,#FLASH_AB_F		;;
	BTSC FADR1,#6			;;
	BSET FLAGB,#FLASH_AB_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_SET:				;;
	CLR FADR0			;;
	MOV #63,W0 			;;
	MOV W0,FADR1			;;
	CALL SET_FLASH_AB		;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SET_V0,W1			;;
	MOV #FLASH_BUF,W2		;;
	MOV #16,W3			;;
SAVE_SET1:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,SAVE_SET1		;;
	 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR FADR0			;;
	MOV #63,W0 			;;
	MOV W0,FADR1			;;
	CALL FLASH_PGM			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SET:				;;
	CLR FADR0			;;
	MOV #63,W0 			;;
	MOV W0,FADR1			;;
	CALL SET_FLASH_AB		;;
	CALL READ_FLASH			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SET_V0,W2			;;
	MOV #FLASH_BUF,W1		;;
	MOV #16,W3			;;
LOAD_SET1:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;	
	BRA NZ,LOAD_SET1		;;
	 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


						
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COPY_FLASHP_X:				;;
	MOV W0,FACT_AMT			;;
COPY_FLASHP:				;;
	MOV FADR1_S,W0			;;		
	MOV W0,FADR1  			;;
	MOV FADR0_S,W0			;;
	MOV W0,FADR0			;;
	CALL SET_FLASH_AB		;;	
	CALL READ_FLASH			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR1_D,W0			;;
	MOV W0,FADR1  			;;
	MOV FADR0_D,W0			;;
	MOV W0,FADR0			;;
	CALL SET_FLASH_AB		;;	
	CALL FLASH_PGM			;;	
	MOV #0x0100,W0			;;
	ADD FADR0_D			;;  
	ADD FADR0_S			;;  
	DEC FACT_AMT			;;
	BRA NZ,COPY_FLASHP		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COPY_FLASHS:				;;
	MOV #256,W0			;;
	MOV W0,FACT_AMT			;;
COPY_FLASHS_X:				;;
	CLR FADR0_D			;; 
	CLR FADR0_S			;; 
	MOV FADR1_D,W0			;;
	MOV W0,FADR1  			;;
	CLR FADR0			;;
	CALL SET_FLASH_AB		;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COPY_FLASHS1:				;;
	MOV FADR1_S,W0			;;		
	MOV W0,FADR1  			;;
	MOV FADR0_S,W0			;;
	MOV W0,FADR0			;;
	CALL SET_FLASH_AB		;;	
	CALL READ_FLASH			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR1_D,W0			;;
	MOV W0,FADR1  			;;
	MOV FADR0_D,W0			;;
	MOV W0,FADR0			;;
	CALL SET_FLASH_AB		;;	
	CALL FLASH_PGM			;;	
	MOV #0x0010,W0			;;
	ADD FADR0_D			;;  
	ADD FADR0_S			;;  
	DEC FACT_AMT			;;
	BRA NZ,COPY_FLASHS1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

TEST_ERR1:
	MOV #0x8000,W0
	MOV W0,R0
	BRA TESTERR
TEST_ERR2:
	MOV #0x4000,W0
	MOV W0,R0
	BRA TESTERR
TESTERR:
	MOV R0,W0
	XOR LEDFG0
	CALL LED_PRG
	MOV #200,W0
	CALL DLYMX
	BRA TESTERR


 	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TESTPRG:				;;
	CALL TEST_LED			;;
	CALL TEST_OLED			;;
	RETURN
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x8000,W0			;;
	MOV W0,LEDFG0			;;
	CLR LEDFG1			;;
	CALL LED_PRG			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL TEST_FLASH			;;
	BTSC FLAGB,#FLASH_ERR_F		;;
	BRA TEST_ERR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xC000,W0			;;
	MOV W0,LEDFG0			;;
	CLR LEDFG1			;;
	CALL LED_PRG			;;
	BSET FLAGB,#FLASH_AB_F		;;
	CALL TEST_FLASH			;;
	BTSC FLAGB,#FLASH_ERR_F		;;
	BRA TEST_ERR2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	CLR FADR0			;;
	CLR FADR1			;;
	INC FADR1 			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_OLED			;;
QQYU:
	CLR FADR0			;;
	CLR FADR1			;;
	INC FADR1 			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #128,W2
	MOV #FLASH_BUF,W1
HHJJ:
	MOV #0xF800,W0
	MOV W0,[W1++]
	DEC W2,W2
	BRA NZ,HHJJ 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #24,W2
	CLR FADR0			;;
	CLR FADR1			;;
	INC FADR1 			;;
TTT:
	PUSH W2
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL FLASH_PGM			;;
	POP W2
	DEC W2,W2 
	BRA NZ,TTT
	CALL WALL_OLED			;;
	MOV #1000,W0
	CALL DLYMX

	CLR FADR0			;;
	CLR FADR1			;;
	INC FADR1 			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	MOV #128,W2
	MOV #FLASH_BUF,W1
HHJJ1:
	MOV #0x001F,W0
	MOV W0,[W1++]
	DEC W2,W2
	BRA NZ,HHJJ1 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #24,W2
	CLR FADR0			;;
	CLR FADR1			;;
	INC FADR1 			;;
TTT1:
	PUSH W2
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL FLASH_PGM			;;
	POP W2
	DEC W2,W2 
	BRA NZ,TTT1
	CALL WALL_OLED			;;
	MOV #1000,W0
	CALL DLYMX
	BRA QQYU
	

	BCLR FLAGB,#FLASH_AB_F		;;
	CALL READ_FLASH
	CALL INIT_OLED			;;
	CALL WALL_OLED			;;
	BRA TESTPRG1
	CLR FADR0			;;
	CLR FADR1			;;
	INC FADR1 			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL READ_FLASH
;;	CALL FLASH_SE			;;
;;	CALL WAIT_FLASH_READY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;	MOV #FLASH_BUF,W1		;;
;;	MOV #128,W2			;;
;;QGGHH:					;;
;;	MOV #0xF800,W0			;;
;;	MOV W0,[W1++]			;;
;;	DEC W2,W2			
;;	BRA NZ,QGGHH
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
;;	BCLR FLAGB,#FLASH_AB_F		;;
;;	MOV #24,W1			;;
;;UUIII:					;;
;;	PUSH W1				;;
;;	CALL FLASH_PGM			;;
;;	POP W1				;;
;;	DEC W1,W1			;;
;;	BRA NZ,UUIII			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	CALL TEST_OLED
	BRA TESTPRG1

	CALL TEST_LED			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x8000,W0			;;
	MOV W0,LEDFG0			;;
	CLR LEDFG1			;;
	CALL LED_PRG			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL TEST_FLASH			;;
	BTSC FLAGB,#FLASH_ERR_F		;;
	BRA TEST_ERR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xC000,W0			;;
	MOV W0,LEDFG0			;;
	CLR LEDFG1			;;
	CALL LED_PRG			;;
	BSET FLAGB,#FLASH_AB_F		;;
	CALL TEST_FLASH			;;
	BTSC FLAGB,#FLASH_ERR_F		;;
	BRA TEST_ERR2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TEST_OLED			;;
TESTPRG1:				;;
	CALL TMR5PRG			;;
	CALL SCAN_LED			;;
	CALL SCANK_PRG			;;
	CALL KEYBO			;;
	CALL TEST_KEYPRG		;;
;	BTSC TMR5_FLAG,#T512M_F		;;
;	CALL TEST_UARTTX		;;
	CALL U1RXPRG			;;
	CALL CHK_U1RX			;;	
	BRA TESTPRG1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UARTRX:				;;
	BTSS FLAGB,#U1RX_PACK_F		;;
	RETURN				;;	
	BCLR FLAGB,#U1RX_PACK_F		;;
	MOV #46,W0
	CP U1RX_BYTE
	BRA Z,$+4
	RETURN
	
	MOV #U1RX_BUF,W2
	CLR W4
	CLR W5
	MOV #21,W1
TEST_UARTRX1:
	MOV [W2++],W0
	CALL ASCII2HEX
	BTSS SR,#C
	RETURN
	ADD W0,W4,W4
	XOR W0,W5,W5
	DEC W1,W1
	BRA NZ,TEST_UARTRX1
	AND #255,W4 
	AND #255,W5 
	MOV [W2++],W0
	CALL ASCII2HEX
	BTSS SR,#C
	RETURN
	CP W0,W4
	BRA Z,$+4
	RETURN
	MOV [W2++],W0
	CALL ASCII2HEX
	BTSS SR,#C
	RETURN
	CP W0,W5
	BRA Z,$+4
	RETURN
	CALL U1TX_X
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXPRG_END:				;;
	BCLR FLAGB,#U1RX_PACK_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1FIFO:				;;
	MOV U1RX_PCNT0,W0		;;
	XOR U1RX_PCNT1,WREG 		;;
	AND #0x7F,W0			;;
	BRA NZ,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC U1RX_PCNT1,WREG		;;
	AND #0x7F,W0			;;
	MUL.UU W0,#10,W0		;;
	MOV #U1RX_FIFO,W1		;;
	ADD W0,W1,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W1			;;
	ASR W1,#1,W1			;;
	CP W1,#2			;;
	BRA LTU,U1RXPRG_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC2 W1,W1			;;
	MOV W1,PACK_BYTE		;;
	MOV #U1RX_TEMP,W3		;;
	CALL U1RXPRG0			;;
	INC U1RX_PCNT1			;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXPRG:				;;
	BCLR FLAGB,#CHK_U1RX_F		;;
	BTSS FLAGB,#U1RX_PACK_F		;;
	BRA CHK_U1FIFO			;;	
	BTSC U1RX_BYTE,#0		;;
	BRA U1RXPRG_END			;;  
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RX_BYTE,W1		;;
	ASR W1,#1,W1			;;
	CP W1,#2			;;
	BRA LTU,U1RXPRG_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC2 W1,W1			;;
	MOV W1,PACK_BYTE		;;
	MOV #U1RX_BUF,W2		;;
	MOV #U1RX_TEMP,W3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXPRG0:
	MOV [W2],W0			;;	
	AND #255,W0			;;
	XOR #0x41,W0			;;
	BSET FLAGB,#U1RXPRG_F		;;	
	BTSS SR,#Z			;;
	BCLR FLAGB,#U1RXPRG_F		;;
	BTSS FLAGB,#U1RXPRG_F		;;	
	INC W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	 
	CLR W4				;;
	CLR W5				;;
U1RXPRG1:				;;
	MOV [W2++],W0			;;
	CALL ASCII2HEX			;;
	BTSS SR,#C			;;
	BRA U1RXPRG_END			;;  
	MOV W0,[W3++]			;;
	ADD W0,W4,W4			;;
	XOR W0,W5,W5			;;
	DEC W1,W1			;;
	BRA NZ,U1RXPRG1			;;
	AND #255,W4 			;;
	AND #255,W5 			;;
	MOV [W2++],W0			;;
	CALL ASCII2HEX			;;
	BTSS SR,#C			;;
	BRA U1RXPRG_END			;;  
	CP W0,W4			;;
	BRA Z,$+4			;;
	BRA U1RXPRG_END			;;  
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGB,#U1RXPRG_F		;;	
	BRA U1RXPRG2			;;
	MOV [W2++],W0			;;
	CALL ASCII2HEX			;;
	BTSS SR,#C			;;
	BRA U1RXPRG_END			;;  
	CP W0,W5			;;
	BRA Z,$+4			;;
	BRA U1RXPRG_END			;;  
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXPRG2:				;;
	BCLR FLAGB,#U1RX_PACK_F		;;
	BSET FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX:				;;
	BTSS FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	MOV #U1RX_TEMP,W2		;;
	MOV [W2],W1			;;
	AND #255,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA1,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A1P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA2,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A2P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA3,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A3P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA4,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A4P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA5,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A5P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA6,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A6P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA7,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A7P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA8,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A8P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA9,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A9P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	CP W0,W1			;;
	BRA Z,UR_A11P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xB0,W0			;;
	CP W0,W1			;;
	BRA Z,UR_B0P			;;
	MOV #0xB1,W0			;;
	CP W0,W1			;;
	BRA Z,UR_B1P			;;
	MOV #0xB2,W0			;;
	CP W0,W1			;;
	BRA Z,UR_B2P			;;
	MOV #0xB3,W0			;;
	CP W0,W1			;;
	BRA Z,UR_B3P			;;
	MOV #0xB4,W0			;;
	CP W0,W1			;;
	BRA Z,UR_B4P			;;
	MOV #0xB5,W0			;;
	CP W0,W1			;;
	BRA Z,UR_B5P			;;
	MOV #0xB6,W0			;;
	CP W0,W1			;;
	BRA Z,UR_B6P			;;
	MOV #0xB7,W0			;;
	CP W0,W1			;;
	BRA Z,UR_B7P			;;
	MOV #0xC0,W0			;;
	CP W0,W1			;;
	BRA Z,UR_C0P			;;
	MOV #0xC1,W0			;;
	CP W0,W1			;;
	BRA Z,UR_C1P			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B7P:					;;
	CALL U1TX_D			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	MOV #U1RX_TEMP+2,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0
	MOV W0,SET_CUR0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0
	MOV W0,SET_CUR1			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0
	MOV W0,SET_CUR2			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0
	MOV W0,SET_CUR3			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0
	MOV W0,SET_CUR4			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0
	MOV W0,SET_CUR5			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0
	MOV W0,SET_CUR6			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0
	MOV W0,SET_CUR7			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #255,W0			;;
	MOV W0,W2			;;	
	MOV [W1++],W0			;;
	AND #255,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	MOV W0,SET_CUR8			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,SET_OLEDPRO		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SAVE_SET			;;
	CALL SETCUR_OLED
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P:					;;
	CALL U1TX_D			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,R0			;;	
	MOV [W1++],W0			;;
	MOV W0,R1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00,W0			;;
	CP R0				;;
	BRA Z,UR_B6P_A			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x01,W0			;;
	CP R0				;;
	BRA Z,UR_B6P_B			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x02,W0			;;
	CP R0				;;
	BRA Z,UR_B6P_C			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x03,W0			;;
	CP R0				;;
	BRA Z,UR_B6P_D			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x04,W0			;;
	CP R0				;;
	BRA Z,UR_B6P_E			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x05,W0			;;
	CP R0				;;
	BRA Z,UR_B6P_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x06,W0			;;
	CP R0				;;
	BRA Z,UR_B6P_G			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF,W0			;;
	CP R0				;;
	BRA Z,UR_B6P_Z			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P_A:				;;
	BTSC R1,#0			;;
	BSET EDKEY_FLAG,#0		;;
	BTSS R1,#0			;;
	BCLR EDKEY_FLAG,#0		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P_B:				;;
	BTSC R1,#0			;;
	BSET EDKEY_FLAG,#1		;;
	BTSS R1,#0			;;
	BCLR EDKEY_FLAG,#1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P_C:				;;
	BTSC R1,#0			;;
	BSET EDKEY_FLAG,#2		;;
	BTSS R1,#0			;;
	BCLR EDKEY_FLAG,#2		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P_D:				;;
	BTSC R1,#0			;;
	BSET EDKEY_FLAG,#3		;;
	BTSS R1,#0			;;
	BCLR EDKEY_FLAG,#3		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P_E:				;;
	BTSC R1,#0			;;
	BSET EDKEY_FLAG,#4		;;
	BTSS R1,#0			;;
	BCLR EDKEY_FLAG,#4		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P_F:				;;
	BTSC R1,#0			;;
	BSET EDKEY_FLAG,#5		;;
	BTSS R1,#0			;;
	BCLR EDKEY_FLAG,#5		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P_G:				;;
	BTSC R1,#0			;;
	BSET EDKEY_FLAG,#6		;;
	BTSS R1,#0			;;
	BCLR EDKEY_FLAG,#6		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B6P_Z:				;;
	CALL SAVE_SET			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_C0P:					;;
	CALL SET_UART_H			;;
	CLR UART_H_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_C1P:					;;
	CALL SET_UART_L			;;
	CLR UART_H_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B5P:					;;
;	CALL U1TX_D			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,R0			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00,W0			;;
	CP R0				;;
	BRA Z,UR_B5P_A			;;
	MOV #0x01,W0			;;
	CP R0				;;
	BRA Z,UR_B5P_B			;;
	RETURN
UR_B5P_A:				;;
	CALL TEST_UARTTX		;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B5P_B:				;;
	CALL U1TX_D			;;
	BCLR FLAGC,#SWSYSTX_STA_F
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	CALL TEST_UARTTX		;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B4P:					;;
	CALL U1TX_D			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W1			;;
	MOV #0,W0			;;
	CP W1,W0			;;	
	BRA Z,UR_B4A			;;
	MOV #1,W0			;;
	CP W1,W0			;;	
	BRA Z,UR_B4B			;;
	MOV #2,W0			;;
	CP W1,W0			;;	
	BRA Z,UR_B4C			;;
	RETURN
UR_B4A:  
	BCLR FLAGC,#KEYAB_F		;;
	CALL WKP_ALL_LED		;;	
	CALL WKP_ALL_OLED		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B4B:  
	BSET FLAGC,#KEYAB_F		;;
	CALL WKP_ALL_LED		;;	
	CALL WKP_ALL_OLED		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B4C:  
	BTG FLAGC,#KEYAB_F		;;
	CALL WKP_ALL_LED		;;	
	CALL WKP_ALL_OLED		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B3P:					;;
	CALL U1TX_D			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	MOV #U1RX_TEMP,W1		;;
	MOV [W1++],W0			;;
	MOV W0,R0			;;
	MOV [W1++],W0			;;
	MOV W0,R1			;;
	MOV W0,FIRST_PG			;;	
	DEC FIRST_PG			;;
	CALL SAVE_SET			;;
	CALL INIT_KEYV			;;
	CALL WKP_ALL_OLED		;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B2P:					;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,R0			;;
	MOV #0,W0			;;
	CP R0				;;
	BRA Z,TEST_LEDP			;;
	MOV #1,W0			;;
	CP R0				;;
	BRA Z,TEST_OLEDP		;;
	MOV #2,W0			;;
	CP R0				;;
	BRA Z,TEST_OLEDKEYP		;;
	MOV #6,W0			;;
	CP R0				;;
	BRA Z,END_TESTP			;;
	RETURN				;;
TEST_LEDP:				;;	
	CALL TEST_LED			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_OLEDP:				;;
	CALL TEST_OLED			;;	
	CALL INIT_KEYV			;;
	CALL WKP_ALL_OLED		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_OLEDKEYP:				;;
	BSET FLAGC,#TEST_OLEDKEY_F	;;
	CLR TEST_OLEDKEY_TIM
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
END_TESTP:				;;
	BCLR FLAGC,#TEST_OLEDKEY_F	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B1P:					;;
	BSET FLAGC,#UR_B01_F		;;	
	BRA UR_B0P1			;;
UR_B0P:					;;
	BCLR FLAGC,#UR_B01_F		;;
UR_B0P1:				;;	
;	CALL U1TX_D			;;
;	CALL U1RXPRG			;;
;	BTSC FLAGB,#CHK_U1RX_F		;;
;	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_TEMP,W1		;;
	MOV [W1++],W0			;;
	MOV W0,R0			;;
	MOV [W1++],W0			;;
	MOV W0,R1			;;
	MOV [W1++],W0			;;
	MOV W0,R2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R1,W0			;;
	AND #255,W0			;;
	XOR #255,W0			;;
	BSET FLAGC,#UR_BALL_F		;;
	BTSS SR,#Z			;;
	BCLR FLAGC,#UR_BALL_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGC,#UR_BALL_F		;;
	BRA UR_B0P2			;;
	CP0 R1				;;
	BRA NZ,$+4			;;
	RETURN				;;
	MOV #OLED_AMT_K,W0		;;
	CP R1				;;
	BRA LEU,$+4			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R1,W0			;;
	DEC W0,W0			;;
	MOV W0,KEY_CNT			;;
	BTSC FLAGC,#UR_B01_F		;;
	CALL SETX_LED			;;
	BTSS FLAGC,#UR_B01_F		;;	
	CALL CLRX_LED			;;
	BRA UR_B0P3			;;
;WRITE_ALL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B0P2:				;;
	CLR KEY_CNT			;;
UR_B0P2_L:				;;
	MOV KEY_CNT,W0			;;
	BTSC FLAGC,#UR_B01_F		;;
	CALL SETX_LED			;;
	BTSS FLAGC,#UR_B01_F		;;	
	CALL CLRX_LED			;;
	INC KEY_CNT			;;
	MOV #OLED_AMT_K,W0		;;
	CP KEY_CNT			;;
	BRA LTU,UR_B0P2_L		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC R2				;;
	MOV R2,W0			;;
	CALL LOAD_KEYV			;;
	CALL WKP_ALL_OLED		;;	
	CALL SET_UART_L			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_B0P3:				;;
	MOV KEY_CNT,W0			;;
	MOV W0,WKEY_CNT			;;
	MOV W0,OLED_CNT			;;
	CP0 R2				;;
	BTSC SR,#Z			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC R2				;;
	MOV R2,W0 			;;
	MOV W0,WPAGE_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SAVE_KEYV			;;
	CALL WKP_OLED			;;WD
	BTSC SR,#C			;;
	BRA UR_B0P3A			;;	
	CLR R1				;;
	CALL WDOLED			;;
UR_B0P3A:				;;
	CALL SAVE_KEYV			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_KEYV:				;;
	MOV #KEYV_BUF+72,W1		;;	
	BTSS FLAGC,#KEYAB_F		;;
	MOV #KEYV_BUF,W1		;;
	MOV WKEY_CNT,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W2			;;
	MOV #0xFF00,W0			;;
	AND W0,W2,W2			;;
	MOV WPAGE_CNT,W0		;;
	AND #31,W0			;;
	IOR W0,W2,W2			;;
	MOV W2,[W1]			;;
	RETURN 				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A1P:					;;
	MOV #128,W2			;;
UR_A1P0:				;;
	MOV #FLASH_STATUS,W1		;;
	CLR [W1++]			;;
	DEC W2,W2			;;
	BRA NZ,UR_A1P0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR FADR1_BUF			;; 
	MOV #1,W0			;;
	MOV W0,FLASH_LIM		;;
	MOV #U1RX_TEMP+2,W2		;;
	MOV [W2],W0			;;
	AND #255,W0			;;
	CP0 W0				;;
	BRA Z,UR_A1P1			;;
	DEC W0,W0			;;
	ASR W0,#3,W0  			;;
	INC W0,W0			;;
	ADD FLASH_LIM			;;
UR_A1P1:				;;
	CALL U1TX_W			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLRWDT				;;
	MOV FADR1_BUF,W0		;;
	MOV W0,FADR1			;;
	BSET FLAGB,#FLASH_AB_F		;;
	BTSS FADR1,#6			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	BCLR FADR1,#6			;;
	CLR FADR0			;; 
	CALL FLASH_BLANK_CHKS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_STATUS,W1		;;
	MOV FADR1_BUF,W0		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;	
	MOV #0x00,W0			;;
	BTSC FLAGB,#FLASH_ERR_F		;;
	MOV #0x01,W0			;;
	MOV W0,[W1]			;;
	INC FADR1_BUF 			;;
	MOV #1,W0			;;
	CALL DLYMX			;;
	MOV FLASH_LIM,W0		;;
	CP FADR1_BUF			;;
	BRA LTU,UR_A1P1			;;
	CALL U1TX_D			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A2P:					;;
	CLR FADR1_BUF			;;
UR_A2P1:				;;
	MOV #FLASH_STATUS,W1		;;
	MOV FADR1_BUF,W0		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	CP0 W0				;;	
	BRA Z,UR_A2P2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CLRWDT				;;
	MOV FADR1_BUF,W0		;;
	MOV W0,FADR1			;;
	BSET FLAGB,#FLASH_AB_F		;;
	BTSS FADR1,#6			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	BCLR FADR1,#6			;; 
	CLR FADR0			;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	CALL U1TX_W			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
UR_A2P2:				;;
	INC FADR1_BUF			;;
	MOV FLASH_LIM,W0		;;
	CP FADR1_BUF			;;
	BRA LTU,UR_A2P1			;;
	CALL U1TX_D			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;BMP HEAD PGM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A3P:					;;
	CALL U1TX_X
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_TEMP+4,W1		;;
	MOV [W1],W0			;;BMP_CNT
	AND #15,W0			;;
	SL W0,#4,W0			;;
	MOV #FLASH_BUF,W1		;;
	ADD W0,W1,W1			;;
	MOV #U1RX_TEMP+10,W3		;;
	MOV #8,W4			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A3P1:				;;
	MOV [W3++],W0			;;
	MOV [W3++],W2			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	MOV W0,[W1++]			;;
	DEC W4,W4			;;
	BRA NZ,UR_A3P1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLAGB,#FLASH_PGM_F		;;
	MOV #U1RX_TEMP+4,W1		;;
	MOV [W1],W0			;;
	AND #15,W0			;;
	XOR #15,W0			;;
	BRA NZ,$+4			;;
	BSET FLAGB,#FLASH_PGM_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #U1RX_TEMP+4,W1		;;
	MOV [W1++],W0			;;
	INC W0,W0			;;
	MOV [W1++],W2			;;
	XOR W2,W0,W0			;;
	AND #255,W0			;;
	BRA NZ,UR_A3P2			;;
	BSET FLAGB,#FLASH_PGM_F		;;
	CALL U1TX_D			;;
UR_A3P2:				;;
	BTSS FLAGB,#FLASH_PGM_F		;;
	RETURN				;;
	MOV #U1RX_TEMP+4,W1		;;
	MOV [W1],W0			;;
	ASR W0,#4,W0			;;
	SWAP W0				;;
	MOV W0,FADR0			;;
	CLR FADR1			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL WAIT_FLASH_READY		;;
	CALL FLASH_PGM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A4P:					;;
	CALL U1TX_X
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,TXLINE_CNT		;;
	MOV [W1++],W0			;;
	MOV W0,TXPAGE_CNT		;;
	MOV [W1++],W0			;;
	MOV W0,TXBMP_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TXLINE_CNT,W0		;;
	AND #7,W0			;;
	SL W0,#5,W0			;;
	MOV #FLASH_BUF,W1		;;
	ADD W0,W1,W1			;;
	MOV #U1RX_TEMP+10,W3		;;
	MOV #16,W4			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A4P1:				;;
	MOV [W3++],W0			;;
	MOV [W3++],W2			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	MOV W0,[W1++]			;;
	DEC W4,W4			;;
	BRA NZ,UR_A4P1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLAGB,#FLASH_PGM_F		;;
	MOV TXLINE_CNT,W0		;;
	AND #7,W0			;;
	XOR #7,W0			;;
	BRA NZ,$+4			;;
	BSET FLAGB,#FLASH_PGM_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV TXPAGE_CNT,W0		;;
	INC W0,W0			;;
	MOV TXBMP_CNT,W2		;;
	XOR W2,W0,W0			;;
	AND #255,W0			;;
	BRA NZ,UR_A4P2			;;
	MOV TXLINE_CNT,W0		;;
	XOR #191,W0			;;
	BRA NZ,UR_A4P2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGB,#FLASH_PGM_F		;;
	CALL U1TX_D			;;
UR_A4P2:				;;
	BTSS FLAGB,#FLASH_PGM_F		;;
	RETURN				;;
	MOV #0x2000,W0			;;
	MUL TXPAGE_CNT			;;
	MOV W2,FADR0			;;
	MOV W3,FADR1			;;
	INC FADR1			;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH R0				;;
	MOV TXLINE_CNT,W0		;;
	MOV W0,R0			;;
	MOV #0x00F8,W0			;;
	AND R0				;;
	MOV #32,W0			;;				;;
	MUL R0				;;
	POP R0				;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFFC0,W0			;;
	AND FADR1,WREG			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	BTSS SR,#Z			;;
	BSET FLAGB,#FLASH_AB_F		;;
	MOV #0x003F,W0			;;
	AND FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL WAIT_FLASH_READY		;;
	CALL FLASH_PGM			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TXPAGE_CNT,W0		;;
	INC W0,W0			;;
	MOV TXBMP_CNT,W2		;;
	XOR W2,W0,W0			;;
	AND #255,W0			;;
	BRA NZ,UR_A4P3			;;
	MOV TXLINE_CNT,W0		;;
	XOR #191,W0			;;
	BRA NZ,UR_A4P3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	NOP
	NOP	
	NOP
	NOP	
	NOP
	NOP	
	NOP
	NOP	
	CALL WAIT_FLASH_READY		;;
	CALL INIT_KEYV			;;
	CALL WKP_ALL_OLED		;;
	CALL SET_UART_L			;;

UR_A4P3:				;;
	NOP
	NOP	
	NOP
	NOP	
	NOP
	NOP	
	NOP
	NOP	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;ERASE FLASH ALL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A5P:					;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL ERASE_FLASH		;;
UR_A5P0:				;;
	CALL U1TX_W			;;
	MOV #10,W0			;;
	CALL DLYMX 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA UR_A5P0			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL U1TX_C			;; 
	BSET FLAGB,#FLASH_AB_F		;;
	CALL ERASE_FLASH		;;
	MOV #10,W0			;;
	CALL DLYMX 			;;
UR_A5P1:				;;
	CALL U1TX_W			;;
	MOV #10,W0			;;
	CALL DLYMX 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	BSET FLAGB,#FLASH_AB_F		;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA UR_A5P1			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL U1TX_D			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;ERASE FLASH PAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A8P:					;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,WPAGE_CNT		;;
	CLR WKEY_CNT			;;
	CALL GET_BMPADR			;;
	MOV #5,W1			;;
UR_A8P1:				;;	
	PUSH W1				;;
	CALL U1TX_W			;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	CALL U1RXPRG			;;
	POP W1				;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	INC FADR1			;;
	DEC W1,W1			;;
	BRA NZ,UR_A8P1  		;;
	CALL U1TX_D			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;CHECK BLANK PAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A9P:					;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,WPAGE_CNT		;;
	CLR WKEY_CNT			;;
	CALL GET_BMPADR			;;
	MOV #5,W0			;;
	MOV W0,R0			;;
UR_A9P1:				;;	
	CALL U1TX_W			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLASH_BLANK_CHKS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGB,#FLASH_ERR_F		;;
	BRA UR_A9P2			;;
	DEC R0				;;
	BRA NZ,UR_A9P1			;;
	CALL U1TX_D			;;
	RETURN				;;
UR_A9P2:				;;
	CALL U1TX_E			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;CHECK BLANK PAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A11P:				;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,WKEY_CNT		;;
	MOV [W1++],W0			;;
	MOV W0,WPAGE_CNT			;;
	CALL GET_BMPADR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL READ_FLASH_BYTE		;;		
	MOV #0x00FF,W1			;;
	CP W0,W1	 		;;	
	BRA NZ,UR_A11P1			;;
	CALL READ_FLASH_BYTE		;;		
	MOV #0x00FF,W1			;;
	CP W0,W1	 		;;	
	BRA NZ,UR_A11P1			;;
	CALL U1TX_D			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A11P1:				;;
	CALL U1TX_W			;;
	CLR FADR0			;;
	CLR FADR1			;;
	CALL SET_FLASH_AB		;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	CALL U1TX_W			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR R6				;;
	CALL GET_BMPADR			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	SWAP.B W0			;;
	ASR W0,#1,W0			;;
	AND #7,W0			;;
	MOV W0,R7			;;
UR_A11P2:				;;
	MOV R7,W0			;;
	CP R6				;;
	BRA Z,UR_A11P3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BMPADR			;;
	CLR FADR0			;;
	MOV #0x2000,W0			;;
	MUL R6				;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL READ_FLASH_BYTE		;;
	MOV #0x00AB,W1			;;
	CP W0,W1	 		;;	
	BRA NZ,UR_A11P3			;;
	CALL READ_FLASH_BYTE		;;		
	MOV #0x00CD,W1			;;
	CP W0,W1	 		;;	
	BRA NZ,UR_A11P3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0			;;
	AND FADR0			;;
	MOV FADR0,W0			;;	
	MOV W0,FADR0_S			;;
	MOV W0,FADR0_D			;;
	MOV FADR1,W0			;;
	MOV W0,FADR1_S			;;
	CLR FADR1_D 			;;
	MOV #32,W0			;;
	CALL COPY_FLASHP_X		;;	
	CALL U1TX_W			;;
UR_A11P3:				;;
	INC R6				;;
	MOV #8,W0			;;	
	CP R6				;;
	BRA LTU,UR_A11P2		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BMPADR			;;
	CLR FADR0			;;
	CALL FLASH_SE			;;
	CALL WAIT_FLASH_READY		;;
	CALL U1TX_W			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR R6				;;
UR_A11P4:				;;
	CLR FADR1			;;
	CLR FADR0			;;
	MOV #0x2000,W0			;;
	MUL R6				;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;
	ADDC FADR1			;;
	CALL SET_FLASH_AB		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL READ_FLASH_BYTE		;;
	MOV #0x00AB,W1			;;
	CP W0,W1	 		;;	
	BRA NZ,UR_A11P5			;;
	CALL READ_FLASH_BYTE		;;		
	MOV #0x00CD,W1			;;
	CP W0,W1	 		;;	
	BRA NZ,UR_A11P5			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BMPADR			;;
	CLR FADR0			;;
	MOV #0x2000,W0			;;
	MUL R6				;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR0,W0			;;	
	MOV W0,FADR0_S			;;
	MOV W0,FADR0_D			;;
	MOV FADR1,W0			;;
	MOV W0,FADR1_D			;;
	CLR FADR1_S 			;;
	MOV #32,W0			;;
	CALL COPY_FLASHP_X		;;	
	CALL U1TX_W			;;
UR_A11P5:				;;
	INC R6				;;
	MOV #8,W0			;;	
	CP R6				;;
	BRA LTU,UR_A11P4		;;
	MOV #20,W0			;;
	CALL DLYMX			;;
	CALL U1TX_D			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A6P:					;;
	MOV #128,W2			;;
	CLR FADR1_BUF			;; 
UR_A6P1:				;;
	CALL U1TX_W			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLRWDT				;;
	MOV FADR1_BUF,W0		;;
	MOV W0,FADR1			;;
	BSET FLAGB,#FLASH_AB_F		;;
	BTSS FADR1,#6			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	BCLR FADR1,#6			;;
	CLR FADR0			;; 
	CALL FLASH_BLANK_CHKS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGB,#FLASH_ERR_F		;;
	BRA UR_A6P2			;;
	INC FADR1_BUF 			;;
	MOV #128,W0			;;
	CP FADR1_BUF			;;
	BRA LTU,UR_A6P1			;;
	CALL U1TX_D			;;
	RETURN				;;
UR_A6P2:				;;
	CALL U1TX_E			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A7P:					;;
	MOV #U1RX_TEMP+2,W1		;;
	MOV [W1++],W0			;;
	MOV W0,TXLINE_CNT		;;
	MOV [W1++],W0			;;
	MOV W0,WPAGE_CNT		;;
	MOV [W1++],W0			;;
	MOV W0,WKEY_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TXLINE_CNT,W0		;;
	AND #7,W0			;;
	SL W0,#5,W0			;;
	MOV #FLASH_BUF,W1		;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_TEMP+10,W3		;;
	MOV #16,W4			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A7P1:				;;
	MOV [W3++],W0			;;
	MOV [W3++],W2			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	MOV W0,[W1++]			;;
	DEC W4,W4			;;
	BRA NZ,UR_A7P1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLAGB,#FLASH_PGM_F		;;
	MOV TXLINE_CNT,W0		;;
	AND #7,W0			;;
	XOR #7,W0			;;
	BRA NZ,$+4			;;
	BSET FLAGB,#FLASH_PGM_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV TXLINE_CNT,W0		;;
	XOR #192,W0			;;
	BRA NZ,UR_A7P2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGB,#FLASH_PGM_F		;;
	CALL U1TX_D			;;
	BRA UR_A7P3			;;
UR_A7P2:				;;
	CALL U1TX_X			;;
	CLR UART_H_TIM			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UR_A7P3:				;;
	BTSS FLAGB,#FLASH_PGM_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BMPADR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH R0				;;
	MOV TXLINE_CNT,W0		;;
	MOV W0,R0			;;
	MOV #0x00F8,W0			;;
	AND R0				;;
	MOV #32,W0			;;				;;
	MUL R0				;;
	POP R0				;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;
	ADDC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL WAIT_FLASH_READY		;;
	CALL FLASH_PGM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
QUR_A5P:				;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL ERASE_FLASH		;;
QUR_A5P0:				;;
	CALL U1TX_W			;;
	MOV #10,W0			;;
	CALL DLYMX 			;;
	BSET FLAGB,#FLASH_AB_F		;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA UR_A5P0			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGB,#FLASH_AB_F		;;
	CALL ERASE_FLASH		;;
QUR_A2P1:				;;
	CALL U1TX_W			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA QUR_A2P2			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGB,#FLASH_AB_F		;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA QUR_A2P2			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL U1TX_D
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
QUR_A2P2:				;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	CALL U1RXPRG			;;
	BTSC FLAGB,#CHK_U1RX_F		;;
	RETURN				;;
	DEC W1,W1			;;
	BRA NZ,UR_A2P1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL U1TX_E
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_D:					;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	MOV #'N',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_E:					;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	MOV #'R',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_W:					;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	MOV #'W',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_C:					;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	MOV #'G',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_X:					;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	MOV #'X',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASCII2HEX_ERR:	
	POP W0
ASCII2HEX_ERR1:	
	CLR W0
	POP W1
	BCLR SR,#C
	RETURN
ASCII2HEX:
	PUSH W1
	PUSH W0
	AND #255,W0
	SUB #'0',W0 
	BRA LTU,ASCII2HEX_ERR
	CP W0,#23
	BRA GEU,ASCII2HEX_ERR
	CALL ASCII2HEX_TBL
	BTSC W0,#4
	BRA ASCII2HEX_ERR
	SWAP.B W0
	MOV W0,W1
	POP W0
	SWAP W0
	AND #255,W0
	SUB #'0',W0 
	BRA LTU,ASCII2HEX_ERR1
	CP W0,#23
	BRA GEU,ASCII2HEX_ERR1
	CALL ASCII2HEX_TBL
	BTSC W0,#4
	BRA ASCII2HEX_ERR
	IOR W0,W1,W0
	POP W1
	BSET SR,#C
	RETURN

	

ASCII2HEX_TBL:
	BRA W0
	RETLW #0,W0
	RETLW #1,W0
	RETLW #2,W0
	RETLW #3,W0
	RETLW #4,W0
	RETLW #5,W0
	RETLW #6,W0
	RETLW #7,W0
	RETLW #8,W0
	RETLW #9,W0
	RETLW #16,W0
	RETLW #16,W0
	RETLW #16,W0
	RETLW #16,W0
	RETLW #16,W0
	RETLW #16,W0
	RETLW #16,W0
	RETLW #10,W0
	RETLW #11,W0
	RETLW #12,W0
	RETLW #13,W0
	RETLW #14,W0
	RETLW #15,W0



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SWSYS_UARTTX:				;;
	CLR U1TX_BTX			;;
	MOV #U1TX_BUF,W1		;;
	CLR R2				;;
	MOV #'A',W0			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	MOV #'0',W0			;;
	BTSC FLAGC,#KEYAB_F		;;
	MOV #'1',W0			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R2,W0			;;CHKSUM
	SWAP.B W0			;;
	CALL HEX2ASC			;;
	CALL LOAD_U1TX			;;
	MOV R2,W0			;;
	CALL HEX2ASC			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #'#',W0			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CLR U1TX_BCNT			;;
	MOV #'$',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY_UARTTX:				;;
	CLR U1TX_BTX			;;
	MOV #U1TX_BUF,W1		;;
	CLR R2				;;
	MOV KEY_ACTION,W0		;;
	CP W0,#0			;;
	BRA Z,KEY_UARTTX_P		;;
	CP W0,#1			;;
	BRA Z,KEY_UARTTX_R		;;
	CP W0,#2			;;
	BRA Z,KEY_UARTTX_C		;;	
	RETURN				;;
KEY_UARTTX_P:				;;
	MOV #'1',W0			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	PUSH W1				;;
	PUSH W2				;;
	MOV KEY_CNT,W0			;;
	CALL CHKX_LED			;;
	POP W2				;;
	POP W1				;;
	MOV #'0',W0			;;
	BTSS SR,#Z			;;
	MOV #'1',W0			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	BRA KEY_UARTTX1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY_UARTTX_R:				;;
	MOV #'2',W0			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	PUSH W1				;;
	PUSH W2				;;
	MOV KEY_CNT,W0			;;
	CALL CHKX_LED			;;
	POP W2				;;
	POP W1				;;
	MOV #'0',W0			;;
	BTSS SR,#Z			;;
	MOV #'1',W0			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	BRA KEY_UARTTX1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY_UARTTX_C:				;;
	MOV #'3',W0			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	PUSH W1				;;
	PUSH W2				;;
	MOV KEY_CNT,W0			;;
	CALL CHKX_LED			;;
	POP W2				;;
	POP W1				;;
	MOV #'0',W0			;;
	BTSS SR,#Z			;;
	MOV #'1',W0			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	BRA KEY_UARTTX1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY_UARTTX1:				;;
	MOV R0,W0			;;KEY_CNT
	SWAP.B W0			;;
	CALL HEX2ASC			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	MOV R0,W0			;;
	CALL HEX2ASC			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R1,W0			;;PAGE
	SWAP.B W0			;;
	CALL HEX2ASC			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	MOV R1,W0			;;
	CALL HEX2ASC			;;
	ADD R2				;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R2,W0			;;CHKSUM
	SWAP.B W0			;;
	CALL HEX2ASC			;;
	CALL LOAD_U1TX			;;
	MOV R2,W0			;;
	CALL HEX2ASC			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #'#',W0			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CLR U1TX_BCNT			;;
	MOV #'$',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


HEX2ASC:
	AND #15,W0
	CP W0,#9
	BRA GTU,HEX2ASC1
	ADD #'0',W0
	RETURN
HEX2ASC1:
	ADD #'A'-10,W0
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UARTTX:				;;
	CLR U1TX_BTX			;;
	MOV #U1TX_BUF,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #'A',W0			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #'B',W0			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #'C',W0			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #'D',W0			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #'#',W0			;;
	CALL LOAD_U1TX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CLR U1TX_BCNT			;;
	MOV #'$',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1TX:				;;
	BTSC U1TX_BTX,#0		;;
	BRA LOAD_U1TX1			;;
	MOV W0,[W1]			;;
	INC U1TX_BTX			;;
	RETURN				;;
LOAD_U1TX1:				;;
	SWAP W0				;;
	MOV [W1],W2			;;
	IOR W0,W2,W0			;;
	MOV W0,[W1++]			;;
	INC U1TX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_RKEY:				;;
	BCLR FLAGB,#RKEY_F		;;
	BCLR FLAGB,#LKEY_F		;;
	MOV KEYFP0,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA NZ,CHK_RKEY_P		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KEYFP1,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA Z,CHK_RKEY_00		;;
	ADD #16,W1			;;
	BRA CHK_RKEY_P			;;
CHK_RKEY_00:				;;
	MOV KEYFP2,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA Z,CHK_RKEY_0		;;
	ADD #32,W1			;;
	BRA CHK_RKEY_P			;;
CHK_RKEY_0:				;;
	MOV KEYFR0,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA NZ,CHK_RKEY_R		;;	
	MOV KEYFR1,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA Z,CHK_RKEY_11		;;
	ADD #16,W1			;;
	BRA CHK_RKEY_R			;;
CHK_RKEY_11:				;;
	MOV KEYFR2,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA Z,CHK_RKEY_1		;;
	ADD #32,W1			;;
	BRA CHK_RKEY_R			;;
CHK_RKEY_1:				;;
	MOV KEYFC0,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA NZ,CHK_RKEY_C		;;	
	MOV KEYFC1,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA Z,CHK_RKEY_22		;;
	ADD #16,W1			;;
	BRA CHK_RKEY_C			;;
CHK_RKEY_22:				;;
	MOV KEYFC2,W0			;;
	FF1R W0,W1			;;
	CP0 W1				;;
	BRA Z,CHK_RKEY_2		;;
	ADD #32,W1			;;
	BRA CHK_RKEY_C			;;
CHK_RKEY_2:				;;
	RETURN				;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_RKEY_P:				;;
	CLR KEY_ACTION			;;
	BRA CHK_RKEY1			;;
CHK_RKEY_R:				;;
	MOV #1,W0			;;
	MOV W0,KEY_ACTION		;;
	BRA CHK_RKEY1			;;
CHK_RKEY_C:				;;
	MOV #2,W0			;;
	MOV W0,KEY_ACTION		;;
	BRA CHK_RKEY1			;;
CHK_RKEY1:				;;
	BSET FLAGB,#LKEY_F		;;
	MOV W1,W0			;;
	CALL KEY_TRANS_TBL		;;
	MOV W0,KEY_CNT			;;
	MOV W0,WKEY_CNT			;;
	MOV #KEYV_BUF+72,W1		;;
	BTSS FLAGC,#KEYAB_F		;;
	MOV #KEYV_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	AND #31,W0			;;
	MOV W0,PAGE_CNT			;;			
	MOV W0,WPAGE_CNT		;;			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BMPADR			;;
	CALL READ_FLASH_BYTE		;;
	MOV #0xAB,W1			;;
	CP W0,W1			;;
	BRA Z,$+4			;;
	RETURN				;;
	CALL READ_FLASH_BYTE		;;
	MOV #0xCD,W1			;;
	CP W0,W1			;;
	BRA Z,$+4			;;
	RETURN				;;
	CLR TEST_OLEDKEY_TIM		;;
	BTSC FLAGC,#TEST_OLEDKEY_F	;;
	RETURN				;;
	MOV #4,W0			;;
	ADD FADR0			;;
	CALL READ_FLASH_BYTE		;;
	MOV W0,R1			;;
	CALL READ_FLASH_BYTE		;;
	MOV W0,R2			;;
	CALL READ_FLASH_BYTE		;;
	MOV W0,R3			;;
	CALL READ_FLASH_BYTE		;;
	MOV W0,R4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	MOV R4,W0			;;		
	SWAP W0				;;
	IOR R3				;;
	MOV R3,W0			;;
	MOV W0,KEY10V			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R2,W0			;;	
	MOV W0,KEYPFV			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGB,#RKEY_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_KEYPRG:				;;
OLED_KEYPRG:				;;
	CALL CHK_RKEY			;;
	BTSS FLAGB,#LKEY_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET DEBUGF,#0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KEY_CNT,W0			;;
	MOV W0,R0			;;
	INC R0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV PAGE_CNT,W0			;;
	MOV W0,R1			;;
	INC R1				;;
	BTSS FLAGB,#RKEY_F		;;
	CLR R1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;
	CP KEY_ACTION			;;
	BRA Z,KEY_P_A			;;
	MOV #1,W0			;;
	CP KEY_ACTION			;;
	BRA Z,KEY_R_A			;;
	MOV #2,W0			;;
	CP KEY_ACTION			;;
	BRA Z,KEY_C_A			;;
	RETURN				;;
KEY_P_A:				;;
;	BTSS KEYPFV,#12			;;
;	RETURN				;;
	BTSC FLAGC,#WKEY_F
	BRA KEY_P_A1			
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #AUTO_KEY_K,W0		;;
	CP0 W0				;;
	BRA NZ,KEY_P_A0 		;;
	BTSC EDKEY_FLAG,#5		;;
	BRA KEY_P_A1			;;
	MOV KEY_CNT,W0			;;
	MOV W0,WKEY_BUF			;;
	BRA KEY_P_A00			;;
KEY_P_A0:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KEY_CNT,W0			;;
	MOV W0,WKEY_BUF			;;
	MOV W0,WKEY_CNT			;;
	MOV W0,OLED_CNT			;;
	MOV #1,W0			;;
	MOV W0,WPAGE_CNT		;;
	CALL WKP_OLED			;;WD
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY_P_A00:
	MOV KEY_CNT,W0			;;
	CALL SETX_LED			;;
	MOV KEY_CNT,W0			;;
	MOV W0,R0			;;
	INC R0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV PAGE_CNT,W0			;;
	MOV W0,R1			;;
	INC R1				;;
	BTSS FLAGB,#RKEY_F		;;
	CLR R1				;;
	BSET FLAGC,#WKEY_F		;;
KEY_P_A1:				;;
	BTSS FLAGB,#RKEY_F		;;
	BRA OLED_KEYPRG1		;;
	BTSS KEYPFV,#0			;;
	RETURN				;;
	BSET FLAGC,#OLED2PSKEY_F	;;
	BRA OLED_KEYPRG1		;;
KEY_R_A:				;;
	BTSS FLAGB,#RKEY_F		;;
	RETURN				;;
	BTSS KEYPFV,#1			;;
	RETURN				;;
	BRA OLED_KEYPRG1		;;
KEY_C_A:				;;
	BTSS FLAGB,#RKEY_F		;;
	RETURN				;;
	BTSS KEYPFV,#2			;;
	RETURN				;;
	BSET FLAGC,#OLED2PSKEY_F	;;
	BRA OLED_KEYPRG1		;;
OLED_KEYPRG1:				;;
	CALL KEY_UARTTX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV KEY_CNT,W0			;;
;	CALL XORX_LED			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


XORX_LED:
	MOV #KEYV_BUF+72,W1
	BTSS FLAGC,#KEYAB_F 
	MOV #KEYV_BUF,W1
	ADD W0,W1,W1
	ADD W0,W1,W1
	MOV [W1],W2
	BTG W2,#15
	MOV W2,[W1]
	;;;;;;;;;;;;;;;;;;;;
	CALL LED_TRANS_TBL
	MOV #LEDFG0,W2
	BTSC W0,#8
	MOV #LEDFG1,W2
	BTSC W0,#9
	ADD #4,W2
	AND #15,W0
	MOV W0,W1
	CALL BIT_TRANS
	BTSC W1,#3
	SWAP W0
	MOV [W2],W1
	XOR W0,W1,W0
	MOV W0,[W2]
	RETURN
SETX_LED:
	MOV #KEYV_BUF+72,W1
	BTSS FLAGC,#KEYAB_F 
	MOV #KEYV_BUF,W1
	ADD W0,W1,W1
	ADD W0,W1,W1
	MOV [W1],W2
	BSET W2,#15
	MOV W2,[W1]
	;;;;;;;;;;;;;;;;;;;;
	CALL LED_TRANS_TBL
	MOV #LEDFG0,W2
	BTSC W0,#8
	MOV #LEDFG1,W2
	BTSC W0,#9
	ADD #4,W2
	AND #15,W0
	MOV W0,W1
	CALL BIT_TRANS
	BTSC W1,#3
	SWAP W0
	MOV [W2],W1
	IOR W0,W1,W0
	MOV W0,[W2]
	RETURN
CLRX_LED:
	MOV #KEYV_BUF+72,W1
	BTSS FLAGC,#KEYAB_F 
	MOV #KEYV_BUF,W1
	ADD W0,W1,W1
	ADD W0,W1,W1
	MOV [W1],W2
	BCLR W2,#15
	MOV W2,[W1]
	;;;;;;;;;;;;;;;;;;;;
	CALL LED_TRANS_TBL
	MOV #LEDFG0,W2
	BTSC W0,#8
	MOV #LEDFG1,W2
	BTSC W0,#9
	ADD #4,W2
	AND #15,W0
	MOV W0,W1
	CALL BIT_TRANS
	BTSC W1,#3
	SWAP W0
	COM W0,W0
	MOV [W2],W1
	AND W0,W1,W0
	MOV W0,[W2]
	RETURN
CHKX_LED:
	CALL LED_TRANS_TBL
	MOV #LEDFG0,W2
	BTSC W0,#8
	MOV #LEDFG1,W2
	BTSC W0,#9
	ADD #4,W2
	AND #15,W0
	MOV W0,W1
	CALL BIT_TRANS
	BTSC W1,#3
	SWAP W0
	MOV [W2],W1
	AND W0,W1,W0
	RETURN

		

LED_TRANS_TBL:
	MOV #OLED_AMT_K,W2
	CP W2,#24
	BRA NZ,LED_TRANS_TBL36
LED_TRANS_TBL24:	
	BRA W0
	RETLW #0x00F,W0
	RETLW #0x00E,W0
	RETLW #0x00D,W0
	RETLW #0x00C,W0
	RETLW #0x007,W0
	RETLW #0x006,W0
	RETLW #0x005,W0
	RETLW #0x004,W0
	RETLW #0x10F,W0
	RETLW #0x10E,W0
	RETLW #0x10D,W0
	RETLW #0x10C,W0
	RETLW #0x00B,W0
	RETLW #0x00A,W0
	RETLW #0x009,W0
	RETLW #0x008,W0
	RETLW #0x003,W0
	RETLW #0x002,W0
	RETLW #0x001,W0
	RETLW #0x000,W0
	RETLW #0x10B,W0
	RETLW #0x10A,W0
	RETLW #0x109,W0
	RETLW #0x108,W0

LED_TRANS_TBL36:	
	BRA W0
	RETLW #0x00F,W0
	RETLW #0x00E,W0
	RETLW #0x00D,W0
	RETLW #0x00C,W0

	RETLW #0x10A,W0
	RETLW #0x109,W0
	RETLW #0x108,W0
	RETLW #0x107,W0

	RETLW #0x000,W0
	RETLW #0x10F,W0
	RETLW #0x10E,W0
	RETLW #0x104,W0
	;;;;;;;;;;;;;;;;
	RETLW #0x00B,W0
	RETLW #0x00A,W0
	RETLW #0x009,W0
	RETLW #0x008,W0

	RETLW #0x106,W0
	RETLW #0x105,W0
	RETLW #0x006,W0
	RETLW #0x005,W0

	RETLW #0x103,W0
	RETLW #0x102,W0
	RETLW #0x101,W0
	RETLW #0x100,W0
	;;;;;;;;;;;;;;;;
	RETLW #0x007,W0
	RETLW #0x10D,W0
	RETLW #0x10C,W0
	RETLW #0x10B,W0

	RETLW #0x004,W0
	RETLW #0x003,W0
	RETLW #0x002,W0
	RETLW #0x001,W0

	RETLW #0x20F,W0
	RETLW #0x20E,W0
	RETLW #0x20D,W0
	RETLW #0x20C,W0
	;;;;;;;;;;;;;;;;



	
KEY_TRANS_TBL:
	MOV #OLED_AMT_K,W2
	CP W2,#24
	BRA NZ,KEY_TRANS_TBL36
KEY_TRANS_TBL24:	
	BRA W0	
	RETLW #99,W0	;0
	RETLW #19,W0	;1
	RETLW #18,W0	;2
	RETLW #17,W0	;3
	RETLW #16,W0	;4
	RETLW #7,W0	;5
	RETLW #6,W0	;6
	RETLW #5,W0	;7
	RETLW #4,W0	;8
	RETLW #15,W0	;9
	RETLW #14,W0	;10
	RETLW #13,W0	;11
	RETLW #12,W0	;12
	RETLW #3,W0	;13
	RETLW #2,W0	;14
	RETLW #1,W0	;15
	RETLW #0,W0	;16
	;;;;;;;;;;;;;;;;;;;;
	RETLW #99,W0	;17
	RETLW #99,W0	;18
	RETLW #99,W0	;19
	RETLW #99,W0	;20
	RETLW #99,W0	;21
	RETLW #99,W0	;22
	RETLW #99,W0	;23
	RETLW #99,W0	;24
	RETLW #23,W0	;25
	RETLW #22,W0	;26
	RETLW #21,W0	;27
	RETLW #20,W0	;28
	RETLW #11,W0	;29
	RETLW #10,W0	;30
	RETLW #9,W0	;31
	RETLW #8,W0	;32



KEY_TRANS_TBL36:	
	BRA W0	
	RETLW #99,W0	;0
	RETLW #7,W0	;1
	RETLW #6,W0	;2
	RETLW #5,W0	;3
	RETLW #4,W0	;4
	RETLW #27,W0	;5
	RETLW #26,W0	;6
	RETLW #25,W0	;7
	RETLW #24,W0	;8
	RETLW #15,W0	;9
	RETLW #14,W0	;10
	RETLW #13,W0	;11
	RETLW #12,W0	;12
	RETLW #3,W0	;13
	RETLW #2,W0	;14
	RETLW #1,W0	;15
	RETLW #0,W0	;16
	;;;;;;;;;;;;;;;;;;;;
	RETLW #23,W0	;17
	RETLW #22,W0	;18
	RETLW #21,W0	;19
	RETLW #20,W0	;20
	RETLW #11,W0	;21
	RETLW #10,W0	;22
	RETLW #9,W0	;23
	RETLW #8,W0	;24
	RETLW #31,W0	;25
	RETLW #30,W0	;26
	RETLW #29,W0	;27
	RETLW #28,W0	;28
	RETLW #19,W0	;29
	RETLW #18,W0	;30
	RETLW #17,W0	;31
	RETLW #16,W0	;32
	;;;;;;;;;;;;;;;;;;;;
	RETLW #99,W0	;33
	RETLW #99,W0	;34
	RETLW #99,W0	;35
	RETLW #99,W0	;36
	RETLW #99,W0	;37
	RETLW #99,W0	;38
	RETLW #99,W0	;39
	RETLW #99,W0	;40
	RETLW #99,W0	;41
	RETLW #99,W0	;42
	RETLW #99,W0	;43
	RETLW #99,W0	;44
	RETLW #35,W0	;45
	RETLW #34,W0	;47
	RETLW #33,W0	;47
	RETLW #32,W0	;48




BMPPAGE_ADR:	
	BRA W0	
	RETLW #1,W0	;1
	RETLW #6,W0	;2
	RETLW #11,W0	;3
	RETLW #16,W0	;4
	RETLW #21,W0	;5
	RETLW #26,W0	;6
	RETLW #31,W0	;7
	RETLW #36,W0	;8
	RETLW #41,W0	;9
	RETLW #46,W0	;10
	RETLW #51,W0	;11
	RETLW #56,W0	;12
	RETLW #65,W0	;13
	RETLW #70,W0	;14
	RETLW #75,W0	;15
	RETLW #80,W0	;16
	RETLW #85,W0	;17
	RETLW #90,W0	;18
	RETLW #95,W0	;19
	RETLW #100,W0	;20
	RETLW #105,W0	;21
	RETLW #110,W0	;22
	RETLW #115,W0	;23
	RETLW #120,W0	;24


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH:			;;
	CLR FADR0		;;
	CLR FADR1		;;
	CALL FLASH_SE		;;
	CALL WAIT_FLASH_READY	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR FADR0		;;
	CLR FADR1		;;
	CALL FLASH_BLANK_CHKS	;;
	BTSC FLAGB,#FLASH_ERR_F	;;
	BRA TEST_FLASH_ERR	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_BUF,W1	;;
	MOV #128,W0		;;
	MOV #0x0100,W2		;;
TEST_FLASH1:			;;
	MOV W2,[W1++]		;;
	ADD #0x0202,W2		;;
	DEC W0,W0		;;
	BRA NZ,TEST_FLASH1	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CLR FADR0		;;
	CLR FADR1		;;
	CALL FLASH_PGM		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR FADR0		;;
	CLR FADR1		;;
	CALL VARIFY_FLASH	;;
	BTSC FLAGB,#FLASH_ERR_F	;;
	BRA TEST_FLASH_ERR	;;
	RETURN   		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH_ERR:			;;
	RETURN   		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WAIT_FLASH_READY:			;;
	CLRWDT				;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA WAIT_FLASH_READY		;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA WAIT_FLASH_READY		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HIGH BYTE WRITE FIRST
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
FLASH_PGM:				;;
	CALL CHK_FLASH_WEN		;;	
	CALL FLASH_WREN			;;
	CALL FLASH_CS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x02,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;	
	CALL SPI1PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_BUF,W1		;;
FLASH_PGM0:				;;			
	MOV [W1],W0			;;
	BTSC FADR0,#0			;;
	INC2 W1,W1 			;;
	BTSS FADR0,#0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	INC FADR0			;;
	MOV FADR0,W0			;;
	AND #255,W0			;;
	BRA NZ,FLASH_PGM0		;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;	MOV W0,SPI1BUF			;;
;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;FLASH_PGM0:				;;			
	INC FADR0			;;
	MOV FADR0,W0			;;
	AND #255,W0			;;
	BRA Z,FLASH_PGM2		;;
	MOV [W1],W2			;;
	BTSS FADR0,#0			;;
	SWAP W2 			;;
	BTSC FADR0,#0			;;
	INC2 W1,W1 			;;
FLASH_PGM1:				;;
	BTSC SPI1STAT,#1		;;
	BRA FLASH_PGM1			;;
	BTSS SPI1STAT,#0		;;
	BRA FLASH_PGM1			;;
	MOV.B SPI1BUF,WREG		;;
	MOV W2,SPI1BUF			;;
	BRA FLASH_PGM0			;;
FLASH_PGM2:				;;
	CALL WAIT_SPI1RDY		;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WAIT_SPI1RDY:				;;
	BTSC SPI1STAT,#1		;;
	BRA WAIT_SPI1RDY		;;
	BTSS SPI1STAT,#0		;;
	BRA WAIT_SPI1RDY		;;
	MOV.B SPI1BUF,WREG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VARIFY_FLASH:				;;
	CALL WAIT_FLASH_READY		;;
	BCLR FLAGB,#FLASH_ERR_F		;;
	CALL FLASH_CS			;;
	MOV #0x03,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;	
	CALL SPI1PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BRA HHY
	MOV #FLASH_BUF,W1		;;
;	MOV W0,SPI1BUF			;;
VARIFY_1:				;;
	CALL SPI1PRG
;	BTSC SPI1STAT,#1		;;
;	BRA VARIFY_1			;;
;	BTSS SPI1STAT,#0		;;
;	BRA VARIFY_1			;;
;	MOV.B SPI1BUF,WREG		;;
;	MOV W0,SPI1BUF			;;
	MOV [W1],W2			;;
	BTSS FADR0,#0			;;
	SWAP W2				;;
	BTSC FADR0,#0			;;
	INC2 W1,W1			;;
	XOR W0,W2,W0			;;
	AND #255,W0			;;
	BRA NZ,VARIFY_ERR		;;
	INC FADR0			;;
	MOV FADR0,W0			;;
	AND #255,W0			;;
	BTSS SR,#Z			;;
	BRA VARIFY_1			;;
;	CALL WAIT_SPI1RDY		;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VARIFY_ERR:				;;
	BSET FLAGB,#FLASH_ERR_F		;;
	CALL WAIT_SPI1RDY		;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_TO_RAM:				;;
	CALL WAIT_FLASH_READY		;;
	CALL FLASH_CS			;;
	MOV #0x03,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	BCLR W0,#6			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;	
	CALL SPI1PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #FLASH_BUF,W1		;;
FTR_0:					;;
	CALL SPI1PRG			;;
	MOV [W1],W2			;;
	BTSC FADR0,#0			;;
	BRA FTR_1			;;
	SWAP W2				;;
	MOV W2,W3			;;
	BRA FTR_2			;;
FTR_1:					;;
	IOR W2,W3,W3			;;
	MOV W3,[W1++]			;;
FTR_2:					;;
	INC FADR0			;;
	MOV FADR0,W0			;;
	AND #255,W0			;;
	BTSS SR,#Z			;;
	BRA FTR_0			;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_MAIN_ASM:				;;
;	CALL TESTPRG
;	BRA _MAIN_ASM


	CLRWDT				;;
	CALL TMR5PRG			;;
	CALL MAIN_TIME			;;
	CALL SCAN_LED			;;
	CALL SCANK_PRG			;;
	CALL KEYBO			;;
	CALL OLED_KEYPRG		;;
	CALL U1RXPRG			;;
	CALL CHK_U1RX			;;	
	CALL TR_OLEDPS			;;
	CALL USBKEY_PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
USBKEY_PRG:				;;
	BTSC FLAGB,#PS2_TX_F		;;
	RETURN				;;
	CLR PS2_TXLIM			;;
	CALL USBKEY_D			;;
	CALL USBKEY			;;
	CP0 PS2_TXLIM			;;
	BRA NZ,$+4			;;
	RETURN				;;
	BTSC FLAGB,#DARK_OLED_F
	CALL SETCUR_OLED
	CLR OLEDPRO_TIM			;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OLEDKEY_PRG:				;;
	BTSC FLAGB,#PS2_TX_F		;;
	RETURN				;;
	CLR PS2_TXLIM			;;
	CALL USBKEY_D			;;
	CALL USBKEY			;;
	CP0 PS2_TXLIM			;;
	BRA NZ,$+4			;;
	RETURN				;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
USBKEY_D:				;;
	MOV #14,W3			;;
	MOV #KEYDDD_B,W1		;;
USBKEY_D0:				;;
	MOV [W1++],W2			;;
	CP0 W2				;;
	BRA Z,USBKEY_D2			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #14,W6			;;
	MOV #KEYDDD0,W4			;;
USBKEY_D1:				;;
	MOV [W4++],W5			;;
	CP W2,W5			;;
	BRA Z,USBKEY_D2			;;
	DEC W6,W6			;;
	BRA NZ,USBKEY_D1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
USBKEY_DN:				;;
	MOV W2,W0			;;
	BSET FLAGB,#KEY_RPOFF_F		;;
	CALL TRANS_PS2_KEY		;;
	BRA USBKEY_D3			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
USBKEY_D2:				;;
	DEC W3,W3			;;
	BRA NZ,USBKEY_D0		;;
	RETURN				;;
USBKEY_D3:				;;
	MOV #14,W3			;;
	MOV #KEYDDD_B,W1		;;
	MOV #KEYDDD0,W2			;;
USBKEY_D4:				;;
	MOV [W2++],W0			;;
	MOV W0,[W1++]			;;
	DEC W3,W3			;;
	BRA NZ,USBKEY_D4		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
USBKEY:					;;
	MOV #14,W3			;;
	MOV #KEYDDD0,W1			;;
USBKEY0:				;;
	MOV [W1++],W2			;;
	CP0 W2				;;
	BRA Z,USBKEY2			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #14,W6			;;
	MOV #KEYDDD_B,W4		;;
USBKEY1:				;;
	MOV [W4++],W5			;;
	CP W2,W5			;;
	BRA Z,USBKEY2			;;
	DEC W6,W6			;;
	BRA NZ,USBKEY1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
USBKEY_N:				;;
	MOV W2,W0			;;
	BCLR FLAGB,#KEY_RPOFF_F		;;
	CALL TRANS_PS2_KEY		;;
	CLR KEY_REPEAT_TIM		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
USBKEY2:				;;
	DEC W3,W3			;;
	BRA NZ,USBKEY0			;;
USBKEY3:				;;
	MOV #14,W3			;;
	MOV #KEYDDD0,W1			;;
	MOV #KEYDDD_B,W2		;;
USBKEY4:				;;
	MOV [W1++],W0			;;
	MOV W0,[W2++]			;;
	DEC W3,W3			;;
	BRA NZ,USBKEY4			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_P:				;;
	MOV #0xF3,W1			;;WIN
	CP W0,W1			;;
	BRA Z,EDP_0			;;
	MOV #0x2B,W1			;;TAB
	CP W0,W1			;;
	BRA Z,EDP_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF0,W1			;;L-CTR
	CP W0,W1			;;
	BRA Z,EDP_2			;;
	MOV #0xF4,W1			;;R-CTR
	CP W0,W1			;;
	BRA Z,EDP_2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF2,W1			;;L-ALT
	CP W0,W1			;;
	BRA Z,EDP_3			;;
	MOV #0xF6,W1			;;R-ALT
	CP W0,W1			;;
	BRA Z,EDP_3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF1,W1			;;L-SHIFT
	CP W0,W1			;;
	BRA Z,EDP_4			;;
	MOV #0xF5,W1			;;R-SHIFT
	CP W0,W1			;;
	BRA Z,EDP_4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDP_0:					;;
	BTSS EDKEY_FLAG,#0		;;WIN
	RETURN				;;
	CLR W0				;;
	CLR KB_REPEAT_B0		;;
	CLR KB_REPEAT_B1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDP_1:					;;
	BTSS EDKEY_FLAG,#1		;;TAB
	RETURN				;;
	CLR W0				;;
	CLR KB_REPEAT_B0		;;
	CLR KB_REPEAT_B1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDP_2:					;;
	BTSS EDKEY_FLAG,#2		;;CTR
	RETURN				;;
	CLR W0				;;
	CLR KB_REPEAT_B0		;;
	CLR KB_REPEAT_B1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDP_3:					;;
	BTSS EDKEY_FLAG,#3		;;ALT
	RETURN				;;
	CLR W0				;;
	CLR KB_REPEAT_B0		;;
	CLR KB_REPEAT_B1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDP_4:					;;
	BTSS EDKEY_FLAG,#4		;;SHIFT
	RETURN				;;
	CLR W0				;;
	CLR KB_REPEAT_B0		;;
	CLR KB_REPEAT_B1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;EDKEY_P:				;;
	BTSC FLAGB,#KEY_RPOFF_F		;;
	BRA EDKEY_P1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF2,W1			;;
	CP W0,W1			;;
	BRA NZ,$+4			;;
	BSET FLAGC,#ALT_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF6,W1			;;
	CP W0,W1			;;
	BRA NZ,$+4			;;
	BSET FLAGC,#ALT_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF0,W1			;;
	CP W0,W1			;;
	BRA NZ,$+4			;;
	BSET FLAGC,#CTRL_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF4,W1			;;
	CP W0,W1			;;
	BRA NZ,$+4			;;
	BSET FLAGC,#CTRL_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGC,#EDKEY_F0		;;
	BRA EDKEY_P0B			;;
	MOV #0xF3,W1			;;
	CP W0,W1			;;
	BRA NZ,EDKEY_P0B		;;
	MOV W0,EDKEY_B			;;
	CLR W0				;;
	RETURN				;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_P0B:				;;
	BTSS FLAGC,#EDKEY_F1		;;
	BRA EDKEY_P0C			;;
	MOV #0x2B,W1			;;
	CP W0,W1			;;
	BRA NZ,EDKEY_P0C		;;
	BTSS FLAGC,#ALT_F		;;
	BRA EDKEY_P0C			;;
	MOV W0,EDKEY_B			;;
	CLR W0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_P0C:				;;
	BTSS FLAGC,#EDKEY_F2		;;
	BRA EDKEY_P0D			;;
	MOV #0x29,W1			;;
	CP W0,W1			;;
	BRA NZ,EDKEY_P0D		;;
	BTSS FLAGC,#CTRL_F		;;
	BRA EDKEY_P0D			;;
	MOV W0,EDKEY_B			;;
	CLR W0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_P0D:				;;
	BTSS FLAGC,#EDKEY_F3		;;
	BRA EDKEY_P0E			;;
	MOV #0x63,W1			;;
	CP W0,W1			;;
	BRA Z,EDKEY_P0D1		;;
	MOV #0x4C,W1			;;
	CP W0,W1			;;
	BRA NZ,EDKEY_P0E		;;
EDKEY_P0D1:				;;
	BTSS FLAGC,#ALT_F		;;
	BRA EDKEY_P0E			;;
	BTSS FLAGC,#CTRL_F		;;
	BRA EDKEY_P0E			;;
	MOV W0,EDKEY_B			;;
	CLR W0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_P0E:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_P1:				;;
	MOV EDKEY_B,W1			;;
	CP W0,W1			;;		
	BRA NZ,EDKEY_P2			;;
	CLR W0				;;
	CLR EDKEY_B			;;
	RETURN				;;
EDKEY_P2:				;;
	MOV #0xF2,W1			;;
	CP W0,W1			;;
	BRA NZ,$+4			;;
	BCLR FLAGC,#ALT_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF6,W1			;;
	CP W0,W1			;;
	BRA NZ,$+4			;;
	BCLR FLAGC,#ALT_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF0,W1			;;
	CP W0,W1			;;
	BRA NZ,$+4			;;
	BCLR FLAGC,#CTRL_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF4,W1			;;
	CP W0,W1			;;
	BRA NZ,$+4			;;
	BCLR FLAGC,#CTRL_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;EDKEY_PRG:				;;
	BTSC FLAGB,#KEY_RPOFF_F		;;
	BRA EDKEY_PRG1			;;
	MOV EDKEY_B1,W1			;;
	MOV W1,EDKEY_B0			;;
	MOV EDKEY_B2,W1			;;
	MOV W1,EDKEY_B1			;;
	MOV W0,EDKEY_B2			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
EDKEY_PRG0A:				;;
	BTSS FLAGC,#EDKEY_F0		;;
	BRA EDKEY_PRG0B			;;
	MOV #0xF3,W1			;;
	CP W0,W1			;;
	BRA NZ,EDKEY_PRG0B		;;
	CLR W0				;;
	RETURN				;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_PRG0B:				;;
	BTSS FLAGC,#EDKEY_F1		;;
	BRA EDKEY_PRG0C			;;
	MOV #0x2B,W1			;;
	CP W0,W1			;;
	BRA NZ,EDKEY_PRG0C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV EDKEY_B1,W2			;;
	MOV #0xF2,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0B1		;;
	MOV #0xF6,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0B1		;;
	BRA EDKEY_PRG0C			;;
EDKEY_PRG0B1:				;;
	CLR W0				;;
	RETURN				;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_PRG0C:				;;
	BTSS FLAGC,#EDKEY_F2		;;
	BRA EDKEY_PRG0D			;;
	MOV #0x29,W1			;;
	CP W0,W1			;;
	BRA NZ,EDKEY_PRG0D		;;
	MOV EDKEY_B1,W2			;;
	MOV #0xF0,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0C1		;;
	MOV #0xF4,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0C1		;;
	BRA EDKEY_PRG0D			;;
EDKEY_PRG0C1:				;;
	MOV #0xF0,W0
	MOV W0,EDKEY_B2			;;
	CLR W0				;;
	RETURN				;;		
EDKEY_PRG0D:				;;
	BTSS FLAGC,#EDKEY_F3		;;
	BRA EDKEY_PRG0E			;;
	MOV #0x4C,W1			;;
	CP W0,W1			;;
	BRA NZ,EDKEY_PRG0E		;;
	MOV EDKEY_B0,W2			;;
	MOV #0xF0,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0D_1		;;
	MOV #0xF4,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0D_1		;;
	MOV #0xF2,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0D_2		;;
	MOV #0xF6,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0D_2		;;
	BRA EDKEY_PRG0E			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_PRG0D_1:				;;
	MOV EDKEY_B1,W2			;;
	MOV #0xF2,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0D1		;;
	MOV #0xF6,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0D1		;;
	BRA EDKEY_PRG0E			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_PRG0D_2:				;;
	MOV EDKEY_B1,W2			;;
	MOV #0xF0,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0D1		;;
	MOV #0xF4,W1			;;
	CP W2,W1			;;
	BRA Z,EDKEY_PRG0D1		;;
	BRA EDKEY_PRG0E			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_PRG0D1:				;;
	MOV W0,EDKEY_B			;;
	CLR W0				;;
	RETURN				;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EDKEY_PRG0E:				;;
	RETURN				;;
EDKEY_PRG1:				;;
	CP EDKEY_B2			;;
	BRA NZ,$+4			;;
	CLR EDKEY_B2			;;
	CP EDKEY_B1			;;
	BRA NZ,$+4			;;
	CLR EDKEY_B1			;;
	CP EDKEY_B0			;;
	BRA NZ,$+4			;;
	CLR EDKEY_B0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV EDKEY_B,W1			;;
	CP W0,W1			;;		
	BRA Z,EDKEY_PRG2		;;
	RETURN				;;	
EDKEY_PRG2:				;;
	CLR W0				;;
	CLR EDKEY_B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PS2_KEY_END:			;;
	POP W3				;;
	POP W2				;;
	POP W1				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PS2_KEY:				;;
	PUSH W1				;;
	PUSH W2				;;
	PUSH W3				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL EDKEY_P	
	CP0 W0
	BRA Z,TRANS_PS2_KEY_END
	CALL TRANS_PS2			;;
	MOV W0,W1			;;
	MOV #PS2_TXDATA0,W0		;;	
	ADD PS2_TXLIM,WREG		;;
	ADD PS2_TXLIM,WREG		;;
	MOV W0,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV W1,W0			;;
	SWAP W0				;;
	AND #255,W0			;;
	MOV W0,W3			;;
	BRA NZ,$+4			;;
	BRA TRANS_PS2_KEY_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0xFA,W0			;;
	CP W0,W3			;;
	BRA NZ,TRANS_PS2_KEY1		;;
	BTSC FLAGB,#KEY_RPOFF_F		;;
	BRA TPK_0A
	MOV #0xE0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0x12,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0xE0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0x7C,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	BRA TRANS_PS2_KEY_END		;;
TPK_0A:					;;
	MOV #0xE0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0xF0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0x7C,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0xE0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0xF0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0x12,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	BRA TRANS_PS2_KEY_END		;;
TRANS_PS2_KEY1:				;;
	MOV #0xFB,W0			;;
	CP W0,W3			;;
	BRA NZ,TRANS_PS2_KEY2		;;
	BTSC FLAGB,#KEY_RPOFF_F		;;
	BRA TRANS_PS2_KEY_END		;;
	MOV #0xE1,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0x14,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0x77,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0xE1,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0xF0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0x14,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0xF0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0x77,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	BRA TRANS_PS2_KEY_END		;;
TRANS_PS2_KEY2:				;;
	BTSC FLAGB,#KEY_RPOFF_F		;;
	BRA TRANS_PS2_KEY4		;;
	CLR KB_REPEAT_B0		;; 
	CLR KB_REPEAT_B1		;; 
	MOV W3,[W2++]			;;
	MOV W3,KB_REPEAT_B0		;;
	INC PS2_TXLIM			;;
	AND #255,W1			;;
	BRA NZ,$+4			;;
	BRA TRANS_PS2_KEY_END		;;
	MOV W1,[W2++]			;;
	MOV W1,KB_REPEAT_B1		;;
	INC PS2_TXLIM			;;	
	BRA TRANS_PS2_KEY_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PS2_KEY4:				;;
	AND #255,W1			;;
	BRA NZ,TRANS_PS2_KEY5		;;
	MOV #0xF0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV W3,[W2++]			;;
	INC PS2_TXLIM			;;
	BRA TRANS_PS2_KEY_END		;;
TRANS_PS2_KEY5:				;;
	MOV W3,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV #0xF0,W0			;;
	MOV W0,[W2++]			;;
	INC PS2_TXLIM			;;
	MOV W1,[W2++]			;;
	INC PS2_TXLIM			;;
	BRA TRANS_PS2_KEY_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





OLEDPSKEY_TBL:
	BRA W0
	RETLW #0x00,W0	;0
	RETLW #0x00,W0	;1
	RETLW #0x00,W0	;2
	RETLW #0x00,W0	;3
	RETLW #0x00,W0	;4
	RETLW #0x00,W0	;5
	RETLW #0x00,W0	;6
	RETLW #0x00,W0	;7
	RETLW #0x2A,W0	;8;BACKSPACE
	RETLW #0x00,W0	;9
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;10
	RETLW #0x00,W0	;11
	RETLW #0x00,W0	;12
	RETLW #0x28,W0	;13;ENTER
	RETLW #0x00,W0	;14
	RETLW #0x00,W0	;15
	RETLW #0x00,W0	;16
	RETLW #0x00,W0	;17
	RETLW #0x00,W0	;18
	RETLW #0x00,W0	;19
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;20
	RETLW #0x00,W0	;21
	RETLW #0x00,W0	;22
	RETLW #0x00,W0	;23
	RETLW #0x00,W0	;24
	RETLW #0x00,W0	;25
	RETLW #0x00,W0	;26
	RETLW #0x29,W0	;27;ESC
	RETLW #0x00,W0	;28
	RETLW #0x00,W0	;29
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;30
	RETLW #0x00,W0	;31
	RETLW #0x2C,W0	;32;SPACE
	RETLW #0x4B,W0	;33;PAGEUP
	RETLW #0x4E,W0	;34;PAGEDN
	RETLW #0x4D,W0	;35;END
	RETLW #0x4A,W0	;36;HOME
	RETLW #0x50,W0	;37;LEFT
	RETLW #0x52,W0	;38;UP
	RETLW #0x4F,W0	;39;RIGHT
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x51,W0	;40;DOWN
	RETLW #0x00,W0	;41
	RETLW #0x00,W0	;42
	RETLW #0x00,W0	;43
	RETLW #0x00,W0	;44
	RETLW #0x49,W0	;45;INSER
	RETLW #0x4C,W0	;46;DEL
	RETLW #0x00,W0	;47
	RETLW #0x27,W0	;48;0
	RETLW #0x1E,W0	;49;1
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x1F,W0	;50
	RETLW #0x20,W0	;51
	RETLW #0x21,W0	;52
	RETLW #0x22,W0	;53
	RETLW #0x23,W0	;54
	RETLW #0x24,W0	;55
	RETLW #0x25,W0	;56
	RETLW #0x27,W0	;57;9
	RETLW #0x00,W0	;58
	RETLW #0x00,W0	;59
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;60
	RETLW #0x00,W0	;61
	RETLW #0x00,W0	;62
	RETLW #0x00,W0	;63
	RETLW #0x00,W0	;64
	RETLW #0x04,W0	;65;A
	RETLW #0x05,W0	;66
	RETLW #0x06,W0	;67
	RETLW #0x07,W0	;68
	RETLW #0x08,W0	;69
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x09,W0	;70
	RETLW #0x0A,W0	;71
	RETLW #0x0B,W0	;72
	RETLW #0x0C,W0	;73
	RETLW #0x0D,W0	;74
	RETLW #0x0E,W0	;75
	RETLW #0x0F,W0	;76
	RETLW #0x10,W0	;77
	RETLW #0x11,W0	;78
	RETLW #0x12,W0	;79
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x13,W0	;80
	RETLW #0x14,W0	;81
	RETLW #0x15,W0	;82
	RETLW #0x16,W0	;83
	RETLW #0x17,W0	;84
	RETLW #0x18,W0	;85
	RETLW #0x19,W0	;86
	RETLW #0x1A,W0	;87
	RETLW #0x1B,W0	;88
	RETLW #0x1C,W0	;89
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x1D,W0	;90;Z
	RETLW #0x00,W0	;91
	RETLW #0x00,W0	;92
	RETLW #0x00,W0	;93
	RETLW #0x00,W0	;94
	RETLW #0x00,W0	;95
	RETLW #0x00,W0	;96
	RETLW #0x00,W0	;97
	RETLW #0x00,W0	;98
	RETLW #0x00,W0	;99
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;100
	RETLW #0x00,W0	;101
	RETLW #0x00,W0	;102
	RETLW #0x00,W0	;103
	RETLW #0x00,W0	;104
	RETLW #0x00,W0	;105
	RETLW #0x00,W0	;106
	RETLW #0x00,W0	;107
	RETLW #0x00,W0	;108
	RETLW #0x00,W0	;109
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;110
	RETLW #0x00,W0	;111
	RETLW #0x3A,W0	;112	;F1
	RETLW #0x3B,W0	;113	
	RETLW #0x3C,W0	;114	
	RETLW #0x3D,W0	;115
	RETLW #0x3E,W0	;116
	RETLW #0x3F,W0	;117
	RETLW #0x40,W0	;118
	RETLW #0x41,W0	;119
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x42,W0	;120
	RETLW #0x43,W0	;121
	RETLW #0x44,W0	;122	;F11
	RETLW #0x45,W0	;123
	RETLW #0x00,W0	;124
	RETLW #0x00,W0	;125
	RETLW #0x00,W0	;126
	RETLW #0x00,W0	;127
	RETLW #0x00,W0	;128
	RETLW #0x00,W0	;129
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;130
	RETLW #0x00,W0	;131
	RETLW #0x00,W0	;132
	RETLW #0x00,W0	;133
	RETLW #0x00,W0	;134
	RETLW #0x00,W0	;135
	RETLW #0x00,W0	;136
	RETLW #0x00,W0	;137
	RETLW #0x00,W0	;138
	RETLW #0x00,W0	;139
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;140
	RETLW #0x00,W0	;141
	RETLW #0x00,W0	;142
	RETLW #0x00,W0	;143
	RETLW #0x00,W0	;144
	RETLW #0x00,W0	;145
	RETLW #0x00,W0	;146
	RETLW #0x00,W0	;147
	RETLW #0x00,W0	;148
	RETLW #0x00,W0	;149
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;150
	RETLW #0x00,W0	;151
	RETLW #0x00,W0	;152
	RETLW #0x00,W0	;153
	RETLW #0x00,W0	;154
	RETLW #0x00,W0	;155
	RETLW #0x00,W0	;156
	RETLW #0x00,W0	;157
	RETLW #0x00,W0	;158
	RETLW #0x00,W0	;159
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;160
	RETLW #0x00,W0	;161
	RETLW #0x00,W0	;162
	RETLW #0x00,W0	;163
	RETLW #0x00,W0	;164
	RETLW #0x00,W0	;165
	RETLW #0x00,W0	;166
	RETLW #0x00,W0	;167
	RETLW #0x00,W0	;168
	RETLW #0x00,W0	;169
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;170
	RETLW #0x00,W0	;171
	RETLW #0x00,W0	;172
	RETLW #0x00,W0	;173
	RETLW #0x00,W0	;174
	RETLW #0x00,W0	;175
	RETLW #0x00,W0	;176
	RETLW #0x00,W0	;177
	RETLW #0x00,W0	;178
	RETLW #0x00,W0	;179
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;180
	RETLW #0x00,W0	;181
	RETLW #0x00,W0	;182
	RETLW #0x00,W0	;183
	RETLW #0x00,W0	;184
	RETLW #0x00,W0	;185
	RETLW #0x00,W0	;186
	RETLW #0x57,W0	;187;=
	RETLW #0x00,W0	;188
	RETLW #0x56,W0	;189;-
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;190
	RETLW #0x00,W0	;191
	RETLW #0x35,W0	;192;~
	RETLW #0x00,W0	;193
	RETLW #0x00,W0	;194
	RETLW #0x00,W0	;195
	RETLW #0x00,W0	;196
	RETLW #0x00,W0	;197
	RETLW #0x00,W0	;198
	RETLW #0x00,W0	;199
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;200
	RETLW #0x00,W0	;201
	RETLW #0x00,W0	;202
	RETLW #0x00,W0	;203
	RETLW #0x00,W0	;204
	RETLW #0x00,W0	;205
	RETLW #0x00,W0	;206
	RETLW #0x00,W0	;207
	RETLW #0x00,W0	;208
	RETLW #0x00,W0	;209
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;210
	RETLW #0x00,W0	;211
	RETLW #0x00,W0	;212
	RETLW #0x00,W0	;213
	RETLW #0x00,W0	;214
	RETLW #0x00,W0	;215
	RETLW #0x00,W0	;216
	RETLW #0x00,W0	;217
	RETLW #0x00,W0	;218
	RETLW #0x00,W0	;219
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x31,W0	;220;\
	RETLW #0x00,W0	;221
	RETLW #0x00,W0	;222
	RETLW #0x00,W0	;223
	RETLW #0x00,W0	;224
	RETLW #0x00,W0	;225
	RETLW #0x00,W0	;226
	RETLW #0x00,W0	;227
	RETLW #0x00,W0	;228
	RETLW #0x00,W0	;229
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;230
	RETLW #0x00,W0	;231
	RETLW #0x00,W0	;232
	RETLW #0x00,W0	;233
	RETLW #0x00,W0	;234
	RETLW #0x00,W0	;235
	RETLW #0x00,W0	;236
	RETLW #0x00,W0	;237
	RETLW #0x00,W0	;238
	RETLW #0x00,W0	;239
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;240
	RETLW #0x00,W0	;241
	RETLW #0x00,W0	;242
	RETLW #0x00,W0	;243
	RETLW #0x00,W0	;244
	RETLW #0x00,W0	;245
	RETLW #0x00,W0	;246
	RETLW #0x00,W0	;247
	RETLW #0x00,W0	;248
	RETLW #0x00,W0	;249
	;;;;;;;;;;;;;;;;;;;
	RETLW #0x00,W0	;250
	RETLW #0x00,W0	;251
	RETLW #0x00,W0	;252
	RETLW #0x00,W0	;253
	RETLW #0x00,W0	;254
	RETLW #0x00,W0	;255
	RETLW #0x00,W0	;256
	RETLW #0x00,W0	;257
	RETLW #0x00,W0	;258
	RETLW #0x00,W0	;259
	;;;;;;;;;;;;;;;;;;;






TRANS_PS2:
	AND #255,W0
	MOV W0,USBKD
	;;;;;;;;;;;;;
	MOV #0x29,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7600,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x35,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0E00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x2B,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0D00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x39,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5800,W0
	RETURN
	;;;;;;;;;;;;;
;    case 0x29 ://ESC
;    case 0x35 ://~
;    case 0x2b ://TAB
;    case 0x39 ://CAPS
	MOV #0x2D,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4E00,W0
	RETURN
	;;;;;;;;;;;;;	
	MOV #0x2E,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5500,W0
	RETURN
	;;;;;;;;;;;;;	
	MOV #0x31,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5D00,W0
	RETURN
	MOV #0x32,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5D00,W0
	RETURN
	;;;;;;;;;;;;;	
	MOV #0x2A,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x6600,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x2d ://-
;   case 0x2e ://=
;   case 0x31 ://\  
;   case 0x2a ://back

	MOV #0x2F,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5400,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x30,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5B00,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x2f ://[
;   case 0x30 ://]

	MOV #0x28,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5A00,W0
	RETURN

	MOV #0x2C,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2900,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x28 ://ENTER
;   case 0x2C ://SPACE
	MOV #0x33,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4C00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x34,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5200,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x33 ://;
;   case 0x34 ://'
	MOV #0x36,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4100,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x37,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4900,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x38,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4A00,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x36 ://,
;   case 0x37 ://.
;   case 0x38 :///
	MOV #0x46,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xFA00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x47,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7E00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x48,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xFB00,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x46 ://Print
;   case 0x47 ://Scroll
;   case 0x48 ://Pause
	MOV #0x49,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE070,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x4C,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE071,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x4A,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE06C,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x4D,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE069,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x4B,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE07D,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x4E,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE07A,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x49 ://Inser
;   case 0x4c ://Delete
;   case 0x4a ://Home
;   case 0x4d ://End
;   case 0x4b ://Page Up
;   case 0x4e ://Page Dn
	MOV #0x52,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE075,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x51,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE072,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x50,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE06B,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x4F,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE074,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x52 ://Up   
;   case 0x51 ://Down 
;   case 0x50 ://Left 
;   case 0x4f ://Right


	MOV #0xF0,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1400,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0xF1,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1200,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0xF2,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1100,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0xF3,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE01F,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0xF4,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE014,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0xF5,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x5900,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0xF6,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE011,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0xF7,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE027,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0xF0 ://L-CTRL
;   case 0xF1 ://L-SHIFT
;   case 0xF2 ://L-ALT   
;   case 0xF3 ://L-WIN
;   case 0xF4 ://R-CTRL
;   case 0xF5 ://R-SHIFT
;   case 0xF6 ://R-ALT
;   case 0xF7 ://R-WIN
	MOV #0x3A,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0500,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x3B,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0600,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x3C,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0400,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x3D,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0C00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x3E,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0300,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x3F,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0B00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x40,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x8300,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x41,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0A00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x42,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0100,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x43,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0900,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x44,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7800,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x45,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x0700,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x3a ://F1
;   case 0x3b ://F2
;   case 0x3c ://F3
;   case 0x3d ://F4
;   case 0x3e ://F5
;   case 0x3f ://F6
;   case 0x40 ://F7
;   case 0x41 ://F8
;   case 0x42 ://F9
;   case 0x43 ://F10
;   case 0x44 ://F11
;   case 0x45 ://F12
	MOV #0x1E,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1600,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x1F,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1E00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x20,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2600,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x21,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2500,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x22,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2E00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x23,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3600,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x24,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3D00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x25,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3E00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x26,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4600,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x27,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4500,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x1e ://1
;   case 0x1f ://2
;   case 0x20 ://3
;   case 0x21 ://4
;   case 0x22 ://5
;   case 0x23 ://6
;   case 0x24 ://7
;   case 0x25 ://8
;   case 0x26 ://9
;   case 0x27 ://0
	MOV #0x04,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1C00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x05,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3200,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x06,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2100,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x07,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2300,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x08,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2400,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x09,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2B00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x0A,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3400,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x0B,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3300,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x0C,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4300,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x0D,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3B00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x0E,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4200,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x0F,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4B00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x10,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3A00,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x04 ://A
;   case 0x05 ://B
;   case 0x06 ://C
;   case 0x07 ://D
;   case 0x08 ://E
;   case 0x09 ://F
;   case 0x0a ://G
;   case 0x0b ://H
;   case 0x0c ://I
;   case 0x0d ://J
;   case 0x0e ://K
;   case 0x0f ://L
;   case 0x10 ://M
	MOV #0x11,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3100,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x12,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4400,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x13,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x4D00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x14,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1500,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x15,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2D00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x16,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1B00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x17,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2C00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x18,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3C00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x19,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2A00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x1A,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1D00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x1B,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x2200,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x1C,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x3500,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x1D,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x1A00,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x11 ://N
;   case 0x12 ://O
;   case 0x13 ://P
;   case 0x14 ://Q
;   case 0x15 ://R
;   case 0x16 ://S
;   case 0x17 ://T
;   case 0x18 ://U
;   case 0x19 ://V
;   case 0x1a ://W
;   case 0x1b ://X
;   case 0x1c ://Y
;   case 0x1d ://Z
;;	num pad
	MOV #0x53,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7700,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x54,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE04A,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x55,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7C00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x56,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7B00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x57,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7900,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x58,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0xE05A,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x63,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7100,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x62,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7000,W0
	RETURN
	;;;;;;;;;;;;;
;   case 0x53 ://Num Lock	  
;   case 0x54 :// /	  
;   case 0x55 :// * 	  
;   case 0x56 ://- 	  
;   case 0x57 ://+	  
;   case 0x58 ://Enter	  
;   case 0x63 ://Del	  
;   case 0x62 ://0 	  
	MOV #0x59,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x6900,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x5A,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7200,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x5B,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7A00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x5C,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x6B00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x5D,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7300,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x5E,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7400,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x5F,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x6C00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x60,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7500,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x61,W0	
	CP USBKD
	BRA NZ,$+6
	MOV #0x7D00,W0
	RETURN
	;;;;;;;;;;;;;
	MOV #0x7D00,W0
	RETURN
;   case 0x59 ://1 	  
;   case 0x5a ://2 	  
;   case 0x5b ://3 	  
;   case 0x5c ://4 	  
;   case 0x5d ://5 	  
;   case 0x5e ://6 	  
;   case 0x5f ://7 	  
;   case 0x60 ://8 	  
;   case 0x61 ://9 	  

OLED2PSKEY:
;	CLR KEYDDD0
;	CLR KEYDDD1
;	CLR KEYDDD2
;	CLR KEYDDD3
;	CLR KEYDDD4
;	CLR KEYDDD5
;	CLR KEYDDD6
;	CLR KEYDDD7
;	CLR KEYDDD8
;	CLR KEYDDD9
;	CLR KEYDDD10
;	CLR KEYDDD11
;	CLR KEYDDD12
;	CLR KEYDDD13
	;;;;;;;;;;;;;;
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TR_OLEDPS:				;;
	BTSS FLAGC,#OLED2PSKEY_F	;;
	RETURN				;;
	CP0 KEY10V			;;
	BTSC SR,#Z			;;
	RETURN				;;
	BTSC FLAGB,#PS2_TX_F		;;
	RETURN				;;
	BCLR FLAGC,#OLED2PSKEY_F	;;
	CLR OLEDPSK0			;;
	CLR OLEDPSK1			;;
	CLR OLEDPSK2			;;
	CLR OLEDPSK3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF0,W2			;;
	BTSC KEY10V,#10			;;	
	MOV W2,OLEDPSK0			;;
	MOV #0xF1,W2			;;
	BTSC KEY10V,#8			;;
	MOV W2,OLEDPSK1			;;
	MOV #0xF2,W2			;;
	BTSC KEY10V,#9			;;
	MOV W2,OLEDPSK2			;;
	MOV KEY10V,W0			;;
	AND #255,W0			;;
	CALL OLEDPSKEY_TBL		;;	
	MOV W0,OLEDPSK3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR PS2_TXLIM			;;
	MOV OLEDPSK0,WREG		;;	
	BTSS SR,#Z			;;
	CALL PSKEY_P			;;
	MOV OLEDPSK1,WREG		;;	
	BTSS SR,#Z			;;
	CALL PSKEY_P			;;
	MOV OLEDPSK2,WREG		;;	
	BTSS SR,#Z			;;
	CALL PSKEY_P			;;
	MOV OLEDPSK3,WREG		;;	
	BTSS SR,#Z			;;
	CALL PSKEY_P			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OLEDPSK3,WREG		;;	
	BTSS SR,#Z			;;
	CALL PSKEY_R			;;
	MOV OLEDPSK2,WREG		;;	
	BTSS SR,#Z			;;
	CALL PSKEY_R			;;
	MOV OLEDPSK1,WREG		;;	
	BTSS SR,#Z			;;
	CALL PSKEY_R			;;
	MOV OLEDPSK0,WREG		;;	
	BTSS SR,#Z			;;
	CALL PSKEY_R			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


PSKEY_P:
	BCLR FLAGB,#KEY_RPOFF_F		;;
	CALL TRANS_PS2_KEY		;;
	CLR KEY_REPEAT_TIM		;;
	RETURN

PSKEY_R:
	BSET FLAGB,#KEY_RPOFF_F		;;
	CALL TRANS_PS2_KEY		;;
	RETURN




	


_USBRP_ASM:
	CLR KEYDDD0
	CLR KEYDDD1
	CLR KEYDDD2
	CLR KEYDDD3
	CLR KEYDDD4
	CLR KEYDDD5
	CLR KEYDDD6
	CLR KEYDDD7
	CLR KEYDDD8
	CLR KEYDDD9
	CLR KEYDDD10
	CLR KEYDDD11
	CLR KEYDDD12
	CLR KEYDDD13
	MOV [W0++],W1
	MOV #0xF0,W2
	BTSC W1,#0
	MOV W2,KEYDDD0
	;;;;;;;;;;;;;;;;;;;
	MOV #0xF1,W2
	BTSC W1,#1
	MOV W2,KEYDDD1
	;;;;;;;;;;;;;;;;;;;
	MOV #0xF2,W2
	BTSC W1,#2
	MOV W2,KEYDDD2
	;;;;;;;;;;;;;;;;;;;
	MOV #0xF3,W2
	BTSC W1,#3
	MOV W2,KEYDDD3
	;;;;;;;;;;;;;;;;;;;
	MOV #0xF4,W2
	BTSC W1,#4
	MOV W2,KEYDDD4
	;;;;;;;;;;;;;;;;;;;
	MOV #0xF5,W2
	BTSC W1,#5
	MOV W2,KEYDDD5
	;;;;;;;;;;;;;;;;;;;
	MOV #0xF6,W2
	BTSC W1,#6
	MOV W2,KEYDDD6
	;;;;;;;;;;;;;;;;;;;
	MOV #0xF7,W2
	BTSC W1,#7
	MOV W2,KEYDDD7
	;;;;;;;;;;;;;;;;;;;
	MOV [W0],W1
	AND #255,W1
	MOV W1,KEYDDD8	
	MOV [W0++],W1
	SWAP W1
	AND #255,W1
	MOV W1,KEYDDD9	
	;;;;;;;;;;;;;;;;;;;
	MOV [W0],W1
	AND #255,W1
	MOV W1,KEYDDD10	
	MOV [W0++],W1
	SWAP W1
	AND #255,W1
	MOV W1,KEYDDD11	
	;;;;;;;;;;;;;;;;;;;
	MOV [W0],W1
	AND #255,W1
	MOV W1,KEYDDD12	
	MOV [W0++],W1
	SWAP W1
	AND #255,W1
	MOV W1,KEYDDD13	
	RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_TIME:				;;
	BTSC TMR5_FLAG,#T8M_F		;;
	INC CLRPS2_CMD_TIM		;;
	MOV #10,W0			;;
	CP CLRPS2_CMD_TIM 		;;
	BRA LTU,MAIN_TIME1		;;
	CLR PS2_CMD			;;
MAIN_TIME1:				;;
	BTSC TMR5_FLAG,#T8M_F		;;
	INC KEY_REPEAT_TIM		;;
	BTSC FLAGB,#PS2_TX_F		;;
	BRA MAIN_TIME2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGB,#KEY_RPOFF_F		;;
	BRA MAIN_TIME2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_TYPEMATIC_DLY_TIM	;;
	CP KEY_REPEAT_TIM		;;
	BRA LTU,MAIN_TIME2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W0,W1			;;	
	CALL GET_TYPEMATIC_REP_TIM	;;
	SUB W1,W0,W0			;;
	BTSC W0,#15			;;
	CLR W0				;;
	MOV W0,KEY_REPEAT_TIM		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP0 KB_REPEAT_B0		;;
	BRA Z,MAIN_TIME2		;;
	CP0 KB_REPEAT_B1		;;
	BRA NZ,MT1_0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KB_REPEAT_B0,W0		;;
	MOV W0,PS2_TXDATA0		;;
	MOV #1,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	BRA MAIN_TIME2			;;
MT1_0:					;;
	MOV KB_REPEAT_B0,W0		;;
	MOV W0,PS2_TXDATA0		;;
	MOV KB_REPEAT_B1,W0		;;
	MOV W0,PS2_TXDATA1		;;
	MOV #2,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
MAIN_TIME2:				;;
	BTSS TMR5_FLAG,#T8M_F		;;
	BRA MAIN_TIME3			;;
;	BTSS PS2VCC,#PS2VCC_P		;;<<
;	CLR PS2VCC_TIM			;;<<
;	BTSS PS2VCC,#PS2VCC_P		;;<<
;	BCLR FLAGC,#KEYBO_OK_F		;;<<
	INC PS2VCC_TIM			;;
	MOV #50,W0			;;
	CP PS2VCC_TIM			;;
	BRA LTU,MAIN_TIME3		;;
	BTSC FLAGC,#KEYBO_OK_F		;;
	BRA MAIN_TIME3			;;	
	BSET FLAGC,#KEYBO_OK_F		;;
	MOV #0xAA,W0			;;
	MOV W0,PS2_TXDATA0		;;
	MOV #1,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
MAIN_TIME3:				;;
	BTSS TMR5_FLAG,#T8M_F		;;
	BRA MAIN_TIME4			;;
	INC TEST_OLEDKEY_TIM		;;
	MOV #1250,W0			;;
	CP TEST_OLEDKEY_TIM		;;
	BRA LTU,MAIN_TIME4		;;
	BCLR FLAGC,#TEST_OLEDKEY_F	;;	
;	BTSS FLAGC,#UART_H_F		;;
;	BRA MAIN_TIME4			;;
;	INC UART_H_TIM			;;
;	MOV #125,W0			;;
;	CP UART_H_TIM			;;
; 	BRA LTU,MAIN_TIME4		;;
;	CALL SET_UART_L			;;
MAIN_TIME4:				;;
	BTSS TMR5_FLAG,#T8M_F		;;
	BRA MAIN_TIME5			;;
;	BTSC KEYFG,#7			;;
;	BRA MAIN_TIME4B			;;
	BTSS PS2VCC,#PS2VCC_P		;;<<
	BRA MAIN_TIME4B			;;
MAIN_TIME4A:				;;
	BTSC FLAGC,#KEYAB_F		;;
	BRA MAIN_TIME4C			;;
	CLR CHGPG_TIM			;;
	BRA MAIN_TIME5			;;
MAIN_TIME4B:				;;
	BTSS FLAGC,#KEYAB_F		;;
	BRA MAIN_TIME4C			;;
	CLR CHGPG_TIM			;;
	BRA MAIN_TIME5			;;
MAIN_TIME4C:				;;
	INC CHGPG_TIM			;;
	MOV #4,W0			;;
	CP CHGPG_TIM			;;
	BRA LTU,MAIN_TIME5		;;
	BTG FLAGC,#KEYAB_F		;;
	BSET FLAGC,#SWSYSTX_STA_F	;;
	CLR  U1TXED_TIM			;;
	CALL WKP_ALL_LED		;;	
	CALL WKP_ALL_OLED		;;
MAIN_TIME5:				;;
	BTSS TMR5_FLAG,#T32M_F		;;
	BRA MAIN_TIME6			;;
	BTSC EDKEY_FLAG,#6		;;
	BRA MAIN_TIME6			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC U1TXED_TIM			;;
	MOV #10,W0			;;
	CP U1TXED_TIM			;;
	BRA LTU,MAIN_TIME6		;;
	BTSC FLAGC,#SWSYSTX_STA_F	;;
	CALL SWSYS_UARTTX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_TIME6:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GET_TYPEMATIC_DLY_TIM:
	MOV TYPEMATIC,W0
	LSR W0,#5,W0
	AND #3,W0
	BRA W0
	RETLW #31,W0
	RETLW #63,W0
	RETLW #94,W0
	RETLW #125,W0

GET_TYPEMATIC_REP_TIM:
	MOV TYPEMATIC,W0
	AND #0x1F,W0
	SUBR W0,#0x1F,W0
	BRA W0
	RETLW #63,W0;2.0
	RETLW #60,W0;2.1
	RETLW #54,W0;2.3
	RETLW #50,W0;2,5
	RETLW #46,W0;2.7
	RETLW #42,W0;3.0
	RETLW #38,W0;3.3
	RETLW #34,W0;3.7
	RETLW #31,W0;4.0
	RETLW #29,W0;4.3
	RETLW #27,W0;4.6
	RETLW #25,W0;5.0
	RETLW #23,W0;5.5
	RETLW #21,W0;6.0
	RETLW #19,W0;6.5
	RETLW #17,W0;7.5
	;;;;;;;;;;;;;;;;;
	RETLW #16,W0;8.0
	RETLW #15,W0;8.6
	RETLW #14,W0;9.2
	RETLW #13,W0;10.0
	RETLW #11,W0;10.9
	RETLW #10,W0;12.0
	RETLW #9,W0;13.3
	RETLW #8,W0;15.0
	RETLW #8,W0;16.0
	RETLW #7,W0;17.1
	RETLW #7,W0;18.5
	RETLW #6,W0;20.0
	RETLW #6,W0;21.8
	RETLW #5,W0;24.0    
	RETLW #5,W0;26.7
	RETLW #4,W0;30.0
	;;;;;;;;;;;;;;;;;







	


KEYPRG:
;	MOV KEYFP0,W0
;	FF1R W0,W1
;	CP0 W1
;	BRA 
;MOV KEYFP0,W0
;XOR LEDFG0 
;MOV KEYFP1,W0
;XOR LEDFG1 
;MOV KEYFP2,W0
;XOR LEDFG2 
	;;;;;;;;;;;;;;;;;;;;
	MOV KEYFP0,W0
	IOR KEYFP1,WREG
	IOR KEYFP2,WREG
	BTSS SR,#Z
	BRA KEY_PRESS
	MOV KEYFR0,W0
	IOR KEYFR1,WREG
	IOR KEYFR2,WREG
	BTSS SR,#Z
	BRA KEY_RELEASE
	MOV KEYFC0,W0
	IOR KEYFC1,WREG
	IOR KEYFC2,WREG
	BTSS SR,#Z
	BRA KEY_CONTINUE
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEY_PRESS:				;;
	MOV #0x58,W0			;;
	MOV W0,PS2_TXDATA0		;;
	MOV #1,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	RETURN				;;
KEY_CONTINUE:				;;
	MOV #150,W0			;;
	MOV W0,CONKEY_TIM		;;
	MOV #0x1C,W0			;;
	MOV W0,PS2_TXDATA0		;;
	MOV #1,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	RETURN				;;
KEY_RELEASE:				;;
	MOV #0xF0,W0			;;
	MOV W0,PS2_TXDATA0		;;
	MOV #0x58,W0			;;
	MOV W0,PS2_TXDATA1		;;
	MOV #2,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	CLR KEYFP0			;;
	CLR KEYFP1			;;
	CLR KEYFP2			;;
	CLR KEYFR0			;;
	CLR KEYFR1			;;
	CLR KEYFR2			;;
	CLR KEYFC0			;;
	CLR KEYFC1			;;
	CLR KEYFC2			;;
	BTSS TMR5_FLAG,#T8M_F		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OLED_AMT_K,W2		;;
	CP W2,#24			;;
	BRA NZ,KEYBO1			;;
	CLR KEYFG2			;;
	MOV #0xFF00,W0			;;	
	AND KEYFG1			;;
KEYBO1:					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KEYFG2,W0			;;
	SWAP W0				;;
	AND #0xF0,W0			;;
	IOR KEYFG0,WREG			;;
	IOR KEYFG1,WREG			;;
	BRA Z,NO_KEY			;;
YESKEY:					;;
	BTSC FLAGB,#DARK_OLED_F		;;
	CALL SETCUR_OLED		;;
	CLR OLEDPRO_TIM			;;
	CLR NOKEY_TIM			;;
	MOV KEYFG0,W0			;;
	CP KEYFB0			;;
	BRA NZ,YESKEY1			;;
	MOV KEYFG1,W0			;;
	CP KEYFB1			;;
	BRA NZ,YESKEY1			;;
	MOV KEYFG2,W0			;;
	CP KEYFB2			;;
	BRA NZ,YESKEY1			;;
	INC YESKEY_TIM			;;
	MOV #1,W0			;;
	CP YESKEY_TIM			;;	
	BRA GEU,$+4			;;
	RETURN				;;
	BTSC FLAGA,#DISKP_F		;;
	BRA YESKEY2			;;
	MOV KEYFG0,W0			;;
	MOV W0,KEYFP0			;;
	MOV W0,KEYFRB0			;;
	MOV KEYFG1,W0			;;
	MOV W0,KEYFP1			;;
	MOV W0,KEYFRB1			;;
	MOV KEYFG2,W0			;;
	MOV W0,KEYFP2			;;
	MOV W0,KEYFRB2			;;
	BSET FLAGA,#DISKP_F		;;
 	RETURN				;;
YESKEY1:				;;
	CLR YESKEY_TIM 			;;
	BCLR FLAGA,#DISKP_F		;;
	MOV KEYFG0,W0			;;
	MOV W0,KEYFB0			;;
	MOV KEYFG1,W0			;;
	MOV W0,KEYFB1			;;
	MOV KEYFG2,W0			;;
	MOV W0,KEYFB2			;;
	RETURN				;;
YESKEY2:				;;
	INC CONKEY_TIM			;;
	CALL GET_TYPEMATIC_DLY_TIM	;;
	CP CONKEY_TIM			;;
	BRA GEU,$+4 			;;
	RETURN				;;
	MOV W0,W1			;;	
	CALL GET_TYPEMATIC_REP_TIM	;;
	SUB W1,W0,W0			;;
	BTSC W0,#15			;;
	CLR W0				;;
	MOV W0,CONKEY_TIM		;;
	BTSC FLAGA,#DISKC_F		;;
	RETURN				;;
	MOV KEYFG0,W0			;;
	MOV W0,KEYFC0			;;
	MOV KEYFG1,W0			;;
	MOV W0,KEYFC1			;;
	MOV KEYFG2,W0			;;
	MOV W0,KEYFC2			;;
	RETURN				;;
NO_KEY:					;;
	CLR YESKEY_TIM 			;;
	INC NOKEY_TIM			;;
	MOV #3,W0			;;
	CP NOKEY_TIM			;;
	BRA GEU,$+4			;;
	RETURN				;;
	BTSC FLAGA,#DISKR_F		;;
	BRA NO_KEY1			;;
	MOV KEYFRB0,W0			;;
	MOV W0,KEYFR0			;;
	MOV KEYFRB1,W0			;;
	MOV W0,KEYFR1			;;
	MOV KEYFRB2,W0			;;
	MOV W0,KEYFR2			;;
NO_KEY1:				;;
	CLR KEYFB0			;;
	CLR KEYFB1			;;
	CLR KEYFB2			;;
	CLR KEYFRB0			;;
	CLR KEYFRB1			;;
	CLR KEYFRB2			;;
	CLR CONKEY_TIM			;;
	BCLR FLAGA,#DISKP_F		;;
	BCLR FLAGA,#DISKR_F		;;
	BCLR FLAGA,#DISKC_F		;;
	BTSS FLAGC,#WKEY_F		;;
	RETURN				;;
	MOV #AUTO_KEY_K,W0		;;
	CP0 W0				;;
	BRA Z,NO_KEY2
	MOV WKEY_BUF,W0			;;
	MOV W0,WKEY_CNT			;;
	MOV W0,OLED_CNT			;;
	MOV #0,W0			;;
	MOV W0,WPAGE_CNT		;;
	CALL WKP_OLED			;;WD
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NO_KEY2:				;;
	BCLR FLAGC,#WKEY_F		;;
	MOV WKEY_BUF,W0			;;
	CALL CLRX_LED			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	MOV #0x07FF,W0			;;
	MOV W0,LATB 			;;
	MOV #0x0003,W0			;;
	MOV W0,TRISB 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF000,W0			;;
	MOV W0,LATC 			;;
	MOV #0xF000,W0			;;
	MOV W0,TRISC 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0C0C,W0			;;
	MOV W0,LATD 			;;
	MOV #0x0C0C,W0			;;
	MOV W0,TRISD 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0			;;DB OUT
	MOV W0,LATE 			;;
	MOV #0x0000,W0			;;
	MOV W0,TRISE 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0030,W0			;;
	MOV W0,ODCF			;;
	MOV #0x0030,W0			;;
	MOV W0,LATF 			;;
	MOV #0x0000,W0			;;
	MOV W0,TRISF 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x030C,W0			;;
	MOV W0,LATG 			;;
	MOV #0x010C,W0			;;
	MOV W0,TRISG 			;;
	BSET KEY0,#KEY0_P		;;
	BSET KEY1,#KEY1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DARK_OLED:				;;
	BTSC SET_OLEDPRO,#0		;;
 	RETURN				;;
	BCLR OLDC,#OLDC_P		;;
	MOV #0,W0			;;
	MOV W0,OLED_CNT			;;
DARK_OLED_0:				;;
	CALL OLED_PRG			;;
	MOV #0x0087,W0			;;
	CALL SPI2PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #0,W0			;;
	CALL SPI2PRG			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC OLED_CNT			;;
	MOV OLED_CNT,W0			;;
	SUB #OLED_AMT_K,W0		;;
	BTSS SR,#Z			;;
	BRA DARK_OLED_0			;;
	BSET OLDC,#OLDC_P		;;
	MOV #0,W0			;;
	MOV W0,OLED_CNT			;;
	BSET FLAGB,#DARK_OLED_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETCUR_OLED:				;;
	BCLR FLAGB,#DARK_OLED_F		;;
	CLR OLEDPRO_TIM			;;
	BCLR OLDC,#OLDC_P		;;
	MOV #0,W0			;;
	MOV W0,OLED_CNT			;;
SETCUR_OLED_0:				;;
	CALL OLED_PRG			;;
	MOV #0x0087,W0			;;
	CALL SPI2PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV OLED_CNT,W2			;;
	BCLR W2,#0			;;
	BCLR W2,#1			;;	
	ASR W2,#2,W2 			;;
	MOV #SET_CUR0,W1		;;
	ADD W2,W1,W1			;;
	ADD W2,W1,W1			;;
	MOV [W1],W2			;;
	BTSC OLED_CNT,#0		;;
	ASR W2,#4,W2 			;;	
	BTSC OLED_CNT,#1		;;
	ASR W2,#8,W2 			;;
	MOV W2,W0			;;
	AND #15,W0			;;
	CALL SPI2PRG			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC OLED_CNT			;;
	MOV OLED_CNT,W0			;;
	SUB #OLED_AMT_K,W0		;;
	BTSS SR,#Z			;;
	BRA SETCUR_OLED_0		;;
	BSET OLDC,#OLDC_P		;;
	MOV #0,W0			;;
	MOV W0,OLED_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_OLED:				;;
	BCLR OLRST,#OLRST_P		;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	BSET OLRST,#OLRST_P		;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	BCLR OLDC,#OLDC_P		;;
	MOV #0,W0			;;
	MOV W0,OLED_CNT			;;
INIT_OLED_0:				;;
	CALL SET_OLED			;;
	INC OLED_CNT			;;
	MOV OLED_CNT,W0			;;
	SUB #OLED_AMT_K,W0		;;
	BTSS SR,#Z			;;
	BRA INIT_OLED_0			;;
	BSET OLDC,#OLDC_P		;;
	MOV #0,W0			;;
	MOV W0,OLED_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SEND_FLASH0_OLED_BE:			;;FLASH0->OLED
	BRA WALL_OLED
	MOV #0,W0			;;全部第1張圖
	MOV W0,FLASH0_CNT		;;
	MOV #0,W0			;;
	MOV W0,OLED_CNT			;;
SEND_FLASH0_OLED_BE_2:			;;
	CALL INIT_SPI2_L		;;
	BCLR OLDC,#OLDC_P		;;
	CALL OLED_PRG			;;
	CALL COLUMNRANGE		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL ROWSRANGE			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET OLDC,#OLDC_P		;;
	CALL INIT_SPI2_H		;;
	CALL GET_FLASH_ADR		;;
	MOV #6144,W0			;;
	MOV W0,R0			;;
SEND_FLASH0_OLED_BE_0:			;;
	CALL FLASH_RDSR		;;
	BTSC W0,#0			;;
	BRA SEND_FLASH0_OLED_BE_0	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLSCS0,#FLSCS0_P		;;
	MOV #0x0003,W0			;;
	CALL SPI1PRG			;;
	MOV FADR2,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	CALL SPI1PRG			;;
SEND_FLASH0_OLED_BE_1:			;;
	CALL OLED_PRG			;;
	CALL SPI1PRG			;;
	CALL SPI2PRG			;;
	CALL OLED_OFF			;;
	DEC R0				;;
	BTSS SR,#Z			;;
	BRA SEND_FLASH0_OLED_BE_1	;;
	BSET FLSCS0,#FLSCS0_P		;;
	INC OLED_CNT			;;
	INC FLASH0_CNT			;;
	MOV OLED_CNT,W0			;;
	SUB #36,W0			;;
	BTSS SR,#Z			;;
	BRA SEND_FLASH0_OLED_BE_2	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WKP_ALL_LED:				;;
	CLR OLED_CNT			;;
WKP_ALL_LED1:				;;
	CLRWDT				;;
	MOV OLED_CNT,W0			;;
	MOV #KEYV_BUF+72,W1		;;
	BTSS FLAGC,#KEYAB_F		;;
	MOV #KEYV_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	BTSS W0,#15			;;
	BRA WKP_ALL_LED1A		;;
	MOV OLED_CNT,W0			;;
	CALL SETX_LED			;;
	BRA WKP_ALL_LED2		;;
WKP_ALL_LED1A:				;;
	MOV OLED_CNT,W0			;;
	CALL CLRX_LED			;;
	BRA WKP_ALL_LED2		;;
WKP_ALL_LED2:				;;
	INC OLED_CNT			;;
	MOV #OLED_AMT_K,W0		;;
	CP OLED_CNT			;;
	BRA LTU,WKP_ALL_LED1		;;
	RETURN 				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WKP_ALL_OLED:				;;
	CLR OLED_CNT			;;
WKP_ALL_OLED1:				;;
	CLRWDT				;;
	MOV OLED_CNT,W0			;;
	MOV W0,WKEY_CNT			;;
	MOV #KEYV_BUF+72,W1		;;
	BTSS FLAGC,#KEYAB_F		;;
	MOV #KEYV_BUF,W1		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	AND #31,W0			;; 
	MOV W0,WPAGE_CNT		;;
	CALL WKP_OLED			;;WD
	BTSC SR,#C			;;
	BRA WKP_ALL_OLED2		;;	
	CLR R1				;;
	CALL WDOLED			;;
WKP_ALL_OLED2:				;;
	INC OLED_CNT			;;
	MOV #OLED_AMT_K,W0		;;
	CP OLED_CNT			;;
	BRA LTU,WKP_ALL_OLED1		;;
	RETURN 				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_BMPADR:				;;
	MOV WPAGE_CNT,W0		;;
	CALL BMPPAGE_ADR		;;
	MOV W0,FADR1			;;
	CLR FADR0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x2000,W0			;;
	MUL WKEY_CNT			;;
	MOV W2,W0			;;
	ADD FADR0			;;
	MOV W3,W0			;;
	ADDC FADR1			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	BTSC FADR1,#6			;;
	BSET FLAGB,#FLASH_AB_F		;;
	RETURN				;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WKP_OLED:				;;
	CALL GET_BMPADR			;;
	CALL READ_FLASH_BYTE		;;		
	MOV #0x00AB,W1			;;
	CP W0,W1	 		;;	
	BRA NZ,WKPA_ERR			;;
	CALL READ_FLASH_BYTE		;;		
	MOV #0x00CD,W1			;;
	CP W0,W1	 		;;	
	BRA NZ,WKPA_ERR			;;
	CALL READ_FLASH_BYTE		;;		
	CALL READ_FLASH_BYTE		;;		
	CALL READ_FLASH_BYTE		;;		
	CP WKEY_CNT			;;
	BRA NZ,WKPA_ERR			;;
	CALL READ_FLASH_BYTE		;;		
	CALL READ_FLASH_BYTE		;;		
	CP WPAGE_CNT			;;
	BRA NZ,WKPA_ERR			;;
GGGTT:
	MOV #0xFF00,W0			;;
	AND FADR0			;;
	BSET FADR0,#5			;;
	CALL WF_OLED			;;
	BSET SR,#C			;;
	RETURN				;;
WKPA_ERR:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
;	CALL READ_FLASH_BYTE		;;		
;	BRA WKPA_ERR
	NOP
	NOP
	NOP
	BCLR SR,#C
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WKP_OLED_ERR:				;;
	BCLR SR,#C			;;
	RETURN				;;
WKP_OLED2:				;;
	MOV #0x2000,W0			;;
	MUL R3				;;
	MOV W2,FADR0			;;
	MOV W3,FADR1			;;
	INC FADR1			;;
	BSET FADR0,#5			;;ADD 32
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFFC0,W0			;;
	AND FADR1,WREG			;;
	BCLR FLAGB,#FLASH_AB_F		;;
	BTSS SR,#Z			;;
	BSET FLAGB,#FLASH_AB_F		;;
	MOV #0x003F,W0			;;
	AND FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL WF_OLED			;;
	BSET SR,#C			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WF_OLED:				;;
	BCLR OLDC,#OLDC_P		;;
	CALL OLED_ON			;;
	CALL COLUMNRANGE		;;
	CALL OLED_OFF			;;
	CALL OLED_ON			;;
	CALL ROWSRANGE			;;
	CALL OLED_OFF			;;
	BSET OLDC,#OLDC_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WF_OLED1:				;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA WF_OLED1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLASH_CS			;;
	MOV #0x0003,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	BCLR W0,#6			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	CALL SPI1PRG			;;
	MOV #6144,W0			;;
	MOV W0,R0			;;
;	CALL SPI1PRG			;;
;	MOV W0,W1			;;
WF_OLED3:				;;
	CALL OLED_ADR_TBL		;;
	XOR LATD,WREG			;;
	AND #0x00F3,W0			;;
	XOR LATD			;;
	CALL SPI1PRG				
	CALL SPI2PRG
;	MOV W1,SPI2BUF			;;
;	MOV W1,SPI1BUF			;;
;WF_OLED2:				;;
;	BTSC SPI2STAT,#1		;;
;	BRA WF_OLED2   			;;
;	BTSS SPI2STAT,#0		;;
;	BRA WF_OLED2   			;;
;	MOV.B SPI2BUF,WREG		;;
;	MOV #0x00E0,W0			;;
;	IOR LATD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV SPI1BUF,W1			;;
	DEC R0				;;
	BRA NZ,WF_OLED3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WOLED:					;;
	BCLR OLDC,#OLDC_P		;;
	CALL OLED_ON			;;
	CALL COLUMNRANGE		;;
	CALL OLED_OFF			;;
	CALL OLED_ON			;;
	CALL ROWSRANGE			;;
	CALL OLED_OFF			;;
	BSET OLDC,#OLDC_P		;;
	CALL GET_FLASH_ADR		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WOLED1:					;;
	CALL FLASH_RDSR			;;
	BTSC W0,#0			;;
	BRA WOLED1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLSCS0,#FLSCS0_P		;;
	MOV #0x0003,W0			;;
	CALL SPI1PRG			;;
	MOV FADR1,W0			;;
	BCLR W0,#6			;;
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	SWAP W0
	CALL SPI1PRG			;;
	MOV FADR0,W0			;;
	CALL SPI1PRG			;;
	MOV #6144,W0			;;
	MOV W0,R0			;;
	CALL SPI1PRG			;;
	MOV W0,W1			;;
WOLED3:					;;
	CALL OLED_ADR_TBL		;;
	XOR LATD,WREG			;;
	AND #0x00F3,W0			;;
	XOR LATD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,SPI2BUF			;;
	MOV W1,SPI1BUF			;;
WOLED2:					;;
	BTSC SPI2STAT,#1		;;
	BRA WOLED2   			;;
	BTSS SPI2STAT,#0		;;
	BRA WOLED2   			;;
	MOV.B SPI2BUF,WREG		;;
	MOV #0x00E0,W0			;;
	IOR LATD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPI1BUF,W1			;;
	DEC R0				;;
	BRA NZ,WOLED3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLSCS0,#FLSCS0_P		;;
	BSET FLSCS1,#FLSCS1_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WDOLED:					;;
	BCLR OLDC,#OLDC_P		;;
	CALL OLED_ON			;;
	CALL COLUMNRANGE		;;
	CALL OLED_OFF			;;
	CALL OLED_ON			;;
	CALL ROWSRANGE			;;
	CALL OLED_OFF			;;
	BSET OLDC,#OLDC_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_ADR_TBL		;;
	XOR LATD,WREG			;;
	AND #0x00F3,W0			;;
	XOR LATD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #6144,W0			;;
	MOV W0,R0			;;
WDOLED1:				;;
;	CALL OLED_ADR_TBL		;;
;	XOR LATD,WREG			;;
;	AND #0x00F3,W0			;;
;	XOR LATD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R1,W1			;;
	BTSS R0,#0			;;
	SWAP W1				;;
	MOV W1,SPI2BUF			;;
WDOLED2:				;;
	BTSC SPI2STAT,#1		;;
	BRA WDOLED2   			;;
	BTSS SPI2STAT,#0		;;
	BRA WDOLED2   			;;
	MOV.B SPI2BUF,WREG		;;
;	MOV #0x00E0,W0			;;
;	IOR LATD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPI1BUF,W1			;;
	DEC R0				;;
	BRA NZ,WDOLED1			;;
	MOV #0x00E0,W0			;;
	IOR LATD			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WALL_OLED:				;;
	CLR OLED_CNT			;;
	CLR FLASH0_CNT			;;
WALL_OLED1:				;;
	CALL WDOLED			;;
	INC OLED_CNT			;;
	INC FLASH0_CNT			;;
	MOV #OLED_AMT_K,W0		;;
	CP OLED_CNT			;;
	BRA LTU,WALL_OLED1		;;
	RETURN 				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_OLED:				;;
	CALL INIT_OLED			;;
	CALL U1TX_W			;;
	MOV #0xFFFF,W0			;;
	MOV W0,R1			;;	
	CALL WALL_OLED			;;
	MOV #200,W0 			;;
	CALL DLYMX			;;
	CALL U1TX_W			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x001F,W0			;;
	MOV W0,R1			;;
	CALL WALL_OLED			;;
	MOV #200,W0 			;;
	CALL DLYMX			;;
	CALL U1TX_W			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x07E0,W0			;;
	MOV W0,R1			;;
	CALL WALL_OLED			;;
	MOV #200,W0 			;;
	CALL DLYMX			;;
	CALL U1TX_W			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF800,W0			;;
	MOV W0,R1			;;
	CALL WALL_OLED			;;
	MOV #200,W0 			;;
	CALL DLYMX			;;
	CALL U1TX_W			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0			;;
	MOV W0,R1			;;
	CALL WALL_OLED			;;
	CALL U1TX_D			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OLED_OFF:				;;
	MOV #0x00E0,W0			;;
	IOR LATD			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OLED_ON:				;;
OLED_PRG:				;;
	CALL OLED_ADR_TBL		;;
	XOR LATD,WREG			;;
	AND #0x00F3,W0			;;
	XOR LATD			;;
	RETURN				;;
OLED_ADR_TBL:				;;
	MOV #OLED_AMT_K,W0		;;	
	CP W0,#24			;;
	BRA NZ,OLED_ADR_TBL36		;;
OLED_ADR_TBL24:				;;
	MOV OLED_CNT,W0			;;
	BRA W0				;;
	RETLW #OLED00_ADR,W0		;;
	RETLW #OLED01_ADR,W0		;;
	RETLW #OLED02_ADR,W0		;;
	RETLW #OLED03_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED08_ADR,W0		;;
	RETLW #OLED09_ADR,W0		;;
	RETLW #OLED10_ADR,W0		;;
	RETLW #OLED11_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED16_ADR,W0		;;
	RETLW #OLED17_ADR,W0		;;
	RETLW #OLED18_ADR,W0		;;
	RETLW #OLED19_ADR,W0		;;


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED04_ADR,W0		;;
	RETLW #OLED05_ADR,W0		;;
	RETLW #OLED06_ADR,W0		;;
	RETLW #OLED07_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED12_ADR,W0		;;
	RETLW #OLED13_ADR,W0		;;
	RETLW #OLED14_ADR,W0		;;
	RETLW #OLED15_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED20_ADR,W0		;;
	RETLW #OLED21_ADR,W0		;;
	RETLW #OLED22_ADR,W0		;;
	RETLW #OLED23_ADR,W0		;;


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED24_ADR,W0		;;
	RETLW #OLED25_ADR,W0		;;
	RETLW #OLED26_ADR,W0		;;
	RETLW #OLED27_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED28_ADR,W0		;;
	RETLW #OLED29_ADR,W0		;;
	RETLW #OLED30_ADR,W0		;;
	RETLW #OLED31_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED32_ADR,W0		;;
	RETLW #OLED33_ADR,W0		;;
	RETLW #OLED34_ADR,W0		;;
	RETLW #OLED35_ADR,W0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OLED_ADR_TBL36:				;;
	MOV OLED_CNT,W0			;;
	BRA W0				;;
	RETLW #OLED00_ADR,W0		;;
	RETLW #OLED01_ADR,W0		;;
	RETLW #OLED02_ADR,W0		;;
	RETLW #OLED03_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED12_ADR,W0		;;
	RETLW #OLED13_ADR,W0		;;
	RETLW #OLED14_ADR,W0		;;
	RETLW #OLED15_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED24_ADR,W0		;;
	RETLW #OLED25_ADR,W0		;;
	RETLW #OLED26_ADR,W0		;;
	RETLW #OLED27_ADR,W0		;;




	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED04_ADR,W0		;;
	RETLW #OLED05_ADR,W0		;;
	RETLW #OLED06_ADR,W0		;;
	RETLW #OLED07_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED16_ADR,W0		;;
	RETLW #OLED17_ADR,W0		;;
	RETLW #OLED18_ADR,W0		;;
	RETLW #OLED19_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED28_ADR,W0		;;
	RETLW #OLED29_ADR,W0		;;
	RETLW #OLED30_ADR,W0		;;
	RETLW #OLED31_ADR,W0		;;


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED08_ADR,W0		;;
	RETLW #OLED09_ADR,W0		;;
	RETLW #OLED10_ADR,W0		;;
	RETLW #OLED11_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED20_ADR,W0		;;
	RETLW #OLED21_ADR,W0		;;
	RETLW #OLED22_ADR,W0		;;
	RETLW #OLED23_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETLW #OLED32_ADR,W0		;;
	RETLW #OLED33_ADR,W0		;;
	RETLW #OLED34_ADR,W0		;;
	RETLW #OLED35_ADR,W0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPI2PRG:				;;
	MOV W0,SPI2BUF			;;
SPI2PRG_0:				;;
	BTSC SPI2STAT,#1		;;
	BRA SPI2PRG_0			;;
	BTSS SPI2STAT,#0		;;
	BRA SPI2PRG_0			;;
	MOV.B SPI2BUF,WREG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COLORA:					;;
	MOV #0x0081,W0			;;COLOR A 
	CALL SPI2PRG			;;
	MOV #0x0019,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COLORB:					;;
	MOV #0x0082,W0			;;COLOR B
	CALL SPI2PRG			;;
	MOV #0x0014,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COLORC:					;;
	MOV #0x0083,W0			;;COLOR C
	CALL SPI2PRG			;;
	MOV #0x0024,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MASTERCONTROL:				;;
	MOV #0x0087,W0			;;MASTER COLOR CONTROL
	CALL SPI2PRG			;;
	MOV #0x000F,W0			;;
	MOV #0x0008,W0			;;<<current
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEPTHSETTING:				;;
	MOV #0x00A0,W0			;;REMAP & COLOR DEPTH SETTING
	CALL SPI2PRG			;;
	MOV #0x0070,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STARTLINE:				;;
	MOV #0x00A1,W0			;;SET DESPLAY START LINE
	CALL SPI2PRG			;;
	MOV #0x0000,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DESPLAYOFFSET:				;;
	MOV #0x00A2,W0			;;SET DESPLAY OFFSET
	CALL SPI2PRG			;;
	MOV #0x0010,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NORMALDISPLAY:				;;
	MOV #0x00A4,W0			;;NORMAL DISPLAY
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MULTIPLEXRATIO:				;;
	MOV #0x00A8,W0			;;MULTIPLEX RATIO
	CALL SPI2PRG			;;
	MOV #0x002F,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DIMMODESETTING:				;;
	MOV #0x00AB,W0			;;DIM MODE SETTING FOR COLOR A'B'C
	CALL SPI2PRG			;;
	MOV #0x0000,W0			;;
	CALL SPI2PRG			;;
	MOV #0x0012,W0			;;
	CALL SPI2PRG			;;
	MOV #0x000C,W0			;;
	CALL SPI2PRG			;;
	MOV #0x0014,W0			;;
	CALL SPI2PRG			;;
	MOV #0x0012,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONFIGULATION:				;;
	MOV #0x00AD,W0			;;MASTER CONFIGULATION
	CALL SPI2PRG			;;
	MOV #0x008E,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
POWERSAVEMODE:				;;
	MOV #0x00B0,W0			;;POWER SAVE MODE
	CALL SPI2PRG			;;
	MOV #0x000B,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PERIODADJUSTMENT:			;;
	MOV #0x00B1,W0			;;PHASE 1 & 2 PERIOD ADJUSTMENT
	CALL SPI2PRG			;;
	MOV #0x0044,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLOCKDIVIDER:				;;
	MOV #0x00B3,W0			;;DISPLAY CLOCK DIVIDER / OSCILLATOR FREQUENCY
	CALL SPI2PRG			;;
	MOV #0x00A0,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GRAYSCALE: 				;;
	MOV #0x00B9,W0			;;ENABLE LINEAR GRAY SCALE
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHARGELEVEL:				;;
	MOV #0x00BB,W0			;;PRE CHARGE LEVEL
	CALL SPI2PRG			;;
	MOV #0x0012,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETVCOMH:				;;
	MOV #0x00BE,W0			;;SET VCOMH
	CALL SPI2PRG			;;
	MOV #0x0028,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLAYNORMAL:				;;
	MOV #0x00AF,W0			;;DISPLAY ON IN NORMAL MODE
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COLUMNRANGE:				;;
	MOV #0x0015,W0			;;SET THE COLUMN RANGE
	CALL SPI2PRG			;;
	MOV #0x0010,W0			;;
	CALL SPI2PRG			;;
	MOV #0x004F,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ROWSRANGE:				;;
	MOV #0x0075,W0			;;SET THE ROWS RANGE
	CALL SPI2PRG			;;
	MOV #0x0000,W0			;;
	CALL SPI2PRG			;;
	MOV #0x002F,W0			;;
	CALL SPI2PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_OLED:				;;
	CALL OLED_PRG			;;
	CALL DISPLAYNORMAL		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL COLUMNRANGE		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL ROWSRANGE			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL COLORA			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL COLORB			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL COLORC			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL MASTERCONTROL		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL DEPTHSETTING		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL STARTLINE			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL DESPLAYOFFSET		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL NORMALDISPLAY		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL MULTIPLEXRATIO		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL DIMMODESETTING		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL CONFIGULATION		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL POWERSAVEMODE		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL PERIODADJUSTMENT		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL CLOCKDIVIDER		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL GRAYSCALE			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL CHARGELEVEL		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL SETVCOMH			;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_PRG			;;
	CALL DISPLAYNORMAL		;;
	CALL OLED_OFF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



DLYMX:
	PUSH W1
DLYMX0:
	CLRWDT
	MOV #4000,W1
DLYMX1:
	NOP
	DEC W1,W1
	BRA NZ,DLYMX1
	DEC W0,W0
	BRA NZ,DLYMX0
	POP W1
	RETURN


PS2_HOST_REQ:
	RETURN









DLY100US:
	MOV #400,W0
	BRA DLYUS_LOOP
DLY40US:
	MOV #160,W0
	BRA DLYUS_LOOP
DLY30US:
	MOV #120,W0
	BRA DLYUS_LOOP
DLY10US:
	MOV #40,W0
	BRA DLYUS_LOOP
DLYUS_LOOP:
	NOP
	DEC W0,W0
	BRA NZ,DLYUS_LOOP
	RETURN 



DLY1000US_I:
	MOV #(4000-2000),W0
	BRA DLY_I
DLY100US_I:
	MOV #(4000-200),W0
	BRA DLY_I
DLY40US_I:
	MOV #(4000-80),W0
	BRA DLY_I
DLY30US_I:
	MOV #(4000-60),W0
	BRA DLY_I
DLY10US_I:
	MOV #(4000-20),W0
	BRA DLY_I
DLY_I:
	MOV W0,TMR4
	POP DLYI_RET0
	POP DLYI_RET1
	BSET FLAGB,#DLYI_RET_F 
	BRA T4INT_END
 	


		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1TXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	BCLR IFS0,#12			;;
	CP0 U1TX_BTX			;;
	BRA Z,U1TX1_END			;;
	MOV #U1TX_BUF,W0		;;
	ADD U1TX_BCNT,WREG		;;
	BCLR W0,#0
	MOV [W0],W0			;;
	BTSC U1TX_BCNT,#0		;;
	SWAP W0				;;
	MOV W0,U1TXREG			;;
	INC U1TX_BCNT			;;
	DEC U1TX_BTX			;; 
	CLR U1TXED_TIM			;;
U1TX1_END:				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1RXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	PUSH W2				;;
	BCLR IFS0,#11			;;
	MOV U1RXREG,W1			;;
	AND #255,W1			;;
	BTSC FLAGB,#U1RX_PACK_F		;;
	BRA U1RXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #'$',W0			;;
	CP W0,W1			;;
	BRA NZ,U1RXI_1			;;	
	CLR U1RX_BYTE_PTR		;;
	BRA U1RXI_END			;;
U1RXI_1:				;;
	MOV #'#',W0			;;
	CP W0,W1			;;
	BRA NZ,U1RXI_2			;;
	MOV U1RX_BYTE_PTR,W0		;;
	MOV W0,U1RX_BYTE		;;
	BSET FLAGB,#U1RX_PACK_F		;;
	CLR U1RX_BYTE_PTR		;; 
	MOV #8,W0			;;
	CP U1RX_BYTE			;;
	BRA NZ,U1RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_BUF,W1		;;
	MOV [W1],W2			;;
	MOV #0x3142,W0			;;
	CP W2,W0			;;
	BRA Z,U1RXI_1A			;;
	MOV #0x3042,W0			;;
	CP W2,W0			;;
	BRA NZ,U1RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_1A:				;;
	BCLR FLAGB,#U1RX_PACK_F		;;
	INC U1RX_PCNT0,WREG		;;
	XOR U1RX_PCNT1,WREG		;;
	AND #0x007F,W0			;;	
	BRA Z,U1RXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC U1RX_PCNT0			;;
	MOV U1RX_PCNT0,W0		;;
	AND #0x7F,W0			;;
	MUL.UU W0,#10,W0		;;
	MOV #U1RX_FIFO,W1		;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RX_BUF,W0		;;
	MOV U1RX_BYTE,W2		;;	
	MOV W2,[W1++]			;;	
	MOV [W0++],W2			;;
	MOV W2,[W1++]			;;	
	MOV [W0++],W2			;;
	MOV W2,[W1++]			;;	
	MOV [W0++],W2			;;
	MOV W2,[W1++]			;;	
	MOV [W0++],W2			;;
	MOV W2,[W1++]			;;
;	CALL U1TX_D			;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	MOV #'N',W0			;;
	MOV W0,U1TXREG			;;
	CLR U1TXED_TIM			;;
	BRA U1RXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_2:				;;
	MOV #256,W0			;;
	CP U1RX_BYTE_PTR		;;
	BRA GEU,U1RXI_END		;;
	MOV #U1RX_BUF,W0		;;
	ADD U1RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS U1RX_BYTE_PTR,#0		;;
	CLR [W0]			;;
	BTSC U1RX_BYTE_PTR,#0		;;
	SWAP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W0],W2			;;
	IOR W1,W2,W2 			;;
	MOV W2,[W0]			;;
	INC U1RX_BYTE_PTR		;;
U1RXI_END:				;;
	POP W2				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T4Interrupt:				;;
	PUSH SR				;;	
	PUSH W0				;;
	BTSS FLAGB,#DLYI_RET_F		;;
	BRA T4INT1			;;
	BCLR FLAGB,#DLYI_RET_F		;;
	PUSH DLYI_RET1			;;
	PUSH DLYI_RET0			;;
	RETURN				;;
T4INT1:					;;
	BTSS PS2DATA_IN,#PS2DATA_P	;;
	BRA IPS2_BYTEIN  		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
IPS2_BYTEOUT:				;;
	BTSS FLAGB,#PS2_TX_F		;;	 
	BRA T4INT_END			;;
IPS2_INHIBIT:				;;
	CALL DLY40US_I			;;
	BTSS PS2CLK_IN,#PS2CLK_P	;;
	BRA IPS2_INHIBIT		;;
	CALL DLY40US_I			;;
	BTSS PS2CLK_IN,#PS2CLK_P	;;
	BRA IPS2_INHIBIT		;;
	BTSS PS2DATA_IN,#PS2DATA_P	;;
	BRA IPS2_BYTEIN  		;;
	CLR PS2_PARITY			;;
	MOV #8,W0			;;
	MOV W0,PS2_BITCNT		;;
	MOV #0,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #1,W0			;;
	BTSS SR,#Z			;;
	BSET PS2DATA,#PS2DATA_P		;;
	BTSC SR,#Z			;;
	BCLR PS2DATA,#PS2DATA_P		;;
	CALL DLY10US_I	;21		;;
	BCLR PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2CLK,#PS2CLK_P		;;
	CALL DLY30US_I			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS PS2CLK_IN,#PS2CLK_P	;;
	BRA IPS2_BYTEOUT_ABORT		;;
	MOV #PS2_TXDATA0,W0		;;	
	ADD PS2_TXBYTE,WREG		;;
	ADD PS2_TXBYTE,WREG 		;;
	MOV [W0],W0			;;
	MOV W0,PS2_TXTEMP		;;
	MOV W0,PS2_TXBUF		;;	
IPS2_BYTEOUT1: 				;;
	MOV PS2_TXBUF,W0		;;
	XOR PS2_PARITY			;;
	AND #1,W0			;;
	BTSS SR,#Z			;;
	BSET PS2DATA,#PS2DATA_P		;;
	BTSC SR,#Z			;;
	BCLR PS2DATA,#PS2DATA_P		;;
	CALL DLY10US_I	;21		;;
	BCLR PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2CLK,#PS2CLK_P		;;
	CALL DLY30US_I			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS PS2CLK_IN,#PS2CLK_P	;;
	BRA IPS2_BYTEOUT_ABORT		;;
	RRNC PS2_TXBUF			;;
	DEC PS2_BITCNT			;;
	BRA NZ,IPS2_BYTEOUT1		;;
	COM PS2_PARITY,WREG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #1,W0			;;
	BTSS SR,#Z			;;
	BSET PS2DATA,#PS2DATA_P		;;
	BTSC SR,#Z			;;
	BCLR PS2DATA,#PS2DATA_P		;;
	CALL DLY10US_I	;21		;;
	BCLR PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2CLK,#PS2CLK_P		;;
	CALL DLY30US_I			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS PS2CLK_IN,#PS2CLK_P 	;;Test for inhibit
	BRA IPS2_BYTEOUT_ABORT		;;
	MOV #0xFFFF,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #1,W0			;;
	BTSS SR,#Z			;;
	BSET PS2DATA,#PS2DATA_P		;;
	BTSC SR,#Z			;;
	BCLR PS2DATA,#PS2DATA_P		;;
	CALL DLY10US_I	;21		;;
	BCLR PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2CLK,#PS2CLK_P		;;
	CALL DLY30US_I			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL DLY1000US_I	;48	;;
	INC PS2_TXBYTE			;;
	MOV PS2_TXLIM,W0		;;
	CP PS2_TXBYTE			;;
	BRA LTU,IPS2_BYTEOUT
	BCLR FLAGB,#PS2_TX_F		;;
	BRA T4INT_END			;;
IPS2_BYTEOUT_ABORT:			;;
	BSET PS2DATA,#PS2DATA_P		;;
	BSET PS2CLK,#PS2CLK_P		;;
	BCLR FLAGB,#PS2_TX_F		;;
	BRA T4INT_END			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IPS2_BYTEIN:				;;
	CALL DLY40US_I			;;
	BTSS PS2CLK_IN,#PS2CLK_P	;;
	BRA IPS2_BYTEIN			;;
	BTSC PS2DATA_IN,#PS2DATA_P	;;
	BRA IPS2_BYTEIN_ABORT		;;
	MOV #8,W0			;;
	MOV W0,PS2_BITCNT		;;		
	CLR PS2_PARITY			;;	
	CALL DLY40US_I			;;
IPS2_BYTEIN_LOOP: 			;;
	BCLR PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2_RXDATA,#8 		;;
	BTSS PS2DATA_IN,#PS2DATA_P	;;
	BCLR PS2_RXDATA,#8 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS PS2CLK_IN,#PS2CLK_P	;;
	BRA IPS2_BYTEIN_ABORT		;;
	RRC PS2_RXDATA			;;
	MOV PS2_RXDATA,W0		;;
	XOR PS2_PARITY 			;;
	DEC PS2_BITCNT			;;
	BRA NZ,IPS2_BYTEIN_LOOP		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2_RXDATA,#8 		;;
	BTSS PS2DATA_IN,#PS2DATA_P	;;	
	BCLR PS2_RXDATA,#8 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS PS2CLK_IN,#PS2CLK_P	;;
	BRA IPS2_BYTEIN_ABORT		;;
	RRC PS2_RXDATA,WREG		;;
	XOR PS2_PARITY 			;;
IPS2_BYTEIN_LOOP1:			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2_RXDATA,#8 		;;
	BTSS PS2DATA_IN,#PS2DATA_P	;;
	BCLR PS2_RXDATA,#8 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS PS2CLK_IN,#PS2CLK_P	;;
	BRA IPS2_BYTEIN_ABORT		;;
	BTSS PS2_RXDATA,#8		;;
	CLR PS2_PARITY			;;
	BTSS PS2_RXDATA,#8		;;
	BRA IPS2_BYTEIN_LOOP1 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR PS2DATA,#PS2DATA_P		;;
	CALL DLY10US_I			;;
	BCLR PS2CLK,#PS2CLK_P		;;
	CALL DLY40US_I			;;
	BSET PS2CLK,#PS2CLK_P		;;
	CALL DLY10US_I			;;
	BSET PS2DATA,#PS2DATA_P		;;
	MOV #255,W0			;;
	AND PS2_RXDATA			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #(4000-2000),W0		;;
	MOV W0,TMR4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFE,W0			;;	
	CP PS2_RXDATA			;;
	BRA NZ,IPS2_BYTEIN1		;;
	MOV PS2_TXTEMP,W0		;;
	MOV W0,PS2_TXDATA0		;;
	MOV #1,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	BRA T4INT_END			;;
IPS2_BYTEIN1:				;;
	MOV #0xEE,W0			;;	
	CP PS2_RXDATA			;;
	BRA NZ,IPS2_BYTEIN1A		;;
	MOV #0xEE,W0			;;	
	MOV W0,PS2_TXDATA0		;;
	MOV #1,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	BRA T4INT_END			;;
IPS2_BYTEIN1A:	
	MOV #0xF2,W0			;;	
	CP PS2_RXDATA			;;
	BRA NZ,IPS2_BYTEIN1B		;;
	MOV #0xFA,W0			;;	
	MOV W0,PS2_TXDATA0		;;
	MOV #0xAB,W0			;;	
	MOV W0,PS2_TXDATA1		;;
	MOV #0x83,W0			;;	
	MOV W0,PS2_TXDATA2		;;
	MOV #3,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	BRA T4INT_END			;;
IPS2_BYTEIN1B:	
	MOV #0xFF,W0			;;	
	CP PS2_RXDATA			;;
	BRA NZ,IPS2_BYTEIN2		;;
	CLR PS2VCC_TIM			;;
	BCLR FLAGC,#KEYBO_OK_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IPS2_BYTEIN2:				;;
	CLR CLRPS2_CMD_TIM		;;
	MOV #0xFA,W0			;;	
	MOV W0,PS2_TXDATA0		;;
	MOV #1,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP0 PS2_CMD			;;
	BRA NZ,IPS2_BYTEIN3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 	MOV #0x00F2,W0			;;	
	CP PS2_RXDATA			;;
	BRA NZ,QQWW			;;
	MOV #0xFA,W0			;;	
	MOV W0,PS2_TXDATA0		;;
	MOV #0xAB,W0			;;	
	MOV W0,PS2_TXDATA1		;;
	MOV #0x83,W0			;;	
	MOV W0,PS2_TXDATA2		;;
	MOV #3,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	BRA T4INT_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
QQWW:					;;
 	MOV #0x00ED,W0			;;	
	CP PS2_RXDATA			;;
	BRA LTU,T4INT_END		;;
	MOV PS2_RXDATA,W0		;;
	MOV W0,PS2_CMD			;;
	BRA T4INT_END			;;
IPS2_BYTEIN3:				;;
	CALL PS2_DECORD 		;;
	BRA T4INT_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IPS2_BYTEIN_ABORT:			;;
	BSET FLAGA,#PS2_RXERR_F		;;
	CLR PS2_RXDATA			;;		 
	BRA T4INT_END			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
T4INT_END:				;;
	BCLR IFS1,#T4IF			;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_DECORD:				;;
 	MOV #0x00ED,W0			;;	
	SUB PS2_CMD,WREG		;;
	BRA GEU,$+4			;;
	RETURN				;;
	CP W0,#18			;;
	BRA LEU,$+4			;;
	RETURN				;;
	CLR PS2_CMD			;;
	BRA W0				;;
	BRA PS2_EDH			;;0
	BRA PS2_EEH			;;1
	BRA PS2_EFH			;;2
	BRA PS2_F0H			;;3
	BRA PS2_F1H			;;4
	BRA PS2_F2H			;;5
	BRA PS2_F3H			;;6
	BRA PS2_F4H			;;7
	BRA PS2_F5H			;;8
	BRA PS2_F6H			;;9
	BRA PS2_F7H			;;10
	BRA PS2_F8H			;;11
	BRA PS2_F9H			;;12
	BRA PS2_FAH			;;13
	BRA PS2_FBH			;;14
	BRA PS2_FCH			;;15
	BRA PS2_FDH			;;16
	BRA PS2_FEH			;;17
	BRA PS2_FFH			;;18
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_EDH:				;;
;	BSET LEDFG0,#0 			;;
;	BTSS PS2_RXDATA,#0		;;
;	BCLR LEDFG0,#0 			;;
;	BSET LEDFG0,#1 			;;
;	BTSS PS2_RXDATA,#1		;;
;	BCLR LEDFG0,#1 			;;
;	BSET LEDFG0,#2 			;;
;	BTSS PS2_RXDATA,#2		;;
;	BCLR LEDFG0,#2 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGA,#LED_SCROLL_F 	;;
	BTSS PS2_RXDATA,#0		;;
	BCLR FLAGA,#LED_SCROLL_F 	;;
	BSET FLAGA,#LED_NUM_F 		;;
	BTSS PS2_RXDATA,#1		;;
	BCLR FLAGA,#LED_NUM_F 		;;
	BSET FLAGA,#LED_CAPS_F 		;;
	BTSS PS2_RXDATA,#2		;;
	BCLR FLAGA,#LED_CAPS_F 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET _kbled,#0			;;
	BTSS PS2_RXDATA,#0		;;
	BCLR _kbled,#0			;;
	BSET _kbled,#1			;;
	BTSS PS2_RXDATA,#1		;;
	BCLR _kbled,#1			;;
	BSET _kbled,#2			;;
	BTSS PS2_RXDATA,#2		;;
	BCLR _kbled,#2			;;
	BSET _kbled,#3			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_EEH:				;;
PS2_EFH:				;;
PS2_F1H:				;;
PS2_FBH:				;;
PS2_FCH:				;;
PS2_FDH:				;;
PS2_FEH:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_F0H:				;;
	CP0 PS2_RXDATA			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV #0xFA,W0			;;	
	MOV W0,PS2_TXDATA0		;;
	MOV #0x02,W0			;;	
	MOV W0,PS2_TXDATA1		;;
	MOV #2,W0			;;
	MOV W0,PS2_TXLIM		;;
	CLR PS2_TXBYTE			;;
	BSET FLAGB,#PS2_TX_F		;;	 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_F2H:				;;
;	MOV #0xFA,W0			;;	
;	MOV W0,PS2_TXDATA2		;;
;	MOV #0xAB,W0			;;	
;	MOV W0,PS2_TXDATA1		;;
;	MOV #0x83,W0			;;	
;	MOV W0,PS2_TXDATA0		;;
;	MOV #2,W0			;;
;	MOV W0,PS2_TXLIM		;;
;	CLR PS2_TXBYTE			;;
;	BSET FLAGB,#PS2_TX_F		;;	 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_F3H:				;;
	MOV PS2_RXDATA,W0		;;
	MOV W0,TYPEMATIC		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_F4H:				;;
	BCLR FLAGA,#KEYB_SCAN_DF	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_F5H:				;;
	BSET FLAGA,#KEYB_SCAN_DF	;;
PS2_F6H:				;;
	BCLR FLAGA,#KEYB_TYPE_DF	;;
	BCLR FLAGA,#KEYB_MAKE_DF	;;
	BCLR FLAGA,#KEYB_BREAK_DF	;;
	MOV #0x34,W0			;;
	MOV W0,TYPEMATIC		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_F7H:				;;
	BSET FLAGA,#KEYB_TYPE_DF	;;
	BCLR FLAGA,#KEYB_MAKE_DF	;;
	BCLR FLAGA,#KEYB_BREAK_DF	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_F8H:				;;
	BCLR FLAGA,#KEYB_TYPE_DF	;;
	BCLR FLAGA,#KEYB_MAKE_DF	;;
	BSET FLAGA,#KEYB_BREAK_DF	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_F9H:				;;
	BSET FLAGA,#KEYB_TYPE_DF	;;
	BCLR FLAGA,#KEYB_MAKE_DF	;;
	BSET FLAGA,#KEYB_BREAK_DF	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_FAH:				;;
	BCLR FLAGA,#KEYB_TYPE_DF	;;
	BCLR FLAGA,#KEYB_MAKE_DF	;;
	BCLR FLAGA,#KEYB_BREAK_DF	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS2_FFH:				;;
	BSET FLAGA,#KEYB_RESET_F	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





	

TESTBMP_ADR:
	.WORD 0x0000
	.WORD 0x0000
	.WORD 0x0040
	.WORD 0x0000
	.WORD 0x0080
	.WORD 0x0000
	.WORD 0x00C0
	.WORD 0x0000
	;;;;;;;;;;;;;;
	.WORD 0x0000
	.WORD 0x0001
	.WORD 0x0040
	.WORD 0x0001
	.WORD 0x0080
	.WORD 0x0001
	.WORD 0x00C0
	.WORD 0x0001
	;;;;;;;;;;;;;;
	.WORD 0x0000
	.WORD 0x0002
	.WORD 0x0040
	.WORD 0x0002
	.WORD 0x0080
	.WORD 0x0002
	.WORD 0x00C0
	.WORD 0x0002
	;;;;;;;;;;;;;;
	.WORD 0x0000
	.WORD 0x0003
	.WORD 0x0040
	.WORD 0x0003
	.WORD 0x0080
	.WORD 0x0003
	.WORD 0x00C0
	.WORD 0x0003
	;;;;;;;;;;;;;;
	.WORD 0x0000
	.WORD 0x0004
	.WORD 0x0040
	.WORD 0x0004
	.WORD 0x0080
	.WORD 0x0004
	.WORD 0x00C0
	.WORD 0x0004
	;;;;;;;;;;;;;;
	.WORD 0x0000
	.WORD 0x0005
	.WORD 0x0040
	.WORD 0x0005
	.WORD 0x0080
	.WORD 0x0005
	.WORD 0x00C0
	.WORD 0x0005
	;;;;;;;;;;;;;;
	.WORD 0x0000
	.WORD 0x0006
	.WORD 0x0040
	.WORD 0x0006
	.WORD 0x0080
	.WORD 0x0006
	.WORD 0x00C0
	.WORD 0x0006
	;;;;;;;;;;;;;;
	.WORD 0x0000
	.WORD 0x0007
	.WORD 0x0040
	.WORD 0x0007
	.WORD 0x0080
	.WORD 0x0007
	.WORD 0x00C0
	.WORD 0x0007
	;;;;;;;;;;;;;;
	.WORD 0x0000
	.WORD 0x0008
	.WORD 0x0040
	.WORD 0x0008
	.WORD 0x0080
	.WORD 0x0008
	.WORD 0x00C0
	.WORD 0x0008
	;;;;;;;;;;;;;;
PICTURE1_0:







	.end
