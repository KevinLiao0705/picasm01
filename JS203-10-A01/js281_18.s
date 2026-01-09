;******************************************************************************

;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 


	
 

        .equ __24ep64gp206, 1 ;
        .include "p24ep64gp206.inc"

;BY DEFINE=============================
;ONLY SELECT 1
;====================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'


	.EQU MYID_K		,0x0000
	.EQU FLASH24_ADDR	,0xA200

;..............................................................................
;Global Declarations:
;..............................................................................
    	.global __reset          
;    	.global __T1Interrupt    
  	.global __T4Interrupt    
;	.global __CNInterrupt	 
  	.global __U1RXInterrupt    
  	.global __U1TXInterrupt  
  	.global __U2TXInterrupt  
	.global __INT1Interrupt
	.global __INT2Interrupt
	.global __IC1Interrupt
	.global __IC2Interrupt
	.global __IC3Interrupt
	.global __SPI2Interrupt


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


.MACRO 	MOVFF XX,YY
	PUSH \XX
	POP \YY
.ENDM


.MACRO 	MOVLF XX,YY
        MOV #\XX,W0
	MOV W0,\YY
.ENDM

.MACRO 	MIW1 XX
        MOV #\XX,W0
	MOV W0,[W1++]
.ENDM

.MACRO 	MRW1 XX
        MOV \XX,W0
	MOV W0,[W1++]
.ENDM


.MACRO 	CHKSH XX
        MOV #\XX,W0
	CALL CHK_SHIFT
.ENDM


.MACRO 	WLCDC XX
	MOV #\XX,W0
	CALL ENCHR
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

.MACRO 	LOXY XX,YY
	MOV #\XX,W0
	MOV W0,LCDX
	MOV #\YY,W0
	MOV W0,LCDY
	CALL GOTOXY
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

FBUF0:			.SPACE 2		
FBUF1:			.SPACE 2		

DBUF0:			.SPACE 2		
DBUF1:			.SPACE 2		
DBUF2:			.SPACE 2		
DBUF3:			.SPACE 2		


TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2		
TMR2H_BUF:		.SPACE 2
FLAGA:	        	.SPACE 2
FLAGB:	        	.SPACE 2
FLAGC:	        	.SPACE 2
FLAGD:	        	.SPACE 2


SETIP_T:	       	.SPACE 2


YESKEY_CNT:	       	.SPACE 2
NOKEY_CNT:	       	.SPACE 2
KEYCON_CNT:	       	.SPACE 2
KEYBUF:	        	.SPACE 2
KEYFP:	        	.SPACE 2
KEYFR:	        	.SPACE 2
KEYFC:	        	.SPACE 2


VR1BUF:	        	.SPACE 2
VR1V:	        	.SPACE 2



U1RX_BYTE_PTR:		.SPACE 2
U1RXA_LEN:		.SPACE 2
U1RXB_LEN:		.SPACE 2
U1RX_LEN:		.SPACE 2
U1TX_BTX:		.SPACE 2
U1TX_BCNT:		.SPACE 2
U1RXGRP:		.SPACE 2
U1RXCMD:		.SPACE 2
U1TX_LEN:		.SPACE 2
U1TX_CHKSUM0:		.SPACE 2
U1TX_CHKSUM1:		.SPACE 2

U1RXID0:		.SPACE 2
U1RXID1:		.SPACE 2
U1RX_GPCMD:		.SPACE 2
U1RX_ITCMD:		.SPACE 2
U1RX_PARA0:		.SPACE 2
U1RX_PARA1:		.SPACE 2
U1RX_PARA2:		.SPACE 2
U1RX_PARA3:		.SPACE 2

U1TX_PARA0:		.SPACE 2
U1TX_PARA1:		.SPACE 2
U1TX_PARA2:		.SPACE 2
U1TX_PARA3:		.SPACE 2



U2TX_BTX:		.SPACE 2
U2TX_BCNT:		.SPACE 2
U2TX_LEN:		.SPACE 2
U2TX_CHKSUM0:		.SPACE 2
U2TX_CHKSUM1:		.SPACE 2




T4ITMR:			.SPACE 2
CONVAD_CNT:		.SPACE 2
PGRET_CNT:		.SPACE 2
PGRET_TIM:		.SPACE 2
SHIFT_CNT:		.SPACE 2
DIS_FLASH_TIM:		.SPACE 2
FLASH_LCD_TIM:		.SPACE 2
NSYSTIME_CNT:		.SPACE 2
GPSTIME_CNT:		.SPACE 2
SPISET_TIM:		.SPACE 2
FAIL_LED_TIM:		.SPACE 2
SPINORX_TIM:		.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
SYSTIME_CNT:		.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
LCDX:			.SPACE 2
LCDY:			.SPACE 2
LCDPG_CNT:			.SPACE 2
SCLCD_CNT:			.SPACE 2
LCDCUR_CNT:			.SPACE 2
LCDBUF:			.SPACE 160	

PARA_BUF:		.SPACE 0		
GPS_STATUS_CNT:		.SPACE 2
DATES_BUF:		.SPACE 32
NTP_OFFS:		.SPACE 2
NTP_JITTER:			.SPACE 2
TIMES_BUF:		.SPACE 32
HWADDR_BUF:		.SPACE 16
LATDPD:			.SPACE 8	
LONDPD:			.SPACE 8	
ALTDPD:			.SPACE 8	

LATBUF:			.SPACE 6
LONBUF:			.SPACE 6
ALTBUF:			.SPACE 6
GPSX_BUF:		.SPACE 4
GPSY_BUF:		.SPACE 4
GPSZ_BUF:		.SPACE 4
SATE_INVIEW:		.SPACE 2
SATE_INVIEW_BUF:	.SPACE 2
SATE_GOOD:		.SPACE 2
SATE_SEL_CNT:		.SPACE 2
SATE_SEL_AMT:		.SPACE 2
SATE_SELBUF:		.SPACE 8
GPS_PDOP:		.SPACE 8
GPS_HDOP:		.SPACE 8
GPS_VDOP:		.SPACE 8
NTPGPS_NO:		.SPACE 2
NTPGPS_EL:		.SPACE 2
NTPGPS_AZ:		.SPACE 2
NTPGPS_DIST:		.SPACE 2
NTPGPS_DOPP1:		.SPACE 2
NTPGPS_DOPP0:		.SPACE 2
TCPIP_BUF:		.SPACE 8
NETMASK_BUF:		.SPACE 8
GATEWAY_BUF:		.SPACE 8
NAMESERVER_BUF:		.SPACE 8
SYSLOG_BUF:		.SPACE 8
LOCLAT_BUF:		.SPACE 6
LOCLON_BUF:		.SPACE 6
DATE_BUF:		.SPACE 6
TIME_BUF:		.SPACE 6
GPSURX_CNT:		.SPACE 2
GPSURX_B0:		.SPACE 2
UTC0:			.SPACE 2
UTC1:			.SPACE 2
UTC2:			.SPACE 2
UTC3:			.SPACE 2
UTC4:			.SPACE 2
UTC5:			.SPACE 2
TOTS0:			.SPACE 2
TOTS1:			.SPACE 2
TOTS2:			.SPACE 2
GPSDATE_BUF:		.SPACE 8
GPSTIME_BUF:		.SPACE 8



SPI2RX_BYTE_PTR:	.SPACE 2
SPI2RXA_LEN:		.SPACE 2
SPI2RXB_LEN:		.SPACE 2
SPITX_BTX:		.SPACE 2
SPITX_MOD:		.SPACE 2
SPITX_BCNT:		.SPACE 2
SPITX_LEN:		.SPACE 2
SPITX_CHKSUM0:		.SPACE 2
SPITX_CHKSUM1:		.SPACE 2
GPSURX_LENA:		.SPACE 2
GPSURX_LENB:		.SPACE 2
GPSURX_LEN:		.SPACE 2
GPSURX_ADDR:		.SPACE 2
GPS6F_TIM:		.SPACE 2
SPIRX_LEN:		.SPACE 2
SPITX_PARA0:		.SPACE 2
SPITX_PARA1:		.SPACE 2
SPITX_PARA2:		.SPACE 2
SPITX_PARA3:		.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
URX00:			.SPACE 2
URX01:			.SPACE 2
URX02:			.SPACE 2
URX03:			.SPACE 2
URX04:			.SPACE 2
URX05:			.SPACE 2
URX06:			.SPACE 2
URX07:			.SPACE 2
URX08:			.SPACE 2
URX09:			.SPACE 2
URX10:			.SPACE 2
URX11:			.SPACE 2
URX12:			.SPACE 2
URX13:			.SPACE 2
URX14:			.SPACE 2
URX15:			.SPACE 2
URX16:			.SPACE 2
URX17:			.SPACE 2
URX18:			.SPACE 2
URX19:			.SPACE 2
URX20:			.SPACE 2
URX21:			.SPACE 2
URX22:			.SPACE 2
URX23:			.SPACE 2
URX24:			.SPACE 2
URX25:			.SPACE 2
URX26:			.SPACE 2
URX27:			.SPACE 2
URX28:			.SPACE 2
URX29:			.SPACE 2
URX30:			.SPACE 2
URX31:			.SPACE 2
URX32:			.SPACE 2
URX33:			.SPACE 2
URX34:			.SPACE 2
URX35:			.SPACE 2
URX36:			.SPACE 2
URX37:			.SPACE 2
URX38:			.SPACE 2
URX39:			.SPACE 2
URX40:			.SPACE 2
URX41:			.SPACE 2
URX42:			.SPACE 2
URX43:			.SPACE 2
URX44:			.SPACE 2
URX45:			.SPACE 2
URX46:			.SPACE 2
URX47:			.SPACE 2
URX48:			.SPACE 2
URX49:			.SPACE 2
URX50:			.SPACE 2
URX51:			.SPACE 2
URX52:			.SPACE 2
URX53:			.SPACE 2
URX54:			.SPACE 2
URX55:			.SPACE 2
URX56:			.SPACE 2
URX57:			.SPACE 2
URX58:			.SPACE 2
URX59:			.SPACE 2
URX60:			.SPACE 2
URX61:			.SPACE 2
URX62:			.SPACE 2
URX63:			.SPACE 2
URX64:			.SPACE 2
URX65:			.SPACE 2
URX66:			.SPACE 2
URX67:			.SPACE 2
URX68:			.SPACE 2
URX69:			.SPACE 2
URX70:			.SPACE 2
URX71:			.SPACE 2
URX72:			.SPACE 2
URX73:			.SPACE 2
URX74:			.SPACE 2
URX75:			.SPACE 2
URX76:			.SPACE 2
URX77:			.SPACE 2
URX78:			.SPACE 2
URX79:			.SPACE 2



;######################################
SET_BUF:		.SPACE 0 ;256
ROON_SEC:		.SPACE 2
;UNIID_SET:		.SPACE 2
;EXIST_SET:		.SPACE 2
;SIPNO_SET:		.SPACE 2
;VOLUME_SET:		.SPACE 2
;KLIGHT_SET:		.SPACE 2

;LANG_SET:		.SPACE 2
;TITLE_SET:		.SPACE 2
;TABLE_SET:		.SPACE 2
;XCHW_SET:		.SPACE 2
;KEYLOCK_SET:		.SPACE 2
;CF_SET:			.SPACE 2
;VIB_SENSI_SET:		.SPACE 2
;POWER_SAVE_SET:		.SPACE 2
;TPMS_PUNIT_SET:		.SPACE 2
;TPMS_TUNIT_SET:		.SPACE 2
;W5_EN_SET:		.SPACE 2
;WXI_SET:		.SPACE 2
;MIRBKL_SET:		.SPACE 2
;TPMS_LOP_SETA:		.SPACE 2
;TPMS_HIP_SETA:		.SPACE 2
;TPMS_HIT_SETA:		.SPACE 2
;TPMS_LOP_SETB:		.SPACE 2
;TPMS_HIP_SETB:		.SPACE 2
;TPMS_HIT_SETB:		.SPACE 2
;RXFREQ_L:		.SPACE 2;
;RXFREQ_H:		.SPACE 2;
;WID00:			.SPACE 2
;WID01:			.SPACE 2
;WID02:			.SPACE 2
;WID10:			.SPACE 2
;WID11:			.SPACE 2
;WID12:			.SPACE 2
;WID20:			.SPACE 2
;WID21:			.SPACE 2
;WID22:			.SPACE 2
;WID30:			.SPACE 2
;WID31:			.SPACE 2
;WID32:			.SPACE 2
;WID40:			.SPACE 2
;WID41:			.SPACE 2
;WID42:			.SPACE 2
;WID_CHKSUM0:		.SPACE 2
;WID_CHKSUM1:		.SPACE 2


;NONE2:			.SPACE 2
;NONE3:			.SPACE 2
NONE4:			.SPACE 2
NONE5:			.SPACE 2

;=================================
SET_END:		.SPACE 0
SET_SPARE:		.SPACE (128+SET_BUF-SET_END)
;=================================

END_RAM:		.SPACE 0


.EQU U1TX_BUF		,0x2000
.EQU U2TX_BUF		,0x2100
.EQU GPSURX_BUFA	,0x2200
.EQU GPSURX_BUFB	,0x2400
.EQU U1RX_BUFA		,0x2200
.EQU U1RX_BUFB		,0x2400
.EQU U1RX_TEMP		,0x2600
.EQU SPI2RX_BUFA	,0x2800
.EQU SPI2RX_BUFB	,0x2A00
.EQU SPITX_BUF		,0x2C00
.EQU SPIRX_TEMP		,0x2D00

;END=4FFF

;=======================PIN1 
.EQU COM_EN_O		,LATA
.EQU COM_EN_IO		,TRISA
.EQU COM_EN_O_P		,7
.EQU COM_EN_IO_P	,7
;=======================PIN2 
.EQU COM_DET_I		,PORTB
.EQU COM_DET_IO		,TRISB
.EQU COM_DET_I_P	,14
.EQU COM_DET_IO_P	,14
;=======================PIN3 
.EQU NC00_I		,PORTB
.EQU NC00_IO		,TRISB
.EQU NC00_I_P		,15
.EQU NC00_IO_P		,15
;=======================PIN4 
.EQU PI_URX_O		,LATG
.EQU PI_URX_IO		,TRISG
.EQU PI_URX_O_P		,6
.EQU PI_URX_IO_P	,6




.EQU GPIO1_I		,PORTG
.EQU GPIO1_IO		,TRISG
.EQU GPIO1_I_P		,6
.EQU GPIO1_IO_P		,6
;=======================PIN5 
.EQU TEST_O		,LATG
.EQU TEST_IO		,TRISG
.EQU TEST_O_P		,7
.EQU TEST_IO_P		,7



.EQU NC01_I		,PORTG
.EQU NC01_IO		,TRISG
.EQU NC01_I_P		,7
.EQU NC01_IO_P		,7
;=======================PIN6 
.EQU GPIO2_I		,PORTG
.EQU GPIO2_IO		,TRISG
.EQU GPIO2_I_P		,8
.EQU GPIO2_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU NC02_I		,PORTG
.EQU NC02_IO		,TRISG
.EQU NC02_I_P		,9
.EQU NC02_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU NC03_I		,PORTA
.EQU NC03_IO		,TRISA
.EQU NC03_I_P		,12
.EQU NC03_IO_P		,12
;=======================PIN12 
.EQU NC04_I		,PORTA
.EQU NC04_IO		,TRISA
.EQU NC04_I_P		,11
.EQU NC04_IO_P		,11
;=======================PIN13 
.EQU NC05_I		,PORTA
.EQU NC05_IO		,TRISA
.EQU NC05_I_P		,0
.EQU NC05_IO_P		,0
;=======================PIN14 
.EQU NC06_I		,PORTA
.EQU NC06_IO		,TRISA
.EQU NC06_I_P		,1
.EQU NC06_IO_P		,1
;=======================PIN15 
.EQU NC07_I		,PORTB
.EQU NC07_IO		,TRISB
.EQU NC07_I_P		,0
.EQU NC07_IO_P		,0
;=======================PIN16 
.EQU NC08_I		,PORTB
.EQU NC08_IO		,TRISB
.EQU NC08_I_P		,1
.EQU NC08_IO_P		,1

;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU LCD_D0_I		,PORTC
.EQU LCD_D0_O		,LATC
.EQU LCD_D0_IO		,TRISC
.EQU LCD_D0_I_P		,0
.EQU LCD_D0_O_P		,0
.EQU LCD_D0_IO_P	,0
;=======================PIN22 
.EQU LCD_D1_I		,PORTC
.EQU LCD_D1_O		,LATC
.EQU LCD_D1_IO		,TRISC
.EQU LCD_D1_I_P		,1
.EQU LCD_D1_O_P		,1
.EQU LCD_D1_IO_P	,1
;=======================PIN23 
.EQU LCD_D2_I		,PORTC
.EQU LCD_D2_O		,LATC
.EQU LCD_D2_IO		,TRISC
.EQU LCD_D2_I_P		,2
.EQU LCD_D2_O_P		,2
.EQU LCD_D2_IO_P	,2
;=======================PIN24 
.EQU NC09_I		,PORTC
.EQU NC09_IO		,TRISC
.EQU NC09_I_P		,11
.EQU NC09_IO_P		,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
.EQU NC10_I		,PORTE
.EQU NC10_IO		,TRISE
.EQU NC10_I_P		,12
.EQU NC10_IO_P		,12
;=======================PIN28 
.EQU NC11_I		,PORTE
.EQU NC11_IO		,TRISE
.EQU NC11_I_P		,13
.EQU NC11_IO_P		,13
;=======================PIN29 
.EQU GPIO3_I		,PORTE
.EQU GPIO3_IO		,TRISE
.EQU GPIO3_I_P		,14
.EQU GPIO3_IO_P		,14
;=======================PIN30 
.EQU GPIO4_I		,PORTE
.EQU GPIO4_IO		,TRISE
.EQU GPIO4_I_P		,15
.EQU GPIO4_IO_P		,15
;=======================PIN31 
.EQU GPS_UTX_I		,PORTA
.EQU GPS_UTX_IO		,TRISA
.EQU GPS_UTX_I_P	,8
.EQU GPS_UTX_IO_P	,8
;=======================PIN32 
.EQU GPS_URX_O		,LATB
.EQU GPS_URX_IO		,TRISB
.EQU GPS_URX_O_P	,4
.EQU GPS_URX_IO_P	,4
;=======================PIN33 
.EQU LCD_LED_O		,LATA
.EQU LCD_LED_IO		,TRISA
.EQU LCD_LED_O_P	,4
.EQU LCD_LED_IO_P	,4
;=======================PIN34 
.EQU NC12_I		,PORTA
.EQU NC12_IO		,TRISA
.EQU NC12_I_P		,9
.EQU NC12_IO_P		,9
;=======================PIN35
.EQU LCD_D3_I		,PORTC
.EQU LCD_D3_O		,LATC
.EQU LCD_D3_IO		,TRISC
.EQU LCD_D3_I_P		,3
.EQU LCD_D3_O_P		,3
.EQU LCD_D3_IO_P	,3
;=======================PIN36
.EQU LCD_D4_I		,PORTC
.EQU LCD_D4_O		,LATC
.EQU LCD_D4_IO		,TRISC
.EQU LCD_D4_I_P		,4
.EQU LCD_D4_O_P		,4
.EQU LCD_D4_IO_P	,4
;=======================PIN37 
.EQU LCD_D5_I		,PORTC
.EQU LCD_D5_O		,LATC
.EQU LCD_D5_IO		,TRISC
.EQU LCD_D5_I_P		,5
.EQU LCD_D5_O_P		,5
.EQU LCD_D5_IO_P	,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
;=======================PIN40 	OSC2
;=======================PIN41 	VSS
;=======================PIN42 
.EQU NC13_I		,PORTD
.EQU NC13_IO		,TRISD
.EQU NC13_I_P		,8
.EQU NC13_IO_P		,8
;=======================PIN43
.EQU PI_SDO_I		,PORTB
.EQU PI_SDO_IO		,TRISB
.EQU PI_SDO_I_P		,5
.EQU PI_SDO_IO_P	,5
;=======================PIN44 
.EQU PI_SDI_O		,LATB
.EQU PI_SDI_IO		,TRISB
.EQU PI_SDI_O_P		,6
.EQU PI_SDI_IO_P	,6
;=======================PIN45
.EQU NC14_I		,PORTC
.EQU NC14_IO		,TRISC
.EQU NC14_I_P		,10
.EQU NC14_IO_P		,10
;=======================PIN46
.EQU PI_SCK_I		,PORTB
.EQU PI_SCK_IO		,TRISB
.EQU PI_SCK_I_P		,7
.EQU PI_SCK_IO_P	,7
;=======================PIN47 
.EQU NC15_I		,PORTC
.EQU NC15_IO		,TRISC
.EQU NC15_I_P		,13
.EQU NC15_IO_P		,13
;=======================PIN48
.EQU PI_CE0_I		,PORTB
.EQU PI_CE0_IO		,TRISB
.EQU PI_CE0_I_P		,8
.EQU PI_CE0_IO_P	,8
;=======================PIN49
.EQU LCD_RS_O		,LATB		
.EQU LCD_RS_IO		,TRISB
.EQU LCD_RS_O_P		,9
.EQU LCD_RS_IO_P	,9
;=======================PIN50 
.EQU LCD_D6_I		,PORTC
.EQU LCD_D6_O		,LATC
.EQU LCD_D6_IO		,TRISC
.EQU LCD_D6_I_P		,6
.EQU LCD_D6_O_P		,6
.EQU LCD_D6_IO_P	,6
;=======================PIN51 
.EQU LCD_D7_I		,PORTC
.EQU LCD_D7_O		,LATC
.EQU LCD_D7_IO		,TRISC
.EQU LCD_D7_I_P		,7
.EQU LCD_D7_O_P		,7
.EQU LCD_D7_IO_P	,7
;=======================PIN52
.EQU LCD_RW_O		,LATC
.EQU LCD_RW_IO		,TRISC
.EQU LCD_RW_O_P		,8
.EQU LCD_RW_IO_P	,8
;=======================PIN53
.EQU NC16_I		,PORTD
.EQU NC16_IO		,TRISD
.EQU NC16_I_P		,5
.EQU NC16_IO_P		,5
;=======================PIN54
.EQU NC17_I		,PORTD
.EQU NC17_IO		,TRISD
.EQU NC17_I_P		,6
.EQU NC17_IO_P		,6
;=======================PIN55
.EQU LCD_EN_O		,LATC
.EQU LCD_EN_IO		,TRISC
.EQU LCD_EN_O_P		,9
.EQU LCD_EN_IO_P	,9
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
.EQU KEY1_I		,PORTF
.EQU KEY1_IO		,TRISF
.EQU KEY1_I_P		,0
.EQU KEY1_IO_P	,0
;=======================PIN59
.EQU KEY2_I		,PORTF
.EQU KEY2_IO		,TRISF
.EQU KEY2_I_P		,1
.EQU KEY2_IO_P	,1
;=======================PIN60
.EQU KEY3_I		,PORTB 
.EQU KEY3_IO		,TRISB
.EQU KEY3_I_P		,10
.EQU KEY3_IO_P	,10
;=======================PIN61
.EQU KEY4_I		,PORTB 
.EQU KEY4_IO		,TRISB
.EQU KEY4_I_P		,11
.EQU KEY4_IO_P	,11
;=======================PIN62
.EQU KEY5_I		,PORTB 
.EQU KEY5_IO		,TRISB
.EQU KEY5_I_P		,12
.EQU KEY5_IO_P	,12
;=======================PIN63
.EQU LED1_O		,LATB 
.EQU LED1_IO		,TRISB
.EQU LED1_O_P		,13
.EQU LED1_IO_P		,13
;=======================PIN64
.EQU LED2_O		,LATA 
.EQU LED2_IO		,TRISA
.EQU LED2_O_P		,10
.EQU LED2_IO_P	,10




