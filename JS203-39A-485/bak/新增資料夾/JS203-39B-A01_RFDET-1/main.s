;******************************************************************************
;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 


	
 

        .equ __24ep64gp206, 1 ;
        .include "p24ep64gp206.inc"

;BY DEFINE=============================

;======================================
;MY_TYPE_ID
        /*
        0:FPGA
        1:IPC
        2:

        */
;====================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'

        .EQU    DEVICE_ID_K             ,0x2537 ;
        .EQU    SON_DEVICE_ID_K         ,0x2538 ;
	.EQU 	DEBUG_SLOT_ID_K	        ,0x0001
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

ATTENUATOR:		.SPACE 2
FREQCH:		        .SPACE 2


F24_ADR:		.SPACE 2		
F24_LEN:		.SPACE 2		

MY_SLOT_ID:		.SPACE 2		
MY_ITEM_ID:		.SPACE 2
MY_TYPE_ID:		.SPACE 2		
SON_SERIAL_ID:		.SPACE 2

SP4T_CNT:	        .SPACE 2		
		


U2TXACT_INX:		.SPACE 2		
U2TXACT_PARA0:		.SPACE 2		
U2TXACT_PARA1:		.SPACE 2		
U2TXACT_PARA2:		.SPACE 2		
U2TXACT_PARA3:		.SPACE 2		
U2RX_PACK_TIME:		.SPACE 2
U2TX_REPEAT_TIM:       .SPACE 2
U1TX_REPEAT_TIM:       .SPACE 2


UTX_FLAG:		.SPACE 2

WGBUF:		.SPACE 2
INFLAG:		.SPACE 2




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


UACT_CNT:		.SPACE 2

PWRON_TIM:		.SPACE 2
RESET_TIM:		.SPACE 2


UICON_TIM:		.SPACE 2
CTRCON_TIM:		.SPACE 2

URX_FLAG:		.SPACE 2

MCUTX2_TIM:		.SPACE 2
MCUTX2_BYTE_CNT:	.SPACE 2
MCUTX2_BYTE:	        .SPACE 2
MCUTX2_BIT_CNT:	        .SPACE 2
MCURX2_CLR_TIM:	        .SPACE 2
MCURX2_TIM:	        .SPACE 2

MCUTX2_BIT_LEN:		.SPACE 2
MCURX2_IBUF:		.SPACE 2
MCURX2_BIT:		.SPACE 2
MCURX2_PCNT0:		.SPACE 2
MCURX2_PCNT1:		.SPACE 2
MCURX2_END_BIT:		.SPACE 2
MCURX2_END_CNT:		.SPACE 2


MCURX2_TMP0:		.SPACE 2
MCURX2_TMP1:		.SPACE 2
MCURX2_ADDSUM:		.SPACE 2
MCURX2_XORSUM:		.SPACE 2
MCURX2_BYTE_PTR:	.SPACE 2
MCURX2_LEN:	        .SPACE 2


		
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
TX_SERIAL_BUF:		.SPACE 2

SLOT_POS:		.SPACE 2

ADIN_BUF0:		.SPACE 2
ADIN_BUF1:		.SPACE 2
ADIN_BUF2:		.SPACE 2
ADIN_BUF3:		.SPACE 2
ADIN_BUF4:		.SPACE 2
ADIN_BUF5:		.SPACE 2
ADIN_BUF6:		.SPACE 2
ADIN_BUF7:		.SPACE 2

ADIN_CLRT0:		.SPACE 2
ADIN_CLRT1:		.SPACE 2
ADIN_CLRT2:		.SPACE 2
ADIN_CLRT3:		.SPACE 2
ADIN_CLRT4:		.SPACE 2
ADIN_CLRT5:		.SPACE 2
ADIN_CLRT6:		.SPACE 2
ADIN_CLRT7:		.SPACE 2




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





;BYTE0-BIT3~0 NOWPAGE
;BYTE0-BIT4~0 LOAD OK
;BYTE4 CHKSUM0
;BYTE5 CHKSUM1
;BYTE6 CHKSUM2
;BYTE7 CHKSUM3


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
.EQU MCUTX2_BUF		,0x2A00	;128
.EQU MCURX2_BUF		,0x2A80	;128
.EQU MCURX2_BUFA	,0x2B00	;128



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








