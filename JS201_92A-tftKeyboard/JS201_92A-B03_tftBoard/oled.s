;******************************************************************************
;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 


	
 

        .equ __24ep64MC202, 1 ;
        .include "p24ep64MC202.inc"

;BY DEFINE=============================
	.EQU OLED_AMT_K		,92
	.EQU	SLAVE_DK	,1	
	.EQU	DATEST_DK	,1	
;	.EQU	U2TX_TEST_DK	,1	
;	.EQU 	IICM_DK		,1
;	.EQU 	IICS_DK		,1
;====================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'
	.EQU 	DEVICE_ID_K		,0x2304
	.EQU 	SERIAL_ID_K		,0x0000
	.EQU 	OLED_MAIN_DEVICE_ID_K	,0x2300

	.EQU 	F24SET_FADR	,0xA000	;DONT USE THE LAST BLOCK OF FLASH(0x0A800)
	.EQU 	FRAM_SIZE_K	,16	
	.EQU 	RX485_SYNC_K	,0xAAC6
;;=====================================================



;====================================
	.include "oledPindef.s";
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
  	.global __CNInterrupt  

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
	
.MACRO 	LXYB XX,YY,XD,YD
	MOV #\XX,W0
	MOV W0,LCDX
	MOV #\YY,W0
	MOV W0,LCDY
	MOV #\XD,W0
	MOV W0,LCDXE
	MOV #\YD,W0
	MOV W0,LCDYE
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


;************************                
.MACRO 	STWC XX
	BSF TFT_SCL_O
	BCF TFT_CS_O
	MOV #\XX,W0
	CALL STWCP
.ENDM
;-------------------------

;************************                
.MACRO 	STWEND
	BSF TFT_CS_O
.ENDM
;-------------------------

;************************                
.MACRO 	STWD XX
	MOV #\XX,W0
	CALL STWDP
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
;;====================================
TMP0:			.SPACE 2				
TMP1:			.SPACE 2				
TMP2:			.SPACE 2				
TMP3:			.SPACE 2				
TMP4:			.SPACE 2				
TMP5:			.SPACE 2				
TMP6:			.SPACE 2				
TMP7:			.SPACE 2				
TMP8:			.SPACE 2				
TMP9:			.SPACE 2				
TMP10:			.SPACE 2				
TMP11:			.SPACE 2				
TMP12:			.SPACE 2				
TMP13:			.SPACE 2				
TMP14:			.SPACE 2				
TMP15:			.SPACE 2				

PWM_BUF:			.SPACE 2				


IMAGE_W:			.SPACE 2				
IMAGE_H:			.SPACE 2				



TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2		

TMR3_BUF:		.SPACE 2		
TMR3_FLAG:		.SPACE 2		
TMR3_IORF:		.SPACE 2		

DELAY_CNT:		.SPACE 2		
DELAY_ACT:		.SPACE 2		

DARK_TFT_TIM:		.SPACE 2		

DIM_CNT:		.SPACE 2		
DIM_SET:		.SPACE 2		
DIMS_CNT:		.SPACE 2		
PRESET_ID:		.SPACE 2		
PRESET_ID_TIM:		.SPACE 2		


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
KBMODE_INX:		.SPACE 2
KBMODE_STEP:		.SPACE 2
KBMODE_TIM:		.SPACE 2
;;====================================
NOWKB_INX:		.SPACE 2
IMAGE_PAG:		.SPACE 2
SPEC_KEY_BUF:		.SPACE 32
;SERIAL_ID:		.SPACE 2
;SWITCH_KB_FLAG1:	.SPACE 2

CONVAD_CNT:		.SPACE 2
VR1BUF:			.SPACE 2
VR1V:			.SPACE 2
LCDX:			.SPACE 2
LCDY:			.SPACE 2
LCDX_LIM0:		.SPACE 2
LCDX_LIM1:		.SPACE 2
LCDY_LIM0:		.SPACE 2
LCDY_LIM1:		.SPACE 2
BMPX:			.SPACE 2
BMPY:			.SPACE 2
LCDXE:			.SPACE 2
LCDYE:			.SPACE 2
COLOR_B:		.SPACE 2
RAMSTR_BUF_PTR:		.SPACE 2
FONT_X:			.SPACE 2
FONT_Y:			.SPACE 2
STR_LEN:		.SPACE 2
COLOR_F:		.SPACE 2
FONT_WB:		.SPACE 2
FLASH_CNT:		.SPACE 2
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
KB_TYPE_CNT:		.SPACE 2
KB_PAGE_CNT:		.SPACE 2
KB_X256_CNT:		.SPACE 2
KB_X256_TH:		.SPACE 2
WPAGE_CNT:		.SPACE 2


FADR0:			.SPACE 2
FADR1:			.SPACE 2
DADR0:			.SPACE 2
DADR1:			.SPACE 2
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


SLEEP_TIM:		.SPACE 2

;DUTX_LEN:		.SPACE 2
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
PRE_RX_CMD:		.SPACE 2
RX_ADDR:		.SPACE 2
RX_FLAGS:		.SPACE 2
RX_LEN:			.SPACE 2
RX_CMD:			.SPACE 2	
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
COMV_CNT:		.SPACE 2
OLEDCUR_CNT:		.SPACE 2
OLED_POS:		.SPACE 2
OLED_INX:		.SPACE 2
OLED_GROUP_INX:		.SPACE 2

OLEDX12_BUF0:		.SPACE 2
OLEDX12_BUF1:		.SPACE 2
OLEDX12_BUF2:		.SPACE 2
OLEDX12_BUF3:		.SPACE 2
OLEDX12_BUF4:		.SPACE 2
OLEDX12_BUF5:		.SPACE 2
OLEDX12_BUF6:		.SPACE 2
OLEDX12_BUF7:		.SPACE 2
OLEDX12_BUF8:		.SPACE 2
OLEDX12_BUF9:		.SPACE 2
OLEDX12_BUF10:		.SPACE 2
OLEDX12_BUF11:		.SPACE 2
OLED_DATA:		.SPACE 2
;2TX_PACK_CNT:		.SPACE 2



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AICFUN_SET:		.SPACE 0		
;DALVOL_SET:		.SPACE 2;0		
;DARVOL_SET:		.SPACE 2;1
;HPLGAIN_SET:		.SPACE 2;2
;HPRGAIN_SET:		.SPACE 2;3
;LOLGAIN_SET:		.SPACE 2;4
;LORGAIN_SET:		.SPACE 2;5
;ADLVOL_SET:		.SPACE 2;6
;ADRVOL_SET:		.SPACE 2;7
;ADLGAIN_SET:		.SPACE 2;8
;ADRGAIN_SET:		.SPACE 2;9
;HPLROUT_SET:		.SPACE 2;10
;HPRROUT_SET:		.SPACE 2;11
;LOLROUT_SET:		.SPACE 2;12
;LORROUT_SET:		.SPACE 2;13
;ADLPROUT_SET:		.SPACE 2;14
;ADLNROUT_SET:		.SPACE 2;15
;ADRPROUT_SET:		.SPACE 2;16
;ADRNROUT_SET:		.SPACE 2;17
;DACFILTER_SET:		.SPACE 2;18
;ADCFILTER_SET:		.SPACE 2;19
;;=================================
;DOUTR_FUN:		.SPACE 2;0
;CODTX_SWCNT:		.SPACE 2;1
;U1TX_SWCNT:		.SPACE 2;2
;U2TX_SWCNT:		.SPACE 2;3
;FUNROUT_SET:		.SPACE 2
AICFUN_END:		.SPACE 0		
.EQU AICFUN_SET_LIMK	,(AICFUN_END-AICFUN_SET)/2	
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;;========================================


;######################################
FSET_BUF:		.SPACE 0 ;256
SERIAL_ID:			.SPACE 2
DIMS_SET:		.SPACE 2
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
SET_SPARE:		.SPACE (128+FSET_BUF-SET_END)
;=================================
NOWKEY_STA0:		.SPACE 2
NOWKEY_STA1:		.SPACE 2
NOWKEY_STA2:		.SPACE 2
NOWKEY_STA3:		.SPACE 2

NOWKEY_STA_BUF:		.SPACE 8*OLED_AMT_K
CHKSUM_BUF:             .SPACE 3*8*4                      
;KEYHEAD_TMP:		.SPACE 512
;BYTE0-BIT3~0 NOWPAGE
;BYTE0-BIT4~0 LOAD OK
;BYTE4 CHKSUM0
;BYTE5 CHKSUM1
;BYTE6 CHKSUM2
;BYTE7 CHKSUM3


END_REG:		.SPACE 2




.EQU STACK_BUF		,0x1F00	
.EQU U1RX_BUFSIZE	,640	;
.EQU U1RX_BUFA		,0x2000	;
.EQU U1RX_BUFB		,0x2280	;
.EQU U1TX_BUF		,0x2500	;
.EQU FLASH_BUF		,0x2600 ; 

.EQU KB_HEAD_BUF	,0x2A00 ;512 

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
.EQU OLEDX12_F		,FLAGA
.EQU OLEDX12_F_P	,1
.EQU OLEDXALL_F		,FLAGA
.EQU OLEDXALL_F_P	,2
.EQU FLASH_AB_F		,FLAGA
.EQU FLASH_AB_F_P	,3
.EQU FLASH_QPI_F	,FLAGA
.EQU FLASH_QPI_F_P	,4
.EQU TFT_BK_F  	        ,FLAGA	
.EQU TFT_BK_F_P	        ,5
.EQU VIEW_F		,FLAGA
.EQU VIEW_F_P		,6
;EQU SLAVE_F		,FLAGA
;EQU SLAVE_F_P		,7
.EQU ERR_F		,FLAGA
.EQU ERR_F_P		,8
.EQU OK_F		,FLAGA
.EQU OK_F_P		,9
;.EQU ERR_F		,FLAGA
;.EQU ERR_F_P		,10
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
.EQU DISKP_F		,FLAGB
.EQU DISKP_F_P		,0
.EQU NOKEY_F		,FLAGB
.EQU NOKEY_F_P		,1
.EQU DISKR_F		,FLAGB
.EQU DISKR_F_P		,2
.EQU KEY_PUSH_F		,FLAGB
.EQU KEY_PUSH_F_P	,3
.EQU STRLEN_F		,FLAGB
.EQU STRLEN_F_P		,4
.EQU RAMSTR_F		,FLAGB
.EQU RAMSTR_F_P		,5
;.EQU DISKR_F		,FLAGB
;.EQU DISKR_F_P		,6
.EQU DISKC_F		,FLAGB
.EQU DISKC_F_P		,7
;.EQU DISKK_F		,FLAGB
;.EQU DISKK_F_P		,8
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


DISABLE_DEVICE:
	CLRWDT
	BCF TFT_BK_F			;;
	BCF RS485_CTL_O			;;
	BCF RS485_CTL_IO		;;
	BRA DISABLE_DEVICE
		


	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
POWER_ON:			;;
        MOV #STACK_BUF,W15  	;;Initialize the Stack Pointer Limit Register
        MOV #STACK_BUF+254,W0  	;;Initialize the Stack Pointer Limit Register
        MOV W0,SPLIM		;;
        CALL CLR_WREG 		;;
	CALL CLR_ALLREG		;;
	CLR ANSELA		;;
	CLR ANSELB		;;
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
	MOV #FSET_BUF,W2	;;	
	CALL LF24_F24SET	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TEST_FLASH_ID	;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLASH_EXITQPI	;;

	;CALL FLASH_SETQE
	NOP
	NOP
	;CALL FLASH_RDSR				;;
	NOP
	NOP
	;CALL FLASH_CLRQE
	NOP
	NOP
	;CALL FLASH_RDSR				;;
	NOP
	NOP			;;
	NOP			;;
	CALL INIT_TIMER1	;;
	CALL INIT_TIMER2	;;
	CALL INIT_TIMER3	;;
	CALL INIT_UART1		;;
	;CALL INIT_UART2	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CALL TEST_TIMER	;;
	;CALL TEST_UART		;;
	;CALL TEST_UART_I	;;
	;CALL TEST_FLASH_QPI	;;
	;CALL TEST_FLASH	;;
	;CALL TEST_FLASH_PGM	;;
	;CALL TEST_OLED_A	;;
	;CALL TEST_OLED_G	;;
	;CALL TEST_OLED_H	;;
	;CALL TEST_TFT		;;
	;CALL TEST_IMAGE	;;
	;CALL TEST_SLEEP	;;
	CLR PWM_BUF		;;
	CALL SET_PWM		;;
	;CALL INIT_PWM		;;
	CALL CHK_FLASH_ID	;;
	BTSS SR,#Z		;;
        GOTO FLASH_ERR_PRG      ;;    
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL GET_KEYHEAD        ;;        
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



WDT_ENABLE:
	BSET RCON,#SWDTEN
	RETURN
WDT_DISABLE:
	BSET RCON,#SWDTEN
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__CNInterrupt:				;;
	;PUSH SR			;;
	;PUSH W0			;;
	BCLR IFS1,#CNIF			;;
	BCLR IEC1,#CNIE
	;POP W0				;;
	;POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	
TEST_SLEEP:
CHK_SLEEP:
	CP0 PRESET_ID_TIM
	BRA Z,$+4
	CLR SLEEP_TIM
	BTFSS KEY_IN_I
	CLR SLEEP_TIM
	BTFSS RS485_RO_I
	CLR SLEEP_TIM
	MOV #500,W0
	CP SLEEP_TIM
	BRA GEU,SLEEP_PRG
	RETURN 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SLEEP_PRG:				;;
	CALL WDT_DISABLE		;;	
	;MOV #0x00E0,W0			;;
	;IOR SR				;;
	BCLR INTCON2,#GIE		;;
	BSET CNENB,#CNIEB0		;;SW
	BSET CNENB,#CNIEB9		;;UART RX
	BCLR IFS1,#CNIF			;;
	BSET IEC1,#CNIE			;;
	;CALL WDT_ENABLE		;;	
	;PWRSAV #SLEEP_MODE		;;
	PWRSAV #IDLE_MODE		;;
	NOP				;;
	NOP				;;
	NOP				;;
	NOP				;;
	BCLR IFS1,#CNIF			;;
	BCLR IEC1,#CNIE			;;
	;MOV #0xFF1F,W0			;;
	;AND SR				;;