;TMR2_FLAG
.EQU    T5U_F_P      	,0	;20NS*256;5.12US
.EQU    T10U_F_P      	,1
.EQU    T20U_F_P      	,2
.EQU	T40U_F_P	,3
.EQU	T80U_F_P	,4
.EQU	T160U_F_P	,5
.EQU	T320U_F_P	,6
.EQU	T640U_F_P	,7
.EQU	T1P3M_F_P	,8
.EQU	T2P6M_F_P	,9
.EQU	T5P2M_F_P 	,10
.EQU	T10M_F_P	,11
.EQU	T20M_F_P	,12
.EQU	T40M_F_P	,13
.EQU	T80M_F_P	,14
.EQU	T160M_F_P	,15
.EQU    T5U_F      	,TMR2_FLAG
.EQU    T10U_F      	,TMR2_FLAG
.EQU    T20U_F      	,TMR2_FLAG
.EQU	T40U_F		,TMR2_FLAG
.EQU	T80U_F		,TMR2_FLAG
.EQU	T160U_F		,TMR2_FLAG
.EQU	T320U_F		,TMR2_FLAG
.EQU	T640U_F		,TMR2_FLAG
.EQU	T1P3M_F		,TMR2_FLAG
.EQU	T2P6M_F		,TMR2_FLAG
.EQU	T5P2M_F 	,TMR2_FLAG
.EQU	T10M_F		,TMR2_FLAG
.EQU	T20M_F		,TMR2_FLAG
.EQU	T40M_F		,TMR2_FLAG
.EQU	T80M_F		,TMR2_FLAG
.EQU	T160M_F		,TMR2_FLAG







.EQU LIGHT_KF		,KEYFP
.EQU LIGHT_KF_P		,0
.EQU MENU_KF		,KEYFP
.EQU MENU_KF_P		,1
.EQU ACK_KF		,KEYFP
.EQU ACK_KF_P		,2
.EQU NEXT_KF		,KEYFP
.EQU NEXT_KF_P		,3
.EQU INC_KF		,KEYFP
.EQU INC_KF_P		,4

.EQU LIGHT_KCF		,KEYFC
.EQU LIGHT_KCF_P	,0
.EQU MENU_KCF		,KEYFC
.EQU MENU_KCF_P		,1
.EQU ACK_KCF		,KEYFC
.EQU ACK_KCF_P		,2
.EQU NEXT_KCF		,KEYFC
.EQU NEXT_KCF_P		,3
.EQU INC_KCF		,KEYFC
.EQU INC_KCF_P		,4





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
.EQU LCD_LINE_F		,FLAGA
.EQU LCD_LINE_F_P	,6
.EQU DISKP_F		,FLAGA
.EQU DISKP_F_P		,7
.EQU DISKR_F		,FLAGA
.EQU DISKR_F_P		,8
.EQU DISKC_F		,FLAGA
.EQU DISKC_F_P		,9
.EQU PGRET_F		,FLAGA
.EQU PGRET_F_P		,10
.EQU DISP_PG_F		,FLAGA
.EQU DISP_PG_F_P  	,11
.EQU KEY_PUSH_F		,FLAGA
.EQU KEY_PUSH_F_P  	,12
.EQU DIS_FLASH_F	,FLAGA
.EQU DIS_FLASH_F_P 	,13
.EQU FLASH_LCD_F	,FLAGA
.EQU FLASH_LCD_F_P  	,14
;.EQU FRAM_ROW_SAME_F	,FLAGA
;.EQU FRAM_ROW_SAME_F_P  ,15



;FLAGB
.EQU GPSURX_START_F	,FLAGB
.EQU GPSURX_START_F_P	,0
.EQU DLE_F		,FLAGB
.EQU DLE_F_P		,1
.EQU URXAB_F		,FLAGB
.EQU URXAB_F_P		,2
.EQU URXA_RECED_F	,FLAGB
.EQU URXA_RECED_F_P	,3
.EQU URXB_RECED_F	,FLAGB
.EQU URXB_RECED_F_P	,4
.EQU SHLR_F		,FLAGB
.EQU SHLR_F_P		,5
.EQU MINUS_F		,FLAGB
.EQU MINUS_F_P		,6
.EQU SPICSH_F		,FLAGB
.EQU SPICSH_F_P		,7
.EQU SPI2RXT_F		,FLAGB
.EQU SPI2RXT_F_P	,8
.EQU SPI2RX_BUFAB_F	,FLAGB
.EQU SPI2RX_BUFAB_F_P	,9
.EQU SPI2RX_PACKA_F	,FLAGB
.EQU SPI2RX_PACKA_F_P	,10
.EQU SPI2RX_PACKB_F	,FLAGB
.EQU SPI2RX_PACKB_F_P  	,11
.EQU SPITX_EN_F		,FLAGB
.EQU SPITX_EN_F_P  	,12
.EQU GPS6F_EN_F		,FLAGB
.EQU GPS6F_EN_F_P 	,13
.EQU SPITX_STANDBY_F	,FLAGB
.EQU SPITX_STANDBY_F_P  ,14
.EQU EDIT_NETADDR_F	,FLAGB
.EQU EDIT_NETADDR_F_P  	,15





;FLAGC
.EQU EDIT_SYSTIME_F	,FLAGC
.EQU EDIT_SYSTIME_F_P	,0
.EQU U2TX_EN_F		,FLAGC
.EQU U2TX_EN_F_P	,1
.EQU SYSTIME_LOAD_F	,FLAGC
.EQU SYSTIME_LOAD_F_P	,2
;.EQU LEDPRG_ON_F	,FLAGC
;.EQU LEDPRG_ON_F_P	,3
;.EQU KLED_FLASH_F	,FLAGC
;.EQU KLED_FLASH_F_P	,4
;.EQU HAND_ON_F		,FLAGC
;.EQU HAND_ON_F_P	,5
;.EQU SIPINF_CHG_F	,FLAGC
;.EQU SIPINF_CHG_F_P	,6
;.EQU ADDDEC_F		,FLAGC
;.EQU ADDDEC_F_P	,7
;.EQU SPEED_SET_F	,FLAGC
;.EQU SPEED_SET_F_P	,8
;.EQU SET_START_F	,FLAGC
;.EQU SET_START_F_P	,9
;.EQU DISP_CONERR_F	,FLAGC
;.EQU DISP_CONERR_F_P	,10
;.EQU ANY_KEY_F		,FLAGC
;.EQU ANY_KEY_F_P  	,11
;.EQU GETSET_F		,FLAGC
;.EQU GETSET_F_P  	,12
;.EQU CHK_LEDF_F	,FLAGC
;.EQU CHK_LEDF_F_P 	,13
;.EQU TRANSTO_F		,FLAGC
;.EQU TRANSTO_F_P  	,14
;.EQU FRAM_ROW_SAME_F	,FLAGC
;.EQU FRAM_ROW_SAME_F_P  ,15





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
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL CLR_WREG 		;;
	CALL INIT_IO		;;
	CALL INIT_AD		;;
	CALL INIT_RAM		;;
	CALL INIT_SIO		;;
	CALL INIT_OSC		;;
	MOV #10000,W0		;;
	CALL DLYX		;;
	MOV #0xA030,W0		;;	;;/256
	MOV W0,T2CON		;;	;;BASE TIME
	MOV #200,W0		;;	
	CALL DLYMX		;;
	MOV #10000,W0		;;
	CALL DLYX		;;
	BSF LED1_O		;;
	BSF LED2_O		;;
	MOV #18,W0		;;	
	MOV W0,ROON_SEC		;;
	CALL LOAD_FLASH24
	;MOV #19,W0		;;	
	;MOV W0,ROON_SEC	;;
	;CALL SAVE_FLASH24



	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_TIMER		;;
	CALL INIT_UART1		;;
	CALL INIT_UART2		;;
	CALL INIT_SPIS		;;
;	CALL TEST_UART1
;	CALL TEST_UART2
;	CALL TEST_SPISI
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DATE_TEST_STR:
	.ASCII "Tue 01.28.2019\0"	;;	
TIME_TEST_STR:
	.ASCII "UTC+8 17:28:35\0"	;;	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:				;;
	CLR FLAGA			;;	
	CLR FLAGB			;;
	CLR FLAGC			;;
	CLR FLAGD			;;
	CLR SHIFT_CNT			;;
	MOVLF #10,SPITX_BTX		;;
	CLR SPITX_BCNT			;;
	SETM SYSTIME_CNT		;;
	SETM GPSTIME_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR LCDPG_CNT			;;
	CLR LCDCUR_CNT			;;
	CLR GPS_STATUS_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #DATES_BUF,W2		;;
	LOFFS1 DATE_TEST_STR		;;
	CALL STR2RAM			;;
	MOVLF 0x8000,NTP_OFFS		;;
	MOVLF 10,NTP_JITTER		;;
	MOV #TIMES_BUF,W2		;;
	LOFFS1 TIME_TEST_STR		;;
	CALL STR2RAM			;;
	MOV #LATBUF,W1			;;
	MIW1 25				;;
	MIW1 02				;;
	MIW1 42				;;
	MOV #LONBUF,W1			;;
	MIW1 121			;;
	MIW1 28				;;
	MIW1 4				;;
	MOV #GPSX_BUF,W1		;;
	MIW1 0xF307			;;
	MIW1 0x8302			;;
	MOV #GPSY_BUF,W1		;;
	MIW1 0x0493			;;
	MIW1 0x1611			;;
	MOV #GPSZ_BUF,W1		;;
	MIW1 0x0268			;;
	MIW1 0x3641			;;
	MOVLF 10,SATE_INVIEW		;;
	MOVLF 8,SATE_GOOD		;;
	MOV #SATE_SELBUF,W1		;;
	MIW1 26				;;
	MIW1 29				;;
	MIW1 05				;;
	MIW1 02				;;
	MOVLF 197,GPS_PDOP		;;
	MOVLF 109,GPS_HDOP		;;
	MOVLF 225,GPS_VDOP		;;
	MOVLF 12,NTPGPS_NO		;;
	MOVLF 576,NTPGPS_EL		;;
	MOVLF 1156,NTPGPS_AZ		;;
	MOVLF 28194,NTPGPS_DIST		;;
	MOVLF -1331,NTPGPS_DOPP1	;;
	MOVLF 111,NTPGPS_DOPP0		;;
	MOV #NETMASK_BUF,W1		;;
	MIW1 255			;;
	MIW1 255			;;
	MIW1 255			;;
	MIW1 0				;;
	MOV #GATEWAY_BUF,W1		;;
	MIW1 192			;;
	MIW1 168			;;
	MIW1 3				;;
	MIW1 40				;;
	MOV #TCPIP_BUF,W1		;;
	MIW1 192			;;
	MIW1 168			;;
	MIW1 3				;;
	MIW1 40				;;
	MOV #NAMESERVER_BUF,W1		;;
	MIW1 0				;;
	MIW1 0 				;;
	MIW1 0				;;
	MIW1 0				;;
	MOV #SYSLOG_BUF,W1		;;
	MIW1 0				;;
	MIW1 0 				;;
	MIW1 0				;;
	MIW1 0				;;
	MOV #LOCLAT_BUF,W1		;;
	MIW1 25				;;
	MIW1 02				;;
	MIW1 42				;;
	MOV #LOCLON_BUF,W1		;;
	MIW1 121			;;
	MIW1 28				;;
	MIW1 4				;;
	MOV #DATE_BUF,W1		;;
	MIW1 1				;;
	MIW1 28				;;
	MIW1 2019				;;
	MOV #TIME_BUF,W1		;;
	MIW1 11				;;
	MIW1 36				;;
	MIW1 8				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TEST_OSC:
	MOV #100,W0
	CALL DLYX
	TG TEST_O
	TG TEST_O
	TG TEST_O
	TG TEST_O
	TG TEST_O
	TG TEST_O
	TG TEST_O
	CLRWDT
	BRA TEST_OSC	

TEST_TIMER:
	CLRWDT
	BTSS TMR2,#8
	BCF TEST_O
	BTSC TMR2,#8
	BSF TEST_O
	BRA TEST_TIMER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART1:				;;
	MOV #0x00AA,W0			;;
	MOV W0,U1TXREG			;;
	;CALL U1TX_RSP			;;
	MOV #100,W0			;;
	CALL DLYMX			;;
	BRA TEST_UART1 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART2:				;;
	MOV #0x00AA,W0			;;
	MOV W0,U2TXREG			;;
	;CALL U1TX_RSP			;;
	MOV #100,W0			;;
	CALL DLYMX			;;
	BRA TEST_UART2 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	

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
	NOP
	NOP
	RETURN
	SWAP W0				;;
	AND #255,W0			;;
	BRA Z,$+6			;;
	MOV #255,W0			;;
	MOV W0,VR1V			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	CLR ANSELC			;;
	CLR ANSELE			;;
	;RETURN				;;
	BSET ANSELE,#12			;;
;	BSET ANSELE,#14			;;
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


;OUTPUT W6:W5.W10	;W10 3B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLOAT2INT:				;;
	MOVFF FBUF0,W3			;;
	MOVFF FBUF1,W4			;;
	BSF MINUS_F			;;
	BTSS W4,#15			;;
	BCF MINUS_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR W4,#15			;;
	LSR W4,#7,W7			;;
	MOV #118,W0			;;
	SUB W7,W0,W7			;;
	BCF SHLR_F			;;	
	BTSS W7,#15			;;	
	BRA F2I_1			;;
	NEG W7,W7			;;	
	BSF SHLR_F			;;	
F2I_1:					;;
	BSET W4,#7			;;
	MOV #0x00FF,W0			;;
	AND W0,W4,W4			;;
	CLR W6				;;
	CLR W5
	BTFSC SHLR_F			;;	
	BRA F2I_1B			;;
F2I_1A:					;;
	CP0 W7				;;
	BRA Z,F2I_2			;;
	BCLR SR,#C			;;
	RLC W3,W3			;;
	RLC W4,W4			;;
	RLC W5,W5			;;
	RLC W6,W6			;;
	DEC W7,W7			;;
	BRA F2I_1A			;;	
F2I_1B:					;;
	CP0 W7				;;
	BRA Z,F2I_2			;;
	BCLR SR,#C			;;
	RRC W6,W6			;;
	RRC W5,W5			;;
	RRC W4,W4			;;
	RRC W3,W3			;;
	DEC W7,W7			;;
	BRA F2I_1B			;;	
F2I_2:					;;
	MOV #1000,W0			;;
	MUL.UU W0,W4,W8			;;
	MOV W9,W10
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;OUTPUT W6:W5.W10W9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DOUBLE2INT:				;;
	MOV DBUF0,W2			;;
	MOV DBUF1,W3			;;
	MOV DBUF2,W4			;;
	MOV DBUF3,W5			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF MINUS_F			;;
	BTSS W5,#15			;;
	BCF MINUS_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR W5,#15			;;
	LSR W5,#4,W7			;;
	MOV #1027,W0			;;
	SUB W7,W0,W7			;;
	BCF SHLR_F			;;	
	BTSS W7,#15			;;	
	BRA D2I_1			;;
	NEG W7,W7			;;	
	BSF SHLR_F			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
D2I_1:					;;
	BSET W5,#4			;;
	MOV #0x001F,W0			;;
	AND W0,W5,W5			;;
	CLR W6				;;
	BTFSC SHLR_F			;;	
	BRA D2I_1B			;;
D2I_1A:					;;
	CP0 W7				;;
	BRA Z,D2I_2			;;
	BCLR SR,#C			;;
	RLC W2,W2			;;
	RLC W3,W3			;;
	RLC W4,W4			;;
	RLC W5,W5			;;
	RLC W6,W6			;;
	DEC W7,W7			;;
	BRA D2I_1A			;;	
D2I_1B:					;;
	CP0 W7				;;
	BRA Z,D2I_2			;;
	BCLR SR,#C			;;
	RRC W6,W6			;;
	RRC W5,W5			;;
	RRC W4,W4			;;
	RRC W3,W3			;;
	RRC W2,W2			;;
	DEC W7,W7			;;
	BRA D2I_1B			;;	