.EQU TMP_BUF		,0x2D00	;256
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
.EQU LOCAL_REMOTE_F	,FLAGA
.EQU LOCAL_REMOTE_F_P	,6
.EQU LOAD_ANT_F	        ,FLAGA
.EQU LOAD_ANT_F_P	,7
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
.EQU MASTER_U1RX_F	,FLAGA
.EQU MASTER_U1RX_F_P 	,13
.EQU MASTER_U2RX_F	,FLAGA
.EQU MASTER_U2RX_F_P 	,14
.EQU WAIT_DUTX_F	,FLAGA
.EQU WAIT_DUTX_F_P  	,15



;FLAGB
;.EQU MCURX1_ALT_F	,FLAGB
;.EQU MCURX1_ALT_F_P	,0
.EQU MCURX2_ALT_F	,FLAGB
.EQU MCURX2_ALT_F_P	,1
.EQU MCURX2_RXIN_F	,FLAGB
.EQU MCURX2_RXIN_F_P	,2
.EQU MCURX2_PACK_F	,FLAGB
.EQU MCURX2_PACK_F_P	,3
.EQU MCUTX2_START_F	,FLAGB
.EQU MCUTX2_START_F_P	,4
.EQU MCURX2_START_F	,FLAGB
.EQU MCURX2_START_F_P	,5
;.EQU MCURX3_START_F	,FLAGB
;.EQU MCURX3_START_F_P	,6
;.EQU MCURX3_ALT_F	,FLAGB
;.EQU MCURX3_ALT_F_P	,7
;.EQU MCURX3_PACK_F	,FLAGB
;.EQU MCURX3_PACK_F_P	,8
;.EQU MCUTX3_EN_F	,FLAGB
;.EQU MCUTX3_EN_F_P	,9
;.EQU U2TX_WAKE_F	,FLAGB
;.EQU U2TX_WAKE_F_P	,10
;.EQU MCUTX1_START_F	,FLAGB
;.EQU MCUTX1_START_F_P	,11
;.EQU MCUTX2_START_F	,FLAGB
;.EQU MCUTX2_START_F_P	,12
;.EQU MCURX1_START_F	,FLAGB
;.EQU MCURX1_START_F_P	,13
;.EQU MCURX3_EN_F	,FLAGB
;.EQU MCURX3_EN_F_P	,14
;.EQU DIS_KFREE_F	,FLAGB
;.EQU DIS_KFREE_F_P	,15



;FLAGC
;.EQU MCURX3_START_F	,FLAGC
;.EQU MCURX3_START_F_P	,0
;.EQU MCURX4_START_F	,FLAGC
;.EQU MCURX4_START_F_P	,1
;.EQU MCURX3_RXIN_F	,FLAGC
;.EQU MCURX3_RXIN_F_P	,2
;.EQU MCUTX4_START_F	,FLAGC
;.EQU MCUTX4_START_F_P	,3
;.EQU MCURX4_RXIN_F	,FLAGC
;.EQU MCURX4_RXIN_F_P	,4
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
	MOV #10,W1		;;
WAIT_POWER:			;;
	MOV #1000,W0		;;
	CALL DLYUX		;;
	DEC W1,W1		;;
	BRA NZ,WAIT_POWER	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL CLR_WREG 		;;
	CALL INIT_IO		;;
	CALL INIT_AD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL INIT_RAM		;;
	CALL INIT_SIO		;;
	CALL INIT_OSC		;;
	MOV #10000,W0		;;
	CALL DLYX		;;
        ;CALL TEST_OSC
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_TIMER2	;;
	CALL INIT_UART1		;;
	CALL INIT_UART2	        ;;
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
	MOV #10,W0		;;
	CALL DLYMX		;;
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER1:				;;
        CLR TMR1                        ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xA000,W0			;;
	MOV W0,T1CON			;;
        MOV #567,W0                   	;;115200
        MOV #189,W0                  	;;115200*3
        MOV W0,PR1                      ;;
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
	;MOV MCUU2_MODE,W0		;;
	;CALL GET_UART_RATE             ;;
	;MOV W0,T1CON                   ;;
	;MOV W2,PR1                     ;;        
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET IPC0,#14			;;
	BCLR IPC0,#13			;;
	BSET IPC0,#12			;;
        BCLR IFS0,#T1IF			;;	
        BSET IEC0,#3                    ;;            
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T1Interrupt:			;;10 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	PUSH W2			;;
	BCLR IFS0,#T1IF		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC MCUTX2_TIM		;;
	MOV #3,W0		;;
	CP MCUTX2_TIM		;;
	BRA LTU,T1I_1		;;
	CLR MCUTX2_TIM		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	BSF MCU_TX2_O		;;	
	BTSS  W0,#0		;;
	BCF MCU_TX2_O		;;	
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC MCUTX2_BIT_CNT	;;
	MOV #10,W0      	;;
	CP MCUTX2_BIT_CNT	;;
	BRA LTU,T1I_1	 	;;
	CLR MCUTX2_BIT_CNT	;;
	INC MCUTX2_BYTE_CNT	;;
	MOV MCUTX2_BYTE,W0	;;	
	CP MCUTX2_BYTE_CNT	;;
	BRA LTU,T1I_1		;;
	BCF MCUTX2_START_F	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