SLEEP_1:
	BTFSS RS485_RO_I
	BRA SLEEP_1
	NOP
	NOP
	NOP
	BSET INTCON2,#GIE		;;
	CALL WDT_ENABLE			;;	
	CLR SLEEP_TIM			;;
	NOP				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_PWM:				;;
	MOV #0x1006,W0;T1		;;
	MOV W0,OC1CON1			;;
	MOV #0x000B,W0;T1		;;
	MOV W0,OC1CON2			;;
	MOV PWM_BUF,W0			;;
	MOV W0,OC1R			;;
	MOV PWM_BUF,W0			;;
	MOV #10000,W0			;;
	MOV W0,PR1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
INIT_PWM:
	;MOV #0x0406,W0;T3
	MOV #0x1006,W0;T1
	MOV W0,OC1CON1
	;MOV #0x000D,W0;T3
	MOV #0x000B,W0;T1
	MOV W0,OC1CON2
	MOV DIM_SET,W0
	INC W0,W0
	MOV W0,R0
	MOV #2048,W0
	MUL R0
	MOV W2,R0
	MOV R0,W0
	INC DIMS_SET
	LSR W0,#4,W0
	MUL DIMS_SET
	DEC DIMS_SET 
	MOV W2,OC1R
	MOV #10000,W0
	MOV W0,PR1
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_BKL:			;;
        BTFSC TFT_BK_F		;;
	BRA SET_BKL_1
	CP0 PWM_BUF
	BRA NZ,$+4
 	RETURN
	CLR PWM_BUF
	CALL SET_PWM
	RETURN 
SET_BKL_1:
	INC DIM_SET
	MOV #2048,W0
	MUL DIM_SET
	DEC DIM_SET
	MOV W2,W0
	INC DIMS_SET
	LSR W0,#4,W0
	MUL DIMS_SET
	DEC DIMS_SET 
	MOV W2,W0
	CP PWM_BUF
	BRA NZ,$+4
	RETURN
	MOV W0,PWM_BUF
	CALL SET_PWM
	RETURN 



	

;66MPS
TEST_OSC:
	TG TP0_O
	TG TP0_O
	TG TP0_O
	TG TP0_O
	TG TP0_O
	TG TP0_O
	TG TP0_O
	TG TP0_O
	CLRWDT
	BRA TEST_OSC	

;1MS
TEST_TIMER:
	CLRWDT
	BTSS TMR2,#8
	BCF TP0_O
	BTSC TMR2,#8
	BSF TP0_O
	BRA TEST_TIMER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART:				;;
	BSF RS485_CTL_O			;;
	MOV #'B',W0	;;
	MOV W0,U1TXREG			;;
	;CALL U1TX_RSP			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1TX_END:				;;
	BTFSS RS485_CTL_O		;;
	RETURN				;;
	BTFSS U1TX_END_F		;;
	RETURN				;;
	BTSS U1STA,#TRMT		;;			
	RETURN				;;
	BCF U1TX_END_F			;;
	BCF RS485_CTL_O			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART_I:				;;
	CLRWDT
	BTFSS RS485_CTL_O
	BRA TEST_UART_IX
	BTFSS U1TX_END_F			;;
	BRA TEST_UART_I
	BTSS U1STA,#TRMT
	BRA TEST_UART_I
	BCF U1TX_END_F
	BCF RS485_CTL_O		;;
			
TEST_UART_IX:
	MOV #0xFFFF,W0			;;	
	CALL DLYX			;;
	MOVLF #0x0123,UTX_CMD
	MOVLF #0x0224,UTX_PARA0
	MOVLF #0x0325,UTX_PARA1
	MOVLF #0x0426,UTX_PARA2
	MOVLF #0x0527,UTX_PARA3
	CALL UTX_STD
	BRA TEST_UART_I		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SWITCH_KB_FLAG:			;;
	MOV #SPEC_KEY_BUF,W1		;;
	MOV #0,W2			;;
	MOV #15,W0			;;
	REPEAT W0			;;
	MOV W2,[W1++]			;;	
	MOV #SPEC_KEY_BUF+8,W1		;;
	MOV #0x0E0D,W0			;;
	MOV W0,[W1++]			;;
	MOV #0x100F,W0			;;
	MOV W0,[W1++]			;;
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
	AND #7,W0			;;
	BRA Z,LSKF_1			;;
	BTSC R0,#0			;;
	SWAP W0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SPEC_KEY_BUF,W1		;;
	MOV R0,W2			;;
	ADD W2,W1,W1
	BCLR W1,#0			;;
	MOV [W1],W2			;;
	ADD W0,W2,W0			;;
	MOV W0,[W1]			;;
LSKF_1:					;;
	INC R0				;;
	MOV #7,W0			;;
	CP R0				;;
	BRA LTU,LSKF_0			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OLED_RESTART:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_KEYHEAD:                            ;;
        CLR FADR0                       ;;
        CLR FADR1                       ;;
	MOV #KB_HEAD_BUF,W1	        ;;
	MOV #512,W2		        ;;
	CALL READ_FLASH		        ;;
        CALL GET_KEY_CHKSUM             ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_ERR_PRG:                          ;;
	CALL INIT_LCD			;;
	CALL INIT_LCDLIM		;;	
	CALL CLRSCR			;;
	BSF TFT_BK_F			;;
        MOVLF #0xFFFF,COLOR_F             ;;        
        LXY 0,0                         ;;
        LOFFS1 FLASH_ERROR_STR          ;;
	BCF RAMSTR_F			;;
	CALL ENSTR			;;
	BSF U1RX_EN_F			;;
        BRA MAIN_LOOP                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	NOP
	NOP
	NOP
	CALL INIT_LCD			;;
	CALL INIT_LCDLIM		;;	
	CALL CLRSCR			;;
	BCF TFT_BK_F			;;
	BCF VIEW_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;CALL SHOW_ID			;;
	;BSF TFT_BK_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL OLED_RESTART		;;
	;ALL SHOW_IFNOID		;;
	;CLR PRESET_ID			;;	
	;CALL PRE_SAVE_ID		;;
	BSF U1RX_EN_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
	CLRWDT				;;
	;CALL CHK_SLEEP			;;
	CALL SET_BKL			;;
	CALL CHK_U1TX_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL KEYBO			;;
	CALL MAINK_PRG			;;
	CALL TMR2PRG			;;	
	CALL TMR3PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL DELAY_ACT_PRG		;;
	CALL CHK_U1RX			;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MAINK_PRG:
	CP0 R0
	BRA NZ,MAINK_PUSH
	CP0 R1
	BRA NZ,MAINK_FREE
	RETURN
MAINK_PUSH:
	BCF TFT_BK_F			;;
	RETURN
MAINK_FREE:
	BTFSC VIEW_F
	BSF TFT_BK_F			;;
	RETURN




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	CLR R0				;;	
	CLR R1				;;
	CLR R2				;;
	CLR R3				;;
	BTFSS T4M_F			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W0				;;
	BTFSS KEY_IN_I			;;
	BSET W0,#0			;;
	CP0 W0				;;
	BRA NZ,YESKEY			;; 	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NOKEY:					;;
	INC NOKEY_CNT			;;
	MOV #3,W0			;;
	CP NOKEY_CNT		        ;;
	BTSS SR,#C			;;
	RETURN				;;
	BSF NOKEY_F			;;		
	MOV KEY_BUF,W0			;;
	BTFSS DISKR_F			;;
	MOV W0,R1			;;
	BCF DISKR_F			;;
	BCF DISKP_F			;;
	BCF DISKC_F			;;
	CLR KEY_BUF			;;
	CLR YESKEY_CNT			;;
	CLR CONKEY_CNT			;; 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
YESKEY:					;;
	CLR NOKEY_CNT			;;
	INC YESKEY_CNT			;;		
	PUSH W0				;;
	MOV #2,W0			;;
	CP YESKEY_CNT			;;
	POP W0				;;
	BTSS SR,#C			;;
	RETURN				;;
	BCF NOKEY_F			;;		
	DEC YESKEY_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP KEY_BUF			;;
	BRA Z,CONKEY			;;
	BTFSC DISKP_F			;;
	RETURN				;;
	MOV W0,KEY_BUF			;;
	MOV W0,R0			;;
	CLR CONKEY_CNT			;; 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONKEY:					;;
	INC CONKEY_CNT			;;
	PUSH W0				;;
	MOV #100,W0			;;
	CP CONKEY_CNT 			;;
	POP W0				;;
	BTSS SR,#Z			;;
	BRA CONKEY_1			;;
	;BSF DISKR_F			;;
	BTFSS DISKC_F			;;
	MOV W0,R2			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONKEY_1:				;;
	PUSH W0				;;
	MOV #250,W0			;;
	CP CONKEY_CNT 			;;
	POP W0				;;
	BTSS SR,#Z			;;
	RETURN				;;
	BTFSS DISKC_F			;;
	MOV W0,R3			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INIT_KB_IMAGE:
	MOV #NOWKEY_STA_BUF,W1
	CLR W2
INIT_KB_IMAGE_1:
	MOV #0,W0
	MOV W0,[W1++]	
	MOV W0,[W1++]	
	MOV #0xAB,W0
	MOV W0,[W1++]	
	MOV #0xCD,W0
	MOV W0,[W1++]	
	INC W2,W2
	MOV #OLED_AMT_K,W0
	CP W2,W0
	BRA LTU,INIT_KB_IMAGE_1
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
UTX_KEYP_PRG:
	NOP
	NOP
	NOP
	MOV #FLASH_TMP,W1
	CALL READ_FLASH_PAGE
	MOV #FLASH_TMP,W3
	MOV [W3++],W0
	INC2 W0,W0
	AND #0x1FF,W0
	MOV W0,UTX_BUFFER_LEN
	MOV #0x4000,W0
	MOV W0,UTX_CMD
	MOV #FLASH_TMP,W3
	MOV R0,W0
	MOV W0,[W3]	
	CALL UTX_BUFFER
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PRE_SAVE_ID:				;;
	MOVLF #8000,PRESET_ID_TIM	;;
	BSF TFT_BK_F			;;
	MOV #0x0000,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
	MOVLF #15,DIMS_SET		;;
	MOVLF #4,DIM_SET		;;
	BSF OK_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOVLF #0x07FF,COLOR_F           ;;        
        LXY 0,0                         ;;
        LOFFS1 SAVE_IDM_STR	        ;;
	BCF RAMSTR_F			;;
	CALL ENSTR			;;
	MOV PRESET_ID,W0		;;	
	INC W0,W0			;;
	CALL L1D_3B			;;
	MOV #' ',W0			;;
	CALL ENCHR			;;
	MOV R1,W0			;;
	CALL ENNUM			;;
	MOV R0,W0			;;
	CALL ENNUM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	

SET_DIM_SET:
	MOV URX_PARA0,W0
	AND #255,W0
	MOV W0,DIM_SET
	BSF OK_F			;;
	RETURN				;;


SPEC_KEY_DIM_UP:
LIGHT_UP_PRG:
	INC DIM_SET
	MOV #5,W0
	CP DIM_SET
	BRA LTU,$+4
	CLR DIM_SET
	BSF OK_F			;;
	RETURN				;;
	
SPEC_KEY_DIM_DOWN:
LIGHT_DOWN_PRG:
	DEC DIM_SET
	MOV #5,W0
	CP DIM_SET
	BRA LTU,$+6
	MOV #4,W0
	MOV W0,DIM_SET
	BSF OK_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHOW_DIMS:				;;
	BSF TFT_BK_F			;;
	MOV #0x0000,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
        MOVLF #0xFFFF,COLOR_F           ;;        
        LXY 0,0                         ;;
        LOFFS1 TFT_DIM_SET_STR		;;
	BCF RAMSTR_F			;;
	CALL ENSTR	
	MOV DIMS_SET,W0
	INC W0,W0
	CALL L1D_3B			;;
	MOV #' ',W0			;;
	CALL ENCHR			;;
	MOV R1,W0			;;
	CALL ENNUM			;;
	MOV R0,W0			;;
	CALL ENNUM			;;

	LXY 14,20
	MOVLF #30,BMPX
	MOVLF #36,BMPY
	MOV #0xF800,W0			;;
	MOV W0,COLOR_B			;;
	CALL DISP_BLK

	LXY 44,20
	MOVLF #40,BMPX
	MOVLF #36,BMPY
	MOV #0xFFFF,W0			;;
	MOV W0,COLOR_B			;;
	CALL DISP_BLK


	LXY 84,20
	MOVLF #30,BMPX
	MOVLF #36,BMPY
	MOV #0x07E0,W0			;;
	MOV W0,COLOR_B			;;
	CALL DISP_BLK
        MOVLF #0x0000,COLOR_B           ;;        


	RETURN

	

SHOW_ID:
	BSF TFT_BK_F			;;
	MOV #0x0000,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
	MOVLF #15,DIMS_SET
	MOVLF #4,DIM_SET
	BSF OK_F

        MOVLF #0xFFFF,COLOR_F             ;;        
        LXY 16,16                         ;;
        LOFFS1 IDM_STR		        ;;
	BCF RAMSTR_F			;;
	CALL ENSTR			;;
	MOV #OLED_AMT_K,W0
 	CP SERIAL_ID
	BRA LTU,$+4
	BRA SHOW_ID_1
	MOV SERIAL_ID,W0
	INC W0,W0		
	CALL L1D_3B
	MOV #' ',W0
	CALL ENCHR
	MOV R1,W0
	CALL ENNUM
	MOV R0,W0
	CALL ENNUM
	RETURN
SHOW_ID_1:
	MOV #'-',W0
	CALL ENCHR
	MOV #'-',W0
	CALL ENCHR
	MOV #'-',W0
	CALL ENCHR
	RETURN