D2I_2:					;;
	RLC W3,W3			;; 
	RLC W4,W4			;;
	RLC W3,W3			;;
	RLC W4,W4			;;
	RLC W3,W3			;;
	AND #3,W3			;;
	MOV #25000,W0			;;
	MUL.UU W0,W4,W8			;;
	MOV #25000,W0			;;
	MUL.UU W0,W3,W2			;;
	ADD W2,W9,W9			;;
	CLR W0				;;
	ADDC W0,W3,W10			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FTR_R2DU:				;;
	MOV FBUF0,W2			;;
	MOV FBUF1,W3			;;
	BSET W3,#7			;;		
	MOV #0x00FF,W0			;;	
	AND W3,W0,W3			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #180,W4			;;
	MOV #20861,W5			;;
	MUL.UU W4,W5,W4			;;
	CALL M2D2D			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R1,W2			;;
	MOV R2,W3			;;
	MOV R3,W4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CLR W0				;;
	IOR W2,W0,W0			;;
	IOR W3,W0,W0			;;
	IOR W4,W0,W0			;;
	BRA Z,FTR_R2DU_Z		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #24,W5			;;
FTR_R2DU_1:				;;
	DEC W5,W5			;;
	BCLR SR,#C			;;
	RLC W2,W2			;;
	RLC W3,W3			;;			
	RLC W4,W4			;;
	BRA NC,FTR_R2DU_1		;;
	INC W5,W5			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	RRC W4,W4			;;	
	RRC W3,W3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
	MOV #0x007F,W0			;;
	AND W0,W4,W4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
	MOV FBUF1,W2			;;
	SL W5,#7,W5			;;
	ADD W5,W2,W2			;;
	MOV #0xFF80,W0			;;
	AND W0,W2,W2			;;
	IOR W2,W4,W4			;;
	MOV W4,FBUF1			;; 
	MOV W3,FBUF0			;; 
	RETURN				;;	
FTR_R2DU_Z:				;;
	MOVLF 0x0000,FBUF1		;;			
	MOVLF 0x0000,FBUF0		;;			
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	


	

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TR_R2DU:				;;
	MOV DBUF0,W2			;;
	MOV DBUF1,W3			;;
	MOV DBUF2,W4			;;
	MOV DBUF3,W5			;;
	BSET W5,#4			;;
	RRC W5,W5				;;
	RRC W4,W4				;;
	RRC W3,W3				;;
	RRC W5,W5				;;
	RRC W4,W4				;;
	RRC W3,W3				;;
	RRC W5,W5				;;
	RRC W4,W4				;;
	RRC W3,W3				;;
	RRC W5,W5				;;
	RRC W4,W4				;;
	RRC W3,W3				;;
	RRC W5,W5				;;
	RRC W4,W4				;;
	RRC W3,W3				;;DBUF3+16*4
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W4,W5			;;
	MOV W3,W4			;;
	MOV #0x0039,W3			;;
	MOV #0x4BB8,W2			;;
	CALL M2D2D			;;
	MOV R3,W4			;;
	MOV R2,W3			;;
	MOV R1,W2			;;
	MOV R0,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W4,W0			;;
	IOR W3,W0,W0			;;
	IOR W2,W0,W0			;;
	BRA Z,TR_R2DU_Z			;;			
	CLR W6				;;
TR_R2DU_1:				;;
	INC W6,W6			;;
	RLC W1,W1			;;
	RLC W2,W2			;;
	RLC W3,W3			;;
	RLC W4,W4			;;
	BRA NC,TR_R2DU_1 		;;
	DEC W6,W6			;;
	CLR W5				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RLC W1,W1				;;
	RLC W2,W2				;;
	RLC W3,W3				;;
	RLC W4,W4				;;
	RLC W5,W5				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RLC W1,W1				;;
	RLC W2,W2				;;
	RLC W3,W3				;;
	RLC W4,W4				;;
	RLC W5,W5				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RLC W1,W1				;;
	RLC W2,W2				;;
	RLC W3,W3				;;
	RLC W4,W4				;;
	RLC W5,W5				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RLC W1,W1				;;
	RLC W2,W2				;;
	RLC W3,W3				;;
	RLC W4,W4				;;
	RLC W5,W5			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	SUB #16,W6			;;
	SL W6,#4,W6			;;
	MOV #0xFFF0,W0			;;
	AND DBUF3,WREG			;;
	IOR W0,W5,W5			;;
	SUB W5,W6,W5			;;
	MOV W5,DBUF3			;;
	MOV W4,DBUF2			;;
	MOV W3,DBUF1			;;
	MOV W2,DBUF0			;;
	RETURN				;;
TR_R2DU_Z:				;;
	MOVLF 0x0000,DBUF3		;;			
	MOVLF 0x0000,DBUF2		;;			
	MOVLF 0x0000,DBUF1		;;			
	MOVLF 0x0000,DBUF0		;;			
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;OUTPUR R3R2R1R0
;M3M2*M5M4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
M2D2D:					;;
	MUL.UU W2,W4,W0 		;;
	MOV W0,R0 			;;
	MOV W1,R1			;;
	MUL.UU W2,W5,W0 		;;
	MOV W0,R2 			;;
	MOV W1,R3			;;
	MUL.UU W4,W3,W0 		;;
	MOV W0,R4 			;;
	MOV W1,R5			;;
	MUL.UU W5,W3,W0 		;;
	MOV W0,R6 			;;
	MOV W1,R7			;;
	MOV R2,W0			;;	
	ADD R1				;;
	MOV R4,W0			;;
	ADDC R1				;;
	MOV R5,W0			;;
	ADDC R3				;;
	MOV R6,W0			;;
	ADDC R3				;;
	CLR W0		 		;;
	ADDC R7				;;
	MOVFF R3,R2			;;
	MOVFF R7,R3			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  



	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	CALL INIT_LCD			;;
	CALL INIT_LCDBUF
	CLR LCDPG_CNT			
MAIN_LOOP:				;;
	CALL TMR2PRG			;;
	CALL MAIN_TPRG			;;
	CALL SCAN_LCD			;;	
	CALL DISPLAY			;;
	CALL CHK_SPIRX
	CALL SPITX_PRG			;;
	CALL CHK_GPSRX			;;
	CALL KEYBO			;;
	CALL MAINK_PRG				
;	BTFSC T1P3M_F
	TG TEST_O
	CLRWDT				;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SPIRX:				;;
	BTFSC SPI2RX_PACKA_F		;;
	BRA SPIRX_A			;;
	BTFSC SPI2RX_PACKB_F		;;
	BRA SPIRX_B			;;
	RETURN				;;
SPIRX_A:				;;
	BCF SPI2RX_PACKA_F		;;	
	MOV #SPI2RX_BUFA,W1		;;
	BRA SPIRXED_PRG			;;
SPIRX_B:				;;
	BCF SPI2RX_PACKB_F		;;
	MOV #SPI2RX_BUFB,W1		;;	
	BRA SPIRXED_PRG			;;
SPIRXED_PRG:				;;
	MOV [W1++],W3			;;
	CP0 W3
	BRA Z,CHK_SPIRX_END		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #148,W0			;;
	CP W3,W0			;;
	BRA GTU,CHK_SPIRX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W3,SPIRX_LEN		;;
	MOV W3,R0			;;
	MOV #0xAB,W5			;;
	CLR W6 				;;
	MOV #SPIRX_TEMP,W4		;;
CHK_SPIRX_1A:				;;
	MOV [W1++],W3			;;
	MOV W3,[W4++]			;;
	XOR W3,W5,W5			;;
	ADD W3,W6,W6			;;
	DEC R0				;;
	BRA NZ,CHK_SPIRX_1A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W3			;;
	XOR W3,W5,W0			;;
	AND #0x00FF,W0			;;
	BRA NZ,CHK_SPIRX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W3			;;
	XOR W3,W6,W0			;;
	AND #0x00FF,W0			;;
	BRA NZ,CHK_SPIRX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF SPITX_STANDBY_F		;;	
	MOV #SPIRX_TEMP,W1		;;
	MOV [W1++],W0			;;
	CALL SPIRX_CMD			;;
CHK_SPIRX_END:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIRX_CMD:				;;
	CP W0,#0xA3			;;
	BRA Z,SPIRX_A3			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIRX_A3:				;;
	CLR SYSTIME_CNT			;;
;	TG LED1_O			;;
	CLR SPINORX_TIM			;;	
	MOV [W1++],W0			;;
	MOV W0,URX14			;;
	MOV [W1++],W0			;;
	MOV W0,URX13			;;
	MOV [W1++],W0			;;
	MOV W0,URX16			;;
	MOV [W1++],W0			;;
	MOV W0,URX15			;;
	MOV [W1++],W0			;;
	MOV W0,URX12			;;
	MOV [W1++],W0			;;
	MOV W0,URX11			;;
	MOV [W1++],W0			;;
	MOV W0,URX10			;;
	PUSH W1				;;
	BTFSS EDIT_SYSTIME_F		;;
	CALL LOAD_SYSTIME		;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSC EDIT_NETADDR_F		;;
	BRA SPIRX_A3_1
	MOV #TCPIP_BUF,W3		;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #NETMASK_BUF,W3		;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #GATEWAY_BUF,W3		;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	AND #3,W0			;;
	MOV W0,GPS_STATUS_CNT		;;
	MOV [W1++],W2			;;
	SWAP W2				;;
	MOV [W1++],W0			;;
	IOR W0,W2,W0			;;
	MOV W0,NTP_OFFS			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	MOV [W1++],W2			;;
	SWAP W2				;;
	MOV [W1++],W0			;;
	IOR W0,W2,W0			;;
	MOV W0,NTP_JITTER		;;
SPIRX_A3_1:				;;
	RETURN				;;	









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SYSTIME:				;;
	BSF SYSTIME_LOAD_F		;;
	MOV URX16,W0			;;
	SWAP W0				;;
	IOR URX15			;;
	MOV #DATE_BUF,W3		;;
	MOV URX14,W0			;;
	MOV W0,[W3++]			;;
	MOV URX13,W0			;;
	MOV W0,[W3++]			;;
	MOV URX15,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #TIME_BUF,W3		;;
	MOV URX12,W0			;;
	MOV W0,[W3++]			;;
	MOV URX11,W0			;;
	MOV W0,[W3++]			;;
	MOV URX10,W0			;;
	MOV W0,[W3++]			;;	
	CLR SYSTIME_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_WEEK			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX16,W0			;;
	CALL GET_WEEK_R210		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #DATES_BUF,W1		;;
	MRW1 R2				;;
	MRW1 R1				;;
	MRW1 R0				;;
	MIW1 ' '			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX14,W0			;;
	CALL TR2BW1			;;
	MIW1 '.'			;;
	MOV URX13,W0			;;
	CALL TR2BW1			;;
	MIW1 '.'			;;
	MOV URX15,W0			;;
	CALL TR4BW1			;;
	MIW1 0				;;
	MOV #TIMES_BUF,W1		;;
	MIW1 'U'			;;
	MIW1 'T'			;;
	MIW1 'C'			;;
	MIW1 '+'			;;
	MIW1 '8'			;;
	MIW1 ' '			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX12,W0			;;
	CALL TR2BW1			;;
	MIW1 ':'			;;
	MOV URX11,W0			;;
	CALL TR2BW1			;;
	MIW1 ':'			;;
	MOV URX10,W0			;;
	CALL TR2BW1			;;
	MIW1 0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;













 	RETURN

	



	

CHK_GPSRX:
	BTFSC URXA_RECED_F	
	BRA CHK_GPSRX_A
	BTFSC URXB_RECED_F	
	BRA CHK_GPSRX_B
	RETURN
CHK_GPSRX_A:
	BCF URXA_RECED_F
	MOV GPSURX_LENA,W0
	MOV W0,GPSURX_LEN	
	MOV #GPSURX_BUFA,W1
	MOV W1,GPSURX_ADDR	
	BRA GPSRXED_PRG
CHK_GPSRX_B:
	BCF URXB_RECED_F
	MOV GPSURX_LENB,W0
	MOV W0,GPSURX_LEN	
	MOV #GPSURX_BUFB,W1
	MOV W1,GPSURX_ADDR	
	BRA GPSRXED_PRG
GPSRXED_PRG:
	MOV [W1++],W0
	CP W0,#0x8F
	BRA Z,GPSRX8F
	CP W0,#0x6D
	BRA Z,GPSRX6D
	CP W0,#0x46
	BRA Z,GPSRX46
	CP W0,#0x4B
	BRA Z,GPSRX4B
	CP W0,#0x5C
	BRA Z,GPSRX5C
	CP W0,#0x6F
	BRA Z,GPSRX6F
	CP W0,#0x41
	BRA Z,GPSRX41
	CP W0,#0x42
	BRA Z,GPSRX42
	NOP
	NOP
	NOP
	RETURN
GPSRX41:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W1				;;
	CALL REPEAT_U2TX		;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RETURN
GPSRX46:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W1				;;
	CALL REPEAT_U2TX		;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RETURN
GPSRX4B:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W1				;;
	CALL REPEAT_U2TX		;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RETURN
GPSRX6F:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W1				;;
	CALL REPEAT_U2TX		;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	BSF GPS6F_EN_F
	CLR GPS6F_TIM	 
	RETURN
GPSRX42:
	NOP
	NOP
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSRX5C:					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W1				;;
	CALL REPEAT_U2TX		;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #24,W0				;;
	CALL LOAD_URX				;;
	MOV #4,W0				;;
	CP SATE_SEL_CNT				;;
	BRA GEU,GPSRX5C_1			;;
	MOV URX04,W0 				;;
	SL W0,#4,W0				;;
	MOV URX05,W1 				;;
	LSR W1,#4,W1				;;
	IOR W0,W1,W1				;;
	MOV #0x421,W0				;;
	CP W1,W0				;;
	BRA LTU,GPSRX5C_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP0 SATE_SEL_CNT			;;
	BRA NZ,GPSRX5C_0			;;
	MOV URX00,W0				;;
	MOV W0,NTPGPS_NO			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX12,W0				;;
	SWAP W0					;;
	IOR URX13,WREG				;;
	MOV W0,FBUF1				;;
	MOV URX14,W0				;;
	SWAP W0					;;
	IOR URX15,WREG				;;
	MOV W0,FBUF0				;;
	CALL FTR_R2DU				;;
	CALL FLOAT2INT				;;
	MOV W10,W0				;;
	CALL L1D_3B				;;
	MOV W5,W0				;;
	MOV #10,W1				;;
	MUL.UU W0,W1,W2				;;
	MOV R2,W0				;;
	ADD W2,W0,W0				;;
	MOV #NTPGPS_EL,W1			;;
	MOV W0,[W1]				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX16,W0				;;
	SWAP W0					;;
	IOR URX17,WREG				;;
	MOV W0,FBUF1				;;
	MOV URX18,W0				;;
	SWAP W0					;;
	IOR URX19,WREG				;;
	MOV W0,FBUF0				;;
	CALL FTR_R2DU				;;
	CALL FLOAT2INT				;;
	MOV W10,W0				;;
	CALL L1D_3B				;;
	MOV W5,W0				;;
	MOV #10,W1				;;
	MUL.UU W0,W1,W2				;;
	MOV R2,W0				;;
	ADD W2,W0,W0				;;
	MOV #NTPGPS_AZ,W1			;;
	MOV W0,[W1]				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSRX5C_0:					;;
	MOV #SATE_SELBUF,W1			;;
	MOV SATE_SEL_CNT,W0			;;
	ADD W0,W1,W1				;;
	ADD W0,W1,W1				;;
	MOV URX00,W0				;;
	MOV W0,[W1]				;;
	INC SATE_SEL_CNT			;;	
GPSRX5C_1:					;;
	INC SATE_INVIEW_BUF			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GPSRX8F:
	MOV [W1],W0
	CP W0,#0xAB
	BRA Z,GPSRX8FAB
	MOV [W1],W0
	CP W0,#0xAC
	BRA Z,GPSRX8FAC

	NOP
	NOP
	NOP
	RETURN
GPSRX6D:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W1				;;
	CALL REPEAT_U2TX		;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #17,W0
	CALL LOAD_URX
	MOV URX00,W0
	SWAP.B W0
	AND #15,W0	
	MOV W0,SATE_GOOD
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX01,W0			;;
	SWAP W0				;;
	IOR URX02,WREG			;;
	MOV W0,FBUF1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV URX03,W0			;;
	SWAP W0				;;
	IOR URX04,WREG			;;
	MOV W0,FBUF0			;;PDOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLOAT2INT			;;
	MOV #GPS_PDOP,W1		;;
	MOV W6,[W1++]			;;
	MOV W5,[W1++]			;;
	MOV W10,[W1++]			;;
	MOV W9,[W1++]			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX05,W0			;;
	SWAP W0				;;
	IOR URX06,WREG			;;
	MOV W0,FBUF1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV URX07,W0			;;
	SWAP W0				;;
	IOR URX08,WREG			;;
	MOV W0,FBUF0			;;HDOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLOAT2INT			;;
	MOV #GPS_HDOP,W1		;;
	MOV W6,[W1++]			;;
	MOV W5,[W1++]			;;
	MOV W10,[W1++]			;;
	MOV W9,[W1++]			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX09,W0			;;
	SWAP W0				;;
	IOR URX10,WREG			;;
	MOV W0,FBUF1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV URX11,W0			;;
	SWAP W0				;;
	IOR URX12,WREG			;;
	MOV W0,FBUF0			;;VDOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLOAT2INT			;;
	MOV #GPS_VDOP,W1		;;
	MOV W6,[W1++]			;;
	MOV W5,[W1++]			;;
	MOV W10,[W1++]			;;
	MOV W9,[W1++]			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_URX:				;;
	MOV W0,W4
	CLR W2				;;
	MOV #URX00,W3			;;
LOAD_URX_1:				;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	INC W2,W2			;;
	CP W2,W4			;;
	BRA LTU,LOAD_URX_1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSRX8FAC:				;;
	PUSH W1				;;
	CALL REPEAT_U2TX		;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W2				;;
	MOV #URX00,W3			;;
GPSRX8FAC_1:				;;
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	INC W2,W2			;;
	CP W2,#68			;;
	BRA LTU,GPSRX8FAC_1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX36,W0			;;
	SWAP W0				;;
	IOR URX37,WREG			;;
	MOV W0,DBUF3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX38,W0			;;
	SWAP W0				;;
	IOR URX39,WREG			;;
	MOV W0,DBUF2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX40,W0			;;
	SWAP W0				;;
	IOR URX41,WREG			;;
	MOV W0,DBUF1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV URX42,W0			;;
	SWAP W0				;;
	IOR URX43,WREG			;;
	MOV W0,DBUF0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TR_R2DU			;;	
	CALL DOUBLE2INT			;;
	MOV #LATDPD,W1			;;
	MOV W6,[W1++]			;;
	MOV W5,[W1++]			;;
	MOV W10,[W1++]			;;
	MOV W9,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LATBUF,W1			;;
	MOV W5,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RRC W10,W10			;;
	RRC W9,W9			;;
	MOV #4719,W0			;;
	MUL.UU W9,W0,W0			;;
	MOV W1,W0			;;
	MOV #60,W2			;;
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	MOV #LATBUF+2,W3		;;
	MOV W0,[W3++]			;;
	MOV W1,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX44,W0			;;
	SWAP W0				;;
	IOR URX45,WREG			;;
	MOV W0,DBUF3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX46,W0			;;
	SWAP W0				;;
	IOR URX47,WREG			;;
	MOV W0,DBUF2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX48,W0			;;
	SWAP W0				;;
	IOR URX49,WREG			;;
	MOV W0,DBUF1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV URX50,W0			;;
	SWAP W0				;;
	IOR URX51,WREG			;;
	MOV W0,DBUF0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TR_R2DU			;;	
	CALL DOUBLE2INT			;;
	MOV #LONDPD,W1			;;
	MOV W6,[W1++]			;;
	MOV W5,[W1++]			;;
	MOV W10,[W1++]			;;
	MOV W9,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LONBUF,W1			;;
	MOV W5,[W1++]			;;
	RRC W10,W10			;;
	RRC W9,W9			;;
	MOV #4719,W0			;;
	MUL.UU W9,W0,W0			;;
	MOV W1,W0			;;
	MOV #60,W2			;;
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	MOV #LONBUF+2,W3		;;
	MOV W0,[W3++]			;;
	MOV W1,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX52,W0			;;
	SWAP W0				;;
	IOR URX53,WREG			;;
	MOV W0,DBUF3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX54,W0			;;
	SWAP W0				;;
	IOR URX55,WREG			;;
	MOV W0,DBUF2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX56,W0			;;
	SWAP W0				;;
	IOR URX57,WREG			;;
	MOV W0,DBUF1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV URX58,W0			;;
	SWAP W0				;;
	IOR URX59,WREG			;;
	MOV W0,DBUF0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL DOUBLE2INT			;;
	MOV #ALTDPD,W1			;;
	MOV W6,[W1++]			;;
	MOV W5,[W1++]			;;
	MOV W10,[W1++]			;;
	MOV W9,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GPSTX_STAND		;;
	MOV SATE_INVIEW_BUF,W0		;;
	MOV W0,SATE_INVIEW		;;
	CLR SATE_INVIEW_BUF		;;
	MOV SATE_SEL_CNT,W0		;;
	MOV W0,SATE_SEL_AMT		;;
	CLR SATE_SEL_CNT		;;
	INC GPS6F_TIM
	MOV #4,W0
	CP GPS6F_TIM
	BRA LTU,$+4
	BCF GPS6F_EN_F	 

	RETURN
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSRX8FAB:				;;
	PUSH W1				;;
	;BRA XXXSSS
	MOV GPSURX_ADDR,W3		;;
	MOV #18,W0			;;
	ADD W0,W3,W3			;;
	MOV [W3],W0			;;
	CP0 W0				;;
	BRA Z,GPSRX8FAB_00		;;
	CP ROON_SEC			;;
	BRA Z,GPSRX8FAB_00		;;
	NOP
	NOP
	NOP
	MOV W0,ROON_SEC			;;
	CALL SAVE_FLASH24		;;
	NOP
	NOP				;;
	NOP
	NOP				;;