T1I_1:				;;
	INC MCURX2_CLR_TIM	;;
	BRA NZ,$+4		;;
	DEC MCURX2_CLR_TIM	;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	CP MCURX2_BIT		;;
	BRA LTU,T1I_END		;;
	BCF MCURX2_START_F	;;
	BTSC MCURX2_IBUF,#6	;;
	BRA T1I_END		;;
	BTSS MCURX2_IBUF,#15	;;
	BRA T1I_END		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	MOV #0xAB,W0			;;
	MOV W0,U1TXREG			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART1 			;;
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





	




	
	


	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
T128M_PRG:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MCURX1:				;;
	RETURN	  			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DEC_SYSURX:
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MCURX2_DEC:                             ;;
        MOV MCURX2_PCNT0,W0             ;;
	XOR MCURX2_PCNT1,WREG           ;;
        AND #127,W0                     ;;
        BRA NZ,$+4                      ;;
        RETURN			        ;;
	MOV #127,W0			;;
	AND MCURX2_PCNT1		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #MCURX2_BUF,W1		;; 
	MOV MCURX2_PCNT1,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0			;;
	MOV [W1],W2			;;
	BTSC MCURX2_PCNT1,#0		;;
	SWAP W2				;;
	AND #255,W2			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xEA,W0			;;
	CP W0,W2			;;
	BRA Z,MCURX2_DEC_PS		;;	
	MOV #0xEB,W0			;;
	CP W0,W2			;;
	BRA Z,MCURX2_DEC_PE		;;	
	MOV #0xEC,W0			;;
	CP W0,W2			;;
	BRA Z,MCURX2_DEC_PT		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;; 
	BTFSC MCURX2_ALT_F		;;
	XOR W0,W2,W2			;;
	BCF MCURX2_ALT_F		;;
	MOV #127,W0	        	;;
	CP MCURX2_BYTE_PTR		;;
	BRA GEU,MCURX2_DEC_ERR		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #MCURX2_BUFA,W0		;;
	ADD U1RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	BTSC U1RX_BYTE_PTR,#0		;;
	BRA MCURX2_DEC_1		;;
	MOV W2,[W0]			;;
	BRA MCURX2_DEC_2		;;
MCURX2_DEC_1:				;;
	SWAP W2				;;
	ADD W2,[W0],[W0]		;;
	SWAP W2				;;
MCURX2_DEC_2:				;;
	MOV MCURX2_TMP0,W0		;;
	MOV W0,MCURX2_TMP1		;;
	MOV W1,W0			;;
	MOV W0,MCURX2_TMP0		;;
	MOV W1,W0			;;
	ADD MCURX2_ADDSUM		;;	
	XOR MCURX2_XORSUM		;;