DIMS_UP_PRG:
	INC DIMS_SET
	MOV #16,W0
	CP DIMS_SET
	BRA LTU,$+4
	CLR DIMS_SET

	MOV #DIMS_SET,W1	;;	
	CALL SAVE_F24WORD	;;

        MOVLF #0xFFFF,COLOR_F           ;;        
        MOVLF #0x0000,COLOR_B           ;;        
        LXY 0,0                         ;;
        LOFFS1 TFT_DIM_SET_STR		;;
	BCF RAMSTR_F			;;
	CALL ENSTR	
	MOV DIMS_SET,W0
	INC W0,W0
	CALL L1D_3B			;;
	MOV #' ',W0			;;
	CALL ENCHR			;;
	MOV R1,W0			;;
	CALL ENNUM			;;
	MOV R0,W0			;;
	CALL ENNUM			;;

	BSF OK_F			;;
	RETURN				;;
	
DIMS_DOWN_PRG:
	DEC DIMS_SET
	MOV #16,W0
	CP DIMS_SET
	BRA LTU,$+6
	MOV #15,W0
	MOV W0,DIMS_SET

	MOV #DIMS_SET,W1	;;	
	CALL SAVE_F24WORD	;;


        MOVLF #0xFFFF,COLOR_F           ;;        
        MOVLF #0x0000,COLOR_B           ;;        
        LXY 0,0                         ;;
        LOFFS1 TFT_DIM_SET_STR		;;
	BCF RAMSTR_F			;;
	CALL ENSTR	
	MOV DIMS_SET,W0
	INC W0,W0
	CALL L1D_3B			;;
	MOV #' ',W0			;;
	CALL ENCHR			;;
	MOV R1,W0			;;
	CALL ENNUM			;;
	MOV R0,W0			;;
	CALL ENNUM			;;


	BSF OK_F			;;
	RETURN				;;


OLED_ALL_ALL:
	RETURN
LOAD_KEY_ACT:
	RETURN



DARK_TEST_KEY:
	RETURN

KBMODE3_KPUSH:
	MOV R0,W0
	DEC W0,W0
	MOV W0,TESTOLED_CNT
	CALL DARK_TEST_KEY
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















	

	
KEYNOP:
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
TMR3PRG:				;;
	CLR TMR3_FLAG			;;	
	MOV TMR3,W0			;;
	XOR TMR3_BUF,WREG		;;	
	BTSC SR,#Z			;;
	RETURN				;;
	MOV W0,TMR3_FLAG		;;	
	IOR TMR3_IORF			;;
	XOR TMR3_BUF			;;
	CLRWDT				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY_ACT_PRG:				;;
	BTSS TMR3_FLAG,#T1M_F_P		;;
	RETURN
	MOV DELAY_ACT,W0
	BRA W0			
	BRA DACT_PRG0
	BRA DACT_PRG1
DACT_PRG0:
	RETURN
;CHECK FLASH STAUS
DACT_PRG1:
	CP0 DELAY_CNT
	BRA Z,$+6
	DEC DELAY_CNT
	RETURN	
	CLR DELAY_ACT
	CALL FLASH_RDSR			;;
	MOV #0,W0			;;BUSY
	BTSS SPIBUF,#0			;;
	MOV #1,W0			;;READY
	MOV W0,UTX_PARA0		;;
	CALL UTX_RESP			;;
	RETURN



TIME1M_PRG:
	INC SLEEP_TIM
	BRA NZ,$+4
	DEC SLEEP_TIM
	CP0 DARK_TFT_TIM
	BRA Z,TIME1M_1
	DEC DARK_TFT_TIM
	CP0 DARK_TFT_TIM
	BRA NZ,$+4
	BSF TFT_BK_F	
TIME1M_1:
	CP0 PRESET_ID_TIM
	BRA Z,TIME1M_2
	BTFSC KEY_IN_I
	BRA TIME1M_1A	
	MOVFF PRESET_ID,SERIAL_ID
	MOV #SERIAL_ID,W1	;;	
	CALL SAVE_F24WORD	;;
	CLR PRESET_ID_TIM
	CALL SHOW_ID
	BRA TIME1M_2	

TIME1M_1A:
	DEC PRESET_ID_TIM
	BRA NZ,TIME1M_2
	CALL SHOW_ID
	BRA TIME1M_2
TIME1M_2:
	RETURN


	.EQU CMD_NONE_K			,0
	.EQU CMD_STOPALL_K		,1
	.EQU CMD_FLASH_ERASE_K		,2
	.EQU CMD_CHK_FLASH_BLANK_K	,3
	.EQU CMD_CHK_FLASH_STATUS_K	,4
TIMEACT_PRG:
	BTFSC T1M_F
	CALL TIME1M_PRG
	BTFSS T16M_F			;;
	RETURN
	MOV CMDINX,W0
	BRA W0			
	BRA CMD_NONE_PRG
	BRA CMD_STOPALL_PRG
	BRA CMD_FLASH_ERASE_PRG
	BRA CMD_CHK_FLASH_BLANK_PRG
	BRA CMD_CHK_FLASH_STATUS

CMD_NONE_PRG:
	RETURN
CMD_STOPALL_PRG:
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_CHK_FLASH_STATUS:			;;
	CP0 CMDTIME			;;
	BRA Z,CMD_CHK_FLASH_STATUS_0	;;
	DEC CMDTIME			;;
	RETURN				;;
CMD_CHK_FLASH_STATUS_0:			;;
	MOVLF #4,CMDTIME		;;
	CALL FLASH_RDSR			;;
	BTSS SPIBUF,#0			;;
	BRA CMD_CHK_FLASH_STATUS_1	;;
	MOVLF 0xFFFF,COLOR_F		;;
	MOVLF 112,LCDX			;;
	MOV FLASH_CNT,W0		;;	
	SWAP.B W0			;;
	CALL ENNUM			;;
	MOV FLASH_CNT,W0		;;	
	CALL ENNUM			;;
	INC FLASH_CNT			;;
	RETURN				;;
CMD_CHK_FLASH_STATUS_1:			;;
	MOVLF 0x07E0,COLOR_F		;;
	MOVLF 112,LCDX			;;
	MOV #'O',W0			;;
	CALL ENCHR			;;
	MOV #'K',W0			;;
	CALL ENCHR			;;
	CLR CMDINX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_FLASH_ERASE_PRG:			;;	
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
	CALL FLASH_RDSR			;;
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
	MOV #0x0ACD,W0			;;
	MOV W0,UTX_PARA1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL FLASH_RDSR			;;
	BTSS SPIBUF,#0			;;
	BRA $+8				;;
	CALL UTX_I_AM_BUZY		;;
	RETURN				;;
	NOP
	NOP
	CALL UTX_I_AM_DONE		;;
	INC CMDSTEP			;;
	RETURN				;;
CFEP_2:					;;
	MOV #CMD_STOPALL_K,W0		;;
	MOV W0,CMDINX			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CMD_CHK_FLASH_BLANK_PRG:		;;	
	BTFSC U1TX_EN_F			;;
	RETURN				;;
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
	MOV W0,UTX_PARA1		;;
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
	CLR CMDSTEP			;;
	RETURN				;;
CCFBP_3:				;;CHECK ERROR
	CALL UTX_I_AM_DONE		;;		
	MOV #CMD_STOPALL_K,W0		;;
	MOV W0,CMDINX			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		



	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER1:				;;
        CLR TMR1                        ;;
	MOV #0x8010,W0			;;0.13US
	MOV W0,T1CON			;;
        ;MOV #100,W0                     ;;
        ;MOV W0,PR1                      ;;
        ;BCLR IFS0,#3			;;
        ;BSET IEC0,#3                    ;;  	          
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER3:				;;
	MOV #0xA030,W0			;;0.13US
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
	MOV #41,W0		;;RP41 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR3		;;
	MOV #0x0001,W0		;;RP40 U1TX
	IOR RPOR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR1		;;
	MOV #0x0010,W0		;;OC1
	IOR RPOR1		;;
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
	MOV #35,W0	;460800		;;66MHZ
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
	MOVLF #4,DIM_SET		;;MAX=31			
	MOVLF #15,DIMS_SET		;;MAX=31			
	MOVLF #31,COMV_CNT		;;MAX=31			
	MOVLF #15,OLEDCUR_CNT		;;MAX=15			
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
	BSF KEY_IN_IO			;;
	BSET CNPUB,#0			;;PULL_UP
	;;PIN2 				;;
	BCF NC2_O			;;
	BCF NC2_IO			;;
	;;PIN3 				;;
	;;PIN4 				;;
	;;PIN5 				;;
	;;PIN6 				;;
	;;PIN7 				;;
	BCF TFT_CS_O			;;
	BCF TFT_CS_IO			;;
	;;PIN8	 			;;
	BCF TFT_BK_O			;;
	BCF TFT_BK_IO			;;
	;;PIN9	 			;;
	BCF TFT_RST_O			;;
	BCF TFT_RST_IO			;;
	;;PIN11	 			;;
	BCF TFT_SCL_O			;;
	BCF TFT_SCL_IO			;;
	;;PIN12	 			;;
	BCF TFT_A0_O			;;
	BCF TFT_A0_IO			;;
	;;PIN13	 			;;
	BCF TFT_SDA_O			;;
	BCF TFT_SDA_IO			;;
	;;PIN14 			;;
	BSF RS485_DI_O			;;
	BCF RS485_DI_IO			;;
	;;PIN15 			;;
	BSF RS485_RO_IO			;;
	;;PIN18 			;;
	BCF RS485_CTL_O			;;
	BCF RS485_CTL_IO		;;
	;;PIN19 			;;
	BCF FLASH_SCK_O			;;
	BCF FLASH_SCK_IO		;;
	;;PIN20 			;;
	BCF FLASH_D0_O			;;
	BCF FLASH_D0_IO			;;
	;;PIN21 			;;
	BCF FLASH_D1_O			;;
	BCF FLASH_D1_IO			;;
	;;PIN22 			;;
	BCF FLASH_D2_O			;;
	BCF FLASH_D2_IO			;;
	;;PIN23 			;;
	BCF FLASH_D3_O			;;
	BCF FLASH_D3_IO			;;
	;;PIN27 			;;
	BSF FLASHA_CS_O			;;
	BCF FLASHA_CS_IO		;;
	;;PIN23 			;;
	BCF TP0_O			;;
	BCF TP0_IO			;;
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
	MOV SERIAL_ID,W2		;;
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
	PUSH W1				;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA0		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA1		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA2		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA3		;;	
	POP W1				;;
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
	GOTO URXDEC_TFT_ACT		;;
	CP W0,#0x30			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_TEST_ACT		;;


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

URXDEC_TEST_ACT:
	MOV RX_CMD,W0			;;
	AND #3,W0		        	;;
	BRA W0				;;
	BRA URXDEC_TESTJ0		;;0
	BRA URXDEC_TESTJ1		;;1
	BRA URXDEC_TESTJ2		;;2
	BRA URXDEC_TESTJ3		;;3
        NOP
        NOP
        NOP
        RETURN

URXDEC_TESTJ0:
URXDEC_TESTJ1:
URXDEC_TESTJ2:
URXDEC_TESTJ3:
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



LOAD_W1_BYTE:
	BTSC W1,#0
	BRA LOAD_W1_BYTE_1
	MOV [W1],W0	
	AND #255,W0		
	INC W1,W1
	RETURN
LOAD_W1_BYTE_1:
	BCLR W1,#0
	MOV [W1],W0	
	SWAP W0
	AND #255,W0		
	INC2 W1,W1
	RETURN
 
LOAD_W1_WORD:
	PUSH W2
	CALL LOAD_W1_BYTE
	MOV W0,W2
	CALL LOAD_W1_BYTE
	SWAP W0
	IOR W0,W2,W0	
	POP W2
	RETURN
	
	

;$1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT:				;;
	MOV RX_CMD,W0
	AND #255,W0
	CP W0,#20 
	BRA LTU,$+4			;;
	RETURN				;;
	BRA W0				;;
	BRA URXDEC_TFT_ACT0		;;CLR SCR WITH COLOR
	BRA URXDEC_TFT_ACT1		;;CLR SCR DISP STRING
	BRA URXDEC_TFT_ACT2		;;DISP STRING 
	BRA URXDEC_TFT_ACT3		;;SHOW NEXT_IMAGE
	BRA URXDEC_TFT_ACT4		;;SHOW IMAGEA
	BRA URXDEC_TFT_ACT5		;;SHOW IMAGEB
	BRA URXDEC_TFT_ACT6		;;EMU KEY ACTION
	BRA URXDEC_TFT_ACT7		;;LIGHT UP
	BRA URXDEC_TFT_ACT8		;;LIGHT DOWN
	BRA URXDEC_TFT_ACT9		;;SET DIM
	BRA URXDEC_TFT_ACT10		;;DIMS UP
	BRA URXDEC_TFT_ACT11		;;DIMS DOWN
	BRA URXDEC_TFT_ACT12		;;SHOW ID
	BRA URXDEC_TFT_ACT13		;;SHOW DIMS
	BRA URXDEC_TFT_ACT14		;;SAVE_ID
	BRA URXDEC_TFT_ACT15		;;RESET
	RETURN
	RETURN
	RETURN
	RETURN
	RETURN
	RETURN
	RETURN
	RETURN

URXDEC_TFT_ACT0:			;;
	BSF TFT_BK_F			;;
	MOVFF URX_PARA0,COLOR_B		;;
	CALL CLRSCR
	CLR KB_TYPE_CNT			;;
	CLR KB_PAGE_CNT			;;
	RETURN
TEST_STR:
	.ASCII "TEST\0"
FLASH_ERROR_STR:
	.ASCII "FLASH ERROR !!!\0"
IDM_STR:
	.ASCII "ID: \0"

SAVE_IDM_STR:
	.ASCII "SAVE ID: \0"


TFT_DIM_SET_STR:
	.ASCII "TFT DIM SET: \0"

NO_ID_STR:
	.ASCII "NO ID !!!\0"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT1:			;;
	BSF TFT_BK_F			;;
	MOVLF #0x0000,COLOR_B		;;
	CALL CLRSCR			;;