GPSRX8FAB_00:				;;
	MOV ROON_SEC,W0			;;
	MOV W0,[W3]			;;
XXXSSS:	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL REPEAT_U2TX		;;
	POP W1				;;
	CLR FAIL_LED_TIM		;; 
	CLR W2				;;
	MOV #URX00,W3			;;
GPSRX8FAB_1:				;;	
	MOV [W1++],W0			;;
	MOV W0,[W3++]			;;
	INC W2,W2			;;
	CP W2,#17			;;
	BRA LTU,GPSRX8FAB_1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX15,W0			;;
	SWAP W0				;;
	IOR URX16,WREG			;;
	MOV W0,URX15			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TIME_ADD8			;;
	CALL GET_WEEK			;;
	MOV #GPSDATE_BUF,W1		;;
	MOV URX16,W0			;;WEEK
	MOV W0,[W1++]			;;
	MOV URX15,W0			;;
	MOV W0,[W1++]			;;
	MOV URX14,W0			;;
	MOV W0,[W1++]			;;
	MOV URX13,W0			;;
	MOV W0,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #GPSTIME_BUF,W1		;;
	MOV URX12,W0			;;
	MOV W0,[W1++]			;;	
	MOV URX11,W0			;;
	MOV W0,[W1++]			;;
	MOV URX10,W0			;;
	MOV W0,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN

	CLR GPSTIME_CNT			;; 
	MOV #200,W0			;;
	CP SYSTIME_CNT			;;
	BRA GEU,$+4			;;
	RETURN				;;

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX16,W0			;;
	CALL GET_WEEK_R210		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #DATES_BUF,W1		;;
	MRW1 R2				;;
	MRW1 R1				;;
	MRW1 R0				;;
	MIW1 ' '			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX14,W0
	CALL TR2BW1
	MIW1 '.'
	MOV URX13,W0
	CALL TR2BW1
	MIW1 '.'
	MOV URX15,W0
	CALL TR4BW1
	MIW1 0
	MOV #TIMES_BUF,W1		;;
	MIW1 'U'
	MIW1 'T'
	MIW1 'C'
	MIW1 '+'
	MIW1 '8'
	MIW1 ' '
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX12,W0
	CALL TR2BW1
	MIW1 ':'
	MOV URX11,W0
	CALL TR2BW1
	MIW1 ':'
	MOV URX10,W0
	CALL TR2BW1
	MIW1 0
	RETURN
TR2BW1:
	PUSH W1
	CALL L1D_2B
	POP W1
	MOV #0x30,W0
	ADD R1,WREG		
	MOV W0,[W1++]
	MOV #0x30,W0
	ADD R0,WREG		
	MOV W0,[W1++]
	RETURN	
		
TR4BW1:
	PUSH W1
	CALL L1D_4B
	POP W1
	MOV #0x30,W0
	ADD R3,WREG		
	MOV W0,[W1++]
	MOV #0x30,W0
	ADD R2,WREG		
	MOV W0,[W1++]
	MOV #0x30,W0
	ADD R1,WREG		
	MOV W0,[W1++]
	MOV #0x30,W0
	ADD R0,WREG		
	MOV W0,[W1++]
	RETURN	


GET_MONTH_DAYS:
	AND #15,W0
	BRA W0
	RETLW #31,W0
	RETLW #31,W0	;1
	RETLW #28,W0	;2
	RETLW #31,W0	;3
	RETLW #30,W0	;4
	RETLW #31,W0	;5
	RETLW #30,W0	;6
	RETLW #31,W0	;7
	RETLW #31,W0	;8
	RETLW #30,W0	;9
	RETLW #31,W0	;10
	RETLW #30,W0	;11
	RETLW #31,W0	;12
	RETLW #31,W0	;
	RETLW #31,W0	;
	RETLW #31,W0	;
	RETLW #31,W0	;
	RETLW #31,W0	;

GET_WEEK_R210:
	AND #7,W0
	BRA W0
	BRA GWR_J0
	BRA GWR_J1
	BRA GWR_J2
	BRA GWR_J3
	BRA GWR_J4
	BRA GWR_J5
	BRA GWR_J6
	BRA GWR_J7
GWR_J0:
	MOVLF 'S',R2
	MOVLF 'U',R1
	MOVLF 'N',R0
	RETURN
GWR_J1:
	MOVLF 'M',R2
	MOVLF 'O',R1
	MOVLF 'N',R0
	RETURN
GWR_J2:
	MOVLF 'T',R2
	MOVLF 'U',R1
	MOVLF 'E',R0
	RETURN
GWR_J3:
	MOVLF 'W',R2
	MOVLF 'E',R1
	MOVLF 'N',R0
	RETURN
GWR_J4:
	MOVLF 'T',R2
	MOVLF 'H',R1
	MOVLF 'U',R0
	RETURN
GWR_J5:
	MOVLF 'F',R2
	MOVLF 'R',R1
	MOVLF 'I',R0
	RETURN
GWR_J6:
	MOVLF 'S',R2
	MOVLF 'A',R1
	MOVLF 'T',R0
	RETURN
GWR_J7:
	MOVLF ' ',R2
	MOVLF ' ',R1
	MOVLF ' ',R0
	RETURN









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TIME_ADD8:				;;
	MOV #8,W0			;;
	ADD URX12			;;
	MOV #24,W0			;;
	CP URX12			;;
	BRA GEU,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC URX13			;;
	MOV URX14,W0,			;;	
	CALL GET_MONTH_DAYS		;;
	MOV W0,R0			;;
	MOV URX15,W0			;;	
	AND #3,W0			;;
	BRA NZ,TIME_ADD8_1		;;
	MOV #2,W0			;;
	CP URX14			;;
	BRA NZ,TIME_ADD8_1		;;
	INC R0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TIME_ADD8_1:				;;
	MOV R0,W0			;;
	CP URX13			;;
	BRA LEU,TIME_ADD8_2		;;
	MOVLF #1,URX13			;;
	INC URX14			;;
	MOV #12,W0			;;
	CP URX14			;;
	BRA LEU,TIME_ADD8_2		;;
	MOVLF #1,URX14			;;
	INC URX15			;;
TIME_ADD8_2:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_WEEK:				;;
	MOV #6,W0			;;DAY 
	MOV W0,URX16			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV URX15,W0			;;
	MOV #2000,W0			;;
	SUB URX15,WREG			;;
	BRA LTU,GET_WEEK_END		;;
	MOV W0,R1			;;
	MOV #100,W0			;;
	CP R1				;;
	BRA GEU,GET_WEEK_END		;;
	CLR R0				;;
GET_WEEK_1:				;;
	MOV R1,W0			;;
	CP R0				;;
	BRA Z,GET_WEEK_2		;;
	MOV #3,W0			;;
	AND R0,WREG			;;
	BRA NZ,$+4			;;
	INC URX16			;;
	INC URX16			;;		
	INC R0				;;
	BRA GET_WEEK_1			;;
GET_WEEK_2:				;;
	MOVLF #1,R0			;;
GET_WEEK_3:				;;
	MOV URX14,W0			;;
	CP R0				;;
	BRA Z,GET_WEEK_4		;;
	MOV R0,W0			;;
	CALL GET_MONTH_DAYS		;;
	ADD URX16			;;	
	INC R0				;;
	BRA GET_WEEK_3			;;
GET_WEEK_4:				;;
	MOV URX13,W0			;;
	ADD URX16			;;
	DEC URX16			;;
	MOV URX16,W0			;;
	MOV #7,W2			;;
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	MOV W1,URX16			;;
GET_WEEK_END:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCSH6:					;;
	CALL ENLCD_FLASH		;;
	INC SHIFT_CNT			;;
	MOV #6,W0			;;	
	CP SHIFT_CNT			;;
	BRA GTU,$+4			;;
	RETURN				;;
	MOV #1,W0			;;
	MOV W0,SHIFT_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCSH4:					;;
	CALL ENLCD_FLASH		;;
	INC SHIFT_CNT			;;
	MOV #4,W0			;;	
	CP SHIFT_CNT			;;
	BRA GTU,$+4			;;
	RETURN				;;
	MOV #1,W0			;;
	MOV W0,SHIFT_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISLCD_FLASH:				;;
	BSF DIS_FLASH_F			;;
	CLR DIS_FLASH_TIM		;;
	BCF FLASH_LCD_F			;;
	CLR FLASH_LCD_TIM		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENLCD_FLASH:				;;
	BCF DIS_FLASH_F			;;
	CLR DIS_FLASH_TIM		;;
	BSF FLASH_LCD_F			;;
	CLR FLASH_LCD_TIM		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCIW1C_YEAR:				;;
	MOV #490,W0			;;
	MOV W0,KEYCON_CNT		;;
INCIW1_YEAR:					;;
	CALL DISLCD_FLASH		;;
	INC [W1],[W1]			;;
	MOV [W1],W0			;;
	CP W0,W2			;;
	BRA GTU,$+4			;;
	RETURN				;;
        MOV #2000,W0                    ;;
	MOV W0,[W1]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCIW1C:				;;
	MOV #490,W0			;;
	MOV W0,KEYCON_CNT		;;
INCIW1:					;;
	CALL DISLCD_FLASH		;;
	INC [W1],[W1]			;;
	MOV [W1],W0			;;
	CP W0,W2			;;
	BRA GTU,$+4			;;
	RETURN				;;
	CLR [W1]			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECIW1C:				;;
	MOV #490,W0			;;
	MOV W0,KEYCON_CNT		;;
DECIW1:					;;
	CALL DISLCD_FLASH		;;
	DEC [W1],[W1]			;;
	MOV [W1],W0			;;
	CP W0,W2			;;
	BRA GTU,$+4			;;
	RETURN				;;
	MOV W2,[W1]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAINK_LIGHT:				;;
	TG LCD_LED_O
	RETURN
	TG DISP_PG_F			;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAINK_PRG:				;;
	BTFSC LIGHT_KF			;;
	BRA MAINK_LIGHT			;;
	BTFSC MENU_KF			;;
	CLR SHIFT_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #49,W0			;;
	CP LCDPG_CNT			;;
	BRA LTU,$+4			;;
	CLR LCDPG_CNT			;;
	MOV LCDPG_CNT,W0		;;
	BRA W0				;;
	BRA KEYPG_J00			;;
	BRA KEYPG_J01			;;
	BRA KEYPG_J02			;;
	BRA KEYPG_J03			;;
	BRA KEYPG_J04			;;
	BRA KEYPG_J05			;;
	BRA KEYPG_J06			;;
	BRA KEYPG_J07			;;
	BRA KEYPG_J08			;;
	BRA KEYPG_J09			;;
	BRA KEYPG_J10			;;
	BRA KEYPG_J11			;;
	BRA KEYPG_J12			;;
	BRA KEYPG_J13			;;
	BRA KEYPG_J14			;;
	BRA KEYPG_J15			;;
	BRA KEYPG_J16			;;
	BRA KEYPG_J17			;;
	BRA KEYPG_J18			;;
	BRA KEYPG_J19			;;
	BRA KEYPG_J20			;;
	BRA KEYPG_J21			;;
	BRA KEYPG_J22			;;
	BRA KEYPG_J23			;;
	BRA KEYPG_J24			;;
	BRA KEYPG_J25			;;
	BRA KEYPG_J26			;;
	BRA KEYPG_J27			;;
	BRA KEYPG_J28			;;
	BRA KEYPG_J29			;;
	BRA KEYPG_J30			;;
	BRA KEYPG_J31			;;
	BRA KEYPG_J32			;;
	BRA KEYPG_J33			;;
	BRA KEYPG_J34			;;
	BRA KEYPG_J35			;;
	BRA KEYPG_J36			;;
	BRA KEYPG_J37			;;
	BRA KEYPG_J38			;;
	BRA KEYPG_J39			;;
	BRA KEYPG_J40			;;
	BRA KEYPG_J41			;;
	BRA KEYPG_J42			;;
	BRA KEYPG_J43			;;
	BRA KEYPG_J44			;;
	BRA KEYPG_J45			;;
	BRA KEYPG_J46			;;
	BRA KEYPG_J47			;;
	BRA KEYPG_J48			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPG_J00:				;;	
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #3,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #1,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J01:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #3,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #2,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J02:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #3,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #0,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J03:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #6,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #4,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J04:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #6,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #3,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J05:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #6,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #3,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J06:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #8,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #7,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J07:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #8,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #6,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J08:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J09:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #42,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	BRA $+6				;;
	MOV #10,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #20,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPG_J10:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #11,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #43,W0			;;
	MOV W0,LCDPG_CNT		;;
	MOVLF 1,SHIFT_CNT		;;
	RETURN				;;
KEYPG_J11:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #12,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #44,W0			;;
	MOV W0,LCDPG_CNT		;;
	MOVLF 1,SHIFT_CNT		;;
	RETURN				;;
KEYPG_J12:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #13,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #45,W0			;;
	MOV W0,LCDPG_CNT		;;
	MOVLF 1,SHIFT_CNT		;;
	RETURN				;;
KEYPG_J13:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #14,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J14:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #15,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J15:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #16,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J16:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #17,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J17:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #18,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J18:				;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	BTFSS NEXT_KF			;;
	BRA $+8				;;
	MOV #19,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	BTFSS INC_KF			;;
	RETURN				;;
	MOVLF #5,SPITX_MOD		;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J19:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #10,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPG_J20:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	BRA $+6				;;
	MOV #21,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #22,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J21:				;;
	BTFSS MENU_KF			;;
	RETURN				;;
	MOV #20,W0			;;
	MOV W0,LCDPG_CNT		;;
	BSF PGRET_F			;;
	CLR PGRET_TIM			;;
	MOVLF #20,PGRET_CNT		;;
	RETURN				;;
KEYPG_J22:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #24,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #23,W0			;;
	MOV W0,LCDPG_CNT		;;
	BSF PGRET_F			;;
	CLR PGRET_TIM			;;
	MOVLF #22,PGRET_CNT		;;
	RETURN				;;
KEYPG_J23:				;;
	BTFSS MENU_KF			;;
	RETURN				;;
	MOV #22,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J24:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #26,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #25,W0			;;
	MOV W0,LCDPG_CNT		;;
	BSF PGRET_F			;;
	CLR PGRET_TIM			;;
	MOVLF #24,PGRET_CNT		;;
	RETURN				;;
KEYPG_J25:				;;
	BTFSS MENU_KF			;;
	RETURN				;;
	MOV #24,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J26:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #28,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #27,W0			;;
	MOV W0,LCDPG_CNT		;;
	;BSF PGRET_F			;;
	;CLR PGRET_TIM			;;
	;MOVLF #26,PGRET_CNT		;;
	RETURN				;;
KEYPG_J27:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #26,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #28,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J28:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #30,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #29,W0			;;
	MOV W0,LCDPG_CNT		;;
	BSF PGRET_F			;;
	CLR PGRET_TIM			;;
	MOVLF #28,PGRET_CNT		;;
	RETURN				;;
KEYPG_J29:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #28,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #30,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPG_J30:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	BRA $+6				;;
	MOV #31,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #32,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J31:				;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #30,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	CP0 SHIFT_CNT			;;
	BRA NZ,KEYPG_J31_1		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #32,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	RETURN
	MOV #1,W0			;;
	MOV W0,SHIFT_CNT		;;
	CALL ENLCD_FLASH		;;
	RETURN				;;
KEYPG_J31_1:				;;
	BTFSC NEXT_KF			;;
	CALL INCSH6			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SHIFT_CNT,W0		;;
	AND #7,W0			;;
	CALL J31TBL			;;
	MOV W0,W2			;;
	MOV #LOCLAT_BUF,W1		;;
	MOV SHIFT_CNT,W0		;;	
	DEC W0,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSC INC_KF			;;	
	CALL INCIW1			;;
	BTFSC INC_KCF			;;	
	CALL INCIW1C			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSC ACK_KF			;;	
	CLR SHIFT_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
J31TBL:					;;
	BRA W0				;;
	RETLW #0,W0			;;
	RETLW #90,W0			;;
	RETLW #60,W0			;;
	RETLW #60,W0			;;
	RETLW #180,W0			;;
	RETLW #60,W0			;;
	RETLW #60,W0			;;
	RETLW #90,W0			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPG_J32:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	BRA $+6				;;
	MOV #33,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #34,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J33:				;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #32,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	CP0 SHIFT_CNT			;;
	BRA NZ,KEYPG_J33_1		;;
	BTFSS NEXT_KF			;;
	BRA $+8				;;
	MOV #34,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #1,W0			;;
	MOV W0,SHIFT_CNT		;;
	CALL ENLCD_FLASH		;;
	RETURN				;;
KEYPG_J33_1:				;;
	BTFSC NEXT_KF			;;
	CALL INCSH6			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SHIFT_CNT,W0		;;
	AND #7,W0			;;
	CALL J33TBL			;;
	MOV W0,W2			;;
	MOV #DATE_BUF,W1		;;
	MOV SHIFT_CNT,W0		;;	
	DEC W0,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
        MOV #3,W0
        CP SHIFT_CNT
        BRA Z,HHGG
	BTFSC INC_KF			;;	
	CALL INCIW1		;;
	BTFSC INC_KCF			;;	
	CALL INCIW1C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSS ACK_KF			;;	
	RETURN				;;
	MOVLF #4,SPITX_MOD		;;
	CLR SHIFT_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HHGG:
	BTFSC INC_KF			;;	
	CALL INCIW1_YEAR		;;
	BTFSC INC_KCF			;;	
	CALL INCIW1C_YEAR		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSS ACK_KF			;;	
	RETURN				;;
	MOVLF #4,SPITX_MOD		;;
	CLR SHIFT_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
J33TBL:					;;
	BRA W0				;;
        BRA TJ00
        BRA TJ01
        BRA TJ02
        BRA TJ03
        BRA TJ04
        BRA TJ05
        BRA TJ06
        BRA TJ07
TJ00:
        MOV #0,W0
        RETURN
TJ01:
        MOV #12,W0
        RETURN
TJ02:
        MOV #31,W0
        RETURN
TJ03:
        MOV #2099,W0
        RETURN
TJ04:
        MOV #23,W0
        RETURN
TJ05:
        MOV #59,W0
        RETURN
TJ06:
        MOV #59,W0
        RETURN
TJ07:
        MOV #0,W0
        RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;