MCURX2_3:				;;
	INC MCURX2_BYTE_PTR		;;
	BRA MCURX2_DEC_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MCURX2_DEC_PS:				;;
	BCF MCURX2_ALT_F		;;
	CLR MCURX2_BYTE_PTR		;;
	CLR MCURX2_ADDSUM		;;
	CLR MCURX2_XORSUM		;;
	BRA MCURX2_DEC_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MCURX2_DEC_PE:				;;
	BCF MCURX2_ALT_F		;;
	MOV #0xAB,W0			;;
	XOR MCURX2_XORSUM,WREG		;;	
	XOR MCURX2_TMP0,WREG		;;
	BRA NZ,MCURX2_DEC_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX2_TMP0,W0		;;
	ADD MCURX2_TMP0,WREG		;;
	ADD MCURX2_TMP1,WREG		;;
	XOR MCURX2_ADDSUM,WREG		;;
	AND #255,W0			;;
	BRA NZ,MCURX2_DEC_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MCURX2_BYTE_PTR,W0		;;	
	MOV W0,MCURX2_LEN		;;
	BSF MCURX2_PACK_F		;;
        RETURN                          ;;
MCURX2_DEC_PT:				;;
	BSF MCURX2_ALT_F		;;
	BRA MCURX2_DEC_END		;;
MCURX2_DEC_ERR:                         ;;
MCURX2_DEC_END:                         ;;
        INC MCURX2_PCNT1		;;
        BRA MCURX2_DEC                  ;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












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
	BTFSS T1M_F			;;
	RETURN				;;
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
	MOV #120,W0		;;RP120 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR8		;;
	MOV #0x0100,W0		;;RP118 U1TX
	IOR RPOR8		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR19		;;
	MOV #36,W0		;;RP36 U2RX
	IOR RPINR19		;;LSB:U2RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR0		;;
	MOV #0x0003,W0		;;RP20 U2TX
	IOR RPOR0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0x00FF,W0		;;
	;AND RPINR0		;;
	;MOV #58,W0		;;RPI58
	;SWAP W0		;;
	;IOR RPINR0		;;INT1 IIC CLK IN
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0x00FF,W0		;;
	;AND RPOR6		;;RP57
	;MOV #0x1000,W0		;;OC1
	;IOR RPOR6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xFF00,W0		;;
	;AND RPINR7		;;
	;MOV #28,W0		;;
	;IOR RPINR7		;;IC1
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0x00FF,W0		;;
	;AND RPINR7		;;
	;MOV #27,W0		;;
	;SWAP W0		;;
	;IOR RPINR7		;;IC2
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xFF00,W0		;;
	;AND RPINR8		;;
	;MOV #37,W0		;;
	;IOR RPINR8		;;IC3
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
;	MOV #0xFF00,W0		;;
;	AND RPOR5		;;
;	MOV #0x0031,W0		;;REFCLKO
;	IOR RPOR5		;;RP54
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
INIT_UART2:				;;
	;MOV #142,W0	;115200		;;66MHZ
	;MOV #65,W0	;256000		;;66MHZ
	;MOV #47,W0	;345600		;;66MHZ
	MOV #35,W0	;460800		;;66MHZ
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
INIT_IO:				;;
	;;PIN1 				;;
        BCF LED_O                       ;;
        BCF LED_IO                      ;;
	;;PIN2 				;;
	;;PIN3 				;;
        BCF FIBER_OUT_O                 ;;
        BCF FIBER_OUT_IO                ;;
	;;PIN4 				;;
        BSF RS422_TX_O                  ;;
        BCF RS422_TX_IO                 ;;
	;;PIN5 				;;
	;;PIN6 				;;
        BSF RS422_RX_IO                 ;;
	;;PIN8 				;;
	;;PIN11 			;;
	;;PIN12 			;;
	;;PIN13 			;;
	;;PIN14 			;;
	BCF SW_EN_O			;;
	BCF SW_EN_IO			;;
	;;PIN15 			;;
	BCF SW_LE1_O			;;
	BCF SW_LE1_IO			;;
	;;PIN16 			;;
	BCF SW_LE2_O			;;
	BCF SW_LE2_IO			;;
	;;PIN21 			;;
	BCF DB0_O                      ;;
	BCF DB0_IO                     ;;
	;;PIN22 			;;
	BCF DB1_O                      ;;
	BCF DB1_IO                     ;;
	;;PIN23 			;;
	BCF DB2_O                      ;;
	BCF DB2_IO                     ;;
	;;PIN24 			;;
	;;PIN27 			;;
	;;PIN28 			;;
	;;PIN29 			;;
	;;PIN30 			;;
	;;PIN31 			;;
	;;PIN32 			;;
	BSF OP_TX_IO                    ;;
	;;PIN33 			;;
	BSF OP_RX_O                     ;;
	BCF OP_RX_IO                    ;;
	;;PIN34 			;;
	;;PIN35 			;;
	BCF DB3_O                      ;;
	BCF DB3_IO                     ;;
	;;PIN36 			;;
	BCF DB4_O                      ;;
	BCF DB4_IO                     ;;
	;;PIN37 			;;
	BCF DB5_O                      ;;
	BCF DB5_IO                     ;;
	;;PIN39 			;;
        BSF OSC1_IO                     ;;
	;;PIN40 			;;
        BSF OSC2_IO                     ;;
	;;PIN42 			;;
	;;PIN43 			;;
	BCF TP1_O                       ;;
	BCF TP1_IO                      ;;
	;;PIN44 			;;
	;;PIN45 			;;
	;;PIN46 			;;
        BSF MCU_RX2_IO                  ;;        
	;;PIN47				;;
	;;PIN48 			;;
        BSF MCU_TX2_O                   ;;
        BCF MCU_TX2_IO                  ;;
	;;PIN49 			;;
	;;PIN50 			;;
	BCF DB6_O                       ;;
	BCF DB6_IO                      ;;
	;;PIN51 			;;
	BCF DB7_O                       ;;
	BCF DB7_IO                      ;;
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
        BSF AIR_FLOW_R_IO	        ;;
	;;PIN60 			;;
        BSF AIR_FLOW_L_IO	        ;;
	;;PIN61 			;;
	BSF WGSW_LOAD_IO	        ;;
	;;PIN62 			;;
        BSF AIR_FLOW_M_IO	        ;;
	;;PIN63 			;;
	BSF WGSW_ANT_IO	                ;;
	;;PIN64 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR ANSELA                      ;;
        CLR ANSELB                      ;;
        CLR ANSELC                      ;;
        CLR ANSELE                      ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:
        RETURN