URXDEC_TFT_ACT2:			;;
	BSF TFT_BK_F			;;
	MOV RX_ADDR,W1			;;
	ADD #18,W1			;;
URXDEC_TFT_ACT1_1:			;;
	CALL LOAD_W1_WORD		;;
	MOV #0xABCD,W2			;;
	CP W0,W2			;;
	BRA Z,$+4			;;
	RETURN				;;
	CALL LOAD_W1_BYTE		;;	
	MOV W0,LCDX			;;
	CALL LOAD_W1_BYTE		;;
	MOV W0,LCDY			;;
	CALL LOAD_W1_WORD		;;
	MOV W0,COLOR_F			;;
	BSF RAMSTR_F			;;
	CALL ENSTR			;;
	BRA URXDEC_TFT_ACT1_1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
URXDEC_TFT_ACT3:                        ;;
	BSF TFT_BK_F			;;
	CALL NEXT_IMAGE                 ;;
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT4:			;;
	MOV #OLED_AMT_K,W0		;;
	CP SERIAL_ID			;;
	BRA LTU,$+4			;;
	RETURN				;;
	MOVFF URX_PARA0,KB_PAGE_CNT	;;
	MOVFF URX_PARA1,KB_TYPE_CNT	;;
URXDEC_TFT_ACT4_0:			;;
	CALL SHOW_IMAGE			;;
	BTFSC ERR_F			;;
        BRA URXDEC_TFT_ACT4_1           ;;
	BSF TFT_BK_F			;;
	RETURN				;;
URXDEC_TFT_ACT4_1:			;;
	BCF TFT_BK_F			;;
	MOV #0x0000,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT5:			;;
	MOV #OLED_AMT_K,W0		;;
	CP SERIAL_ID			;;
	BRA LTU,$+4			;;
	RETURN				;;
	MOV URX_PARA0,W0		;;
	AND #255,W0			;;
	MOV W0,DIM_SET			;;
	MOV RX_ADDR,W1			;;
	ADD #18,W1			;;
	MOV SERIAL_ID,W0		;;
	ADD W0,W1,W1			;;
	CALL LOAD_W1_1B			;;
	BTSC W0,#7			;;
	BRA URXDEC_TFT_ACT4_1		;;
	PUSH W0				;;
	AND #7,W0			;;
	MOV W0,KB_PAGE_CNT		;;
	POP W0				;;
	SWAP.B W0			;;
	AND #7,W0			;;
	MOV W0,KB_TYPE_CNT		;;
	BRA URXDEC_TFT_ACT4_0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT6:			;;
	MOVFF URX_PARA0,DARK_TFT_TIM	;;
	BCF TFT_BK_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT7:			;;
        CALL LIGHT_UP_PRG               ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT8:			;;
        CALL LIGHT_DOWN_PRG             ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT9:			;;
	CALL SET_DIM_SET		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT10:			;;
        CALL DIMS_UP_PRG                ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT11:			;;
        CALL DIMS_DOWN_PRG              ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT12:			;;
        CALL SHOW_ID	                ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT13:			;;
        CALL SHOW_DIMS	                ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT14:			;;
	MOV URX_PARA0,W0		;;
	MOV W0,PRESET_ID		;;	
        CALL PRE_SAVE_ID                ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TFT_ACT15:			;;
	GOTO POWER_ON
	RESET				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_FLASH_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #15,W0			;;
	BRA W0				;;
	BRA URXDEC_ERASE_FLASH		;;0
	BRA URXDEC_CHK_FLASH_BLANK	;;1
	BRA URXDEC_PROGRAM_FLASH	;;2
	BRA URXDEC_VERIFY_FLASH		;;3
	BRA URXDEC_ERASE_FLASH_SIMP	;;4
	BRA URXDEC_CHK_FLASH_STATUS	;;5
	BRA URXDEC_PROGRAM_FLASH_SIMP	;;6
	BRA URXDEC_PROGRAM_IMAGE	;;7
	BRA URXDEC_PROGRAM_IMAGE_DONE	;;8
	BRA URXDEC_GET_KEY_CHKSUM	;;9
        RETURN                          ;;10
        RETURN                          ;;11
        RETURN                          ;;12
        RETURN                          ;;13
        RETURN                          ;;14
        RETURN                          ;;15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_ERASE_FLASH_SIMP:		;;	
	CALL ERASE_FRAM_ALL		;;
	MOV #CMD_CHK_FLASH_STATUS_K,W0	;;
	MOV W0,CMDINX			;;
	CLR CMDSTEP			;;
	CLR CMDTIME			;;
	CLR FLASH_CNT			;;			
        CALL GET_KEYHEAD                ;;        
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CHK_FLASH_STATUS:		;;
	CLR TMR3			;;
	CLR TMR3			;;
	MOV TMR3,W0			;;
	MOV W0,TMR3_BUF			;;	
	MOVLF #1,DELAY_ACT		;;
	MOV URX_PARA0,W0		;;
	MUL SERIAL_ID			;;
	MOV URX_PARA0,W0		;;
	ADD W2,W0,W0			;;	
	MOV W0,DELAY_CNT		;;
	MOVFF RX_CMD,PRE_RX_CMD		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_ERASE_FLASH:			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
	MOV #CMD_FLASH_ERASE_K,W0	;;	
	MOV W0,CMDINX			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
URXDEC_CHK_FLASH_BLANK:			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
	MOV #CMD_CHK_FLASH_BLANK_K,W0	;;	
	MOV W0,CMDINX			;;
	CLR CMDSTEP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
URXDEC_PROGRAM_FLASH_SIMP:		;;
	MOV RX_ADDR,W1			;;
	ADD #10,W1			;;
	MOV [W1++],W0			;;
	MOV W0,FADR0			;;
	MOV [W1++],W0			;;
	MOV W0,FADR1			;;//PACK CNT
	MOV [W1++],W0			;;
	MOV W0,URX_PARA2		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF FADR0,R0			;;
	MOVFF FADR1,R1			;;
	MOV W1,R2			;;
	CLR R3				;;
UPFS_0:					;;
	MOVFF R0,FADR0			;;
	MOVFF R1,FADR1			;;
	MOV R2,W1			;;
	CALL FLASH_PGM			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF R0,FADR0			;;	
	MOVFF R1,FADR1			;;
	MOV R2,W1			;;
	CALL FLASH_VERIFY		;;
	BTFSS ERR_F			;;
	BRA UPFS_1			;;
	INC R3				;;
	MOV #4,W0			;;
	CP R3				;;
	BRA LTU,UPFS_0			;;
	MOVFF RX_CMD,PRE_RX_CMD		;;
	MOV #0,W0			;;
	MOV W0,UTX_PARA0		;;	
	CALL UTX_RESP			;;
	RETURN				;;	
UPFS_1:					;;
	MOVFF RX_CMD,PRE_RX_CMD		;;
	MOV #1,W0			;;
	MOV W0,UTX_PARA0		;;	
	BCF U1U2_F			;;
	CALL UTX_RESP			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_GET_KEY_CHKSUM:		        ;;
	MOVFF RX_CMD,PRE_RX_CMD		;;
        MOV #224,W0                     ;;
        MOV #96,W0                     ;;
	MOV W0,UTX_BUFFER_LEN		;;
        MOV #CHKSUM_BUF,W3              ;;
        CALL UTX_BUFFER_RESP            ;;
	RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_PROGRAM_IMAGE_DONE:		;;
	MOVLF 0x07E0,COLOR_F		;;
	MOVLF #112,LCDX			;;
	MOV #'O',W0			;;
	CALL ENCHR			;;
	MOV #'K',W0			;;
	CALL ENCHR			;;
	CLR FADR0			;;
	CLR FADR1			;;
	MOV #KB_HEAD_BUF,W1		;;
	CALL SAVE_FLASH_256B		;;			
	MOV #10000,W0		        ;;
	CALL DLYX		        ;;
	MOV #KB_HEAD_BUF+256,W1		;;
	CALL SAVE_FLASH_256B		;;
        CALL GET_KEYHEAD                ;;        
	RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_PROGRAM_IMAGE:			;;
	MOV RX_ADDR,W1			;;
	ADD #10,W1			;;
	MOV [W1++],W0			;;
	PUSH W0				;;
	AND #7,W0			;;
	MOV W0,KB_PAGE_CNT		;;
	POP W0				;;
	SWAP W0				;;
	AND #7,W0			;;
	MOV W0,KB_TYPE_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,KB_X256_CNT		;;	
	MOV [W1++],W0			;;
	MOV W0,KB_X256_TH		;;	
	MOV [W1++],W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KB_X256_CNT,W0		;;
	IOR KB_TYPE_CNT,WREG		;;
	IOR KB_PAGE_CNT,WREG		;;
	CP0 W0				;;
	BRA NZ,UPI_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1000,W0			;;
	MOV W0,DADR0			;;	
	CLR DADR1			;;
	CLR WPAGE_CNT			;;
	MOV #KB_HEAD_BUF,W1		;;
	CLR W0				;;
	REPEAT #255			;;
	MOV W0,[W1++]			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UPI_1:					;;
	CP0 KB_X256_CNT			;;
	BRA NZ,UPI_2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CP0 KB_TYPE_CNT
        BRA Z,XXUU
        NOP
        NOP
        NOP
	CP0 WPAGE_CNT
	BRA Z,XXUU
	NOP
	NOP
	NOP	
XXUU:
	MOV #256,W0			;;	
	MUL WPAGE_CNT			;;
	MOV W2,W0			;;
	ADD DADR0			;;
	MOV W3,W0			;;
	ADDC DADR1			;;
	CLR WPAGE_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #64,W0			;;
	MUL KB_TYPE_CNT			;;
	MOV W2,W4			;;
	MOV #8,W0			;;
	MUL KB_PAGE_CNT			;;
	MOV W2,W0			;;
	ADD W2,W4,W4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #0x01FF,W4			;;
	MOV #KB_HEAD_BUF,W1		;;
	ADD W4,W1,W1			;;
	MOV #0xCDAB,W0			;;
	MOV W0,[W1++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W1++]			;;
	MOV DADR0,W0			;;
	MOV W0,[W1++]			;;
	MOV DADR1,W0			;;	
	MOV W0,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UPI_2:					;;
	MOV #256,W0			;;
	MUL KB_X256_CNT			;;
	MOV W2,W0			;;
	ADD DADR0,WREG			;;
	MOV W0,FADR0			;;
	MOV W3,W0			;;
	ADDC DADR1,WREG			;;
	MOV W0,FADR1			;;
	INC WPAGE_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
UPI_3:					;;
	MOV RX_ADDR,W1			;;
	ADD #18,W1			;;
	CALL SAVE_FLASH_256B		;;			
	BTFSS ERR_F			;;
	BRA UPI_4			;;
	MOVFF RX_CMD,PRE_RX_CMD		;;
	MOVLF #0,W0			;;
	MOV W0,UTX_PARA0		;;	
	CALL UTX_RESP			;;
	RETURN				;;	
UPI_4:					;;
	MOVFF RX_CMD,PRE_RX_CMD		;;
	MOVLF #1,W0			;;
	MOV W0,UTX_PARA0		;;	
	BCF U1U2_F			;;
	CALL UTX_RESP			;;
	MOVLF #112,LCDX			;;
	MOV KB_X256_CNT,W0		;;
	SWAP.B W0			;;
	CALL ENNUM			;;
	MOV KB_X256_CNT,W0		;;	
	CALL ENNUM			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;IN FADR0,FADR1,W1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_FLASH_256B:			;;
	PUSH R0				;;
	PUSH R1				;;
	PUSH R2				;;
	PUSH R3				;;
	BCF ERR_F			;;
	MOVFF FADR0,R0			;;
	MOVFF FADR1,R1			;;
	MOV W1,R2			;;
	CLR R3				;;
SAVE_FLASH_256B_1:			;;
	MOVFF R0,FADR0			;;
	MOVFF R1,FADR1			;;
	MOV R2,W1			;;
	CALL FLASH_PGM			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVFF R0,FADR0			;;	
	MOVFF R1,FADR1			;;
	MOV R2,W1			;;
	CALL FLASH_VERIFY		;;
	BTFSS ERR_F			;;
	BRA SAVE_FLASH_256B_OK		;;
	INC R3				;;
	MOV #3,W0			;;
	CP R3				;;
	BRA LTU,SAVE_FLASH_256B_1	;;
SAVE_FLASH_256B_ERR:			;;
	BSF ERR_F			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_FLASH_256B_OK:			;;
	POP R3				;;
	POP R2				;;
	POP R1				;;
	POP R0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

URXDEC_PROGRAM_FLASH:			;;
	BCF U1U2_F			;;
	CALL UTX_I_HAVE_REC		;;
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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR SR,#C			;;
	RRC FADR1			;;
	RRC FADR0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_PROGRAM_FLASH_1:			;;
	CALL FLASH_PGM			;;
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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_VERIFY_FLASH_1:			;;
	CALL FLASH_VERIFY_QPI		;;
	BTFSS ERR_F			;;
	BRA $+8				;;
	CALL UTX_I_AM_ERR		;;
	RETURN				;;	
	;MOV #256,W0			;;
	;SUB URX_PARA0			;;
	;BRA GTU,URXDEC_VERIFY_FLASH_1	;;
	CALL UTX_I_HAVE_REC		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;$2



	
















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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIOUT_QPI:			;;	
	MOV #0xF000,W5		;;
	BSF FLASH_SCK_O		;;
	MOV W0,W4		;;
	BCF FLASH_SCK_O		;;
	SWAP W0			;;
 	XOR LATB,WREG		;;
	AND W5,W0,W0		;;
	XOR LATB		;;
	NOP			;;
	NOP			;;
	BSF FLASH_SCK_O		;;
	NOP			;;
	NOP			;;
	BCF FLASH_SCK_O		;;
	MOV W4,W0		;;
	SWAP.B W0
	SWAP W0			;;
 	XOR LATB,WREG		;;
	AND W5,W0,W0		;;
	XOR LATB		;;
	NOP			;;
	NOP			;;
	BSF FLASH_SCK_O		;;
	RETURN			;;
				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	

