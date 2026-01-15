;******************************************************************************

        .equ __24fj32ga004, 1 ;
        .include "p24fj32ga004.inc"

        .include "pindef.s"
        .include "macro.h"


;ICD2 USE REGISTER OF 0x800-0x822
;..............................................................................
;..............................................................................
    	.global __reset          ;The label for the first line of code. 
    	.global __T1Interrupt    ;Declare Timer 1 ISR name global
  	.global __T4Interrupt    ;Declare Timer 4 ISR name global
	.global __CNInterrupt
    	.global __INT1Interrupt   
    	.global __INT2Interrupt   
  	.global __U1RXInterrupt    ;Declare Timer 4 ISR name global


	








.EQU STACK_STADR_K	,0x1F00


.EQU DEVICE_ID_K	,0x2537


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


ICD2_USE: 	.SPACE 128
UNI_FLAG:		.SPACE 2
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
R10:			.SPACE 2		
R11:			.SPACE 2		
R12:			.SPACE 2		
R13:			.SPACE 2		
R14:			.SPACE 2		
R15:			.SPACE 2		


RX_DEVICE_ID:	        .SPACE 2
RX_SERIAL_ID:	        .SPACE 2
RX_GROUP_ID:	        .SPACE 2
MY_SLOT_ID:		.SPACE 2
RX_LEN:			.SPACE 2
RX_CMD:			.SPACE 2
RX_PARA0:		.SPACE 2	
RX_PARA1:		.SPACE 2	
RX_PARA2:		.SPACE 2	
RX_PARA3:		.SPACE 2	
		


;;=====================================
;REG0
MAX_INT:                 .SPACE 2 ;31
MAX_N:                   .SPACE 2 ;30:15
MAX_FRAC:                .SPACE 2 ;14:3
;REG1
MAX_RES0:                .SPACE 2 ;31
MAX_CPL:                 .SPACE 2 ;30~29
MAX_CPT:                 .SPACE 2 ;28~27
MAX_P:                   .SPACE 2 ;26~15
MAX_M:                   .SPACE 2 ;14~3
;REG2
MAX_LDS:                 .SPACE 2 ;31
MAX_SDN:                 .SPACE 2 ;30:29
MAX_MUX:                 .SPACE 2 ;28:26
MAX_DBR:                 .SPACE 2 ;25
MAX_RDIV2:               .SPACE 2 ;24
MAX_R:                   .SPACE 2 ;23:14
MAX_REG4DB:              .SPACE 2 ;13
MAX_CP:                  .SPACE 2 ;12:9
MAX_LDF:                 .SPACE 2 ;8
MAX_LDP:                 .SPACE 2 ;7
MAX_PDP:                 .SPACE 2 ;6
MAX_SHDN:                .SPACE 2 ;5
MAX_TRI:                 .SPACE 2 ;4
MAX_RST:                 .SPACE 2 ;3
;REG3
MAX_VCO:                 .SPACE 2 ;31:26
MAX_VAS_SHDN:            .SPACE 2 ;25
MAX_VAS_TEMP:            .SPACE 2 ;24
MAX_RES1:                .SPACE 2 ;23:19
MAX_CSM:                 .SPACE 2 ;18
MAX_MUTEDEL:             .SPACE 2 ;17
MAX_CDM:                 .SPACE 2 ;16:15
MAX_CDIV:                .SPACE 2 ;14:3
;REG4
MAX_RES2:                .SPACE 2 ;31:29
MAX_SDLDO:               .SPACE 2 ;28
MAX_SDDIV:               .SPACE 2 ;27
MAX_SDREF:               .SPACE 2 ;26
MAX_BSH:                 .SPACE 2 ;25:24
MAX_FB:                  .SPACE 2 ;23
MAX_DIVA:                .SPACE 2 ;22:20
MAX_BSL:                 .SPACE 2 ;19:12
MAX_SDVCO:               .SPACE 2 ;11
MAX_MTLD:                .SPACE 2 ;10
MAX_BDIV:                .SPACE 2 ;9
MAX_RFB_EN:              .SPACE 2 ;8
MAX_BPWR:                .SPACE 2 ;7:6
MAX_RFA_EN:              .SPACE 2 ;5
MAX_APWR:                .SPACE 2 ;4:3
;REG5
MAX_RES3:                .SPACE 2 ;31
MAX_VAS_DLY:             .SPACE 2 ;30:29
MAX_RES4:                .SPACE 2 ;28:26
MAX_SDPLL:               .SPACE 2 ;25
MAX_F01:                 .SPACE 2 ;24
MAX_LD:                  .SPACE 2 ;23:22
MAX_RES5:                .SPACE 2 ;21:19
MAX_MUX3:                .SPACE 2 ;18
MAX_RES6:                .SPACE 2 ;17:7
MAX_ADCS:                .SPACE 2 ;6
MAX_ADCM:                .SPACE 2 ;5:3
;REG6
MAX_DID:                 .SPACE 2 ;31:28
MAX_RES7:                .SPACE 2 ;27:24
MAX_POR:                 .SPACE 2 ;23
MAX_ADC:                 .SPACE 2 ;22:16
MAX_ADCV:                .SPACE 2 ;15
MAX_RES8:                .SPACE 2 ;14:10
MAX_VASV:                .SPACE 2 ;9
MAX_V:                   .SPACE 2 ;8:3
;============================================             