EMU_PULSE_IN_PRG:
        MOV TMR2,W0
        AND #255,W0
        MOV W0,R0
        MOV #25,W0
        CP R0
        BRA GEU,$+6
        BSF TP1_O
        RETURN
        BCF TP1_O
        RETURN

ADRF_CLR_PRG:
	BTFSS T1M_F			;;
	RETURN	
        INC ADIN_CLRT0
        INC ADIN_CLRT1
        INC ADIN_CLRT2
        INC ADIN_CLRT3
        INC ADIN_CLRT4
        INC ADIN_CLRT5
        INC ADIN_CLRT6
        INC ADIN_CLRT7
        MOV #20,W0
        CP ADIN_CLRT0
        BRA LTU,$+4
        BSET ADIN_BUF0,#15
        CP ADIN_CLRT1
        BRA LTU,$+4
        BSET ADIN_BUF1,#15
        CP ADIN_CLRT2
        BRA LTU,$+4
        BSET ADIN_BUF2,#15
        CP ADIN_CLRT3
        BRA LTU,$+4
        BSET ADIN_BUF3,#15
        CP ADIN_CLRT4
        BRA LTU,$+4
        BSET ADIN_BUF4,#15
        CP ADIN_CLRT5
        BRA LTU,$+4
        BSET ADIN_BUF5,#15
        CP ADIN_CLRT6
        BRA LTU,$+4
        BSET ADIN_BUF6,#15
        CP ADIN_CLRT7
        BRA LTU,$+4
        BSET ADIN_BUF7,#15
        RETURN




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:	                                ;;
        CALL INIT_RAM   		;;
	BSF U1RX_EN_F			;;
	BSF U2RX_EN_F			;;
        CALL SET_ATT                    ;;
        CLR SP4T_CNT
        BCF LOAD_ANT_F
        BCF LOCAL_REMOTE_F
        CALL SET_OUT
        CLR MY_SLOT_ID
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
        CLRWDT                          ;;
	BTFSC T128M_F			;;
        TG LED_O                        ;;
	CLRWDT				;;
        CALL SET_OUT                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL EMU_PULSE_IN_PRG           ;;
        CALL ADRF_CLR_PRG               ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TIMEACT_PRG		;;
        ;;CALL U1TX_PRG                 ;;
        CALL CHK_U1TX_END               ;;
	CALL CHK_U1RX			;;
        ;=================================
        CALL U2TX_PRG                   ;;
        CALL CHK_U2TX_END               ;;
	CALL CHK_U2RX			;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SET_ATT:
        MOV ATTENUATOR,W0
        XOR LATC,WREG
        AND #255,W0
        XOR LATC
        BSF SW_LE2_O
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        BCF SW_LE2_O
        BCF SW_EN_O
        BSF ATT_LE_O
        RETURN