SPIOUT:
	BTFSC FLASH_QPI_F
	BRA SPIOUT_QPI
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
SPIIN_QPI:			;;
	MOV #0xF000,W0		;;
	IOR TRISB		;;
	NOP			;;
	BCF FLASH_SCK_O		;;
	NOP
	NOP
	NOP			;;
	MOV PORTB,W0		;;
	SWAP W0			;;	
	BSF FLASH_SCK_O		;;
	AND #0xF0,W0		;;
	MOV W0,W2		;;
	BCF FLASH_SCK_O		;;
	NOP			;;
	NOP			;;
	NOP			;;
	NOP			;;
	MOV PORTB,W0		;;
	SWAP W0			;;
	SWAP.B W0		;;
	AND #0x0F,W0		;;
	IOR W0,W2,W0		;;	
	MOV W0,SPIBUF		;;	
	BSF FLASH_SCK_O		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	

SPIIN:
	BTFSC FLASH_QPI_F
	BRA SPIIN_QPI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIIN_A:			;;
	CLRWDT			;;
	BSF FLASH_SCK_O		;;
	CLR SPIBUF		;;
	;;========================
	BCF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_SCK_O		;;
	RLC SPIBUF		;;
	BCLR SPIBUF,#0		;;
	BTFSC FLASHA_DO_I	;;
	BSET SPIBUF,#0		;;
	BSF FLASH_SCK_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPIBUF,W0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FLASH_ID:				;;
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
	MOV SPIBUFA,W2
	MOV SPIBUFB,W3
	CALL SPIIN			;;
	MOV W0,R5			;;
	CALL SET_FCS			;;
	MOV #0xEF,W0			;;
	CP R4				;;
	BTSC SR,#Z			;;
	RETURN				;;
	MOV #0xC2,W0			;;
	CP R4				;;
	BTSC SR,#Z			;;
	RETURN				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_FLASH:					;;
	BCF FLASH_AB_F				;;
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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF FLASH_AB_F				;;
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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL CHK_FLASH_ID
	NOP
	NOP
	CALL FLASH_EXITQPI	
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
	BSF ERR_F			;;
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
FLASH_VERIFY_QPI_1:			;;
	CALL SPIIN			;;
	MOV [W1++],W0			;;
	CP SPIBUF			;;
	BRA NZ,FLASH_VERIFY_QPI_ERR	;;
	INC FADR0			;;
	BTSC SR,#Z			;;
	INC FADR1			;;
	MOV.B FADR0,WREG		;;
	BRA NZ,FLASH_VERIFY_QPI_1	;;
	CALL SET_FCS			;;
	BCF ERR_F			;;
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
	CALL SPIOUT			;;
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
	CALL SPIIN			;;
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
READ_FLASH_8B:				;;
	MOV #FLASH_TMP,W1		;;
	MOV #8,W2			;;
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
CLR_FCSA:
	BSF FLASHA_DO_IO
	BSF FLASHA_WP_O
	BCF FLASHA_WP_IO
	BSF FLASHA_HOLD_O
	BCF FLASHA_HOLD_IO
	BCF FLASHA_CS_O
	RETURN	
CLR_FCSAB:
	PUSH W0
	MOV #0x0FFF,W0
	AND TRISB
	BCF FLASHA_CS_O
	POP W0
	RETURN


SET_FCS:
	BTFSC FLASH_QPI_F
	BRA SET_FCSAB
SET_FCSA:
	BSF FLASHA_CS_O
	BCF FLASH_D0_IO
	BCF FLASH_D1_IO
	BCF FLASH_D2_IO
	BCF FLASH_D3_IO
	RETURN	

SET_FCSAB:
	BSF FLASHA_CS_O
	PUSH W0
	MOV #0x0FFF,W0
	AND TRISB
	BCF FLASHA_CS_O
	POP W0
	RETURN	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
READ_FLASH:				;;
	PUSH R7				;;
	MOV W2,R7			;;
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
	CALL SPIIN			;;
	MOV W0,[W1++]			;;
	DEC R7				;;
	BRA NZ,READ_FLASH_QPI_2		;;
	CALL SET_FCS			;;
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
	BSF FLASH_QPI_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_EXITQPI:				;;
	BSF FLASH_QPI_F			;;
	CALL CLR_FCS			;;
	MOV #0x00FF,W0			;;
	CALL SPIOUT			;;
	CALL SET_FCS			;;
	BCF FLASH_QPI_F			;;
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
UTX_RESP:				;;
	MOV PRE_RX_CMD,W0		;;
	BSET W0,#15			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
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
UTX_BUFFER_RESP:			;;
	MOV PRE_RX_CMD,W0		;;
	BSET W0,#15			;;
	MOV W0,UTX_CMD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_BUFFER:				;;
	CALL UTX_START			;;
	MOV #DEVICE_ID_K,W0		;;
	CALL LOAD_UTX_BYTE		;;
	MOV #DEVICE_ID_K,W0		;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SERIAL_ID,W0		;;SERIAL ID
	CALL LOAD_UTX_BYTE		;;
	MOV SERIAL_ID,W0		;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00,W0			;;FLAG
	CALL LOAD_UTX_BYTE		;;
	MOV #0x00,W0			;;FLAG
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_BUFFER_LEN,W0		;;
	ADD #2,W0			;;
	CALL LOAD_UTX_BYTE		;;
	MOV UTX_BUFFER_LEN,W0		;;
	ADD #2,W0			;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_CMD,W0			;;
	CALL LOAD_UTX_BYTE		;;
	MOV UTX_CMD,W0			;;	
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_BUFFER_1:				;;
	MOV [W3],W0			;;
	CALL LOAD_UTX_BYTE		;;
	MOV [W3++],W0			;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	DEC UTX_BUFFER_LEN		;;
	BRA NZ,UTX_BUFFER_1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL UTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_STD:				;;
	CALL UTX_START			;;
	MOV #DEVICE_ID_K,W0		;;
	CALL LOAD_UTX_BYTE		;;
	MOV #DEVICE_ID_K,W0		;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SERIAL_ID,W0		;;SERIAL ID
	CALL LOAD_UTX_BYTE		;;
	MOV SERIAL_ID,W0		;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00,W0			;;FLAG
	CALL LOAD_UTX_BYTE		;;
	MOV #0x00,W0			;;FLAG
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0			;;LEN LOW BYTE
	CALL LOAD_UTX_BYTE		;;
	MOV #0,W0			;;LEN HIGH BYTE
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_CMD,W0			;;
	CALL LOAD_UTX_BYTE		;;
	MOV UTX_CMD,W0			;;	
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA0,W0		;;
	CALL LOAD_UTX_BYTE		;;
	MOV UTX_PARA0,W0		;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA1,W0		;;
	CALL LOAD_UTX_BYTE		;;
	MOV UTX_PARA1,W0		;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA2,W0		;;
	CALL LOAD_UTX_BYTE		;;
	MOV UTX_PARA2,W0		;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA3,W0		;;
	CALL LOAD_UTX_BYTE		;;
	MOV UTX_PARA3,W0		;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
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
	BSF RS485_CTL_O			;;
	BTFSC U1U2_F			;;
	BRA U2TX_END			;;
U1TX_END:				;;
	MOVFF UTX_BTX,U1TX_BTX		;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BCF U1TX_END_F			;;
	BSET IFS0,#U1TXIF		;;
	RETURN				;;
U2TX_END:				;;
	MOVFF UTX_BTX,U2TX_BTX		;;
	CLR U2TX_BCNT			;;
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
	CLR SLEEP_TIM			;;
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
	CLR SLEEP_TIM			;;
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
	BSF U1TX_END_F
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
        INC DIMS_CNT            ;;
        MOV #9,W0		;;
        CP DIMS_CNT		;;
        BRA LTU,T1I_1		;;
        CLR DIMS_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC DIM_CNT		;;
	MOV #5,W0		;;
	CP DIM_CNT		;;
	BRA LTU,T1I_1		;;
	CLR DIM_CNT		;;
T1I_1:				;;
        MOV DIM_SET,W0		;;0~4
        CP DIM_CNT		;;
        BRA GTU,T1I_OVER	;;	
        BTFSS TFT_BK_F		;;
	BRA T1I_OVER		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV DIMS_SET,W0		;;0~9
        CP DIMS_CNT		;;
        BRA GTU,T1I_OVER		;;	
        BSF TFT_BK_O		;;
	BRA T1I_END	
T1I_OVER:                       ;;	
        BCF TFT_BK_O            ;;
T1I_END:                        ;;
	POP.S			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	



			





;$4



CASET:
	STWC 0x2A
	STWD 0x00
	MOV LCDX,W0
	ADD #2,W0
	CALL STWDP
	STWD 0x00
	MOV LCDXE,W0
	ADD LCDX,WREG
	DEC W0,W0
	ADD #2,W0
	CALL STWDP
	STWEND
	RETURN

RASET:
	STWC 0x2B
	STWD 0x00
	MOV LCDY,W0
	ADD #3,W0
	CALL STWDP
	STWD 0x00
	MOV LCDYE,W0
	ADD LCDY,WREG
	DEC W0,W0
	ADD #4,W0
	CALL STWDP
	STWEND
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CRASET_LIM:			;;
	STWC 0x2A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWD 0x00		;;
	MOV LCDX_LIM0,W0	;;	
	CP LCDX			;;
	BRA LT,$+4		;;
	MOV LCDX,W0		;;
	PUSH W0			;;
	ADD #2,W0		;;	
	CALL STWDP		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWD 0x00		;;
	POP W0			;;
	ADD LCDXE,WREG		;;
	DEC W0,W0		;;
	CP LCDX_LIM1		;;	
	BRA GT,$+4		;;
	MOV LCDX_LIM1,W0	;;
	ADD #2,W0		;;	
	CALL STWDP		;;
	STWEND			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0x2B		;;
	STWD 0x00		;;
	MOV LCDY_LIM0,W0	;;	
	CP LCDY			;;
	BRA LT,$+4		;;
	MOV LCDY,W0		;;
	PUSH W0			;;
	ADD #3,W0		;;
	CALL STWDP		;;
	STWD 0x00		;;
	POP W0			;;
	ADD LCDYE,WREG		;;
	DEC W0,W0		;;
	CP LCDY_LIM1		;;	
	BRA GT,$+4		;;
	MOV LCDY_LIM1,W0	;;	
	ADD #3,W0		;;
	CALL STWDP		;;
	STWEND			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0x36 		;;     
	STWD 0xC4  		;;
	STWEND			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CRASET:				;;
	CALL CASET		;;
	CALL RASET		;;
	STWC 0x36 		;;     
	STWD 0xC0 		;; 
	STWEND			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STWCP:				;;
	BCF TFT_A0_O		;;	
	NOP			;;
	BSF TFT_SDA_O		;;
	BTSS W0,#7		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#6		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#5		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;	
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#4		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#3		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;	
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#2		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#1		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#0		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STWDP16:			;;
	BSF TFT_A0_O		;;
	BSF TFT_SDA_O		;;
	BTSS W0,#15		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;	
	BTSS W0,#14		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#13		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#12		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#11		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#10		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#9		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#8		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
STWDP:				;;
	BSF TFT_A0_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#7		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#6		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#5		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#4		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#3		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#2		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#1		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#0		;;
	BCF TFT_SDA_O		;;
	BCF TFT_SCL_O		;;
	BSF TFT_SCL_O		;;
	RETURN			;;



















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
XXXSTWDP16:			;;
	BSF TFT_A0_O		;;
	BSF TFT_SDA_O		;;
	BTSS W0,#15		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;	
	BTSS W0,#14		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#13		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#12		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#11		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#10		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#9		;;
	BCF TFT_SDA_O		;;
	NOP			;;	
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#8		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
XXXSTWDP:				;;
	BSF TFT_A0_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#7		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#6		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#5		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#4		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#3		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#2		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#1		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF TFT_SDA_O		;;
	BTSS W0,#0		;;
	BCF TFT_SDA_O		;;
	NOP			;;
	BCF TFT_SCL_O		;;
	NOP			;;
	BSF TFT_SCL_O		;;
	NOP			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;STRDP32:
	PUSH W2
	BSF TFT_A0_O
	MOV #32,W2
	BRA STRDP_0
STRDP24:
	PUSH W2
	BSF TFT_A0_O
	MOV #24,W2
	BRA STRDP_0
STRDP16:
	PUSH W2
	BSF TFT_A0_O
	MOV #16,W2
	BRA STRDP_0
STRDP8:
	PUSH W2
	BSF TFT_A0_O
	MOV #8,W2
STRDP_0:
	BSF TFT_SDA_IO