MAX00:			.SPACE 2		
MAX01:			.SPACE 2		
MAX10:			.SPACE 2		
MAX11:			.SPACE 2		
MAX20:			.SPACE 2		
MAX21:			.SPACE 2		
MAX30:			.SPACE 2		
MAX31:			.SPACE 2		
MAX40:			.SPACE 2		
MAX41:			.SPACE 2		
MAX50:			.SPACE 2		
MAX51:			.SPACE 2		
MAX60:			.SPACE 2		
MAX61:			.SPACE 2		

TEST_FREQSET_CNT:       .SPACE 2
FREQ_SET:		.SPACE 2		
FREQ_ADJ:		.SPACE 2		


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

TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2



FLAGA:		        .SPACE 2		

SYS_FLAG0L:	        .SPACE 2		
SYS_FLAG0H:	        .SPACE 2		
SYS_FLAG1L:	        .SPACE 2		
SYS_FLAG1H:	        .SPACE 2		
WGFREQCH:	        .SPACE 2		
ATTENUATE:	        .SPACE 2		


.EQU U1RX_BUFSIZE	,640	;
.EQU U1RX_BUFA		,0x2000	;
.EQU U1RX_BUFB		,0x2280	;
.EQU U1TX_BUF		,0x2500	;




;FLAGA
.EQU U1RX_EN_F		,FLAGA
.EQU U1RX_EN_F_P	,0
.EQU U1RXT_F		,FLAGA
.EQU U1RXT_F_P		,1
.EQU U1RX_BUFAB_F	,FLAGA
.EQU U1RX_BUFAB_F_P	     ,2
.EQU U1RX_PACKA_F	,FLAGA
.EQU U1RX_PACKA_F_P         ,3
.EQU U1RX_PACKB_F	,FLAGA
.EQU U1RX_PACKB_F_P         ,4
.EQU U1TX_EN_F		,FLAGA
.EQU U1TX_EN_F_P	,5
.EQU U1TX_END_F		,FLAGA
.EQU U1TX_END_F_P	,6
;.EQU U2TXON_F	        ,FLAGA
;.EQU U2TXON_F_P 	,4
;.EQU YES_F	        ,FLAGA	
;.EQU YES_F_P	        ,5

	
;..............................................................................
;Code Section in Program Memory
;..............................................................................

.text                             ;Start of Code section
__reset:
	GOTO POWER_ON




TEST_OSC:
        CLRWDT 
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
        BRA TEST_OSC


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
POWER_ON:			;;
	MOV #STACK_STADR_K,W15	
        MOV #0x1FFE,W0        	;;Initialize the Stack Pointer Limit Register
        MOV W0,SPLIM		;;
        CALL CLR_WREG 		;;
	CALL CLR_ALLRAM		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL INIT_IO		;;
	CALL INIT_SIO		;;
	CALL INIT_UART
	CALL INIT_OSC		;;
	CALL OSC_H		;;
      	CALL INIT_TIMER		;;	
	CLRWDT			;;
	MOV #10000,W0		;;
	CALL DLYPRG		;;
        ;CALL TEST_UTX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;CALL TEST_TIMER
        MOV #1000,W0
        CALL DLYMX
        CALL INIT_MAX
        MOV #20,W0
        CALL DLYMX
        NOP
        NOP
        
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BRA MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_TIMER:
        BSF LED_O
        MOV #10,W0
        CALL DLYMX
        BCF LED_O
        MOV #10,W0
        CALL DLYMX
        BRA TEST_TIMER

TEST_FREQSET:


        BTSS TMR2_FLAG,#12
        RETURN
        INC TEST_FREQSET_CNT
        MOV #10,W0
        CP TEST_FREQSET_CNT
        BRA GEU,$+4
        RETURN
        CLR TEST_FREQSET_CNT
        INC WGFREQCH
        MOV #360,W0
        CP WGFREQCH
        BRA GEU,$+4
        RETURN
        MOVLF #280,WGFREQCH
        RETURN

        

MAIN:
        MOVLF #0,MY_SLOT_ID
        MOVLF #320,FREQ_SET

        ;MOVLF #280,FREQ_SET
        ;MOVLF #317,FREQ_SET

        MOVLF #0,FREQ_ADJ
        CALL SET_FREQ
        MOVFF FREQ_SET,WGFREQCH
MAIN_LOOP:
        CLRWDT
        CALL TMR2PRG	                ;	
        BTSS TMR2_BUF,#14
        BSF LED_O
        BTSC TMR2_BUF,#14
        BCF LED_O
        ;CALL TEST_FREQSET
        MOV WGFREQCH,W0
        CP FREQ_SET
        BRA Z,MAIN_1
        NOP
        NOP
        NOP
        NOP
        NOP
        MOV W0,FREQ_SET
        MOVLF #0,FREQ_ADJ               ;;
        CALL SET_FREQ
