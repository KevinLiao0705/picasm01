;******************************************************************************

        .equ __24fj64ga004, 1 ;
        .include "p24fj64ga004.inc"
	.include "COMPASS.BTXT"
        .include "tpmstft.h"


  	.global __U1RXInterrupt    ;Declare Timer 4 ISR name global


;2.7
;2.5V 34B 
;2.4V 32B
;2.3V 2FB
;2.2V 2E0
;2.1V 2B9
;2.0V 296
;1.9V 26C
;1.8V 249
;1.7V 21F
;1.6V 1FA	  
;1.5V 1CE 

;3.0
;2.5V 2FX 
;2.4V 2DX
;2.3V 2BX
;2.2V 29X
;2.1V 26X
;2.0V 24X
;1.9V 22X
;1.8V 21X
;1.7V 1FX
;1.6V 1DX	  
;1.5V 1AX 





; .EQU V2P5 ,0x2F0
; .EQU V2P4 ,0x2D0
; .EQU V2P3 ,0x2B0
; .EQU V2P2 ,0x290
; .EQU V2P1 ,0x260
; .EQU V2P0 ,0x240
; .EQU V1P9 ,0x220
; .EQU V1P8 ,0x210
; .EQU V1P7 ,0x1F0
; .EQU V1P6 ,0x1D0
; .EQU V1P5 ,0x1A0

;1M
; .EQU V2P5 ,0x160
; .EQU V2P3 ,0x140
; .EQU V2P2 ,0x130
; .EQU V2P0 ,0x110
; .EQU V1P9 ,0x100
; .EQU V1P6 ,0x0D0



;10K
 .EQU V2P5 ,0x345
 .EQU V2P3 ,0x303
 .EQU V2P2 ,0x2E0
 .EQU V2P0 ,0x2A0
 .EQU V1P9 ,0x27B
 .EQU V1P6 ,0x21A






;158=10.8V
 .EQU VPOW_0 ,504	;8V
 .EQU VPOW_1 ,536	;8.5V
 .EQU VPOW_2 ,630 	;10 V;
 .EQU VPOW_3 ,662 	;10.5V



;END PROGRAM ADDESS 0xABFC

	
;..............................................................................
;Code Section in Program Memory
;..............................................................................

.text                             ;Start of Code section
__reset:
	GOTO POWER_ON




;*********************************
TPUSRX:				;;
	BCLR IFS1,#T4IF		;;
	BCLR IEC1,#T4IE		;;	
	BCLR MRXE,#MRXE_P	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR T1CON,#TON 	;;
	MOVLF 0xFFFF,PR1	;;	
	MOV #0x8002,W0		;;
	MOV W0,T1CON		;;
	MOV #0xA000,W0		;;
	MOV W0,T2CON		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
        BCLR FLAGE,#TRXIN_F     ;;
        BSET FLAGE,#TRFERR_F    ;;
        CLR TRXBYTE_BUF         ;;
        CLR TTCODE2_CNT         ;;
        CLR TRFBIT_CNT          ;;
	CLR PUSERR_CNT		;;
	CLR PUSYES_CNT		;;
	CLR TMR1		;;
	CLR TMR2		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TWAIT_RXL0:			;;
	CLRWDT			;;
	BTSC MRX,#MRX_P		;;
	BRA TWAIT_RXL0		;;
	CLR TMR2		;;	
TWAIT_RXH0:			;;
	CLRWDT			;;
	BTSS MRX,#MRX_P		;;
	BRA TWAIT_RXH0		;;
	CLR TMR2		;;
TWAIT_RXL1:			;;
	CLRWDT			;;
	BTSC MRX,#MRX_P		;;
	BRA TWAIT_RXL1		;;
	CLR TMR2		;;
TWAIT_RXH1:			;;
	CLRWDT			;;
	BTSS MRX,#MRX_P		;;
	BRA TWAIT_RXH1		;;
	CLR TMR2		;;
TGET_RXH:			;;
	CLRWDT			;;
	BTSC MRX,#MRX_P		;;
	BRA TGET_RXH		;;
	MOV TMR2,W1		;;
	CLR TMR2		;;	
        BCLR RFBUF_PCNT1,#0  	;;
	CALL TPUSRF		;;
        BTSC FLAGE,#TRXIN_F      ;;
	RETURN			;;
	MOV #600,W0		;;
	CP TMR1			;;
	BRA LTU,$+4		;;	
	RETURN			;;
TGET_RXL:			;;
	CLRWDT			;;
	BTSS MRX,#MRX_P		;;
	BRA TGET_RXL		;;
	MOV TMR2,W1		;;
	CLR TMR2		;;	
        BSET RFBUF_PCNT1,#0  	;;
	CALL TPUSRF		;;
        BTSC FLAGE,#TRXIN_F      ;;
	RETURN			;;
	MOV PORTB,W0		;;
	LSR W0,#10,W0		;;
	AND #7,W0		;;
	XOR #7,W0		;;
	BRA Z,$+4		;; 	
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #600,W0		;;
	CP TMR1			;;
	BRA LTU,TGET_RXH	;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	


		















	

TPMSV_LOC:
	.WORD 0x0000
	.WORD 0x5100
	.WORD 0x008C
	.WORD 0x518C
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_TPMSV:				;;
	INC TPMSV_CNT			;;
	MOV #4,W0			;;
	CP TPMSV_CNT			;;
	BRA LTU,$+4			;;
	CLR TPMSV_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_TPMSVX:				;;
	MOV #8,W0			;;
	MUL TPMSV_CNT			;;
	MOV #TPMSV_BUF,W0		;;
	ADD W0,W2,W2			;;
	MOV [W2++],W0			;;
	MOV W0,DPPB0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,DPPB1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV [W2++],W0			;;
	MOV W0,DPPB2			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,DPPB3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0			;;
	XOR DPPB2,WREG			;;
	BRA NZ,DISP_TPMSV1		;;
	MOV DPPB1,W0			;;
	XOR DPPB3,WREG			;;
	BRA NZ,DISP_TPMSV1		;;
	RETURN				;;
DISP_TPMSV1:				;;
	DEC2 W2,W2			;;
	DEC2 W2,W2			;;
	MOV DPPB0,W0			;;
	MOV W0,[W2++]			;; 
	MOV DPPB1,W0			;;
	MOV W0,[W2++]			;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #6,W0			;;
	BTSC TPMSV_CNT,#0		;;
	MOV #74,W0			;;
	MOV W0,LCDX 			;;
	MOV #15,W0			;;
	BTSC TPMSV_CNT,#1		;;
	MOV #125,W0			;;
	MOV W0,LCDY 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #42,W1			;;
	MOV #0x0300,W0			;;
	AND DPPB1,WREG			;;
	BRA Z,$+4			;;
	ADD #6,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0			;;
	AND #255,W0			;;
	CP W0,#16			;;
	BRA NZ,$+4			;;
	SUB #14,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0			;;
	SWAP W0				;;
	AND #255,W0			;;
	CP W0,#16			;;
	BRA NZ,$+4			;;
	SUB #14,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #48,W0			;;
	SUB W0,W1,W0			;;
	BCLR SR,#C			;;
	RRC W0,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W0,BMPX			;;
	MOVLF 20,BMPY			;;
	CALL COLOR0			;;
	CALL DISP_BLK			;;
	MOV BMPX,W0			;;
	ADD LCDX 			;;
	PUSH BMPX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0			;;
	SWAP W0				;;	
	SWAP.B W0			;;
	AND #7,W0			;;
	MOV W0,FCOLOR			;;
	BRA DISP_TPMSV3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGD,#DISPCF_F		;;
	BRA DISP_TPMSV2A		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #2,W1			;;
	MOV W1,FCOLOR			;;
	MOV #7,W2
	CP W0,W2			;;
	BRA Z,DISP_TPMSV3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #3,W1			;;
	MOV W1,FCOLOR			;;
	BTSC W0,#0			;;
	BRA DISP_TPMSV3	 		;;
	BTSC W0,#1			;;
	BRA DISP_TPMSV3	 		;;
	MOV #0,W1			;;
	MOV W1,FCOLOR			;;
	BRA DISP_TPMSV3			;;
DISP_TPMSV2A:				;;
	MOV #2,W1			;;
	MOV W1,FCOLOR			;;
	MOV #7,W2			;;	
	CP W0,W2			;;
	BRA Z,DISP_TPMSV3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #3,W1			;;0:WHITE 1:GREEN 2 YELLOW
	MOV W1,FCOLOR			;;3:RED
	BTSC W0,#2			;;
	BRA DISP_TPMSV3	 		;;
	MOV #0,W1			;;
	MOV W1,FCOLOR			;;
	BRA DISP_TPMSV3			;;
DISP_TPMSV3:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGE,#TPMS_LEN_F		;;
	CLR FCOLOR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0			;;
	AND #255,W0			;;
	CP W0,#16			;;
	BRA Z,$+4			;;
	CALL WNUM			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC DPPB1,#9			;;
	CALL WPOINT			;;
	MOV DPPB0,W0			;;
	SWAP W0				;;
	AND #255,W0			;;
	CP W0,#16			;;
	BRA Z,$+4			;;
	CALL WNUM			;;
	BTSC DPPB1,#8			;;
	CALL WPOINT			;;
	MOV DPPB0,W0			;;
	CALL WNUM			;;
	POP BMPX			;;	
	MOVLF 20,BMPY			;;
	CALL COLOR0			;;
	CALL DISP_BLK			;;
	MOV BMPX,W0			;;
	ADD LCDX 			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WNUM:					;;
	LOFFS2 NUMBER_TBL		;;
	AND #255,W0			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	MOV #14,W3			;;
	MOV W3,BMPX			;;
	MOV #20,W3			;;
	MOV W3,BMPY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W2++],W0		;;
	MOV W0,FADR0			;;	
	TBLRDL [W2++],W0		;;
	MOV W0,FADR1			;;	
	CALL GET_BMPS			;;
	CALL DISP_FNT24			;;
	MOV BMPX,W0			;;
	ADD LCDX 			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WPOINT:					;;
	MOVLF #POINT_0_ADR0,FADR0	;;	
	MOVLF #POINT_0_ADR1,FADR1	;;	
	MOV #5,W3			;;
	MOV W3,BMPX			;;
	MOV #20,W3			;;
	MOV W3,BMPY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BMPS			;;
	CALL DISP_FNT24			;;
	MOV BMPX,W0			;;
	ADD LCDX 			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WPOINT_SPACE:				;;
	MOVLF 5,BMPX			;;
	MOVLF 20,BMPY			;;
W_SPACE:				;;
	CALL COLOR0			;;
	CALL DISP_BLK			;;
	MOV BMPX,W0			;;
	ADD LCDX 			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RSTR:					;;	
	PUSH W1				;;
RSTR0:					;;
        TBLRDL [W1],W0		        ;;
	BTSC W1,#0			;;
	SWAP W0				;; 
	AND #255,W0			;;
	BRA Z,RSTR_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS2 F16P_TBL			;;
	MOV #16,W3			;;
	MOV W3,BMPX			;;
	MOV #16,W3			;;
	MOV W3,BMPY			;;
	BTSS FLAGD,#F24P_F		;;
	BRA RSTR1			;;
	LOFFS2 F24P_TBL			;;
	MOV #24,W3			;;
	MOV W3,BMPX			;;
	MOV #24,W3			;;
	MOV W3,BMPY			;;
RSTR1:					;;	
	SUB #'A',W0			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	TBLRDL [W2++],W0		;;
	MOV W0,FADR0			;;	
	TBLRDL [W2++],W0		;;
	MOV W0,FADR1			;;	
	CALL GET_BMPS			;;
	CALL DISP_BMP24			;;
	MOV BMPX,W0			;;
	ADD LCDX 			;;
	INC W1,W1			;;
	BRA RSTR0			;;
RSTR_END:				;;
	POP W1				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RRSTR:					;;	
	PUSH W1				;;
        MOV #RAMSTR_BUF,W1	        ;;
RRSTR0:					;;
	PUSH W1
	BCLR W1,#0 
        MOV [W1],W0		        ;;
	POP W1
	BTSC W1,#0
	SWAP W0
	AND #255,W0			;;
	BRA Z,RRSTR_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS2 F16P_TBL			;;
	MOV #16,W3			;;
	MOV W3,BMPX			;;
	MOV #16,W3			;;
	MOV W3,BMPY			;;
	BTSS FLAGD,#F24P_F		;;
	BRA RRSTR1			;;
	LOFFS2 F24P_TBL			;;
	MOV #24,W3			;;
	MOV W3,BMPX			;;
	MOV #24,W3			;;
	MOV W3,BMPY			;;
RRSTR1:					;;	
	SUB #'A',W0			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	ADD W2,W0,W2			;;
	TBLRDL [W2++],W0		;;
	MOV W0,FADR0			;;	
	TBLRDL [W2++],W0		;;
	MOV W0,FADR1			;;	
	CALL GET_BMPS			;;
	CALL DISP_BMP24			;;
	MOV BMPX,W0			;;
	ADD LCDX 			;;
	INC W1,W1			;;
	BRA RRSTR0			;;
RRSTR_END:				;;
	POP W1				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ICONP:				;;
	BSET FLAGA,#ICONP_F	;;	 
	INC ICONP_CNT		;;
	MOV #25,W0		;;
	CP ICONP_CNT		;;
	BRA LTU,$+4		;;
	CLR ICONP_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #12,W0		;;
	MUL ICONP_CNT		;;
	MOV #ICONP_BUF,W0	;;
	ADD W0,W2,W2		;;
	BTST.C [W2],#0		;;PRESENT BIT
	BRA C,DPPX		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP:				;;
	BCLR FLAGA,#ICONP_F	;;
	INC DPP_CNT		;;
	MOV #16,W0		;;
	CP DPP_CNT		;;
	BRA LTU,$+4		;;
	CLR DPP_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #12,W0		;;
	MUL DPP_CNT		;;
	MOV #DPPBUF,W0		;;
	ADD W0,W2,W2		;;
	BTST.C [W2],#0		;;PRESENT BIT
	BRA C,$+4		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DPPX:				;;
	MOV [W2++],W0		;;
	MOV W0,DPPB0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV [W2++],W0		;;
	MOV W0,DPPB2		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,LCDX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,LCDY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS DPPB0,#1		;;FORCE BIT
	BRA DPP_NOFORCE		;;
DPP_FORCE:			;;
	BCLR DPPB0,#1		;;
	MOV DPPB0,W0		;;	
	SWAP W0			;;
	AND #255,W0		;;
	MOV W0,DPPB3		;;
	BRA DPP1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP_NOFORCE: 			;;
	BTSC DPPB0,#2		;;DYNAMIC_F
	BRA DPP0		;;
	MOV DPPB0,W0		;;	
	SWAP W0			;;
	XOR DPPB3,WREG		;;
	AND #0x00FF,W0		;;
	BRA NZ,$+4		;;
	RETURN			;;
	XOR DPPB3		;;
	BRA DPP1 		;;
DPP0:				;;
	MOV DPPB2,W0		;;	
	SUB T4ITMR,WREG		;;
	BTSC W0,#15		;;	
	RETURN			;;
	INC DPPB3		;;
	MOV DPPB1,W1		;;
	TBLRDL [W1],W0		;;
	CP W0,#1		;;
	BRA GTU,DPP1		;;
	DEC DPPB3		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP1:				;;
	PUSH LCDX_LIM0		;;
	PUSH LCDX_LIM1		;;
	PUSH LCDY_LIM0		;;
	PUSH LCDY_LIM1		;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH R2			;;
	PUSH R3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W1		;;
	TBLRDL [W1++],W0	;;
	MOV W0,R0		;;PAGE AMOUNT
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R0,W0		;;
	CP DPPB3		;; 	
	BRA LTU,DPP3		;;
	BTSS DPPB0,#3		;;ONCE
	BRA DPP2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC DPP_ONCE_CNT	;;
	BRA NZ,DPP2		;;
	BCLR FLAGB,#DPP_ONCE_F	;;
	CLR DPPB0		;;
	BRA DPP_END		;;
DPP2:				;;	
	CLR DPPB3 		;;
DPP3:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,R1		;;DELAY TIME
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,BMPX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,BMPY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	TBLRDL [W1++],W0	;;
	AND #0x000F,W0		;;
	MOV W0,R2  		;;DISPLAY TYPE
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,R3 		;;DISPLAY BUF
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX,W0 		;;
	MOV W0,LCDX_LIM0	;;
	ADD BMPX,WREG		;;
	MOV W0,LCDX_LIM1	;;	
	DEC LCDX_LIM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY,W0 		;;
	MOV W0,LCDY_LIM0	;;
	ADD BMPY,WREG		;;
	MOV W0,LCDY_LIM1	;;	
	DEC LCDY_LIM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R2,W0		;;
	BRA W0			;;
	BRA DPP_T0		;;
	BRA DPP_T1		;;
	BRA DPP_T2		;;
	BRA DPP_T3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP_T0:				;;
	MOV #6,W0		;;
	MUL DPPB3		;;	
	ADD W2,W1,W1		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,FADR0		;;
	TBLRDL [W1++],W0	;;
	MOV W0,FADR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1],W0		;;
	CP W0,#0		;;
	BTSC SR,#Z 		;;
	MOV R1,W0		;;
	ADD T4ITMR,WREG		;;
	MOV W0,DPPB2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BMPS		;;
	CALL DISP_BMP24		;;
	BRA DPP_END		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP_T1:				;;
	MOV #6,W0		;;
	MUL DPPB3		;;	
	ADD W2,W1,W1		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,FADR0		;;A191
	TBLRDL [W1++],W0	;;
	MOV W0,FADR1		;;0038
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1],W0		;;
	CP W0,#0		;;
	BTSC SR,#Z 		;;
	MOV R1,W0		;;
	ADD T4ITMR,WREG		;;
	MOV W0,DPPB2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BLKC8		;;
	CALL DISP_BMP8		;;
	BTSS FLAGC,#ESCAPE_BMP8_F;;
	BRA DPP_END		;;	
	BRA DPP_END3		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP_T2:				;;
	MOV #6,W0		;;
	MUL DPPB3		;;	
	ADD W2,W1,W1		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,FADR0		;;
	TBLRDL [W1++],W0	;;
	MOV W0,COLOR_F		;;
	TBLRDL [W1],W0		;;
	MOV W0,COLOR_B		;;
	MOV R1,W0		;;
	ADD T4ITMR,WREG		;;
	MOV W0,DPPB2		;;
	CALL DISP_DPPFA		;;
	BRA DPP_END		;;
DPP_T3:				;;
	MOV #8,W0		;;
	MUL DPPB3		;;	
	ADD W2,W1,W1		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,FADR0		;;
	TBLRDL [W1++],W0	;;
	MOV W0,FADR1		;;
	TBLRDL [W1++],W0	;;
	MOV W0,COLOR_F		;;
	TBLRDL [W1],W0		;;
	MOV W0,COLOR_B		;;
	MOV R1,W0		;;
	ADD T4ITMR,WREG		;;
	MOV W0,DPPB2		;;
	CALL DISP_DPPFB		;;
	BRA DPP_END		;;
DPP_END:			;;	
	BTSC FLAGA,#ICONP_F	;;
	BRA DPP_END1		;; 
	MOV #12,W0		;;
	MUL DPP_CNT		;;
	MOV #DPPBUF,W0		;;
	ADD W0,W2,W2		;;
	BRA DPP_END2		;;
DPP_END1:			;;
	MOV #12,W0		;;
	MUL ICONP_CNT		;;
	MOV #ICONP_BUF,W0	;;
	ADD W0,W2,W2		;;
DPP_END2:			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB3,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP_END3:			;;
	POP R3			;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	POP LCDY_LIM1		;;
	POP LCDY_LIM0		;;
	POP LCDX_LIM1		;;
	POP LCDX_LIM0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









TFT_OFF:
	WLCDP 0x07,0x0036
	CALL DLYMS
	WLCDP 0x07,0x0026
	CALL DLYMS
	WLCDP 0x07,0x0004
	CALL DLYMS
	WLCDP 0x09,0x00E8
	WLCDP 0x03,0x01E0
	WLCDP 0x03,0x01E2
	RETURN





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SONG_STOP:			;;
	BCLR FLAGA,#SONG_F	;;	
	BCLR FLAGD,#SONG_KP_STOP_F;;	
SONG_STOP1:			;;
	MOVLF 0xFFFF,OC5R	;;
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
SONG_PRG:			;;
	BTSS FLAGA,#SONG_F	;;
	BRA SONG_STOP		;;
	INC SONG_CNT		;;
	MOV SONG_TIM,W0		;;	
	CP SONG_CNT		;;
	BRA GTU,SONG_PRG0	;;
	BRA Z,SONG_PRG00	;;
	RETURN			;;
SONG_PRG00:			;;
	MOV SONG_POT,W1		;;
	TBLRDL [W1],W0		;;
	BTSS W0,#7		;;
	BRA SONG_STOP1		;;
	RETURN			;;
SONG_PRG0:			;;
	MOV SONG_POT,W1		;;
	TBLRDL [W1],W0		;;
	INC2 SONG_POT 		;;
	CP0 W0			;;
	BRA Z,SONG_STOP		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #0x007F,W0		;;
	BRA NZ,SONG_PRG1	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF 0xFFFF,OC5R	;;
	TBLRDL [W1],W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	MOV W0,SONG_TIM		;;
	ADD SONG_TIM		;;
	ADD SONG_TIM		;;
	ADD SONG_TIM		;;
	CLR SONG_CNT		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
SONG_PRG1:			;;
	PUSH W1			;;
	BCLR T3CON,#TON		;;
	LOFFS1 MUSIC_TBL	;;
	ADD W0,W1,W1		;;
	ADD W0,W1,W1		;;
	TBLRDL [W1],W0		;;
	MOV W0,PR3		;;
	DEC2 W0,W2		;;
	MOV W2,OC5RS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,OC5R 		;;
	CLR TMR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET T3CON,#TON		;;
	POP W1			;;
	TBLRDL [W1],W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	MOV W0,SONG_TIM		;;
	ADD SONG_TIM		;;
	ADD SONG_TIM		;;
	ADD SONG_TIM		;;
	CLR SONG_CNT		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