KEYPG_J34:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	BRA $+6				;;
	MOV #35,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #36,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J35:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #34,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #36,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J36:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	BRA $+6				;;
	MOV #37,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #38,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J37:				;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #36,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSS NEXT_KF			;;
	BRA $+8				;;
	MOV #38,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	BTFSS INC_KF			;;
	RETURN				;;
	MOV #36,W0			;;
	MOV W0,LCDPG_CNT		;;
	CALL GPSTX_COLD_RESET		;;
	RETURN				;;
KEYPG_J38:				;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	BTFSS ACK_KF			;;
	BRA $+8				;;
	MOV #39,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	BTFSS NEXT_KF			;;
	BRA $+8				;;
	MOV #40,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	RETURN

KEYPG_J39:				;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #38,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	BTFSS NEXT_KF			;;
	BRA $+8				;;
	MOV #40,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	BTFSS INC_KF			;;
	RETURN				;;
	MOV #38,W0			;;
	MOV W0,LCDPG_CNT		;;
	CALL GPSTX_WARM_RESET		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPG_J40:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #9,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS ACK_KF			;;
	BRA $+6				;;
	MOV #41,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #20,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J41:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #40,W0			;;
	MOV W0,LCDPG_CNT		;;
	BTFSS NEXT_KF			;;
	BRA $+6				;;
	MOV #20,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J42:				;;
	BTFSS MENU_KF			;;
	BRA $+6				;;
	MOV #0,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J43:				;;
	CLR SPISET_TIM			;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #10,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	CP0 SHIFT_CNT			;;
	BRA NZ,KEYPG_J43_1		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #1,W0			;;
	MOV W0,SHIFT_CNT		;;
	CALL ENLCD_FLASH		;;
	RETURN				;;
KEYPG_J43_1:				;;
	BTFSC NEXT_KF			;;
	CALL INCSH4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SHIFT_CNT,W0		;;
	AND #7,W0			;;
	CALL J43TBL			;;
	MOV W0,W2			;;
	MOV #NETMASK_BUF,W1		;;
	MOV SHIFT_CNT,W0		;;	
	DEC W0,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSC INC_KF			;;	
	CALL INCIW1			;;
	BTFSC INC_KCF			;;	
	CALL INCIW1C			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSS ACK_KF			;;	
	RETURN				;;
	CLR SHIFT_CNT			;;
	MOVLF #2,SPITX_MOD		;;
	MOV #10,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
J43TBL:					;;
J44TBL:					;;
J45TBL:					;;
	BRA W0				;;
	RETLW #0,W0			;;
	RETLW #255,W0			;;
	RETLW #255,W0			;;
	RETLW #255,W0			;;
	RETLW #255,W0			;;
	RETLW #0,W0			;;
	RETLW #0,W0			;;
	RETLW #0,W0			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPG_J44:				;;
	CLR SPISET_TIM			;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #11,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	CP0 SHIFT_CNT			;;
	BRA NZ,KEYPG_J44_1		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #1,W0			;;
	MOV W0,SHIFT_CNT		;;
	CALL ENLCD_FLASH		;;
	RETURN				;;
KEYPG_J44_1:				;;
	BTFSC NEXT_KF			;;
	CALL INCSH4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SHIFT_CNT,W0		;;
	AND #7,W0			;;
	CALL J44TBL			;;
	MOV W0,W2			;;
	MOV #GATEWAY_BUF,W1		;;
	MOV SHIFT_CNT,W0		;;	
	DEC W0,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSC INC_KF			;;	
	CALL INCIW1			;;
	BTFSC INC_KCF			;;	
	CALL INCIW1C			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSS ACK_KF			;;	
	RETURN				;;
	MOVLF #3,SPITX_MOD		;;
	CLR SHIFT_CNT			;;
	MOV #11,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYPG_J45:				;;
	CLR SPISET_TIM			;;
	BTFSS MENU_KF			;;
	BRA $+8				;;
	MOV #12,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
	CP0 SHIFT_CNT			;;
	BRA NZ,KEYPG_J45_1		;;
	BTFSS ACK_KF			;;
	RETURN				;;
	MOV #1,W0			;;
	MOV W0,SHIFT_CNT		;;
	CALL ENLCD_FLASH		;;
	RETURN				;;
KEYPG_J45_1:				;;
	BTFSC NEXT_KF			;;
	CALL INCSH4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SHIFT_CNT,W0		;;
	AND #7,W0			;;
	CALL J45TBL			;;
	MOV W0,W2			;;
	MOV #TCPIP_BUF,W1		;;
	MOV SHIFT_CNT,W0		;;	
	DEC W0,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSC INC_KF			;;	
	CALL INCIW1			;;
	BTFSC INC_KCF			;;	
	CALL INCIW1C			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSS ACK_KF			;;	
	RETURN				;;
	MOVLF #1,SPITX_MOD		;;
	CLR SHIFT_CNT			;;
	MOV #12,W0			;;
	MOV W0,LCDPG_CNT		;;
	RETURN				;;
KEYPG_J46:				;;
	RETURN				;;
KEYPG_J47:				;;
	RETURN				;;
KEYPG_J48:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;PG1
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_TBL:				;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
        TBLRDL [W1],W1		        ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_MS:				;;
	PUSH W2				;;
	MOV #0x8000,W2			;;
	CP W0,W2			;;
	POP W2				;;
	BRA Z,DISP_MS_2	
	BTSS W0,#15			;;
	BRA DISP_MS_1			;;
	NEG W0,W0			;;
	PUSH W0				;;
	MOV #'-',W0			;;
	CALL ENCHR			;;
	POP W0				;;
DISP_MS_1:				;;
	CALL L1D_5B			;;
	CALL SDISP5B			;;
	RETURN				;;
DISP_MS_2:				;;
	MOV #'-',W0			;;
	CALL ENCHR			;;
	MOV #'-',W0			;;
	CALL ENCHR			;;
	MOV #'-',W0			;;
	CALL ENCHR			;;
	MOV #'-',W0			;;
	CALL ENCHR			;;
	MOV #'-',W0			;;
	CALL ENCHR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SDISP7B:				;;
	CP0 R6				;;
	BRA NZ,DISP7B			;;
SDISP6B:				;;
	CP0 R5				;;
	BRA NZ,DISP6B			;;
SDISP5B:				;;
	CP0 R4				;;
	BRA NZ,DISP5B			;;
SDISP4B:				;;
	CP0 R3				;;
	BRA NZ,DISP4B			;;
SDISP3B:				;;
	CP0 R2				;;
	BRA NZ,DISP3B			;;
SDISP2B:				;;
	CP0 R1				;;
	BRA NZ,DISP2B			;;
	BRA DISP1B			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
DISP7B:					;;
	MOV R6,W0			;;
	CALL ENNUM			;;
DISP6B:					;;
	MOV R5,W0			;;
	CALL ENNUM			;;
DISP5B:					;;
	MOV R4,W0			;;
	CALL ENNUM			;;
DISP4B:					;;
	MOV R3,W0			;;
	CALL ENNUM			;;
DISP3B:					;;
	MOV R2,W0			;;
	CALL ENNUM			;;
DISP2B:					;;
	MOV R1,W0			;;
	CALL ENNUM			;;
DISP1B:					;;
	MOV R0,W0			;;
	CALL ENNUM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

DISP2H:
	PUSH W0
	SWAP W0
	AND #15,W0
	CALL ENNUM
	POP W0
	AND #15,W0
	CALL ENNUM
	RETURN
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NS_STR:					;;
	.ASCII "ns\0"			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MS_STR:					;;
	.ASCII "ms\0"			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
US_STR:					;;
	.ASCII "us\0"			;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BLY_STR:				;;
	.ASCII "BL\0"		;;
BLN_STR:				;;
	.ASCII "  \0"		;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PPS_STR:				;;
	.ASCII "PPS: \0"		;;
GPS_STR:				;;
	.ASCII "GPS: \0"		;;
GPS_STATUS_STBL:			;;	
	.WORD tbloffset(STANDBY_STR)	;;
	.WORD tbloffset(NORMAL_STR)	;;
	.WORD tbloffset(SEARCH_STR)	;;	
	.WORD tbloffset(CALIBRATION_STR);;	
CALIBRATION_STR:			;;
	.ASCII "CALIBRATE WAIT  \0"	;;	
STANDBY_STR:				;;
	.ASCII "BOOTING.........\0"	;;	
NORMAL_STR:				;;
	.ASCII "NORMAL OPERATION\0"	;;	
SEARCH_STR:				;;
	.ASCII "ANTTNNA FAULT\0"	;;
NTP_OFFS_STR:				;;
	.ASCII "NTP Offs. \0"           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_MAINST:				;;
	LOXY 0,0			;;
	LOFFS1 GPS_STR			;;
	CALL ENSTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #1,W0			;;
	CP SATE_GOOD			;;
	BRA GEU,$+6			;;
	MOV #2,W2			;;	
	BRA HHUU			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #3,W2			;;
	CP0 GPS_STATUS_CNT		;;
	BRA Z,$+4			;;
	MOV #1,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HHUU:					;;
	BTFSS SYSTIME_LOAD_F		;;
	MOV #0,W2			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,W0			;;
	LOFFS1 GPS_STATUS_STBL	 	;;
	CALL GET_TBL			;;
	CALL ENSTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #260,W0
	CP VR1V
	BRA GEU,DM_1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOXY 23,0			;;
	LOFFS1 BLY_STR			;;
	CALL ENSTR			;;
	BRA DM_2
DM_1:					;;
	LOXY 23,0			;;
	LOFFS1 BLN_STR			;;
	CALL ENSTR			;;
	BRA DM_2
DM_2:
	LOXY 26,0			;;
	MOV #DATES_BUF,W1		;;		
	BTFSC SYSTIME_LOAD_F		;;
	CALL ENRAM			;;
	LOXY 0,1			;;
	LOFFS1 NTP_OFFS_STR		;;
	CALL ENSTR			;;
	LOFFS1 PPS_STR			;;
	CALL ENSTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV NTP_OFFS,W0			;;
	CP0 W0				;;
	BRA NZ,DISP_MAINST_0		;;
	;CP0 NTP_JITTER			;;
	;BRA NZ,DISP_MAINST_0		;;
	MOV #0x8000,W0			;;	
DISP_MAINST_0:				;;
	CALL DISP_MS			;;
	MOV #' ',W0			;;
	CALL ENCHR			;;
	MOV NTP_JITTER,W0		;;
	CP W0,#0			;;
	BRA Z,DISP_MAINST_0_NS		;;
	CP W0,#1			;;
	BRA Z,DISP_MAINST_0_US		;;
	BRA DISP_MAINST_0_MS		;;
DISP_MAINST_0_NS:			;;
	LOFFS1 NS_STR			;;
	CALL ENSTR			;;
	BRA DISP_MAINST_00
DISP_MAINST_0_US:			;;
	LOFFS1 US_STR			;;
	CALL ENSTR			;;
	BRA DISP_MAINST_00
DISP_MAINST_0_MS:			;;
	LOFFS1 MS_STR			;;
	CALL ENSTR			;;
	BRA DISP_MAINST_00
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_MAINST_00:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #',',W0			;;
	;CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;LOFFS1 PPS_STR			;;
	;CALL ENSTR			;;
	;MOV NTP_JITTER,W0		;;
	;CALL DISP_MS			;;
	;MOV #' ',W0			;;
	;CALL ENCHR			;;
	;LOFFS1 US_STR			;;
	;CALL ENSTR			;;
DISP_MAINST_1:

	LOXY 26,1			;;
	MOV #TIMES_BUF,W1		;;		
	BTFSC SYSTIME_LOAD_F		;;
	CALL ENRAM			;;
	RETURN				;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NTPSYNC_STR:				
	.ASCII "NTPSync: NTP 4.2.8p10\0"		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSLOG_STR:				
	.ASCII "GPSLog: Thunderbolt-e\0"		
SN_STR:				
	.ASCII "SN: 103JS0105P08\0"		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_NTPINF:				;;
	LOXY 0,0			;;
	LOFFS1 NTPSYNC_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 GPSLOG_STR		;;
	CALL ENSTR			;;
	INC2 W8,W8			;;
	LOFFS1 SN_STR			;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




RECEIVER_STR:				
	.ASCII "RECEIVER\0"		
LAT_STR:				
	.ASCII "LAT: \0"		
LON_STR:				
	.ASCII "LON: \0"		



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLOC0E:				;;		
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;
	POP W1				;;
	CHKSH 4				;;	
	CALL DISP3B			;;
	MOV #1,W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_2B			;;
	POP W1				;;
	CHKSH 5				;;	
	CALL DISP2B			;;
	MOV #'\'',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_2B			;;
	POP W1				;;
	CHKSH 6				;;	
	CALL DISP2B			;;
	MOV #'\"',W0			;;
	CALL ENCHR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLOC0N:				;;		
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_2B			;;
	POP W1				;;
	CHKSH 1				
	CALL DISP2B			;;
	MOV #1,W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_2B			;;
	POP W1				;;
	CHKSH 2				
	CALL DISP2B			;;
	MOV #'\'',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_2B			;;
	POP W1				;;
	CHKSH 3				
	CALL DISP2B			;;
	MOV #'\"',W0			;;
	CALL ENCHR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SHIFT:				;;
	CP SHIFT_CNT			;;
	BRA Z,$+4			;;
	RETURN 				;;
	BTFSS FLASH_LCD_F		;;
	RETURN				;;
	BTFSC DIS_FLASH_F		;;
	RETURN				;;
	MOV #18,W0			;;
	MOV W0,R3			;;
	MOV W0,R2			;;
	MOV W0,R1			;;
	MOV W0,R0			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLOC1:				;;				
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;
	POP W1				;;
	CALL SDISP3B			;;
	MOV #'.',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV #60,W2			;;
	MUL.UU W0,W2,W2			;;
	MOV [W1++],W0			;;
	ADD W0,W2,W2			;;
	MOV W2,W4			;;
	ADD W2,W4,W4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #7,W0			;;
	MUL.UU W0,W2,W2			;;
	MOV W2,W0			;;
	MOV #9,W2			;;	
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	ADD W0,W4,W0			;;
	CALL L1D_4B			;;
	CALL DISP4B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLOC2:				;;				
	MOV [W1],W0			;;
	SWAP W0				;;
	SWAP.B W0			;;
	AND #15,W0			;;
	BRA Z,DISPLOC2_1		;;			
	MOV #'-',W0			;;
	CALL ENCHR			;;
DISPLOC2_1:				;;
	MOV [W1],W0			;;
	SWAP W0				;;
	AND #15,W0			;;
	MOV W0,R6			;;
	MOV [W1],W0			;;
	SWAP.B W0			;;
	AND #15,W0			;;
	MOV W0,R5			;;
	MOV [W1],W0			;;
	AND #15,W0			;;
	MOV W0,R4			;;
	INC2 W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W0			;;
	SWAP W0				;;
	SWAP.B W0			;;
	AND #15,W0			;;
	MOV W0,R3			;;
	MOV [W1],W0			;;
	SWAP W0				;;
	AND #15,W0			;;
	MOV W0,R2			;;
	MOV [W1],W0			;;
	SWAP.B W0			;;
	AND #15,W0			;;
	MOV W0,R1			;;
	MOV [W1],W0			;;
	AND #15,W0			;;
	MOV W0,R0			;;
	CALL SDISP7B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_GPSLOC0:				;;
	LOXY 5,0			;;
	LOFFS1 RECEIVER_STR		;;
	CALL ENSTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOXY 0,1			;;
	LOFFS1 LAT_STR			;;
	CALL ENSTR			;;
	MOV #LATBUF,W1			;;
	CALL DISPLOC0N			;;
	MOV #'N',W0			
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOXY 20,1			;;
	LOFFS1 LON_STR			;;
	CALL ENSTR			;;
	MOV #LONBUF,W1			;;					
	CALL DISPLOC0E			;;
	MOV #'E',W0			;;
	CALL ENCHR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_GPSLOC1:				;;
	LOXY 5,0			;;
	LOFFS1 RECEIVER_STR		;;
	CALL ENSTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOXY 0,1			;;
	LOFFS1 LAT_STR			;;
	CALL ENSTR			;;
	MOV #LATDPD,W3			;;
	MOV [W3++],W1			;;
	MOV [W3++],W0			;;
	CALL L2D_5B			;;
	CALL SDISP3B			;;
	MOV #'.',W0			;;
	CALL ENCHR			;;
	MOV #LATDPD+4,W3		;;
	MOV [W3++],W1			;;
	MOV [W3++],W0			;;
	CALL L2D_5B			;;
	CALL DISP5B			;;
	MOV #'N',W0			
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	LOXY 20,1			;;
	LOFFS1 LON_STR			;;
	CALL ENSTR			;;
	MOV #LONDPD,W3			;;
	MOV [W3++],W1			;;
	MOV [W3++],W0			;;
	CALL L2D_5B			;;
	CALL SDISP3B			;;
	MOV #'.',W0			;;
	CALL ENCHR			;;
	MOV #LONDPD+4,W3		;;
	MOV [W3++],W1			;;
	MOV [W3++],W0			;;
	CALL L2D_5B			;;
	CALL DISP5B			;;
	MOV #'E',W0			;;
	CALL ENCHR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_GPSLOC2:				;;
	LOXY 5,0			;;
	LOFFS1 RECEIVER_STR		;;
	CALL ENSTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOXY 0,1			;;
	MOV #'X',W0			;;
	CALL ENCHR			;;
	MOV #':',W0			;;
	CALL ENCHR			;;
	MOV #GPSX_BUF,W1		;;
	CALL DISPLOC2			;;
	MOV #'m',W0			;;
	CALL ENCHR			;;
	MOV #' ',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #'Y',W0			;;
	CALL ENCHR			;;
	MOV #':',W0			;;
	CALL ENCHR			;;
	MOV #GPSY_BUF,W1		;;
	CALL DISPLOC2			;;
	MOV #'m',W0			;;
	CALL ENCHR			;;
	MOV #' ',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #'Z',W0			;;
	CALL ENCHR			;;
	MOV #':',W0			;;
	CALL ENCHR			;;
	MOV #GPSZ_BUF,W1		;;
	CALL DISPLOC2			;;
	MOV #'m',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SATELLITE_STR:
	.ASCII "SATELLITE\0"		
INVIEW_STR:
	.ASCII "In view: \0"		
GOOD_STR:
	.ASCII "GOOD: \0"		
SEL_STR:
	.ASCII "SEL: \0"		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SATE:				;;
	LOXY 5,0			;;
	LOFFS1 SATELLITE_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 INVIEW_STR		;;
	CALL ENSTR			;;
	MOV SATE_INVIEW,W0		;;
	CALL L1D_2B			;;
	CALL SDISP2B			;;
	INC2 W8,W8			;;
	INC2 W8,W8			;;
	LOFFS1 GOOD_STR			;;
	CALL ENSTR			;;
	MOV SATE_GOOD,W0		;;
	CALL L1D_2B			;;
	CALL SDISP2B			;;
	INC2 W8,W8			;;
	INC2 W8,W8			;;
	LOFFS1 SEL_STR			;;
	CALL ENSTR			;;
	MOV SATE_SEL_AMT,W0		;;
	AND #7,W0
	BRA W0
	BRA DISP_SATE_J0
	BRA DISP_SATE_J1
	BRA DISP_SATE_J2
	BRA DISP_SATE_J3
	BRA DISP_SATE_J4
	BRA DISP_SATE_J0
	BRA DISP_SATE_J0
	BRA DISP_SATE_J0
	


DISP_SATE_J0:				;;
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SATE_J1:				;;
	MOV #SATE_SELBUF,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SATE_J2:				;;
	MOV #SATE_SELBUF,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	INC2 W8,W8			;;
	MOV #SATE_SELBUF+2,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SATE_J3:				;;
	MOV #SATE_SELBUF,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	INC2 W8,W8			;;
	MOV #SATE_SELBUF+2,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	INC2 W8,W8			;;
	MOV #SATE_SELBUF+4,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