MAIN_1:
        CALL CHK_U1RX
        BRA MAIN_LOOP



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
        TG LED_O
	MOV [W1++],W0			;;
	MOV W0,RX_DEVICE_ID		;;
	MOV #0X2536,W2	         ;;
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
	MOV [W1++],W0			;;
	MOV W0,RX_GROUP_ID		;;
        SWAP W0                         ;;
        AND #255,W0                     ;;
        MOV #0XAB,W2
        CP W0,W2                     ;;        
        BRA Z,$+4                       ;;
        RETURN                          ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,RX_LEN			;;
	MOV [W1++],W0			;;
	MOV W0,RX_CMD			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA0			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA1			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA2			;;
	MOV [W1++],W0			;;
	MOV W0,RX_PARA3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RX_CMD,W0			;;	
	SWAP W0				;;
	AND #255,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x10			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_SLOT_ACT		;;
        RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

URXDEC_SLOT_ACT:			        ;;
	MOV RX_CMD,W0			;;
	AND #255,W0			;;
	CP W0,#1			;;
	BRA LTU,$+4			;;
	RETURN				;;
	BRA W0				;;
	BRA U1RX_SLOT_00J		;;
U1RX_SLOT_00J:		                ;;
	MOV [W1++],W0			;;
	MOV W0,SYS_FLAG0L		;;
	MOV [W1++],W0			;;
	MOV W0,SYS_FLAG0H		;;
	MOV [W1++],W0			;;
	MOV W0,SYS_FLAG1L		;;
	MOV [W1++],W0			;;
	MOV W0,SYS_FLAG1H		;;
	MOV [W1++],W0			;;
        PUSH W0                         ;;
	AND #255,W0     		;;
        MOV W0,WGFREQCH                 ;;
        MOV #290,W0                     ;;
        ADD WGFREQCH                   ;;
        POP W0                          ;;
        SWAP W0                         ;;
	AND #255,W0     		;;
        MOV W0,ATTENUATE                ;;
        RETURN

        
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
U1RX_CMD_01J:				;;
U1RX_CMD_02J:				;;
U1RX_CMD_03J:				;;
U1RX_CMD_04J:				;;PULSE ON:
U1RX_CMD_05J:				;;
U1RX_CMD_06J:				;;
U1RX_CMD_07J:				;;
        RETURN                          ;;
;;========================================


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


;=========================
CLR_ALLRAM:				
	MOV #(UNI_FLAG+2),W1	
CLR_ALLRAM_1:		
        CLRWDT		
	CLR [W1++]			
	MOV #STACK_STADR_K,W0	
	CP W1,W0			
	BRA LTU,CLR_ALLRAM_1	
	RETURN				
;=========================



INIT_OSC:
	MOV OSCCON,W0
	MOV #OSCCONL, w1
	MOV #0x46, w2
	MOV #0x57, w3
	MOV.B W2,[W1]
	MOV.B W3,[W1]
	NOP
	NOP
	MOV #0x0000,W0
	MOV W0,CLKDIV
	MOV #0x0006,W0
	MOV W0,OSCTUN
	RETURN


INIT_TIMER:
	BSET INTCON1,#NSTDIS
	MOV #0xA030,W0
	MOV W0,T2CON		;BASE TIME
	;;;;;;;;;;;;;;;;;
	RETURN



DLYPRG:
	CLRWDT
	DEC W0,W0
	BRA NZ,DLYPRG
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UTX:	
        CLRWDT 			;;
	MOV #0xAB,W0			;;
	MOV W0,U1TXREG			;;
	MOV #100,W0			;;
	CALL DLYMX			;;
	BRA TEST_UTX			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
TEST_URX:
	CLRWDT				;;
	BTSS IFS0,#11			;;
	BRA TEST_URX
	BCLR IFS0,#11			;;
	MOV U1RXREG,W0			;;
	BRA TEST_URX		


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



INIT_UART:
	MOV #415,W0	;9600
;;	MOV #207,W0	;19200
	MOV #8,W0	;57600
	MOV W0,U1BRG
	MOV #0x8008,W0
	MOV W0,U1MODE
	MOV #0x0400,W0
	MOV W0,U1STA 

;	BCLR IPC3,#2 
;	BCLR IPC3,#1 
;	BSET IPC3,#0 
;	BCLR IFS0,#12		;;
;	BSET IEC0,#12		;;UTXINT

	BCLR IFS0,#11			;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;

	BCLR IPC2,#14 
	BCLR IPC2,#13 
	BSET IPC2,#12 
	BCLR IFS0,#11		;;
	BSET IEC0,#11		;;URXINT
 	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SIO:			;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BCLR OSCCON,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1F0C,W0		;;
	MOV W0,RPINR18		;;U1RX(BIT4-0)
	MOV #0x0300,W0		;;
	MOV W0,RPOR6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;

;	MOV #0x0A00,W0		;;
;	MOV W0,RPINR0		;;INT1
;	MOV #0x0002,W0		;;
;	MOV W0,RPINR1		;;INT2
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BSET OSCCON,#6		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INIT_IO:
        ;PIN1 
        BCF SCLK_O
        BCF SCLK_IO
        ;PIN2 
        BCF SDA_O
        BCF SDA_IO
        ;PIN3 
        BCF SLE_O
        BCF SLE_IO
        ;PIN4 
        BCF CE_O
        BCF CE_IO
        ;PIN5 
        BCF RFOUT_EN_O
        BCF RFOUT_EN_IO
        ;PIN8 
        BSF LD_IO
        ;PIN23 
        BCF LED_O
        BCF LED_IO
        ;PIN24 
        BSF MCU_RX_I
        ;PIN25 
        BCF MCU_TX_O
        BCF MCU_TX_IO
        ;PIN44 
        BSF SDO_IO


	MOV #0xFFFF,W0
	MOV W0,AD1PCFG 
        BSET CNPU2,#CN22PUE
	RETURN  