SET_OUT:
        CLR OUT_FLAG
        BTFSC LOCAL_REMOTE_F
        BSET OUT_FLAG,#0
        BTSC SP4T_CNT,#0
        BSET OUT_FLAG,#1
        BTSC SP4T_CNT,#1
        BSET OUT_FLAG,#2
        BTSC SP4T_CNT,#2
        BSET OUT_FLAG,#3
        BTFSS LOAD_ANT_F
        BSET OUT_FLAG,#4
        BTFSC LOAD_ANT_F
        BSET OUT_FLAG,#5
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV OUT_FLAG,W0
        XOR LATC,WREG
        AND #255,W0
        XOR LATC
        BSF SW_LE1_O
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        BCF SW_LE1_O
        BCF SW_EN_O
        RETURN




ATTPRG:
        






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2TX_PRG:                               ;;
        BTFSC U2TXON_F                  ;;
        RETURN                          ;;
        MOV TMR2,W0                     ;;
        SUB U2TX_REPEAT_TIM,WREG        ;;
        BTSS W0,#15                     ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC SON_SERIAL_ID               ;;
        MOV #9,W0                       ;;
        CP SON_SERIAL_ID                ;;
        BRA LTU,$+6                     ;;
        MOV #1,W0                       ;;
        MOV W0,SON_SERIAL_ID            ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #DEVICE_ID_K,W0             ;;
	MOV W0,TX_DEVICE_ID             ;;
        MOV SON_SERIAL_ID,W0            ;;        
        DEC W0,W0                       ;;        
	MOV W0,TX_SERIAL_ID             ;;
        MOV W0,TX_SERIAL_BUF            ;;
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
GET_SON_INF:                            ;;
	MOV #0x1000,W0                  ;;
	MOV W0,UTX_CMD                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV FREQCH,W0                   ;;
        MOV W0,UTX_PARA0                ;;
        MOV ATTENUATOR,W0               ;;
        SWAP W0                         ;;
        IOR UTX_PARA0                   ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR UTX_PARA1                   ;;
        CLR UTX_PARA2                   ;;        
        CLR UTX_PARA3                   ;; 
        CLR UTX_BUFFER_LEN              ;;        
U2TX_PRG_1:                             ;;
        CLR RS485_CMD                   ;;
        CLR RS485_CMD_PARA0             ;;
        CLR RS485_CMD_PARA1             ;;
        CLR RS485_CMD_PARA2             ;;
        CLR RS485_CMD_PARA3             ;;
        MOV #1,W0                       ;;
        MOV W0,UACT_CNT                 ;;
	CALL UTX_STD                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        RETURN
        INC SON_SERIAL_ID               ;;
        MOV #3,W0                       ;;
        CP SON_SERIAL_ID                ;;
        BRA GEU,$+4                     ;;
        RETURN                          ;;
        MOVLF #1,SON_SERIAL_ID          ;;
	RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