DISP_SATE_J4:
	MOV #SATE_SELBUF,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	INC2 W8,W8			;;
	MOV #SATE_SELBUF+2,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	INC2 W8,W8			;;
	MOV #SATE_SELBUF+4,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	INC2 W8,W8			;;
	MOV #SATE_SELBUF+6,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CALL DISP2B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DOP:				;;
	MOV [W1++],W0			;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CALL SDISP3B			;;
	MOV #'.',W0			;;
	CALL ENCHR			;;
	POP W1				;;
	MOV [W1++],W0			;;
	CALL L1D_3B			;;
	MOV R2,W0			;;	
	CALL ENNUM			;;
	MOV R1,W0			;;	
	CALL ENNUM			;;
	MOV R0,W0			;;	
	CALL ENNUM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DILLUTION_STR:				;;			
	.ASCII "DILLUTION OF\0"		;;
PDOP_STR:				;;
	.ASCII "PDOP: \0"		;;
HDOP_STR:				;;
	.ASCII "HDOP: \0"		;;
VDOP_STR:				;;
	.ASCII "VDOP: \0"		;;
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_GPSDOP:				;;
	LOXY 0,0			;;
	LOFFS1 DILLUTION_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 PDOP_STR			;;
	CALL ENSTR			;;
	MOV #GPS_PDOP,W1		;;
	CALL DISP_DOP			;;
	INC2 W8,W8			;;
	INC2 W8,W8			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 HDOP_STR			;;
	CALL ENSTR			;;
	MOV #GPS_HDOP,W1		;;
	CALL DISP_DOP			;;
	INC2 W8,W8			;;
	INC2 W8,W8			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 VDOP_STR			;;
	CALL ENSTR			;;
	MOV #GPS_VDOP,W1		;;
	CALL DISP_DOP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_P1DU:				;;
	CALL L1D_4B			;;
	MOVFF R0,R4			
	MOVFF R1,R0			
	MOVFF R2,R1			
	MOVFF R3,R2			
	CALL SDISP3B					
	WLCDC '.'	
	MOV R4,W0
	CALL DISP1B			;;
	WLCDC 1
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EL_STR:					;;
	.ASCII "EL: \0"		;;
AZ_STR:					;;
	.ASCII "AZ: \0"		;;
DIST_STR:					;;
	.ASCII "Dist: \0"		;;
DOPP_STR:					;;
	.ASCII "Dopp: \0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_NTPGPS:				;;
	LOXY 0,0			;;
	LOFFS1 SATELLITE_STR		;;
	CALL ENSTR			;;
	INC2 W8,W8			;;
	MOV NTPGPS_NO,W0		;;
	CALL L1D_2B			;;
	CALL SDISP2B			;;
	INC2 W8,W8			;;
	INC2 W8,W8			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 EL_STR			;;
	CALL ENSTR			;;
	MOV NTPGPS_EL,W0		;;
	CALL DISP_P1DU			
	INC2 W8,W8			;;
	INC2 W8,W8			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 AZ_STR			;;
	CALL ENSTR			;;
	MOV NTPGPS_AZ,W0		;;
	CALL DISP_P1DU			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;LOXY 0,1			;;
	;LOFFS1 DIST_STR			;;
	;CALL ENSTR			;;
	;MOV NTPGPS_DIST,W0		;;
	;CALL L1D_5B			;;
	;CALL SDISP5B			;;
	;WLCDC 'k'			;;
	;WLCDC 'm'			;;
	;INC2 W8,W8			;;
	;INC2 W8,W8			;;
	;LOFFS1 DOPP_STR			;;
	;CALL ENSTR			;;
	;MOV NTPGPS_DOPP1,W0		;;
	;CALL DISP_MS			;;
	;WLCDC '.'			;;
	;MOV NTPGPS_DOPP0,W0		;;
	;CALL L1D_3B			;;
	;CALL DISP3B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

SETLAN_STR:					;;
	.ASCII "SETUP: LAN\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SETLAN:				;;
	LOXY 0,0			;;
	LOFFS1 SETLAN_STR		;;
	CALL ENSTR	
	RETURN	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_NETADR:				;;	
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CHKSH 1
	CALL SDISP3B			;;
	WLCDC '.'			;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CHKSH 2
	CALL SDISP3B			;;
	WLCDC '.'			;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CHKSH 3
	CALL SDISP3B			;;
	WLCDC '.'			;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CHKSH 4				;;
	CALL SDISP3B			;;
	POP W1				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SET_NETADR:			;;	
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CHKSH 1
	CALL DISP3B			;;
	WLCDC '.'			;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CHKSH 2
	CALL DISP3B			;;
	WLCDC '.'			;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CHKSH 3
	CALL DISP3B			;;
	WLCDC '.'			;;
	POP W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	PUSH W1				;;
	CALL L1D_3B			;;	
	CHKSH 4				;;
	CALL DISP3B			;;
	POP W1				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NETMASK_STR:				;;
	.ASCII "NETMASK\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_NETMASK:				;;
	LOXY 0,0			;;
	LOFFS1 NETMASK_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	MOV #NETMASK_BUF,W1		;;
	CALL DISP_NETADR		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KEYFUNC2_STR:
	.ASCII "ACK -> SAVE , MENU -> CANCEL\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NETMASK1_STR:				;;
	.ASCII "NETMASK: \0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SET_NETMASK:			;;
	LOXY 0,0			;;
	LOFFS1 NETMASK1_STR		;;
	CALL ENSTR			;;
	MOV #NETMASK_BUF,W1		;;
	CALL DISP_SET_NETADR		;;
	LOXY 0,1			;;
	LOFFS1 KEYFUNC2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GATEWAY_STR:				;;
	.ASCII "DEFAULT GATEWAY\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_GATEWAY:				;;
	LOXY 0,0			;;
	LOFFS1 GATEWAY_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	MOV #GATEWAY_BUF,W1		;;
	CALL DISP_NETADR		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GATEWAY1_STR:				;;
	.ASCII "DEFAULT GATEWAY: \0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SET_GATEWAY:			;;
	LOXY 0,0			;;
	LOFFS1 GATEWAY1_STR		;;
	CALL ENSTR			;;
	MOV #GATEWAY_BUF,W1		;;
	CALL DISP_SET_NETADR		;;
	LOXY 0,1			;;
	LOFFS1 KEYFUNC2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TCPIP_STR:				;;
	.ASCII "TCP/IP ADDRESS\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_TCPIP:				;;
	LOXY 0,0			;;
	LOFFS1 TCPIP_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	MOV #TCPIP_BUF,W1		;;
	CALL DISP_NETADR		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TCPIP1_STR:				;;
	.ASCII "TCP/IP ADDRESS: \0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SET_TCPIP:				;;
	LOXY 0,0			;;
	LOFFS1 TCPIP1_STR		;;
	CALL ENSTR			;;
	MOV #TCPIP_BUF,W1		;;
	CALL DISP_SET_NETADR		;;
	LOXY 0,1			;;
	LOFFS1 KEYFUNC2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HOSTNAME_STR:				;;
	.ASCII "HOSTNAME\0"		;;
TIMESERVER_STR:				;;
	.ASCII "timeserver\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_HOSTNAME:				;;
	LOXY 0,0			;;
	LOFFS1 HOSTNAME_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 TIMESERVER_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DOMAIN_STR:				;;
	.ASCII "DOMAIN NAME\0"		;;
DOMAIN_COM_STR:				;;
	.ASCII "domain.com\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DOMAIN:				;;
	LOXY 0,0			;;
	LOFFS1 DOMAIN_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 DOMAIN_COM_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NAMESERVER_STR:				;;
	.ASCII "NAME SERVER\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_NAMESERVER:			;;
	LOXY 0,0			;;
	LOFFS1 NAMESERVER_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	MOV #NAMESERVER_BUF,W1		;;
	CALL DISP_NETADR		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RNC_STR:				
	.ASCII "Remote Network Connection\0"		;;
DISABLE_STR:				
	.ASCII "Disabled\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_RNC:				;;
	LOXY 0,0			;;
	LOFFS1 RNC_STR			;;
	CALL ENSTR			;;
	LOXY 5,1			;;
	LOFFS1 DISABLE_STR			;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SYSLOG_STR:				;;
	.ASCII "SYSLOG SERVER\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SYSLOG:			;;
	LOXY 0,0			;;
	LOFFS1 SYSLOG_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	MOV #SYSLOG_BUF,W1		;;
	CALL DISP_NETADR		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RESET_STR:				;;
	.ASCII "Reset Factory Settings\0"		
KEYFUNC1_STR:				;;
	.ASCII "INC -> YES , MENU -> NO\0"		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_RESET:			;;
	LOXY 0,0			;;
	LOFFS1 RESET_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 KEYFUNC1_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NLM_STR:				
	.ASCII "Netcard Link Mode/Speed\0"		;;
AUTOSENSE_STR:				
	.ASCII "Autosensing\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_NLM:				;;
	LOXY 0,0			;;
	LOFFS1 NLM_STR			;;
	CALL ENSTR			;;
	LOXY 5,1			;;
	LOFFS1 AUTOSENSE_STR			;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DAYLIGHT_OFF_STR:				
	.ASCII "DAYLIGHT SAVING OFF: {MEZ}\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DAYLIGHT_ON_STR:				
	.ASCII "DAYLIGHT SAVING ON: {MESZ}\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DAYLIGHT:				;;
	LOXY 0,0			;;
	LOFFS1 DAYLIGHT_OFF_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 DAYLIGHT_ON_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DAYLIGHT_S_STR:				
	.ASCII "SETUP: DAYLIGHT SAV\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DAYLIGHT_S:				;;
	LOXY 0,0			;;
	LOFFS1 DAYLIGHT_S_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DAYLIGHT_EN1_STR:				
	.ASCII "DAYLIGHT SAV ON: Date:\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DAYLIGHT_EN2_STR:				
	.ASCII "Day of Week: Sun Time:\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DAYLIGHT_EN:				;;
	LOXY 0,0			;;
	LOFFS1 DAYLIGHT_EN1_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 DAYLIGHT_EN2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DAYLIGHT_US_STR:				
	.ASCII "SETUP: DAYLIGHT UNSAV\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DAYLIGHT_US:				;;
	LOXY 0,0			;;
	LOFFS1 DAYLIGHT_US_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DAYLIGHT_DIS1_STR:				
	.ASCII "DAYLIGHT SAV OFF: Date:\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DAYLIGHT_DIS2_STR:				
	.ASCII "Day of Week: Sun Time:\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DAYLIGHT_DIS:				;;
	LOXY 0,0			;;
	LOFFS1 DAYLIGHT_DIS1_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 DAYLIGHT_DIS2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETSER_STR:				
	.ASCII "SETUP: SERIAL PORT\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SETSER:				;;
	LOXY 0,0			;;
	LOFFS1 SETSER_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SERPORT1_STR:				
	.ASCII "SERIAL PORT\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SERPORT2_STR:				
	.ASCII "PARM: 9600  8N1  MODE: PER\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SERPORT:			;;
	LOXY 5,0			;;
	LOFFS1 SERPORT1_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 SERPORT2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETSTRING_STR:				
	.ASCII "SETUP: STRING TYPE\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SETSTRING:				;;
	LOXY 0,0			;;
	LOFFS1 SETSTRING_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STRINGTYPE1_STR:				
	.ASCII "STRING TYPE\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STRINGTYPE2_STR:				
	.ASCII "STRING TYPE: ASCII\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_STRINGTYPE:			;;
	LOXY 5,0			;;
	LOFFS1 STRINGTYPE1_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 STRINGTYPE2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETINITIAL_STR:				
	.ASCII "SETUP: INITIAL LOCATION\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SETINITIAL:			;;
	LOXY 0,0			;;
	LOFFS1 SETINITIAL_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INITIALLOC1_STR:				
	.ASCII "INITIAL LOCATION\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_INITIALLOC:				;;
	LOXY 5,0			;;
	LOFFS1 INITIALLOC1_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 LAT_STR			;;
	CALL ENSTR			;;
	MOV #LOCLAT_BUF,W1		;;
	CALL DISPLOC0N			;;
	MOV #'N',W0			
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOXY 20,1			;;
	LOFFS1 LON_STR			;;
	CALL ENSTR			;;
	MOV #LOCLON_BUF,W1		;;					
	CALL DISPLOC0E			;;
	MOV #'E',W0			;;
	CALL ENCHR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETSTIME_STR:				;;	
	.ASCII "SETUP: TIME\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SETSTIME:				;;
	LOXY 0,0			;;
	LOFFS1 SETSTIME_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETTIME_STR:				;;	
	.ASCII "SETUP: SET TIME\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SETTIME:				;;
	LOXY 0,0			;;
	LOFFS1 SETTIME_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHGTIME_STR:				;;	
	.ASCII "SET TIME\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DATE:				;;
	MOV #DATE_BUF,W1		;;
	MOV [W1],W0			;;
	CP0 W0				;;
	BRA NZ,$+6			;;
	INC [W1],[W1]			;;
	INC W0,W0			;;
	CALL L1D_2B			;;
	CHKSH 1				;;	
	CALL DISP2B			;;
	WLCDC '.' 			;;
	MOV #DATE_BUF+2,W1		;;
	MOV [W1],W0			;;
	CP0 W0				;;
	BRA NZ,$+6			;;
	INC [W1],[W1]			;;
	INC W0,W0			;;
	CALL L1D_2B			;;
	CHKSH 2				;;	
	CALL DISP2B			;;
	WLCDC '.' 			;;
	MOV #DATE_BUF+4,W1		;;
	MOV [W1],W0			;;
	CALL L1D_4B			;;
	CHKSH 3				;;	
	CALL DISP4B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_TIME:				;;
	MOV #TIME_BUF,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CHKSH 4				;;	
	CALL DISP2B			;;
	WLCDC ':' 			;;
	MOV #TIME_BUF+2,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CHKSH 5				;;	
	CALL DISP2B			;;
	WLCDC ':' 			;;
	MOV #TIME_BUF+4,W1		;;
	MOV [W1],W0			;;
	CALL L1D_2B			;;
	CHKSH 6				;;	
	CALL DISP2B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATE_STR:				;;	
	.ASCII "DATE: \0"		;;
TIME_STR:				;;	
	.ASCII "TIME: \0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_CHGTIME:				;;
	LOXY 5,0			;;
	LOFFS1 CHGTIME_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 DATE_STR			;;
	CALL ENSTR			;;
	CALL DISP_DATE			;;
	LOXY 20,1			;;
	LOFFS1 TIME_STR			;;
	CALL ENSTR			;;
	CALL DISP_TIME			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_IGNORE_STR:				;;	
	.ASCII "SETUP: IGNORE\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SET_IGNORE:			;;
	LOXY 0,0			;;
	LOFFS1 SET_IGNORE_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IGNORE_STR:				;;	
	.ASCII "IGNORE\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_IGNORE:				;;
	LOXY 0,0			;;
	LOFFS1 IGNORE_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_COLDBOOT_STR:			;;	
	.ASCII "SETUP: INITIATE COLD\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SET_COLDBOOT:			;;
	LOXY 0,0			;;
	LOFFS1 SET_COLDBOOT_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COLDBOOT_STR:				;;	
	.ASCII "Are you sure?   Press\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_COLDBOOT:				;;
	LOXY 0,0			;;
	LOFFS1 COLDBOOT_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 KEYFUNC1_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_WARMBOOT_STR:			;;	
	.ASCII "SETUP: INITIATE WARM\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SET_WARMBOOT:			;;
	LOXY 0,0			;;
	LOFFS1 SET_WARMBOOT_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WARMBOOT_STR:				;;	
	.ASCII "Are you sure?   Press\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_WARMBOOT:				;;
	LOXY 0,0			;;
	LOFFS1 WARMBOOT_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 KEYFUNC1_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_ANTENNA_STR:			;;	
	.ASCII "SETUP: ANTENNA\0"	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_SET_ANTENNA:			;;
	LOXY 0,0			;;
	LOFFS1 SET_ANTENNA_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ANTENNA1_STR:				;;	
	.ASCII "ANTENNA\0"		;;
ANTENNA2_STR:				;;	
	.ASCII "LENGTH: 20\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_ANTENNA:				;;
	LOXY 5,0			;;
	LOFFS1 ANTENNA1_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 ANTENNA2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERRINF1_STR:				;;	
	.ASCII "Error Info (0x00 = no error)\0"		;;
ERRINF2_STR:				;;	
	.ASCII "Pos: 0x00 Time: 0x00 Net: 0x00\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_ERRINF:				;;
	LOXY 5,0			;;
	LOFFS1 ERRINF1_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 ERRINF2_STR		;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NTPPRO_STR:				;;			
	.ASCII "NTP 3.0\0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HWADDR_STR:				;;			
	.ASCII "HWAddr: \0"		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_NTPPRO:				;;
	LOXY 0,0			;;
	LOFFS1 NTPPRO_STR		;;
	CALL ENSTR			;;
	LOXY 0,1			;;
	LOFFS1 HWADDR_STR		;;
	CALL ENSTR			;;
	MOV #HWADDR_BUF,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	CALL DISP2H			;; 
	MOV #':',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	CALL DISP2H			;; 
	MOV #':',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	CALL DISP2H			;; 
	MOV #':',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	CALL DISP2H			;; 
	MOV #':',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	CALL DISP2H			;; 
	MOV #':',W0			;;
	CALL ENCHR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	CALL DISP2H			;; 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLAY:				;;
	BTFSS T10M_F			;;
	BRA DISPLAY_1			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC SPISET_TIM			;;
	CP0 SPISET_TIM			;;
	BRA NZ,$+4			;;
	DEC SPISET_TIM			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #200,W0			;;
	CP SPISET_TIM			;;
	BRA LTU,DISPLAY_1		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF EDIT_NETADDR_F		;;	 
	BCF EDIT_SYSTIME_F		;;	 
DISPLAY_1:				;;
	MOV #49,W0			;;
	CP LCDPG_CNT			;;
	BRA LTU,$+4			;;
	CLR LCDPG_CNT			;;
	MOV LCDPG_CNT,W0		;;
	BRA W0				;;
	BRA LCDPG_J00			;;
	BRA LCDPG_J01			;;
	BRA LCDPG_J02			;;
	BRA LCDPG_J03			;;
	BRA LCDPG_J04			;;
	BRA LCDPG_J05			;;
	BRA LCDPG_J06			;;
	BRA LCDPG_J07			;;
	BRA LCDPG_J08			;;
	BRA LCDPG_J09			;;
	BRA LCDPG_J10			;;
	BRA LCDPG_J11			;;
	BRA LCDPG_J12			;;
	BRA LCDPG_J13			;;
	BRA LCDPG_J14			;;
	BRA LCDPG_J15			;;
	BRA LCDPG_J16			;;
	BRA LCDPG_J17			;;
	BRA LCDPG_J18			;;
	BRA LCDPG_J19			;;
	BRA LCDPG_J20			;;
	BRA LCDPG_J21			;;
	BRA LCDPG_J22			;;
	BRA LCDPG_J23			;;
	BRA LCDPG_J24			;;
	BRA LCDPG_J25			;;
	BRA LCDPG_J26			;;
	BRA LCDPG_J27			;;
	BRA LCDPG_J28			;;
	BRA LCDPG_J29			;;
	BRA LCDPG_J30			;;
	BRA LCDPG_J31			;;
	BRA LCDPG_J32			;;
	BRA LCDPG_J33			;;
	BRA LCDPG_J34			;;
	BRA LCDPG_J35			;;
	BRA LCDPG_J36			;;
	BRA LCDPG_J37			;;
	BRA LCDPG_J38			;;
	BRA LCDPG_J39			;;
	BRA LCDPG_J40			;;
	BRA LCDPG_J41			;;
	BRA LCDPG_J42			;;
	BRA LCDPG_J43			;;
	BRA LCDPG_J44			;;
	BRA LCDPG_J45			;;
	BRA LCDPG_J46			;;
	BRA LCDPG_J47			;;
	BRA LCDPG_J48			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J00:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_MAINST		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J01:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_NTPINF		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J02:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_NTPPRO		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J03:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_GPSLOC0		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J04:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_GPSLOC1		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;x = R * cos(lat) * cos(lon)		;;