CLR_WREG:
        CLR W0
        MOV W0,W14
        REPEAT #12
        MOV W0,[++W14]
        CLR W14
        RETURN





NOPPRG:
        NOP
        NOP
        NOP
        NOP
        NOP
        RETURN
        
;INPUT R1,R0
WMAX_REG:
        BSF SLE_O
        CALL NOPPRG
        BCF SLE_O
        CALL NOPPRG
        CLR W2
WMAX_REG_1:
        BTSS R1,#15
        BCF SDA_O
        BTSC R1,#15
        BSF SDA_O
        CALL NOPPRG
        BSF SCLK_O
        CALL NOPPRG
        BCF SCLK_O
        RLC R0
        RLC R1
        INC W2,W2
        MOV #32,W0
        CP W2,W0
        BRA LTU,WMAX_REG_1
        BCF SDA_O
        BSF SLE_O
        RETURN

MAX_ENABLE:
        BSF CE_O
        RETURN
        


;;N 16~65535/65536 IN INT MODE
;;N 19~4091/65536 IN FRAC MODE
;;FRAC 0~4095/4096



;INPUT R1,R0
RMAX_REG:
        CLR R1
        MOVLF #6,R0
        CALL WMAX_REG
        CLR R0
        CLR R1
        BSF SLE_O
        CALL NOPPRG
        ;BSF SCLK_O
        ;CALL NOPPRG
        ;BCF SCLK_O
        CALL NOPPRG
        CLR W2
RMAX_REG_1:
        BSF SCLK_O
        CALL NOPPRG
        NOP
        NOP
        NOP
        RLC R0
        RLC R1
        BTFSC SDO_I
        BSET R0,#0
        BCF SCLK_O
        CALL NOPPRG
        INC W2,W2
        MOV #33,W0
        CP W2,W0
        BRA LTU,RMAX_REG_1
        RETURN

INIT_MAX_REG:
        CALL INIT_MAX_DATA
        CALL LOAD_MAX_REG
        RETURN


INIT_MAX_DATA:
;;=====================================
;REG0
        MOVLF #0x00,MAX_INT;                 .SPACE 2 ;31
        MOVLF #250,MAX_N;                    .SPACE 2 ;30:15
        MOVLF #0x00,MAX_FRAC;                .SPACE 2 ;14:3
;REG1
        MOVLF #0x00,MAX_RES0;                .SPACE 2 ;31
        MOVLF #0x01,MAX_CPL;                 .SPACE 2 ;30~29
        MOVLF #0x00,MAX_CPT;                 .SPACE 2 ;28~27
        MOVLF #0x01,MAX_P;                   .SPACE 2 ;26~15
        MOVLF #0xFFF,MAX_M;                  .SPACE 2 ;14~3
;REG2
        MOVLF #0x00,MAX_LDS;                 .SPACE 2 ;31
        MOVLF #0x00,MAX_SDN;                 .SPACE 2 ;30:29
        MOVLF #0x0C,MAX_MUX;                 .SPACE 2 ;28:26
        MOVLF #0x00,MAX_DBR;                 .SPACE 2 ;25
        MOVLF #0x00,MAX_RDIV2;               .SPACE 2 ;24
        MOVLF #0x01,MAX_R;                   .SPACE 2 ;23:14
        MOVLF #0x00,MAX_REG4DB;              .SPACE 2 ;13
        MOVLF #0x00,MAX_CP;                  .SPACE 2 ;12:9
        MOVLF #0x00,MAX_LDF;                 .SPACE 2 ;8
        MOVLF #0x00,MAX_LDP;                 .SPACE 2 ;7
        MOVLF #0x01,MAX_PDP;                 .SPACE 2 ;6
        MOVLF #0x00,MAX_SHDN;                .SPACE 2 ;5
        MOVLF #0x00,MAX_TRI;                 .SPACE 2 ;4
        MOVLF #0x00,MAX_RST;                 .SPACE 2 ;3
;REG3
        MOVLF #0x00,MAX_VCO;                 .SPACE 2 ;31:26
        MOVLF #0x00,MAX_VAS_SHDN;            .SPACE 2 ;25
        MOVLF #0x00,MAX_VAS_TEMP;            .SPACE 2 ;24
        MOVLF #0x00,MAX_RES1;                .SPACE 2 ;23:19
        MOVLF #0x00,MAX_CSM;                 .SPACE 2 ;18
        MOVLF #0x00,MAX_MUTEDEL;             .SPACE 2 ;17
        MOVLF #0x00,MAX_CDM;                 .SPACE 2 ;16:15
        MOVLF #0x00,MAX_CDIV;                .SPACE 2 ;14:3