RAMSTR_ADD_START:			;;
	CLR RAMSTR_CNT			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RAMSTR_ADD:				;;
	MOV #RAMSTR_BUF,W1		;;
	MOV RAMSTR_CNT,W2		;;
	ADD W1,W2,W1			;;
	BTSS W1,#0			;;
	BRA RAMSTR_ADD1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR W1,#0			;;
	MOV [W1],W2			;;
	SWAP W2				;;
	MOV.B W0,W2			;;
	SWAP W2				;;
	MOV W2,[W1]			;;
	INC2 W1,W1			;;
	CLR [W1]			;;
	INC RAMSTR_CNT			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RAMSTR_ADD1:				;;
	AND #255,W0			;;
	MOV W0,[W1]			;;
	INC RAMSTR_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_TPMSTBL:				;;
	CALL DARKSCR			;;
	CALL INIT_LCDLIM		;;
	MOV #PORCH_S_0_ADR0,W0		;;
	MOV W0,FADR0			;;
	MOV #PORCH_S_0_ADR1,W0		;;
	MOV W0,FADR1			;;
	MOVLF #24,BMPX			;;	
	MOVLF #52,BMPY			;;
	MOVLF #52,LCDX			;;
	MOVLF #52,LCDY			;;
	CALL GET_BLKC8			;;
	CALL DISP_BMP8			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_TPMS_FLAG:				;;
	MOV #TPMS_DATA,W3		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W3,W3			;;
	MOV [W3],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	INC2 W3,W3			;;
	MOV [W3],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	INC2 W3,W3			;;
	MOV [W3],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	INC2 W3,W3			;;
	MOV [W3],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	INC2 W3,W3			;;
	MOV [W3],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_TPMS_DATA:				;;
	MOV #TPMSV_0A,W2		;;
	MOV #TPMS_DATA,W3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_TPMS_DATA:				;;
	MOV #TPMSV_0A,W3		;;
	MOV #TPMS_DATA,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	INC2 W2,W2			;;
	INC2 W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	INC2 W2,W2			;;
	INC2 W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	INC2 W2,W2			;;
	INC2 W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	INC2 W2,W2			;;
	INC2 W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0			;;
	MOV W0,[W3++]			;;
	MOV [W2++],W0			;;
	AND #3,W0			;;
	MOV W0,[W3++]			;;
	INC2 W2,W2			;;
	INC2 W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INIT_TPMSV:
	MOV #TPMSV_BUF,W1		;;
	CLR [W1++]
	CLR [W1++]
	SETM [W1++]
	SETM [W1++]
	CLR [W1++]
	CLR [W1++]
	SETM [W1++]
	SETM [W1++]
	CLR [W1++]
	CLR [W1++]
	SETM [W1++]
	SETM [W1++]
	CLR [W1++]
	CLR [W1++]
	SETM [W1++]
	SETM [W1++]
	CLR [W1++]
	CLR [W1++]
	SETM [W1++]
	SETM [W1++]
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TPMS_DATA:				;;
	MOV #TPMS_DATA,W3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x4120,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x4120,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x4120,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x4120,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x4120,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x0000,W0			;;
	MOV W0,[W3++]			;;
	MOV #0x00FF,W0			;;
	MOV W0,[W3++]			;;
	MOV #0,W0			;;
	MOV W0,[W3++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #26,W0			;;
	MOV W0,TPMS_LOP_SETA		;;
	MOV W0,TPMS_LOP_SETB		;;
	MOV #45,W0			;;
	MOV W0,TPMS_HIP_SETA		;;
	MOV W0,TPMS_HIP_SETB		;;
	MOV #110,W0			;;
	MOV W0,TPMS_HIT_SETA		;;
	MOV W0,TPMS_HIT_SETB		;;
	CLR TPMS_PUNIT_SET		;;
	CLR TPMS_TUNIT_SET		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEMO_TPMSV:				;;
	MOV #TPMS_DATA,W1		;;
	MOV #0x4020,W0 			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
					;;
	MOV #0x4121,W0 			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
					;;
	MOV #0x4222,W0 			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
					;;
	MOV #0x4323,W0 			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;

	MOV #0x4424,W0 			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;

	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TPMSV_E:				;;
	MOV #TPMS_DATA,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W1,W1			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	IOR #0x88,W0			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W1,W1			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	IOR #0x88,W0			;;	
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W1,W1			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	IOR #0x88,W0			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W1,W1			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	IOR #0x88,W0			;;	
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W1,W1			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	IOR #0x88,W0			;;	
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_TPMSV:				;;
	MOV #TPMS_DATA,W1		;;
					;;
	CLR [W1++]			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
					;;
	CLR [W1++]			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
					;;
	CLR [W1++]			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
					;;
	CLR [W1++]			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
					;;
	CLR [W1++]			;;
	MOV [W1],W0			;;
	AND #3,W0			;;
	MOV W0,[W1++]			;;
	CLR [W1++]			;;
	CLR [W1++]			;;
					;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS_W5A:				;;
	CLR TPMSD_CNT			;;
	MOV TPMSSET_BUF,W0		;;
	SWAP W0				;;
	IOR TPMSSET_BUF,WREG		;;
	MOV W0,DPPB0			;;
	CLR DPPB1			;;
	BRA TRANS_TPMS1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS_W5B:				;;
	CLR TPMSD_CNT			;;
	INC TPMSD_CNT			;;
	MOV TPMSSET_BUF,W0		;;
	SWAP W0				;;
	IOR TPMSSET_BUF,WREG		;;
	MOV W0,DPPB0			;;
	CLR DPPB1			;;
	BRA TRANS_TPMS1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS_SET:				;;
	CLR TPMSD_CNT			;;
	MOV TPMSSET_BUF,W0		;;
	SWAP W0				;;
	IOR TPMSSET_BUF,WREG		;;
	MOV W0,DPPB0			;;
	CLR DPPB1			;;
	BRA TRANS_TPMS1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 	


;TPMS_DATA
;0 BYTE PSI
;1 BYTE TEMPC
;2 BYTE BIT0 0.5C
;	BIT1 BATLOW
;	BIT4 LOW PRESSURE
;	BIT5 HIGH PRESSURE
;	BIT6 HIGH TEMPERATUR  
;	BIT7 TXED  	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS:				;;
	INC TPMSD_CNT			;;
	MOV #4,W0			;;
	CP TPMSD_CNT			;;
	BRA LTU,$+4			;;
	CLR TPMSD_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS0:				;;
	MOV #8,W0			;;
	MUL TPMSD_CNT			;;
	MOV #TPMS_DATA,W0		;;
	ADD W0,W2,W2			;;
	MOV [W2++],W0			;;
	MOV W0,DPPB0 			;;
	MOV [W2++],W0			;;
	MOV W0,DPPB1 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS1:				;;
	MOV DPPB0,W0			;;
	BTSC FLAGD,#DISPCF_F		;;
	SWAP W0				;;
	BTSC FLAGD,#DISPCF_F		;;
	CALL TRANS_TPT			;;
	BTSS FLAGD,#DISPCF_F		;;
	CALL TRANS_PRESS		;;
	CALL ADJR210			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R1,W0			;;
	SWAP W0				;;
	IOR R0				;;
	BTSC FLAGD,#S1P_F		;;
	BSET R2,#9			;;
	BTSC FLAGD,#S2P_F		;;
	BSET R2,#8			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGD,#DISPCF_F
	BRA TRANS_TPMS1A
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC DPPB1,#7			;;	
	BRA $+6				;;
	MOV #2,W0			;;
	BRA TRANS_TPMS2			;;	 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTSS DPPB1,#4			;;	
	BRA $+6				;;
	MOV #3,W0			;;
	BRA TRANS_TPMS1B		;;	 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTSS DPPB1,#5			;;	
	BRA $+6				;;
	MOV #3,W0			;;
	BRA TRANS_TPMS1B		;;	 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0,W0			;;
	BRA TRANS_TPMS2			;;	 
TRANS_TPMS1A:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC DPPB1,#7			;;	
	BRA $+6				;;
	MOV #2,W0			;;
	BRA TRANS_TPMS2			;;	 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTSS DPPB1,#6			;;	
	BRA $+6				;;
	MOV #3,W0			;;
	BRA TRANS_TPMS1B		;;	 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0,W0			;;
	BRA TRANS_TPMS2			;;	 
TRANS_TPMS1B:				;;	
	BTSC FLAGF,#FLASH_F		;;
	MOV #0,W0			;;
	BRA TRANS_TPMS2			;;	 
TRANS_TPMS2:				;;
	SWAP.B W0			;;
	SWAP W0				;;
	IOR R2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
	MOV #8,W0			;;
	MUL TPMSD_CNT			;;
	MOV #TPMSV_BUF,W0		;;
	ADD W0,W2,W2			;;
	MOV R0,W0			;;
	MOV W0,[W2++]			;;
	MOV R2,W0			;;
	MOV W0,[W2++]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ADJR210:			;;
	CP0 R2			;;
	BRA Z,$+4		;;
	RETURN			;;	
	BTSC FLAGD,#S1P_F	;;
	RETURN			;;	
	MOV #16,W0		;;
	MOV W0,R2		;;
	CP0 R1			;;
	BRA Z,$+4		;;
	RETURN			;;	
	BTSC FLAGD,#S2P_F	;;
	RETURN			;;	
	MOV #16,W0		;;
	MOV W0,R1		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
TRANS_DDD:			;;
        BCLR FLAGD,#S1P_F       ;;
        BCLR FLAGD,#S2P_F       ;;
	MOV #17,W0		;;	
	MOV W0,R0		;;
	MOV W0,R1		;;
	MOV W0,R2		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPT:			;;
	AND #255,W0		;;
	MOV W0,R3		;;	
	MOV #255,W0		;;
	CP R3			;;
	BRA Z,TRANS_DDD		;;
        BCLR FLAGD,#S1P_F       ;;
        BCLR FLAGD,#S2P_F       ;;
	CLR R0			;;
	CLR R1			;;
	CLR R2			;;
	BTSC TPMS_TUNIT_SET,#0	;;
	BRA TRANS_TPTF		;;
TRANS_TPTC:			;;
	MOV #40,W0		;;
	SUB R3,WREG		;;
	BRA C,TRANS_TPTC1	;;	
	NEG W0,W0		;;	
	MOV #17,W1		;;
	MOV W1,R2		;;
	CALL L1D_2B		;;
	RETURN			;;
TRANS_TPTC1:			;;
	CALL L1D_3B		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPTF: 			;;	
	MOV #9,W0		;;
	MUL R3			;;
	MOV W2,W0		;;
	MOV #5,W2 		;;
	REPEAT #17		;;
	DIV.UW W0,W2		;;
	MOV W0,R3		;;
	BRA TRANS_TPTC		;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PRESS:                    ;;
	AND #255,W0		;;
	MOV W0,R3		;;	
	MOV #255,W0		;;
	CP R3			;;
	BRA Z,TRANS_DDD		;;
        BCLR FLAGD,#S1P_F       ;;
        BCLR FLAGD,#S2P_F       ;;
	BTSC TPMS_PUNIT_SET,#1	;;
	BRA TRANS_PRESS1	;;	
	BTSS TPMS_PUNIT_SET,#0	;;
	BRA TRANS_PSI		;;
	BRA TRANS_KPA		;;
TRANS_PRESS1:			;;
	BTSS TPMS_PUNIT_SET,#0	;;
	BRA TRANS_BAR		;;
	BRA TRANS_KGCM		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PSI:                      ;;
	MOV #100,W0		;;
	CP R3			;;
	BRA GEU,TRANS_PSI1	;;
        BSET FLAGD,#S2P_F       ;;
        MOV R3,W0               ;;
	CALL L1D_2B		;;
	MOV R1,W0		;;
	MOV W0,R2		;;
	MOV R0,W0		;;
	MOV W0,R1		;;
        MOV #0,W0               ;;
        BTSC DPPB1,#0           ;;
        MOV #5,W0               ;;
        MOV W0,R0               ;;
	RETURN			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PSI1:			;;
	MOV R3,W0		;;
	CALL L1D_3B		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_KGCM: 			;;
	MOV #70,W0		;;
	BRA TRANS_BAR0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_BAR: 			;;
	MOV #69,W0		;;
TRANS_BAR0:			;;
	MUL R3			;;
        BTSC DPPB1,#0           ;;
	ADD #35,W2		;;
	MOV W2,W0		;;
	CALL L1D_5B		;;	
	CALL DEL_R0		;;
	CP0 R3			;;
	BRA NZ,TRANS_BAR1	;;
        BSET FLAGD,#S1P_F       ;;
	RETURN			;;
TRANS_BAR1:			;;
        BSET FLAGD,#S2P_F       ;;
	MOV R1,W0		;;
	MOV W0,R0		;;
	MOV R2,W0		;;
	MOV W0,R1		;;
	MOV R3,W0		;;
	MOV W0,R2		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_KPA:			;;
	MOV #69,W0		;;
	MUL R3			;;
        BTSC DPPB1,#0           ;;
	ADD #35,W2		;;
	MOV W2,W0		;;
	CALL L1D_5B		;;
	CALL DEL_R0		;;
	CP0 R3			;;
	BRA NZ,$+4		;;
	RETURN			;;
	MOV #9,W0		;;
	MOV W0,R0		;;
	MOV W0,R1		;;
	MOV W0,R2		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
DEL_R0:				;;
	MOV R0,W1		;;
	MOV R1,W0		;;
	MOV W0,R0		;;
	MOV R2,W0		;;
	MOV W0,R1		;;
	MOV R3,W0		;;
	MOV W0,R2		;;
	MOV R4,W0		;;
	MOV W0,R3		;;
	MOV W1,R4		;;
	MOV #5,W0		;;
	CP R4			;;	
	BRA GEU,$+4		;;
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC R0			;;
	MOV #10,W0		;;	
	CP R0			;;
	BRA GEU,$+4		;;
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR R0			;;
	INC R1			;;
	MOV #10,W0		;;
	CP R1			;;
	BRA GEU,$+4		;;
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR R1			;;
	INC R2			;;
	MOV #10,W0		;;
	CP R2			;;
	BRA GEU,$+4		;;
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR R2			;;
	INC R3			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_TPMS_ALM:			;;
	BCLR FLAGF,#CTA_F	;;
	MOV #8,W0		;;
	MUL TPMSI_CNT		;;
	MOV #TPMS_DATA,W0	;;
	ADD W0,W2,W1		;;
	MOV [W1++],W0		;;
	MOV W0,DPPB0		;;
	MOV [W1++],W0		;;
	MOV W0,DPPB1		;;
	MOV [W1++],W0		;;
	MOV W0,DPPB2		;;
	MOV [W1++],W0		;;
	MOV W0,DPPB3		;;
	MOV TPMS_LOP_SETA,W0	;;
	BTSC TPMSI_CNT,#1	;;	
	MOV TPMS_LOP_SETB,W0	;;
	MOV W0,DPPB5		;;
	MOV TPMS_HIP_SETA,W0	;;
	BTSC TPMSI_CNT,#1	;;	
	MOV TPMS_HIP_SETB,W0	;;
	MOV W0,DPPB6		;;
	MOV TPMS_HIT_SETA,W0	;;
	BTSC TPMSI_CNT,#1	;;	
	MOV TPMS_HIT_SETB,W0	;;
	MOV W0,DPPB7		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0		;;
	AND #255,W0		;;	
	MOV W0,W2		;;	
	CP DPPB5;;TPMS_LOP_SET	;;
	BRA LEU,$+4		;;
	BSET DPPB1,#4		;;
	BRA GEU,$+4		;;
	BCLR DPPB1,#4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP DPPB6;;TPMS_HIP_SET	;;
	BRA GEU,$+4		;;
	BSET DPPB1,#5		;;
	BRA LEU,$+4		;;
	BCLR DPPB1,#5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0		;;
	SWAP W0			;;
	AND #255,W0		;;	
	MOV W0,W3		;;
	CP DPPB7;;TPMS_HIT_SET	;;
	BRA GEU,$+4		;;
	BSET DPPB1,#6		;;
	BRA LEU,$+4		;;
	BCLR DPPB1,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR DPPB4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0		;;
	AND #255,W0		;;
	CP W2,W0		;;
	BRA GEU,CTA_1		;;	
	BSET DPPB4,#4 		;;
	MOV DPPB2,W0		;;
	MOV.B W2,W0		;;
	MOV W0,DPPB2		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
CTA_1:				;;
	MOV DPPB2,W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	CP W2,W0		;;
	BRA LEU,CTA_2		;;	
	BSET DPPB4,#5 		;;
	MOV DPPB2,W0		;;
	SWAP W0			;;
	MOV.B W2,W0		;;
	SWAP W0			;;
	MOV W0,DPPB2		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
CTA_2:				;;
	MOV DPPB3,W0		;;
	AND #255,W0		;;
	CP W3,W0		;;
	BRA LEU,CTA_3		;;	
	BSET DPPB4,#6 		;;
	MOV DPPB3,W0		;;
	MOV.B W3,W0		;;
	MOV W0,DPPB3		;; 
CTA_3:				;;
	MOV DPPB2,W0		;;
	MOV DPPB5,W2;;TPMS_LOP_SET,W2	;;
	MOV.B W2,W0		;;
	BTSS DPPB1,#4		;;
	MOV W0,DPPB2		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0		;;
	SWAP W0			;;
	MOV DPPB6,W2;;TPMS_HIP_SET,W2	;;
	MOV.B W2,W0		;;
	SWAP W0			;;
	BTSS DPPB1,#5		;;
	MOV W0,DPPB2		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB3,W0		;;
	MOV DPPB7,W2;;TPMS_HIT_SET,W2	;;
	MOV.B W2,W0		;;
	BTSS DPPB1,#6		;;
	MOV W0,DPPB3		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0		;;
	AND DPPB4,WREG		;;
	AND #0x0070,W0		;;
	BRA Z,CTA_4		;;
	BSET FLAGF,#CTA_F	;;
CTA_4:				;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS_ICON:		;;
	INC TPMSI_CNT		;;
	MOV #5,W0		;;
	CP TPMSI_CNT		;;
	BRA LTU,TRANS_TPMS_ICON0;;
	CLR TPMSI_CNT		;;
	BCLR FLAGE,#TPMS_FIRST_F;;
TRANS_TPMS_ICON0:		;;
	MOV #8,W0		;;
	MUL TPMSI_CNT		;;
	MOV #TPMS_DATA,W0	;;
	ADD W0,W2,W1		;;
	MOV [W1++],W0		;;
	MOV W0,DPPB0		;;
	MOV [W1++],W0		;;
	MOV W0,DPPB1		;;
	MOV [W1++],W0		;;
	MOV W0,DPPB2		;;
	MOV [W1++],W0		;;
	MOV W0,DPPB3		;;
	MOV TPMS_LOP_SETA,W0	;;
	BTSC TPMSI_CNT,#1	;;	
	MOV TPMS_LOP_SETB,W0	;;
	MOV W0,DPPB5		;;
	MOV TPMS_HIP_SETA,W0	;;
	BTSC TPMSI_CNT,#1	;;	
	MOV TPMS_HIP_SETB,W0	;;
	MOV W0,DPPB6		;;
	MOV TPMS_HIT_SETA,W0	;;
	BTSC TPMSI_CNT,#1	;;	
	MOV TPMS_HIT_SETB,W0	;;
	MOV W0,DPPB7		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BTSC FLAGE,#TPMS_FIRST_F
;	BRA TTI_1		;;	
	BTSS DPPB1,#3		;;
	BRA TRANS_TPMS_ICON2	;;
	BCLR DPPB1,#3		;;
TTI_1: 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0		;;
	AND #255,W0		;;	
	MOV W0,W2		;;	
	CP DPPB5;;TPMS_LOP_SET	;;
	BRA LEU,$+4		;;
	BSET DPPB1,#4		;;
	BRA GEU,$+4		;;
	BCLR DPPB1,#4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP DPPB6;;TPMS_HIP_SET	;;
	BRA GEU,$+4		;;
	BSET DPPB1,#5		;;
	BRA LEU,$+4		;;
	BCLR DPPB1,#5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0		;;
	SWAP W0			;;
	AND #255,W0		;;	
	MOV W0,W3		;;
	CP DPPB7;;TPMS_HIT_SET	;;
	BRA GEU,$+4		;;
	BSET DPPB1,#6		;;
	BRA LEU,$+4		;;
	BCLR DPPB1,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR DPPB4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0		;;
	AND #255,W0		;;
	CP W2,W0		;;
	BRA GEU,TTIX1		;;	
	BSET DPPB4,#4 		;;
	MOV DPPB2,W0		;;
	MOV.B W2,W0		;;
	MOV W0,DPPB2		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
TTIX1:				;;
	MOV DPPB2,W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	CP W2,W0		;;
	BRA LEU,TTIX2		;;	
	BSET DPPB4,#5 		;;
	MOV DPPB2,W0		;;
	SWAP W0			;;
	MOV.B W2,W0		;;
	SWAP W0			;;
	MOV W0,DPPB2		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
TTIX2:				;;
	MOV DPPB3,W0		;;
	AND #255,W0		;;
	CP W3,W0		;;
	BRA LEU,TTIX3		;;	
	BSET DPPB4,#6 		;;
	MOV DPPB3,W0		;;
	MOV.B W3,W0		;;
	MOV W0,DPPB3		;; 
TTIX3:				;;
	MOV DPPB2,W0		;;
	MOV DPPB5,W2;;TPMS_LOP_SET,W2	;;
	MOV.B W2,W0		;;
	BTSS DPPB1,#4		;;
	MOV W0,DPPB2		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0		;;
	SWAP W0			;;
	MOV DPPB6,W2;;TPMS_HIP_SET,W2	;;
	MOV.B W2,W0		;;
	SWAP W0			;;
	BTSS DPPB1,#5		;;
	MOV W0,DPPB2		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB3,W0		;;
	MOV DPPB7,W2;;TPMS_HIT_SET,W2	;;
	MOV.B W2,W0		;;
	BTSS DPPB1,#6		;;
	MOV W0,DPPB3		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0		;;
	AND #0x0070,W0		;;
	SWAP.B W0		;;
	MOV W0,TPMSALM_TYP 	;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0		;;
	AND DPPB4,WREG		;;
	AND #0x0070,W0		;;
	BRA Z,TRANS_TPMS_ICON1	;;
;	BTSC TPMSI_CNT,#2	;;	
;	BRA TRANS_TPMS_ICON2	;;
	BTSC FLAGE,#TPMS_LEN_F	;;
	BRA TRANS_TPMS_ICON2	;;
;	SWAP.B W0		;;
;	MOV W0,TPMSALM_TYP 	;;	
;	BTSC FLAGE,#TPMS_FIRST_F;;
;	BRA TRANS_TPMS_ICON1	;;	
	MOV #60,W0		;;
	ADD MENU_ESC_TIM,WREG	;;
	CP TFT_ON_TIM		;;
	BRA GTU,TTIX4		;;
	MOV #60,W0		;;
	MOV W0,TFT_ON_TIM	;;	
	CLR MENU_ESC_TIM	;;
TTIX4:				;;
	BSET FLAGE,#TPMS_ALMBBB_F;;	
	CLR TPMS_ALMBB_CNT	;; 
;	MOV #100,W0		;;
;	BTSC TPMSI_CNT,#2	;;	
;	MOV W0,TPMS_ALMBB_CNT	;;
	CLR TPMS_ALMBB_TIM	;;
	CALL SING_TPMS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS_ICON1:		;;
	MOV DPPB1,W0		;;
	AND #0x0070,W0		;;
	BRA Z,$+4		;;
	BSET FLAGE,#TPMS_ALMED_F;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS_ICON2:		;;
	MOV #4,W4		;;	
	BTSC DPPB1,#4		;;
	MOV #2,W4		;;
	BTSC DPPB1,#5		;;
	MOV #1,W4		;;
	BTSC DPPB1,#6		;;
	MOV #3,W4		;;
	BTSC FLAGE,#TPMS_LEN_F	;;
	MOV #4,W4		;;	
	BTSS DPPB1,#7		;;
	MOV #0,W4 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #12,W0		;;
	MUL TPMSI_CNT		;;
	BTSC TPMSI_CNT,#2	;;
	ADD #72,W2		;;
	MOV #DPPBUF,W0		;;
	ADD W0,W2,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W2		;;
	SWAP W2			;;
	MOV.B W4,W2		;;
	SWAP W2			;;
	MOV W2,[W1]		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC TPMSI_CNT,#2	;;	
	BRA TRANS_TPMS_ICON3	;;
	MOV #48,W0		;;
	ADD W0,W1,W1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #2,W4		;;	
	BTSC DPPB1,#1		;;
	MOV #0,W4		;;
	BTSC DPPB1,#6		;;
	MOV #1,W4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1],W2		;;
	SWAP W2			;;
	MOV.B W4,W2		;;
	SWAP W2			;;
	MOV W2,[W1]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TPMS_ICON3:		;;
	MOV #8,W0		;;
	MUL TPMSI_CNT		;;
	MOV #TPMS_DATA,W0	;;
	ADD W0,W2,W1		;;
	MOV DPPB0,W0		;;
	MOV W0,[W1++]		;;
	MOV DPPB1,W0		;;
	MOV W0,[W1++]		;;
	MOV DPPB2,W0		;;
	MOV W0,[W1++]		;;
	MOV DPPB3,W0		;;
	MOV W0,[W1++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TIREV0B,W0		;;	
	IOR TIREV1B,WREG	;;
	IOR TIREV2B,WREG	;;
	IOR TIREV3B,WREG	;;	
	IOR TIREV4B,WREG	;;	
	AND #0x0070,W0		;;
	BTSC SR,#Z		;;
	BCLR FLAGE,#TPMS_ALMED_F;;
	BTSC SR,#Z		;;
	BCLR FLAGE,#TPMS_ALMBBB_F;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMSIC_PRG:				;;	
	MOV TPMS_PUNIT_SET,W0		;;
	BTSC FLAGD,#DISPCF_F		;;
	MOV TPMS_TUNIT_SET,W0		;;
	BTSC FLAGD,#DISPCF_F		;;
	ADD #4,W0			;;
	MOV #8,W1			;;
	LOFFS2 TP_PSI_TBL		;;
	CALL CHG_DPPXT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGE,#TPMS_LEN_F		;;
	BRA TPMSIC_PRG1			;;
	MOV #4,W0			;;
	MOV #9,W1			;;
	LOFFS2 TP_STATUS_TBL		;;
	CALL CHG_DPPXT			;;
	RETURN				;;
TPMSIC_PRG1:				;;
	BTSS FLAGE,#TPMS_ALMED_F	;;
	BRA TPMSIC_PRG2			;;
	MOV #3,W0			;;
	BTSC TPMSALM_TYP,#2		;;
	MOV #8,W0			;;
	BTSC TPMSALM_TYP,#1		;;
	MOV #7,W0			;;
	BTSC TPMSALM_TYP,#0		;;
	MOV #6,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #9,W1			;;
	LOFFS2 TP_STATUS_TBL		;;
	CALL CHG_DPPXT			;;	
	RETURN				;;
TPMSIC_PRG2:				;;
	BTSS FLAGE,#BATLL_F 		;;
	BRA TPMSIC_PRG3			;;
	MOV #2,W0			;;
	MOV #9,W1			;;
	LOFFS2 TP_STATUS_TBL		;;
	CALL CHG_DPPXT			;;	
	RETURN				;;
TPMSIC_PRG3:				;;
	MOV #9,W1			;;
	LOFFS2 TP_GTIRE_TBL		;;
	CALL CHG_DPPDT			;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;DRAW_HV:
	MOV HV_BUF,W0	
	CP POWV_TEMP
	BRA NZ,$+4
	RETURN
	MOV W0,HV_TEMP
	

DRAW_HV:
	MOV #'W',W0		;;
	CALL RAMSTR_ADD_START	;;
	MOV #'A',W0		;;
	CALL RAMSTR_ADD		;;
	MOV #'I',W0		;;
	CALL RAMSTR_ADD		;;
	MOV #'T',W0		;;
	CALL RAMSTR_ADD		;;
	MOVLF 0,LCDX_LIM0	;;
	MOVLF 127,LCDX_LIM1	;;
	MOVLF 0,LCDY_LIM0	;;
	MOVLF 159,LCDY_LIM1	;;
	MOVLF 0,LCDX		;;
	MOVLF 130,LCDY		;;
	
	CALL RRSTR		;;
	RETURN

DRAW_PV:
DRAW_RV:



DISP_POWV:
	MOV POWV_BUF,W0
	CP POWV_TEMP
	BRA NZ,$+4
	RETURN
	MOV W0,POWV_TEMP


	CALL C_WTBK
	BTSC VPOW_R,#VPOW_F		;;
	CALL C_RDBK
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #30,W0			;;
	MUL POWV_BUF			;;
	MOV W2,W0			;;
	MOV #189,W2			;;
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	CALL L1D_3B
	CP0 R2
	BRA NZ,DISP_POWV1

	LXY 93,93
	MOV #' ',W0
	CALL ENCHR
	LXY 117,93
	MOV #' ',W0
	CALL ENCHR
	LXY 97,93
	MOV R1,W0
	CALL ENNUM
	MOV #'.',W0
	CALL ENCHR
	MOV R0,W0
	CALL ENNUM
	BRA DISP_POWV2
DISP_POWV1:
	LXY 93,93
	MOV R2,W0
	CALL ENNUM
	MOV R1,W0
	CALL ENNUM
	MOV #'.',W0
	CALL ENCHR
	MOV R0,W0
	CALL ENNUM
DISP_POWV2:
	CALL C_WTBK
	RETURN
	

DISP_PVD:
	MOV PV_BUF,W0
	MOV W0,R0
	BTSC R0,#15
	NEG R0
	MOV #9,W0
	MUL R0
	MOV W2,W0			;;
	MOV #20,W2 			;;
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	MOV W0,R0
	BTSC PV_BUF,#15
	NEG R0
	MOV #12,W0
	ADD R0,WREG
	MOV W0,PVD_BUF 
	

	MOV PVD_BUF,W0	
	CP PVD_TEMP
	BRA NZ,$+4
	RETURN
	MOV W0,PVD_TEMP			;;
	MOV #DEGREE_0_ADR0,W0		;;
	MOV W0,FADR0			;;
	MOV #DEGREE_0_ADR1,W0		;;
	MOV W0,FADR1			;;
	MOVLF 44,LCDX_LIM0		;;
	MOVLF 83,LCDX_LIM1		;;
	MOVLF 30,LCDY_LIM0		;;
	MOVLF 69,LCDY_LIM1		;;
	MOVLF #40,BMPX			;;	
	MOVLF #80,BMPY			;;
	MOVLF #44,LCDX			;;
	MOVLF #21,LCDY			;;0=12,20,21
	MOV PVD_BUF,W0 
	MOV W0,LCDY
	CALL GET_BMPS			;;
	CALL DISP_BMP24			;;
	CALL INIT_LCDLIM		;;
	RETURN


TRANS_DDA:
	MOV W0,R0
	MOV #'0',W0
	CP R0
	BRA Z,TDDA_0
	MOV #'1',W0
	CP R0
	BRA Z,TDDA_1
	MOV #'2',W0
	CP R0
	BRA Z,TDDA_2
	MOV #'3',W0
	CP R0
	BRA Z,TDDA_3
	MOV #'4',W0
	CP R0
	BRA Z,TDDA_4
	MOV #'5',W0
	CP R0
	BRA Z,TDDA_5
	MOV #'6',W0
	CP R0
	BRA Z,TDDA_6
	MOV #'7',W0
	CP R0
	BRA Z,TDDA_7
	MOV #'8',W0
	CP R0
	BRA Z,TDDA_8
	MOV #'9',W0
	CP R0
	BRA Z,TDDA_9
	MOV #'-',W0
	CP R0
	BRA Z,TDDA_M
	MOV #' ',W0
	CP R0
	BRA Z,TDDA_S
	BRA TDDA_S
TDDA_0:
	MOV #0,W0
	RETURN	
TDDA_1:
	MOV #1,W0
	RETURN	
TDDA_2:
	MOV #2,W0
	RETURN	
TDDA_3:
	MOV #3,W0
	RETURN	
TDDA_4:
	MOV #4,W0
	RETURN	
TDDA_5:
	MOV #5,W0
	RETURN	
TDDA_6:
	MOV #6,W0
	RETURN	
TDDA_7:
	MOV #7,W0
	RETURN	
TDDA_8:
	MOV #8,W0
	RETURN	
TDDA_9:
	MOV #9,W0
	RETURN	
TDDA_M:
	MOV #17,W0
	RETURN	
TDDA_S:
	MOV #16,W0
	RETURN	
TDDA_A:
	MOV #10,W0
	RETURN	
TDDA_B:
	MOV #11,W0
	RETURN	
TDDA_C:
	MOV #12,W0
	RETURN	
TDDA_D:
	MOV #13,W0
	RETURN	
TDDA_E:
	MOV #14,W0
	RETURN	
TDDA_F:
	MOV #15,W0
	RETURN	

DISP_PV:
	MOV #DDB_BUF,W1
	MOV #DDB_BUF+10,W2
	MOVLF #5,R7
DISP_PV0:
	MOV [W1++],W0
	MOV [W2++],W3
	CP W0,W3
	BRA NZ,DISP_PV1
	DEC R7	
	BRA NZ,DISP_PV0
	RETURN
DISP_PV1:
	MOV #DDB_BUF,W1
	MOV #DDB_BUF+10,W2
	MOVLF #5,R7
DISP_PV2:
	MOV [W1++],W0
	MOV W0,[W2++]
	DEC R7	
	BRA NZ,DISP_PV2

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #DDB_BUF,W1
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R3
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R2
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R1
	MOV [W1++],W0
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R0

	MOV #0,W2
	MOV #16,W0
	CP R2
	BRA Z,DISP_PV3
	MOV #17,W0
	CP R2
	BRA Z,DISP_PV3
	MOV #10,W0
	MUL R2
DISP_PV3:
	MOV R1,W0
	ADD W0,W2,W0
	MOV W0,PV_BUF
	MOV #17,W0
	CP R3
	BRA NZ,$+4	
	NEG PV_BUF

	MOV #17,W0
	CP R2
	BRA NZ,$+4	
	NEG PV_BUF
	

	MOVLF #0,FCOLOR			;;
	MOVLF #30,LCDX			;;
	MOVLF #80,LCDY			;;
 	CALL DISP_NUM4			;;
	RETURN


DISP_HV:  
	MOV #DDA_BUF,W1
	MOV #DDA_BUF+10,W2
	MOVLF #5,R7
DISP_HV0:
	MOV [W1++],W0
	MOV [W2++],W3
	CP W0,W3
	BRA NZ,DISP_HV1
	DEC R7	
	BRA NZ,DISP_HV0
	RETURN
DISP_HV1:
	MOV #DDA_BUF,W1
	MOV #DDA_BUF+10,W2
	MOVLF #5,R7
DISP_HV2:
	MOV [W1++],W0
	MOV W0,[W2++]
	DEC R7	
	BRA NZ,DISP_HV2

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #DDA_BUF,W1
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R3
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R2
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R1
	MOV [W1++],W0
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R0

	CALL GET_DEGA



	MOVLF #1,FCOLOR			;;
	MOVLF #64,LCDX			;;
	MOVLF #130,LCDY			;;
 	CALL DISP_NUM4			;;
	RETURN


GET_DEGA:
	MOV #16,W0
	CP R3
	BRA NZ,GET_DEGA_1
	MOV #16,W0
	CP R2
	BRA NZ,GET_DEGA_2
	MOV R1,W0
	MOV W0,DEG_A
	RETURN
GET_DEGA_1:
	MOV #100,W0
	MUL R3
	MOV W2,W4
	MOV #10,W0
	MUL R2	
	ADD W4,W2,W0
	ADD R1,WREG
	MOV W0,DEG_A
	RETURN
GET_DEGA_2:
	MOV #10,W0
	MUL R2	
	MOV W2,W0
	ADD R1,WREG
	MOV W0,DEG_A
	RETURN
	



GET_DEGB:
	MOV #16,W0
	CP R3
	BRA NZ,GET_DEGB_1
	MOV #16,W0
	CP R2
	BRA NZ,GET_DEGB_2
	MOV R1,W0
	MOV W0,DEG_B
	RETURN
GET_DEGB_1:
	MOV #17,W0
	CP R3
	BRA Z,GET_DEGB_2M
	MOV #100,W0
	MUL R3
	MOV W2,W4
	MOV #10,W0
	MUL R2	
	ADD W4,W2,W0
	ADD R1,WREG
	MOV W0,DEG_B
	RETURN
GET_DEGB_2:
	MOV #17,W0
	CP R2
	BRA Z,GET_DEGB_3M
	MOV #10,W0
	MUL R2	
	MOV W2,W0
	ADD R1,WREG
	MOV W0,DEG_B
	RETURN


GET_DEGB_2M:
	MOV #10,W0
	MUL R2	
	MOV W2,W0
	ADD R1,WREG
	MOV W0,DEG_B
	NEG DEG_B
	RETURN

GET_DEGB_3M:
	MOV R1,W0
	MOV W0,DEG_B
	NEG DEG_B
	RETURN










DISP_RV:  
	MOV #DDC_BUF,W1
	MOV #DDC_BUF+10,W2
	MOVLF #5,R7
DISP_RV0:
	MOV [W1++],W0
	MOV [W2++],W3
	CP W0,W3
	BRA NZ,DISP_RV1
	DEC R7	
	BRA NZ,DISP_RV0
	RETURN
DISP_RV1:
	MOV #DDC_BUF,W1
	MOV #DDC_BUF+10,W2
	MOVLF #5,R7
DISP_RV2:
	MOV [W1++],W0
	MOV W0,[W2++]
	DEC R7	
	BRA NZ,DISP_RV2

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #DDC_BUF,W1
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R3
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R2
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R1
	MOV [W1++],W0
	MOV [W1++],W0
	CALL TRANS_DDA
	MOV W0,R0
	CALL GET_DEGB
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF #2,FCOLOR			;;
	MOVLF #-4,LCDX			;;
	MOVLF #130,LCDY			;;
 	CALL DISP_NUM4			;;
	RETURN



DISP_NUM4:
	MOV #16,W0
	CP R3
	BRA NZ,DISP_NUM4_1
	MOV #16,W0
	CP R2
	BRA NZ,DISP_NUM4_2
	MOVLF 14,BMPX			;;
	MOVLF 20,BMPY			;;
	CALL W_SPACE
	MOV R1,W0
	CALL WNUM
	CALL WPOINT			;;
	MOV R0,W0
	CALL WNUM
	MOVLF 14,BMPX			;;
	MOVLF 20,BMPY			;;
	CALL W_SPACE
	RETURN
DISP_NUM4_1:
	MOV R3,W0
	CALL WNUM
	MOV R2,W0
	CALL WNUM
	MOV R1,W0
	CALL WNUM
	CALL WPOINT			;;
	MOV R0,W0
	CALL WNUM
	RETURN
DISP_NUM4_2:
	MOVLF 7,BMPX			;;
	MOVLF 20,BMPY			;;
	CALL W_SPACE
	MOV R2,W0
	CALL WNUM
	MOV R1,W0
	CALL WNUM
	CALL WPOINT			;;
	MOV R0,W0
	CALL WNUM
	MOVLF 7,BMPX			;;
	MOVLF 20,BMPY			;;
	CALL W_SPACE
	RETURN

 

DISP_DEG:
	BTSS TMR2_FLAG,#T4M_F		;;0=64US	
	RETURN				;;
	CALL SET_DEG_BUFA
	MOV #60,W0
	MOV W0,RADIUS
	CALL C_YLBK
	CALL DRAW_DEGA
	;;;;;;;;;;;;;;;;;;;
	CALL SET_DEG_BUFB
	MOV #54,W0
	MOV W0,RADIUS
	CALL C_GRBK
	CALL DRAW_DEGB

	RETURN

	INC DEG_A
	MOV #360,W0
	CP DEG_A
	BRA LTU,$+4
	CLR DEG_A

	DEC DEG_B
	BTSS DEG_B,#15
	RETURN
	MOV #360,W0
	MOV W0,DEG_B
	
	RETURN
DRAW_LINE:
	PUSH R0
	MOV W0,R0
DRAW_LINE_1:
	CALL DRAW_POINT
	INC LCDX
	DEC R0
	BRA NZ,DRAW_LINE_1
	POP R0
	RETURN

U1RXP:
	BCLR FLAGG,#U1RX_PACK_F		;;
	CLR R1
	CLR R0
U1RXP_1:	
	MOV #U1RX_BUF,W1
	MOV R0,W0
	ADD W0,W1,W1
	ADD W0,W1,W1
	MOV [W1],W0
	XOR #0x2C,W0
	BRA NZ,U1RXP_2
	MOV #U1RXP_TEMP,W1
	MOV R1,W0
	ADD W0,W1,W1
	ADD W0,W1,W1
	MOV R0,W0
	MOV W0,[W1]
	INC R1
	MOV #10,W0
	CP R1
	BRA LTU,$+4
	RETURN
U1RXP_2:
	INC R0
	MOV U1RX_BYTE,W0
	CP R0
	BRA LTU,U1RXP_1
	MOV #6,W0
	CP R1
	BRA GEU,$+4
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1RXP_TEMP,W1
	MOV [W1++],W0
	MOV W0,R2
	MOV [W1++],W0
	MOV W0,R3
	MOV [W1++],W0
	MOV W0,R4
	MOV [W1++],W0
	MOV W0,R5
	MOV [W1++],W0
	MOV W0,R6
	MOV [W1++],W0
	MOV W0,R7
	INC R2
	INC R4
	INC R6
	MOV R2,W0
	SUB R3
	MOV R4,W0
	SUB R5
	MOV R6,W0
	SUB R7

	MOV #DDA_BUF,W1
	MOV #U1RX_BUF,W2
	MOV R2,W0
	MOV W0,R0
	MOV R3,W0
	MOV W0,R1
	CALL L_DEG

	MOV #DDB_BUF,W1
	MOV #U1RX_BUF,W2
	MOV R4,W0
	MOV W0,R0
	MOV R5,W0
	MOV W0,R1
	CALL L_DEG

	MOV #DDC_BUF,W1
	MOV #U1RX_BUF,W2
	MOV R6,W0
	MOV W0,R0
	MOV R7,W0
	MOV W0,R1
	CALL L_DEG
	NOP
	NOP
	NOP

	RETURN
L_DEG:
	CP0 R1
	BRA NZ,$+4
	RETURN
	MOV #6,W0
	CP R1
	BRA LTU,$+4
	RETURN
	MOV #5,W0
	CP R1
	BRA Z,L_DEG_1
	MOV #4,W0
	CP R1
	BRA Z,L_DEG_0C
	MOV #3,W0
	CP R1
	BRA Z,L_DEG_0B
	MOV #2,W0
	CP R1
	BRA Z,L_DEG_0A
L_DEG_0A:
	MOV #' ',W0
	MOV W0,[W1++]
L_DEG_0B:
	MOV #' ',W0
	MOV W0,[W1++]
L_DEG_0C:
	MOV #' ',W0
	MOV W0,[W1++]
L_DEG_1:
	MOV R0,W0
	MOV #U1RX_BUF,W2
	ADD W2,W0,W2
	ADD W2,W0,W2
	MOV [W2],W0
	MOV W0,[W1++]
	INC R0
	DEC R1
	BRA NZ,L_DEG_1
	RETURN
	



	MOV #U1RX_BUF,W1
	MOV R2,W0
	ADD W0,W1,W1
	ADD W0,W1,W1
	MOV [W1],W0
	MOV W0,DPPB4
	

	NOP
	NOP
	NOP
	NOP
	RETURN	




	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_PRG:				;;
	CLR DEG_A
	MOV #360,W0
	MOV W0,DEG_B	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_PRG0:				;;
	BCLR FLAGB,#BATLOW_F 		;;
	BCLR FLAGE,#BATLL_F 		;;
	BCLR FLAGE,#BATLLL_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BSET BKLCE,#BKLCE_P		;;
;	BSET FLAGF,#BKLCE_F		;;
	CALL OSC_H			;;
	CALL INIT_MAIN			;;
	CALL COMPASS_FRAM	
	CALL INIT_LCDLIM

	CALL C_RDBK
	LXY 30,50
	MOV #68,W0
	CALL DRAW_LINE

	CALL COLOR0
	LXY 10,110
	MOV #'R',W0
	CALL ENCHR
	LXY 107,110
	MOV #'H',W0
	CALL ENCHR
	LXY 60,100
	MOV #'P',W0
	CALL ENCHR



	BCLR FLAGD,#TPMSSET_F		;;
	BCLR FLAGE,#TPMS_LEN_F		;;		
	CLR MENU_ESC_TIM		;;
;	CALL CHKAD_BAT			;;
;	CALL CHKAD_POW			;;
	BCLR FLAGF,#TPMS_ESC_F		;; 
	BTSS VDET_R,#VDET_F		;;
	BSET FLAGF,#TPMS_ESC_F		;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	LOFFS1 TP_TIRE_TBL		;;
;	MOVLF 45,LCDX			;;
;	MOVLF 54,LCDY			;;
;	CALL LOAD_DPP			;;
;	LOFFS1 TP_TIRE_TBL		;;
;	MOVLF 76,LCDX			;;
;	MOVLF 54,LCDY			;;
 ;	CALL LOAD_DPP			;;
;	LOFFS1 TP_TIRE_TBL		;;
;	MOVLF 45,LCDX			;;
;	MOVLF 86,LCDY			;;
; ;	CALL LOAD_DPP			;;
;	LOFFS1 TP_TIRE_TBL		;;
;	MOVLF 76,LCDX			;;
;	MOVLF 86,LCDY			;;
 ;	CALL LOAD_DPP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	LOFFS1 TP_WBAT_TBL		;;
;	MOVLF 36,LCDX			;;
;	MOVLF 56,LCDY			;;
; 	CALL LOAD_DPP			;;
;	LOFFS1 TP_WBAT_TBL		;;
;	MOVLF 83,LCDX			;;
;	MOVLF 56,LCDY			;;
 ;	CALL LOAD_DPP			;;
;	LOFFS1 TP_WBAT_TBL		;;
;	MOVLF 36,LCDX			;;
;	MOVLF 88,LCDY			;;
 ;	CALL LOAD_DPP			;;
;	LOFFS1 TP_WBAT_TBL		;;
;	MOVLF 83,LCDX			;;
;	MOVLF 88,LCDY			;;
 ;	CALL LOAD_DPP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	LOFFS1 TP_PSI_TBL		;;
;	MOVLF 95,LCDX			;;
;	MOVLF 50,LCDY			;;
;	MOV TPMS_PUNIT_SET,W0		;;
 ;	CALL LOAD_DPPX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	LOFFS1 TP_GTIRE_TBL		;;
;	MOVLF 0,LCDX			;;
;	MOVLF 59,LCDY			;;
 ;	CALL LOAD_DPP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	LOFFS1 TP_W5_TBL		;;
;	MOVLF 54,LCDX			;;
;	MOVLF 106,LCDY			;;
;	BTSS W5_EN_SET,#0		;;
 ;	CALL LOAD_DPP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR TPMSI_CNT			;;
	DEC TPMSI_CNT			;;
	BSET FLAGE,#TPMS_FIRST_F	;;	
	CLR PV_BUF
	SETM PV_TEMP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_LOOP:
	BTSC FLAGG,#U1RX_PACK_F		;;
	CALL U1RXP
;	BTSC TMR2_FLAG,#T32M_F		;;0=64US	
;	CALL TEST_PRG			;;
	CALL TMR2PRG			;;
	CALL TMR_TPMS			;;
	CALL DISP_PV
	CALL DISP_PVD
	CALL DISP_HV
	CALL DISP_RV
	CALL DISP_DEG
	CALL KEYBO			;;
	CALL TPMS_KEY			;;
	BRA TPMS_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_PRG:
;	MOV #0x55,W0
;	MOV W0,U1TXREG			;;

	INC PV_BUF
	MOV #60,W0
	CP PV_BUF
	BRA GT,$+4
        RETURN
	MOV #-60,W0
	MOV W0,PV_BUF
	RETURN	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_KEY:				;;
	MOV #0x0100,W0			;;
	CP KEY_FLAG0			;;
	BRA Z,TPMS_KEY0R		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0001,W0			;;
	CP KEY_FLAG0			;;
	BRA Z,TPMS_KEY0P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0x0001,W0			;;
	CP KEY_FLAG1			;;
	BRA Z,TPMS_KEY0C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0002,W0			;;
	CP KEY_FLAG1			;;
	BRA Z,TPMS_KEY1C		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0002,W0			;;
	CP KEY_FLAG0			;;
	BRA Z,TPMS_KEY1P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0x0004,W0			;;
	CP KEY_FLAG0			;;
	BRA Z,TPMS_KEY2P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0004,W0			;;
	CP KEY_FLAG1			;;
	BRA Z,TPMS_KEY2C		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_STOP_SONG:				;;
	BCLR FLAGA,#SONG_F		;;
	BSET FLAGB,#DISKR_F		;;
	RETURN				;;
TPMS_KEY1P:				;;
	CALL SING_BEEP
	BTSS FLAGE,#TPMS_LEN_F		;;
	RETURN         			;;
TPMS_KEY1P1:				;;
	BCLR FLAGE,#TPMS_LEN_F		;;
	CALL SAVE_FLASH_ALL
	POP W0				;;
	POP W0				;;
	CALL INIT_TPMSV			;;
	BRA TPMS_PRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_KEY2C:				;;
	BCLR FLAGE,#TPMS_ALMBBB_F	;;		
	CLR TPMS_ALMBB_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	BTSC FLAGE,#TPMS_LEN_F		;;
	BRA TPMS_KEY1P1			;;
	BTSC FLAGF,#PUSHCC_F		;;
	BRA TPMS_KEY2C_1		;;
	BSET FLAGF,#PUSHCC_F		;;
	CLR CONKEY_CNT 			;;
	RETURN  			;;
TPMS_KEY2C_1:				;;
TPMS_LEN_SET:				;;
	MOV #0,W0			;;
	MOV #0,W1			;;
	CALL CHG_DPPX			;;
	MOV #0,W0			;;
	MOV #1,W1			;;
	CALL CHG_DPPX			;;
	MOV #0,W0			;;
	MOV #2,W1			;;
	CALL CHG_DPPX			;;
	MOV #0,W0			;;
	MOV #3,W1			;;
	CALL CHG_DPPX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #2,W0			;;
	MOV #4,W1			;;
	CALL CHG_DPPX			;;
	MOV #2,W0			;;
	MOV #5,W1			;;
	CALL CHG_DPPX			;;
	MOV #2,W0			;;
	MOV #6,W1			;;
	CALL CHG_DPPX			;;
	MOV #2,W0			;;
	MOV #7,W1			;;
	CALL CHG_DPPX			;;
	CALL CLR_TPMS_FLAG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGE,#TPMS_LEN_F		;;
	MOV #TPMSV_BUF,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1111,W0			;;
	MOV W0,[W2++]			;;
	MOV #0x0011,W0			;;
	MOV W0,[W2++]			;;
	SETM [W2++]			;;
	SETM [W2++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0x1111,W0			;;
	MOV W0,[W2++]			;;
	MOV #0x0011,W0			;;
	MOV W0,[W2++]			;;
	SETM [W2++]			;;
	SETM [W2++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1111,W0			;;
	MOV W0,[W2++]			;;
	MOV #0x0011,W0			;;
	MOV W0,[W2++]			;;
	SETM [W2++]			;;
	SETM [W2++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1111,W0			;;
	MOV W0,[W2++]			;;
	MOV #0x0011,W0			;;
	MOV W0,[W2++]			;;
	SETM [W2++]			;;
	SETM [W2++]			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_KEY0C:				;;
	RETURN				;;
TPMS_KEY0R:				;;
	RETURN				;;
TPMS_KEY0P:				;;
	CALL SING_BEEP			;;
	BTSC FLAGE,#TPMS_LEN_F		;;
	BRA TPMS_KEY1P1			;;
	BTSS FLAGD,#DISPCF_F		;;
	BRA TPMS_KEY0P_1		;;
	BTSC W5_EN_SET,#0		;;
	RETURN				;;
	CALL DISP_W5			;;
	POP W0				;;
	POP W0				;;
	CALL INIT_TPMSV			;;
	BCLR FLAGD,#DISPCF_F		;;
	BRA TPMS_PRG0			;;
TPMS_KEY0P_1:				;;
	BCLR FLAGF,#DISP_W5_F		;; 
	BSET FLAGD,#DISPCF_F		;;
	CLR DISPCF_TIM			;;
	RETURN				;;
TPMS_KEY2P:				;;
	CALL SING_BEEP			;;
	BTSC FLAGE,#TPMS_LEN_F		;;
	BRA TPMS_KEY1P1			;;
	BCLR FLAGE,#TPMS_ALMBBB_F	;;	
	RETURN				;;
TPMS_KEY1C:				;;
	BCLR FLAGE,#TPMS_ALMBBB_F	;;		
	CLR TPMS_ALMBB_CNT		;;
	CALL MENU_START			;;
	POP W0				;;
	POP W0				;;
	CALL INIT_TPMSV			;;
	BRA TPMS_PRG0			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEERR_PRG:				;;
	MOV #8,W0			;;
	MUL DPPB3			;;
	MOV #TPMS_DATA,W0		;;
	ADD W0,W2,W2			;;
	MOV [W2],W0			;;
	AND #255,W0			;;
	MOV W0,DPPB0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2],W0			;;
	SWAP W0				;;	
	AND #255,W0			;;
	MOV W0,DPPB1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0			;;
	SUB TRX6,WREG			;;
	BTSC W0,#15			;;
	NEG W0,W0			;;
	SUB #10,W0			;;
	BTSC SR,#C			;;
	BRA DEERR_ERR 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0			;;
	SUB TRX5,WREG			;;
	BTSC W0,#15			;;
	NEG W0,W0			;;
	SUB #10,W0			;;
	BTSC SR,#C			;;
	BRA DEERR_ERR 			;;
DEERR_OK:				;;
	BSET SR,#C			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEERR_ERR:				;;
	CLR DPPB0			;;
	MOV #0x0001,W0			;;
	BTSC DPPB3,#0			;;	
	MOV #0x0002,W0			;;
	BTSS DPPB3,#1			;;	
	GOTO DEERR_ERR_1		;;
	MOV #0x0004,W0			;;
	BTSS DPPB3,#0			;;	
	MOV #0x0008,W0			;;
DEERR_ERR_1:				;;
	BTSS DPPB3,#2			;;	
	MOV #0x0010,W0			;;
	MOV W0,W1			;;
	AND DEERR_BUF,WREG		;;
	BTSS SR,#Z			;;
	BRA DEERR_OK			;;
	MOV W1,W0			;;
	IOR DEERR_BUF			;;
	MOV #0x007F,W0			;;
	MOV W0,RXBYTE_BUF		;;	
	BCLR SR,#C			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_TPMS_RFIN:				;;
	BTSS FLAGE,#TRXIN_F		;;
	RETURN				;;
	BCLR FLAGE,#TRXIN_F		;;
TPMS_RFIN:
	BTSC FLAGE,#TPMS_LEN_F		;;
	BRA CTR_LEN			;;
CTR_DIN:				;;
	MOV #WID00,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TRX0,W0			;;
	SWAP.B W0			;;
	AND #0x0F,W0			;;
	CLR DPPB3			;;
	CP W0,#0x0A			;;
	BRA Z,CTR_DIN_1			;;
	INC DPPB3			;; 
	CP W0,#0x0B			;;
	BRA Z,CTR_DIN_1			;;
	INC DPPB3			;; 
	CP W0,#0x0C			;;
	BRA Z,CTR_DIN_1			;;
	INC DPPB3			;; 
	CP W0,#0x0D			;;
	BRA Z,CTR_DIN_1			;;
	INC DPPB3			;; 
	CP W0,#0x02			;;
	BRA Z,CTR_DIN_1			;;
	RETURN				;;
CTR_DIN_1:				;;
	MOV DPPB3,W0			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	MOV [W1++],W0			;;
	MOV W0,DPPB0			;;
	MOV [W1++],W0			;;
	MOV W0,DPPB1			;;
	MOV [W1++],W0			;;
	MOV W0,DPPB2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0			;;
	XOR TRX1,WREG			;;
	AND #255,W0			;;
	BTSS SR,#Z			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0			;;
	XOR TRX2,WREG			;;
	AND #255,W0			;;
	BTSS SR,#Z			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0			;;
	XOR TRX3,WREG			;;
	AND #255,W0			;;
	BTSS SR,#Z			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS W5_EN_SET,#0		;;				
	BRA CTR_DIN_2			;;
	MOV #4,W0			;;
	CP DPPB3			;;
	BRA NZ,CTR_DIN_2		;;
	BCLR SR,#Z			;;
	RETURN				;;
CTR_DIN_2:				;;
	CALL DEERR_PRG			;;
	BCLR SR,#Z			;;
	BTSS SR,#C			;;
	RETURN				;;
	MOV #8,W0			;;
	MUL DPPB3			;;
	MOV #TPMS_DATA,W0		;;
	ADD W0,W2,W2			;;
	MOV TRX5,W1			;;
	SWAP W1				;;
	MOV TRX6,W0			;;
	MOV.B W0,W1			;;
	MOV W1,[W2++]			;;
	MOV [W2],W0			;;
	MOV #0xFFF0,W1			;;
	AND W0,W1,W0			;;
	MOV TRX0,W1			;;
	AND #0x0F,W1			;;
	IOR #0x88,W1			;;
	IOR W0,W1,W0			;;
	MOV W0,[W2]			;;
	BSET SR,#Z			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SAMETRX:				;;
	MOV TRX0,W0			;;
	XOR TRX0_BUF,WREG		;;
	BTSS SR,#Z			;;
	RETURN				;;
	MOV TRX1,W0			;;
	XOR TRX1_BUF,WREG		;;
	BTSS SR,#Z			;;
	RETURN				;;
	MOV TRX2,W0			;;
	XOR TRX2_BUF,WREG		;;
	BTSS SR,#Z			;;
	RETURN				;;
	MOV TRX3,W0			;;
	XOR TRX3_BUF,WREG		;;
	BTSS SR,#Z			;;
	RETURN				;;
	MOV TRX4,W0			;;
	XOR TRX4_BUF,WREG		;;
	BTSS SR,#Z			;;
	RETURN				;;
	MOV TRX5,W0			;;
	XOR TRX5_BUF,WREG		;;
	BTSS SR,#Z			;;
	RETURN				;;
	MOV TRX6,W0			;;
	XOR TRX6_BUF,WREG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RELOAD_SAMETRX:				;;
	MOV TRX0,W0			;;
	MOV W0,TRX0_BUF			;;
	MOV TRX1,W0			;;
	MOV W0,TRX1_BUF			;;
	MOV TRX2,W0			;;
	MOV W0,TRX2_BUF			;;
	MOV TRX3,W0			;;
	MOV W0,TRX3_BUF			;;
	MOV TRX4,W0			;;
	MOV W0,TRX4_BUF			;;
	MOV TRX5,W0			;;
	MOV W0,TRX5_BUF			;;
	MOV TRX6,W0			;;
	MOV W0,TRX6_BUF			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_SAMETRX:				;;
	CLR TRX0_BUF			;;
	CLR TRX1_BUF			;;
	CLR TRX2_BUF			;;
	CLR TRX3_BUF			;;
	CLR TRX4_BUF			;;
	CLR TRX5_BUF			;;
	CLR TRX6_BUF			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CTR_LEN:			;;
	MOV TRX0,W0		;;
	SWAP.B W0 		;;
	AND #0x0F,W0		;;
        XOR #0x0F,W0		;;
	BRA NZ,CTR_LEN0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0		;;
	CP TRX1			;;
	BRA NZ,CTR_LEN0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xCD,W0		;;
	CP TRX2			;;
	BRA NZ,CTR_LEN0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #0xEF,W0		;;
	CP TRX3			;;
	BRA NZ,CTR_LEN0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BSET FLAGF,#LENALL_F	;;
	CALL SING_BEEP		;;
	MOV #100,W0		;;
	CALL DLYMX		;;
	CALL SING_BEEP		;;
	MOV #1000,W0		;;
	CALL DLYMX		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CTR_LEN0:				;;
	BTSC FLAGF,#LENALL_F		;;
	BRA CTR_LEN0A			;;	
	BTSS TRX0,#3			;;
	RETURN				;;		
CTR_LEN0A:				;;
	CLR MENU_ESC_TIM		;;
	BCLR FLAGE,#TCLRRF_F 		;;
	MOV LENSAME_BUF,W0		;;
	XOR TRX4,WREG			;;
	AND #255,W0			;;
	BRA Z,CTR_LEN1			;;
	XOR LENSAME_BUF			;;
	CLR LENSAME_CNT			;;
	RETURN				;;
CTR_LEN1:				;;	
	INC LENSAME_CNT			;;
	MOV #4,W0			;;
	CP LENSAME_CNT			;;	
	BRA GEU,$+4			;;
	RETURN				;;
	CALL CHK_SAMETRX		;;
	BTSC SR,#Z			;;
	RETURN				;;
	CALL RELOAD_SAMETRX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGE,#EDITED_F		;;
	MOV #WID00,W1			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TRX0,W0			;;
	SWAP.B W0			;;
	AND #0x0F,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x0A			;;
	BRA NZ,$+6			;;
	MOV #0,W0			;;
	BRA CTR_LEN2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x0B			;;
	BRA NZ,$+6			;;
	MOV #1,W0			;;
	BRA CTR_LEN2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x0C			;;
	BRA NZ,$+6			;;
	MOV #2,W0			;;
	BRA CTR_LEN2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x0D			;;
	BRA NZ,$+6			;;
	MOV #3,W0			;;
	BRA CTR_LEN2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x02			;;
	BRA Z,$+4			;;
	RETURN				;;
	BCLR W5_EN_SET,#0		;;				
	MOV #4,W0			;;
	BRA CTR_LEN2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CTR_LEN2:				;;
	MOV W0,DPPB2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TRX1,W0			;;
	MOV W0,[W1++]			;;
	MOV TRX2,W0			;;
	MOV W0,[W1++]			;;
	MOV TRX3,W0			;;
	MOV W0,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #8,W0			;;
	MUL DPPB2			;;
	MOV #TPMS_DATA,W0		;;
	ADD W0,W2,W2			;;
	MOV TRX5,W1			;;
	SWAP W1				;;
	MOV TRX6,W0			;;
	MOV.B W0,W1			;;
	MOV W1,[W2++]			;;
	MOV [W2],W0			;;
	MOV #0xFFF0,W1			;;
	AND W0,W1,W0			;;
	MOV TRX0,W1			;;
	AND #0x0F,W1			;;
	IOR #0x88,W1			;;
	IOR W0,W1,W0			;;
	MOV W0,[W2]			;;
	MOV DPPB2,W0			;;
	MOV W0,TPMSD_CNT		;;
	CALL TRANS_TPMS0		;;	
	CALL SING_BH1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_SHOW:				;;
	CALL DARKSCR			;;
	CALL INIT_LCDLIM		;;
	CALL INIT_DYBMP			;;	
	CALL INIT_DPP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 #PORCH_SHOW_A_TBL	;;
	CALL LOAD_DYBMP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
TPMS_SHOW1:				;;
	CALL TMR2PRG			;;
	CALL DYBMP			;;
	MOV #DYBMP_BUF+0*12,W1		;;
	MOV [W1],W0			;;
	BTSS W0,#3			;;
	BRA TPMS_SHOW1			;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_DYBMP			;;	
	LOFFS1 #PORCH_SHOW_B_TBL	;;
	CALL LOAD_DYBMP			;;
TPMS_SHOW2:				;;
	CALL TMR2PRG			;;
	CALL DYBMP			;;
	MOV #DYBMP_BUF+0*12,W1		;;
	MOV [W1],W0			;;
	BTSS W0,#3			;;
	BRA TPMS_SHOW2			;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF #8,LCDX			;;
	MOVLF #0,LCDY			;;
	LOFFS1 #TYREDOG_STR		;;
	BCLR FLAGD,#F24P_F		;;
	CALL RSTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF #16,LCDX			;;
	MOVLF #136,LCDY			;;
	LOFFS1 #TPMS_STR		;;
	BSET FLAGD,#F24P_F		;;
	CALL RSTR			;;
	BCLR FLAGD,#F24P_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_DYBMP			;;	
	LOFFS1 #PLUG_SHOW_A_TBL		;;
	CALL LOAD_DYBMP			;;
	LOFFS1 #PLUG_SHOW_B_TBL		;;
	CALL LOAD_DYBMP			;;
	LOFFS1 #METER_SHOW_A_TBL	;;
	CALL LOAD_DYBMP			;;
	LOFFS1 #METER_SHOW_B_TBL	;;
	CALL LOAD_DYBMP			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
TPMS_SHOW3:				;;
	CALL TMR2PRG			;;
	CALL DYBMP			;;
	MOV #DYBMP_BUF+0*12,W1		;;
	MOV [W1],W0			;;
	BTSS W0,#3			;;
	BRA TPMS_SHOW3			;; 
	MOV #DYBMP_BUF+1*12,W1		;;
	MOV [W1],W0			;;
	BTSS W0,#3			;;
	BRA TPMS_SHOW3			;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_DPP			;;
	LOFFS1 TP_METER_TBL		;;
	MOVLF 72,LCDX			;;
	MOVLF 25,LCDY			;;
 	CALL LOAD_DPP_DYM		;;
	LOFFS1 TP_METER_TBL		;;
	MOVLF 72,LCDX			;;
	MOVLF 86,LCDY			;;
 	CALL LOAD_DPP_DYM		;;
	MOVLF #100,WAIT_TIM		;;
	CLR R0				;;
	CLR R1
TPMS_SHOW4:				;;
	PUSH R0				;;
	PUSH R1				;;
	CALL TMR2PRG			;;
	CALL DPP			;;
	POP R1				;;
	POP R0				;;
	BTSS TMR2_FLAG,#T16M_F		;;16MS 
	BRA TPMS_SHOW4			;;	
	INC R0				;;
	MOV #10,W0			;;
	CP R0				;;
	BRA LTU,TPMS_SHOW5		;;		
	CLR R0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #8,W0			;;
	CP R1				;;
	BRA GEU,TPMS_SHOW5		;;	
	MOV R1,W0			;;
	AND #3,W0			;;
;	BTSS FLAGF,#DEMO_F		;;	
;	CALL GET_TIREDX			;;
	INC R1				;;
TPMS_SHOW5:				;;
	DEC WAIT_TIM			;;
	BRA NZ,TPMS_SHOW4		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_W5:				;;
	CALL DARKSCR			;;
	CALL INIT_LCDLIM		;;
	CALL INIT_DYBMP			;;	
	CALL INIT_DPP			;;
	CALL INIT_TPMSV
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOVLF #8,LCDX			;;
;	MOVLF #10,LCDY			;;
;	LOFFS1 #TYREDOG_STR		;;
;	CALL RSTR			;;
;	CALL C_WTBK			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF 40,LCDX			;;
	MOVLF 20,LCDY			;;
	CLR FCOLOR			;;
	MOV #5,W0			;;
	CALL WNUM			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 TP_GTIRE_TBL		;;
	MOVLF 60,LCDX			;;
	MOVLF 10,LCDY			;;
 	CALL LOAD_DPP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLAGD,#DISPCF_F		;; 
	LOFFS1 TP_PSI_TBL		;;
	MOVLF 80,LCDX			;;
	MOVLF 74,LCDY			;;
	MOV TPMS_PUNIT_SET,W0		;; 
 	CALL LOAD_DPPX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FLAGD,#DISPCF_F		;; 
	LOFFS1 TP_PSI_TBL		;;
	MOVLF 80,LCDX			;;
	MOVLF 110,LCDY			;;
	MOV TPMS_TUNIT_SET,W0		;;
	ADD #4,W0			;; 
 	CALL LOAD_DPPX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLAGD,#TPMSSET_F		;;
	BCLR FLAGD,#DISPCF_F		;; 
	BSET FLAGF,#DISP_W5_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV #4,W0			;;
	MOV W0,DPPB0			;;
	MOV #8,W0			;;
	MUL DPPB0			;;
	MOV #TPMS_DATA,W0		;;
	ADD W0,W2,W2			;;
	MOV [W2++],W0			;;
	MOV W0,DPPB0 			;;
	MOV [W2++],W0			;;
	MOV W0,DPPB1 			;;
	MOV DPPB0,W0			;;
	AND #255,W0			;;
	MOV W0,TPMSSET_BUF		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TRANS_TPMS_W5A		;;
	CLR TPMSV_CNT			;;
	CALL DISP_TPMSVX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLAGD,#TPMSSET_F		;;
	BSET FLAGD,#DISPCF_F		;; 
	BSET FLAGF,#DISP_W5_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #4,W0			;;
	MOV W0,DPPB0			;;
	MOV #8,W0			;;
	MUL DPPB0			;;
	MOV #TPMS_DATA,W0		;;
	ADD W0,W2,W2			;;
	MOV [W2++],W0			;;
	MOV W0,DPPB0 			;;
	MOV [W2++],W0			;;
	MOV W0,DPPB1 			;;
	MOV DPPB0,W0			;;
	SWAP W0				;;
	AND #255,W0			;;
	MOV W0,TPMSSET_BUF		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TRANS_TPMS_W5B		;;
	CLR TPMSV_CNT			;;
	INC TPMSV_CNT			;;
	CALL DISP_TPMSVX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOVLF #1000,WAIT_TIM		;;
DISP_W5_1:				;;
	CALL TMR2PRG			;;
	CALL GETRF_T			;;
	CALL CHK_TPMS_RFIN		;;
	CALL DPP			;;
 	CALL DYBMP			;;
	CALL KEYBO			;;
	MOV #0x0001,W0			;;
	CP KEY_FLAG0			;;
	BRA NZ,$+4      		;;
	RETURN				;;
 	BTSS TMR2_FLAG,#T4M_F		;;16MS 
	BRA DISP_W5_1			;;	
	DEC WAIT_TIM			;;
	BRA NZ,DISP_W5_1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SIN_DEGREE:
	CALL OFFSET_DEG
	MOV #90,W0
	CP R0
	BRA LEU,SIN_SEG0
	MOV #180,W0
	CP R0
	BRA LEU,SIN_SEG1
	MOV #270,W0
	CP R0
	BRA LEU,SIN_SEG2
	BRA SIN_SEG3
SIN_SEG0:
	BCLR R7,#0
	MOV R0,W0
	RETURN	
SIN_SEG1:
	BCLR R7,#0
	MOV #180,W0
	SUBR R0,WREG
	RETURN	
SIN_SEG2:
	BSET R7,#0
	MOV #180,W0
	SUB R0,WREG
	RETURN	
SIN_SEG3:
	BSET R7,#0
	MOV #360,W0
	SUBR R0,WREG
	RETURN	


OFFSET_DEG:
	MOV DEGREE,W0
	MOV W0,R0
	MOV #90,W0
	ADD R0
OFFSET_DEG0:
	BTSS R0,#15
	BRA OFFSET_DEG1
	MOV #360,W0
	ADD R0
	BRA OFFSET_DEG0
OFFSET_DEG1:
	MOV #360,W0
	CP R0
	BRA GEU,$+4
	RETURN
	MOV #360,W0
	SUB R0
	BRA OFFSET_DEG1

COS_DEGREE:
	CALL OFFSET_DEG
	MOV #90,W0
	CP R0    
	BRA LEU,COS_SEG0
	MOV #180,W0
	CP R0    
	BRA LEU,COS_SEG1
	MOV #270,W0
	CP R0     
	BRA LEU,COS_SEG2
	BRA COS_SEG3
COS_SEG0:
	BCLR R7,#1
	MOV R0,W0
	RETURN	
COS_SEG1:
	BSET R7,#1
	MOV #180,W0
	SUBR R0,WREG
	RETURN	
COS_SEG2:
	BSET R7,#1
	MOV #180,W0
	SUB R0,WREG
	RETURN	
COS_SEG3:
	BCLR R7,#1
	MOV #360,W0
	SUBR R0,WREG
	RETURN	




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
CIRPRG:					;;
	CALL COLOR0			;;
	CALL DARKSCR			;;
CIRPRG_0:				;;	
	MOV #57,W0			;;
	MOV W0,RADIUS			;;
CIRPRGX:
	CLR DEGREE			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CIRPRG_1:				;;
	CLRWDT				;;
	LOFFS1 SIN_TBL			;;
	CALL SIN_DEGREE			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W0		;;
	MUL RADIUS			;;
	MOV W3,LCDY			;;
	BTSC W2,#15			;;
	INC LCDY			;;
	BTSS R7,#0			;;
	NEG LCDY			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 COS_TBL			;;
	CALL COS_DEGREE
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W0		;;
	MUL RADIUS			;;
	MOV W3,LCDX			;;
	BTSC W2,#15			;;
	INC LCDX			;;
	BTSC R7,#1			;;
	NEG LCDX			;;
	MOV #64,W0			;;
	ADD LCDY			;;
	MOV #64,W0			;;
	ADD LCDX			;;	
	CALL DRAW_POINT			;;
	INC DEGREE			;;
	MOV #360,W0			;;
	CP DEGREE			;;
	BRA LTU,CIRPRG_1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


POINT_DEG:				;;
	CLRWDT				;;
	LOFFS1 SIN_TBL			;;
	CALL SIN_DEGREE			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W0		;;
	MUL RADIUS			;;
	MOV W3,LCDY			;;
	BTSC W2,#15			;;
	INC LCDY			;;
	BTSS R7,#0			;;
	NEG LCDY			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 COS_TBL			;;
	CALL COS_DEGREE
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W0		;;
	MUL RADIUS			;;
	MOV W3,LCDX			;;
	BTSC W2,#15			;;
	INC LCDX			;;
	BTSC R7,#1			;;
	NEG LCDX			;;
	MOV #64,W0			;;
	ADD LCDY			;;
	MOV #64,W0			;;
	ADD LCDX			;;	
	CALL DRAW_POINT			;;
	RETURN



COMPASS_FRAM:
	CALL COLOR0		;;
	CALL DARKSCR			;;
	MOV #(10*2048+10*32+10),W0
	MOV W0,COLOR_F
	CLR COLOR_B
	MOV #57,W0			;;
	MOV W0,RADIUS			;;
	CALL CIRPRGX
	MOV #55,W0			;;
	MOV W0,RADIUS			;;
	CALL CIRPRGX

	CALL C_GRBK

	MOV #0,W0
	MOV W0,DEGREE
COMPASS_FRAM_1:	
	MOV #56,W0			;;
	MOV W0,RADIUS			;;
	CALL POINT_DEG
	MOV #5,W0
	ADD DEGREE
	MOV #360,W0
	CP DEGREE
	BRA LTU,COMPASS_FRAM_1


	CALL C_RDBK
	MOV #0,W0
	MOV W0,DEGREE
COMPASS_FRAM_2:	
	MOV #57,W0			;;
	MOV W0,RADIUS			;;
	CALL POINT_DEG
	MOV #56,W0			;;
	MOV W0,RADIUS			;;
	CALL POINT_DEG
	MOV #55,W0			;;
	MOV W0,RADIUS			;;
	CALL POINT_DEG
	MOV #45,W0
	ADD DEGREE
	MOV #360,W0
	CP DEGREE
	BRA LTU,COMPASS_FRAM_2

	RETURN
	
TEST_DEGA:
	CALL COMPASS_FRAM	
	CALL DRAW_HV
	NOP
TEST_DEGA0:
	MOV #60,W0
	MOV W0,RADIUS
	CLR DEG_A
	MOV #360,W0
	MOV W0,DEG_B
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_DEGA1:
	CLRWDT
	CALL SET_DEG_BUFA
	MOV #60,W0
	MOV W0,RADIUS
	CALL C_RDBK
	CALL DRAW_DEGA
	;;;;;;;;;;;;;;;;;;;
	CALL SET_DEG_BUFB
	MOV #54,W0
	MOV W0,RADIUS
	CALL C_GRBK
	CALL DRAW_DEGB

	MOV #1,W0
	CALL DLYMX
	MOV #0x2E,W0
	CP DEG_A
	BRA NZ,YYYY
	NOP
	NOP
	NOP
	NOP
YYYY:
	DEC DEG_B
	INC DEG_A
	MOV #360,W0
	CP DEG_A
	BRA LTU,TEST_DEGA1
	BRA TEST_DEGA0	



DRAW_DEGA:
	MOV #DEG_BUFA,W1
	MOV [W1],W0
	BCLR FLAGG,#FORCE_DRAW_F
	BTSC W0,#0  
	BSET FLAGG,#FORCE_DRAW_F
	MOV #DEG_BUFA+62,W1
	MOV #DEG_BUFA+2,W2
	CALL DARK_PPP
	MOV #DEG_BUFA+2,W1
	MOV #DEG_BUFA+62,W2
	CALL DRAW_PPP
	MOV #DEG_BUFA+2,W1
	MOV #DEG_BUFA+62,W2
	PUSH R7
	MOV #30,W0
	MOV W0,R7
DRAW_DEGA_1:
	MOV [W1++],W0
	MOV W0,[W2++]
	DEC R7
	BRA NZ,DRAW_DEGA_1	
	MOV #DEG_BUFA,W1
	MOV [W1],W0
	BCLR W0,#0
	MOV W0,[W1]
	POP R7
	RETURN
	

DRAW_DEGB:
	MOV #DEG_BUFB,W1
	MOV [W1],W0
	BCLR FLAGG,#FORCE_DRAW_F
	BTSC W0,#0  
	BSET FLAGG,#FORCE_DRAW_F
	MOV #DEG_BUFB+62,W1
	MOV #DEG_BUFB+2,W2
	CALL DARK_PPP
	MOV #DEG_BUFB+2,W1
	MOV #DEG_BUFB+62,W2
	CALL DRAW_PPP
	MOV #DEG_BUFB+2,W1
	MOV #DEG_BUFB+62,W2
	PUSH R7
	MOV #30,W0
	MOV W0,R7
DRAW_DEGB_1:
	MOV [W1++],W0
	MOV W0,[W2++]
	DEC R7
	BRA NZ,DRAW_DEGB_1	
	MOV #DEG_BUFB,W1
	MOV [W1],W0
	BCLR W0,#0
	MOV W0,[W1]
	POP R7
	RETURN

	


DARK_PPP:
	PUSH R2
	PUSH R3
	PUSH R7
	MOV #15,W0
	MOV W0,R7
DARK_PPP_0:
	MOV [W1++],W0
	MOV W0,R2
	MOV [W1++],W0
	MOV W0,R3
	CALL CHK_DD_SAME
	BTSC FLAGG,#FORCE_DRAW_F
	BCLR SR,#Z 
	BTSC SR,#Z
	BRA DARK_PPP_1
	MOV R2,W0
	MOV W0,LCDX
	MOV R3,W0
	MOV W0,LCDY
	CALL DARK_POINT
DARK_PPP_1:
	DEC R7
	BRA NZ,DARK_PPP_0
	POP R7
	POP R3
	POP R2
	RETURN




	
DRAW_PPP:
	PUSH R7
	MOV #15,W0
	MOV W0,R7
DRAW_PPP_0:
	MOV [W1++],W0
	MOV W0,R2
	MOV [W1++],W0
	MOV W0,R3
	CALL CHK_DD_SAME
	BTSC FLAGG,#FORCE_DRAW_F
	BCLR SR,#Z 
	BTSC SR,#Z
	BRA DRAW_PPP_1
	MOV R2,W0
	MOV W0,LCDX
	MOV R3,W0
	MOV W0,LCDY
	CALL DRAW_POINT
DRAW_PPP_1:
	DEC R7
	BRA NZ,DRAW_PPP_0
	POP R7
	RETURN



CHK_DD_SAME:
	PUSH R7
	PUSH W2
	MOV #15,W0
	MOV W0,R7
CDS_0:
	MOV [W2++],W0
	CP R2
	BRA NZ,CDS_1
	MOV [W2++],W0
	CP R3
	BRA NZ,CDS_2
	POP W2
	POP R7
	RETURN
CDS_1:
	MOV [W2++],W0
CDS_2:
	DEC R7
	BRA NZ,CDS_0
	BCLR SR,#Z
	POP W2
	POP R7
	RETURN



	
SET_DEG_BUFB:
	MOV #DEG_BUFB+2,W1
	MOV #54,W0
	MOV W0,RADIUS
	MOV DEG_B,W0
	MOV W0,DEGREE
	BRA SET_DEG_BUFX
SET_DEG_BUFA:
	MOV #DEG_BUFA+2,W1
	MOV #63,W0
	MOV W0,RADIUS
	MOV DEG_A,W0
	MOV W0,DEGREE
SET_DEG_BUFX:
	CALL LOAD_DEG_BUF
	INC DEGREE
	CALL LOAD_DEG_BUF
	DEC DEGREE
	DEC DEGREE
	CALL LOAD_DEG_BUF
	INC DEGREE
	;;;;;;;;;;;;;;;;;;;;
	DEC RADIUS
	CALL LOAD_DEG_BUF
	INC DEGREE
	CALL LOAD_DEG_BUF
	DEC DEGREE
	DEC DEGREE
	CALL LOAD_DEG_BUF
	INC DEGREE
	;;;;;;;;;;;;;;;;;;;
	DEC RADIUS
	CALL LOAD_DEG_BUF
	INC DEGREE
	CALL LOAD_DEG_BUF
	DEC DEGREE
	DEC DEGREE
	CALL LOAD_DEG_BUF
	INC DEGREE
	;;;;;;;;;;;;;;;;;;;
	DEC RADIUS
	CALL LOAD_DEG_BUF
	INC DEGREE
	CALL LOAD_DEG_BUF
	DEC DEGREE
	DEC DEGREE
	CALL LOAD_DEG_BUF
	INC DEGREE
	;;;;;;;;;;;;;;;;;;;
	DEC RADIUS
	CALL LOAD_DEG_BUF
	INC DEGREE
	CALL LOAD_DEG_BUF
	DEC DEGREE
	DEC DEGREE
	CALL LOAD_DEG_BUF
	INC DEGREE
	;;;;;;;;;;;;;;;;;
	RETURN


 

	
LOAD_DEG_BUF:	
	CALL GET_CIRXY
	MOV LCDX,W0
	MOV W0,[W1++]
	MOV LCDY,W0
	MOV W0,[W1++]
	RETURN
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_CIRXY:				;;
	PUSH W1
	LOFFS1 SIN_TBL			;;
	CALL SIN_DEGREE			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W0		;;
	MUL RADIUS			;;
	MOV W3,LCDY			;;
	BTSC W2,#15			;;
	INC LCDY			;;
	BTSS R7,#0			;;
	NEG LCDY			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 COS_TBL			;;
	CALL COS_DEGREE			;;
	ADD W0,W1,W1			;;
	ADD W0,W1,W1			;;
	TBLRDL [W1++],W0		;;
	MUL RADIUS			;;
	MOV W3,LCDX			;;
	BTSC W2,#15			;;
	INC LCDX			;;
	BTSC R7,#1			;;
	NEG LCDX			;;
	MOV #64,W0			;;
	ADD LCDY			;;
	MOV #64,W0			;;
	ADD LCDX			;;	
	POP W1
 	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TITLE:					;;
	CALL DARKSCR			;;
	CALL INIT_LCDLIM		;;
	CALL INIT_DYBMP			;;	
	CALL INIT_DPP			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF #32,LCDX			;;
	MOVLF #0,LCDY			;;
	LOFFS1 #JOSN_STR		;;
	CALL RSTR			;;
	CALL C_WTBK			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	LOFFS1 #DYBMP_TEST_TBL		;;<<
;	CALL LOAD_DYBMP			;;<<

	CALL INIT_LCDLIM
	MOV #COMPASS_0_ADR0,W0		;;
	MOV W0,FADR0			;;
	MOV #COMPASS_0_ADR1,W0		;;
	MOV W0,FADR1			;;
	MOVLF #128,BMPX			;;	
	MOVLF #128,BMPY			;;
	MOVLF #0,LCDX			;;
	MOVLF #16,LCDY			;;
	CALL GET_BMPS			;;
	CALL DISP_BMP24			;;





	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOVLF 0,LCDX_LIM0		;;
;	MOVLF 127,LCDX_LIM1		;;
;	MOVLF 129,LCDY_LIM0		;;
;	MOVLF 144,LCDY_LIM1		;;
;	LOFFS1 TITLE_1_STRB		;;
;	CALL FIXSTR			;;
	MOVLF 144,LCDY_LIM0		;;
	MOVLF 159,LCDY_LIM1		;;
	LOFFS1 TITLE_2_STRB		;;
	CALL FIXSTR			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOVLF #400,WAIT_TIM		;;
TITLE1:					;;
	CALL TMR2PRG			;;
;	CALL DPP			;;
;	CALL DYBMP			;;
	CALL KEYBO			;;
	BTSS TMR2_FLAG,#T4M_F		;;16MS 
	BRA TITLE1			;;	
	DEC WAIT_TIM			;;
	BRA NZ,TITLE1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
LOAD_DYBMP:			;;
	MOV DYBMP_AMT,W0	;;		
	MUL.UU W0,#12,W2 	;;	
	MOV #DYBMP_BUF,W5	;;
	ADD W5,W2,W5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0007,W0		;;
	MOV W0,[W5++]		;;FLAG		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,[W5++]		;;ADDRESS
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5		;;TIMER BUF
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5		;;NOW_X	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5		;;NOW_Y	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC DYBMP_AMT		;;
	RETURN			;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
LOAD_DYSTR:			;;
	MOV DYBMP_AMT,W0	;;		
	MUL.UU W0,#12,W2 	;;	
	MOV #DYBMP_BUF,W5	;;
	ADD W5,W2,W5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0017,W0		;;
	MOV W0,[W5++]		;;FLAG		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,[W5++]		;;ADDRESS
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5		;;TIMER BUF
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5		;;NOW_X	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5		;;NOW_Y	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC DYBMP_AMT		;;
	RETURN			;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP:				;;
	INC DYBMP_CNT		;;
	MOV #20,W0		;;
	CP DYBMP_CNT		;;
	BRA LTU,$+4		;;
	CLR DYBMP_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #12,W0		;;
	MUL DYBMP_CNT		;;
	MOV #DYBMP_BUF,W0	;;
	ADD W0,W2,W2		;;
	BTST.C [W2],#0		;;PRESENT BIT
	BRA C,$+4		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV [W2++],W0		;;
	MOV W0,DPPB2		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC DPPB0,#1		;;FORCE BIT
	BRA DYBMP1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS DPPB0,#3		;;STOP_F
	BRA DYBMP0		;;
	RETURN			;;
DYBMP0:				;;
	MOV DPPB2,W0		;;	
	SUB TMR2,WREG		;;
	BTSC W0,#15		;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP1:				;;
	BTSC DPPB0,#4		;;
	BRA DYSTR		;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH R2			;;
	PUSH R3			;;
	PUSH LCDX_LIM0		;;
	PUSH LCDX_LIM1		;;
	PUSH LCDY_LIM0		;;
	PUSH LCDY_LIM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR DPPB0,#1		;;CLR FORCE BIT
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W1		;;
	TBLRDL [W1++],W0		;;
	MOV W0,R0		;;FLAG
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0		;;
	MOV W0,FADR0		;;
	TBLRDL [W1++],W0		;;
	MOV W0,FADR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	ADD TMR2,WREG		;;
	MOV W0,DPPB2		;;TIMER_BUF
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	TBLRDL [W1++],W0	;;
	MOV W0,R1    		;;FIRST X
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,R2    		;;FIRST Y
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS DPPB0,#2		;;START BIT
	BRA DYBMP2		;;
	BCLR DPPB0,#2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R1,W0		;;RELOAD FIRST X,Y
	MOV W0,DPPB3		;;
	MOV R2,W0		;;
	MOV W0,DPPB4		;;
	BRA DYBMP3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP2:				;;
	BTSC R0,#1		;;
	BRA DYBMP2B		;;
DYBMP2A:			;;
	BTSC R0,#0 		;;
	INC DPPB4		;;LCDY
	BTSS R0,#0 		;;
	DEC DPPB4		;;
	BRA DYBMP3		;;
DYBMP2B:			;;
	BTSC R0,#0 		;;
	INC DPPB3		;;LCDX
	BTSS R0,#0 		;;
	DEC DPPB3		;;
	BRA DYBMP3		;;
DYBMP3:				;;
	TBLRDL [W1++],W0	;;ENDX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLAGA,#BUF_F	;;
	CP DPPB3		;;
	BRA NZ,DYBMP3A		;;
	BSET FLAGA,#BUF_F	;;
	MOV R1,W0		;;
	MOV W0,DPPB3		;;
DYBMP3A:			;;
	TBLRDL [W1++],W0	;;ENDY
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP DPPB4		;;
	BRA NZ,DYBMP3B		;;
	MOV R2,W0		;;
	MOV W0,DPPB4		;;
	BTSS FLAGA,#BUF_F 	;;
	BRA DYBMP3B		;;
	BTSS R0,#2		;;
	BRA DYBMP3B		;;
	BSET DPPB0,#3		;;SET STOP BIT 
	BRA DYBMP_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP3B:			;;
	MOV DPPB3,W0		;;
	MOV W0,LCDX		;;
	MOV DPPB4,W0		;;
	MOV W0,LCDY		;;
	TBLRDL [W1++],W0	;;LIMX0
	MOV W0,LCDX_LIM0	;;	
	TBLRDL [W1++],W0	;;LIMX1
	MOV W0,LCDX_LIM1	;;	
	TBLRDL [W1++],W0	;;LIMY0
	MOV W0,LCDY_LIM0	;;	
	TBLRDL [W1++],W0	;;LIMY1
	MOV W0,LCDY_LIM1	;;	
        ;;;;;;;;;;;;;;;;;;;;;;;;;;		
	TBLRDL [W1],W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	MOV W0,BMPX		;;
	TBLRDL [W1++],W0	;;
	AND #255,W0		;;
	MOV W0,BMPY		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;		
	MOV R0,W0		;;
	SWAP W0			;;
	AND #3,W0		;;	
	BRA W0			;;
	BRA DYBMP_T0		;;
	BRA DYBMP_T1		;;
	BRA DYBMP_T2		;;
	BRA DYBMP_T3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP_T0:			;;
	PUSH W1			;;
	CALL GET_BMPS		;;
	CALL DISP_BMP24		;;
	POP W1			;;
DYBMP_T00:			;;
	TBLRDL [W1],W0		;;
	MOV W0,COLOR_B		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R0,W0		;;
	AND #3,W0		;;	
	BRA W0			;;
	BRA DYBMP_T0A		;;
	BRA DYBMP_T0B		;;
	BRA DYBMP_T0C		;;
	BRA DYBMP_T0D		;;	
DYBMP_T0A:			;;
	MOV BMPY,W0		;;
	ADD LCDY 		;;
	MOV #1,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	BRA DYBMP_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP_T0B:			;;
	DEC LCDY 		;;
	MOV #1,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	BRA DYBMP_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP_T0C:			;;
	MOV BMPX,W0		;;
	ADD LCDX 		;;
	MOV #1,W0		;;
	MOV W0,BMPX		;;
	CALL DISP_BLK		;;
	BRA DYBMP_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP_T0D:			;;
	DEC LCDX		;;
	MOV #1,W0		;;
	MOV W0,BMPX		;;
	CALL DISP_BLK		;;
	BRA DYBMP_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP_T1:			;;	
	PUSH W1			;;
	CALL GET_BLKC8		;;
	CALL DISP_BMP8		;;
	POP W1			;;
	BRA DYBMP_T00		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP_T2:			;;
DYBMP_T3:			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DYBMP_END:			;;	
	MOV #12,W0		;;
	MUL DYBMP_CNT		;;
	MOV #DYBMP_BUF,W0	;;
	ADD W0,W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB3,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB4,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB5,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	POP LCDY_LIM1		;;
	POP LCDY_LIM0		;;
	POP LCDX_LIM1		;;
	POP LCDX_LIM0		;;
	POP R3			;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;0 STATUS_FLAG
;1 TABLE_ADDRESS
;2 TIMER_BUF 
;3 NOW_X
;4 NOW_Y
;STATUS FLAG
;B0 PRESENT
;B1 FORCE
;B2 START 
;B3 STOP   	

;DYFONT_TEST_TBL:
;	.WORD 0x0000	;FLAG
;	.WORD 1000 	;BETWEEN TIME  
;	.WORD 2000      ;FIRST_TIME
;	.WORD 2000 	;END_TIME 		
;	.WORD 0		;LIMIT XL	
;	.WORD 127	;LIMIT XR	
;	.WORD 128	;LIMIT YT	
;	.WORD 143	;LIMIT YB
;	.WORD 0xFFFF	;FRONT COLOR
;	.WORD 0x0000	;BACK GROUND COLOR
;	.WORD 0 	;FIRST X
;	.WORD 0 	;END X

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DYSTR:				;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH R2			;;
	PUSH R3			;;
	PUSH LCDX_LIM0		;;
	PUSH LCDX_LIM1		;;
	PUSH LCDY_LIM0		;;
	PUSH LCDY_LIM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC DPPB0,#1		;;CLR FORCE BIT
	INC DPPB3		;;
	BCLR DPPB0,#1		;;CLR FORCE BIT
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W1		;;
	TBLRDL [W1],W1		;;
	CALL TRANS_LANG		;;			
	CALL ENSTR_LEN		;;STR_LEN
	MOV W1,FADR0		;;STR ADDRESS
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W1		;;
	INC2 W1,W1		;;
	TBLRDL [W1],W1		;;
	MOV W1,FADR1		;;DYF TABLE	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,R0		;;FLAG
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,R1		;;BETWEEN TIME
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	BTSC DPPB0,#2		;;
	MOV W0,R1		;;START TIME
	MOV R1,W0		;;
	ADD TMR2,WREG		;;
	MOV W0,DPPB2		;;TIMER_BUF
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,R1		;;END TIME
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	TBLRDL [W1++],W0	;;LIMX0
	MOV W0,LCDX_LIM0	;;	
	TBLRDL [W1++],W0	;;LIMX1
	MOV W0,LCDX_LIM1	;;	
	TBLRDL [W1++],W0	;;LIMY0
	MOV W0,LCDY_LIM0	;;	
	TBLRDL [W1++],W0	;;LIMY1
	MOV W0,LCDY_LIM1	;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;     
	MOV W0,COLOR_F		;;	
	TBLRDL [W1++],W0	;;      
	MOV W0,COLOR_B  	;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0	;;
	MOV W0,R2		;;FIRST X 
	TBLRDL [W1++],W0	;;
	MOV W0,R3		;;END X 
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTSS DPPB0,#2		;;START BIT
	BRA DYSTR2		;;
	BCLR DPPB0,#2		;;
	MOV R2,W0		;;RELOAD FIRST X,Y
	MOV W0,DPPB3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0	;;	
	SUB LCDY_LIM1,WREG	;;
	INC W0,W0		;;
	MOV W0,BMPY		;;
	MOV LCDX_LIM0,W0	;;	
	MOV W0,LCDX		;;	
	SUB LCDX_LIM1,WREG	;;
	INC W0,W0		;;
	MOV W0,BMPX		;;
	MOV LCDY_LIM0,W0	;;	
	MOV W0,LCDY		;;	
	CALL DISP_BLK		;;
	BRA DYSTR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYSTR2:				;;
	DEC DPPB3		;;<<
DYSTR3:				;;
	MOV LCDY_LIM0,W0	;;	
	SUB LCDY_LIM1,WREG	;;
	INC W0,W0		;;
	MOV W0,BMPY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;
	SUB LCDX_LIM1,WREG	;;
	INC W0,W0		;;
	MOV STR_LEN,W2		;;
	SUB W0,W2,W0		;;
	BRA NC,DYSTR4		;; 	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,BMPX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;	
	MOV W0,LCDX		;;
	MOV LCDY_LIM0,W0	;;	
	MOV W0,LCDY		;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPX,W0		;;
	ADD LCDX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR0,W1		;;
	CALL ENSTR		;;
	MOV LCDX,W0		;;
	SUB LCDX_LIM1,WREG	;;
	INC W0,W0		;;
	MOV W0,BMPX		;;
	CALL DISP_BLK		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET DPPB0,#3		;;STOP BIT
	BRA DYSTR_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DYSTR4:				;;
	NEG W0,W0		;;
	ADD R3,WREG		;;
	NEG W0,W0		;;END X
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP DPPB3		;;
	BRA GT,DYSTR5		;;
	BRA NZ,DYSTR4A		;;
	MOV R1,W0		;;
	ADD TMR2,WREG		;;
	MOV W0,DPPB2		;;TIMER_BUF
	BSET DPPB0,#2		;;START BIT
	BRA DYSTR5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DYSTR4A:			;;
	MOV R2,W0		;;RELOAD FIRST X,Y
	MOV W0,DPPB3		;;
DYSTR5:				;;
	MOV DPPB3,W0		;;	
	MOV W0,LCDX		;;
	MOV LCDY_LIM0,W0	;;	
	MOV W0,LCDY		;;
	MOV FADR0,W1		;;
	CALL ENSTR		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX,W0		;;
	SUB LCDX_LIM1,WREG	;;	
	INC W0,W0		;;
	MOV W0,BMPX		;;
	CALL DISP_BLK		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DYSTR_END:			;;	
	MOV #12,W0		;;
	MUL DYBMP_CNT		;;
	MOV #DYBMP_BUF,W0	;;
	ADD W0,W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB1,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB3,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB4,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB5,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	POP LCDY_LIM1		;;
	POP LCDY_LIM0		;;
	POP LCDX_LIM1		;;
	POP LCDX_LIM0		;;
	POP R3			;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP_STR_1:				;;
	MOVLF 0,LCDX_LIM0		;;
	MOVLF 127,LCDX_LIM1		;;
	MOVLF 128,LCDY_LIM0		;;
	MOVLF 143,LCDY_LIM1		;;
	CALL FIXSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP_STR_2:				;;
	MOVLF 0,LCDX_LIM0		;;
	MOVLF 127,LCDX_LIM1		;;
	MOVLF 144,LCDY_LIM0		;;
	MOVLF 159,LCDY_LIM1		;;
	CALL FIXSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DPP_STR_M:				;;
	MOVLF 0,LCDX_LIM0		;;
	MOVLF 127,LCDX_LIM1		;;
	MOVLF 136,LCDY_LIM0		;;
	MOVLF 151,LCDY_LIM1		;;
	CALL FIXSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
LOAD_FRAM_BK:				;;
	CALL WAIT_FLASH_READY		;;
	MOV #SET_BUF,W1			;;
	BCLR FCS,#FCS_P			;;
	MOV #0x0003,W0			;;
	CALL SPIPRG			;;
	MOV #0x003D,W0			;;
	CALL SPIPRG			;;
	MOV #0,W0			;;
	CALL SPIPRG			;;
	MOV #0,W0			;;
	CALL SPIPRG			;;	
	CLR FADR0			;;
	BRA LOAD_FRAM1			;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
LOAD_FRAM:				;;
	CALL WAIT_FLASH_READY		;;
	MOV #SET_BUF,W1			;;
	BCLR FCS,#FCS_P			;;
	MOV #0x0003,W0			;;
	CALL SPIPRG			;;
	MOV #0x003F,W0			;;
	CALL SPIPRG			;;
	MOV #0,W0			;;
	CALL SPIPRG			;;
	MOV #0,W0			;;
	CALL SPIPRG			;;	
	CLR FADR0			;; 
LOAD_FRAM1:				;;
	MOV W0,SPI1BUF			;;
LOAD_FRAM1A:				;;
	BTSS SPI1STAT,#0		;;
	BRA LOAD_FRAM1A			;;
        MOV [W1],W0			;;
	BTSC FADR0,#0			;;
	SWAP W0				;;
	MOV.B #0,W0			;;
	MOV SPI1BUF,W2			;;
	AND #0x00FF,W2			;;
	IOR W2,W0,W0			;;
	BTSC FADR0,#0			;;
	SWAP W0				;;
	MOV W0,[W1]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FADR0,#0			;;
	INC2 W1,W1			;;
	INC FADR0			;;
	MOV.B FADR0,WREG		;;
	BRA NZ,LOAD_FRAM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FCS,#FCS_P			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INIT_FRAM:
	MOVLF 0,LANG_SET
	RETURN

INIT_RAM:
	CLR FLAGA	
	CLR FLAGB	
	CLR FLAGC	
	CLR FLAGD
	CLR FLAGE
	CLR FLAGF
	CLR FLAGG
	CLR FONT_TYP
	CLR RFBUF_PCNT0
	CLR RFBUF_PCNT1
	CLR ALM_FLAG
	CLR A_MIN
	CLR A_HOUR
	CLR A_ONOFF
	CLR C_MIN
	CLR C_HOUR
	CLR C_SEC
	CLR OSC_CNT	
	CLR SIGNAL_CNT
	CLR SHAKE_CNT	
	CLR TPMS_ALM_CNT
	CLR MOD_TYPE
	CLR MOD_FLAG
	CLR DEBUG_CNT		
	MOV #188,W0
	MOV W0,POWV_DAT
	MOVLF 65,TEMPC_DAT
	CLR RXBYTE_BUF 
	CLR POWV_BUF0
	CLR POWV_BUF1
	CLR POWV_CNT
	CLR POWV_TEMP 
	DEC POWV_TEMP
	RETURN
NOPP:
	NOP
	NOP
	RETURN

TEST_ILI9163:
	BSET BKLCE,#BKLCE_P	;;
	CALL RESET_LCD
	W0LCD 0x11		;;SLEEP OUT	
	W0LCD 0x13		;;ENTER NORMAL MODE
	W0LCD 0x29		;;
	W8LCD 0x3A,0x55		;;		
YYUU:
	CALL C_GRGR
	CALL CLRSCR
	NOP
	NOP
	NOP
	CALL C_BKBK
	CALL CLRSCR
	NOP
	NOP
	NOP
	BRA YYUU
	BCLR LCDCS,#LCDCS_P
	MOV #0x2C,W0
	CALL LCDWC8
	MOV #160,W2
IIOO1:
	MOV #128,W3
IIOO:
	MOV #0x000F,W0
	CALL LCDWD16
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DEC W3,W3
	BRA NZ,IIOO 	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP


	DEC W2,W2
	BRA NZ,IIOO1 	
	BSET LCDCS,#LCDCS_P

	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BRA TEST_ILI9163
	;=========================
;;	WLCDP 0x00,0x0001 	;;<<start oscillation
	W0LCD 0x11		;;SLEEP OUT	
	;=========================
;;	WLCDP 0x07,0x0004 	;;DISPLAY CONTROL
	;GON=7.5,DTE=7.4,D=7.1.0

	WLCDP 0x0D,0x0000	;0x000F
	;PON=0 
	WLCDP 0x0E,0x0000	;0x000F
	;VCOMG=0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0
	CALL DLYMX
	WLCDP 0x01,0x0013 ;<<
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WLCDP 0x0C,0x0000	;SET VCI
	WLCDP 0x0D,0x0003	;SET VRH
	WLCDP 0x0E,0x1319	;SET VCM,VDV
	WLCDP 0x09,0x00E8	;DK=1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WLCDP 0x05,0x1020;
	WLCDP 0x23,0x0000;
	WLCDP 0x24,0x0000;
	WLCDP 0x25,0x0000;
	WLCDP 0x26,0x0000;
	WLCDP 0x08,0x0202;
	WLCDP 0x0A,0x0000;
	WLCDP 0x0B,0x0000;
	WLCDP 0x0C,0x0000;
	WLCDP 0x0F,0x0000;
	WLCDP 0x21,0x0000;
	WLCDP 0x14,0x9F00;
	WLCDP 0x16,0x7F00;
	WLCDP 0x17,0x9F00;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WLCDP 0x03,0x0048	;SET BT,DC0
	WLCDP 0x09,0x0048	;SET DC1
	WLCDP 0x0D,0x0013	;SET PON
	WLCDP 0x03,0x0148	;SET AP[2:0]
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #40,W0
	CALL DLYMX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WLCDP 0x03,0x0148	;SET BT,DC0
	WLCDP 0x09,0x00E0	;DK=0
	WLCDP 0x0E,0x3319	;VCOM=1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WLCDP 0x30,0x0707
	WLCDP 0x31,0x0707
	WLCDP 0x32,0x0707
	WLCDP 0x33,0x0305
	WLCDP 0x34,0x0007
	WLCDP 0x35,0x0000
	WLCDP 0x36,0x0007
	WLCDP 0x37,0x0502
	WLCDP 0x3A,0x050F
	WLCDP 0x3B,0x070C
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WLCDP 0x09,0x00E4	;DK=0
	CALL LCD_ON



	BCLR LCDCS,#LCDCS_P
	MOV #0x04,W0
	CALL LCDWC8
	CALL LCDRD8
	NOP
	NOP
	NOP
	NOP
	CALL LCDRD8
	NOP
	NOP
	NOP
	NOP
	CALL LCDRD8
	NOP
	NOP
	NOP
	NOP
	CALL LCDRD8
	NOP
	NOP
	NOP
	NOP
	BSET LCDCS,#LCDCS_P
	RETURN

LCDWC8:
	BCLR LCDRS,#LCDRS_P
	MOV.B WREG,LATC
	BCLR LCDWR,#LCDWR_P
	BSET LCDWR,#LCDWR_P
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DRAW_POINT:				;;
  .IFDEF NEWLCD_K			;;
	CALL GOTOXY			;;
	BCLR LCDCS,#LCDCS_P		;;
	MOV #0x2C,W0             	;;	
	CALL LCDWC8			;;
  .ELSE					;;
	WLCDP 0x21,0x007F		;;
	BCLR LCDCS,#LCDCS_P		;;
	MOV #0x22,W0             	;;	
	CALL LCDWC			;;
  .ENDIF 				;;
	BSET LCDRS,#LCDRS_P		;;
	MOV COLOR_F,W0			;;
	SWAP W0				;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	SWAP W0				;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	BSET LCDCS,#LCDCS_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DARK_POINT:				;;
  .IFDEF NEWLCD_K			;;
	CALL GOTOXY			;;
	BCLR LCDCS,#LCDCS_P		;;
	MOV #0x2C,W0             	;;	
	CALL LCDWC8			;;
  .ELSE					;;
	WLCDP 0x21,0x007F		;;
	BCLR LCDCS,#LCDCS_P		;;
	MOV #0x22,W0             	;;	
	CALL LCDWC			;;
  .ENDIF 				;;
	BSET LCDRS,#LCDRS_P		;;
	MOV COLOR_B,W0			;;
	SWAP W0				;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	SWAP W0				;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	BSET LCDCS,#LCDCS_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DARKSCR:				;;
	CLR COLOR_B			;;
CLRSCR:					;;
  .IFDEF NEWLCD_K			;;
	CLR LCDX			;;
	CLR LCDY			;;
	CALL GOTOXY			;;
	BCLR LCDCS,#LCDCS_P		;;
	MOV #0x2C,W0             	;;	
	CALL LCDWC8			;;
  .ELSE					;;
	WLCDP 0x21,0x007F		;;
	BCLR LCDCS,#LCDCS_P		;;
	MOV #0x22,W0             	;;	
	CALL LCDWC			;;
  .ENDIF 				;;
	BSET LCDRS,#LCDRS_P		;;
	MOV #160,W0			;;
	MOV W0,R0			;;
CLRSCR1:				;;
	MOV #128,W0			;;
	MOV W0,R1			;;
CLRSCR2:				;;
	MOV COLOR_B,W0			;;
	SWAP W0				;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	SWAP W0				;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	DEC R1				;;
	BRA NZ,CLRSCR2			;;
	DEC R0				;;
	BRA NZ,CLRSCR1			;;
	BSET LCDCS,#LCDCS_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


LCDWC16:
	BCLR LCDRS,#LCDRS_P
	SWAP W0
	MOV.B WREG,LATC
	BCLR LCDWR,#LCDWR_P
	BSET LCDWR,#LCDWR_P
	SWAP W0
	MOV.B WREG,LATC
	BCLR LCDWR,#LCDWR_P
	BSET LCDWR,#LCDWR_P
	RETURN	 
LCDWD8:
	BSET LCDRS,#LCDRS_P
	MOV.B WREG,LATC
	BCLR LCDWR,#LCDWR_P
	BSET LCDWR,#LCDWR_P
	RETURN

LCDWD16:
	BSET LCDRS,#LCDRS_P
	SWAP W0
	MOV.B WREG,LATC
	BCLR LCDWR,#LCDWR_P
	BSET LCDWR,#LCDWR_P
	SWAP W0
	MOV.B WREG,LATC
	BCLR LCDWR,#LCDWR_P
	BSET LCDWR,#LCDWR_P
	RETURN	 

LCDRD16:
	BSET LCDRS,#LCDRS_P
	SETM.B TRISC
	BCLR LCDRD,#LCDRD_P
	NOP
	MOV.B PORTC,WREG
	SWAP W0
	;;;;;;;;;;;;;;;;;;;;;
	BSET LCDRD,#LCDRD_P
	NOP
	BCLR LCDRD,#LCDRD_P
	NOP
	MOV.B PORTC,WREG
	BSET LCDRD,#LCDRD_P
	CLR.B TRISC
	RETURN	 


LCDRD8:
	BSET LCDRS,#LCDRS_P
	SETM.B TRISC
	BCLR LCDRD,#LCDRD_P
	NOP
	MOV.B PORTC,WREG
	BSET LCDRD,#LCDRD_P
	CLR.B TRISC
	RETURN	 



DLYPRG:
	CLRWDT
	DEC W0,W0
	BRA NZ,DLYPRG
	RETURN

INIT_UART:
;;	MOV #415,W0	;9600
	MOV #207,W0	;19200
;;	MOV #68,W0	;57600
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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1RXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	PUSH W2				;;
	BCLR IFS0,#11			;;
	MOV U1RXREG,W1			;;
	AND #255,W1			;;
	BTSC FLAGG,#U1RX_PACK_F		;;
	BRA U1RXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #'$',W0			;;
	CP W0,W1			;;
	BRA NZ,U1RXI_1			;;	
	CLR U1RX_BYTE_PTR		;;
	BRA U1RXI_2			;;
U1RXI_1:				;;
	MOV #0x0D,W0			;;END	
	CP W0,W1			;;
	BRA NZ,U1RXI_2A			;;
	MOV U1RX_BUF,W0			;;
	AND #255,W0
	XOR #0x24,W0
	BRA NZ,U1RXI_END
	MOV U1RX_BYTE_PTR,W0		;;
	MOV W0,U1RX_BYTE		;;
	BSET FLAGG,#U1RX_PACK_F		;;
	CLR U1RX_BYTE_PTR		;; 
	BRA U1RXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U1RXI_2A:				;;
	NOP
U1RXI_2:				;;
	MOV #64,W0			;;
	CP U1RX_BYTE_PTR		;;
	BRA GEU,U1RXI_END		;;
	MOV #U1RX_BUF,W0		;;
	ADD U1RX_BYTE_PTR,WREG		;;
	ADD U1RX_BYTE_PTR,WREG		;;
	MOV W1,[W0]			;;
	INC U1RX_BYTE_PTR		;;
U1RXI_END:				;;
	POP W2				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
POWER_ON:			;;
        MOV #0x1E00,W15       	;;Initalize the Stack Pointer
        MOV #0x1FFE,W0        	;;Initialize the Stack Pointer Limit Register
        MOV W0,SPLIM		;;
        CALL CLR_WREG 		;;
        CALL INIT_IO		;;
	CALL INIT_SIO		;;
	CALL INIT_UART
;	CALL INIT_TIMER		;;	
;	MOV #100,W0		;;
;	CALL DLYMX		;;		
	BSET RCON,#SWDTEN 	;;
	CLRWDT			;;
	MOV #10000,W0		;;
	CALL DLYPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_OSC		;;
	CALL INIT_SIO		;;
	CALL INIT_RAM		;;
	CALL INIT_SPI		;;
	CALL FLASH_RESET	;;	
	CALL INIT_TIMER		;;	
	CALL INIT_LCDLIM	;;	
;	CALL TEST_ILI9163	''
	CALL INIT_LCD		;;
	CALL INIT_BUZ		;;
	CALL INIT_AD		;;
	CALL COLOR0		;;
	CALL DARKSCR		;;
	CALL LOAD_FRAM_BK	;;
	MOV WID00,W0		;;
	ADD WID01,WREG		;;
	ADD WID02,WREG		;;
	ADD WID10,WREG		;;
	ADD WID11,WREG		;;
	ADD WID12,WREG		;;
	ADD WID20,WREG		;;
	ADD WID21,WREG		;;
	ADD WID22,WREG		;;
	ADD WID30,WREG		;;
	ADD WID31,WREG		;;
	ADD WID32,WREG		;;
	ADD WID40,WREG		;;
	ADD WID41,WREG		;;
	ADD WID42,WREG		;;
	XOR WID_CHKSUM,WREG	;;
	BTSS SR,#Z		;;
	CALL LOAD_FRAM		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_FRAM 		;;
	CALL INIT_MAIN		;;
	CALL CHK_SETS		;;
	CALL CLR_TPMSV		;;
	BTSS PORTB,#10		;;<<DEBUG
	CALL FACPRG		;;
	CALL CHKAD_BAT		;;	
	CALL CHKAD_POW		;;
	CALL OSC_H		;;
	BSET BKLCE,#BKLCE_P	;;
;	CALL PRESHOW 		;;
;	CALL DISP_W5		;;
;	CALL TEST_DEGA
	CALL TITLE		;;
POWER_ON1:			;;
	BSET BKLCE,#BKLCE_P	;;
	BSET FLAGF,#BKLCE_F	;;
;	CALL DISP_TABLE		;;
	BCLR MRXE,#MRXE_P	;;	
	CALL OSC_M		;;
;	MOV #100,W0		;;
;	CALL DLYMX		;;
	CALL CHKAD_BAT		;;
	CALL LOAD_TPMS_DATA	;;
	BRA TPMS_MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



TEST_STR:
	.ASCII "TEST\0"
KEY_STR:
	.ASCII "KEY:\0"
RF_STR:
	.ASCII "RF:\0"
BAT_STR:
	.ASCII "BAT:\0"
POW_STR:
	.ASCII "POW:\0"
MIC_STR:
	.ASCII "MIC:\0"
SHK_STR:
	.ASCII "SHK:\0"

CHK_SETS:				;;
	LOFFS7 SET_LIMIT_S		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SET:				;;
	CLR W6				;;
CHK_SET1:				;;
	MOV W7,W1			;;	
	MOV #8,W0			;;
	MUL.UU W6,W0,W2			;;
	ADD W2,W1,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W0++],W1		;;
	TBLRDL [W0++],W2		;;
	TBLRDL [W0++],W3		;;
	TBLRDL [W0++],W4		;;
	CP0 W1				;;
	BRA NZ,$+4			;;
	RETURN				;;
	BTSC FLAGC,#INITIAL_F		;;
	BRA CHK_SET_INIT		;;		
	MOV [W1],W5			;;
	CP W5,W2			;;
	BRA LTU,CHK_SET_LT		;;
	CP W5,W3			;;
	BRA GTU,CHK_SET_GT		;;
	INC W6,W6			;;
	BRA CHK_SET1			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
CHK_SET_LT:				;;
CHK_SET_GT:				;;
CHK_SET_INIT:				;;
	MOV W4,[W1]			;;
	INC W6,W6			;;
	BRA CHK_SET1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPSHK:				;;
	INC FACB1			;;
	LXY 60,96			;;
	MOV FACB1,W0			;;
	CALL ENBYTE			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPMIC:				;;
	INC FACB2			;;
	LXY 60,112			;;
	MOV FACB2,W0			;;
	CALL ENBYTE			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FACPRG:
	CLR FACB1	
	CLR FACB2
	BSET BKLCE,#BKLCE_P
	BSET FLAGF,#BKLCE_F		;;
	CALL OSC_H			;;	
	CALL SING_B531
	MOV #0xFFFF,W0
	MOV W0,COLOR_B
	CALL CLRSCR		;;
	MOV #1000,W0 
	CALL DLYMX

	CALL SING_B531
	MOV #0x0000,W0
	MOV W0,COLOR_B
	CALL CLRSCR		;;
	MOV #300,W0 
	CALL DLYMX

	CALL SING_B531
	MOV #0x001F,W0
	MOV W0,COLOR_B
	CALL CLRSCR		;;
	MOV #300,W0 
	CALL DLYMX

	CALL SING_B531
	MOV #0x07E0,W0
	MOV W0,COLOR_B
	CALL CLRSCR		;;
	MOV #300,W0 
	CALL DLYMX

	CALL SING_B531
	MOV #0xF800,W0
	MOV W0,COLOR_B
	CALL CLRSCR		;;
	MOV #300,W0 
	CALL DLYMX

	MOV #0x0000,W0
	MOV W0,COLOR_B
	CALL CLRSCR		;;

	LDPTR TEST_STR			;;
	LXY 48,16			;;
	CALL ENSTR			;;

	LDPTR KEY_STR			;;
	LXY 44,32			;;
	CALL ENSTR			;;

	LDPTR RF_STR			;;
	LXY 44,48			;;
	CALL ENSTR			;;

	LDPTR BAT_STR			;;
	LXY 28,64			;;
	CALL ENSTR			;;

	LDPTR POW_STR			;;
	LXY 28,80			;;
	CALL ENSTR			;;

	LDPTR SHK_STR			;;
	LXY 28,96			;;
	CALL ENSTR			;;

	LDPTR MIC_STR			;;
	LXY 28,112			;;
	CALL ENSTR			;;


	CLR FACBUF0 
	CALL OSC_M
FACPRG1:
	CALL TMR2PRG			;;
	CALL TMR_MAIN			;;
	CALL GETRF_T			;;
	CALL CHK_FAC_RFIN
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FACB0,W0
	XOR PORTB,WREG
	AND #0x0140,W0
	MOV W0,W1
	XOR FACB0
	PUSH W1
	BTSC W1,#6
	CALL DISPSHK
	POP W1
	BTSC W1,#8
	CALL DISPMIC
 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0			;;
	CP DETBAT_TIM			;;
	BRA LTU,FACPRG2			;;
	CLR DETBAT_TIM			;;
	CALL CHKAD_BAT			;;
	LXY 60,64			;;
	MOV BATV_BUF,W0
	SWAP W0
	CALL ENNUM			;;
	MOV BATV_BUF,W0
	CALL ENBYTE			;;
	MOV #' ',W0
	CALL ENCHR
	MOV #'L',W0
	BTSS FLAGB,#BATLOW_F		;;<<
	MOV #'H',W0
	CALL ENCHR
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL CHKAD_POW			;;
	LXY 60,80			;;
	MOV POWV_BUF,W0
	SWAP W0
	CALL ENNUM			;;
	MOV POWV_BUF,W0
	CALL ENBYTE			;;



	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FACPRG2:
	CALL LKEYBO			;;
	CALL FAC_KEY			;;
	BRA FACPRG1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_FAC_RFIN:				;;
	BTSS FLAGE,#TRXIN_F		;;
	RETURN				;;
	BCLR FLAGE,#TRXIN_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TRX0,W0			;;
	AND #0xF0,W0			;;
	XOR #0xF0,W0			;;
	BRA Z,$+4 			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TRX1,W0			;;
	AND #0xFF,W0			;;
	XOR #0x12,W0			;;
	BRA Z,$+4 			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TRX2,W0			;;
	AND #0xFF,W0			;;
	XOR #0x34,W0			;;
	BRA Z,$+4 			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TRX3,W0			;;
	AND #0xFF,W0			;;
	XOR #0x56,W0			;;
	BRA Z,$+4 			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TRX5,W0			;;
	AND #0xFF,W0			;;
	XOR #0x78,W0			;;
	BRA Z,$+4 			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV TRX6,W0			;;
;	AND #0xFF,W0			;;
;	XOR #0x9A,W0			;;
;	BRA Z,$+4 			;;
;	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LXY 68,48			;;
	INC FACBUF0			;;
	MOV FACBUF0,W0			;;
	CALL ENBYTE			;;
	CALL SING_BEEP
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


FAC_KEY:
	MOV #0x0001,W0
	CP KEY_FLAG0
	BRA Z,FAC_KEY0P
	;;;;;;;;;;;;;;;;;;;;;
;	MOV #0x0100,W0
;	CP KEY_FLAG0
;	BRA Z,FAC_KEY0R
	;;;;;;;;;;;;;;;;;;;;;
;	MOV #0x0001,W0
;	CP KEY_FLAG1
;	BRA Z,FAC_KEY0C
	;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0002,W0
	CP KEY_FLAG0
	BRA Z,FAC_KEY1P
	;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0004,W0
	CP KEY_FLAG0
	BRA Z,FAC_KEY2P

	MOV #0x0400,W0
	CP KEY_FLAG0
	BRA Z,FAC_KEY2R

	MOV #0x0004,W0
	CP KEY_FLAG1
	BRA Z,FAC_KEY2C

	;;;;;;;;;;;;;;;;;;;;;
	RETURN

FAC_KEY2R:
	CALL INIT_TPMS_DATA
	CALL SAVE_FLASH_ALL
	POP W0
	POP W0
	POP W0
	POP W0
	GOTO POWER_ON


FAC_KEY2C:
	BSET W5_EN_SET,#0
	CALL INIT_TPMS_DATA
	CALL SAVE_FLASH_ALL
	POP W0
	POP W0
	POP W0
	POP W0
	GOTO POWER_ON


FAC_KEY0P:
	MOV #1,W0
	BRA FAC_DISKEY
FAC_KEY1P:
	MOV #2,W0
	BRA FAC_DISKEY
FAC_KEY2P:
	MOV #3,W0
	BRA FAC_DISKEY
	
FAC_DISKEY:
	PUSH W0
	LXY 76,32			;;
	POP W0
	CALL ENNUM			;;

	RETURN
	


TABLE_SEL_TBL:
    	.WORD TABLE_BLACK_0_ADR0	
	.WORD TABLE_BLACK_0_ADR1
    	.WORD TABLE_BLUE_0_ADR0	
	.WORD TABLE_BLUE_0_ADR1   
    	.WORD TABLE_PURPLE_0_ADR0	
	.WORD TABLE_PURPLE_0_ADR1
    	.WORD JOSN_LOGO_0_ADR0	
	.WORD JOSN_LOGO_0_ADR1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_TABLE:			;;
	CALL INIT_LCDLIM	;;	
	LOFFS1 TABLE_SEL_TBL	;;
	MOV #4,W0		;;
	MUL TABLE_SET		;;
	ADD W2,W1,W1		;;
	TBLRDL [W1++],W0	;;
	MOV W0,FADR0		;;
	TBLRDL [W1++],W0	;;	
	MOV W0,FADR1		;;
	LXY 0,0			;;
	MOVLF 128,BMPX		;;
	MOVLF 160,BMPY		;;
	CALL GET_BLKC8		;;
	CALL DISP_BMP8		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
	





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TEMPC:				;;
	BTSC CF_SET,#0			;;
	BRA TRANS_TEMPF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TEMPC_DAT,W0		;;	
TRANS_TEMPC0:				;;
	MOV #40,W1			;;
	SUB W0,W1,W0			;;
	BRA GEU,TRANS_TEMPC1		;;
	NEG W0,W0			;;
	MOV #'-',W1			;;
	MOV W1,DISPB14			;;
	BRA TRANS_TEMPC2		;;
TRANS_TEMPC1:				;;
	MOV #' ',W1			;;
	MOV W1,DISPB14			;;
TRANS_TEMPC2:				;;
	MOV #100,W2			;;	
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	CP0 W0				;;
	BRA Z,TRANS_TEMPC3		;;
	ADD #0x30,W0			;;
	MOV W0,DISPB14			;;
TRANS_TEMPC3:				;;
	MOV W1,W0			;;
	MOV #10,W2			;;	
	CALL D1D2B			;;
	MOV W0,DISPB15			;;
	MOV W1,DISPB16			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #1,W0			;;	
	MOV W0,DISPB17			;;
	MOV #'F',W0			;;
	BTSS CF_SET,#0			;;
	MOV #'C',W0			;;
	MOV W0,DISPB18			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TEMPF:				;;
	MOV #9,W0			;;
	MUL TEMPC_DAT			;;
	MOV W2,W0			;;
	MOV #5,W2 			;;
	REPEAT #17			;;
	DIV.UW W0,W2			;;
	BRA TRANS_TEMPC0		;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


D1D2B:
	REPEAT #17
	DIV.UW W0,W2
	ADD #0x30,W0
	ADD #0x30,W1
	RETURN

	







;/////////////////////////////////////////////////////////////////////////////////


CHG_OSC:
	INC OSC_CNT
	MOV #4,W0
	CP OSC_CNT
	BRA LTU,$+4
	CLR OSC_CNT
	MOV OSC_CNT,W0
	CP W0,#0
	BRA Z,OSC_H
	CP W0,#1
	BRA Z,OSC_M
	CP W0,#2
	BRA Z,OSC_L
	CP W0,#3
	BRA Z,SLEEP_PRG
	RETURN
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OSC_H:		
OSC_FRCPLL:
	BCLR FLAGC,#OSC8M_F
	CLR OSC_CNT
	MOVLF 600,PR4			
	CLR CLKDIV
	MOV #0xA030,W0
	MOV W0,T2CON		
	MOV #1,W0
	BRA OSC_PRG
OSC_M:
OSC_FRC:
	BSET FLAGC,#OSC8M_F
	MOVLF #1,OSC_CNT
	MOVLF 150,PR4			
	CLR CLKDIV
	MOV #0xA020,W0
	MOV W0,T2CON		
	MOV #7,W0
	BRA OSC_PRG
OSC_L:
OSC_FRCDIV:
	BCLR FLAGC,#OSC8M_F
	MOVLF #2,OSC_CNT
	MOV #0x0300,W0
	MOV W0,CLKDIV
	MOV #0xA010,W0
	MOV W0,T2CON		
	MOV #7,W0
	BRA OSC_PRG
OSC_PRG:		
	MOV #OSCCONH, w1
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T4Interrupt:			;;37.7 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	BCLR IFS1,#T4IF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC T4ITMR_B		;;
	BTSC T4ITMR_B,#2	;;
	INC T4ITMR		;;
	BCLR T4ITMR_B,#2	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSC FLAGA,#MTXE_F      ;;  
        BRA RFTX_INT            ;;  
        BSET MTX,#MTX_P         ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGA,#MRXE_F	;;
	BCLR MRXE,#MRXE_P	;;	
	MOV PORTA,W0		;;	
	XOR FLAGA,WREG		;;
	AND #0x0200,W0		;;	
	BRA Z,RFNO_CHG  	;;	
	XOR FLAGA		;;	
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RFBUF_PCNT0,W0	;;	
	AND #0x003F,W0		;;
	RLNC W0,W0		;;	
	MOV #RXBUF,W1		;;
	ADD W0,W1,W1		;;
	MOV RF_CNT,W0		;;
	MOV W0,[W1]		;;
	INC RFBUF_PCNT0 	;;
	CLR RF_CNT		;;
	BRA RFRX_END		;;
RFNO_CHG:			;;
	INC RF_CNT		;;
	BTSC FLAGA,#RFLH_F	;;
	BCLR RFBUF_PCNT0,#0	;;	
	BTSS FLAGA,#RFLH_F 	;;
	BSET RFBUF_PCNT0,#0	;; 	
	BRA RFRX_END		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RFTX_INT:                       ;;
	CLR TXRF_CNT		;; 
	BSET MRXE,#MRXE_P	;;	
        INC RFTX_TIM            ;;
        MOV #8,W0               ;;
	CP RFTX_TIM		;;
	BRA LTU,RFTX_END	;;
        CLR RFTX_TIM            ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSS FLAGA,#MTXPRE_F    ;;
        BRA RFTX_INT2           ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSS MTXBIT_CNT,#0      ;;
        BCLR MTX,#MTX_P         ;;
        BTSC MTXBIT_CNT,#0      ;;
        BSET MTX,#MTX_P         ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC MTXBIT_CNT          ;;
	MOV #79,W0		;;
	CP MTXBIT_CNT		;;	
	BRA LTU,RFTX_END	;;	
        CLR MTXBIT_CNT          ;;
        CLR MTXBYTE_CNT         ;;
        BCLR FLAGA,#MTXPRE_F    ;;
        BRA RFTX_END            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RFTX_INT2:                      ;;
        CP0 MTX_COUNT           ;;
        BRA NZ,RFTX_INT3        ;;
        BSET MTX,#MTX_P         ;;
        BCLR FLAGA,#MTXE_F      ;;
        CLR CONCON_TIM          ;;
        CLR RXBYTE_BUF          ;;        
        BRA RFTX_END            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RFTX_INT3:                      ;;
	CP0 MTXBIT_CNT		;;
        BRA NZ,RFTX_INT4	;;
        BCLR MTX,#MTX_P         ;;
        INC2 MTXBIT_CNT         ;;
        BRA RFTX_END      	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RFTX_INT4:                      ;;
        BTSS MTXBIT_CNT,#0      ;;
        BRA RFTX_INT5           ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC MTXBIT_CNT          ;;
	MOV #32,W0		;;	
	CP MTXBIT_CNT		;;
	BRA LTU,RFTX_INT4A	;;
        CLR MTXBIT_CNT         	;;
        INC MTXBYTE_CNT  	;;
        MOV #7,W0               ;;
	CP MTXBYTE_CNT		;;	
	BRA LTU,RFTX_INT4B	;;
        CLR MTXBYTE_CNT         ;;
        DEC MTX_COUNT           ;;
        BRA RFTX_INT4C          ;;
RFTX_INT4A:                     ;;
        NOP                     ;;
        NOP                     ;;
        NOP                     ;;
        NOP                     ;;
        NOP                     ;;
RFTX_INT4B:                     ;;
        NOP                     ;;
        NOP                     ;;
	NOP			;;
RFTX_INT4C:                     ;;
        NOP                     ;;
        NOP                     ;;
        NOP                     ;;
        NOP                     ;;
        MOV #0x0100,W0          ;;
	XOR LATA		;;
        BRA RFTX_END            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RFTX_INT5:                      ;;
	MOV #TXBUF,W0		;;	
	ADD MTXBYTE_CNT,WREG	;;
	ADD MTXBYTE_CNT,WREG	;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W0],W0		;;
        BTSS MTXBIT_CNT,#4      ;;
        SWAP W0                 ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #4,W1               ;;
        BTSC MTXBIT_CNT,#2      ;;
        MOV #1,W1               ;;
        BTSS MTXBIT_CNT,#3      ;;BIT_TRANS
        SWAP.B W1               ;;
        BTSS MTXBIT_CNT,#1      ;;
        RLNC W1,W1               ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        AND W0,W1,W0            ;;
        BTSS SR,#Z              ;;
        BSET MTX,#MTX_P         ;;
        BTSC SR,#Z              ;;
        BCLR MTX,#MTX_P         ;;
        INC MTXBIT_CNT          ;;
        BRA RFTX_END            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RFTX_END:
RFRX_END:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHAKE_INT:				;;
	CP0 SHAKE_CNT			;;
	BRA Z,SHAKE_INT1 		;;
	INC SHAKE_TIM			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #2,W0			;;
	CP SHAKE_TIM			;;
	BRA NZ,$+6			;;
	BCLR SHAKE,#SHAKE_P		;;
	BRA SONG_INT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #1000,W0			;;
	CP SHAKE_TIM			;;
	BRA NZ,$+6			;;
	BSET SHAKE,#SHAKE_P		;;
	BRA SONG_INT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #5000,W0			;;
	CP SHAKE_TIM			;;
	BRA NZ,$+6			;;
	BCLR SHAKE,#SHAKE_P		;;
	BRA SONG_INT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #6000,W0			;;
	CP SHAKE_TIM			;;
	BRA NZ,$+6			;;
	BSET SHAKE,#SHAKE_P		;;
	BRA SONG_INT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #30000,W0			;;
	CP SHAKE_TIM			;;
	BRA LTU,SONG_INT		;;
	CLR SHAKE_TIM			;;
	DEC SHAKE_CNT			;;
	BRA SONG_INT			;;
SHAKE_INT1:				;;
	BSET SHAKE,#SHAKE_P		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SONG_INT:
	INC SONG_BASET
	MOV SONG_BASET_KK,W0
	CP SONG_BASET
	BRA LTU,INT_END
	CLR SONG_BASET
	BTSC FLAGA,#SONG_F	;;
	BRA SONG_INT1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SONG_INT_STOP:			;;
	BCLR FLAGA,#SONG_F	;;	
	BCLR FLAGD,#SONG_KP_STOP_F;;	
SONG_INT_STOP1:			;;
	MOVLF 0xFFFF,OC5R	;;
	BRA SONG_INT_END	;;
SONG_INT1:			;;
	INC SONG_CNT		;;
	MOV SONG_TIM,W0		;;	
	CP SONG_CNT		;;
	BRA GTU,SONG_INT2	;;
	BRA NZ,SONG_INT_END	;;
	MOV SONG_POT,W1		;;
	TBLRDL [W1],W0		;;
	BTSS W0,#7		;;
	BRA SONG_INT_STOP1	;;
	BRA SONG_INT_END	;;
SONG_INT2:			;;
	MOV SONG_POT,W1		;;
	TBLRDL [W1],W0		;;
	INC2 SONG_POT 		;;
	CP0 W0			;;
	BRA NZ,SONG_INT2A	;;
	DEC SONG_AMT		;;
	BRA Z,SONG_INT_STOP	;;
	MOV SONG_POTB,W0	;;
	MOV W0,SONG_POT		;;
	BRA SONG_INT2		;;
SONG_INT2A:			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #0x007F,W0		;;
	BRA NZ,SONG_INT3	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF 0xFFFF,OC5R	;;
	TBLRDL [W1],W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	MOV W0,SONG_TIM		;;
	ADD SONG_TIM		;;
	ADD SONG_TIM		;;
	ADD SONG_TIM		;;
	CLR SONG_CNT		;;
	BRA SONG_INT_END	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
SONG_INT3:			;;
	PUSH W1			;;
	BCLR T3CON,#TON		;;
	LOFFS1 MUSIC_TBL	;;
	ADD W0,W1,W1		;;
	ADD W0,W1,W1		;;
	TBLRDL [W1],W0		;;
	BTSS FLAGC,#OSC8M_F	;;
	BRA SONG_INT4		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
SONG_INT4:			;;
	MOV W0,PR3		;;
	DEC2 W0,W1		;;
	MOV W1,OC5RS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,OC5R 		;;
	CLR TMR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET T3CON,#TON		;;
	POP W1			;;
	TBLRDL [W1],W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	MOV W0,SONG_TIM		;;
	ADD SONG_TIM		;;
	ADD SONG_TIM		;;
	ADD SONG_TIM		;;
	CLR SONG_CNT		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SONG_INT_END:
INT_END:
	POP W1
	POP W0
	POP SR	
	RETFIE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BEEP_OFF:			;;
	MOVLF 0xFFFF,OC5R	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BEEP_ON:			;;
	BCLR T3CON,#TON		;;
	MOV #1912,W0		;;H1
	BTSC OSC_CNT,#1		;;
	BRA BEEP_OSC_L		;;
	BTSC OSC_CNT,#0		;;
	BRA BEEP_OSC_M		;;
	BRA BEEP_OSC_H		;;
BEEP_OSC_L:			;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
BEEP_OSC_M:			;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
BEEP_OSC_H:			;;			
	MOV W0,PR3		;;
	DEC2 W0,W1		;;
	MOV W1,OC5RS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,OC5R 		;;
	CLR TMR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET T3CON,#TON		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FONTP:					;;
	BTSS FLAGA,#THF_F		;;
	BRA FONTP0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W1				;;
	PUSH W2				;;
	PUSH W3				;;
	CALL INIT_LCDLIM		;;
	LOFFS1 TABLE_SEL_TBL		;;
	MOV #4,W0			;;
	MUL TABLE_SET			;;
	ADD W2,W1,W1			;;
	TBLRDL [W1],W0			;;
	MOV W0,FADR0			;;
	INC2 W1,W1			;;
	TBLRDL [W1],W0			;;
	MOV W0,FADR1			;;
	CALL GET_BLKC8			;;
	BSET FCS,#FCS_P			;;
	POP W3				;;
	POP W2				;;
	POP W1				;;
FONTP0:					;;
        PUSH W2				;;
	PUSH W3				;;
	PUSH LCDY			;;
	MOV FONT_Y,W3			;;
	BCLR FLAGA,#GOTOXY_F		;;	
	BSET LCDCS,#LCDCS_P		;;
FONTP1:    				;;	
;;	CALL GOTOXY			;;
        TBLRDL [W1],W0		        ;;
	BTSC W1,#0			;;
	SWAP W0				;;MATRIX
	MOV FONT_X,W2			;;
	PUSH LCDX			;;
	CALL WLCDFX			;;
	POP LCDX			;;
	INC LCDY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGA,#ENF_2X_F		;;
	BRA FONTP2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	CALL GOTOXY			;;
        TBLRDL [W1],W0		        ;;
	BTSC W1,#0			;;
	SWAP W0				;;
	MOV FONT_X,W2			;;
	PUSH LCDX			;;
	CALL WLCDFX			;;
	POP LCDX			;;
	INC LCDY			;;
FONTP2:					;;
	INC W1,W1			;;	;;
	MOV FONT_X,W0			;;
	CP W0,#9			;;
	BRA NC,$+4			;;
	INC W1,W1			;;	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC W3,W3			;;
	BRA NZ,FONTP1  			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FONT_X,W0			;;
	BTSC FLAGA,#ENF_2X_F		;;
	ADD FONT_X,WREG			;;
	ADD LCDX			;;
	POP LCDY			;;
	POP W3				;;
        POP W2	 			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T1Interrupt:			;;
	BCLR IEC0,#T1IE		;;
	BCLR IFS0,#T1IF		;;	
	BCLR IEC1,#CNIE		;;
	BCLR IFS1,#CNIF		;;
	BCLR IFS1,#INT1IF	;; 
	BCLR IEC1,#INT1IE	;;
	BSET FLAGF,#T1_MF	;;	
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__CNInterrupt:			;;
	BCLR IEC1,#CNIE
	BCLR IFS1,#CNIF
	BCLR IFS1,#INT2IF		;; 
	BCLR IEC1,#INT2IE		;;
	BCLR IEC0,#T1IE
	BCLR IFS0,#T1IF
	BCLR IFS1,#INT1IF		;; 
	BCLR IEC1,#INT1IE		;;
	BSET FLAGF,#CNCHG_MF
	RETFIE
__INT1Interrupt:
	BCLR IFS1,#INT1IF		;; 
	BCLR IEC1,#INT1IE		;;
	BCLR IFS1,#INT2IF		;; 
	BCLR IEC1,#INT2IE		;;
	BCLR IEC1,#CNIE
	BCLR IFS1,#CNIF
	BCLR IEC0,#T1IE
	BCLR IFS0,#T1IF
	BSET FLAGF,#INT1_MF
	RETFIE	

__INT2Interrupt:
	BCLR IFS1,#INT1IF		;; 
	BCLR IEC1,#INT1IE		;;
	BCLR IFS1,#INT2IF		;; 
	BCLR IEC1,#INT2IE		;;
	BCLR IEC1,#CNIE
	BCLR IFS1,#CNIF
	BCLR IEC0,#T1IE
	BCLR IFS0,#T1IF
	BSET FLAGG,#INT2_MF
	RETFIE	






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SLEEP_PRG:				;;
	BCLR RCON,#SWDTEN 		;;
	BSET MRXE,#MRXE_P		;;
	BCLR BKLCE,#BKLCE_P		;;
	BCLR FLAGF,#BKLCE_F		;;
	BCLR FLAGF,#INT1_MF		;;
	BCLR FLAGF,#T1_MF		;;
	BCLR FLAGF,#CNCHG_MF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BCLR IEC1,#T4IE			;;
	MOVLF #3,OSC_CNT		;;
	BSET MRXE,#MRXE_P		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IFS1,#CNIF			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BSET CNEN1,#CN14IE		;;RIGHT KEY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	BSET CNEN1,#CN15IE		;;LEFT KEY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNEN2,#CN24IE		;;MIC
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET CNEN2,#CN22IE		;;SHK
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;	BSET CNEN2,#CN16IE		;;MID_KEY
	BCLR IFS1,#INT1IF		;; 
	BSET IEC1,#INT1IE		;;
	BSET INTCON2,#INT1EP		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IFS1,#INT1IF		;; 
	BSET IEC1,#INT1IE		;;
	BCLR INTCON2,#INT1EP		;;

;	BSET CNEN1,#CN6IE		;;P_DETV
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SP_T0_K,W0			;;20MIN
	CP CLRTPMS_TIM			;;
	BRA LTU,SLEEP_PRG00		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC DISCN10S_TIM		;;	
	MOV #10,W0			;;;
	CP DISCN10S_TIM			;;
	BRA LTU,$+4			;;
	BCLR FLAGF,#DISCN10S_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGF,#DISCN10S_F		;;
	BSET IEC1,#CNIE			;;
SLEEP_PRG00:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SP_T1_K,W0			;;20MIN
	CP CLRTPMS_TIM			;;
	BRA GTU,SLEEP_PRG1		;;
SLEEP_PRG0:				;;
	BCLR T1CON,#TON 		;;
	CLR TMR1			;;
	BCLR IFS0,#T1IF			;;
	MOVLF 64,PR1			;;1/128 SEC
	MOV #0x0032,W0			;;	
	MOV W0,T1CON			;;
	BSET T1CON,#TON 		;;
	BSET IEC0,#T1IE			;;
	BRA SLEEP_PRG3			;;
SLEEP_PRG1:
	MOV #SP_T2_K,W0			;;60MIN
	CP CLRTPMS_TIM			;;
	BRA GTU,SLEEP_PRG2		;;
	BCLR T1CON,#TON 		;;
	CLR TMR1			;;
	BCLR IFS0,#T1IF			;;
	MOVLF 512,PR1			;;1/128 SEC
	MOV #0x0032,W0			;;	
	MOV W0,T1CON			;;
	BSET T1CON,#TON 		;;
	BSET IEC0,#T1IE			;;
	BRA SLEEP_PRG3			;;
SLEEP_PRG2:
	BCLR T1CON,#TON 		;;
	CLR TMR1			;;
	BCLR IFS0,#T1IF			;;
	MOVLF 512,PR1			;;1/128 SEC
	MOV #0x0032,W0			;;	
	MOV W0,T1CON			;;
	BCLR T1CON,#TON 		;;
	BCLR IEC0,#T1IE			;;
SLEEP_PRG3:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
	PWRSAV #0			;;SLEEP mode;1=IDL 0=SLEEP
;;	PWRSAV #IDLE_MODE		;;	
	NOP				;;
	NOP				;;
;	BSET IEC1,#T4IE			;;
;	MOV #0x4000,W0			;;
;	IOR IPC6			;;ENI TIMER4 INTERRUPT
	CLRWDT				;;
	BSET RCON,#SWDTEN 		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_MAIN:				;;		
	CALL INIT_LCDLIM		;;
	CALL INIT_DYBMP			;;	
	CALL INIT_DPP			;;
	CALL INIT_DFF			;;
	MOVLF #0x781E,OFFSET_FXY	;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





SING_B531:
	LOFFS1 #B531_TBL
	MOVLF 1,SONG_AMT
	BRA SING_SONG
SING_BH1:
	BTSC FLAGE,#BATLL_F	;;
	RETURN
	LOFFS1 #BH1_TBL
	MOVLF 1,SONG_AMT
	BRA SING_SONG
SING_TPMSBB:
	LOFFS1 #B135_TBL
	MOVLF 1,SONG_AMT
	BRA SING_SONG

SING_TPMS:
	LOFFS1 #B135_TBL
	MOVLF 5,SONG_AMT
	BRA SING_SONG
SING_ALMED:
	LOFFS1 #B53X5_TBL
	MOVLF 1,SONG_AMT
	BRA SING_SONG
SING_BEEP:
	LOFFS1 #BH1_TBL
	MOVLF 1,SONG_AMT
	BRA SING_SONG



SING_NONE:
	BCLR FLAGA,#SONG_F	;;	
	RETURN


;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@








SING_SONG:
	BTSC FLAGE,#PDEMO_AUTO_F
	RETURN
	BSET FLAGD,#SONG_KP_STOP_F
SING_SONG1:
	TBLRDL [W1++],W0	;;
	MOV W0,SONG_BASET_KK
	MOV W1,SONG_POT
	MOV W1,SONG_POTB
	MOVLF 10,SONG_TIM
	MOVLF 9,SONG_CNT
	BSET FLAGA,#SONG_F
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_BATKEY:				;;	
	CALL BEEP_OFF			;;
	BCLR FLAGA,#SONG_F		;;
	BSET BKLCE,#BKLCE_P		;;
	BSET FLAGF,#BKLCE_F		;;
	CALL INIT_TPMSV			;;
	CALL OSC_M			;;
	CLR CLRTPMS_TIM			;;
	CALL TPMS_PRG			;;
	BRA TPMS_SP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_MAIN:				;;	
	CALL BEEP_OFF			;;
	BCLR FLAGA,#SONG_F		;;
	BSET BKLCE,#BKLCE_P		;;
	BSET FLAGF,#BKLCE_F		;;
	CALL OSC_H			;;
;	CALL TPMS_SHOW			;;
	MOV #120,W0			;;<<DEBUG 120                                                    
	MOV W0,TFT_ON_TIM		;;	
TPMS_MAIN1:				;;
	CALL BEEP_OFF			;;
	BCLR FLAGA,#SONG_F		;;
TPMS_MAIN2:				;;
	CALL INIT_TPMSV			;;
;	BSET BKLCE,#BKLCE_P		;;
;	BSET FLAGF,#BKLCE_F		;;
	CLR DLYBKL_TIM			;;
	CALL OSC_M			;;
	CLR CLRTPMS_TIM			;;
	CLR DISCN10S_TIM		;;
	CLR DISCN10S_CNT		;;
	BCLR FLAGF,#DISCN10S_F		;;
        MOV #0xFFCF,W0			;;
	MOV W0,AD1PCFG			;;
	CALL TPMS_PRG			;;
	CALL SAVE_FLASH_ALL		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_SP:				;;
	CALL BEEP_OFF			;;
	BCLR FLAGA,#SONG_F		;;
	BCLR FLAGD,#MENUP_F		;; 
	BSET FLAGD,#PULSP_F		;; 
	BCLR FLAGD,#MAINP_F		;; 
	BCLR BKLCE,#BKLCE_P		;;
	BCLR FLAGF,#BKLCE_F		;;
	CALL FLASH_SLEEP		;;
	CALL LCD_OFF			;;
	CALL OSC_L			;;
        MOV #0xFFDF,W0			;;
	MOV W0,AD1PCFG			;;
	MOV #1,W0			;;
	CALL DLYMX			;;
	BTSC VDET,#VDET_P		;;	
	BRA TPMS_SPV			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR CLRTPMS_TIM			;; 
	CLR SLEEP_WK_TIM		;;
	CLR SLEEP_WK_CNT		;;
	BCLR FLAGF,#DISCN10S_F		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_SP1:				;;
	MOV #SP_T1_K,W0			;;20MIN
	CP CLRTPMS_TIM			;;
	BRA LTU,TPMS_SP1A		;;
	MOV #7,W0			;;
	ADD CLRTPMS_TIM			;;
	ADD SLEEP_WK_TIM		;; 		
TPMS_SP1A:				;;
	INC SLEEP_WK_TIM		;;
	MOV #10,W0			;;
	CP SLEEP_WK_TIM			;;
	BRA LTU,$+4			;;
	CLR SLEEP_WK_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC CLRTPMS_TIM 		;;
	BTSC SR,#Z			;;
	DEC CLRTPMS_TIM 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	MOV #SP_T2_K,W0			;;60MIN
	CP CLRTPMS_TIM			;;
	BRA NZ,TPMS_SP1B		;;
	CALL CLR_TPMS_FLAG		;;
TPMS_SP1B:				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC VDET,#VDET_P		;;	
	BRA TPMS_SPV			;;
	BTSS PORTB,#10			;;
	BRA TPMS_SPK			;;
	CALL SLEEP_PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGG,#INT2_MF		;;
	BRA TPMS_SPV			;;
	BTSC FLAGF,#INT1_MF		;;
	BRA TPMS_SPK			;;
	BTSS FLAGF,#CNCHG_MF		;;	
	BRA TPMS_SP1Z			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #SP_T1_K,W0			;;
	CP CLRTPMS_TIM			;;
	BRA GTU,TPMS_SP1C		;;
	BSET FLAGF,#DISCN10S_F		;;
	CLR DISCN10S_TIM 		;;
	INC DISCN10S_CNT		;;
	MOV #3,W0			;;
	CP DISCN10S_CNT			;;
	BRA LTU,TPMS_SP1Z		;;
	CLR DISCN10S_CNT		;; 
	MOV #SP_T0_K,W0			;;
	MOV W0,CLRTPMS_TIM		;;
	BRA TPMS_SP1Z			;;
TPMS_SP1C:				;;
	MOV #10,W0			;;
	CALL DLYMX			;;
	CLR SLEEP_WK_TIM		;;
	INC SLEEP_WK_CNT		;;
	MOV #2,W0			;;
	CP SLEEP_WK_CNT			;;
	BRA LTU,TPMS_SP1Z		;;
 	CLR CLRTPMS_TIM			;;
	CLR SLEEP_WK_CNT		;;

	CALL PULSP_ESC			;;
	BSET FLAGB,#DISKR_F		;;
	BSET FLAGB,#DISKK_F		;;
	BRA TPMS_MAIN 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_SP1Z:				;;
	MOV #SP_T1_K,W0			;;
	CP CLRTPMS_TIM			;;
	BRA GTU,TPMS_SP1		;;
	BCLR MRXE,#MRXE_P		;;
	BSET FLAGB,#CLRRF_F		;;	
TPMS_SP2:				;;
	CLRWDT				;;
	CALL TPUSRX			;;
	BSET MRXE,#MRXE_P		;;
	MOV #0xA010,W0			;;
	MOV W0,T2CON			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGE,#TRXIN_F		;;
	BRA TPMS_SP1			;;
	BCLR FLAGE,#TRXIN_F		;;
	CALL TPMS_RFIN			;;
	BTSS SR,#Z			;;
	BRA TPMS_SP1Z			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB3,W0			;;
	MOV W0,TPMSI_CNT		;;	
	CALL CHK_TPMS_ALM		;;
	BTSS FLAGF,#CTA_F		;;
	BRA TPMS_SP1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #60,W0			;;                                                    
	MOV W0,TFT_ON_TIM		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL PULSP_ESC			;;
	BSET FLAGB,#DISKR_F		;;
	BSET FLAGB,#DISKK_F		;;
	BRA TPMS_MAIN1 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_SPK:				;;
	MOV #20,W0			;;                                                    
	MOV W0,TFT_ON_TIM		;;	
	CALL PULSP_ESC			;;
	BSET FLAGB,#DISKR_F		;;
	BSET FLAGB,#DISKK_F		;;
	CALL SING_BEEP			;; 
	BRA TPMS_MAIN2 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPMS_SPV:				;;
	MOV #20,W0			;;                                                    
	MOV W0,TFT_ON_TIM		;;	
	CALL PULSP_ESC			;;
	BSET FLAGB,#DISKR_F		;;
	BSET FLAGB,#DISKK_F		;;
	CALL SING_BEEP			;; 
	BRA TPMS_MAIN2 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




FNT_COLOR_TBL:
	.WORD 0xFFFF		;;WHITE
	.WORD 0x001F		;;GREEN
	.WORD 0xF81F		;;
	.WORD 0xF800		;;RED
	.WORD 0x07FF		;;
	.WORD 0xFFFF
	.WORD 0xFFFF
	.WORD 0xFFFF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_FNT24:			;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH R2			;;
	PUSH R3			;; 
	MOV BMPY,W0		;;
	MOV W0,R1		;;
DISP_FNT240:			;;
	BCLR FLAGA,#GOTOXY_F	;;
	MOV BMPX,W0		;;
	MOV W0,R0		;;
DISP_FNT24A:			;;		
	MOV W0,SPI1BUF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;	
	CP LCDX			;;
	BRA LT,DISP_FNT24D0	;;
	MOV LCDX_LIM1,W0	;;
	CP LCDX			;;
	BRA GT,DISP_FNT24D0	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_FNT24A0:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_FNT24A0	;;
	MOV SPI1BUF,W0		;;
	MOV W0,SPI1BUF		;;
	MOV W0,R2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0	;;	
	CP LCDY			;;
	BRA LT,DISP_FNT24D1	;;
	MOV LCDY_LIM1,W0	;;
	CP LCDY			;;
	BRA GT,DISP_FNT24D1	;;
DISP_FNT24A1:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_FNT24A1	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPI1BUF,W0		;;
	MOV W0,R3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS0 FNT_COLOR_TBL	;;
	ADD FCOLOR,WREG		;;
	ADD FCOLOR,WREG		;;
	TBLRDL [W0++],W0	;;
	AND R2			;;	
	SWAP W0			;;
	AND R3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGA,#GOTOXY_F	;;
	BRA DISP_FNT24B		;;
	BSET FLAGA,#GOTOXY_F	;;
	CALL GOTOXY		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  .IFDEF NEWLCD_K		;;
	BCLR LCDCS,#LCDCS_P	;;
	BCLR LCDRS,#LCDRS_P	;;
	MOV #0x2C,W0            ;;	
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
  .ENDIF			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	BSET LCDRS,#LCDRS_P	;;
	BCLR LCDCS,#LCDCS_P	;;
DISP_FNT24B:			;;
	MOV R2,W0		;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	MOV R3,W0		;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	BRA DISP_FNT24E		;;
DISP_FNT24D0:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_FNT24D0	;;
	MOV SPI1BUF,W0		;;
	MOV W0,SPI1BUF		;;
DISP_FNT24D1:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_FNT24D1	;;
	MOV SPI1BUF,W0		;;
	BCLR FLAGA,#GOTOXY_F	;;	
	BSET LCDCS,#LCDCS_P	;;
DISP_FNT24E:			;;
	INC LCDX		;;
	DEC R0			;;
	BRA NZ,DISP_FNT24A	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDCS,#LCDCS_P	;;
	MOV BMPX,W0		;;
	SUB LCDX		;;
	INC LCDY		;;
	DEC R1			;;
	BRA NZ,DISP_FNT240	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPY,W0
	SUB LCDY		;;	
	BSET FCS,#FCS_P		;;
	POP R3			;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_BMP24:			;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH R2			;;
	PUSH R3			;; 
	MOV BMPY,W0		;;
	MOV W0,R1		;;
DISP_BMP240:			;;
	BCLR FLAGA,#GOTOXY_F	;;
	MOV BMPX,W0		;;
	MOV W0,R0		;;
DISP_BMP24A:			;;		
	MOV W0,SPI1BUF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;	
	CP LCDX			;;
	BRA LT,DISP_BMP24D0	;;
	MOV LCDX_LIM1,W0	;;
	CP LCDX			;;
	BRA GT,DISP_BMP24D0	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_BMP24A0:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_BMP24A0	;;
	MOV SPI1BUF,W0		;;
	MOV W0,SPI1BUF		;;
	MOV W0,R2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0	;;	
	CP LCDY			;;
	BRA LT,DISP_BMP24D1	;;
	MOV LCDY_LIM1,W0	;;
	CP LCDY			;;
	BRA GT,DISP_BMP24D1	;;
DISP_BMP24A1:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_BMP24A1	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SPI1BUF,W0		;;
	MOV W0,R3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGA,#GOTOXY_F	;;
	BRA DISP_BMP24B		;;
	BSET FLAGA,#GOTOXY_F	;;
	CALL GOTOXY		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  .IFDEF NEWLCD_K		;;
	BCLR LCDCS,#LCDCS_P	;;
	BCLR LCDRS,#LCDRS_P	;;
	MOV #0x2C,W0            ;;	
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
  .ENDIF			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	BSET LCDRS,#LCDRS_P	;;
	BCLR LCDCS,#LCDCS_P	;;
DISP_BMP24B:			;;
	MOV R2,W0		;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	MOV R3,W0		;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	BRA DISP_BMP24E		;;
DISP_BMP24D0:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_BMP24D0	;;
	MOV SPI1BUF,W0		;;
	MOV W0,SPI1BUF		;;
DISP_BMP24D1:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_BMP24D1	;;
	MOV SPI1BUF,W0		;;
	BCLR FLAGA,#GOTOXY_F	;;	
	BSET LCDCS,#LCDCS_P	;;
DISP_BMP24E:			;;
	INC LCDX		;;
	DEC R0			;;
	BRA NZ,DISP_BMP24A	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDCS,#LCDCS_P	;;
	MOV BMPX,W0		;;
	SUB LCDX		;;
	INC LCDY		;;
	DEC R1			;;
	BRA NZ,DISP_BMP240	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPY,W0		;;
	SUB LCDY		;;	
	BSET FCS,#FCS_P		;;
	POP R3			;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_BMP8:			;;
	BCLR FLAGC,#ESCAPE_BMP8_F;; 
	PUSH R0			;;
	PUSH R1			;;
	PUSH R2			;;
	MOV BMPY,W0		;;
	MOV W0,R1		;;
DISP_BMP80:			;;
	BCLR FLAGA,#GOTOXY_F	;;
	MOV BMPX,W0		;;
	MOV W0,R0		;;
DISP_BMP8A:			;;		
	MOV W0,SPI1BUF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;	
	CP LCDX			;;
	BRA LT,DISP_BMP8D0	;;
	MOV LCDX_LIM1,W0	;;
	CP LCDX			;;
	BRA GT,DISP_BMP8D0	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0	;;	
	CP LCDY			;;
	BRA NC,DISP_BMP8D0	;;
	MOV LCDY_LIM1,W0	;;
	CP LCDY			;;
	BRA GT,DISP_BMP8D0	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_BMP8A0:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_BMP8A0		;;
	MOV SPI1BUF,W0		;;
	MOV W0,R2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGA,#GOTOXY_F	;;
	BRA DISP_BMP8B		;;
	BSET FLAGA,#GOTOXY_F	;;
	CALL GOTOXY		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  .IFDEF NEWLCD_K		;;
	BCLR LCDCS,#LCDCS_P	;;
	BCLR LCDRS,#LCDRS_P	;;
	MOV #0x2C,W0            ;;	
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
  .ENDIF			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	BSET LCDRS,#LCDRS_P	;;
	BCLR LCDCS,#LCDCS_P	;;
DISP_BMP8B:			;;
	MOV R2,W0		;;
	AND #255,W0		;;
	MOV #BMPC,W2		;;
	ADD W0,W2,W2		;;
	ADD W0,W2,W2		;;
	MOV [W2],W0		;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	MOV [W2],W0		;;
	SWAP W0			;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	BRA DISP_BMP8E		;;
DISP_BMP8D0:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_BMP8D0		;;
	MOV SPI1BUF,W0		;;
	BCLR FLAGA,#GOTOXY_F	;;	
	BSET LCDCS,#LCDCS_P	;;
DISP_BMP8E:			;;
	INC LCDX		;;
	DEC R0			;;
	BRA NZ,DISP_BMP8A	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDCS,#LCDCS_P	;;
DISP_BMP8F:			;;
	MOV BMPX,W0		;;
	SUB LCDX		;;
	INC LCDY		;;
	DEC R1			;;
	BRA NZ,DISP_BMP80	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPY,W0		;;
	SUB LCDY		;;	
DISP_BMP8G:			;;
	BSET FCS,#FCS_P		;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PUNIT:			;;
	BTSC TPMS_PUNIT_SET,#1	;;
	BRA TRANS_PUNIT1	;;	
	BTSS TPMS_PUNIT_SET,#0	;;
	BRA TRANS_PUNIT_PSI	;;
	BRA TRANS_PUNIT_KPA	;;
TRANS_PUNIT1:			;;
	BTSS TPMS_PUNIT_SET,#0	;;
	BRA TRANS_PUNIT_BAR	;;
	BRA TRANS_PUNIT_KGCM	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PUNIT_PSI:		;;
	MOVLF #'P',R2		;;
	MOVLF #'S',R1		;;
	MOVLF #'I',R0		;;
	BCLR SR,#C		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PUNIT_KPA:		;;
	MOVLF #'K',R2		;;
	MOVLF #'P',R1		;;
	MOVLF #'A',R0		;;
	BCLR SR,#C		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PUNIT_BAR:		;;
	MOVLF #'B',R2		;;
	MOVLF #'A',R1		;;
	MOVLF #'R',R0		;;
	BCLR SR,#C		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_PUNIT_KGCM:		;;
	MOVLF #'K',R2		;;
	MOVLF #'G',R1		;;
	MOVLF #'/',R0		;;
	MOVLF #'C',R2		;;
	MOVLF #'M',R1		;;
	BSET SR,#C		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TUNIT:			;;
	BTSS TPMS_TUNIT_SET,#0	;;
	BRA TRANS_TUNIT_DC	;;
	BRA TRANS_TUNIT_DF	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TUNIT_DC:			;;
	MOVLF #8,R1		;;
	MOVLF #'C',R0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_TUNIT_DF:			;;
	MOVLF #8,R1		;;
	MOVLF #'F',R0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PULSP_ESC:				;;
	CALL LCD_ON			;;
	CALL FLASH_RESET		;;
	CALL OSC_M			;;
	BSET IEC1,#T4IE			;;
	CLR SLEEP_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BKLCE_PRG:
	BTSS FLAGE,#BATLL_F
	BRA BKLCE_PRG1
        BTSC FLAGA,#MTXE_F      ;;  
	BRA BKLCE_PRG0
	BTSS FLAGA,#SONG_F		;;
	BRA BKLCE_PRG1
BKLCE_PRG0:
	BCLR BKLCE,#BKLCE_P 
	RETURN
BKLCE_PRG1:
	BTSC FLAGF,#BKLCE_F
	BSET BKLCE,#BKLCE_P 
	BTSS FLAGF,#BKLCE_F
	BCLR BKLCE,#BKLCE_P 
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_OPPOF:				;;
;	BCLR FLAGE,#OPPOF_F		;;
;	CP0 TABLE_SET			;;
;	BRA NZ,$+4			;;
;	RETURN				;;
;	MOV #3,W0			;;
;	CP TABLE_SET			;;	
;	BRA NZ,$+4			;;
;	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 	BSET FLAGE,#OPPOF_F		;;
;	BCLR FLAGE,#OPPOF_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_OSC8M:				;;
	BTSC FLAGC,#OSC8M_F		;;
	RETURN 				;;
	MOV OC5R,W0			;;OC5=FFFF BEEP OFF
	INC W0,W0			;;
	BTSC SR,#Z     			;;
	CALL OSC_M			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_OSC32M:				;;
	BTSS FLAGC,#OSC8M_F		;;
	RETURN 				;;
	MOV OC5R,W0			;;OC5=FFFF BEEP OFF
	INC W0,W0			;;
	BTSC SR,#Z     			;;
	CALL OSC_H			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BUF0 FLAG			;;
;BUF2 COUNTRY,DATA(NEW)		;;
;BUF3 COUNTRY,DATA(OLD)		;;
;BUF1 XY			;;
;BUF4 COLOR_F			;;
;BUF5 COLOR_B 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DFF:				;;
	BCLR FLAGA,#ICONP_F	;;
	INC DFF_CNT		;;
	MOV #30,W0		;;
	CP DFF_CNT		;;
	BRA LTU,$+4		;;
	CLR DFF_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #12,W0		;;
	MUL DFF_CNT		;;
	MOV #DFFBUF,W0		;;
	ADD W0,W2,W2		;;
	BTST.C [W2],#0		;;PRESENT BIT
	BRA C,$+4		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,DPPB1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOV [W2++],W0		;;
	MOV W0,DPPB2		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2],W0		;;
	AND #255,W0		;;
	MOV W0,LCDX		;;
	MOV [W2++],W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	MOV W0,LCDY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,COLOR_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2++],W0		;;
	MOV W0,COLOR_B		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC DPPB0,#1		;;FORCE BIT
	BRA DFF1		;;
	MOV DPPB1,W0		;;	
	XOR DPPB2,WREG		;;
	BRA NZ,$+4		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DFF1:				;;
	MOV DPPB1,W0		;;
	MOV W0,DPPB2		;;
	SWAP W0			;;
	AND #255,W0		;;
	MOV W0,FONT_TYP		;;
	MOV DPPB1,W0		;;
	BTSC DPPB0,#2		;;
	BSET FLAGA,#THF_F	;;	 
	CALL ENCHR		;;
	BCLR FLAGA,#THF_F	;;	 
	MOV #12,W0		;;
	MUL DFF_CNT		;;
	MOV #DFFBUF,W0		;;
	ADD W0,W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB0,W0		;;
	MOV W0,[W2++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W2,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPB2,W0		;;
	MOV W0,[W2]		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TMR_TPMS:				;;
	BTSS TMR2_FLAG,#T8M_F		;;
	RETURN				;;
	INC DETBAT_TIM			;; 
	INC DETPOW_TIM			;; 
	INC DLYBKL_TIM			;;
	MOV #10,W0			;;
	CP DLYBKL_TIM			;;
	BRA LTU,TMR_TPMS0		;;
	BSET BKLCE,#BKLCE_P		;;
	BSET FLAGF,#BKLCE_F		;;
TMR_TPMS0:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC FLASH_TIM			;;	
	MOV #80,W0			;;
	CP FLASH_TIM			;;
	BRA LTU,$+6			;;
	BTG FLAGF,#FLASH_F		;;
	CLR FLASH_TIM			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC RFPUS_TIM			;;
	INC SLEEP_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC TXRF_CNT			;;CHK TXRF AFTER TIME
	MOV #80,W0			;;
	CP TXRF_CNT			;;
	BRA LTU,$+6			;;
	BCLR FLAGB,#TXRF_F		;;
	SETM ACTION_KEY 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC CLRRF_CNT			;;CHK FREE_KEY
	MOV #30,W0			;;
	CP CLRRF_CNT			;;
	BRA LTU,$+4			;;
	BSET FLAGB,#CLRRF_F 		;;
	INC TCLRRF_CNT			;;CHK FREE_KEY
	MOV #30,W0			;;
	CP TCLRRF_CNT			;;
	BRA LTU,$+4			;;
	BSET FLAGE,#TCLRRF_F 		;;
	BRA LTU,$+4			;;
	CLR DEERR_BUF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGD,#DISPCF_F		;;
	CLR MENU_ESC_TIM		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC DISPCF_TIM			;;
	MOV #1200,W0			;;
	CP DISPCF_TIM			;;
	BTSC SR,#C 			;;
	BCLR FLAGD,#DISPCF_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP0 WAIT_TIME_CNT		;;
	BRA Z,$+4			;;
	DEC WAIT_TIME_CNT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGE,#TPMS_ALMBBB_F	;;	
	BRA TMR_TPMS1			;;
	INC TPMS_ALMBB_TIM		;;
	MOV #800,W0			;;
	CP TPMS_ALMBB_TIM		;;
	BRA LTU,TMR_TPMS1		;;
	CLR TPMS_ALMBB_TIM		;;
	CALL SING_TPMSBB		;;
	INC TPMS_ALMBB_CNT		;;
	MOV #10,W0			;;
	CP TPMS_ALMBB_CNT		;;
	BRA LTU,TMR_TPMS1 		;;
	BCLR FLAGE,#TPMS_ALMBBB_F	;;	
TMR_TPMS1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




SWAP_OSC:
	INC OSC_CNT
	MOV #3,W0
	CP OSC_CNT
	BRA LTU,$+4
	CLR OSC_CNT
	BTSS OSC_CNT,#1
	BRA OSC_H

	BTSS FLAGA,#OSCL_F
	BRA SWAP_OSCFRC
SWAP_OSCPLL: 
	CALL OSC_FRCPLL
	RETURN
SWAP_OSCFRC:
	CALL OSC_FRC
	RETURN	






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MENU_SET:				;;
	CLR DPPSET_CNT			;;
	LOFFS1 #MENU_SET_TBL 		;;
CHK_MENU_SET0:				;;
	TBLRDL [W1++],W0		;;
	TBLRDL [W1++],W2		;;
	CP0 W0				;;
	BRA Z,CHK_MENU_SET1		;;
	CP MENU_ADR			;;
	BRA NZ,CHK_MENU_SET0		;;
	MOV [W2],W0			;;
	INC W0,W0			;;
	MOV W0,DPPSET_CNT		;;	
CHK_MENU_SET1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DPPSEL:				;;
	MOV DPPSEL_PRE,W0	;;	
	CP DPPSEL_CNT		;;
	BRA NZ,$+4		;;
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL DIS_ALLSEL		;;
	DEC DPPSEL_CNT,WREG	;;
	CALL SET_DPPSEL		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL C_BKBK		;;
	MOV DPPSEL_PRE,W0	;;
	CALL DRAW_DPPSEL	;;
	CALL C_BLBL		;; 
	CALL CHK_MENU_IS_ENTRY	;;
	BRA NZ,$+4		;;
	CALL C_YLYL		;; 
	CALL CHK_MENU_IS_DISABLE;;
	BRA NZ,$+4		;;
	CALL C_WTWT		;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPSEL_CNT,W0	;;
	MOV W0,DPPSEL_PRE	;;	
	CALL DRAW_DPPSEL	;;
	CLR DPPSET_PRE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SELSTR		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TMR_MAIN:				;;
	BTSS TMR2_FLAG,#T8M_F		;;
	RETURN				;;
	INC DETBAT_TIM			;;
	INC DETPOW_TIM			;;
	INC RFPUS_TIM			;;
	INC SLEEP_CNT			;;
	INC SLEEP_WAIT			;;
	BTSC SR,#Z			;;
	DEC SLEEP_WAIT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC WAITOSC8M_TIM		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC TXRF_CNT			;;CHK TXRF AFTER TIME
	MOV #80,W0			;;
	CP TXRF_CNT			;;
	BRA LTU,$+6			;;
	BCLR FLAGB,#TXRF_F		;;
	SETM ACTION_KEY 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC CLRRF_CNT			;;CHK FREE_KEY
	MOV #30,W0			;;
	CP CLRRF_CNT			;;
	BRA LTU,$+4			;;
	BSET FLAGB,#CLRRF_F 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC TCLRRF_CNT			;;CHK FREE_KEY
	MOV #30,W0			;;
	CP TCLRRF_CNT			;;
	BRA LTU,$+4			;;
	BSET FLAGE,#TCLRRF_F 		;;
	BRA LTU,$+4			;;
	CLR DEERR_BUF        		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP0 WAIT_TIME_CNT		;;
	BRA Z,$+4			;;
	DEC WAIT_TIME_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MENU_BUT_A_STR:
	.ASCII "ENT   -->   ESC\0"
MENU_BUT_B_STR:
	.ASCII " +     -    ESC\0"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_START:				;;
	BSET FLAGB,#DISKR_F		;;
	BSET BKLCE,#BKLCE_P		;;
	BSET FLAGF,#BKLCE_F		;;
;;	LOFFS1 #MENU_X			;;
	LOFFS1 #MENU_IH			;;
	MOV W1,MENU_ADR			;;
	CLR DPPSEL_CNT			;;
	INC DPPSEL_CNT			;;
	CLR MENU_STK_CNT		;;
	BCLR FLAGE,#EDITED_F		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_PRG:				;;		
	BTSS FLAGE,#BATLL_F		;;
	CALL OSC_H			;;
	BTSC FLAGE,#BATLL_F		;;
	CALL OSC_M			;;
	CALL INIT_LCDLIM		;;
	CLR MENU_ESC_TIM		;;
	BSET FLAGD,#MENUP_F		;;
	BCLR FLAGD,#MAINP_F		;; 
	BCLR FLAGD,#PULSP_F		;; 
	CALL DARKSCR			;;
	CALL INIT_DPP			;;
	CALL INIT_DFF			;;
	CLR DPPSEL_PRE 			;;
	CALL LOAD_MENU_SET		;;
	CALL CHK_MENU_SET		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MENU_ADR,W1			;;
	TBLRDL [W1++],W0		;;
	MOV W0,MENU_AMT			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0		;;
	MOV W0,MENU_KADR		;;			;;	
	CLR R0				;;
MENU_LOAD:				;;
	PUSH W1				;;
	TBLRDL [W1],W1			;;
	MOV R0,W0			;;
	CALL MENU_ICON_XY		;;
	CALL LOAD_DPP			;;	
	POP W1				;;
	ADD W1,#8,W1			;;
	INC R0				;;
	MOV MENU_AMT,W0			;;
	CP R0				;;
	BRA NC,MENU_LOAD		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MENU_ADR,W0			;;
MENU_LOAD3A:				;;
	LOFFS1 MENU_IHAA		;;
	CP W0,W1			;;
	BRA Z,MENU_LOAD3AA		;;
	LOFFS1 MENU_IHBA		;;
	CP W0,W1			;;
	BRA NZ,MENU_LOAD3B		;;
MENU_LOAD3AA:				;;
	LOFFS1 TP_PSI_TBL		;;
	MOVLF 80,LCDX			;;
	MOVLF 74,LCDY			;;
	MOV TPMS_PUNIT_SET,W0		;; 
 	CALL LOAD_DPPX			;;
	CALL INIT_TPMSV			;;
	LDPTR MENU_BUT_B_STR		;;
	CALL C_YLBK			;;				
	LXY 4,144			;;
	CALL ENSTR			;;
	BRA MENU_LOAD5			;;
MENU_LOAD3B:				;;
	LOFFS1 MENU_IHAB		;;
	CP W0,W1			;;
	BRA Z,MENU_LOAD3BA		;;
	LOFFS1 MENU_IHBB		;;
	CP W0,W1			;;
	BRA NZ,MENU_LOAD3C		;;
MENU_LOAD3BA:				;;
	LOFFS1 TP_PSI_TBL		;;
	MOVLF 80,LCDX			;;
	MOVLF 74,LCDY			;;
	MOV TPMS_PUNIT_SET,W0		;; 
 	CALL LOAD_DPPX			;;
	CALL INIT_TPMSV			;;
	CALL C_YLBK			;;				
	LDPTR MENU_BUT_B_STR		;;
	LXY 4,144			;;
	CALL ENSTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BRA MENU_LOAD5			;;
MENU_LOAD3C:				;;
	LOFFS1 MENU_IHAC		;;
	CP W0,W1			;;
	BRA Z,MENU_LOAD3CA		;;
	LOFFS1 MENU_IHBC		;;
	CP W0,W1			;;
	BRA NZ,MENU_LOAD4		;;
MENU_LOAD3CA:				;;
	LOFFS1 TP_PSI_TBL		;;
	MOVLF 80,LCDX			;;
	MOVLF 74,LCDY			;;
	MOV TPMS_TUNIT_SET,W0		;; 
	ADD #4,W0			;;
 	CALL LOAD_DPPX			;;
	CALL INIT_TPMSV			;;
	CALL C_YLBK			;;				
	LDPTR MENU_BUT_B_STR		;;
	LXY 4,144			;;
	CALL ENSTR			;;
	BRA MENU_LOAD5			;;
MENU_LOAD4:				;;
	CALL C_YLBK			;;				
	LDPTR MENU_BUT_A_STR		;;
	LXY 4,144			;;
	CALL ENSTR			;;
MENU_LOAD5:				;;
	CALL C_WTBK			;;				
MENU_LOOP:				;;
	CALL BKLCE_PRG			;;
	BTSC FLAGE,#BATLL_F		;;
	BRA MENU_LOOP00			;;
        BTSS FLAGA,#MTXE_F  		;;  
	CALL CHK_OSC32M			;;
	BTSS FLAGA,#SONG_F		;;
	CALL CHK_OSC32M			;;
MENU_LOOP00:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;
	CALL TMR_MAIN			;;
MENU_LOOP1:				;;
	CLR DRAW_ACTION_CNT		;;
	MOV MENU_ADR,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IHAA		;;
	CP W0,W1			;;
	BRA Z,MENU_LOOP2A1		;;
	LOFFS1 MENU_IHBA		;;
	CP W0,W1			;;
	BRA Z,MENU_LOOP2A2		;;
	LOFFS1 MENU_IHAB		;;
	CP W0,W1			;;
	BRA Z,MENU_LOOP2B1		;;
	LOFFS1 MENU_IHBB		;;
	CP W0,W1			;;
	BRA Z,MENU_LOOP2B2		;;
	LOFFS1 MENU_IHAC		;;
	CP W0,W1			;;
	BRA Z,MENU_LOOP2C1		;;
	LOFFS1 MENU_IHBC		;;
	CP W0,W1			;;
	BRA Z,MENU_LOOP2C2		;;
	BRA MENU_LOOP3			;;
MENU_LOOP2A1:				;;
	BSET FLAGD,#TPMSSET_F		;;
	BCLR FLAGD,#DISPCF_F		;; 
	MOV TPMS_LOP_SETA,W0		;;
	MOV W0,TPMSSET_BUF		;; 
	CALL TRANS_TPMS_SET		;;
	BCLR FLAGF,#DISP_W5_F		;; 
	CALL DISP_TPMSV			;;
	BRA MENU_LOOP3			;;
MENU_LOOP2A2:				;;
	BSET FLAGD,#TPMSSET_F		;;
	BCLR FLAGD,#DISPCF_F		;; 
	MOV TPMS_LOP_SETB,W0		;;
	MOV W0,TPMSSET_BUF		;; 
	CALL TRANS_TPMS_SET		;;
	BCLR FLAGF,#DISP_W5_F		;; 
	CALL DISP_TPMSV			;;
	BRA MENU_LOOP3			;;
MENU_LOOP2B1:				;;
	BSET FLAGD,#TPMSSET_F		;;
	BCLR FLAGD,#DISPCF_F		;; 
	MOV TPMS_HIP_SETA,W0		;;
	MOV W0,TPMSSET_BUF		;; 
	CALL TRANS_TPMS_SET		;;
	BCLR FLAGF,#DISP_W5_F		;; 
	CALL DISP_TPMSV			;;
	BRA MENU_LOOP3			;;
MENU_LOOP2B2:				;;
	BSET FLAGD,#TPMSSET_F		;;
	BCLR FLAGD,#DISPCF_F		;; 
	MOV TPMS_HIP_SETB,W0		;;
	MOV W0,TPMSSET_BUF		;; 
	CALL TRANS_TPMS_SET		;;
	BCLR FLAGF,#DISP_W5_F		;; 
	CALL DISP_TPMSV			;;
	BRA MENU_LOOP3			;;
MENU_LOOP2C1:				;;
	BSET FLAGD,#TPMSSET_F		;;
	BSET FLAGD,#DISPCF_F		;; 
	MOV TPMS_HIT_SETA,W0		;;
	MOV W0,TPMSSET_BUF		;; 
	CALL TRANS_TPMS_SET		;;
	BCLR FLAGF,#DISP_W5_F		;; 
	CALL DISP_TPMSV			;;
	BRA MENU_LOOP3			;;
MENU_LOOP2C2:				;;
	BSET FLAGD,#TPMSSET_F		;;
	BSET FLAGD,#DISPCF_F		;; 
	MOV TPMS_HIT_SETB,W0		;;
	MOV W0,TPMSSET_BUF		;; 
	CALL TRANS_TPMS_SET		;;
	BCLR FLAGF,#DISP_W5_F		;; 
	CALL DISP_TPMSV			;;
	BRA MENU_LOOP3			;;
MENU_LOOP3:				;;
	CALL DFF			;;
	CALL DPP			;;
	CALL DPPSEL			;;
	CALL DPPSET			;;
	CALL KEYBO			;;
	MOV MENU_KADR,W0		;;
	CALL W0				;;
	BTSS FLAGB,#NOKEY_F		;;
	CLR MENU_ESC_TIM		;;
 	BTSC TMR2_FLAG,#T512M_F		;;
	INC MENU_ESC_TIM		;;
	MOV #30,W0			;;
	CP MENU_ESC_TIM			;;
	BRA LTU,MENU_LOOP		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_KEY:				;;
	BTSC KEY_FLAG0,#KP0_F		;;
	BRA MENU_KP0			;;
	BTSC KEY_FLAG0,#KR0_F		;;
	BRA MENU_INCSEL			;;
	BTSC KEY_FLAG0,#KD0_F		;;
	BRA MENU_ENTRY			;;
	BTSC KEY_FLAG1,#KCS0_F		;;
	BRA MENU_DECSEL			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC KEY_FLAG0,#KR2_F		;;
	BRA MENU_ESC			;;
	BTSC KEY_FLAG1,#KCS2_F		;;
	BRA MENU_ESC1			;;
	BTSC KEY_FLAG0,#KP1_F		;;
	BRA MENU_ENTRY			;;
	BTSC KEY_FLAG1,#KCS1_F		;;
	BRA MENU_ENTRY			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_DECSEL:			;;
	MOV MENU_ADR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IHAA	;;
	CP W0,W1		;;
	BRA Z,MENU_IHAA_DECV	;;
	LOFFS1 MENU_IHBA	;;
	CP W0,W1		;;
	BRA Z,MENU_IHBA_DECV	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IHAB	;;
	CP W0,W1		;;
	BRA Z,MENU_IHAB_DECV	;;
	LOFFS1 MENU_IHBB	;;
	CP W0,W1		;;
	BRA Z,MENU_IHBB_DECV	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IHAC	;;
	CP W0,W1		;;
	BRA Z,MENU_IHAC_DECV	;;
	LOFFS1 MENU_IHBC	;;
	CP W0,W1		;;
	BRA Z,MENU_IHBC_DECV	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF #200,CONKEY_CNT	;;
	DEC DPPSEL_CNT		;;
	BTSS SR,#Z		;;
	RETURN			;;				
	MOV MENU_AMT,W0		;;
	MOV W0,DPPSEL_CNT	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_KP0:			;;
	MOV MENU_ADR,W0		;;
	LOFFS1 MENU_IHAA	;;
	CP W0,W1		;;
	BRA Z,MENU_IHAA_DECV	;;
	LOFFS1 MENU_IHBA	;;
	CP W0,W1		;;
	BRA Z,MENU_IHBA_DECV	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IHAB	;;
	CP W0,W1		;;
	BRA Z,MENU_IHAB_DECV	;;
	LOFFS1 MENU_IHBB	;;
	CP W0,W1		;;
	BRA Z,MENU_IHBB_DECV	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IHAC	;;
	CP W0,W1		;;
	BRA Z,MENU_IHAC_DECV	;;
	LOFFS1 MENU_IHBC	;;
	CP W0,W1		;;
	BRA Z,MENU_IHBC_DECV	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHAA_DECV:			;;	
	CALL CONKEY_SET0P	;;	
	BSET FLAGE,#EDITED_F	;;	
	DEC TPMS_LOP_SETA	;;	
	MOV #150,W0		;;
	BTSC TPMS_LOP_SETA,#15	;;
	MOV W0,TPMS_LOP_SETA	;;
	RETURN			;;
MENU_IHBA_DECV:			;;	
	CALL CONKEY_SET0P	;;	
	BSET FLAGE,#EDITED_F	;;	
	DEC TPMS_LOP_SETB	;;	
	MOV #150,W0		;;
	BTSC TPMS_LOP_SETB,#15	;;
	MOV W0,TPMS_LOP_SETB	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHAB_DECV:			;;	
	CALL CONKEY_SET0P	;;	
	BSET FLAGE,#EDITED_F	;;	
	DEC TPMS_HIP_SETA	;;	
	MOV #10,W0		;;
	CP TPMS_HIP_SETA	;;	
	BRA LTU,$+4		;;
	RETURN			;;
	MOV #200,W0		;;
	MOV W0,TPMS_HIP_SETA	;;
	RETURN			;;
MENU_IHBB_DECV:			;;	
	CALL CONKEY_SET0P	;;	
	BSET FLAGE,#EDITED_F	;;	
	DEC TPMS_HIP_SETB	;;	
	MOV #10,W0		;;
	CP TPMS_HIP_SETB	;;	
	BRA LTU,$+4		;;
	RETURN			;;
	MOV #200,W0		;;
	MOV W0,TPMS_HIP_SETB	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHAC_DECV:			;;	
	CALL CONKEY_SET0P	;;	
	BSET FLAGE,#EDITED_F	;;	
	DEC TPMS_HIT_SETA	;;	
	MOV #40,W0		;;
	CP TPMS_HIT_SETA	;;	
	BRA LTU,$+4		;;
	RETURN			;;
	MOV #160,W0		;;
	MOV W0,TPMS_HIT_SETA	;;
	RETURN			;;
MENU_IHBC_DECV:			;;	
	CALL CONKEY_SET0P	;;	
	BSET FLAGE,#EDITED_F	;;	
	DEC TPMS_HIT_SETB	;;	
	MOV #40,W0		;;
	CP TPMS_HIT_SETB	;;	
	BRA LTU,$+4		;;
	RETURN			;;
	MOV #160,W0		;;
	MOV W0,TPMS_HIT_SETB	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_INCSEL:			;;
	INC DPPSEL_CNT		;;
	INC MENU_AMT,WREG	;;
	CP DPPSEL_CNT		;;
	BRA NC,$+6		;;
	CLR DPPSEL_CNT		;;
	INC DPPSEL_CNT		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_ESC:			;;
	CP0 MENU_STK_CNT	;;	
	BRA NZ,$+4		;;
	BRA MENU_ESC1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SING_NONE		;;
	CALL POP_MENU		;;
	POP W0			;;
	POP W0			;;
	BRA MENU_PRG		;;
MENU_ESC1:			;;
	POP W0			;;
	POP W0			;;
	CALL SAVE_FLASH_ALL	;;	
	RETURN 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_FLASH_ALL:			;;
	MOV WID00,W0		;;
	ADD WID01,WREG		;;
	ADD WID02,WREG		;;
	ADD WID10,WREG		;;
	ADD WID11,WREG		;;
	ADD WID12,WREG		;;
	ADD WID20,WREG		;;
	ADD WID21,WREG		;;
	ADD WID22,WREG		;;
	ADD WID30,WREG		;;
	ADD WID31,WREG		;;
	ADD WID32,WREG		;;
	ADD WID40,WREG		;;
	ADD WID41,WREG		;;
	ADD WID42,WREG		;;
	MOV W0,WID_CHKSUM	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SAVE_FLASH_A	;;	
	MOV #20,W0		;;
	CALL DLYMX		;;
	CALL SAVE_FLASH_B	;;
	RETURN			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_FLASH_A:			;;
	CALL SAVE_TPMS_DATA	;;
	MOV #SET_BUF,W1		;;
	CALL VERIFY_FRAM	;;	
	BRA NZ,$+4		;;
	RETURN 			;;
	CALL ERASE_FRAM		;;
	MOV #SET_BUF,W1		;;
	CALL WRITE_FRAM		;;
	RETURN 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_FLASH_B:			;;
	CALL SAVE_TPMS_DATA	;;
	MOV #SET_BUF,W1		;;
	CALL VERIFY_FRAM_BK	;;	
	BRA NZ,$+4		;;
	RETURN 			;;
	CALL ERASE_FRAM_BK	;;
	MOV #SET_BUF,W1		;;
	CALL WRITE_FRAM_BK	;;
	RETURN 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_ENTRY:			;;
	BSET FLAGB,#DISKR_F	;;
	CP0 DPPSEL_CNT		;;	
	BRA NZ,$+4		;;
	RETURN			;;
	DEC DPPSEL_CNT,WREG	;;
	MUL.UU W0,#8,W2		;;
	MOV W2,W0		;;
	ADD MENU_ADR,WREG	;;
	ADD W0,#6,W1		;;
	TBLRDL [W1],W0		;;
	CP W0,#10		;;
	BRA LTU,MENU_ENT	;;
	PUSH W0			;;
	CALL PUSH_MENU		;;
	POP W0			;;
	MOV W0,MENU_ADR		;;
	CLR DPPSEL_CNT		;;
	INC DPPSEL_CNT		;;
	POP W0			;;
	POP W0			;;
	BRA MENU_PRG		;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	
MENU_ENT:
	CALL SAVE_MENU_SET	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV MENU_ADR,W0			;;
	LOFFS1 MENU_IHAA
	CP W0,W1
	BRA Z,MENU_IHAA_ENT
	LOFFS1 MENU_IHBA
	CP W0,W1
	BRA Z,MENU_IHBA_ENT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IHAB
	CP W0,W1
	BRA Z,MENU_IHAB_ENT
	LOFFS1 MENU_IHBB
	CP W0,W1
	BRA Z,MENU_IHBB_ENT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IHAC
	CP W0,W1
	BRA Z,MENU_IHAC_ENT
	LOFFS1 MENU_IHBC
	CP W0,W1
	BRA Z,MENU_IHBC_ENT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 MENU_IH
	CP W0,W1
	BRA Z,MENU_IH_ENT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN





CONKEY_SET1P:
	MOVLF #100,CONKEY_CNT
	BTSS KEY_FLAG1,#KCS1_F
	RETURN
	MOVLF #280,CONKEY_CNT
	RETURN	

CONKEY_SET0P:
	MOVLF #100,CONKEY_CNT
	BTSS KEY_FLAG1,#KCS0_F
	RETURN
	MOVLF #280,CONKEY_CNT
	RETURN	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHAA_ENT:			;;
	CALL CONKEY_SET1P	;;	
	BSET FLAGE,#EDITED_F	;;	
	INC TPMS_LOP_SETA	;;	
	MOV #150,W0		;;
	CP TPMS_LOP_SETA	;;
	BRA GTU,$+4		;;
	RETURN			;;
	MOVLF #0,TPMS_LOP_SETA	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHBA_ENT:			;;
	CALL CONKEY_SET1P	;;	
	BSET FLAGE,#EDITED_F	;;	
	INC TPMS_LOP_SETB	;;	
	MOV #150,W0		;;
	CP TPMS_LOP_SETB	;;
	BRA GTU,$+4		;;
	RETURN			;;
	MOVLF #0,TPMS_LOP_SETB	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHAB_ENT:			;;
	CALL CONKEY_SET1P	;;	
	BSET FLAGE,#EDITED_F	;;	
	INC TPMS_HIP_SETA	;;	
	MOV #200,W0		;;
	CP TPMS_HIP_SETA	;;
	BRA GTU,$+4		;;
	RETURN			;;
	MOVLF #10,TPMS_HIP_SETA	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHBB_ENT:			;;
	CALL CONKEY_SET1P	;;	
	BSET FLAGE,#EDITED_F	;;	
	INC TPMS_HIP_SETB	;;	
	MOV #200,W0		;;
	CP TPMS_HIP_SETB	;;
	BRA GTU,$+4		;;
	RETURN			;;
	MOVLF #10,TPMS_HIP_SETB	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHAC_ENT:			;;
	CALL CONKEY_SET1P	;;	
	BSET FLAGE,#EDITED_F	;;	
	INC TPMS_HIT_SETA	;;	
	MOV #160,W0		;;
	CP TPMS_HIT_SETA	;;
	BRA GTU,$+4		;;
	RETURN			;;
	MOVLF #40,TPMS_HIT_SETA	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IHBC_ENT:			;;
	CALL CONKEY_SET1P	;;	
	BSET FLAGE,#EDITED_F	;;	
	INC TPMS_HIT_SETB	;;	
	MOV #160,W0		;;
	CP TPMS_HIT_SETB	;;
	BRA GTU,$+4		;;
	RETURN			;;
	MOVLF #40,TPMS_HIT_SETB	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_IH_ENT:			;;
	MOV #5,W0		;;
	CP DPPSEL_CNT		;;	
	BRA Z,$+4		;;
	RETURN			;;
	CLR MENU_STK_CNT	;;	
	BSET FLAGF,#TPMS_LENST_F	
	BRA MENU_ESC
















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GETRF_T:                        ;;
	MOV TMR2,W0		;;
	MOV W0,GETRF_TIM	;;
        MOV RFBUF_PCNT0,W0      ;;
        XOR RFBUF_PCNT1,WREG    ;;
	AND #0x003F,W0		;;
        BTSC SR,#Z              ;;
        RETURN                  ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RFBUF_PCNT1,W0	;;
	AND #0x003F,W0		;;
	RLNC W0,W0		;;
	MOV #RXBUF,W1		;;
	ADD W0,W1,W1		;;
	MOV [W1],W1		;;
	PUSH W1			;;
        CALL TRFPRG             ;;  
	POP W1			;;
;	CALL RFPRG		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        INC RFBUF_PCNT1         ;;
        BTSC FLAGB,#RXIN_F      ;;
	RETURN			;;
        BTSC FLAGE,#TRXIN_F     ;;
	RETURN			;;
        BRA GETRF_T             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPUSRF_ERR:			;;
	CLR PUSYES_CNT		;;
	INC PUSERR_CNT		;;
	BRA TRFPRG_ERR		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPUSRF:     			;;
        MOV #LONG_KTP,W0        ;;25
	CP W1,W0		;;
	BRA GEU,TPUSRF_ERR 	;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #SHORT_KTP,W0       ;;25
	CP W1,W0		;;
	BRA LTU,TPUSRF_ERR 	;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC PUSYES_CNT		;;
	MOV #14,W0		;;
	CP PUSYES_CNT		;;
	BRA LTU,$+6		;;
	CLR PUSERR_CNT		;;
	CLR TMR1		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSS FLAGE,#TRFERR_F	;;	
        BRA TPUSRF1		;;
        BTSS RFBUF_PCNT1,#0  	;;
        BRA TRFPRG_END		;;	
        MOV #START_KTP,W0       ;;
	CP W1,W0		;;
	BTSC SR,#C		;;
	BCLR FLAGE,#TRFERR_F	;;
        BRA TRFPRG_END		;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TPUSRF1:			;;
        INC TTCODE2_CNT         ;;
        MOV #MID_KTP,W0		;;
        CP W1,W0                ;;
        BRA LTU,$+4	        ;;
        INC TTCODE2_CNT         ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSS TTCODE2_CNT,#1    	;;
        RETURN                 	;;
        BTSC TTCODE2_CNT,#0    	;;
        BRA TRFPRG2    	       	;;3
        MOV #MID_KTP,W0	       	;;2
        CP W1,W0               	;;
        BRA GEU,TRFPRG_ERR     	;;
        BRA TRFPRG2    	       	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRFPRG:                         ;;
	CLR TMR1		;;
        MOV #LONG_KT,W0         ;;25
	CP W1,W0		;;
	BRA GEU,TRFPRG_ERR 	;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #SHORT_KT,W0        ;;25
	CP W1,W0		;;
	BRA LTU,TRFPRG_ERR 	;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTSS FLAGE,#TRFERR_F	;;	
        BRA TRFPRG1		;;
        BTSS RFBUF_PCNT1,#0  	;;
        BRA TRFPRG_END		;;	
        MOV #START_KT,W0        ;;
	CP W1,W0		;;
	BTSC SR,#C		;;
	BCLR FLAGE,#TRFERR_F	;;
        BRA TRFPRG_END		;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRFPRG1:			;;
        INC TTCODE2_CNT         ;;
        MOV #MID_KT,W0		;;
        CP W1,W0                ;;
        BRA LTU,$+4	        ;;
        INC TTCODE2_CNT         ;;
        BTSS TTCODE2_CNT,#1    	;;
        RETURN                 	;;
        BTSC TTCODE2_CNT,#0    	;;
        BRA TRFPRG2    	       	;;
        MOV #MID_KT,W0	       	;;
        CP W1,W0               	;;
        BRA GEU,TRFPRG_ERR     	;;
TRFPRG2:      	                ;;
        BCLR TTCODE2_CNT,#1    	;;
        BCLR SR,#C              ;;
        BTSS RFBUF_PCNT1,#0     ;;
        BSET SR,#C              ;;
	RLC TTCODE1	        ;;	 
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC TRFBIT_CNT	        ;;	
        MOV #13,W0              ;;
	CP TRFBIT_CNT		;;
	BRA LTU,TRFPRG_END	;;
	CLR TMR1		;;<<PUSRF TIME RESET
        CLR RFPUS_TIM	        ;;	
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV TTCODE1,W0          ;;
	MOV W0,W1		;;
	SWAP W0			;;
	AND #15,W0		;;
	XOR W1,W0,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,W0		;;
	SWAP.B W0		;;	
	XOR W0,W1,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RRC W0,W1		;;
	XOR W1,W0,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #1,W0		;;
	BTSC W1,#2		;;
	MOV #0,W0		;;
	XOR W1,W0,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC W0,#0		;;
	BRA TRFPRG_ERR		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TTCODE1,W0		;;
	SWAP W0			;;
	AND #0x000E,W0		;;
	MOV W0,W2		;;	
	MOV #TRX0,W0		;;
	ADD W0,W2,W1		;;
	MOV TTCODE1,W0		;;
	AND #255,W0		;;
	MOV W0,[W1]		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV #4,W0               ;;
        BTSS W2,#2      	;;
        MOV #1,W0               ;;
        BTSC W2,#3     		;;BIT_TRANS
        SWAP.B W0               ;;
        BTSC W2,#1      	;;
        RLNC W0,W0              ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
	IOR TRXBYTE_BUF		;;
	CLR TCLRRF_CNT		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV TRXBYTE_BUF,W0 	;;
        AND #0x007F,W0          ;;<<
        XOR #0x007F,W0          ;;<<
        BRA NZ,TRFPRG_ERR       ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W0			;;
        ADD TRX0,WREG            ;;<<
        ADD TRX1,WREG            ;;<<
        ADD TRX2,WREG            ;;<<
        ADD TRX3,WREG            ;;<<
        ADD TRX5,WREG            ;;<<
        ADD TRX6,WREG            ;;<<
        XOR TRX4,WREG    	;;<<
	AND #255,W0		;;<<
	BRA Z,TRFPRG_TPMSC	;;	
	XOR #0x5C,W0		;;	
	BRA Z,TRFPRG_TPMST	;;
        BRA TRFPRG_ERR        	;;
TRFPRG_TPMST:			;;
	BSET FLAGE,#RFIN_TPMSCT_F	 
	BRA TRFPRG_RFIN		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
TRFPRG_TPMSC:			;;
	BCLR TRX0,#0		;;
	BTSC TRX6,#0
	BSET TRX0,#0
	BCLR SR,#C
	RRC TRX6
	BCLR FLAGE,#RFIN_TPMSCT_F	 
TRFPRG_RFIN:			 ;;
        BSET FLAGE,#TRXIN_F      ;;
	MOV #2,W0		 ;;
	CP TRX6			 ;;
	BRA GEU,TRFPRG_RFIN1
	CLR TRX6		 ;;
	BCLR TRX0,#0		 ;;		 
TRFPRG_RFIN1:			 ;;
        CLR TRXBYTE_BUF          ;;
TRFPRG_ERR:                      ;;
        CLR TTCODE2_CNT          ;;
        BSET FLAGE,#TRFERR_F     ;;
        CLR TRFBIT_CNT           ;;
TRFPRG_END:		        ;;	        
        RETURN                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	CLR KEY_FLAG1			;;
	CLR KEY_FLAG0			;;
	BTSS TMR2_FLAG,#T4M_F		;;0=64US	
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV PORTB,W0			;;
	LSR W0,#10,W0			;;
	XOR #7,W0			;;
	AND #7,W0			;;
	BRA NZ,YESKEY			;; 	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NOKEY:					;;
	BTSC FLAGB,#NOKEY_F		;;
	BRA NOKEY1			;;
	MOV DBCLK_BUF2,W1		;;
	MOV W1,DBCLK_BUF3		;;
	MOV DBCLK_BUF1,W1		;;
	MOV W1,DBCLK_BUF2		;;
	MOV DBCLK_BUF0,W1		;;
	MOV W1,DBCLK_BUF1		;;
	MOV DBCLK_CNT,W1		;;
	MOV W1,DBCLK_BUF0		;;
	CLR DBCLK_CNT			;;
NOKEY1:					;;
	BSET FLAGB,#NOKEY_F		;;		
	INC DBCLK_CNT			;;
	BTSC SR,#Z			;;
	DEC DBCLK_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC NOKEY_CNT			;;
	MOV #10,W0			;;
	CP NOKEY_CNT		        ;;
	BTSS SR,#C			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #100,W0			;;
	CP DBCLK_BUF3			;;
	BRA LTU,NOKEY2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #5,W0			;;
	CP DBCLK_BUF2			;;
	BRA LTU,NOKEY2			;;
	MOV #30,W0			;;
	CP DBCLK_BUF2			;;
	BRA GTU,NOKEY2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #5,W0			;;
	CP DBCLK_BUF1			;;
	BRA LTU,NOKEY2			;;
	MOV #30,W0			;;
	CP DBCLK_BUF1			;;
	BRA GTU,NOKEY2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #5,W0			;;
	CP DBCLK_BUF0			;;
	BRA LTU,NOKEY2			;;
	MOV #30,W0			;;
	CP DBCLK_BUF0			;;
	BRA GTU,NOKEY2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KEY_BUF,W0			;;
	SWAP.B W0			;;
	IOR KEY_FLAG0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR DBCLK_BUF0			;;	
	CLR DBCLK_BUF1			;;
	CLR DBCLK_BUF2			;;
	CLR DBCLK_BUF3			;;
	BSET FLAGB,#DISKR_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NOKEY2:					;;
	MOV KEY_BUF,W0			;;
	SL  W0,#8,W0			;;
	BTSS FLAGB,#DISKR_F		;;
	IOR KEY_FLAG0			;;
	BCLR FLAGB,#DISKR_F		;;
	BCLR FLAGB,#DISKK_F		;;
	CLR KEY_BUF			;;
	CLR YESKEY_CNT			;;
	CLR CONKEY_CNT			;; 
	BCLR FLAGF,#PUSHCC_F 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGB,#TXKEY_F		;; 
	RETURN				;;
	BCLR FLAGB,#TXKEY_F		;;
	CLR MTX_COUNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
YESKEY:					;;
	BTSS FLAGB,#NOKEY_F		;;
	BRA YESKEY1			;;
	MOV DBCLK_BUF2,W1		;;
	MOV W1,DBCLK_BUF3		;;
	MOV DBCLK_BUF1,W1		;;
	MOV W1,DBCLK_BUF2		;;
	MOV DBCLK_BUF0,W1		;;
	MOV W1,DBCLK_BUF1		;;
	MOV DBCLK_CNT,W1		;;
	MOV W1,DBCLK_BUF0		;;
	CLR DBCLK_CNT			;;
YESKEY1:				;;
	BCLR FLAGB,#NOKEY_F		;;		
	INC DBCLK_CNT			;;
	BTSC SR,#Z			;;
	DEC DBCLK_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR NOKEY_CNT			;;
	INC YESKEY_CNT			;;		
	PUSH W0				;;
	MOV #1,W0			;;
	CP YESKEY_CNT			;;
	POP W0				;;
	BTSS SR,#C			;;
	RETURN				;;
	CLR SLEEP_CNT			;;
	DEC YESKEY_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP KEY_BUF			;;
	BRA Z,CONKEY			;;
	BTSC FLAGB,#DISKK_F		;;
	RETURN				;;
	MOV W0,KEY_BUF			;;
	IOR KEY_FLAG0			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONKEY:					;;
	INC CONKEY_CNT			;;
	PUSH W0				;;
	MOV #300,W0			;;
	CP CONKEY_CNT 			;;
	POP W0				;;
	BTSS SR,#C			;;
	RETURN				;;
	CLR CONKEY_CNT			;;
	IOR KEY_FLAG1			;;
	BSET FLAGB,#DISKR_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LKEYBO:					;;
	CLR KEY_FLAG1			;;
	CLR KEY_FLAG0			;;
	BTSS TMR2_FLAG,#T16M_F		;;0=64US	
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTG TEST,#TEST_P		;;
	MOV PORTB,W0			;;
	LSR W0,#10,W0			;;
	XOR #7,W0			;;
	AND #7,W0			;;
	BRA NZ,LYESKEY			;; 	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LNOKEY:					;;
	INC NOKEY_CNT			;;
	MOV #3,W0			;;
	CP NOKEY_CNT		        ;;
	BTSS SR,#C			;;
	RETURN				;;
	BSET FLAGB,#NOKEY_F		;;		
	MOV KEY_BUF,W0			;;
	SL  W0,#8,W0			;;
	BTSS FLAGB,#DISKR_F		;;
	IOR KEY_FLAG0			;;
	BCLR FLAGB,#DISKR_F		;;
	BCLR FLAGB,#DISKK_F		;;
	CLR KEY_BUF			;;
	CLR YESKEY_CNT			;;
	CLR CONKEY_CNT			;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGB,#TXKEY_F		;; 
	RETURN				;;
	BCLR FLAGB,#TXKEY_F		;;
	CLR MTX_COUNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LYESKEY:				;;
	CLR NOKEY_CNT			;;
	INC YESKEY_CNT			;;		
	PUSH W0				;;
	MOV #2,W0			;;
	CP YESKEY_CNT			;;
	POP W0				;;
	BTSS SR,#C			;;
	RETURN				;;
	BCLR FLAGB,#NOKEY_F		;;		
	CLR SLEEP_CNT			;;
	DEC YESKEY_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP KEY_BUF			;;
	BRA Z,LCONKEY			;;
	BTSC FLAGB,#DISKK_F		;;
	RETURN				;;
	MOV W0,KEY_BUF			;;
	IOR KEY_FLAG0			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCONKEY:				;;
	INC CONKEY_CNT			;;
	PUSH W0				;;
	MOV #100,W0			;;
	CP CONKEY_CNT 			;;
	POP W0				;;
	BTSS SR,#C			;;
	RETURN				;;
	CLR CONKEY_CNT			;;
	IOR KEY_FLAG1			;;
	BSET FLAGB,#DISKR_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
CHKAD_BAT_SLOW:				;;
	MOV #60,W0			;;
	CP DETBAT_TIM			;;
	BRA GEU,$+4			;;
	RETURN				;;
	CLR DETBAT_TIM			;;
	CALL CHKAD_BAT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
CHKAD_POW_SLOW:				;;
	MOV #12,W0			;;
	CP DETPOW_TIM			;;
	BRA GEU,$+4			;;
	RETURN				;;
	CLR DETPOW_TIM			;;
	CALL CHKAD_POW			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHKAD_POW:				;;
	CALL GET_ADP			;;
	MOV W0,W1			;;
	INC POWV_CNT			;;
	MOV #16,W0			;; 
	CP POWV_CNT			;;
	BRA LTU,$+4			;;
	CLR POWV_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,W0			;;
	ADD POWV_BUF0			;;
	MOV #0,W0			;;
	ADDC POWV_BUF1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV POWV_BUF,W0			;;
	SUB W1,W0,W0			;;
	BTSC W0,#15			;;
	NEG W0,W0			;;
	MOV #16,W2			;;
	CP W0,W2			;;
;	BRA LTU,$+4			;;
;	MOV W1,POWV_BUF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP0 POWV_CNT			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV POWV_BUF0,W2		;;
	MOV POWV_BUF1,W3		;;
	CLR POWV_BUF0			;;
	CLR POWV_BUF1 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 	BCLR SR,#C			;;
;	RRC W3,W3			;;
;	RRC W2,W2			;;
 	BCLR SR,#C			;;
	RRC W3,W3			;;
	RRC W2,W2			;;
 	BCLR SR,#C			;;
	RRC W3,W3			;;
	RRC W2,W2			;;
 	BCLR SR,#C			;;
	RRC W3,W3			;;
	RRC W2,W2			;;
 	BCLR SR,#C			;;
	RRC W3,W3			;;
	RRC W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W2,POWV_BUF			;;
	MOV W2,W0			;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #VPOW_0,W1			;;
	CP W0,W1			;;
	BRA GTU,$+4			;;
	BSET VDET_R,#VDET_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #VPOW_1,W1			;;
	CP W0,W1			;;
	BRA LTU,$+4			;;
	BCLR VDET_R,#VDET_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #VPOW_2,W1			;;
	CP W0,W1			;;
	BRA GTU,$+4			;;
	BSET VPOW_R,#VPOW_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #VPOW_3,W1			;;
	CP W0,W1			;;
	BRA LTU,$+4			;;
	BCLR VPOW_R,#VPOW_F		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHKAD_BAT:				;;
	CALL GET_ADX			;;
	MOV W0,BATV_BUF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #V2P2,W1			;;
	CP W0,W1			;;
	BRA GTU,$+4			;;
	BSET FLAGB,#BATLOW_F		;;<<
	MOV #V2P3,W1			;;
	CP W0,W1			;;
	BRA LTU,$+4			;;
	BCLR FLAGB,#BATLOW_F		;;<<
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #V1P9,W1			;;
	CP W0,W1			;;
	BRA GTU,$+4			;;
	BSET FLAGE,#BATLL_F		;;<<
	MOV #V2P0,W1			;;
	CP W0,W1			;;
	BRA LTU,$+4			;;
	BCLR FLAGE,#BATLL_F		;;<<
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #V1P6,W1			;;
	CP W0,W1			;;
	BRA GTU,$+4			;;
	BSET FLAGE,#BATLLL_F		;;<<
	MOV #V1P6,W1			;;
	CP W0,W1			;;
	BRA LTU,$+4			;;
	BCLR FLAGE,#BATLLL_F		;;<<
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INIT_AD:
        MOV #0x0400,W0
        MOV W0,AD1CON2
        MOV #0x8014,W0
        MOV W0,AD1CON3
        CLR AD1CHS
        MOV #0xFFCF,W0
	MOV W0,AD1PCFG

        MOV #0xFFCF,W0
	MOV W0,AD1PCFG


        CLR AD1CSSL
        MOV #0x00E6,W0
        MOV W0,AD1CON1
	RETURN


GET_ADP:
        BCLR AD1CON1,#ADON
	MOV #0x0010,W1
        MOV W1,AD1CSSL
        BSET AD1CON1,#ADON
        BCLR IFS0,#AD1IF
	BRA GET_AD1

GET_ADB:
        BCLR AD1CON1,#ADON
	MOV #0x0020,W1
        MOV W1,AD1CSSL
        BSET AD1CON1,#ADON
        BCLR IFS0,#AD1IF
	BRA GET_AD1


GET_ADX:
        BCLR AD1CON1,#ADON
	MOV #0x0020,W1
        MOV W1,AD1CSSL
        BSET AD1CON1,#ADON
        BCLR IFS0,#AD1IF
GET_AD1: 
        BTSS IFS0,#AD1IF
        BRA GET_AD1
        BCLR IFS0,#AD1IF
GET_AD1A: 
        BTSS IFS0,#AD1IF
        BRA GET_AD1A
        BCLR IFS0,#AD1IF
GET_AD1B: 
        BTSS IFS0,#AD1IF
        BRA GET_AD1B
        BCLR IFS0,#AD1IF
GET_AD1C: 
        BTSS IFS0,#AD1IF
        BRA GET_AD1C
        BCLR IFS0,#AD1IF
        MOV ADC1BUF0,W0
        MOV W0,R0
GET_AD2: 
        BTSS IFS0,#AD1IF
        BRA GET_AD2
        BCLR IFS0,#AD1IF
        MOV ADC1BUF0,W0
        MOV W0,R1
GET_AD3: 
        BTSS IFS0,#AD1IF
        BRA GET_AD3
        BCLR IFS0,#AD1IF
        MOV ADC1BUF0,W0
        MOV W0,R2
GET_AD4: 
        BTSS IFS0,#AD1IF
        BRA GET_AD4
        BCLR IFS0,#AD1IF
        MOV ADC1BUF0,W0
        MOV W0,R3
GET_AD5: 
        BTSS IFS0,#AD1IF
        BRA GET_AD5  
        BCLR IFS0,#AD1IF
        MOV ADC1BUF0,W0
        MOV W0,R4
GET_AD6: 
        BTSS IFS0,#AD1IF
        BRA GET_AD6
        BCLR IFS0,#AD1IF
        MOV ADC1BUF0,W0
        MOV W0,R5
GET_AD7: 
        BTSS IFS0,#AD1IF
        BRA GET_AD7
        BCLR IFS0,#AD1IF
        MOV ADC1BUF0,W0
        MOV W0,R6
GET_AD8: 
        BTSS IFS0,#AD1IF
        BRA GET_AD8
        BCLR IFS0,#AD1IF
        MOV ADC1BUF0,W0
        MOV W0,R7
        BCLR AD1CON1,#ADON
        CALL BSORT
        MOV R2,W0
        ADD R3,WREG
        ADD R4,WREG
        ADD R5,WREG
        LSR W0,#2,W0
        RETURN 







BSORT:
        MOV #7,W1
        MOV W1,R8
BSORT0:
        MOV #R0,W0
        MOV R8,W1
        MOV W1,R9
BSORT1:
        CALL COMPW
        DEC R9
        BRA NZ,BSORT1
        DEC R8
        BRA NZ,BSORT0
        RETURN

                
COMPW:
        MOV [W0++],W2
        MOV [W0],W3
        CP W3,W2
        BRA GE,COMPW1
        MOV [W0--],W3
        MOV [W0],W2
        MOV W3,[W0++]
        MOV W2,[W0]
COMPW1:
        RETURN





;--------End of All Code Sections ---------------------------------------------


        .include "prog.s"
TYREDOG_BMP:
        .include "DATA.S"