;y = R * cos(lat) * sin(lon)		;;
;z = R *sin(lat)			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J05:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_GPSLOC2		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J06:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SATE			;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J07:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_GPSDOP		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J08:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_NTPGPS		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J09:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SETLAN		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J10:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_NETMASK		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J11:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_GATEWAY		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J12:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_TCPIP			;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J13:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_HOSTNAME		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J14:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_DOMAIN		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J15:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_NAMESERVER		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J16:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_RNC			;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J17:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SYSLOG		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J18:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_RESET			;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J19:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_NLM			;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J20:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SETSTIME		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J21:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_DAYLIGHT		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J22:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_DAYLIGHT_S		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J23:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_DAYLIGHT_EN		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J24:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_DAYLIGHT_US		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J25:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_DAYLIGHT_DIS		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J26:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SETSER		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J27:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SERPORT		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J28:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SETSTRING		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J29:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_STRINGTYPE		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J30:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SETINITIAL		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J31:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_INITIALLOC		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J32:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SETTIME		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J33:				;;
	CP0 SHIFT_CNT
	BRA Z,$+6
	BSF EDIT_SYSTIME_F		;;	 
        CLR SPISET_TIM
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_CHGTIME		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J34:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SET_IGNORE		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J35:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_IGNORE		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J36:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SET_COLDBOOT		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J37:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_COLDBOOT		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J38:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SET_WARMBOOT		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J39:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_WARMBOOT		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J40:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SET_ANTENNA		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J41:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_ANTENNA		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J42:				;;
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_ERRINF		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J43:				;;
	CP0 SHIFT_CNT
	BRA Z,$+6
	BSF EDIT_NETADDR_F		;;	 
        CLR SPISET_TIM
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SET_NETMASK		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J44:				;;
	CP0 SHIFT_CNT
	BRA Z,$+6
	BSF EDIT_NETADDR_F		;;	 
        CLR SPISET_TIM
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SET_GATEWAY		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J45:				;;
	CP0 SHIFT_CNT
	BRA Z,$+6
	BSF EDIT_NETADDR_F		;;	 
        CLR SPISET_TIM
	CALL CLR_LCDBUF			;;
	BTFSS DISP_PG_F			;;			
	CALL DISP_SET_TCPIP		;;
	BTFSC DISP_PG_F			;;			
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J46:				;;
	CALL CLR_LCDBUF			;;
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J47:				;;
	CALL CLR_LCDBUF			;;
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCDPG_J48:				;;
	CALL CLR_LCDBUF			;;
	CALL DISP_PG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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


PAGE_STR:
	.ASCII "Page: \0"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_PG:				;;
	LOXY 0,0			;;
	LOFFS1 PAGE_STR			;;
	CALL ENSTR			;;
	MOV LCDPG_CNT,W0		;;
	INC W0,W0			;;
	CALL L1D_2B			;;
	MOV R1,W0			;;
	CALL ENNUM			;;
	MOV R0,W0			;;
	CALL ENNUM			;;
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
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	CLR KEYFP			;;
	CLR KEYFR			;;
	CLR KEYFC			;;
	BTFSS T2P6M_F			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR R0				;;
	BTFSS KEY1_I			;;
	BSET R0,#0			;;
	BTFSS KEY2_I			;;
	BSET R0,#1			;;
	BTFSS KEY3_I			;;
	BSET R0,#2			;;
	BTFSS KEY4_I			;;
	BSET R0,#3			;;
	BTFSS KEY5_I			;;
	BSET R0,#4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP0 R0				;;
	BRA NZ,KEYBO_1			;;
	CLR YESKEY_CNT			;;
	INC NOKEY_CNT			;;
	MOV #10,W0			;;
	CP NOKEY_CNT			;;
	BRA GEU,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KEYBUF,W0			;;
	BTFSS DISKR_F			;;
	MOV W0,KEYFR			;;
	CLR KEYBUF			;;
	BCF DISKR_F			;;
	BCF DISKC_F			;;
	BCF DISKP_F			;;
	CLR KEYCON_CNT			;;
	BCF KEY_PUSH_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC DIS_FLASH_TIM		;;
	MOV #200,W0			;;	
	CP DIS_FLASH_TIM		;;
	BRA LTU,$+4			;;
	BCF DIS_FLASH_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO_1:				;;
	CLR NOKEY_CNT			;;
	MOV KEYBUF,W0			;;
	CP R0				;;
	BRA Z,KEYBO_2			;;
	INC YESKEY_CNT			;;
	MOV #5,W0			;;
	CP YESKEY_CNT			;;
	BRA GEU,$+4			;;
	RETURN 				;;
	CLR YESKEY_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KEYBUF,W0			;;
	CP R0				;;
	BRA Z,KEYBO_2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV R0,W0			;;
	MOV W0,KEYBUF			;;
	BTFSS DISKP_F			;;
	MOV W0,KEYFP			;;
	BSF KEY_PUSH_F			;;
	RETURN				;;
KEYBO_2:				;;
 	INC KEYCON_CNT			;;
	MOV #500,W0			;;
	CP KEYCON_CNT			;;
	BRA GEU,$+4			;;
	RETURN				;;
	MOV R0,W0			;;
	BTFSS DISKC_F			;;
	MOV W0,KEYFC			;; 
	MOV #0,W0			;;
	MOV W0,KEYCON_CNT		;;	
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
	BTFSC T160M_F			;;
	INC TMR2H_BUF			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_TPRG:				;;
	BTFSC T5P2M_F			;;
	INC FLASH_LCD_TIM		;;
	MOV #50,W0			;;
	CP FLASH_LCD_TIM		;;  
	BRA LTU,$+6			;;
	CLR FLASH_LCD_TIM		;;
	TG FLASH_LCD_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSC T80M_F			;;
	CALL CONVERT_AD


	BTFSS PGRET_F			;;
	BRA MAIN_TPRG_1			;;
	BTFSC T80M_F			;;
	INC PGRET_TIM			;;	
	MOV #16,W0			;;
	CP PGRET_TIM			;;
	BRA LTU,MAIN_TPRG_1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF PGRET_CNT,LCDPG_CNT	;;	
	BCF PGRET_F			;;
MAIN_TPRG_1:				;;
	BTFSS T10M_F			;;
	BRA MAIN_TPRG_2			;;
	INC SPINORX_TIM			;;
	MOV #400,W0			;;
	CP SPINORX_TIM			;;
	BRA LTU,$+4			;;
	NOP
	;CLR GPS_STATUS_CNT		;;<<debug
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC SYSTIME_CNT			;;
	CP0 SYSTIME_CNT			;;
	BRA NZ,$+4			;;
	DEC SYSTIME_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC GPSTIME_CNT			;;
	CP0 GPSTIME_CNT			;;
	BRA NZ,$+4			;;
	DEC GPSTIME_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC FAIL_LED_TIM		;;
	CP0 FAIL_LED_TIM		;;
	BRA NZ,$+4			;;
	DEC FAIL_LED_TIM		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #3,W0			;;
	CP SATE_GOOD			;;
	BRA LTU,$+4			;;
	BCF LED1_O			;;
	BRA GEU,$+4			;;
	BSF LED1_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #3,W0			;;
	CP SATE_GOOD			;;
	BRA LTU,$+4			;;
	BSF LED2_O			;;
	BRA GEU,$+4			;;
	BCF LED2_O			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #500,W0			;;
;	CP FAIL_LED_TIM			;;
;	BRA LTU,$+4			;;
;	BCF LED2_O			;;
;	BRA GEU,$+4			;;
;	BSF LED2_O			;;
MAIN_TPRG_2:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER:				;;
	MOV #0xA030,W0			;;/256
	MOV W0,T2CON			;;BASE TIME
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA000,W0			;;	
	MOV W0,T4CON			;;	
	CLR TMR4			;;
	MOVLF 12500,PR4			;;250US	
	MOV #0x0FFF,W0			;;
	AND IPC6			;;
	MOV #0x1000,W0			;;
	IOR IPC6			;;
	BSET IEC1,#T4IE		;	;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







				
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_LCD:                       ;;                                
	BSF LCD_LED_O		;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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




INIT_SIO:			;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BCLR OSCCON,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #24,W0		;;RP40 U1RX
	MOV W0,RPINR18		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR1		;;
	MOV #0x01,W0		;;RP36 U1TX 
	IOR RPOR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR8		;;
	MOV #0x0300,W0		;;RP118 U2TX 
	IOR RPOR8		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;





	MOV #0xFF00,W0		;;
	AND RPINR22		;;
	MOV #37,W0		;;
	IOR RPINR22		;;SPI2 DI 
	;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPINR22		;;
	MOV #39,W0		;;
	SWAP W0			;;
	IOR RPINR22		;;SPI2 DI 
	;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR2		;;
	MOV #0x08,W0		;;SPI2 DO 
	IOR RPOR2		;;RP38
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR23		;;
	MOV #40,W0		;;
	IOR RPINR23		;;SPI2 SS 
	;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #0x00FF,W0		;;
;	AND RPOR8		;;
;	MOV #0x08,W0		;;
;	SWAP W0			;;
;	IOR RPOR8		;;SPI2 DO 
	;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #0xFF00,W0		;;
;	AND RPOR9		;;
;	MOV #0x09,W0		;;
;	IOR RPOR9		;;SPI2 CLK 
	;;;;;;;;;;;;;;;;;;;;;;;;;
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
;	MOV #141,W0	;115200		;;
;	MOV #1705,W0	;9600		;;
;	MOV #108,W0	;115200		;;
	MOV #1303,W0	;9600		;;50M
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
;	MOV #141,W0	;115200		;;
;	MOV #1705,W0	;9600		;;
	MOV #108,W0	;115200		;;
;	MOV #1303,W0	;9600		;;50M
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
	;MOV U2RXREG,W0			;;
	;MOV U2RXREG,W0			;;
	;MOV U2RXREG,W0			;;
	;MOV U2RXREG,W0			;;
	;BCLR IFS1,#U2RXIF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;BCLR IPC2,#14 			;;
	;BCLR IPC2,#13 			;;
	;BSET IPC2,#12 			;;
	;BCLR IFS1,#U2RXIF		;;
	;BSET IEC1,#U2RXIE		;;URXINT
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
INIT_OSC:				;;FRC
	CLR CLKDIV			;;
	MOV #52,W0			;;X*(48+2)/4=50MIPS
	MOV W0,PLLFBD			;;PLLDIV
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;BIT40:PRE	/6
	IOR CLKDIV			;;
	MOV #0x0000,W0			;;BIT76:POST
	IOR CLKDIV			;;
	MOV #0x0000,W0			;;BIT10-8=FRCDIV
	IOR CLKDIV			;;
	MOV #1,W0			;;
	CALL OSC_PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0			;;MAX 31
	;COM W0,W0			;;
	;INC W0,W0			;;
	MOV W0,OSCTUN 
	RETURN	

TEST_U1TX:
	CLRWDT
	MOV #0xAB,W0
	MOV W0,U1TXREG			;;
;	TG U1TX_O
	MOV #10000,W0
	CALL DLYX
	BRA TEST_U1TX



INIT_IO:
	;;PIN1 
	BCF COM_EN_O
	BCF COM_EN_IO
	;;PIN2 
	BSF COM_DET_IO
	;;PIN3 
	BSF NC00_IO
	;;PIN4 
	BSF PI_URX_O
	BCF PI_URX_IO
	;;PIN5 
	BSF NC01_IO
	;;PIN6 
	BSF GPIO2_IO
	;;PIN8 
	BSF NC02_IO
	;;PIN11 
	BSF NC03_IO
	;;PIN12 
	BSF NC04_IO
	;;PIN13 
	BSF NC05_IO
	;;PIN14 
	BSF NC06_IO
	;;PIN15 
	BSF NC07_IO
	;;PIN16 
	BSF NC08_IO
	;;PIN21 
	BCF LCD_D0_O
	BCF LCD_D0_IO
	;;PIN22 
	BCF LCD_D1_O
	BCF LCD_D1_IO
	;;PIN23 
	BCF LCD_D2_O
	BCF LCD_D2_IO
	;;PIN24 
	BSF NC09_IO
	;;PIN27 
	BSF NC10_IO
	;;PIN28 
	BSF NC11_IO
	;;PIN29 
	BSF GPIO3_IO
	;;PIN30 
	BSF GPIO4_IO
	;;PIN31 
	BSF GPS_UTX_IO
	;;PIN32 
	BSF GPS_URX_O
	BCF GPS_URX_IO
	;;PIN33 
	BCF LCD_LED_O
	BCF LCD_LED_IO
	;;PIN34 
	BSF NC12_IO
	;;PIN35 
	BCF LCD_D3_O
	BCF LCD_D3_IO
	;;PIN36 
	BCF LCD_D4_O
	BCF LCD_D4_IO
	;;PIN37
	BCF LCD_D5_O
	BCF LCD_D5_IO
	;;PIN42 
	BSF NC13_IO
	;;PIN43 
	BSF PI_SDO_IO
	;;PIN44 
	BCF PI_SDI_O
	BCF PI_SDI_IO
	;;PIN45 
	BSF NC14_IO
	;;PIN46 
	BSF PI_SCK_IO
	;;PIN47
	BSF NC15_IO
	;;PIN48 
	BSF PI_CE0_IO
	;;PIN49 
	BCF LCD_RS_O
	BCF LCD_RS_IO
	;;PIN50 
	BCF LCD_D6_O
	BCF LCD_D6_IO
	;;PIN51 
	BCF LCD_D7_O
	BCF LCD_D7_IO
	;;PIN52 
	BCF LCD_RW_O
	BCF LCD_RW_IO
	;;PIN53 
	BSF NC16_IO
	;;PIN54 
	BSF NC17_IO
	;;PIN55 
	BCF LCD_EN_O
	BCF LCD_EN_IO
	;;PIN58 
	BSF KEY1_IO
	;;PIN59 
	BSF KEY2_IO
	;;PIN60 
	BSF KEY3_IO
	;;PIN61 
	BSF KEY4_IO
	;;PIN62 
	BSF KEY5_IO
	;;PIN63 
	BCF LED1_O
	BCF LED1_IO
	;;PIN64 
	BCF LED2_O
	BCF LED2_IO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF TEST_O
	BCF TEST_IO

	

	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
REPEAT_U2TX:				;;
	BTFSC U2TX_EN_F
	NOP
	NOP
	NOP
	MOV GPSURX_ADDR,W3		;;
	CLR R0				;;
	CALL U2TX_START			;;
REPEAT_U2TX_1:				;;
	NOP
	NOP
	NOP
	MOV [W3++],W0			;;
	CALL LOAD_U2TXBYTE_B		;;
	INC R0				;;
	MOV GPSURX_LEN,W0		;;	
	CP R0				;;
	BRA LTU,REPEAT_U2TX_1		;;
	CALL U2TX_END			;;
	NOP
	NOP
	NOP
	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_START:				;;
	BCF U2TX_EN_F			;;
	CLR U2TX_BTX			;;
	CLR U2TX_BCNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2TX_BUF,W1		;;
	MOV #0x10,W0			;;
	CALL LOAD_U2TXBYTE_A		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U2TXBYTE_A:			;;
	MOV W0,[W1++]			;;
	INC U2TX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U2TXBYTE_C:			;;
LOAD_U2TXBYTE_B:			;;
	PUSH W2				;;
	AND #255,W0			;;
	MOV #0x10,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_U2TXBYTE_B1		;;	
	CALL LOAD_U2TXBYTE_A		;;
	POP W2				;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U2TXBYTE_B1:			;;
	PUSH W0				;;
	MOV #0x10,W0			;;
	CALL LOAD_U2TXBYTE_A		;;
	POP W0				;;
	CALL LOAD_U2TXBYTE_A		;;
	POP W2				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_END:				;;
	MOV #0x10,W0			;;
	CALL LOAD_U2TXBYTE_A		;;
	MOV #0x03,W0			;;
	CALL LOAD_U2TXBYTE_A		;;
	CLR U2TX_BCNT			;;
	BSF U2TX_EN_F			;;
	BSET IFS1,#U2TXIF		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSTX_START:				;;
	BCF U1TX_EN_F			;;
	CLR U1TX_BTX			;;
	CLR U1TX_BCNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1TX_BUF,W1		;;
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_GPSBYTE_A:				;;
	MOV W0,[W1++]			;;
	INC U1TX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_GPSBYTE_C:				;;
LOAD_GPSBYTE_B:				;;
	PUSH W2				;;
	AND #255,W0			;;
	MOV #0x10,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_GPSBYTE_B1		;;	
	CALL LOAD_GPSBYTE_A		;;
	POP W2				;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_GPSBYTE_B1:			;;
	PUSH W0				;;
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	POP W0				;;
	CALL LOAD_GPSBYTE_A		;;
	POP W2				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSTX_END:				;;
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x03,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BSET IFS0,#U1TXIF		;;
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
SPITX_START:				;;
	BCF SPITX_EN_F			;;
	CLR SPITX_BTX			;;
	CLR SPITX_BCNT			;;
	CLR SPITX_LEN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	MOV W0,SPITX_CHKSUM0		;;
	CLR SPITX_CHKSUM1		;;
	MOV #SPITX_BUF,W1		;;
	MOV #0xFF,W0			;;
	CALL LOAD_SPIBYTE_A		;;
	MOV #0xFF,W0			;;
	CALL LOAD_SPIBYTE_A		;;
	MOV #0xEA,W0			;;
	CALL LOAD_SPIBYTE_A		;;
	MOV SPITX_LEN,W0		;;
	CALL LOAD_SPIBYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SPIBYTE_A:				;;
	MOV W0,[W1++]			;;
	INC SPITX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SPIBYTE_B:				;;
	PUSH W2				;;
	AND #255,W0			;;
	MOV #0xEA,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_SPIBYTE_B1		;;	
	MOV #0xEB,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_SPIBYTE_B1		;;	
	MOV #0xEC,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_SPIBYTE_B1		;;	
	MOV W0,[W1++]			;;
	INC SPITX_BTX			;;
	POP W2				;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SPIBYTE_B1:			;;
	MOV #0xEC,W2			;;
	MOV W2,[W1++]			;;
	INC SPITX_BTX			;;
	MOV #0xAB,W2			;;
	XOR W2,W0,W0			;;
	MOV W0,[W1++]			;;
	INC SPITX_BTX			;;
	POP W2				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SPIBYTE_C:				;;
	XOR SPITX_CHKSUM0		;;
	ADD SPITX_CHKSUM1		;;
	INC SPITX_LEN			;; 
	CALL LOAD_SPIBYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_END:				;;
	MOV SPITX_CHKSUM0,W0		;;
	CALL LOAD_SPIBYTE_B		;;
	MOV SPITX_CHKSUM1,W0		;;
	CALL LOAD_SPIBYTE_B		;;
	MOV #0xEB,W0			;;
	CALL LOAD_SPIBYTE_A		;;
	MOV #0xFF,W0			;;
	CALL LOAD_SPIBYTE_A		;;
	MOV #0xFF,W0			;;
	CALL LOAD_SPIBYTE_A		;;



	MOV #SPITX_BUF+6,W1		;;
	MOV SPITX_LEN,W0		;;
	CALL LOAD_SPIBYTE_B		;;
	DEC SPITX_BTX			;;
	CLR SPITX_BCNT			;;
	BSF SPITX_EN_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_PRG:				;;
	BTFSS SPITX_STANDBY_F		;;
	RETURN				;;
	BCF SPITX_STANDBY_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSC SPITX_EN_F		;;
	RETURN				;;
	MOV SPITX_MOD,W0		;;	
	AND #7,W0			;;
	BRA W0				;; 
	BRA SPITX_J0			;;
	BRA SPITX_J1			;;
	BRA SPITX_J2			;;
	BRA SPITX_J3			;;
	BRA SPITX_J4			;;
	BRA SPITX_J5			;;RESET
	BRA SPITX_J0			;;
	BRA SPITX_J7			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_J0:				;;
	MOV #300,W0			;;
	CP GPSTIME_CNT			;;
	BRA GEU,$+4			;;
	BRA SPITX_J7			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SPITX_START		;;
	MOV #0xA0,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	CALL SPITX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_J1:				;;ip_address 
	CALL SPITX_START		;;
	MOV #0xA1,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	MOV #TCPIP_BUF,W7		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	CALL SPITX_END			;;
	CLR SPITX_MOD			;;
	CLR SPISET_TIM			;;

	MOV #4000,W0
	CALL DLYMX
	RESET


	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_J2:				;;NETMASK address 
	CALL SPITX_START		;;
	MOV #0xA2,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	MOV #NETMASK_BUF,W7		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	CALL SPITX_END			;;
	CLR SPITX_MOD			;;
	CLR SPISET_TIM			;;

	MOV #4000,W0
	CALL DLYMX
	RESET


	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_J3:				;;GATEWAY 
	CALL SPITX_START		;;
	MOV #0xA3,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	MOV #GATEWAY_BUF,W7		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	CALL SPITX_END			;;
	;INC SETIP_T
	;MOV #5,W0
	;CP SETIP_T 
	;BRA LTU,$+6
	CLR SPITX_MOD			;;
	;CLR SETIP_T
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR SPISET_TIM			;;

	MOV #4000,W0
	CALL DLYMX
	RESET

	 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_J4:				;;SET SYSTIME 
	CALL SPITX_START		;;
	MOV #0xA4,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	MOV #DATE_BUF,W7		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7],W2			;;
        MOV #2000,W0
        CP W2,W0
        BRA GEU,HHH        
        MOV #2000,W0
        MOV W0,[W7]        