;REG4
        MOVLF #0x03,MAX_RES2;                .SPACE 2 ;31:29
        MOVLF #0x00,MAX_SDLDO;               .SPACE 2 ;28
        MOVLF #0x00,MAX_SDDIV;               .SPACE 2 ;27
        MOVLF #0x00,MAX_SDREF;               .SPACE 2 ;26
        MOVLF #0x01,MAX_BSH;                 .SPACE 2 ;25:24
        MOVLF #0x01,MAX_FB;                  .SPACE 2 ;23
        MOVLF #0x00,MAX_DIVA;                .SPACE 2 ;22:20
        MOVLF #0x0B,MAX_BSL;                 .SPACE 2 ;19:12
        MOVLF #0x00,MAX_SDVCO;               .SPACE 2 ;11
        MOVLF #0x00,MAX_MTLD;                .SPACE 2 ;10
        MOVLF #0x01,MAX_BDIV;                .SPACE 2 ;9
        MOVLF #0x00,MAX_RFB_EN;              .SPACE 2 ;8
        MOVLF #0x00,MAX_BPWR;                .SPACE 2 ;7:6
        MOVLF #0x01,MAX_RFA_EN;              .SPACE 2 ;5
        MOVLF #0x02,MAX_APWR;                .SPACE 2 ;4:3
;REG5
        MOVLF #0x00,MAX_RES3;                .SPACE 2 ;31
        MOVLF #0x00,MAX_VAS_DLY;             .SPACE 2 ;30:29
        MOVLF #0x00,MAX_RES4;                .SPACE 2 ;28:26
        MOVLF #0x00,MAX_SDPLL;               .SPACE 2 ;25
        MOVLF #0x00,MAX_F01;                 .SPACE 2 ;24
        MOVLF #0x01,MAX_LD;                  .SPACE 2 ;23:22
        MOVLF #0x00,MAX_RES5;                .SPACE 2 ;21:19
        MOVLF #0x00,MAX_MUX3;                .SPACE 2 ;18
        MOVLF #0x00,MAX_RES6;                .SPACE 2 ;17:7
        MOVLF #0x00,MAX_ADCS;                .SPACE 2 ;6
        MOVLF #0x00,MAX_ADCM;                .SPACE 2 ;5:3
        RETURN