STRDP_1:
	BCF TFT_SCL_O
	BSET SR,#C
	BTFSS TFT_SDA_I
	BCLR SR,#C
	BSF TFT_SCL_O
	RLC W0,W0
	RLC W1,W1
	DEC W2,W2
	BRA NZ,STRDP_1
	BSF TFT_CS_O
	POP W2
	BCF TFT_SDA_IO
 	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_ST7735:					;;
	BSF TFT_SCL_O				;;
	CALL RESET_LCD				;;
	STWC 0x11 ;;//Sleep out			;;
	MOV #120,W0				;;
	CALL DLYMX				;;
	STWC 0xB1 ;				;;
	STWD 0x05 ;				;;
	STWD 0x3C ;				;;
	STWD 0x3C ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xB2 ;				;;
	STWD 0x05 ;				;;
	STWD 0x3C ;				;;
	STWD 0x3C ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xB3 ;				;;
	STWD 0x05 ;				;;
	STWD 0x3C ;				;;
	STWD 0x3C ;				;;
	STWD 0x05 ;				;;
	STWD 0x3C ;				;;
	STWD 0x3C ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xB4 ; //Column inversion		;;
	STWD 0x07 ;				;;
	STWEND					;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xB6 ; //Extend gate non-overlaptim;;
	STWD 0xB4 ;				;;
	STWD 0xF0 ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xC0 ;				;;
	STWD 0xAE ;				;;	
	STWD 0x0E ;				;;
	STWD 0x04 ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xC1 ;				;;	
	STWD 0xC0 ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xC2 ;				;;
	STWD 0x0A ;				;;
	STWD 0x00 ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xC3 ;				;;
	STWD 0x8A ;				;;
	STWD 0x26 ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xC4 ;				;;
	STWD 0x8A ;				;;
	STWD 0xEE ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xC5 ; //VCOM			;;
	STWD 0x01 ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xe0 ;				;;
	STWD 0x03 ;				;;
	STWD 0x1D ;				;;
	STWD 0x08 ;				;;
	STWD 0x0D ;				;;
	STWD 0x36 ;				;;
	STWD 0x33 ;				;;
	STWD 0x2C ;				;;
	STWD 0x2F ;				;;
	STWD 0x2C ;				;;
	STWD 0x2A ;				;;
	STWD 0x32 ;				;;
	STWD 0x3C ;				;;
	STWD 0x00 ;				;;
	STWD 0x01 ;				;;
	STWD 0x03 ;				;;
	STWD 0x0F ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0xe1 ;				;;
	STWD 0x03 ;				;;
	STWD 0x1D ;				;;
	STWD 0x08 ;				;;
	STWD 0x0D ;				;;
	STWD 0x2F ;				;;
	STWD 0x2C ;				;;
	STWD 0x28 ;				;;
	STWD 0x2D ;				;;
	STWD 0x2C ;				;;
	STWD 0x2A ;				;;
	STWD 0x32 ;				;;
	STWD 0x3D ;				;;
	STWD 0x00 ;				;;
	STWD 0x01 ;				;;	
	STWD 0x01 ;				;;
	STWD 0x0F ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0x36 ;     			;;
	;STWD 0xC0 ; 				;;
	STWD 0x04 ; 				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0x3A ; //65k mode			;;
	STWD 0x05 ;				;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0x20 ;				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWEND					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0x29 ; //Display on		;;
	STWEND					;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_IMAGE_HEAD:				;;	
	MOV #KB_HEAD_BUF,W1			;;
	MOV #512,W2				;;
	CALL READ_FLASH				;;	
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_IMAGE_ADDR:				;;
	BSF ERR_F			;;
	MOV #KB_HEAD_BUF,W1		;;
	MOV #64,W0			;;
	MUL KB_TYPE_CNT			;;		
	ADD W2,W1,W1			;;
	MOV #8,W0			;;
	MUL KB_PAGE_CNT			;;
	ADD W2,W1,W1			;;
	MOV #0xCDAB,W2			;;		
	MOV [W1++],W0			;;
	CP W0,W2			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV [W1++],W0			;;
	MOV [W1++],W0			;;
	MOV W0,FADR0			;;	
	MOV [W1++],W0			;;
	MOV W0,FADR1			;;	
	BCF ERR_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_KEY_CHKSUM:                         ;;
        PUSH R0                         ;;
        CLR KB_TYPE_CNT                 ;;
        CLR KB_PAGE_CNT                 ;;
        MOV #CHKSUM_BUF,W1              ;;
        MOV #0xFFAB,W0                  ;;
        REPEAT #111                     ;;
        MOV W0,[W1++]                   ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR R0                          ;;
GKC_0:                                  ;;
	CALL GET_IMAGE_ADDR		;;
	BTFSC ERR_F			;;
        BRA GKC_1                       ;;
	MOV #TMP0,W1			;;
	MOV #16,W2                      ;;
	CALL READ_FLASH			;;
	MOV #0xCDAB,W0			;;
	CP TMP0				;;
	BRA NZ,GKC_1			;;
        MOV #CHKSUM_BUF,W1              ;;
        MOV R0,W0                       ;;
        SL W0,#2,W0                     ;;
        ADD W0,W1,W1                    ;;
        MOV TMP6,W0                     ;;
        MOV W0,[W1++]                   ;;
        MOV TMP7,W0                     ;;
        MOV W0,[W1++]                   ;;
GKC_1:                                  ;;
        INC R0                          ;;
        INC KB_PAGE_CNT                 ;;
        MOV #8,W0                       ;;
        CP KB_PAGE_CNT                  ;;
        BRA LTU,GKC_0                   ;;
        CLR KB_PAGE_CNT                 ;;
        INC KB_TYPE_CNT                 ;;
        MOV #7,W0                       ;;
        CP KB_TYPE_CNT                  ;;
        BRA LTU,GKC_0                   ;;
        CLR KB_TYPE_CNT                 ;;
        POP R0                          ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_IMAGE_ERR:                          ;;
	CALL GET_IMAGE_ADDR		;;
	BTFSC ERR_F			;;
        RETURN                          ;;
	MOV #TMP0,W1			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #16,W2			;;
	CALL READ_FLASH			;;
	MOV #0xCDAB,W0			;;
	CP TMP0				;;
	BRA Z,$+4			;;
	BSF ERR_F			;;
	RETURN          		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                
        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHOW_IMAGE_DARK:			;;
        MOV #0x0000,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHOW_IMAGE:				;;
	;CALL GET_IMAGE_ADDR		;;
	;BTFSC ERR_F			;;
	;BRA SHOW_IMAGE_DARK     	;;
	;MOV #TMP0,W1			;;
	;MOV #16,W2			;;
	;CALL READ_FLASH        	;;
	;MOV #0xCDAB,W0			;;
	;CP TMP0			;;
	;BRA Z,$+6			;;
	;BSF ERR_F			;;
	;BRA SHOW_IMAGE_DARK		;;
        CALL CHK_IMAGE_ERR
        BTFSC ERR_F
        BRA SHOW_IMAGE_DARK
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TMP4,W0			;;
	MOV W0,IMAGE_W			;;
	MOV TMP5,W0			;;
	MOV W0,IMAGE_H			;;
	PUSH R7				;;
	PUSH R6				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF VIEW_F			;;
	LXYB 0,0,128,128		;;
	CALL CRASET			;;
	STWC 0x2C			;;
	MOV #128,W3			;;
CLRSCR_1X:				;;
	CALL READ_FLASH_PAGE		;;
	MOV #128,W4			;;
	MOV #FLASH_TMP,W1		;;
CLRSCR_2X:				;;
	CLRWDT				;;
	MOV [W1++],W0			;;
	CALL STWDP16			;;
	DEC W4,W4			;;
	BRA NZ,CLRSCR_2X		;;
	DEC W3,W3			;;
	BRA NZ,CLRSCR_1X		;;
	STWEND				;;
	POP R6				;;
	POP R7				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;













;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TFT_START:				;;
	LXYB 0,0,128,64			;;
	CALL CRASET			;;
	STWC 0x2C			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TFT_POINT:				;;
	CALL STWDP16			;;
	RETURN				;;
TFT_END:				;;
	STWEND				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INC_IMAGE_CNT:
	INC KB_PAGE_CNT
	MOV #8,W0
	CP KB_PAGE_CNT
	BRA GEU,$+4
	RETURN
	CLR KB_PAGE_CNT
	INC KB_TYPE_CNT
	MOV #7,W0
	CP KB_TYPE_CNT
	BRA GEU,$+4
	RETURN
	CLR KB_TYPE_CNT
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NEXT_IMAGE:				;;
	CLR R7				;;
NEXT_IMAGE_0:				;;
	CALL INC_IMAGE_CNT              ;;
        NOP
        NOP
        NOP
        NOP
        NOP
        CALL CHK_IMAGE_ERR              ;;
        BTFSC ERR_F                     ;;
        BRA NEXT_IMAGE_1                ;;
	CALL SHOW_IMAGE			;;
	RETURN				;;
NEXT_IMAGE_1:				;;
	INC R7				;;
	MOV #64,W0			;;
	CP R7				;;
	BRA LTU,NEXT_IMAGE_0		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_IMAGE:				;;
	BCF TFT_BK_F			;;
	CALL INIT_LCD			;;
	BSF TFT_BK_F			;;
	CLR KB_TYPE_CNT			;;
	CLR KB_PAGE_CNT			;;
	CLR FADR0
	CLR FADR1
	MOV #KB_HEAD_BUF,W1		;;
	MOV #512,W2			;;
	CALL READ_FLASH			;;
	NOP
	NOP
	NOP
TEST_IMAGE_1:				;;
	CALL SHOW_IMAGE			;;
	BTFSC ERR_F			;;	
	BRA TEST_IMAGE_2		;;
	MOV #1000,W0			;;
	CALL DLYMX			;;
TEST_IMAGE_2:				;;
	INC KB_PAGE_CNT			;;
	MOV #8,W0			;;
	CP KB_PAGE_CNT			;;
	BRA LTU,TEST_IMAGE_1		;;	
	CLR KB_PAGE_CNT			;;
	INC KB_TYPE_CNT			;;
	MOV #7,W0			;;
	CP KB_TYPE_CNT			;;
	BRA LTU,TEST_IMAGE_1		;;
	CLR KB_TYPE_CNT			;;
	BRA LTU,TEST_IMAGE_1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_TFT:				;;
	BCF TFT_BK_F			;;
	CALL INIT_LCD			;;
	BSF TFT_BK_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
TEST_TFT_1:				;;
	MOV #0xFFFF,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
	MOV #300,W0 			;;
	CALL DLYMX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x001F,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
	MOV #300,W0 			;;
	CALL DLYMX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x07E0,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
	MOV #300,W0 			;;
	CALL DLYMX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xF800,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
	MOV #300,W0 			;;
	CALL DLYMX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0000,W0			;;
	MOV W0,COLOR_B			;;
	CALL CLRSCR			;;
	MOV #300,W0 			;;
	CALL DLYMX			;;	
	BRA TEST_TFT			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_LCD:					;;
	CALL INIT_ST7735			;;
	RETURN 					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DARKSCR:				;;
	CLR COLOR_B			;;
CLRSCR:					;;
	BSF VIEW_F			;;
	LXYB 0,0,128,128		;;
	CALL CRASET			;;
	STWC 0x2C			;;
	MOV #128,W3			;;
CLRSCR_1:				;;
	MOV #128,W4			;;
CLRSCR_2:				;;
	CLRWDT				;;
	MOV COLOR_B,W0			;;
	CALL STWDP16			;;
	DEC W4,W4			;;
	BRA NZ,CLRSCR_2			;;
	DEC W3,W3			;;
	BRA NZ,CLRSCR_1			;;
	STWEND				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




DISP_BLK:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DBLK:				;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH LCDX		;;
	PUSH LCDY		;;
	MOV BMPX,W0 		;;
	MOV W0,LCDXE		;;
	MOV BMPY,W0 		;;
	MOV W0,LCDYE		;; 
	CALL CRASET_LIM		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWC 0x2C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPY,W0		;;
	MOV W0,R1		;;
DBLK_0:				;;
	MOV BMPX,W0		;;
	MOV W0,R0		;;
DBLK_1:				;;		
	MOV LCDX_LIM0,W0	;;	
	CP LCDX			;;
	BRA LT,DBLK_2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM1,W0	;;
	CP LCDX			;;
	BRA GT,DBLK_2  		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0	;;	
	CP LCDY			;;
	BRA LT,DBLK_2		;;
	MOV LCDY_LIM1,W0	;;
	CP LCDY			;;
	BRA GT,DBLK_2	  	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV COLOR_B,W0		;;
	CALL STWDP16		;;
DBLK_2:				;;
	INC LCDX		;;
	DEC R0			;;
	BRA NZ,DBLK_1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPX,W0		;;
	SUB LCDX		;;
	INC LCDY		;;
	DEC R1			;;
	BRA NZ,DBLK_0		;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	STWEND			;;
	POP LCDY		;;
	POP LCDX		;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RESET_LCD:				;;
	BSF TFT_CS_O			;;
	BSF TFT_RST_O			;;
	MOV #1,W0			;;
	CALL DLYMX			;;
	BCF TFT_RST_O			;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	BSF TFT_RST_O			;;
	MOV #120,W0			;;
	CALL DLYMX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	










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
LF24_F24SETBUF:					;;
	MOV #F24SET_BUF,W2			;;
LF24_F24SET:
	CLR TBLPAG 				;;	
	MOV #tbloffset(F24SET_FADR),W1		;;
	MOV #F24SET_LEN_K,W3 			;;
LF24_F24SETBUF_1:				;;
	TBLRDL [W1++],W0			;;
	MOV W0,[W2++]				;;
	DEC W3,W3				;;
	BRA NZ,LF24_F24SETBUF_1			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	




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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENSTR_LEN:				;;
	BSF STRLEN_F			;;
	CLR STR_LEN			;;
	BRA ENSTR00			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENSTR:					;;
	BCF STRLEN_F			;;
ENSTR00:				;;
	;PUSH W1			;;
	;BTFSC RAMSTR_F			;;
        ;MOV RAMSTR_BUF_PTR,W1	        ;;
ENSTR0:					;;	
	BTFSS RAMSTR_F			;;
	BRA ENSTR0A			;;
	PUSH W1				;;
	BCLR W1,#0			;;
	MOV [W1],W0			;;
	POP W1				;;
	BRA ENSTR0B			;;
ENSTR0A:				;;
        TBLRDL [W1],W0		        ;;
ENSTR0B:				;;
	BTSC W1,#0			;;
	SWAP W0				;; 
	AND #255,W0			;;
	BRA Z,ENSTR_END			;;
	CALL ENCHR			;;
	INC W1,W1			;;
	BRA ENSTR0			;;
ENSTR_END:				;;
	INC W1,W1			;;
	BCF STRLEN_F			;;
	;POP W1				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
NUM_TRANS:				;;
	BTSS W0,#4			;;
	BRA NUM_TRANS1			;;
	BTSS W0,#0			;;
	BRA NUM_TRANS0			;;
	MOV #'-',W0			;;
	RETURN				;;
NUM_TRANS0:				;;
	MOV #' ',W0			;;
	RETURN				;;
NUM_TRANS1:				;;
	ADD.B #246,W0       ;-10	;;	
        BTSC SR,#C			;;
	ADD.B #7,W0			;;
	ADD.B #0x3A,W0			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FONT0_PRP: 				;;
	MOV #8,W1			;;
	MOV W1,FONT_X			;;
	MOV #16,W1			;;	
	MOV W1,FONT_Y			;;
	MOV #2,W1			;;	
	MOV W1,FONT_WB			;;
	MUL.UU W0,#16,W0		;;
        MOV #tbloffset(ASCII_TBL),W1	;;
        ADD W0,W1,W1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENNUM:					;;
	AND #15,W0			;;
	CALL NUM_TRANS			;;