HHH:
	MOV [W7],W0			;;
	SWAP W0 			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #TIME_BUF,W7		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W7++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	CALL SPITX_END			;;
	CLR SPITX_MOD			;;
	CLR SPISET_TIM			;;

	MOV #5000,W0
	CALL DLYMX
	RESET

	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_J5:				;;SET RESET 
	CALL SPITX_START		;;
	MOV #0xA5,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	MOV SPITX_PARA0,W0		;;
	CALL LOAD_SPIBYTE_C		;;
	MOV SPITX_PARA1,W0		;;
	CALL LOAD_SPIBYTE_C		;;
	MOV SPITX_PARA2,W0		;;
	CALL LOAD_SPIBYTE_C		;;
	MOV SPITX_PARA3,W0		;;
	CALL LOAD_SPIBYTE_C		;;
	CALL SPITX_END			;;
	CLR SPITX_MOD			;;
	CLR SPISET_TIM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_J7:				;;
	CALL SPITX_START		;;
	MOV #0xA7,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #GPSDATE_BUF,W3		;;
	MOV [W3++],W0			;;WEEK
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3],W0			;;
	SWAP W0 			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #GPSTIME_BUF,W3		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SATE_INVIEW,W0		;;	
	CALL LOAD_SPIBYTE_C		;;
	MOV SATE_GOOD,W0		;;	
	CALL LOAD_SPIBYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #LATDPD+2,W3		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #LONDPD+2,W3		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #ALTDPD+2,W3		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3],W0			;;
	SWAP W0				;;
	CALL LOAD_SPIBYTE_C		;;
	MOV [W3++],W0			;;
	CALL LOAD_SPIBYTE_C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL SPITX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPITX_TEST:				;;
	BTFSC SPITX_EN_F		;;
	RETURN				;;
	CALL SPITX_START		;;
	MOV #0x12,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	MOV #0x34,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	MOV #0x56,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	MOV #0x78,W0			;;				
	CALL LOAD_SPIBYTE_C		;;
	CALL SPITX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSTX_STAND:				;;
	CALL GPSTX_START		;;
	MOV #0x26,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x03,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x24,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x03,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x3C,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x00,W0			;;
	CALL LOAD_GPSBYTE_C		;;
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x03,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;MOV #0x10,W0			;;
	;CALL LOAD_GPSBYTE_A		;;
	;MOV #0x37,W0			;;
	;CALL LOAD_GPSBYTE_A		;;
	;MOV #0x10,W0			;;
	;CALL LOAD_GPSBYTE_A		;;
	;MOV #0x03,W0			;;
	;CALL LOAD_GPSBYTE_A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x10,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	MOV #0x21,W0			;;
	CALL LOAD_GPSBYTE_A		;;
	CALL GPSTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSTX_COLD_RESET:			;;
	CALL GPSTX_START		;;
	MOV #0x1E,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	MOV #0x4B,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	CALL GPSTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSTX_WARM_RESET:			;;
	CALL GPSTX_START		;;
	MOV #0x1E,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	MOV #0x0E,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	CALL GPSTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSTX_GET_VER:				;;
	CALL GPSTX_START		;;
	MOV #0x1C,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	MOV #0x03,W0			;;
	CALL LOAD_GPSBYTE_C		;;
	CALL GPSTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSTX_GET_SAT:				;;
	CALL GPSTX_START		;;
	MOV #0x24,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	CALL GPSTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSTX_GET_VIEWSAT:			;;
	CALL GPSTX_START		;;
	MOV #0x39,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	MOV #0x06,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	MOV #0x00,W0			;;				
	CALL LOAD_GPSBYTE_C		;;
	CALL GPSTX_END			;;
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
U1TX_KEY:				;;
	PUSH W0				;;
	CALL U1TX_START			;;
	MOV #0xD8,W0			;;GROUP
	CALL LOAD_U1BYTE_C		;;		
	MOV #0x1,W0			;;ITCMD
	CALL LOAD_U1BYTE_C		;;
	POP W0				;;
	CALL LOAD_U1BYTE_C		;;		
	CALL U1TX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	






;$2
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
	MOV #148,W0			;;
	CP W3,W0			;;
	BRA GTU,CHK_U1RX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W3,U1RX_LEN			;;
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
	BRA BIT_TRANSO_1		;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__SPI2Interrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS2,#SPI2IF		;;		
	MOV SPI2BUF,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xEA,W0			;;
	CP W0,W1			;;
	BRA Z,SPI2RXI_PS		;;	
	MOV #0xEB,W0			;;
	CP W0,W1			;;
	BRA Z,SPI2RXI_PE		;;	
	MOV #0xEC,W0			;;
	CP W0,W1			;;
	BRA Z,SPI2RXI_PT		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;; 
	BTFSC SPI2RXT_F			;;
	XOR W0,W1,W1			;;
	BCF SPI2RXT_F			;;
	MOV #150,W0			;;
	CP SPI2RX_BYTE_PTR		;;
	BRA GEU,SPI2TXI			;;
	MOV #SPI2RX_BUFA,W0		;;
	BTFSC SPI2RX_BUFAB_F		;;
	MOV #SPI2RX_BUFB,W0		;;
	ADD SPI2RX_BYTE_PTR,WREG	;;
	ADD SPI2RX_BYTE_PTR,WREG	;;
	MOV W1,[W0]			;;
	INC SPI2RX_BYTE_PTR		;;
	BRA SPI2TXI			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPI2RXI_PS:				;;
	BCF SPI2RXT_F			;;
	CLR SPI2RX_BYTE_PTR		;;
	BRA SPI2TXI			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPI2RXI_PE:				;;
	BCF SPI2RXT_F			;;
	MOV SPI2RX_BYTE_PTR,W0		;;	
	BTFSS SPI2RX_BUFAB_F		;;	
	MOV W0,SPI2RXA_LEN		;;
	BTFSC SPI2RX_BUFAB_F		;;	
	MOV W0,SPI2RXB_LEN		;;
	BTFSS SPI2RX_BUFAB_F		;;	
	BSF SPI2RX_PACKA_F		;;
	BTFSC SPI2RX_BUFAB_F		;;	
	BSF SPI2RX_PACKB_F		;;
	TG SPI2RX_BUFAB_F		;;
	BRA SPI2TXI			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPI2RXI_PT:				;;
	BSF SPI2RXT_F			;;
	BRA SPI2TXI			;;
SPI2TXI:				;;
	MOV #SPITX_BUF,W1		;;
	MOV SPITX_BCNT,W0		;;
	AND #0x007F,W0
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1],W0			;;
	BTFSS SPITX_EN_F		;;
	MOV #0,W0			;;	
	MOV W0,SPI2BUF			;;
	INC SPITX_BCNT			;;
	MOV SPITX_BTX,W0		;;
	CP SPITX_BCNT			;;
	BRA LTU,SPI2RXI_END		;;
	BCF SPITX_EN_F
SPI2RXI_END:				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


 	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1RXInterrupt:			;;
GPSURXI:				;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS0,#11			;;
	MOV U1RXREG,W0			;;
	AND #255,W0			;;
	MOV W0,GPSURX_B0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x10			;; 
	BRA Z,GPSURX_DLE		;;
	CP W0,#0x03			;; 
	BRA Z,GPSURX_ETX		;;
	BRA GPSURX_DATA			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
GPSURX_DLE:				;;
	BTFSC DLE_F			;;
	BRA GPSURX_DLE_1		;;
	BSF DLE_F			;;
	BRA GPSURXI_END			;;
GPSURX_DLE_1:				;;
	BCF DLE_F			;;
	BRA GPSURX_DATA			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSURX_ETX:				;;
	BTFSS DLE_F			;;
	BRA GPSURX_DATA			;;
GPSURX_RXED:				;;
	BCF DLE_F			;;
	BCF GPSURX_START_F		;;
	BTFSS URXAB_F			;;
	BSF URXA_RECED_F		;;
	BTFSC URXAB_F			;;
	BSF URXB_RECED_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV GPSURX_CNT,W0		;;
	BTFSS URXAB_F			;;
	MOV W0,GPSURX_LENA		;;
	BTFSC URXAB_F			;;
	MOV W0,GPSURX_LENB		;;
	TG URXAB_F			;;
	BRA GPSURXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GPSURX_DATA:				;;
	BTFSS DLE_F			;;
	BRA GPSURX_DATA_1		;;
	CLR GPSURX_CNT			;;
	BSF GPSURX_START_F		;;
GPSURX_DATA_1:				;;
	BCF DLE_F			;;
	MOV #256,W0			;;
	CP GPSURX_CNT			;;
	BRA LTU,$+4			;;
	BCF GPSURX_START_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS GPSURX_START_F		;;
	BRA GPSURXI_END			;;
	MOV #GPSURX_BUFA,W1		;;
	BTFSC URXAB_F			;;
	MOV #GPSURX_BUFB,W1		;;
	MOV GPSURX_CNT,W0		;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV GPSURX_B0,W0		;;	
	MOV W0,[W1]			;;
	INC GPSURX_CNT			;;
GPSURXI_END:				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




KVSU1RXI:
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
	
;50MIPS TMR2 UNIT=20*256(DIVIDER)=5.12US
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
	MOV #195,W0			;;
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












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T4Interrupt:			;;250 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	BCLR IFS1,#T4IF		;;
	INC T4ITMR		;;
T4I_0:
	;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_END_1:			;;	
	POP W1			;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SPIS:			;;
	MOV #0x0180,W0		;;	
	MOV W0,SPI2CON1		;;
	MOV #0x0000,W0		;;
	MOV W0,SPI2CON2		;;
	MOV #0x8004,W0		;;
	MOV W0,SPI2STAT		;;
	BCLR IFS2,#SPI2IF	;;
	BSET IEC2,#SPI2IE	;;
	BCLR IPC8,#6		;;
	BCLR IPC8,#5		;;
	BSET IPC8,#4		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_SPISI:
TEST_SPISI_0:
	CLRWDT
	CALL SPITX_TEST
	MOV #100,W0
	CALL DLYMX
	BRA TEST_SPISI_0

TEST_SPIS:
	CLR R2
	CLR R3
	MOV #0x87,W0
	MOV W0,SPI2BUF
TEST_SPIS_0:
	BTFSC PI_CE0_I
	CALL SPICSH
	BTFSS PI_CE0_I
	CALL SPICSL
	CLRWDT
	BTSS SPI2STAT,#SPIRBF
	BRA TEST_SPIS_0		
	MOV SPI2BUF,W0
	MOV W0,R0
	MOV R7,W0
	MOV #0x87,W0
	MOV W0,SPI2BUF
	INC R7	
	BRA TEST_SPIS_0

SPICSH:
	BTFSC SPICSH_F
	RETURN
	BSF SPICSH_F
;	BCLR SPI2STAT,#15		;;
;	CALL INIT_SPIS 	

	;MOVLF #0x00,R7 
	;MOV R7,W0
	;MOV W0,SPI2BUF
	;INC R7	
	RETURN			

SPICSL:
	BTFSS SPICSH_F
	RETURN
	BCF SPICSH_F
	RETURN			


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SPIM:			;;
	MOV #0x027B,W0		;;
	MOV #0x0262,W0		;;
	MOV #0x0263,W0		;;/8	OK
	MOV #0x0273,W0		;;/4	OK
	MOV #0x027B,W0		;;/2	
	MOV W0,SPI2CON1		;;
	MOV #0x0000,W0		;;
	MOV W0,SPI2CON2		;;
	MOV #0x8000,W0		;;
	MOV W0,SPI2STAT		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIPRG:					;;
	MOV W0,SPI2BUF			;;
SPIPRG1:				;;
	CLRWDT				;;
	BTSC SPI2STAT,#1		;;
	BRA SPIPRG1			;;	
	BTSS SPI2STAT,#0		;;
	BRA SPIPRG1			;;	
	MOV.B SPI2BUF,WREG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_SPI:			;;
	MOV #0x00AA,W0		;;
	CALL SPIPRG		;;
	MOV #10,W0		;;
	CALL DLYMX		;;
	BRA TEST_SPI		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_FLASH24:					;;
	MOV #0x00E0,W0				;;
	IOR SR					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL VER_FLASH24			;;
	BTSC SR,#Z				;;
	BRA SAVE_FLASH24_END
	CALL WAIT_FLASH24_READY			;;
	CALL ERASE_FLASH24			;;
	CALL WAIT_FLASH24_READY			;;
	MOV #SET_BUF,W2				;;
	CALL WRITE_FLASH24			;;
	MOV #0,W0				;;
	MOV W0,NVMCON				;;
SAVE_FLASH24_END:				;;
	MOV #0xFF1F,W0				;;
	AND SR					;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_FLASH24:					;;
	MOV #tblpage(FLASH24_ADDR),W0 		;;	
	MOV W0, TBLPAG 				;;	
	MOV #tbloffset(FLASH24_ADDR),W1		;;
	MOV #64,W3 				;;
	MOV #SET_BUF,W2				;;
LOAD_FLASH24_1:					;;
	TBLRDL [W1++],W0			;;
	MOV W0,[W2++]				;;
	DEC W3,W3				;;
	BRA NZ,LOAD_FLASH24_1			;;
	RETURN 					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VER_FLASH24:					;;
	MOV #tblpage(FLASH24_ADDR),W0 		;;	
	MOV W0, TBLPAG 				;;	
	MOV #tbloffset(FLASH24_ADDR),W1		;;
	MOV #64,W3 				;;
	MOV #SET_BUF,W2				;;
VER_FLASH24_1:					;;
	TBLRDL [W1++],W0			;;
	XOR W0,[W2++],W0			;;
	BRA Z,$+4				;;
	RETURN					;;
	DEC W3,W3				;;
	BRA NZ,VER_FLASH24_1			;;
	RETURN 					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WAIT_FLASH24_READY:				;;
	CLRWDT					;;
	BTSC NVMCON,#15				;;
	BRA WAIT_FLASH24_READY			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH24:					;;
	CALL LOAD_FLASH24			;;
	NOP					;;
	NOP					;;
	NOP					;;
	CALL WAIT_FLASH24_READY			;;
	NOP					;;
	NOP					;;
	NOP					;;
	NOP					;;
	CALL WAIT_FLASH24_READY			;;
	NOP					;;
	NOP					;;
	NOP					;;
	CALL LOAD_FLASH24			;;
	NOP					;;
	NOP					;;
	NOP					;;
	CALL LOAD_TEST24			;;
	NOP					;;
	NOP					;;
	NOP					;;
	MOV #SET_BUF,W2				;;
	CALL WRITE_FLASH24			;;
	NOP					;;
	NOP					;;
	NOP					;;
	CALL WAIT_FLASH24_READY			;;
	NOP					;;
	NOP					;;
	NOP					;;
	CALL LOAD_FLASH24			;;
	NOP					;;
	NOP					;;
	NOP					;;
	BRA TEST_FLASH24 			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_TEST24:				;;
	MOV #SET_BUF,W1			;;
	MOV #64,W2			;;
	MOV #0x1234,W3 			;;
LOAD_TEST24_1:				;;	
	MOV W3,[W1++]			;;
	MOV #0x0101,W0			;;
	ADD W0,W3,W3			;;
	DEC W2,W2			;;
	BRA NZ,LOAD_TEST24_1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERASE_FLASH24:				;;
	MOV #tblpage(FLASH24_ADDR),W0	;;
	MOV W0,NVMADRU			;;
	MOV #tbloffset(FLASH24_ADDR),W0	;;
	MOV W0,NVMADR			;;
	MOV #0x4003,W0 			;;	
	MOV W0,NVMCON 			;;	
	DISI #6				;;
	MOV #0x55,W0			;;				
	MOV W0,NVMKEY 			;;	
	MOV #0xAA,W0 			;;	
	MOV W0,NVMKEY 			;;
	BSET NVMCON,#15 		;;	
	NOP 				;;	
	NOP 				;;
	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









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
	














;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRITE_FLASH24:				;;
	CLR W3				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRITE_FLASH24_0:			;;
	MOV #tblpage(FLASH24_ADDR),W0	;;
	MOV W0,NVMADRU			;;
	MOV #tbloffset(FLASH24_ADDR),W0	;;
	ADD W0,W3,W0			;;
	ADD W0,W3,W0			;;
	ADD W0,W3,W0			;;
	ADD W0,W3,W0			;;
	MOV W0,NVMADR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFA,W0			;;
	MOV W0,TBLPAG			;;
	MOV #0,W1			;; Perform the TBLWT instructions to write the latches; W2 is incremented in the TBLWTH instruction to point to the; next instruction location
	TBLWTL [W2++],[W1]		;;
	TBLWTH W3,[W1++]		;;
	TBLWTL [W2++],[W1]		;;
	TBLWTH W3,[W1++]		;;
	CLR TBLPAG			;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x4001,W0			;;
	MOV W0,NVMCON			;;
	DISI #06			;; Write the KEY Sequence
	MOV #0x55,W0			;;
	MOV W0,NVMKEY			;;	
	MOV #0xAA,W0			;;
	MOV W0,NVMKEY			;; Start the erase operation
	BSET NVMCON,#15			;; Insert two NOPs after the erase cycle (required)
	NOP				;;
	NOP				;;
	NOP				;;
	CALL WAIT_FLASH24_READY		;;
	INC W3,W3			;;
	MOV #32,W0			;;
	CP W3,W0			;;
	BRA NZ,WRITE_FLASH24_0		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TS:
	CLR TOTS0
	CLR TOTS1
	CLR TOTS2
	MOV URX06,W0
	SWAP W0
	IOR URX05,WREG
	MOV #14,W1
	MUL.UU W0,W1,W2
	MOV W2,R0
	 
	
GPST2UTC:
	CALL TRANS_TS
	CLR W4
	CLR W5
	CLR W6
	MOV #1980,W0
	MOV W0,UTC0
GPST2UTC_0:
	MOV #0x01E2,W3
	MOV #0x8500,W2
	MOV UTC0,W0
	AND #3,W0
	BRA Z,GPST2UTC_1
	MOV #0x01E1,W3
	MOV #0x3380,W2
GPST2UTC_1:
	CLR W0	
	ADD W4,W2,W8
	ADDC W5,W3,W9
	ADDC W6,W0,W10
	MOV W8,W0	
	SUB TOTS0,WREG	 
	MOV W9,W0	
	SUBB TOTS1,WREG	 
	MOV W10,W0	
	SUBB TOTS2,WREG	 
	BRA LTU,GPST2UTC_2
	MOV W4,W0
	ADD TOTS0
	MOV W5,W0
	ADDC TOTS1
	MOV W6,W0
	ADDC TOTS2
	INC UTC0
	BRA GPST2UTC_0	
GPST2UTC_2:








	.ORG 0x9FFC			;;OFFSET 0x200
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0012			;;00	
	.WORD 0x5678			;;01	
	.WORD 0x00CF			;;02	
	.WORD 0x1B0C			;;03	
	.WORD 0xEB3E			;;04	
	.WORD 0x005D			;;05	
	.WORD 0x0005			;;06
	.WORD 0x0000			;;04
	.WORD 0x0000			;;05
	.WORD 0x0000			;;06
	.WORD 0x0000			;;07
	.WORD 0x0000			;;08