LOAD_MAX_REG:
        MOV #0xFFF,W2
        ;=====================
        CLR MAX00
        CLR MAX01
        
        BTSC MAX_INT,#0
        BSET MAX01,#15
                
        MOV MAX_N,W0
        LSR W0,#1,W0
        IOR MAX01
        BTSC MAX_N,#0
        BSET MAX00,#15
        ;
        MOV MAX_FRAC,W0
        AND W0,W2,W0
        SL W0,#3,W0
        IOR MAX00
        ;======================
        CLR MAX11
        MOVLF #1,MAX10


        ;MOV #31,W0
        ;SL W0,#3,W0
        ;IOR MAX10
        

        
        BTSC MAX_RES0,#0
        BSET MAX11,#15
        ;
        MOV MAX_CPL,W0
        AND #3,W0
        SL W0,#13,W0
        IOR MAX11
        ;
        MOV MAX_CPT,W0
        AND #3,W0
        SL W0,#11,W0
        IOR MAX11
        ;
        MOV MAX_P,W0
        AND W0,W2,W0
        LSR W0,#1,W0
        IOR MAX11
        BTSC MAX_P,#0
        BSET MAX10,#15
        ;
        MOV MAX_M,W0
        AND W0,W2,W0
        SL W0,#3,W0
        IOR MAX10
        ;
        ;===================================
        CLR MAX21
        MOVLF #2,MAX20
        ;
        BTSC MAX_LDS,#0
        BSET MAX21,#15
        ;
        MOV MAX_SDN,W0
        AND #3,W0
        SL W0,#13,W0
        IOR MAX21
        ;
        MOV MAX_MUX,W0
        AND #7,W0
        SL W0,#10,W0
        IOR MAX21
        ;
        BTSC MAX_DBR,#0
        BSET MAX21,#9
        ;
        BTSC MAX_RDIV2,#0
        BSET MAX21,#8
        ;
        MOV MAX_R,W0
        AND #0x3FF,W0
        ASR W0,#2,W0
        IOR MAX21
        BTSC MAX_R,#0
        BSET MAX20,#14
        BTSC MAX_R,#1
        BSET MAX20,#15
        ;
        BTSC MAX_REG4DB,#0
        BSET MAX20,#13
        ;
        MOV MAX_CP,W0
        AND #0xF,W0
        SL W0,#9,W0
        IOR MAX20
        ;
        BTSC MAX_LDF,#0
        BSET MAX20,#8
        ;
        BTSC MAX_LDP,#0
        BSET MAX20,#7
        ;
        BTSC MAX_PDP,#0
        BSET MAX20,#6
        ;
        BTSC MAX_SHDN,#0
        BSET MAX20,#5
        ;
        BTSC MAX_TRI,#0
        BSET MAX20,#4
        ;
        BTSC MAX_RST,#0
        BSET MAX20,#3
        ;
        ;===================================
        CLR MAX31
        MOVLF #3,MAX30
        ;
        MOV MAX_VCO,W0
        AND #0x3F,W0
        SL W0,#10,W0
        IOR MAX31
        ;
        BTSC MAX_VAS_SHDN,#0
        BSET MAX31,#9
        ;
        BTSC MAX_VAS_TEMP,#0
        BSET MAX31,#8
        ;
        MOV MAX_RES1,W0
        AND #0x1F,W0
        SL W0,#3,W0
        IOR MAX31
        ;
        BTSC MAX_CSM,#0
        BSET MAX31,#2
        ;
        BTSC MAX_MUTEDEL,#0
        BSET MAX31,#1
        ;
        BTSC MAX_CDM,#0
        BSET MAX30,#15
        BTSC MAX_CDM,#1
        BSET MAX31,#0
        ;
        MOV MAX_CDIV,W0
        AND W2,W0,W0
        SL W0,#3,W0
        IOR MAX30
        ;===================================
        CLR MAX41
        MOVLF #4,MAX40
        ;
        MOV MAX_RES2,W0
        AND #0x7,W0
        SL W0,#13,W0
        IOR MAX41
        ;
        BTSC MAX_SDLDO,#0
        BSET MAX41,#12
        ;
        BTSC MAX_SDDIV,#0
        BSET MAX41,#11
        ;
        BTSC MAX_SDREF,#0
        BSET MAX41,#10
        ;
        MOV MAX_BSH,W0
        AND #0x3,W0
        SL W0,#8,W0
        IOR MAX41
        ;
        BTSC MAX_FB,#0
        BSET MAX41,#7
        ;
        MOV MAX_DIVA,W0
        AND #0x7,W0
        SL W0,#4,W0
        IOR MAX41
        ;
        MOV MAX_BSL,W0
        AND #0xF0,W0
        LSR W0,#4,W0
        IOR MAX41
        MOV MAX_BSL,W0
        AND #0x0F,W0
        SL W0,#12,W0
        IOR MAX40
        ;
        BTSC MAX_SDVCO,#0
        BSET MAX40,#11
        ;
        BTSC MAX_MTLD,#0
        BSET MAX40,#10
        ;
        BTSC MAX_BDIV,#0
        BSET MAX40,#9
        ;
        BTSC MAX_RFB_EN,#0
        BSET MAX40,#8
        ;
        MOV MAX_BPWR,W0
        AND #0x3,W0
        SL W0,#6,W0
        IOR MAX40
        ;
        BTSC MAX_RFA_EN,#0
        BSET MAX40,#5
        ;
        MOV MAX_APWR,W0
        AND #0x3,W0
        SL W0,#3,W0
        IOR MAX40
        ;
        ;===================================
        CLR MAX51
        MOVLF #5,MAX50
        ;
        BTSC MAX_RES3,#0
        BSET MAX50,#15
        ;
        MOV MAX_VAS_DLY,W0
        AND #0x3,W0
        SL W0,#13,W0
        IOR MAX51
        ;
        MOV MAX_RES4,W0
        AND #0x7,W0
        SL W0,#10,W0
        IOR MAX51
        ;
        BTSC MAX_SDPLL,#0
        BSET MAX51,#9
        ;
        BTSC MAX_F01,#0
        BSET MAX51,#8
        ;
        MOV MAX_LD,W0
        AND #0x3,W0
        SL W0,#6,W0
        IOR MAX51
        ;
        MOV MAX_RES5,W0
        AND #0x7,W0
        SL W0,#3,W0
        IOR MAX51
        ;
        BTSC MAX_MUX,#3
        BSET MAX51,#2
        ;
        BTSC MAX_RES6,#10
        BSET MAX51,#1
        BTSC MAX_RES6,#9
        BSET MAX51,#0
        MOV MAX_RES6,W0
        AND #0x1FF,W0
        SL W0,#7,W0
        IOR MAX50
        ;
        BTSC MAX_ADCS,#0
        BSET MAX50,#6
        ;
        MOV MAX_ADCM,W0
        AND #0x7,W0
        SL W0,#3,W0
        IOR MAX50
        ;
        RETURN
                
WRITE_MAX:
        CALL LOAD_MAX_REG
        CALL WMAX_R5
        CALL WMAX_R4
        CALL WMAX_R3
        CALL WMAX_R2
        CALL WMAX_R1
        CALL WMAX_R0
        RETURN

WMAX_R0:
        MOVFF MAX00,R0
        MOVFF MAX01,R1
        CALL WMAX_REG
        RETURN
WMAX_R1:
        MOVFF MAX10,R0
        MOVFF MAX11,R1
        CALL WMAX_REG
        RETURN
WMAX_R2:
        MOVFF MAX20,R0
        MOVFF MAX21,R1
        CALL WMAX_REG
        RETURN
WMAX_R3:
        MOVFF MAX30,R0
        MOVFF MAX31,R1
        CALL WMAX_REG
        RETURN
WMAX_R4:
        MOVFF MAX40,R0
        MOVFF MAX41,R1
        CALL WMAX_REG
        RETURN
WMAX_R5:
        MOVFF MAX50,R0
        MOVFF MAX51,R1
        CALL WMAX_REG
        RETURN