ENCHR:					;;
	BSF VIEW_F			;;
	PUSH W1				;;
	CALL FONT0_PRP			;;
	BTFSC STRLEN_F			;;
	BRA ENCHR1			;;
	CALL FONTP 			;;ENFPRG			;;
	POP W1				;;
	RETURN				;;
ENCHR1:					;;
	MOV FONT_X,W0			;;
	ADD STR_LEN			;;
	POP W1				;;
	RETURN				;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_LCDLIM:			;;
	CLR LCDX_LIM0		;;
	MOV #127,W0		;;
	MOV W0,LCDX_LIM1	;;
	CLR LCDY_LIM0		;;
	MOV #127,W0		;;
	MOV W0,LCDY_LIM1	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FONTP:					;;
	MOV FONT_X,W0 			;;
	MOV W0,LCDXE			;;
	MOV FONT_Y,W0 			;;
	MOV W0,LCDYE			;;
	CALL CRASET_LIM			;;
	STWC 0x2C			;;
	MOV FONT_Y,W5			;;
FONTP_1:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0		;;
	CP LCDY				;;
	BRA LT,FONTP_1A	  		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM1,W0		;;
	CP LCDY				;;
	BRA GT,FONTP_1A	  		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,W2			;;
        TBLRDL [W2++],W3	        ;;
	BTSC W1,#0			;;
	SWAP W3				;;
        TBLRDL [W2++],W4	        ;;
	BTSC W1,#0			;;
	SWAP W4				;;
	MOV FONT_X,W2			;;
	CALL WF1L			;;
	MOV FONT_X,W0			;;
	SUB LCDX			;;
FONTP_1A: 				;;
	MOV FONT_X,W2			;;
	DEC W2,W2			;;
	LSR W2,#3,W2			;;
	INC W2,W2			;;
	ADD W2,W1,W1			;;
	INC LCDY			;;
	DEC W5,W5			;;
	BRA NZ,FONTP_1			;;
	MOV FONT_X,W0			;;
	ADD LCDX			;;
	MOV FONT_Y,W0			;;
	SUB LCDY			;;
	STWEND				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WF1L:					;;
	MOV LCDX_LIM0,W0		;;	
	CP LCDX				;;
	BRA GE,WF1L_1			;;
	RRC W4,W4			;;
	RRC W3,W3			;;
	BRA WF1L_3			;;	
WF1L_1:					;;
	MOV LCDX_LIM1,W0		;;
	CP LCDX				;;
	BRA LE,WF1L_2	  		;;
	RRC W4,W4			;;
	RRC W3,W3			;;
	BRA WF1L_3			;;	
WF1L_2:					;;
	RRC W4,W4			;;
	RRC W3,W3			;;
	MOV COLOR_F,W0			;;
	BTSS SR,#C			;;
	MOV COLOR_B,W0			;;
	CALL STWDP16			;;
WF1L_3:					;;
	INC LCDX			;;
	DEC W2,W2			;;
	BRA NZ,WF1L			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ASCII_TBL:
;   0
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;  1 ;DU
 .BYTE 0x00,0x00,0x00,0x00,0x78,0xCC,0xCC,0xCC,0x78,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;  2
 .BYTE 0x00,0x00,0x00,0x00,0x07,0x0F,0x1F,0x3F,0x7F,0x3F 
 .BYTE 0x1F,0x0F,0x07,0x00,0x00,0x00 
;  3
 .BYTE 0x00,0x00,0x00,0x00,0xE0,0xF0,0xF8,0xFC,0xFE,0xFC 
 .BYTE 0xF8,0xF0,0xE0,0x00,0x00,0x00 
;  4
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x10,0x38,0x7C,0xFE,0x7C 
 .BYTE 0x38,0x10,0x00,0x00,0x00,0x00 
;  5
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x3C,0x3C,0xE7,0xE7,0xE7 
 .BYTE 0x18,0x18,0x3C,0x00,0x00,0x00 
;  6
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x3C,0x7E,0xFF,0xFF,0x7E 
 .BYTE 0x18,0x18,0x3C,0x00,0x00,0x00 
;  7
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x18,0x3C,0x3C 
 .BYTE 0x18,0x00,0x00,0x00,0x00,0x00 
;  8 DU
 .BYTE 0x00,0x00,0x00,0x00,0x78,0xCC,0xCC,0xCC,0x78,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;   9
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x3C,0x66,0x42,0x42 
 .BYTE 0x66,0x3C,0x00,0x00,0x00,0x00 
;   10
 .BYTE 0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xC3,0x99,0xBD,0xBD 
 .BYTE 0x99,0xC3,0xFF,0xFF,0xFF,0xFF 
;  11
 .BYTE 0x00,0x00,0x00,0x00,0xF0,0xE0,0xB0,0x98,0x3C,0x66 
 .BYTE 0x66,0x66,0x3C,0x00,0x00,0x00 
;  12
 .BYTE 0x00,0x00,0x00,0x00,0x3C,0x66,0x66,0x66,0x3C,0x18 
 .BYTE 0x7E,0x18,0x18,0x00,0x00,0x00 
;   13
 .BYTE 0x00,0x00,0x00,0x00,0xFC,0xCC,0xFC,0x0C,0x0C,0x0C 
 .BYTE 0x0E,0x0F,0x07,0x00,0x00,0x00 
;  14
 .BYTE 0x00,0x00,0x00,0x00,0xFE,0xC6,0xFE,0xC6,0xC6,0xC6 
 .BYTE 0xE6,0xE7,0x67,0x03,0x00,0x00 
;  15
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x18,0xDB,0x3C,0xE7,0x3C 
 .BYTE 0xDB,0x18,0x18,0x00,0x00,0x00 
;  16
 .BYTE 0x00,0x00,0x00,0x00,0x02,0x06,0x0E,0x3E,0xFE,0x3E 
 .BYTE 0x0E,0x06,0x02,0x00,0x00,0x00 
;  17
 .BYTE 0x00,0x00,0x00,0x00,0x80,0xC0,0xE0,0xF8,0xFE,0xF8 
 .BYTE 0xE0,0xC0,0x80,0x00,0x00,0x00 
;  18
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x3C,0x7E,0x18,0x18,0x18 
 .BYTE 0x7E,0x3C,0x18,0x00,0x00,0x00 
;  19
 .BYTE 0x00,0x00,0x00,0x00,0xCC,0xCC,0xCC,0xCC,0xCC,0xCC 
 .BYTE 0x00,0xCC,0xCC,0x00,0x00,0x00 
;  20
 .BYTE 0x00,0x00,0x00,0x00,0xFE,0xDB,0xDB,0xDB,0xDE,0xD8 
 .BYTE 0xD8,0xD8,0xD8,0x00,0x00,0x00 
;  21
 .BYTE 0x00,0x00,0x00,0x7C,0xC6,0x0C,0x38,0x6C,0xC6,0xC6 
 .BYTE 0x6C,0x38,0x60,0xC6,0x7C,0x00 
;  22
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 
 .BYTE 0xFE,0xFE,0xFE,0x00,0x00,0x00 
;  23
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x3C,0x7E,0x18,0x18,0x18 
 .BYTE 0x7E,0x3C,0x18,0x7E,0x00,0x00 
;  24
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x3C,0x7E,0x18,0x18,0x18 
 .BYTE 0x18,0x18,0x18,0x00,0x00,0x00 
;  25
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x18,0x18,0x18,0x18,0x18 
 .BYTE 0x7E,0x3C,0x18,0x00,0x00,0x00 
;
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x30,0x60,0xFE,0x60 
 .BYTE 0x30,0x00,0x00,0x00,0x00,0x00 
;  27
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x18,0x0C,0xFE,0x0C 
 .BYTE 0x18,0x00,0x00,0x00,0x00,0x00 
;  28
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x06,0x06,0x06 
 .BYTE 0xFE,0x00,0x00,0x00,0x00,0x00 
;  29
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x24,0x66,0xFF,0x66 
 .BYTE 0x24,0x00,0x00,0x00,0x00,0x00 
;  30
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x10,0x38,0x38,0x7C,0x7C 
 .BYTE 0xFE,0xFE,0x00,0x00,0x00,0x00 
;  31
 .BYTE 0x00,0x00,0x00,0x00,0x00,0xFE,0xFE,0x7C,0x7C,0x38 
 .BYTE 0x38,0x10,0x00,0x00,0x00,0x00 
;   32
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;!  33
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x3C,0x3C,0x3C,0x18,0x18 
 .BYTE 0x00,0x18,0x18,0x00,0x00,0x00 
;"  34
 .BYTE 0x00,0x00,0x00,0xC6,0xC6,0xC6,0x44,0x00,0x00,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;#  35
 .BYTE 0x00,0x00,0x00,0x00,0x6C,0x6C,0xFE,0x6C,0x6C,0x6C 
 .BYTE 0xFE,0x6C,0x6C,0x00,0x00,0x00 
;$  36
 .BYTE 0x00,0x00,0x30,0x30,0x7C,0xC6,0x86,0x06,0x7C,0xC0 
 .BYTE 0xC2,0xC6,0x7C,0x30,0x30,0x00 
;%  37
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x86,0xC6,0x60,0x30 
 .BYTE 0x18,0xCC,0xC6,0x00,0x00,0x00 
;&  38
 .BYTE 0x00,0x00,0x00,0x00,0x38,0x6C,0x6C,0x38,0xDC,0x76 
 .BYTE 0x66,0x66,0xDC,0x00,0x00,0x00 
;'  39
 .BYTE 0x00,0x00,0x00,0x0C,0x0C,0x0C,0x06,0x00,0x00,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;(  40
 .BYTE 0x00,0x00,0x00,0x00,0x30,0x18,0x0C,0x0C,0x0C,0x0C 
 .BYTE 0x0C,0x18,0x30,0x00,0x00,0x00 
;)  41
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x30,0x60,0x60,0x60,0x60 
 .BYTE 0x60,0x30,0x18,0x00,0x00,0x00 
;*  42
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x66,0x3C,0xFF,0x3C 
 .BYTE 0x66,0x00,0x00,0x00,0x00,0x00 
;+  43
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x18,0x18,0x18,0xFF,0x18 
 .BYTE 0x18,0x18,0x00,0x00,0x00,0x00 
;,  44
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 
 .BYTE 0x18,0x18,0x18,0x0C,0x00,0x00 
;-  45
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x7F,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;.  46
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 
 .BYTE 0x00,0x18,0x18,0x00,0x00,0x00 
;/  47
 .BYTE 0x00,0x00,0x00,0x00,0x80,0xC0,0x60,0x30,0x18,0x0C 
 .BYTE 0x06,0x02,0x00,0x00,0x00,0x00 
;0  48
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xE6,0xF6,0xDE,0xCE 
 .BYTE 0xC6,0xC6,0x7C,0x00,0x00,0x00 
;1  49
 .BYTE 0x00,0x00,0x00,0x00,0x30,0x38,0x3C,0x30,0x30,0x30 
 .BYTE 0x30,0x30,0xFC,0x00,0x00,0x00 
;2  50
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xC0,0x60,0x30,0x18 
 .BYTE 0x0C,0xC6,0xFE,0x00,0x00,0x00 
;3  51
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xC0,0xC0,0x78,0xC0 
 .BYTE 0xC0,0xC6,0x7C,0x00,0x00,0x00 
;4  52
 .BYTE 0x00,0x00,0x00,0x00,0x60,0x70,0x78,0x6C,0x66,0xFE 
 .BYTE 0x60,0x60,0xF0,0x00,0x00,0x00 
;5  53
 .BYTE 0x00,0x00,0x00,0x00,0xFE,0x06,0x06,0x06,0x7E,0xC0 
 .BYTE 0xC0,0xC6,0x7C,0x00,0x00,0x00 
;6  54
 .BYTE 0x00,0x00,0x00,0x00,0x38,0x0C,0x06,0x06,0x7E,0xC6 
 .BYTE 0xC6,0xC6,0x7C,0x00,0x00,0x00 
;7  55
 .BYTE 0x00,0x00,0x00,0x00,0xFE,0xC6,0xC0,0x60,0x30,0x18 
 .BYTE 0x18,0x18,0x18,0x00,0x00,0x00 
;8  56
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xC6,0xC6,0x7C,0xC6 
 .BYTE 0xC6,0xC6,0x7C,0x00,0x00,0x00 
;9  57
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xC6,0xC6,0xFC,0xC0 
 .BYTE 0xC0,0x60,0x3C,0x00,0x00,0x00 
;:  58
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x18,0x18,0x00,0x00,0x00 
 .BYTE 0x18,0x18,0x00,0x00,0x00,0x00 
;;  59
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x18,0x18,0x00,0x00,0x00 
 .BYTE 0x18,0x18,0x0C,0x00,0x00,0x00 
;<  60
 .BYTE 0x00,0x00,0x00,0x00,0x60,0x30,0x18,0x0C,0x06,0x0C 
 .BYTE 0x18,0x30,0x60,0x00,0x00,0x00 
;=  61
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x7E,0x00,0x00 
 .BYTE 0x7E,0x00,0x00,0x00,0x00,0x00 
;>  62
 .BYTE 0x00,0x00,0x00,0x00,0x06,0x0C,0x18,0x30,0x60,0x30 
 .BYTE 0x18,0x0C,0x06,0x00,0x00,0x00 
;?  63
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xC6,0x60,0x30,0x30 
 .BYTE 0x00,0x30,0x30,0x00,0x00,0x00 
;@  64
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xC6,0xF6,0xF6,0xF6 
 .BYTE 0x76,0x06,0x7C,0x00,0x00,0x00 
;A  65
 .BYTE 0x00,0x00,0x00,0x00,0x10,0x38,0x6C,0xC6,0xC6,0xFE 
 .BYTE 0xC6,0xC6,0xC6,0x00,0x00,0x00 