U1TX_BACK:
        BRA U1TX_PRG_1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_PRG:                               ;;
        BTFSC U1TXON_F                  ;;
        RETURN                          ;;
        MOV TMR2,W0                     ;;
        SUB U1TX_REPEAT_TIM,WREG        ;;
        BTSS W0,#15                     ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1TX_PRG_1:                              ;;
        MOV #0X2536,W0                  ;;
	MOV W0,TX_DEVICE_ID             ;;
        CLR TX_SERIAL_ID                ;;
        MOV #0xAC00,W0                  ;;
	MOV W0,TX_GROUP_ID              ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1000,W0                  ;;
	MOV W0,UTX_CMD                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR INFLAG                      ;;
        BTFSS WGSW_LOAD_I               ;;
        BSET INFLAG,#0                  ;;
        BTFSS WGSW_ANT_I                ;;
        BSET INFLAG,#1                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOVLF #15,UTX_PARA0               ;;
        MOV INFLAG,W0                   ;;
        MOV W0,UTX_PARA1                ;;
        CLR UTX_PARA2                   ;;        
        CLR UTX_PARA3                   ;; 
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;MOVLF #0X120,ADIN_BUF0
        ;MOVLF #0X200,ADIN_BUF1
        ;MOVLF #0X300,ADIN_BUF2
        ;MOVLF #0X400,ADIN_BUF3
        ;MOVLF #0X500,ADIN_BUF4
        ;MOVLF #0X600,ADIN_BUF5
        ;MOVLF #0X700,ADIN_BUF6
        ;MOVLF #0X800,ADIN_BUF7

        MOVLF #8,UTX_BUFFER_LEN         ;;        
        MOV #ADIN_BUF0,W3               ;;
        MOVLF #0,UACT_CNT               ;;     
	CALL UTX_STD                    ;;
	RETURN                          ;;
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
	MOV W0,RX_DEVICE_ID		;;
	MOV #0x2536,W2	                ;;
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
	MOV [W1++],W0			;;
	MOV W0,RX_PARA0			;;systemStatus0L
	MOV [W1++],W0			;;
	MOV W0,RX_PARA1			;;systemStatus0H
	MOV [W1++],W0			;;
	MOV W0,RX_PARA2			;;systemFlag0L
	MOV [W1++],W0			;;
	MOV W0,RX_PARA3			;;systemFlag0H
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RX_CMD,W0			;;	
	SWAP W0				;;
	AND #255,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x10			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_CMD_ACT		;;
	RETURN				;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_SLOT_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	CP W0,#1			;;
	BRA LTU,$+4			;;
	RETURN				;;
	BRA W0				;;
	BRA U1RX_SLOT_00J		;;RETURN SLOT INF
        RETURN                          ;;        
U1RX_SLOT_00J:				;;
        MOV #10,W0                      ;;
        ADD TMR2,WREG                   ;;
        MOV W0,DELAY_ACT_TIM            ;;
        MOVLF #1,DELAY_ACT              ;;
        RETURN                          ;;
;;========================================


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CMD_ACT:			        ;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	CP W0,#8			;;
	BRA LTU,$+4			;;
	RETURN				;;
	BRA W0				;;
	BRA U1RX_CMD_00J		;;
	BRA U1RX_CMD_01J		;;
	BRA U1RX_CMD_02J		;;
	BRA U1RX_CMD_03J		;;
	BRA U1RX_CMD_04J		;;
	BRA U1RX_CMD_05J		;;
	BRA U1RX_CMD_06J		;;
	BRA U1RX_CMD_07J		;;
        RETURN                          ;;        
U1RX_CMD_00J:				;;
	MOV [W1++],W0			;;
        MOV W0,R0                       ;;SYSTEMFLAG0L
	MOV [W1++],W0			;;
        MOV W0,R1                       ;;SYSTEMFLAG0H
        
	MOV [W1++],W0			;;
        MOV W0,R2                       ;;SYSTEMFLAG0L
	MOV [W1++],W0			;;
        MOV W0,R3                       ;;SYSTEMFLAG0H
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSC R0,#6                      ;;
        BCF LOCAL_REMOTE_F              ;;
        BTSS R0,#6                      ;;
        BSF LOCAL_REMOTE_F              ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSC R0,#8                      ;;
        BSF LOAD_ANT_F                  ;;
        BTSS R0,#8                      ;;
        BCF LOAD_ANT_F                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR SP4T_CNT
        BTSC R0,#9
        BSET SP4T_CNT,#0
        BTSC R0,#10
        BSET SP4T_CNT,#1
        BTSC R0,#11
        BSET SP4T_CNT,#2
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
        CP WGBUF        
        BRA NZ,$+4
        BRA U1RX_CMD_00J_1              ;;
        MOV W0,WGBUF                    ;;
        AND #255,W0
	MOV W0,FREQCH			;;
        MOV WGBUF,W0
        SWAP W0
        AND #255,W0
	MOV W0,ATTENUATOR
        CALL SET_ATT                    ;;
        BRA U1RX_CMD_00J_1              ;;
        