READ_MAX:
        CALL RMAX_REG
        MOV R1,W0
        LSR W0,#12,W0
        AND #15,W0
        MOV W0,MAX_DID
        ;
        MOV R1,W0
        LSR W0,#7,W0
        AND #1,W0
        MOV W0,MAX_POR
        ;
        MOV R1,W0
        AND #0x7F,W0
        MOV W0,MAX_ADC
        ;
        MOV R0,W0
        LSR W0,#15,W0
        AND #1,W0
        MOV W0,MAX_ADCV
        ;
        MOV R0,W0
        LSR W0,#9,W0
        AND #1,W0
        MOV W0,MAX_VASV
        ;
        MOV R0,W0
        LSR W0,#3,W0
        AND #0x3F,W0
        MOV W0,MAX_V
        ;
        RETURN                








INIT_MAX:
        BCF CE_O                
        MOV #10,W0
        CALL DLYMX
        NOP
        NOP
        NOP
        NOP
        CALL INIT_MAX_DATA
        BSF CE_O                
        BCF RFOUT_EN_O
        MOVLF #0,MAX_RFA_EN         
        MOVLF #0,MAX_RFB_EN         
        CALL LOAD_MAX_REG
        CALL WRITE_MAX
        ;========================
        
        /*
        BCF SCLK_O
        BCF SDA_O
        BSF SLE_O
        ;========================
        
        MOVLF #0x00,MAX00
        MOVLF #0x00,MAX01
        MOVLF #0x01,MAX10
        MOVLF #0x00,MAX11
        MOVLF #0x02,MAX20
        MOVLF #0x00,MAX21
        MOVLF #0x03,MAX30
        MOVLF #0x00,MAX31
        MOVLF #0x8C,MAX40
        MOVLF #0x00,MAX41
        MOVLF #0x05,MAX50
        MOVLF #0x00,MAX51
        CALL WMAX_R5
        MOV #20,W0
        CALL DLYMX
        CALL WMAX_R4
        CALL WMAX_R3
        CALL WMAX_R2
        CALL WMAX_R1
        CALL WMAX_R0
        */
        MOV #20,W0
        CALL DLYMX
        
        
        MOVLF #0x00,MAX_INT;                 .SPACE 2 ;31
        MOVLF #225,MAX_N;                    .SPACE 2 ;30:15
        MOVLF #2000,MAX_FRAC;                .SPACE 2 ;14:3
;REG1
        MOVLF #0x00,MAX_RES0;                .SPACE 2 ;31
        MOVLF #0x01,MAX_CPL;                 .SPACE 2 ;30~29
        MOVLF #0x00,MAX_CPT;                 .SPACE 2 ;28~27
        MOVLF #0x01,MAX_P;                   .SPACE 2 ;26~15
        MOVLF #0xFFF,MAX_M;                  .SPACE 2 ;14~3
;REG2
        MOVLF #0x00,MAX_LDS;                 .SPACE 2 ;31
        MOVLF #0x00,MAX_SDN;                 .SPACE 2 ;30:29
        MOVLF #0x0C,MAX_MUX;                 .SPACE 2 ;28:26
        MOVLF #0x00,MAX_DBR;                 .SPACE 2 ;25
        MOVLF #0x00,MAX_RDIV2;               .SPACE 2 ;24
        MOVLF #0x02,MAX_R;                   .SPACE 2 ;23:14
        MOVLF #0x00,MAX_REG4DB;              .SPACE 2 ;13
        MOVLF #15,MAX_CP;                    .SPACE 2 ;12:9
        MOVLF #0x00,MAX_LDF;                 .SPACE 2 ;8
        MOVLF #0x00,MAX_LDP;                 .SPACE 2 ;7
        MOVLF #0x01,MAX_PDP;                 .SPACE 2 ;6
        MOVLF #0x00,MAX_SHDN;                .SPACE 2 ;5
        MOVLF #0x00,MAX_TRI;                 .SPACE 2 ;4
        MOVLF #0x00,MAX_RST;                 .SPACE 2 ;3
;REG3
        MOVLF #0x00,MAX_VCO;                 .SPACE 2 ;31:26
        MOVLF #0x00,MAX_VAS_SHDN;            .SPACE 2 ;25
        MOVLF #1,MAX_VAS_TEMP;            .SPACE 2 ;24
        MOVLF #0x00,MAX_RES1;                .SPACE 2 ;23:19
        MOVLF #0x00,MAX_CSM;                 .SPACE 2 ;18
        MOVLF #1,MAX_MUTEDEL;             .SPACE 2 ;17
        MOVLF #0x00,MAX_CDM;                 .SPACE 2 ;16:15
        MOVLF #200,MAX_CDIV;                .SPACE 2 ;14:3
;REG4
        MOVLF #0x03,MAX_RES2;                .SPACE 2 ;31:29
        MOVLF #0x00,MAX_SDLDO;               .SPACE 2 ;28
        MOVLF #0x00,MAX_SDDIV;               .SPACE 2 ;27
        MOVLF #0x00,MAX_SDREF;               .SPACE 2 ;26
        MOVLF #0x01,MAX_BSH;                 .SPACE 2 ;25:24
        MOVLF #0x01,MAX_FB;                  .SPACE 2 ;23
        MOVLF #0x00,MAX_DIVA;                .SPACE 2 ;22:20
        MOVLF #144,MAX_BSL;                 .SPACE 2 ;19:12
        MOVLF #0x00,MAX_SDVCO;               .SPACE 2 ;11
        MOVLF #1,MAX_MTLD;                .SPACE 2 ;10
        MOVLF #0x00,MAX_BDIV;                .SPACE 2 ;9
        MOVLF #0x00,MAX_RFB_EN;              .SPACE 2 ;8
        MOVLF #0x00,MAX_BPWR;                .SPACE 2 ;7:6
        MOVLF #0x01,MAX_RFA_EN;              .SPACE 2 ;5
        MOVLF #0x03,MAX_APWR;                .SPACE 2 ;4:3