;B  66
 .BYTE 0x00,0x00,0x00,0x00,0x7E,0xCC,0xCC,0xCC,0x7C,0xCC 
 .BYTE 0xCC,0xCC,0x7E,0x00,0x00,0x00 
;C  67
 .BYTE 0x00,0x00,0x00,0x00,0x78,0xCC,0x86,0x06,0x06,0x06 
 .BYTE 0x86,0xCC,0x78,0x00,0x00,0x00 
;D  68
 .BYTE 0x00,0x00,0x00,0x00,0x3E,0x6C,0xCC,0xCC,0xCC,0xCC 
 .BYTE 0xCC,0x6C,0x3E,0x00,0x00,0x00 
;E  69
 .BYTE 0x00,0x00,0x00,0x00,0xFE,0xCC,0x8C,0x2C,0x3C,0x2C 
 .BYTE 0x8C,0xCC,0xFE,0x00,0x00,0x00 
;F  70
 .BYTE 0x00,0x00,0x00,0x00,0xFE,0xCC,0x8C,0x2C,0x3C,0x2C 
 .BYTE 0x0C,0x0C,0x1E,0x00,0x00,0x00 
;G  71
 .BYTE 0x00,0x00,0x00,0x00,0x78,0xCC,0x86,0x06,0x06,0xF6 
 .BYTE 0xC6,0xCC,0xB8,0x00,0x00,0x00 
;   72
 .BYTE 0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6,0xC6,0xFE,0xC6 
 .BYTE 0xC6,0xC6,0xC6,0x00,0x00,0x00 
;I  73
 .BYTE 0x00,0x00,0x00,0x00,0x3C,0x18,0x18,0x18,0x18,0x18 
 .BYTE 0x18,0x18,0x3C,0x00,0x00,0x00 
;J  74
 .BYTE 0x00,0x00,0x00,0x00,0xF0,0x60,0x60,0x60,0x60,0x60 
 .BYTE 0x66,0x66,0x3C,0x00,0x00,0x00 
;K  75
 .BYTE 0x00,0x00,0x00,0x00,0xCE,0xCC,0x6C,0x6C,0x3C,0x6C 
 .BYTE 0x6C,0xCC,0xCE,0x00,0x00,0x00 
;L  76
 .BYTE 0x00,0x00,0x00,0x00,0x1E,0x0C,0x0C,0x0C,0x0C,0x0C 
 .BYTE 0x8C,0xCC,0xFE,0x00,0x00,0x00 
;M  77
 .BYTE 0x00,0x00,0x00,0x00,0xC6,0xEE,0xFE,0xD6,0xC6,0xC6 
 .BYTE 0xC6,0xC6,0xC6,0x00,0x00,0x00 
;N  78
 .BYTE 0x00,0x00,0x00,0x00,0xC6,0xCE,0xDE,0xFE,0xF6,0xE6 
 .BYTE 0xC6,0xC6,0xC6,0x00,0x00,0x00 
;O  79
 .BYTE 0x00,0x00,0x00,0x00,0x38,0x6C,0xC6,0xC6,0xC6,0xC6 
 .BYTE 0xC6,0x6C,0x38,0x00,0x00,0x00 
;P  80
 .BYTE 0x00,0x00,0x00,0x00,0x7E,0xCC,0xCC,0xCC,0x7C,0x0C 
 .BYTE 0x0C,0x0C,0x1E,0x00,0x00,0x00 
;Q  81
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xC6,0xC6,0xC6,0xD6 
 .BYTE 0xF6,0x7C,0x60,0xE0,0x00,0x00 
;R  82
 .BYTE 0x00,0x00,0x00,0x00,0x7E,0xCC,0xCC,0xCC,0x7C,0x6C 
 .BYTE 0xCC,0xCC,0xCE,0x00,0x00,0x00 
;S  83
 .BYTE 0x00,0x00,0x00,0x00,0x7C,0xC6,0xC6,0x0C,0x38,0x60 
 .BYTE 0xC6,0xC6,0x7C,0x00,0x00,0x00 
;T  84
 .BYTE 0x00,0x00,0x00,0x00,0xFF,0x99,0x18,0x18,0x18,0x18 
 .BYTE 0x18,0x18,0x3C,0x00,0x00,0x00 
;U  85
 .BYTE 0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6,0xC6,0xC6,0xC6 
 .BYTE 0xC6,0xC6,0x7C,0x00,0x00,0x00 
;V  86
 .BYTE 0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6,0xC6,0xC6,0xC6 
 .BYTE 0x6C,0x38,0x10,0x00,0x00,0x00 
;W  87
 .BYTE 0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6,0xC6,0xC6,0xD6 
 .BYTE 0xFE,0xEE,0xC6,0x00,0x00,0x00 
;X  88
 .BYTE 0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6,0x6C,0x38,0x6C 
 .BYTE 0xC6,0xC6,0xC6,0x00,0x00,0x00 
;Y  89
 .BYTE 0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6,0x6C,0x38,0x38 
 .BYTE 0x38,0x38,0x7C,0x00,0x00,0x00 
;Z  90
 .BYTE 0x00,0x00,0x00,0x00,0xFE,0xC6,0x62,0x30,0x18,0x0C 
 .BYTE 0x86,0xC6,0xFE,0x00,0x00,0x00 
;[  91
 .BYTE 0x00,0x00,0x00,0x00,0x3C,0x0C,0x0C,0x0C,0x0C,0x0C 
 .BYTE 0x0C,0x0C,0x3C,0x00,0x00,0x00 
;\  92
 .BYTE 0x00,0x00,0x00,0x00,0x02,0x06,0x0E,0x1C,0x38,0x70 
 .BYTE 0xE0,0xC0,0x80,0x00,0x00,0x00 
;]  93
 .BYTE 0x00,0x00,0x00,0x00,0x3C,0x30,0x30,0x30,0x30,0x30 
 .BYTE 0x30,0x30,0x3C,0x00,0x00,0x00 
;^  94
 .BYTE 0x00,0x00,0x10,0x38,0x6C,0xC6,0x00,0x00,0x00,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;_  95
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0xFF,0x00 
;`  96
 .BYTE 0x00,0x00,0x18,0x18,0x30,0x00,0x00,0x00,0x00,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 
;a  97
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x3C,0x60,0x7C 
 .BYTE 0x66,0x66,0xDC,0x00,0x00,0x00 
;b  98
 .BYTE 0x00,0x00,0x00,0x00,0x0E,0x0C,0x0C,0x3C,0x6C,0xCC 
 .BYTE 0xCC,0xCC,0x76,0x00,0x00,0x00 
;c  99
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x7C,0xC6,0x06 
 .BYTE 0x06,0xC6,0x7C,0x00,0x00,0x00 
;d  100
 .BYTE 0x00,0x00,0x00,0x00,0x70,0x60,0x60,0x78,0x6C,0x66 
 .BYTE 0x66,0x66,0xDC,0x00,0x00,0x00 
;e  101
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x7C,0xC6,0xFE 
 .BYTE 0x06,0xC6,0x7C,0x00,0x00,0x00 
;f  102
 .BYTE 0x00,0x00,0x00,0x00,0x38,0x6C,0x4C,0x0C,0x3E,0x0C 
 .BYTE 0x0C,0x0C,0x1E,0x00,0x00,0x00 
;g  103
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xDC,0x66,0x66 
 .BYTE 0x66,0x7C,0x60,0x66,0x3C,0x00 
;h  104
 .BYTE 0x00,0x00,0x00,0x00,0x0E,0x0C,0x0C,0x6C,0xDC,0xCC 
 .BYTE 0xCC,0xCC,0xCE,0x00,0x00,0x00 
;i  105
 .BYTE 0x00,0x00,0x00,0x00,0x30,0x30,0x00,0x38,0x30,0x30 
 .BYTE 0x30,0x30,0x78,0x00,0x00,0x00 
;j  106
 .BYTE 0x00,0x00,0x00,0x00,0x60,0x60,0x00,0x70,0x60,0x60 
 .BYTE 0x60,0x60,0x66,0x66,0x3C,0x00 
;k  107
 .BYTE 0x00,0x00,0x00,0x00,0x0E,0x0C,0x0C,0xCC,0x6C,0x3C 
 .BYTE 0x6C,0xCC,0xCE,0x00,0x00,0x00 
;l  108
 .BYTE 0x00,0x00,0x00,0x00,0x38,0x30,0x30,0x30,0x30,0x30 
 .BYTE 0x30,0x30,0x78,0x00,0x00,0x00 
;m  109
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x44,0xFE,0xD6 
 .BYTE 0xD6,0xD6,0xD6,0x00,0x00,0x00 
;n  110
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x76,0xCC,0xCC 
 .BYTE 0xCC,0xCC,0xCC,0x00,0x00,0x00 
;o  111
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x7C,0xC6,0xC6 
 .BYTE 0xC6,0xC6,0x7C,0x00,0x00,0x00 
;p  112
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x76,0xCC,0xCC 
 .BYTE 0xCC,0x7C,0x0C,0x0C,0x1E,0x00 
;q  113
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xDC,0x66,0x66 
 .BYTE 0x66,0x7C,0x60,0x60,0xF0,0x00 
;r  114
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x76,0xDC,0xCC 
 .BYTE 0x0C,0x0C,0x1E,0x00,0x00,0x00 
;s  115
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x7C,0xC6,0x1C 
 .BYTE 0x70,0xC6,0x7C,0x00,0x00,0x00 
;t  116
 .BYTE 0x00,0x00,0x00,0x00,0x10,0x18,0x18,0x7E,0x18,0x18 
 .BYTE 0x18,0xD8,0x70,0x00,0x00,0x00 
;u  117
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x66,0x66,0x66 
 .BYTE 0x66,0x66,0xDC,0x00,0x00,0x00 
;v  118
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6 
 .BYTE 0x6C,0x38,0x10,0x00,0x00,0x00 
;w  119
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6 
 .BYTE 0xD6,0xFE,0x6C,0x00,0x00,0x00 
;x  120
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xC6,0x6C,0x38 
 .BYTE 0x38,0x6C,0xC6,0x00,0x00,0x00 
;y  121
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xC6,0xC6,0xC6 
 .BYTE 0xC6,0xFC,0xC0,0x60,0x3C,0x00 
;z  122
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFE,0x66,0x30 
 .BYTE 0x18,0xCC,0xFE,0x00,0x00,0x00 
;{  123
 .BYTE 0x00,0x00,0x00,0x00,0x70,0x18,0x18,0x18,0x0E,0x18 
 .BYTE 0x18,0x18,0x70,0x00,0x00,0x00 
;|  124
 .BYTE 0x00,0x00,0x00,0x00,0x18,0x18,0x18,0x18,0x00,0x18 
 .BYTE 0x18,0x18,0x18,0x00,0x00,0x00 
;}  125
 .BYTE 0x00,0x00,0x00,0x00,0x0E,0x18,0x18,0x18,0x70,0x18 
 .BYTE 0x18,0x18,0x0E,0x00,0x00,0x00 
;~  126
 .BYTE 0x00,0x00,0x00,0x00,0xDC,0x76,0x00,0x00,0x00,0x00 
 .BYTE 0x00,0x00,0x00,0x00,0x00,0x00 








.EQU F24SET_LEN_K	,(FSET_LOC_TBL_END-FSET_LOC_TBL)/8
FSET_LOC_TBL:;ADDRESS,INIT VALUE,MIN,MAX
	.WORD SERIAL_ID		,0xFFFF	,0,255	
	.WORD DIMS_SET		,15	,0,100	
FSET_LOC_TBL_END:
	.WORD 0		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.ORG (F24SET_FADR-0x204)	;;
F24SET_TBL:				;;
	.WORD 0x00FF			;;00	
	.WORD 0x000F			;;01	
	.WORD 0xFFFF			;;02	
	.WORD 0xFFFF			;;03	
	.WORD 0xFFFF			;;04	
	.WORD 0xFFFF			;;05	
	.WORD 0xFFFF			;;06
	.WORD 0xFFFF			;;07
	.WORD 0xFFFF			;;08
	.WORD 0xFFFF			;;09
	.WORD 0xFFFF			;;10
	.WORD 0xFFFF			;;11
	.WORD 0xFFFF			;;12
	.WORD 0xFFFF			;;13
	.WORD 0xFFFF			;;14
	.WORD 0xFFFF			;;15
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


;SON OLED FLASH DESCRIPTION
;===================================================================
;0x000000~512B ADDRESS HEAD
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY0PG0
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY0PG1
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY0PG2
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY0PG3
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY0PG4
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY0PG5
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY0PG6
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY0PG7

;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY1PG0
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY1PG1
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY1PG2
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY1PG3
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY1PG4
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY1PG5
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY1PG6
;0xAB,0xCD,0x00,0x00,ADDRESS(4B,L2H) TY1PG7
;...
;...
;...

;0x010000~IMAGE DATA





;MASTER OLED FLASH DESCRIPTION
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



;        byteBuf[inx++] = (byte) (0xAB);
;        byteBuf[inx++] = (byte) (0xCD);
;        byteBuf[inx++] = (byte) (16);//16bit
;        byteBuf[inx++] = (byte) (0);//0:rgb:1:bgr                                
;        byteBuf[inx++] = (byte) ((size) & 255);
;        byteBuf[inx++] = (byte) ((size >> 8) & 255);
;        byteBuf[inx++] = (byte) ((size >> 16) & 255);
;        byteBuf[inx++] = (byte) ((size >> 24) & 255);
;        byteBuf[inx++] = (byte) ((w) & 255);
;        byteBuf[inx++] = (byte) ((w >> 8) & 255);
;        byteBuf[inx++] = (byte) ((h) & 255);
;        byteBuf[inx++] = (byte) ((h >> 8) & 255);
;        int chkInx=inx;
;        byteBuf[inx++] = (byte) (CHKSUM0)
;        byteBuf[inx++] = (byte) (CHKSUM1)
;        byteBuf[inx++] = (byte) (CHKSUM2)
;        byteBuf[inx++] = (byte) (CHKSUM3)