U1RX_CMD_00J_1:				;;
        CALL U1TX_BACK
        RETURN

U1RX_CMD_01J:				;;
U1RX_CMD_02J:				;;
U1RX_CMD_03J:				;;
        RETURN                          ;;
U1RX_CMD_04J:				;;
        MOV RX_PARA0,W0                 ;;
        AND #255,W0                     ;;
        MOV W0,FREQCH                   ;;
        MOV RX_PARA1,W0                 ;;
        AND #255,W0                     ;;
        MOV W0,ATTENUATOR               ;;
        CALL SET_ATT                    ;;
        RETURN                          ;;
U1RX_CMD_05J:				;;
        RETURN                          ;;
U1RX_CMD_06J:				;;
U1RX_CMD_07J:				;;
        RETURN                          ;;
;;========================================






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_ACT_BIT:                            ;;
        MOV MY_ITEM_ID,W0               ;;
        SL W0,#2,W0                     ;;
        DEC2 W0,W0                      ;;
        CP0 RX_PARA0                    ;;
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
        ;MOV TX_SERIAL_BUF,W0            ;;
        ;CP RX_SERIAL_ID	       	;;
        ;BRA Z,$+4                       ;;
        ;RETURN                          ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,RX_GROUP_ID		;;
        MOV #0XAB00,W0                  ;;
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
;%2					;;
DECU2RX_1000J:				;;
        MOV #ADIN_BUF0,W1               ;;
        MOV RX_SERIAL_ID,W0             ;;
        AND #7,W0                       ;;
        ADD W0,W1,W1                    ;;
        ADD W0,W1,W1                    ;;
        MOV URX_PARA0,W0                ;;
        MOV W0,[W1]                     ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #ADIN_CLRT0,W1              ;;
        MOV RX_SERIAL_ID,W0             ;;
        AND #7,W0                       ;;
        ADD W0,W1,W1                    ;;
        ADD W0,W1,W1                    ;;
        CLR [W1]                        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV RX_SERIAL_ID,W0             ;;
        AND #7,W0                       ;;
        CALL BIT_TRANS                  ;;
        IOR URX_FLAG                    ;;
        
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;UTX_BUFFER_LEN         WORD LEN	;;
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
        MOV UACT_CNT,W0                 ;;
        CP W0,#1                        ;;
        BRA NZ,$+4                      ;;
        MOV #U2TX_BUF,W1		;;
        CP W0,#2                        ;;
        BRA NZ,$+4                      ;;
        MOV #MCUTX2_BUF,W1		;;
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
        MOV UACT_CNT,W0                 ;;
        AND #3,W0                       ;;
        BRA W0                          ;;
	BRA U1TX_END			;;
	BRA U2TX_END			;;
	BRA MCUTX2_END			;;
        RETURN                          ;;        
U1TX_END:				;;
	BSF U1TX_EN_F			;;
	BCF U1RX_EN_F			;;
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
        BSF U2TXON_F                    ;;
	BCF U2TX_END_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF UTX_BTX,U2TX_BTX		;;
	CLR U2TX_BCNT			;;
	BSET IFS1,#U2TXIF		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MCUTX2_END:				;;
        BSF MCUTX2_START_F              ;;
	MOVFF UTX_BTX,MCUTX2_BYTE	;;
	CLR MCUTX2_BIT_CNT		;;
	CLR MCUTX2_BYTE_CNT		;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1TX_END:                           ;;
	BTFSS U1TX_END_F                ;;
	RETURN                          ;;
	BTSS U1STA,#8                   ;;
	RETURN                          ;;
	BCF U1TX_END_F                  ;;
        BCF U1TXON_F                    ;;
        MOV #250,W0                     ;;
        ADD TMR2,WREG                   ;;
        MOV W0,U1TX_REPEAT_TIM          ;;
	RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2TX_END:                           ;;
	BTFSS U2TX_END_F                ;;
	RETURN                          ;;
	BTSS U2STA,#8                   ;;        
	RETURN                          ;;
	BCF U2TX_END_F                  ;;
        BCF U2TXON_F                    ;;
        MOV #300,W0                     ;;
        ADD TMR2,WREG                   ;;
        MOV W0,U2TX_REPEAT_TIM          ;;
	RETURN                          ;;
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