;REG5
        MOVLF #0x00,MAX_RES3;                .SPACE 2 ;31
        MOVLF #0x00,MAX_VAS_DLY;             .SPACE 2 ;30:29
        MOVLF #0x00,MAX_RES4;                .SPACE 2 ;28:26
        MOVLF #0x00,MAX_SDPLL;               .SPACE 2 ;25
        MOVLF #0x01,MAX_F01;                 .SPACE 2 ;24
        MOVLF #0x01,MAX_LD;                  .SPACE 2 ;23:22
        MOVLF #0x00,MAX_RES5;                .SPACE 2 ;21:19
        MOVLF #0x00,MAX_MUX3;                .SPACE 2 ;18
        MOVLF #0x00,MAX_RES6;                .SPACE 2 ;17:7
        MOVLF #0x00,MAX_ADCS;                .SPACE 2 ;6
        MOVLF #0x00,MAX_ADCM;                .SPACE 2 ;5:3
        CALL WRITE_MAX
        NOP
        NOP
        NOP
        NOP
        MOV #10,W0
        CALL DLYMX
        CALL READ_MAX
        NOP
        NOP
        NOP
        NOP
        RETURN


SET_FREQ:
        CALL TRANS_FREQ       
        CALL LOAD_MAX_REG
        CALL WMAX_R4
        CALL WMAX_R0
        BSF RFOUT_EN_O
        RETURN  



	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OSC_H:		
	MOV #1,W0
OSC_PRG:		
	MOV #OSCCONH,w1
	MOV #0x78, w2
	MOV #0x9A, w3
	DISI #3				;;
	MOV.B w2, [w1]
	MOV.B w3, [w1]
	;Set new oscillator selection
	MOV.B WREG, OSCCONH
	;OSCCONL (low byte) unlock sequence
	MOV #OSCCONL, w1
	MOV #0x46, w2
	MOV #0x57, w3
	DISI #3				;;
	MOV.B w2, [w1]
	MOV.B w3, [w1]
	;Start oscillator switch operation
	BSET OSCCON,#0
	NOP
	NOP
	NOP
	RETURN

DLYMS:
        MOV #1,W0       
DLYMX:
        PUSH  R0
        PUSH  R1
        MOV W0,R1
DLYMX1:
	MOV TMR2,W0
	MOV W0,R0
DLYMX2:
	CLRWDT
	MOV R0,W0
	SUB TMR2,WREG
	AND #0x00C0,W0
	BRA Z,DLYMX2
        DEC R1
        BRA NZ,DLYMX1 
        POP R1
        POP R0
        RETURN
;=====================
;1.00       
;2.90
;3.50
;6.00
;=====================
TRANS_FREQ:
        MOV #300,W0
        CP FREQ_SET
        BRA GEU,TR_FREQ_DIV1
        MOV #150,W0
        CP FREQ_SET
        BRA GEU,TR_FREQ_DIV2
        MOV #75,W0
        CP FREQ_SET
        BRA GEU,TR_FREQ_DIV4
        RETURN 
TR_FREQ_DIV1:
        CLR MAX_DIVA
        MOV FREQ_SET,W0
        LSR W0,#1,W0
        MOV W0,MAX_N
        CLR MAX_FRAC
        BTSC FREQ_SET,#0
        BSET MAX_FRAC,#11
        MOV FREQ_ADJ,W0
        SL W0,#2,W0
        ADD MAX_FRAC
        BRA TR_FREQ_ADJ
TR_FREQ_DIV2:
        MOVLF #1,MAX_DIVA
        MOV FREQ_SET,W0
        MOV W0,MAX_N
        CLR MAX_FRAC
        MOV FREQ_ADJ,W0
        SL W0,#1,W0
        ADD MAX_FRAC
        BRA TR_FREQ_ADJ
TR_FREQ_DIV4:
        MOVLF #2,MAX_DIVA
        MOV FREQ_SET,W0
        SL W0,#1,W0
        MOV W0,MAX_N
        CLR MAX_FRAC
        MOV FREQ_ADJ,W0
        ADD MAX_FRAC
        BRA TR_FREQ_ADJ
TR_FREQ_ADJ:
        BTSC MAX_FRAC,#15
        BRA TR_FREQ_ADJ_1
        BTSS MAX_FRAC,#12
        RETURN
        INC MAX_N
        MOV #4095,W0
        AND MAX_FRAC
        RETURN
                     

TR_FREQ_ADJ_1:
        DEC MAX_N
        MOV #4095,W0
        AND MAX_FRAC
        RETURN
        

FREQ_TBL:
        .WORD 175
        .WORD 


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


        