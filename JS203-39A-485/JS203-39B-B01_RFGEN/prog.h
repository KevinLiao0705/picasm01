;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ICON_PRG:				;;
	INC ICONL_CNT			;;
	MOV #24,W0			;;
	CP ICONL_CNT			;;
	BRA LTU,$+4			;;
	CLR ICONL_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV ICONL_CNT,W4		;;
	MOV #ICONB,W1			;;
	ADD W1,W4,W1			;;
	ADD W1,W4,W1			;;			
	MOV [W1],W0			;;
	MOV W0,W2			;;
	SWAP W0				;;
	XOR W0,W2,W0			;;
	BRA NZ,$+4			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND #255,W2			;;
	MOV W2,R0			;;
	MOV W2,W0			;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	MOV W0,[W1]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 ICON_TBL_TBL		;;
	MUL.UU W4,#2,W2			;;
	ADD W2,W1,W1			;;
	TBLRDL [W1],W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0			;;
	MOV W0,LCDX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0			;;
	MOV W0,LCDY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R0,W0			;;
	AND #7,W0			;;
	MUL.UU W0,#2,W2			;;
	ADD W2,W1,W1			;;W1_TBL
	TBLRDL [W1],W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC R0,#3			;;PRESENT
	BRA ICON_PRG1			;;
	INC2 W1,W1			;;
	INC2 W1,W1			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0		;;
	MOV W0,BMPX	  		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0		;;
	MOV W0,BMPY	  		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_LCDLIM		;;
	LOFFS1 TABLE_SEL_TBL		;;
	MOV #4,W0			;;
	MUL TABLE_SET			;;
	ADD W2,W1,W1			;;
	TBLRDL [W1++],W0		;;
	MOV W0,FADR0			;;
	TBLRDL [W1],W0			;;
	MOV W0,FADR1			;;
	CALL GET_BLKC8			;;
	CALL DISP_INP8			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV ICONL_CNT,W4		;;	
	MUL.UU W4,#12,W2 		;;	
	MOV #ICONP_BUF,W5		;;
	ADD W5,W2,W5			;;
	CLR W0				;;
	MOV W0,[W5]			;;
	RETURN				;;
ICON_PRG1:				;;	
	MOV ICONL_CNT,W4		;;	
	MUL.UU W4,#12,W2 		;;	
	MOV #ICONP_BUF,W5		;;
	ADD W5,W2,W5			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0003,W2			;;
	MOV R0,W0			;;
	SWAP.B W0			;;
	AND #15,W0			;;
	XOR #15,W0
	BRA NZ,$+4			;;
	BSET W2,#2			;;
	XOR #15,W0			;; 
	SWAP W0				;;
	IOR W0,W2,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W0,[W5++]			;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,[W5++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	SETM W0				;;
	MOV W0,[W5++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX,W0			;;
	MOV W0,[W5++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY,W0			;;
	MOV W0,[W5]			;;
	RETURN				;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_PRETBL:				;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ICON_PRGX:	
	INC W4,W4
	MOV #ICON_AMT_K,W0
	CP W4,W0
	BRA LTU,ICON_PRG1
	RETURN


ICON_XY_TBL:
	.WORD 0,0
	.WORD 25,25
	.WORD 0,0
	.WORD 25,25
	.WORD 0,0
	.WORD 25,25

	



TABLE_SEL_TBL:
    	.WORD TABL_BLACK_ADR0	
	.WORD TABL_BLACK_ADR1
    	.WORD TABL_BLUE_ADR0	
	.WORD TABL_BLUE_ADR1   
    	.WORD TABL_GREEN_ADR0	
	.WORD TABL_GREEN_ADR1
    	.WORD TABL_PURPLE_ADR0	
	.WORD TABL_PURPLE_ADR1
DISP_TABLE:
	CALL INIT_LCDLIM
	LOFFS1 TABLE_SEL_TBL
	MOV #4,W0
	MUL TABLE_SET
	ADD W2,W1,W1
	TBLRDL [W1++],W0
	MOV W0,FADR0
	TBLRDL [W1++],W0
	MOV W0,FADR1
	LXY 0,0
	MOVLF 128,BMPX
	MOVLF 160,BMPY
	CALL GET_BLKC8		;;
	CALL DISP_BMP8		;;
	RETURN


MENU_SET_TBL:
	.WORD tbloffset(MENU_N),PRESHOW_SET
	.WORD tbloffset(MENU_NX),TABLE_SET
	.WORD 0


SETM_SET_TBL:
	.WORD tbloffset(SETM_A_TBL),SETM_A_SET
	.WORD tbloffset(SETM_B_TBL),SETM_B_SET
	.WORD tbloffset(SETM_C_TBL),SETM_C_SET
	.WORD tbloffset(SETM_D_TBL),SETM_D_SET
	.WORD tbloffset(SETM_E_TBL),SETM_E_SET
	.WORD tbloffset(SETM_F_TBL),SETM_F_SET
	.WORD tbloffset(SETM_G_TBL),SETM_G_SET
	.WORD tbloffset(SETM_H_TBL),SETM_H_SET
	.WORD tbloffset(SETM_I_TBL),SETM_I_SET
	.WORD tbloffset(SETM_J_TBL),SETM_J_SET
	.WORD tbloffset(SETM_K_TBL),SETM_K_SET
	.WORD tbloffset(SETM_L_TBL),SETM_L_SET
	.WORD tbloffset(SETM_M_TBL),SETM_M_SET
	.WORD tbloffset(SETM_N_TBL),SETM_N_SET
	.WORD tbloffset(SETM_O_TBL),SETM_O_SET
	.WORD tbloffset(SETM_P_TBL),SETM_P_SET
	.WORD tbloffset(SETM_Q_TBL),SETM_Q_SET
	.WORD tbloffset(SETM_R_TBL),SETM_R_SET
	.WORD 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_MENU_SET:				;;
	LOFFS1 #MENU_SET_TBL 		;;
LOAD_MENU_SET0:				;;
	TBLRDL [W1++],W0		;;
	CP0 W0				;;
	BRA Z,LOAD_MENU_SET1		;;
	TBLRDL [W1++],W2		;;
	CP MENU_ADR			;;
	BRA NZ,LOAD_MENU_SET0		;;
	MOV [W2],W0			;;
	INC W0,W0			;;
	MOV W0,DPPSEL_CNT		;;
LOAD_MENU_SET1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_SETM_SET:				;;
	LOFFS1 #SETM_SET_TBL 		;;
LOAD_SETM_SET0:				;;
	TBLRDL [W1++],W0		;;
	CP0 W0				;;
	BRA Z,LOAD_SETM_SET1		;;
	TBLRDL [W1++],W2		;;
	CP SETM_ADR			;;
	BRA NZ,LOAD_SETM_SET0		;;
	MOV [W2],W0			;;
	MOV W0,SETMNOW_CNT		;;
LOAD_SETM_SET1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_MENU_SET:				;;
	LOFFS1 #MENU_SET_TBL 		;;
SAVE_MENU_SET0:				;;
	TBLRDL [W1++],W0		;;
	CP0 W0				;;
	BRA Z,SAVE_MENU_SET1		;;
	TBLRDL [W1++],W2		;;
	CP MENU_ADR			;;
	BRA NZ,SAVE_MENU_SET0		;;
	DEC DPPSEL_CNT,WREG		;;
	MOV W0,[W2]			;;
SAVE_MENU_SET1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_SETM_SET:				;;
	LOFFS1 #SETM_SET_TBL 		;;
SAVE_SETM_SET0:				;;
	TBLRDL [W1++],W0		;;
	CP0 W0				;;
	BRA Z,SAVE_SETM_SET1		;;
	TBLRDL [W1++],W2		;;
	CP SETM_ADR			;;
	BRA NZ,SAVE_SETM_SET0		;;
	MOV SETMNOW_CNT,W0 		;;
	MOV W0,[W2]			;;
SAVE_SETM_SET1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_PRG0:				;;
	LOFFS1 #SETM_TBL		;;
	MOV W1,SETM_ADR			;;
	CLR SETM_STK_CNT		;;
	CLR SETMSEL_CNT			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_PRG:				;;		
	CALL DARKSCR			;;
	SETM SETMNOW_CNT		;;
	CALL LOAD_SETM_SET		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_PRG_KIN:				;;
	MOV SETM_ADR,W2			;;
	TBLRDL [W2++],W0		;;
	MOV W0,SETMSEL_AMT		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W2++],W0		;;
	MOV W0,SETM_KADR		;;				
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLF 0,LCDX_LIM0		;;
	MOVLF 127,LCDX_LIM1		;;
	MOVLF 0,LCDY_LIM0		;;
	MOVLF 16,LCDY_LIM1		;;
	CALL C_WTBL			;;
	TBLRDL [W2++],W1		;;
	CP0 W1				;;
	BRA Z,CHK_SETM_START	 	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W2				;;
	CALL FIXSTR			;;
	POP W2				;;
	MOV #16,W0			;;
	ADD LCDY_LIM0			;;
	ADD LCDY_LIM1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W2++],W1		;;
	CP0 W1				;;
	BRA Z,CHK_SETM_START	 	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH W2				;;
	CALL FIXSTR			;;
	POP W2				;;
	MOV #16,W0			;;
	ADD LCDY_LIM0			;;
	ADD LCDY_LIM1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SETM_START:				;;
	CLR R2				;;
CHK_SETM_START00:			;;
	MOV LCDY_LIM0,W0		;;
	MOV W0,R1			;;
	MOV R2,W0			;;
	MOV W0,R0			;;
CHK_SETM_START0:			;;
	PUSH W2				;;
	MOV R0,W0			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W2++],W1		;;
	TBLRDL [W2++],W1		;;
	MOV #16,W0			;;
	ADD R1				;;
	TBLRDL [W2++],W1		;;
	CP0 W1				;;
	BRA Z,CHK_SETM_START1		;;	 
	MOV #16,W0			;;
	ADD R1				;;
CHK_SETM_START1:			;;
	POP W2				
	MOV R0,W0			;;
	CP SETMSEL_CNT			;;
	BRA Z,CHK_SETM_START2		;;
	INC R0				;;
	MOV SETMSEL_AMT,W0		;;
	CP R0				;;
	BRA LTU,CHK_SETM_START0		;;
CHK_SETM_START2:			;;
	MOV #161,W0			;;
	CP R1				;;
	BRA LTU,SETM_LOAD		;;
	INC R2				;;
	BRA CHK_SETM_START00		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_LOAD:				;;
	CP0 R2				;;
	BRA Z,SETM_LOAD0		;;
	MOV #160,W0			;;
	CP R1				;;
	BRA GEU,SETM_LOAD0		;;
	MOV #16,W0			;;
	ADD LCDY_LIM0			;;
	ADD LCDY_LIM1			;;

;	BTSC R0,#0			;;
;	CALL C_BKWT			;;
;	BTSS R0,#0			;;
;	CALL C_BKGY			;;
;	MOV LCDX_LIM0,W0
;	MOV W0,LCDX
;	MOV LCDY_LIM0,W0
;	MOV W0,LCDY
;	MOV #128,W0			;;
;	MOV W0,BMPX			;;
;	MOV #16,W0			;;
;	MOV W0,BMPY			;;
;	PUSH R2
;	PUSH W2
;	CALL DISP_BLK			;;
;	POP W2
;	POP R2
SETM_LOAD0:
	MOV R2,W0			;;
	MOV W0,R0			;;
	MOV W2,R1			;;
SETM_LOAD1:				;;
	MOV R1,W2			;;
	MOV R0,W0			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	ADD W0,W2,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS R0,#0			;;
	CALL C_BKWT			;;
	BTSC R0,#0			;;
	CALL C_BKGY			;;
	TBLRDL [W2++],W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SETMSEL_CNT,W0		;;
	CP R0				;;
	BRA NZ,SETM_LOAD1A 		;;
	MOV #C_GREEN,W0			;;
	MOV W0,COLOR_B			;;
SETM_LOAD1A:				;;
	MOV SETMNOW_CNT,W0		;;
	CP R0				;;
	BRA NZ,SETM_LOAD1B 		;;
	MOV #C_RED,W0			;;
	MOV W0,COLOR_F			;;
SETM_LOAD1B:				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W2++],W1		;;
	CP0 W1				;;
	BRA Z,SETM_LOAD2		;;	 
	PUSH W2				;;
	CALL FIXSTR			;;
	POP W2				;;
	MOV #16,W0			;;
	ADD LCDY_LIM0			;;
	ADD LCDY_LIM1			;;
	MOV #160,W0			;;
	CP LCDY_LIM0			;;
	BRA GTU,SETM_LOOP		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W2++],W1		;;
	CP0 W1				;;
	BRA Z,SETM_LOAD2		;;	 
	PUSH W2				;;
	CALL FIXSTR			;;
	POP W2				;;
	MOV #16,W0			;;
	ADD LCDY_LIM0			;;
	ADD LCDY_LIM1			;;
	MOV #160,W0			;;
	CP LCDY_LIM0			;;
	BRA GTU,SETM_LOOP		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_LOAD2:				;;	
	INC R0				;;
	MOV SETMSEL_AMT,W0		;;
	CP R0				;;
	BRA LTU,SETM_LOAD1		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
SETM_LOOP:				;;
	CALL TMR2PRG			;;
	CALL KEYBO			;;
	MOV SETM_KADR,W0		;;
	CALL W0				;;
	BRA SETM_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENUA_PRG:				;;
	LOFFS1 #MENU_A			;;
	MOV W1,MENU_ADR			;;
	CLR DPPSEL_CNT			;;
	INC DPPSEL_CNT			;;
	CLR MENU_STK_CNT		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MENU_PRG:				;;		
	CALL DARKSCR			;;
	CALL INIT_DPP			;;
	CLR DPPSEL_PRE 			;;
	CALL LOAD_MENU_SET		;;
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
	CALL LOAD_DPP			;;	;;
	POP W1				;;
	ADD W1,#8,W1			;;
	INC R0				;;
	MOV MENU_AMT,W0			;;
	CP R0				;;
	BRA NC,MENU_LOAD		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
MENU_LOOP:				;;
	CALL TMR2PRG			;;
	CALL DPP			;;
	CALL DPPSEL			;;
	CALL KEYBO			;;
	MOV MENU_KADR,W0		;;
	CALL W0				;;
	BRA MENU_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

INIT_ICONP:
	CLR W1
INIT_ICONP1:
	MOV #ICONP_BUF,W0
	ADD W1,W0,W0
	ADD W1,W0,W0 	
	CLR [W0]
	INC W1,W1
	MOV #144,W2
	CP W1,W2
	BRA LTU,INIT_ICONP1 	
	RETURN
INIT_ICONB:
	CLR W1
INIT_ICONB1:
	MOV #ICONB,W0
	ADD W1,W0,W0
	ADD W1,W0,W0 	
	CLR [W0]
	INC W1,W1
	MOV #24,W2
	CP W1,W2
	BRA LTU,INIT_ICONB1 	
	RETURN

RTIME_PRG:
	BTSS IFS0,#T1IF
	BRA RTIME_PRG1
	BCLR IFS0,#T1IF
	INC MIN
	MOV #60,W0
	CP MIN
	BRA LTU,RTIME_PRG1
	CLR MIN
	INC HOUR
	MOV #24,W0
	CP HOUR
	BRA LTU,RTIME_PRG1
	CLR HOUR
RTIME_PRG1:
	MOVLF 'A',DISPB0
	MOVLF 'M',DISPB1

	MOV #0x8000,W0
	MOV W0,RCFGCAL

	MOV RTCVAL,W0
	SWAP W0
	SWAP.B W0
	AND #15,W0
	CALL NUM_TRANS
	MOV W0,DISPB2
	 	
	MOV RTCVAL,W0
	SWAP W0
	AND #15,W0
	CALL NUM_TRANS
	MOV W0,DISPB3

	MOV #':',W0
	BTSS RCFGCAL,#HALFSEC
	MOV #' ',W0
	MOV W0,DISPB4
	
	MOV RTCVAL,W0
	SWAP.B W0
	AND #15,W0
	CALL NUM_TRANS
	MOV W0,DISPB5
	 	
	MOV RTCVAL,W0
	AND #15,W0
	CALL NUM_TRANS
	MOV W0,DISPB6

	RETURN







INIT_RTCC:
	DISI #5
	MOV #0x55,W0
	MOV W0,NVMKEY
	MOV #0xAA,W0
	MOV W0,NVMKEY
	BSET RCFGCAL,#RTCWREN 
	NOP
	NOP
	BSET RCFGCAL,#RTCEN 	
	;;;;;;;;;;;;;;;;;;;
	BCLR RCFGCAL,#8
	BCLR RCFGCAL,#9
	MOV #0x0000,W0
	MOV W0,RTCVAL
	BSET RCFGCAL,#8
	MOV #0x0000,W0
	MOV W0,RTCVAL
	BCLR RCFGCAL,#8
	BSET RCFGCAL,#9
	MOV #0x0000,W0
	MOV W0,RTCVAL
	BSET RCFGCAL,#8
	MOV #0x0000,W0
	MOV W0,RTCVAL
	;;;;;;;;;;;;;;;;;;;
	BCLR RCFGCAL,#RTCWREN 	
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
INIT_RTIME:				;;
	CLR MIN				;;
	CLR HOUR			;;
	MOV #0,W5			;;
INIT_RTIME1:				;;
	MOV #DFFBUF,W4			;;
	MUL.UU W5,#12,W2		;;
	ADD W2,W4,W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR [W2]			;;
	BSET [W2],#0
	BSET [W2++],#2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #' ',W0			;;
	MOV W0,[W2++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W0,[W2++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 	LOFFS1 RTIME_XY_TBL		;;
	ADD W1,W5,W1			;;
	ADD W1,W5,W1			;;
	TBLRDL [W1],W0			;;
	MOV W0,[W2++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFFFF,W0			;;
	MOV W0,[W2++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;
	MOV W0,[W2++]			;;
 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC W5,W5			;;
	CP W5,#7			;;
	BRA LTU,INIT_RTIME1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	
INIT_DYBMP:
	CLR W1
INIT_DYBMP1:
	MOV #DYBMP_BUF,W0
	ADD W1,W0,W0
	ADD W1,W0,W0 	
	CLR [W0]
	INC W1,W1
	MOV #120,W2
	CP W1,W2
	BRA LTU,INIT_DYBMP1 	
	CLR DYBMP_AMT
	RETURN

INIT_DFF:
	CLR W1
INIT_DFF1:
	MOV #DFFBUF,W0
	ADD W1,W0,W0
	ADD W1,W0,W0 	
	CLR [W0]
	INC W1,W1
	MOV #120,W2
	CP W1,W2
	BRA LTU,INIT_DFF1 	
	CLR DFF_AMT
	RETURN



INIT_DPP:
	CLR W1
INIT_DPP1:
	MOV #DPPBUF,W0
	ADD W1,W0,W0
	ADD W1,W0,W0 	
	CLR [W0]
	INC W1,W1
	MOV #54,W2
	CP W1,W2
	BRA LTU,INIT_DPP1 	
	CLR DPP_AMT
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DIS_ALLSEL:			;;
	CLR W1			;;
DIS_ALLSEL1:			;;
	MUL.UU W1,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	MOV #0xFFF9,W0		;;
	AND W0,[W5],[W5]	;;
	INC W1,W1		;;
	CP W1,#9		;;
	BRA NC,DIS_ALLSEL1	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SET_DPPSEL:			;;
	MUL.UU W0,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	MOV #0x0006,W0		;;
	IOR W0,[W5],[W5]	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;W1=ADDRESS
;;W0=CNT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
MENU_ICON_XY:			;;
	CALL XYA_TBL		;;
	MUL.UU W0,#4,W2		;;	
	ADD W5,W2,W5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W5++],W0		;;
	MOV W0,LCDX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W5],W0		;;
	MOV W0,LCDY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_DPP_ONCE:			;;	
	BSET FLAGB,#DPP_ONCE_F	;;
	BSET FLAGB,#DPP_ON_F	;;
	MOV DPP_AMT,W4		;;	
	MUL.UU W4,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	MOV #0x000F,W0		;;
	BRA LOAD_DPP0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_DPP_DYM:			;;
	MOV DPP_AMT,W4		;;	
	MUL.UU W4,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0007,W0		;;
	BRA LOAD_DPP0		;;
LOAD_DPP:			;;	
	MOV DPP_AMT,W4		;;	
	MUL.UU W4,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0003,W0		;;
LOAD_DPP0:			;;
	MOV W0,[W5++]		;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,[W5++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	SETM W0			;;
	MOV W0,[W5++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX,W0		;;
	MOV W0,[W5++]		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY,W0		;;
	MOV W0,[W5]		;;
	INC DPP_AMT		;;
	RETURN			;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DRAW_DPPSEL:			;;
	CP0 W0			;;
	BRA NZ,$+4		;;
	RETURN			;;
	DEC W0,W0		;;
	CP W0,#9		;;
	BRA NC,$+4		;;
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL XYA_TBL		;;
	MUL.UU W0,#4,W2		;;	
	ADD W5,W2,W5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W5++],W0	;;
	SUB W0,#3,W0		;;
	MOV W0,LCDX		;;
	TBLRDL [W5++],W0	;;
	SUB W0,#3,W0		;;
	MOV W0,LCDY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #3,W0		;;
	MOV W0,BMPX		;;
	MOV #42,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	MOV #42,W0		;;
	MOV W0,BMPX		;;
	MOV #3,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #39,W0		;;
	ADD LCDX		;;
	MOV #3,W0		;;
	MOV W0,BMPX		;;
	MOV #42,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	MOV #39,W0		;;
	SUB LCDX		;;
	MOV #39,W0		;;
	ADD LCDY		;;
	MOV #42,W0		;;
	MOV W0,BMPX		;;
	MOV #3,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_LANG:			;;
	PUSH W0			;;
	MOV LANG_SET,W0		;;
	ADD LANG_SET,WREG	;;	
	ADD W1,W0,W1		;;
	TBLRDL [W1],W1		;;
	POP W0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;FLAG 
;BIT1,0
;00 DOWN TO UP
;01 UP TO DOWN
;10 LEFT TO RIGHT
;11 RIGHT TIO LEFT
;BIT 2 RETURN/STOP 
;BIT 3,4 STEP 1,2,3,4 
;USED REGISTER
;0 STATUS_FLAG
;1 TABLE_ADDRESS
;2 TIMER_BUF 
;3 NOW_X
;4 NOW_Y
;==============
;STATUS FLAG
;B0 PRESENT
;B1 FORCE
;B2 START 
;B3 STOP   	
;B4 BMP/FONT
DYBMP_TEST_TBL:
	.WORD 0x0005	;BIT01 DIRECT,B2 PRESENT,B3 STOP,B8 256 COLOR
	.WORD BNZ_ADR0 ;BMP_ADDRESS L
	.WORD BNZ_ADR1 ;BMP_ADDRESS H
	.WORD 1000    	;BETWEEN TIME  
	.WORD 0		;FIRST X
	.WORD -40	;FIRST Y
	.WORD 0		;END X
	.WORD 40	;END Y
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 40 	;LIMIT YT	
	.WORD 119	;LIMIT YB
	.WORD 0x8050	;BMPX,BMPY
	.WORD 0x0000	;BACK GROUND COLOR

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
DYSTR_TEST0_TBL:
	.WORD 0x0000	;FLAG
	.WORD 1000 	;BETWEEN TIME  
	.WORD 30000     ;FIRST_TIME
	.WORD 30000 	;END_TIME 		
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 128	;LIMIT YT	
	.WORD 143	;LIMIT YB
	.WORD 0xFFFF	;FRONT COLOR
	.WORD 0x0000	;BACK GROUND COLOR
	.WORD 128 	;FIRST X
	.WORD 0 	;END X

DYSTR_TEST1_TBL:
	.WORD 0x0000	;FLAG
	.WORD 1000 	;BETWEEN TIME  
	.WORD 30000      ;FIRST_TIME
	.WORD 30000 	;END_TIME 		
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 144	;LIMIT YT	
	.WORD 159	;LIMIT YB
	.WORD 0xFFFF	;FRONT COLOR
	.WORD 0x0000	;BACK GROUND COLOR
	.WORD 128 	;FIRST X
	.WORD 0 	;END X


DYSTR_TEST_STRB:
	.WORD tbloffset(DYSTR_TEST_STR_0)
	.WORD tbloffset(DYSTR_TEST_STR_1)
        .WORD tbloffset(DYSTR_TEST_STR_2)
	.WORD tbloffset(DYSTR_TEST_STR_3)
DYSTR_TEST_STR_0:
	.ASCII "ABCDEFGHIJKL\0"
DYSTR_TEST_STR_1:
	.ASCII "DYSTR_TEST_STR_1\0"
DYSTR_TEST_STR_2:
	.ASCII "DYSTR_TEST_STR_2\0"
DYSTR_TEST_STR_3:
	.ASCII "DYSTR_TEST_STR_3\0"
	
DYSTR_TEST0_ADR:
	.WORD tbloffset(DYSTR_TEST_STRB)
	.WORD tbloffset(DYSTR_TEST0_TBL)
DYSTR_TEST1_ADR:
	.WORD tbloffset(DYSTR_TEST_STRB)
	.WORD tbloffset(DYSTR_TEST1_TBL)



	
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
	TBLRDL [W1++],W0		;;ENDY
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
	DEC DPPB3		;;
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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FIXSTR:				;;
	CALL TRANS_LANG		;;			
	CALL ENSTR_LEN		;;
	MOV LCDX_LIM0,W0	;;
	SUB LCDX_LIM1,WREG	;;
	INC W0,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV STR_LEN,W2          ;;	
	SUB W0,W2,W0		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,BMPX		;;
	BTSC SR,#C		;;
	INC W0,W0		;;
	PUSH W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #16,W0		;;
	MOV W0,BMPY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;	
	MOV W0,LCDX		;;
	MOV LCDY_LIM0,W0	;;	
	MOV W0,LCDY		;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPX,W0		;;
	ADD LCDX		;; 
	CALL ENSTR		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	POP BMPX		;;
	CALL DISP_BLK		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELSTR:				;;
	CP0 DPPSEL_CNT		;;	
	BRA NZ,$+4		;;
	RETURN			;;
	CALL INIT_LCDLIM
	CALL C_WTBK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC DPPSEL_CNT,WREG	;;
	MUL.UU W0,#8,W2		;;
	MOV W2,W0		;;
	ADD MENU_ADR,WREG	;;
	ADD W0,#8,W1		;;
	PUSH W1			;;
	TBLRDL [W1],W1		;;
	CALL TRANS_LANG		;;			
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL ENSTR_LEN		;;
	MOV STR_LEN,W2          ;;	
	MOV #128,W0		;;
	SUB W0,W2,W0		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,BMPX		;;
	MOV #16,W0		;;
	MOV W0,BMPY		;;
	MOV #128,W0		;;
	MOV W0,LCDY		;;
	CLR LCDX	 	;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPX,W0		;;
	ADD LCDX		;; 
	CALL ENSTR		;;
	CALL DARKEND		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	POP W1			;;
	INC2 W1,W1		;;
	TBLRDL [W1],W1		;;
	CALL TRANS_LANG		;;			
	CALL ENSTR_LEN		;;
	MOV STR_LEN,W2          ;;		;;
	MOV #128,W0		;;
	SUB W0,W2,W0		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,BMPX		;;
	MOV #16,W0		;;
	MOV W0,BMPY		;;
	MOV #144,W0		;;
	MOV W0,LCDY		;;
	CLR LCDX	 	;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPX,W0		;;
	ADD LCDX		;; 
	CALL ENSTR		;;
	CALL DARKEND		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;Z=0;NO ENTRY
;Z=1;YES ENTRY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_MENU_IS_ENTRY:		;;
	CP0 DPPSEL_CNT		;;	
	BRA NZ,$+4		;;
	RETURN			;;
	DEC DPPSEL_CNT,WREG	;;
	MUL.UU W0,#8,W2		;;
	MOV W2,W0		;;
	ADD MENU_ADR,WREG	;;
	ADD W0,#6,W1		;;
	TBLRDL [W1],W0		;;
	CP0 W0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 
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
	CALL C_GRGR		;; 
	CALL CHK_MENU_IS_ENTRY	;;
	BRA NZ,$+4		;;
	CALL C_HGRHGR		;; 
	MOV DPPSEL_CNT,W0	;;
	MOV W0,DPPSEL_PRE	;;	
	CALL DRAW_DPPSEL	;;
	CALL SELSTR		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TEST_DYBMP:
	CALL INIT_DYBMP
	LOFFS1 #DYBMP_TEST_TBL
	CALL LOAD_DYBMP
TEST_DYBMP1:
	CALL DYBMP
	CALL TMR2PRG
	CALL KEYBO
	BRA TEST_DYBMP1

TEST_DYSTR:
	CALL INIT_DYBMP
	LOFFS1 #DYSTR_TEST0_ADR
	CALL LOAD_DYSTR
	LOFFS1 #DYSTR_TEST1_ADR
	CALL LOAD_DYSTR
TEST_DYSTR1:
	CALL DYBMP
	CALL TMR2PRG
	CALL KEYBO
	BRA TEST_DYSTR1



TEST_DPP:
	CALL INIT_DPP
	LOFFS1 #A1_ARM_TBL
	MOV #0,W0
	CALL LOAD_DPP
	LOFFS1 #A2_ARM_S_TBL
	MOV #1,W0
	CALL LOAD_DPP
	LOFFS1 #A3_ARM_ST_TBL
	MOV #2,W0
	CALL LOAD_DPP
	LOFFS1 #A4_PANIC_TBL
	MOV #3,W0
	CALL LOAD_DPP
	LOFFS1 #A6_CH2_TBL
	MOV #4,W0
	CALL LOAD_DPP
	LOFFS1 #A7_CH3_TBL
	MOV #5,W0
	CALL LOAD_DPP
;	LOFFS1 #A8_CH4_TBL
;	MOV #6,W0
;	CALL LOAD_DPP
;	LOFFS1 #A10_L_SENSOR_TBL
;	MOV #7,W0
;	CALL LOAD_DPP
;	LOFFS1 #A11_H_SENSOR_TBL
;	MOV #8,W0
;	CALL LOAD_DPP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 #DPPF3_TBL
	MOV #6,W0
	CALL LOAD_DPP
	LOFFS1 #DPPF2_TBL
	MOV #7,W0
	CALL LOAD_DPP
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 #DPPF1_TBL
	MOV #8,W0
	CALL LOAD_DPP



	CLR DPPSEL_CNT
	CLR DPPSEL_PRE 
TEST_DPP1:
	CALL DPP
	CALL DPPSEL
	CALL TMR2PRG
	CALL KEYBO
	CALL DPP_KEY	
	BRA TEST_DPP1
DPP_KEY:
	BTSC KEY_FLAG,#0
	BRA DPP_KEY0
	BTSC KEY_FLAG,#1
	BRA DPP_KEY1
	BTSC KEY_FLAG,#2
	BRA DPP_KEY2
	RETURN
DPP_KEY0:
	INC DPPSEL_CNT
	MOV #10,W0
	CP DPPSEL_CNT
	BRA NC,$+4
	CLR DPPSEL_CNT
	RETURN
DPP_KEY1:
	RETURN
DPP_KEY2:
	RETURN





SETM_A_KEY:
SETM_B_KEY:
SETM_C_KEY:
SETM_D_KEY:
SETM_E_KEY:
SETM_F_KEY:
SETM_G_KEY:
SETM_H_KEY:
SETM_I_KEY:
SETM_J_KEY:
SETM_K_KEY:
SETM_L_KEY:
SETM_M_KEY:
SETM_N_KEY:
SETM_O_KEY:
SETM_P_KEY:
SETM_Q_KEY:
SETM_R_KEY:
SETM_S_KEY:
SETM_T_KEY:
SETM_KEY:
	BTSC KEY_FLAG,#0
	BRA SETM_INCSEL
	BTSC KEY_FLAG,#1
	BRA SETM_ESC
	BTSC KEY_FLAG,#2
	BRA SETM_ENTRY
	RETURN


SETM_RETURN:
	POP W0
	POP W0
	MOV #SET_BUF,W1
	CALL VERIFY_FRAM
	BRA Z,SETM_RETURN1
	CALL ERASE_FRAM
	MOV #SET_BUF,W1
	CALL WRITE_FRAM
SETM_RETURN1:
	RETURN 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_INCSEL:			;;
	INC SETMSEL_CNT		;;
	MOV SETMSEL_AMT,WREG	;;
	CP SETMSEL_CNT		;;
	BRA NC,$+4		;;
	CLR SETMSEL_CNT		;;
	POP W0			;;
	POP W0			;;
	GOTO SETM_PRG_KIN	;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_ESC:			;;
	CALL SAVE_SETM_SET	;;
	CP0 SETM_STK_CNT	;;	
	BRA NZ,$+4		;;
	BRA SETM_RETURN		;;
	CALL POP_SETM		;;
	POP W0			;;
	POP W0			;;
	BRA SETM_PRG		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_ENTRY:			;;
	MOV SETMSEL_CNT,WREG	;;
	MUL.UU W0,#6,W2		;;
	MOV W2,W0		;;
	ADD SETM_ADR,WREG	;;
	ADD W0,#8,W1		;;
	TBLRDL [W1],W0		;;
	CP0 W0			;;
	BRA NZ,$+4 		;;
	BRA SETM_ENTRY1		;;	
	PUSH W0			;;
	CALL PUSH_SETM		;;
	POP W0			;;
	MOV W0,SETM_ADR		;;
	CLR SETMSEL_CNT		;;
	POP W0			;;
	POP W0			;;
	BRA SETM_PRG		;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETM_ENTRY1:			;;
	MOV SETMSEL_CNT,W0	;;
	MOV W0,SETMNOW_CNT	;;
	POP W0			;;
	POP W0			;;
	GOTO SETM_PRG_KIN	;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;























MENU_A_KEY:
	BTSC KEY_FLAG,#KR0_F
	BRA MENU_INCSEL
	BTSC KEY_FLAG,#KR2_F
	BRA MENU_ESC
	BTSC KEY_FLAG,#KC0_F
	BRA MENU_ENTRY
	RETURN
MENUA_ESC:
	POP W0
	POP W0
	MOV #SET_BUF,W1
	CALL VERIFY_FRAM
	BRA Z,MENUA_ESC1
	CALL ERASE_FRAM
	MOV #SET_BUF,W1
	CALL WRITE_FRAM
MENUA_ESC1:
	RETURN 
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
	CALL SAVE_MENU_SET	;;
	CP0 MENU_STK_CNT	;;	
	BRA NZ,$+4		;;
	BRA MENUA_ESC		;;
	CALL POP_MENU		;;
	POP W0			;;
	POP W0			;;
	BRA MENU_PRG		;;
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
	CP0 W0			;;
	BRA NZ,$+4 		;;
	RETURN			;;
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

	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUSH_SETM:				;;
	MOV SETM_STK_CNT,W0		;;
	MUL.UU W0,#4,W2			;;
	MOV #SETM_STK_BUF,W0		;;
	ADD W2,W0,W5			;;
	MOV SETM_ADR,W0			;;
	MOV W0,[W5++]			;;
	MOV SETMSEL_CNT,W0		;;
	MOV W0,[W5]			;;
	INC SETM_STK_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
POP_SETM:				;;
	DEC SETM_STK_CNT		;;
	MOV SETM_STK_CNT,W0		;;
	MUL.UU W0,#4,W2			;;
	MOV #SETM_STK_BUF,W0		;;
	ADD W2,W0,W5			;;
	MOV SETM_ADR,W0			;;
	MOV [W5++],W0			;;
	MOV W0,SETM_ADR			;;
	MOV [W5],W0			;;
	MOV W0,SETMSEL_CNT		;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUSH_MENU:				;;
	MOV MENU_STK_CNT,W0		;;
	MUL.UU W0,#4,W2			;;
	MOV #MENU_STK_BUF,W0		;;
	ADD W2,W0,W5			;;
	MOV MENU_ADR,W0			;;
	MOV W0,[W5++]			;;
	MOV DPPSEL_CNT,W0		;;
	MOV W0,[W5]			;;
	INC MENU_STK_CNT		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
POP_MENU:				;;
	DEC MENU_STK_CNT		;;
	MOV MENU_STK_CNT,W0		;;
	MUL.UU W0,#4,W2			;;
	MOV #MENU_STK_BUF,W0		;;
	ADD W2,W0,W5			;;
	MOV MENU_ADR,W0			;;
	MOV [W5++],W0			;;
	MOV W0,MENU_ADR			;;
	MOV [W5],W0			;;
	MOV W0,DPPSEL_CNT		;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;26000 STEP                    ;;
ENCODE:                        ;;
        MOV #144,W0            ;;
        MOV W0,R0              ;;
ENCODE01:                      ;;
        MOV #1,W0              ;;
        BTSC HOP3,#4           ;;BTC
        MOV #16,W0             ;;
        MOV W0,W2              ;;
        BTSS HOP2,#1           ;;
        BRA ENCODE1            ;;
        RLNC W2,W2             ;;
        RLNC W2,W2             ;;
ENCODE1:                       ;;
        BTSC HOP1,#1           ;;
        RLNC W2,W2             ;;
        BTSC HOP4,#7           ;;
        BRA ENCODE2            ;;
        MOV #0x2E,W0           ;;
        BTSC HOP4,#2           ;;
        MOV #0x74,W0           ;;
        BRA ENCODE3            ;;
ENCODE2:                       ;;
        MOV #0x5C,W0           ;;
        BTSC HOP4,#2           ;;
        MOV #0x3A,W0           ;;
ENCODE3:                       ;;
        AND W0,W2,W2           ;;
        MOV #0,W0              ;;
        BTSS SR,#Z            ;;
        MOV #1,W0              ;;
        XOR HOP3,WREG          ;;
        XOR HOP1,WREG          ;;
        XOR KEY0,WREG          ;;
        MOV W0,W2              ;;
        RRC W2,W2              ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET HOP4,#8 	       ;;	
	BTSS SR,#C	       ;;	
	BCLR HOP4,#8           ;; 
        RRC HOP4               ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET HOP3,#8 	       ;;	
	BTSS SR,#C	       ;;	
	BCLR HOP3,#8           ;; 
        RRC HOP3               ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET HOP2,#8 	       ;;	
	BTSS SR,#C	       ;;	
	BCLR HOP2,#8           ;; 
        RRC HOP2               ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET HOP1,#8 	       ;;	
	BTSS SR,#C	       ;;	
	BCLR HOP1,#8           ;; 
        RRC HOP1               ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;
ENCODE4:                       ;;
        RRC KEY0,WREG          ;;
	RRC KEY3	       ;;
	RRC KEY2	       ;; 	
	RRC KEY1	       ;;	
	RRC KEY0	       ;;	
	DEC R0   	       ;;	
        BRA NZ,ENCODE01        ;;50*528
        MOV HOP1,W0            ;;
        XOR HOP2,WREG          ;;
        XOR HOP3,WREG          ;;
        XOR HOP4,WREG          ;;
        XOR HOP0               ;;
        RETURN                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_KEY1:			;;
        MOV #0x01,W0		;;
	MOV W0,KEY0		;;
        MOV #0x23,W0		;;
	MOV W0,KEY1		;;
        MOV #0x45,W0		;;
	MOV W0,KEY2		;;
        MOV #0x67,W0		;;
	MOV W0,KEY3		;;
        MOV #0x89,W0		;;
	MOV W0,KEY4		;;
        MOV #0xAB,W0		;;
	MOV W0,KEY5		;;
        MOV #0xCD,W0		;;
	MOV W0,KEY6		;;
        MOV #0xEF,W0		;;
	MOV W0,KEY7		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_KEY:			;;
        MOV #0x2301,W0		;;
	MOV W0,KEY0		;;
        MOV #0x6745,W0		;;
	MOV W0,KEY1		;;
        MOV #0xAB89,W0		;;
	MOV W0,KEY2		;;
        MOV #0xEFCD,W0		;;
	MOV W0,KEY3		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;C=PARI BIT;;;;;;;;;;;;
PARI_PRG:                 ;;
        MOV W0,W2         ;;
        SWAP.B W2         ;;
        XOR W0,W2,W2      ;;
        ;;;;;;;;;;;;;;;;;;;;
        MOV R5,W0         ;;
        XOR W0,W2,W2      ;;
        ;;;;;;;;;;;;;;;;;;;;
	RRC W2,W0	  ;;	
        XOR W0,W2,W2      ;;
        ;;;;;;;;;;;;;;;;;;;;
        MOV #1,W0         ;;
        BTSC W2,#2        ;;
        MOV #0,W0         ;;
        XOR W0,W2,W2      ;;
        ;;;;;;;;;;;;;;;;;;;;
        RRC W2,W2         ;;
        RLC R5,WREG       ;;
        MOV W0,R1         ;;
        RETURN            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;DPPB0 LOW BYTE FLAG
;      HIGH BYTE STATIC SHOW PAGE_CNT
;      FLAG.0 1=PRESENT
;      FLAG.1 1=FORCE SHOW
;      FLAG.2 1=DYNAMIC
;      FLAG.3 1=ONCE
;DPPB1 TBL ADDRESS
;DPPB2 TIMER LIMIT 
;DPPB3 NOW PAGE
;DPPB4 LCDX
;DPPB5 LCDY


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FORCE_ICON_ALL:			;;
	CLR ICONP_CNT		;;
FORCE_ICON_ALL1:		;;
	MOV #12,W0		;;
	MUL ICONP_CNT		;;
	MOV #ICONP_BUF,W0	;;
	ADD W0,W2,W2		;;
	BSET [W2],#1		;;FORCE BIT
	INC ICONP_CNT		;;
	MOV #24,W0		;;
	CP ICONP_CNT		;;
	BRA LTU,FORCE_ICON_ALL1	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ICONP:				;;
	BSET FLAGA,#ICONP_F	;;	 
	INC ICONP_CNT		;;
	MOV #24,W0		;;
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
	MOV #0x9,W0		;;
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
	SUB TMR2,WREG		;;
	BTSC W0,#15		;;	
	RETURN			;;
	INC DPPB3		;;
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
	ADD TMR2,WREG		;;
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
	MOV W0,FADR0		;;
	TBLRDL [W1++],W0	;;
	MOV W0,FADR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1],W0		;;
	CP W0,#0		;;
	BTSC SR,#Z 		;;
	MOV R1,W0		;;
	ADD TMR2,WREG		;;
	MOV W0,DPPB2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL GET_BLKC8		;;
	CALL DISP_BMP8		;;
	BRA DPP_END		;;	
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
	ADD TMR2,WREG		;;
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
	ADD TMR2,WREG		;;
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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DPPFA:			;;
	PUSH R0			;;
	MOV BMPY,W0		;;
	SUB #16,W0 		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,R0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	MOV BMPY,W0		;;
	ADD LCDY		;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR0,W1		;;
	CALL ENSTR_LEN		;;
	MOV STR_LEN,W2          ;;		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH LCDX		;;
	PUSH BMPX		;;
	MOV W2,W0		;;
	SUB BMPX,WREG		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,BMPX		;;
	MOV #16,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPX,W0		;;
	ADD LCDX		;;		
	MOV FADR0,W1		;;
	CALL ENSTR		;;
	CALL DISP_BLK		;;
	MOV #16,W0		;;
	ADD LCDY		;;
	POP BMPX		;; 
	POP LCDX		;;
	MOV R0,W0		;;
	MOV W0,BMPY 		;;
	CALL DISP_BLK		;;
 	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_DPPFB:			;;
	PUSH R0			;;
	MOV BMPY,W0		;;
	SUB #32,W0 		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,R0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	MOV BMPY,W0		;;
	ADD LCDY		;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR0,W1		;;
	CALL ENSTR_LEN		;;
	MOV STR_LEN,W2          ;;		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH LCDX		;;
	PUSH BMPX		;;
	MOV W2,W0		;;
	SUB BMPX,WREG		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,BMPX		;;
	MOV #16,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPX,W0		;;
	ADD LCDX		;;		
	MOV FADR0,W1		;;
	CALL ENSTR		;;
	CALL DISP_BLK		;;
	MOV #16,W0		;;
	ADD LCDY		;;
	POP BMPX		;; 
	POP LCDX		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W2			;;
	MOV FADR1,W1		;;
DISP_DPPFB3:			;;
        TBLRDL [W1],W0		;;
	AND #255,W0		;;
	BRA Z,DISP_DPPFB4	;;
	INC W2,W2		;; 
        TBLRDL [W1],W0		;;
	SWAP W0			;;
	AND #255,W0		;;
	BRA Z,DISP_DPPFB4	;;
	INC W2,W2		;; 
	INC2 W1,W1		;;
	BRA DISP_DPPFB3		;;	
DISP_DPPFB4: 			;;
	MOV #8,W0		;;
	MUL.UU W2,W0,W2		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH LCDX		;;
	PUSH BMPX		;;
	MOV W2,W0		;;
	SUB BMPX,WREG		;;
	BCLR SR,#C		;;
	RRC W0,W0		;;
	MOV W0,BMPX		;;
	MOV #16,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPX,W0		;;
	ADD LCDX		;;		
	MOV FADR1,W1		;;
	CALL ENSTR		;;
	CALL DISP_BLK		;;
	MOV #16,W0		;;
	ADD LCDY		;;
	POP BMPX		;; 
	POP LCDX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV R0,W0		;;
	MOV W0,BMPY 		;;
	CALL DISP_BLK		;;
 	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

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
	MOV #20,W0		;;
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





DYMP:
	TBLRDL [W1++],W0
	MOV W0,R0
	;;;;;;;;;;;	
	TBLRDL [W1++],W0
	MOV W0,R1
	;;;;;;;;;;;;
	TBLRDL [W1++],W0
	MOV W0,BMPX
	;;;;;;;;;;;;
	TBLRDL [W1++],W0
	MOV W0,BMPY
	;;;;;;;;;;;;
	TBLRDL [W1++],W0
	MOV W0,LCDX
	;;;;;;;;;;;;
	TBLRDL [W1++],W0
	MOV W0,LCDY
DYMP1:	
	TBLRDL [W1++],W0
	MOV W0,FADR0
	TBLRDL [W1++],W0
	MOV W0,FADR1
	TBLRDL [W1++],W0
	MOV W0,R2
	PUSH W1
	PUSH BMPX
	PUSH BMPY
	PUSH LCDX
	PUSH LCDY
	;;;;;;;;;;
	CALL GET_BLKC8
	CALL DISP_BMP8	
	MOV R2,W0
	CP0 W0
	BTSC SR,#Z 
	MOV R1,W0
	CALL DLYMX
	POP LCDY 
	POP LCDX 
	POP BMPY 	
	POP BMPX 	
	POP W1
	;;;;;;;;;;;;;;;
	DEC R0
	BRA NZ,DYMP1  
	RETURN



R_DYMP:
	TBLRDL [W1++],W0
	MOV W0,R0
	;;;;;;;;;;;	
	TBLRDL [W1++],W0
	MOV W0,R1
	;;;;;;;;;;;;
	TBLRDL [W1++],W0
	MOV W0,BMPX
	;;;;;;;;;;;;
	TBLRDL [W1++],W0
	MOV W0,BMPY
	;;;;;;;;;;;;
	TBLRDL [W1++],W0
	MOV W0,LCDX
	;;;;;;;;;;;;
	TBLRDL [W1++],W0
	MOV W0,LCDY
R_DYMP1:	
	TBLRDL [W1++],W0
	MOV W0,FADR0
	TBLRDL [W1++],W0
	MOV W0,FADR1
	TBLRDL [W1++],W0
	MOV W0,R2
	PUSH W1
	PUSH BMPX
	PUSH BMPY
	PUSH LCDX
	PUSH LCDY
	;;;;;;;;;;
	CALL GET_BMPS
	CALL DISP_BMP24	
	MOV R2,W0
	CP0 W0
	BTSC SR,#Z 
	MOV R1,W0
	CALL DLYMX
	POP LCDY 
	POP LCDX 
	POP BMPY 	
	POP BMPX 	
	POP W1
	;;;;;;;;;;;;;;;
	DEC R0
	BRA NZ,R_DYMP1  
	RETURN






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_LCDLIM:			;;
	CLR LCDX_LIM0		;;
	MOV #127,W0		;;
	MOV W0,LCDX_LIM1	;;
	CLR LCDY_LIM0		;;
	MOV #159,W0		;;
	MOV W0,LCDY_LIM1	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_BMPS:			;;
	CALL WAIT_FLASH_READY	;;
	BCLR FCS,#FCS_P		;;
	MOV #0x03,W0		;;
	CALL SPIPRG		;;
	MOV FADR1,W0		;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	SWAP W0			;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	CALL SPIPRG		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_BMPC:			;;
	CALL WAIT_FLASH_READY	;;
	BCLR FCS,#FCS_P		;;
	MOV #0x03,W0		;;
	CALL SPIPRG		;;
	MOV FADR1,W0		;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	SWAP W0			;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	CALL SPIPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SPIPRG		;;
	CALL SPIPRG		;;
	CALL SPIPRG		;;
	CALL SPIPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SPIPRG		;;
	AND #255,W0		;;
	MOV W0,BMPX		;;
	CALL SPIPRG		;;
	AND #255,W0		;;
	MOV W0,BMPY		;;
	CALL SPIPRG		;;
	CALL SPIPRG		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_BMPC8:			;;
	CALL WAIT_FLASH_READY	;;
	BCLR FCS,#FCS_P		;;
	MOV #0x03,W0		;;
	CALL SPIPRG		;;
	MOV FADR1,W0		;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	SWAP W0			;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	CALL SPIPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SPIPRG		;;
	CALL SPIPRG		;;
	CALL SPIPRG		;;
	CALL SPIPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL SPIPRG		;;
	AND #255,W0		;;	
	MOV W0,BMPX		;;
	CALL SPIPRG		;;
	AND #255,W0		;;	
	MOV W0,BMPY		;;
	CALL SPIPRG		;;
	CALL SPIPRG		;;
	PUSH R0			;;
	CLR R0			;;
	MOV #BMPC,W1		;;
GET_BMPC8A:			;;
	CALL SPIPRG		;;	
	AND #255,W0		;;
	MOV W0,W2		;;
	CALL SPIPRG		;;
	AND #255,W0		;;
	SWAP W0			;;
	IOR W0,W2,[W1]		;;
	INC2 W1,W1
	INC R0			;;
	MOV #256,W0		;;
	CP R0			;;
	BRA NC,GET_BMPC8A 	;;	
	POP R0			;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_BLKC8:			;;
	CALL WAIT_FLASH_READY	;;
	BCLR FCS,#FCS_P		;;
	MOV #0x03,W0		;;
	CALL SPIPRG		;;
	MOV FADR1,W0		;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	SWAP W0			;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	CALL SPIPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH R0			;;
	PUSH W1			;;
	PUSH W2			;;
	CLR R0			;;
	MOV #BMPC,W1		;;
GET_BLKC8A:			;;
	CALL SPIPRG		;;	
	AND #255,W0		;;
	MOV W0,W2		;;
	CALL SPIPRG		;;
	AND #255,W0		;;
	SWAP W0			;;
	IOR W0,W2,[W1]		;;
	INC2 W1,W1		;;
	INC R0			;;
	MOV #256,W0		;;
	CP R0			;;
	BRA NC,GET_BLKC8A 	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0200,W0		;;
	ADD FADR0		;;
	BTSC SR,#C		;;
	INC FADR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	POP W2			;;
	POP W1			;;		
	POP R0			;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GET_F8BMPC:			;;
	TBLRDL [W1++],W0		;;
	TBLRDL [W1++],W0		;;
	TBLRDL [W1++],W0		;;
	MOV W0,BMPX		;;
	SWAP W0			;;
	MOV W0,BMPY		;;
	MOV #255,W0		;;
	AND BMPX		;;
	AND BMPY		;;
	TBLRDL [W1++],W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH R0			;;
	CLR R0			;;
	MOV #BMPC,W2		;;
GET_F8BMPC1:			;;
	TBLRDL [W1++],W0		;;
	MOV W0,[W2++]		;;
	INC R0			;;
	MOV #256,W0		;;
	CP R0			;;
	BRA NC,GET_F8BMPC1 	;;	
	POP R0			;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_F8BMP:			;;	
	PUSH R0			;;
	PUSH R1			;;
	DEC BMPY,WREG		;;
	ADD LCDY		;;
	MOV BMPY,W0		;;
	MOV W0,R1		;;
DISP_F8BMP0:			;;
	BCLR FLAGA,#GOTOXY_F	;;
	MOV BMPX,W0		;;
	MOV W0,R0		;;
DISP_F8BMP1:			;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1],W0		;;
	BTSC W1,#0		;;
	SWAP W0			;;
	AND #255,W0		;;
	MOV #BMPC,W2		;;
	ADD W0,W2,W2		;;
	ADD W0,W2,W2		;;
	MOV [W2],W3		;;
	INC W1,W1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;	
	CP LCDX			;;
	BRA LT,DISP_F8BMP4	;;
	MOV LCDX_LIM1,W0	;;
	CP LCDX			;;
	BRA GT,DISP_F8BMP4	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0	;;	
	CP LCDY			;;
	BRA LT,DISP_F8BMP4	;;
	MOV LCDY_LIM1,W0	;;
	CP LCDY			;;
	BRA GT,DISP_F8BMP4	;;
DISP_F8BMP2:			;;
	BTSC FLAGA,#GOTOXY_F	;;
	BRA DISP_F8BMP3		;;
	BSET FLAGA,#GOTOXY_F	;;
	CALL GOTOXY		;;
	BSET LCDRS,#LCDRS_P	;;
	BCLR LCDCS,#LCDCS_P	;;
DISP_F8BMP3:			;;
	MOV W3,W0		;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	MOV W3,W0		;;
	SWAP W0			;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	BRA DISP_F8BMP5		;;
DISP_F8BMP4:			;;
	BCLR FLAGA,#GOTOXY_F	;;	
	BSET LCDCS,#LCDCS_P	;;
DISP_F8BMP5:			;;
	INC LCDX		;;
	DEC R0			;;
	BRA NZ,DISP_F8BMP1	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDCS,#LCDCS_P	;;
	MOV BMPX,W0		;;
	SUB LCDX		;;
	MOV #1,W0		;;
	SUB LCDY		;;
	DEC R1			;;
	BRA NZ,DISP_F8BMP0	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC LCDY		;;	
	BSET FCS,#FCS_P		;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_BLK:			;;
	CP0 BMPX		;;
	BRA GT,$+4		;;
	RETURN			;;
	CP0 BMPY		;;
	BRA GT,$+4		;;
	RETURN			;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH LCDX		;;
	PUSH LCDY		;;
	DEC BMPY,WREG		;;
	ADD LCDY		;;
	MOV BMPY,W0		;;
	MOV W0,R1		;;
DISP_BLK0:			;;
	BCLR FLAGA,#GOTOXY_F	;;
	MOV BMPX,W0		;;
	MOV W0,R0		;;
DISP_BLK1:			;;		
	BTSC FLAGA,#GOTOXY_F	;;
	BRA DISP_BLK2		;;
	BSET FLAGA,#GOTOXY_F	;;
	CALL GOTOXY		;;
	BSET LCDRS,#LCDRS_P	;;
	BCLR LCDCS,#LCDCS_P	;;
DISP_BLK2:			;;
	MOV LCDX_LIM0,W0	;;	
	CP LCDX			;;
	BRA LT,DISP_BLK2A	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM1,W0	;;
	CP LCDX			;;
	BRA GT,DISP_BLK2A  	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0	;;	
	CP LCDY			;;
	BRA LT,DISP_BLK2A	;;
	MOV LCDY_LIM1,W0	;;
	CP LCDY			;;
	BRA GT,DISP_BLK2A  	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV COLOR_B,W0		;;
	SWAP W0			;;	
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	SWAP W0			;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	BRA DISP_BLK3 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_BLK2A:			;;
	BCLR FLAGA,#GOTOXY_F	;;	
	BSET LCDCS,#LCDCS_P	;;
DISP_BLK3:			;;	
	INC LCDX		;;
	DEC R0			;;
	BRA NZ,DISP_BLK1	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDCS,#LCDCS_P	;;
	MOV BMPX,W0		;;
	SUB LCDX		;;
	MOV #1,W0		;;
	SUB LCDY		;;
	DEC R1			;;
	BRA NZ,DISP_BLK0	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC LCDY		;;	
	BSET FCS,#FCS_P		;;
	POP LCDY		;;
	POP LCDX		;;
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
	DEC BMPY,WREG		;;
	ADD LCDY		;;
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
	MOV #1,W0		;;
	SUB LCDY		;;
	DEC R1			;;
	BRA NZ,DISP_BMP240	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC LCDY		;;	
	BSET FCS,#FCS_P		;;
	POP R3			;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_BMP8:			;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH R2			;;
	DEC BMPY,WREG		;;
	ADD LCDY		;;
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
	MOV BMPX,W0		;;
	SUB LCDX		;;
	MOV #1,W0		;;
	SUB LCDY		;;
	DEC R1			;;
	BRA NZ,DISP_BMP80	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC LCDY		;;	
	BSET FCS,#FCS_P		;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_INP8:			;;
	BSET FCS,#FCS_P		;;
	PUSH R0			;;
	PUSH R1			;;
	PUSH R2			;;
	DEC BMPY,WREG		;;
	ADD LCDY		;;
	MOV BMPY,W0		;;
	MOV W0,R1		;;
DISP_INP80:			;;
	PUSH FADR0		;;
	PUSH FADR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;
	SUB LCDX_LIM1,WREG	;;
	INC W0,W2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY,W0		;;
	SUB LCDY_LIM1,WREG	;;
	MUL.UU W0,W2,W2		;;
	MOV LCDX,W0		;;
	ADD W0,W2,W0		;;
	ADD FADR0		;;
	BTSC SR,#C		;;
	INC FADR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL WAIT_FLASH_READY	;;
	BCLR FCS,#FCS_P		;;
	MOV #0x03,W0		;;
	CALL SPIPRG		;;
	MOV FADR1,W0		;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	SWAP W0			;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	CALL SPIPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FLAGA,#GOTOXY_F	;;
	MOV BMPX,W0		;;
	MOV W0,R0		;;
DISP_INP8A:			;;		
	MOV W0,SPI1BUF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
DISP_INP8A0:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_INP8A0		;;
	MOV SPI1BUF,W0		;;
	MOV W0,R2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGA,#GOTOXY_F	;;
	BRA DISP_INP8B		;;
	BSET FLAGA,#GOTOXY_F	;;
	CALL GOTOXY		;;
	BSET LCDRS,#LCDRS_P	;;
	BCLR LCDCS,#LCDCS_P	;;
DISP_INP8B:			;;
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
	BRA DISP_INP8E		;;
DISP_INP8D0:			;;
	BTSS SPI1STAT,#0	;;
	BRA DISP_INP8D0		;;
	MOV SPI1BUF,W0		;;
	BCLR FLAGA,#GOTOXY_F	;;	
	BSET LCDCS,#LCDCS_P	;;
DISP_INP8E:			;;
	INC LCDX		;;
	DEC R0			;;
	BRA NZ,DISP_INP8A	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDCS,#LCDCS_P	;;
	MOV BMPX,W0		;;
	SUB LCDX		;;
	MOV #1,W0		;;
	SUB LCDY		;;
	BSET FCS,#FCS_P		;;
	POP FADR1		;;
	POP FADR0		;;
	DEC R1			;;
	BRA NZ,DISP_INP80	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC LCDY		;;	
	BSET FCS,#FCS_P		;;
	POP R2			;;
	POP R1			;;
	POP R0			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








; 0=16uS
; 1=32uS
; 2=64
; 3=128
; 4=256
; 5=512
; 6=1mS
; 7=2mS
; 8=4mS
; 9=8mS  
;10=16mS
;11=32mS
;12=64mS
;13=128mS
;14=256mS
;15=512mS
TMR2PRG:
	CLR TMR2_FLAG		
	MOV TMR2,W0
	XOR TMR2_BUF,WREG
	BTSC SR,#Z
	RETURN
	MOV W0,TMR2_FLAG
	XOR TMR2_BUF
	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GETSTR:				;;
	ADD W1,W0,W1		;;
	ADD W1,W0,W1		;;
        TBLRDL [W1],W1		;;
	RETURN	        	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


TMOD0_STR:
 .ASCII "1 BLANK CHECK  \0"
TMOD1_STR:
 .ASCII	"2 ERASE FLASH  \0"
TMOD2_STR:
 .ASCII	"3 PGM FLASH    \0"
TMOD3_STR:
 .ASCII	"4 PGM BLOCK    \0"
TMOD4_STR:
 .ASCII	"5 TEST WRITE   \0"
TMOD5_STR:
 .ASCII "6 EXIT         \0"

TMODSTR_TBL:
 .HWORD tbloffset(TMOD0_STR)
 .HWORD tbloffset(TMOD1_STR)
 .HWORD tbloffset(TMOD2_STR)
 .HWORD tbloffset(TMOD3_STR)
 .HWORD tbloffset(TMOD4_STR)
 .HWORD tbloffset(TMOD5_STR)



TEST_MOD_STR:
 	.ASCII "TEST FRASH      \0"
ERASE_OK_STR:
	.ASCII "ERASE OK        \0"	
DASH_STR:
	.ASCII "----------------\0"
WAIT_STR:
	.ASCII "WAIT...         \0"
FLASH_BLANK_STR:
	.ASCII "FLASH IS BLANK  \0"
FLASH_NO_BLANK_STR:
	.ASCII "SEC01 NOT BLANK \0"
PGM_OK_STR:
	.ASCII "PROGRAM OK      \0"	
VERIFY_STR:
	.ASCII "VERIFY........  \0"	
PGM_ERR_STR:
	.ASCII "PROGRAM ERROR   \0"	
	
DISP_TMOD0:
	BCLR FLAGA,#ENF_2X_F
	CALL COLOR0
	LDPTR TEST_MOD_STR
	LXY 0,0
	CALL ENSTR
	LDPTR DASH_STR
	LXY 0,16
	CALL ENSTR
	RETURN

DISP_TMOD1:
	LDPTR TMODSTR_TBL
	MOV MENU_CNT,W0
	CALL GETSTR
	LXY 0,32
	CALL ENSTR

	MOV #1,W0
	CP MENU_CNT
	BTSS SR,#Z
	RETURN

	MOV #0,W0
	CP ERASE_CNT
	BTSC SR,#Z
	RETURN


	LXY 112,32
	MOV ERASE_CNT,W0
	DEC W0,W0
	CALL ENBYTE

	RETURN	


TMOD_PRG:
	CLR MENU_CNT
	CLR ERASE_CNT
TMOD0:
	CALL COLOR0
	CALL CLRSCR
	CALL DISP_TMOD0
TMOD1:
	CALL DISP_TMOD1
TMOD_LOOP:
	CALL TMR2PRG
	CALL KEYBO
	CALL TMOD_KEY	
	BRA TMOD_LOOP
TMOD_END:
	RETURN

TMOD_KEY:
	BTSC KEY_FLAG,#0
	BRA TMOD_KEY0
	BTSC KEY_FLAG,#1
	BRA TMOD_KEY1
	BTSC KEY_FLAG,#2
	BRA TMOD_KEY2
	RETURN
TMOD_KEY0:
	MOV MENU_CNT,W0
        BRA W0 
TMODPRG_TBL:
        BRA FLASH_BLANK_CHKA
        BRA ERASE_FLASH
        BRA PGMBLK ;PGMBMP
        BRA PGMBLK
        BRA FLASH_BLANK_CHKA;TEST_WFLASH 
        BRA MAIN_RETURN
	RETURN
MAIN_RETURN:
	POP W0
	POP W0
	BRA MAIN

TMOD_KEY1:
	INC MENU_CNT
	MOV #6,W0
	CP MENU_CNT
	BTSC SR,#C
	CLR MENU_CNT 
	POP W0
	BRA TMOD0 
TMOD_KEY2:
	MOV #1,W0
	CP MENU_CNT
	BTSS SR,#Z
	RETURN
	INC ERASE_CNT
	MOV #0x0041,W0
	CP ERASE_CNT
	BTSC SR,#C
	CLR ERASE_CNT 
	POP W0
	BRA TMOD0 
	



FLASH_WREN:
	BCLR FCS,#FCS_P
	MOV #0x0006,W0
	CALL SPIPRG
	BSET FCS,#FCS_P
	RETURN
FLASH_WRDI:
	BCLR FCS,#FCS_P
	MOV #0x0004,W0
	CALL SPIPRG
	BSET FCS,#FCS_P
	RETURN
FLASH_RDSR:
	BCLR FCS,#FCS_P
	MOV #0x0005,W0
	CALL SPIPRG
	CALL SPIPRG
	BSET FCS,#FCS_P
	RETURN
FLASH_WRSR:
	BCLR FCS,#FCS_P
	MOV #0x0001,W0
	CALL SPIPRG
	MOV #0x0000,W0
	CALL SPIPRG
	BSET FCS,#FCS_P
	RETURN
FLASH_BE:
	BCLR FCS,#FCS_P
	MOV #0x00C7,W0
	CALL SPIPRG
	BSET FCS,#FCS_P
	RETURN
FLASH_BS:
	PUSH W0
	BCLR FCS,#FCS_P
	MOV #0x00D8,W0
	CALL SPIPRG
	POP W0
	CALL SPIPRG
	MOV #0x0000,W0
	CALL SPIPRG
	MOV #0x0000,W0
	CALL SPIPRG
	BSET FCS,#FCS_P
	RETURN


WAIT_FLASH_READY:
	CALL FLASH_RDSR
	BTSC SPI1BUF,#0
	BRA WAIT_FLASH_READY
	CALL FLASH_RDSR
	BTSC SPI1BUF,#0
	BRA WAIT_FLASH_READY
	RETURN

CHK_FLASH_WEN:
	CALL FLASH_RDSR
	MOV SPI1BUF,W0
	BTSC SPI1BUF,#0
	BRA CHK_FLASH_WEN
	AND #0x001C,W0
	BTSC SR,#Z
	RETURN         
	CALL FLASH_WREN
	CALL FLASH_WRSR
	BRA CHK_FLASH_WEN


TEST_WSET:
	MOV #0x0001,W2
	MOV #SET_BUF,W1
	MOV #128,W3
TEST_WSET1:
	MOV W2,[W1++]
	ADD #0x0101,W2
	DEC W3,W3
	BRA NZ,TEST_WSET1	
	
	CALL W_SET
	NOP
	NOP
	BRA TEST_WSET
	
W_SET:
	CALL ERASE_FRAM
	MOV #SET_BUF,W1
	CALL WRITE_FRAM
	MOV #SET_BUF,W1
	CALL VERIFY_FRAM
	NOP
	NOP
	NOP
	RETURN

ERASE_FRAM:
	CALL CHK_FLASH_WEN
	CALL FLASH_WREN
	MOV #0x003F,W0
	CALL FLASH_BS
ERASE_FRAM1:
	CALL FLASH_RDSR
	BTSC SPI1BUF,#0
	BRA ERASE_FRAM1
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRITE_FRAM:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	CLR FADR0			;;	
	BCLR FCS,#FCS_P			;;
	MOV #0x0002,W0			;;
	CALL SPIPRG			;;
	MOV #0x003F,W0			;;
	CALL SPIPRG			;;
	MOV #0000,W0			;;
	CALL SPIPRG			;;
	MOV #0000,W0			;;
	CALL SPIPRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRITE_FRAM1:				;;
        MOV [W1],W0			;;
	BTSC FADR0,#0			;;
	SWAP W0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W0,SPI1BUF			;;
	BTSC FADR0,#0			;;
	INC2 W1,W1			;;
	INC FADR0			;;
WRITE_FRAM1A:				;;
	BTSS SPI1STAT,#0		;;
	BRA WRITE_FRAM1A		;;
	MOV.B SPI1BUF,WREG	        ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV.B FADR0,WREG		;;
	BRA NZ,WRITE_FRAM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FCS,#FCS_P			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_SET:				;;
	CLR W5				;;
CHK_SET1:				;;
	MOV #SET_BUF,W4			;;
	ADD W5,W4,W4			;;
	ADD W5,W4,W4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOFFS1 SET_LIMIT		;;
	MOV #6,W0			;;
	MUL.UU W5,W0,W2			;;
	ADD W2,W1,W1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W4],W2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1],W0			;;
	CP W2,W0			;;
	BRA LTU,CHK_SET_LS		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W1,W1			;;
	TBLRDL [W1],W0			;;
	CP W2,W0			;;
	BRA GTU,CHK_SET_GT		;;
CHK_SET2:				;;
	INC W5,W5			;;
	CP W5,#SET_AMT_K		;;
	BRA LTU,CHK_SET1		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
CHK_SET_LS:				;;
CHK_SET_GT:				;;
	LOFFS1 (SET_LIMIT+4)		;;
	MOV #6,W0			;;
	MUL.UU W5,W0,W2			;;
	ADD W2,W1,W1			;;
	TBLRDL [W1],W0			;;
	MOV W0,[W4]			;;
	BRA CHK_SET2			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		;;
VERIFY_FRAM:				;;
	CALL WAIT_FLASH_READY		;;
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
VERIFY_FRAM1:				;;
	MOV W0,SPI1BUF			;;
        MOV [W1],W0			;;
	BTSC FADR0,#0			;;
	SWAP W0				;;
	BTSC FADR0,#0			;;
	INC2 W1,W1			;;
VERIFY_FRAM1A:				;;
	BTSS SPI1STAT,#0		;;
	BRA VERIFY_FRAM1A		;;
	CP.B SPI1BUF			;;
	BRA NZ,VERIFY_FRAM_END 		;;
	INC FADR0			;;
	MOV.B FADR0,WREG		;;
	BRA NZ,VERIFY_FRAM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VERIFY_FRAM_END:			;;
	BSET FCS,#FCS_P			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








ERASE_FLASH:
	MOV #0,W0
	CP ERASE_CNT
	BTSC SR,#Z
	BRA ERASE_ALL
	;;;;;;;;;;;;;;;;;;;;
	CALL CHK_FLASH_WEN
	CALL FLASH_WREN
	MOV ERASE_CNT,W0
	DEC W0,W0
	CALL FLASH_BS
	BRA ERASE_ALL1
ERASE_ALL:
	CALL CHK_FLASH_WEN
	CALL FLASH_WREN
	CALL FLASH_BE
ERASE_ALL1:
	LDPTR WAIT_STR 
	LXY 0,48
	CALL ENSTR
	PUSH R0 
	CLR R0
ERASE_FLASH1:
	CALL TMR2PRG
	BTSS TMR2_FLAG,#T32M_F
	BRA ERASE_FLASH2
	INC R0
	LXY 112,48
	MOV R0,W0
	CALL ENBYTE
ERASE_FLASH2:
	CALL FLASH_RDSR
	BTSC SPI1BUF,#0
	BRA ERASE_FLASH1
	POP R0
	LDPTR ERASE_OK_STR
	LXY 0,48
	CALL ENSTR
	RETURN
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		;;
VERIFY_FLASH:				;;
	CALL WAIT_FLASH_READY		;;
	BCLR FCS,#FCS_P			;;
	MOV #0x0003,W0			;;
	CALL SPIPRG			;;
	MOV FADR1,W0			;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	CALL SPIPRG			;;	
VERIFY_FLASH1:				;;
	MOV W0,SPI1BUF			;;
        TBLRDL [W1],W0			;;
	BTSC FADR0,#0			;;
	SWAP W0				;;
	BTSC FADR0,#0			;;
	INC2 W1,W1			;;
VERIFY_FLASH1A:				;;
	BTSS SPI1STAT,#0		;;
	BRA VERIFY_FLASH1A		;;
	CP.B SPI1BUF			;;
	BRA NZ,VERIFY_END 		;;
	INC FADR0			;;
	BTSC SR,#Z			;;
	INC FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR0,W0			;;
	CP R0				;;
	BRA NZ,VERIFY_FLASH1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR1,W0			;;
	CP R1				;;
	BRA NZ,VERIFY_FLASH1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VERIFY_END:				;;
	BSET FCS,#FCS_P			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_WFLASH:				;;
	LDPTR WAIT_STR			;;
	LXY 0,48			;;
	CALL ENSTR			;;
	MOV #0x7E00,W0			;;
	MOV W0,FADR0			;;
	CLR FADR1			;;
	CLR R5				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_WFLASH0:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	BCLR FCS,#FCS_P			;;
	MOV #0x0002,W0			;;
	CALL SPIPRG			;;
	MOV FADR1,W0			;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	CALL SPIPRG			;;
TEST_WFLASH1:				;;
	MOV FADR0,W0			;;
	MOV W0,SPI1BUF			;;
	INC FADR0			;;
TEST_WFLASH1A:				;;
	BTSS SPI1STAT,#0		;;
	BRA TEST_WFLASH1A		;;
	MOV.B SPI1BUF,WREG	        ;;
	MOV.B FADR0,WREG		;;
	BRA NZ,TEST_WFLASH1 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FCS,#FCS_P			;;
	CALL WAIT_FLASH_READY		;;
	MOV #0x8200,W0			;;
	CP FADR0			;;
	BRA NZ,TEST_WFLASH0 		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x7E00,W0			;;
	MOV W0,FADR0			;;
	CLR FADR1			;;
	CALL WAIT_FLASH_READY		;;
	BCLR FCS,#FCS_P			;;
	MOV #0x0003,W0			;;
	CALL SPIPRG			;;
	MOV FADR1,W0			;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	CALL SPIPRG			;;
TEST_WFLASH2: 				;;
	CALL SPIPRG			;;
        XOR FADR0,WREG 			;;
	AND #255,W0			;;
	BRA NZ,TEST_WFLASH_ERR		;;
	INC FADR0			;; 	
	MOV #0x8200,W0			;;
	CP FADR0			;;
	BRA NZ,TEST_WFLASH2 		;;
TEST_WFLASH_OK:				;;
	BSET FCS,#FCS_P			;;
	LDPTR PGM_OK_STR		;;
	LXY 0,48			;;
	CALL ENSTR			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_WFLASH_ERR:			;;
	BSET FCS,#FCS_P			;;
	LDPTR PGM_ERR_STR		;;
	LXY 0,48			;;
	CALL ENSTR			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
FLASH_PGM:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	BCLR FCS,#FCS_P			;;
	MOV #0x0002,W0			;;
	CALL SPIPRG			;;
	MOV FADR1,W0			;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	CALL SPIPRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_PGM1:				;;
        TBLRDL [W1],W0			;;
	BTSC FADR0,#0			;;
	SWAP W0				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W0,SPI1BUF			;;
	BTSC FADR0,#0			;;
	INC2 W1,W1			;;
	INC FADR0			;;
	BTSC SR,#Z			;;
	INC FADR1			;;
FLASH_PGM1A:				;;
	BTSS SPI1STAT,#0		;;
	BRA FLASH_PGM1A			;;
	MOV.B SPI1BUF,WREG	        ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV.B FADR0,WREG		;;
	BRA NZ,FLASH_PGM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FCS,#FCS_P			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PGMBLK:					;;
	BSET FLAGA,#PGMBLK_F		;;
	BRA PGMBMP0			;;
PGMBMP:					;;
	BCLR FLAGA,#PGMBLK_F		;;
PGMBMP0:				;;
	PUSH R0				;;
	PUSH R1				;;
        LDPTR TYREDOG_BMP		;;
	TBLRDL [W1],W0			;;
	MOV W0,R0			;;
	CLR R1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSC FLAGA,#PGMBLK_F		;;
	ADD W1,#8,W1			;;
PGMBMP0A:  				;;
	MOV #PGM_ADR0,W0		;;
	MOV W0,FADR0			;;
	MOV #PGM_ADR1,W0		;;
	MOV W0,FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV FADR0,W0			;;
	ADD R0				;;
	MOV FADR1,W0			;;
	ADDC R1 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PGMBMP1:				;;
	CALL FLASH_PGM			;;
	LXY 112,48			;;
	MOV FADR1,W0			;;
	CALL ENBYTE			;;
	MOV R0,W0			;;
	CP FADR0			;;
	BRA NC,PGMBMP1			;;
	MOV R1,W0			;;
	CP FADR1			;;
	BRA NC,PGMBMP1	 		;;
PGMBMP1A:				;;
	LDPTR VERIFY_STR		;;	
	LXY 0,48			;;
	CALL ENSTR			;;		
	CALL WAIT_FLASH_READY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        LDPTR TYREDOG_BMP		;;
	BTSC FLAGA,#PGMBLK_F		;;
	ADD W1,#8,W1			;;
PGMBMP1B:				;;
	MOV #PGM_ADR0,W0		;;
	MOV W0,FADR0			;;
	MOV #PGM_ADR1,W0		;;
	MOV W0,FADR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL VERIFY_FLASH 		;;
	BRA NZ,PGMBMP2			;;
	LDPTR PGM_OK_STR		;;
	BRA PGMBMP3			;;
PGMBMP2:				;;
	LDPTR PGM_ERR_STR		;;
PGMBMP3:				;;
	LXY 0,48			;;
	CALL ENSTR			;;
	POP R1				;;
	POP R0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
PRE_BMP:				;;
	CALL WAIT_FLASH_READY		;;
	BCLR FCS,#FCS_P			;;
	MOV #0x0003,W0			;;
	CALL SPIPRG			;;
	MOV FADR1,W0			;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	CALL SPIPRG			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_BLANK_CHKA:			;;
	BSET FLAGA,#FLASH_BLANK_CHKA_F	;;
	MOV #0,W0			;;
	BRA FLASH_BLANK_CHK0		;;
FLASH_BLANK_CHKS:			;;
	BCLR FLAGA,#FLASH_BLANK_CHKA_F	;;
FLASH_BLANK_CHK0:			;;
	MOV W0,FADR1			;;
	LDPTR WAIT_STR			;;
	LXY 0,48			;;
	CALL ENSTR			;;
	MOV #500,W0			;;
	CALL DLYMX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR FADR0			;;
	BCLR FCS,#FCS_P 		;;
	MOV #0x0003,W0			;;
	CALL SPIPRG			;;
	MOV FADR1,W0			;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	SWAP W0				;;
	CALL SPIPRG			;;
	MOV FADR0,W0			;;
	CALL SPIPRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLASH_BLANK_CHK1:			;;
	MOV W0,SPI1BUF			;;
	MOV #0x00FF,W0			;;
FLASH_BLANK_CHK1A:			;;
	BTSS SPI1STAT,#0		;;
	BRA FLASH_BLANK_CHK1A		;;	
	CP.B SPI1BUF			;;
	BRA NZ,FLASH_NO_BLANK 		;;
	INC FADR0			;;
	BRA NZ,FLASH_BLANK_CHK1 	;;
	INC FADR1			;;
	BTSS FLAGA,#FLASH_BLANK_CHKA_F	;;
	BRA FLASH_BLANK			;;
	LXY 112,48			;;
	MOV FADR1,W0			;;
	CALL ENBYTE			;;
	BTSS FADR1,#6			;;
	BRA FLASH_BLANK_CHK1		;;
FLASH_BLANK:				;;
	BSET FCS,#FCS_P			;;
	LDPTR FLASH_BLANK_STR		;;
	LXY 0,48			;;
	CALL ENSTR			;;
	BSET SR,#C			;;
	RETURN				;;
FLASH_NO_BLANK:				;;
	BSET FCS,#FCS_P 		;;
	LDPTR FLASH_NO_BLANK_STR	;;	
	LXY 0,48			;;
	CALL ENSTR			;;
	LXY 24,48			;;
	MOV FADR1,W0			;;
	CALL ENBYTE			;;
	BCLR SR,#C			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBO:					;;
	CLR KEY_FLAG			;;
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
	INC NOKEY_CNT			;;
	MOV #5,W0			;;
	CP NOKEY_CNT		        ;;
	BTSS SR,#C			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV KEY_BUF,W0			;;
	SL  W0,#8,W0			;;
	BTSS FLAGB,#DISKR_F		;;
	IOR KEY_FLAG			;;
	BCLR FLAGB,#DISKR_F		;;
	CLR KEY_BUF			;;
	CLR YESKEY_CNT			;;
	CLR CONKEY_CNT			;; 
	BTSS FLAGB,#TXKEY_F		;; 
	RETURN				;;
	BCLR FLAGB,#TXKEY_F		;;
	CLR MTX_COUNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
YESKEY:					;;
	INC YESKEY_CNT			;;		
	PUSH W0				;;
	MOV #5,W0			;;
	CP YESKEY_CNT			;;
	POP W0				;;
	BTSS SR,#C			;;
	RETURN				;;
	DEC YESKEY_CNT			;;
	CP KEY_BUF			;;
	BRA Z,CONKEY			;;
	MOV W0,KEY_BUF			;;
	MOV.B WREG,KEY_FLAG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONKEY:					;;
	INC CONKEY_CNT			;;
	PUSH W0				;;
	MOV #400,W0			;;
	CP CONKEY_CNT 			;;
	POP W0				;;
	BTSS SR,#C			;;
	RETURN				;;
	SWAP.B W0
	MOV.B WREG,KEY_FLAG		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












INIT_OSC:
	MOV OSCCON,W0
	MOV #OSCCONL, w1
	MOV #0x46, w2
	MOV #0x57, w3
	MOV.B W2,[W1]
	MOV.B W3,[W1]
	BSET OSCCON,#1 ;32768
	NOP
	NOP
	NOP
	MOV #0x0000,W0
	MOV W0,CLKDIV
	RETURN
INIT_IO:
	MOV #0xFFFF,W0
	MOV W0,LATA 
	MOV #0x021C,W0
	MOV W0,TRISA
	MOV #0xFF1F,W0
	MOV W0,LATB 
	MOV #0x1D17,W0
	MOV W0,TRISB 
 	MOV #0x0300,W0
	MOV W0,LATC  
 	MOV #0x0300,W0
	MOV W0,TRISC 
	MOV #0xFFFF,W0
	MOV W0,AD1PCFG 
	RETURN  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_BUZ:			;;16MHZ
	MOV #0x200D,W0		;;
	MOV W0,OC5CON		;;
	MOVLF 1000,PR3		;;
	MOVLF #0xFFFF,OC5R	;;
	MOVLF 999,OC5RS		;;
	MOV #0xA010,W0		;;
	MOV W0,T3CON		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INIT_TIMER:
	BSET INTCON1,#NSTDIS
	MOV #0xA030,W0
	MOV W0,T2CON		;BASE TIME
	;;;;;;;;;;;;;;;;;
	MOV #0xA000,W0
	MOV W0,T4CON
	CLR TMR4
	MOVLF 600,PR4		;37.5US	
	BSET IEC1,#T4IE		;RF USE
	;;;;;;;;;;;;;;;;;;
	CLR TMR1
	BCLR IFS0,#T1IF
	MOVLF 7680,PR1
	MOV #0x8032,W0
	MOV W0,T1CON		;REAL TIME
	RETURN
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T4Interrupt:			;;37.7 US
	PUSH W0			;;
	PUSH W1			;;
	BCLR IFS1,#T4IF		;;
        BTSC FLAGA,#MTXE_F      ;;  
        BRA RFTX_INT            ;;  
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
	AND #0x001F,W0		;;
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
SONG_INT:
	INC SONG_BASET
	MOV #SONG_BASET_K,W0
	CP SONG_BASET
	BRA LTU,INT_END
	CLR SONG_BASET
	BTSC FLAGA,#SONG_F	;;
	BRA SONG_INT1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SONG_INT_STOP:			;;
	BCLR FLAGA,#SONG_F	;;	
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
	BRA Z,SONG_INT_STOP	;;
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
	RETFIE



DLYMS:
        MOV #1,W0       
DLYMX:
        PUSH  R0
        PUSH  R1
        MOV W0,R1
DLYMX1:
        MOV #1000,W0
        MOV W0,R0
DLYMX2:
        NOP
        DEC R0
        BRA NZ,DLYMX2
        DEC R1
        BRA NZ,DLYMX1 
        POP R1
        POP R0
        RETURN
             



;..............................................................................
;Subroutine: Initialization of W registers to 0x0000
;..............................................................................

CLR_WREG:
        CLR W0
        MOV W0,W14
        REPEAT #12
        MOV W0,[++W14]
        CLR W14
        RETURN


LCD_STANBY:
;LCDREG_Write (0x0007,0x0000);
	WLCDP 0x07,0x0000
;Delay_ms(25)¡F
	MOV #25,W0
	CALL DLYMX
;LDREG_Write (0x000E,0x1319);
	WLCDP 0x0E,0x1319
	MOV #25,W0
	CALL DLYMX
;LCDREG_Write (0x000D,0x0000);
	WLCDP 0x0D,0x0000
	MOV #25,W0
	CALL DLYMX
;LCDREG_Write (0x0009,0x0008);
	WLCDP 0x09,0x0008
	MOV #25,W0
	CALL DLYMX
;LCDREG_Write G(0x0003,0x0000);
	WLCDP 0x03,0x0000
	MOV #25,W0
	CALL DLYMX
;LCDREG_Write (0x0003,0x0001);
	WLCDP 0x03,0x0001
	MOV #25,W0
	CALL DLYMX
	RETURN
INIT_LCD:
	CALL RESET_LCD
;TFT_writec(0x00,0x56);TFT_writed(0x00, 0x00); 	 // reduce power consumption 
;	WLCDP 56,0x000  
	NOP
	NOP
;TFT_writec(0x00,0x52);TFT_writed(0x00, 0x02); 	 // reduce power consumption 
;	WLCDP 52,0x002  
	NOP
	NOP
;TFT_writec(0x00,0x00);TFT_writed(0x00, 0x01); 	 // Start internal OSC. 
	WLCDP 0x00,0x0001 
	MOV #100,W0
	CALL DLYMX ;Delay_ms(10); 	 // Delay 10 ms 
;TFT_writec(0x00,0x01);TFT_writed(0x01, 0x13); 	// set the display line number and display direction 
;	WLCDP 0x01,0x0113 
	;1    1->160
	;2    1->160
	;...........
	;128  1->160

	WLCDP 0x01,0x0013 
	;128  1->160
	;...........
	;2    1->160		
	;1    1->160

;	WLCDP 0x01,0x0213 
	;128  1<-160
	;...........
	;2    1<-160		
	;1    1<-160



;TFT_writec(0x00,0x02);TFT_writed(0x07, 0x00); 	// set 1 line inversion 
	WLCDP 0x02,0x0300;020300 
;TFT_writec(0x00,0x05);TFT_writed(0x10, 0x30); 	// set GRAM write direction and BGR=1 
;	WLCDP 0x05,0x1028;051030

	WLCDP 0x05,0x1020;051030


;TFT_writec(0x00,0x25);TFT_writed(0x00, 0x00); 	// set 18-bit mask register 
	WLCDP 0x23,0x0000;230000
;TFT_writec(0x00,0x26);TFT_writed(0x00, 0x00); 	// set 18-bit mask register 
	WLCDP 0x24,0x0000;240000

	WLCDP 0x25,0x0000;230000
	WLCDP 0x26,0x0000;240000


;TFT_writec(0x00,0x08);TFT_writed(0x02, 0x02); 	// set the back/front porch number 
	WLCDP 0x08,0x0202;<<080302
;TFT_writec(0x00,0x0A);TFT_writed(0x00, 0x00); 	// set the transfer interface and transfer number 
	WLCDP 0x0A,0x0000
;TFT_writec(0x00,0x0B);TFT_writed(0x00, 0x00); 	// set the equalized and delay period to save power 
	WLCDP 0x0B,0x0000
;TFT_writec(0x00,0x0C);TFT_writed(0x00, 0x00);	 // set internal reference voltage REGP=VCI=2.8V 
	WLCDP 0x0C,0x0000
;TFT_writec(0x00,0x0F);TFT_writed(0x00, 0x00); 	// Set Gate scan start address 
	WLCDP 0x0F,0x0000
;TFT_writec(0x00,0x21);TFT_writed(0x00, 0x00); 	// set the writing start address of AC counter 
	WLCDP 0x21,0x0000
;TFT_writec(0x00,0x14);TFT_writed(0x9F, 0x00); 	// set the display area 
	WLCDP 0x14,0x9F00
;TFT_writec(0x00,0x16);TFT_writed(0x7F, 0x00); 	// set the GRAM access area 
	WLCDP 0x16,0x7F00
;TFT_writec(0x00,0x17);TFT_writed(0x9F, 0x00); 	// set the GRAM access area 
	WLCDP 0x17,0x9F00
;Delay_ms (50); 	
	MOV #50,W0
	CALL DLYMX
;LCDREG_Write (0x0003);TFT_writed(0x00,0x00); 	 
	WLCDP 0x03,0x0000
;Delay_ms (10); 	 
	MOV #100,W0
	CALL DLYMX
;LCDREG_Write (0x0009);TFT_writed(0x00,0x00); 	 
	WLCDP 0x09,0x0000
;Delay_ms (10); 	 
	MOV #100,W0
	CALL DLYMX
;LCDREG_Write (0x000D);TFT_writed(0x00,0x00); 	 
	WLCDP 0x0D,0x0000
;Delay_ms (10); 	 
	MOV #100,W0
	CALL DLYMX
;LCDREG_Write (0x000E);TFT_writed(0x00,0x00); 	 
	WLCDP 0x0E,0x0000
;Delay_ms (10); 
	MOV #100,W0
	CALL DLYMX	 
;;Please follow this power on sequence 	 
;TFT_writec(0x00,0x03);TFT_writed(0x01, 0x50); 	// enable charge-pump1 and VG /VGL voltage 
	WLCDP 0x03,0x0148
;TFT_writec(0x00,0x09);TFT_writed(0x00, 0x44); 	// enable set the driving capability of source driver 
	WLCDP 0x09,0x0044
;Delay_ms(10); 	 // Delay 10 ms 
	MOV #100,W0
	CALL DLYMX
;TFT_writec(0x00,0x0D);TFT_writed(0x00, 0x13); 	 // set voltage VGAM1OUT=VCI*1.65 
	WLCDP 0x0D,0x0013	;OR 0093 
;Delay_ms(40); 	
	MOV #400,W0
	CALL DLYMX
;TFT_writec(0x00,0x0E);TFT_writed(0x33, 0x19); // set VCOM  and VCOM amplitude voltage 	
	WLCDP 0x0E,0x3319
;; ---------- Adjust the Gamma 2.2 Curve ------------------- 	
;TFT_writec(0x00,0x30);TFT_writed(0x07, 0x07); 	
	WLCDP 0x30,0x0707
;TFT_writec(0x00,0x31);TFT_writed(0x07, 0x07); 	
	WLCDP 0x31,0x0707
;TFT_writec(0x00,0x32);TFT_writed(0x07, 0x07); 	
	WLCDP 0x32,0x0707
;TFT_writec(0x00,0x33);TFT_writed(0x03, 0x05); 	
	WLCDP 0x33,0x0305
;TFT_writec(0x00,0x34);TFT_writed(0x00, 0x07); 	
	WLCDP 0x34,0x0007
;TFT_writec(0x00,0x35);TFT_writed(0x00, 0x00); 	
	WLCDP 0x35,0x0000
;TFT_writec(0x00,0x36);TFT_writed(0x00, 0x07); 	
	WLCDP 0x36,0x0007
;TFT_writec(0x00,0x37);TFT_writed(0x05, 0x02); 	
	WLCDP 0x37,0x0502
;TFT_writec(0x00,0x3A);TFT_writed(0x05, 0x0F); 
	WLCDP 0x3A,0x050F
;TFT_writec(0x00,0x3B);TFT_writed(0x07, 0x0C); 
	WLCDP 0x3B,0x070C
;LCDREG_Write (0x0021);TFT_writed(0x00, 0x00); 
;	WLCDP 21,0x000 
;; Write the display data into GRAM here 
;;/ set the index register as 0x22 
;	LLC.BYTE 0x022              
;	CALL LCDWC
	MOV #100,W0
	CALL DLYMX
	WLCDP 0x07,0x0037
;	CALL LCDWD_ST
;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DARKEND:				;;
	MOV #128,W0			;;
	SUBR LCDX,WREG			;;
	BTSS SR,#C 			;;
	RETURN				;;
	MOV W0,BMPX			;;
	MOV #16,W0			;;
	MOV W0,BMPY			;;
	CALL DISP_BLK			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DARKSCR:				;;
	CLR COLOR_B			;;
CLRSCR:					;;
	WLCDP 0x21,0x007F		;;
	BCLR LCDCS,#LCDCS_P		;;
	MOV #0x22,W0             	;;	
	CALL LCDWC			;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RESET_LCD:				;;
	BSET LCDCS,#LCDCS_P 		;;
	BCLR LCDRST,#LCDRST_P		;;
	MOV #100,W0			;;
	CALL DLYMX			;;
	BSET LCDRST,#LCDRST_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;ID=0
LCDWC:
	BCLR LCDRS,#LCDRS_P
	CLR.B LATC
	BCLR LCDWR,#LCDWR_P
	BSET LCDWR,#LCDWR_P
	MOV.B WREG,LATC
	BCLR LCDWR,#LCDWR_P
	BSET LCDWR,#LCDWR_P
	RETURN	 
LCDWD:
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

LCDRDD:
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










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SIO:			;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BCLR OSCCON,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1F18,W0		;;
	MOV W0,RPINR20		;;
	MOV #0x081F,W0		;;
	MOV W0,RPOR4		;;
	MOV #0x071F,W0		;;
	MOV W0,RPOR12		;;
	MOV #0x1600,W0		;;
	MOV W0,RPOR2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #0x0000,W0		;;
;	MOV W0,RPOR6		;;
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
SPIPRG:				;;
	MOV W0,SPI1BUF		;;
SPIPRG1:			;;
	BTSC SPI1STAT,#1	;;
	BRA SPIPRG1		;;	
	BTSS SPI1STAT,#0	;;
	BRA SPIPRG1		;;	
	MOV.B SPI1BUF,WREG	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
INIT_SPI:			;;
	MOV #0x027B,W0		;;
	MOV W0,SPI1CON1		;;
	MOV #0x0000,W0		;;
	MOV W0,SPI1CON2		;;
	MOV #0x8000,W0		;;
	MOV W0,SPI1STAT		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
C_WTBK:
COLOR0:
	MOV #0xFFFF,W0
	MOV W0,COLOR_F
	CLR COLOR_B
	RETURN
C_BKWT:
COLOR1:
	MOV #0x0000,W0
	MOV W0,COLOR_F
	SETM COLOR_B
	RETURN
C_YLBK:
COLOR2:
	MOV #0x07FF,W0
	MOV W0,COLOR_F
	CLR COLOR_B
	RETURN
C_BKBK:
	MOV #0x0000,W0
	MOV W0,COLOR_F
	CLR COLOR_B
	RETURN
C_RDBK:
	MOV #0x001F,W0
	MOV W0,COLOR_F
	CLR COLOR_B
	RETURN

C_BKRD:
	MOV #0x001F,W0
	MOV W0,COLOR_B
	CLR COLOR_F
	RETURN

C_BKGY:
	CLR COLOR_F
	MOV #0xF79E,W0
	MOV W0,COLOR_B
	RETURN



C_GRBK:
	MOV #0x07E0,W0
	MOV W0,COLOR_F
	CLR COLOR_B
	RETURN
C_BLBK:
	MOV #0xF800,W0
	MOV W0,COLOR_F
	CLR COLOR_B
	RETURN
C_BLBL:
	MOV #0xF800,W0
	MOV W0,COLOR_F
	MOV W0,COLOR_B
	RETURN
C_GRGR:
	MOV #0x07E0,W0
	MOV W0,COLOR_F
	MOV W0,COLOR_B
	RETURN

C_HGRHGR:
	MOV #0x05E0,W0
	MOV W0,COLOR_F
	MOV W0,COLOR_B
	RETURN

C_WTBL:
	MOV #0xF800,W0
	MOV W0,COLOR_B
	SETM COLOR_F
	RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
W1P:				;;
	BTSC FLAGA,#GOTOXY_F	;;
	BRA W1PA		;;
	BSET FLAGA,#GOTOXY_F	;;
	CALL GOTOXY		;;
	BSET LCDRS,#LCDRS_P	;;
	BCLR LCDCS,#LCDCS_P	;;
W1PA:				;;
	MOV LCDX_LIM0,W0	;;	
	CP LCDX			;;
	BRA LT,W1PB		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM1,W0	;;
	CP LCDX			;;
	BRA GT,W1PB	  	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM0,W0	;;	
	CP LCDY			;;
	BRA LT,W1PB		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY_LIM1,W0	;;
	CP LCDY			;;
	BRA GT,W1PB	  	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTSS FLAGA,#THF_F	;;
	BRA W1PA1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUSH FADR0		;;
	PUSH FADR1		;;
	PUSH W2			;;
	PUSH W3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX_LIM0,W0	;;
	SUB LCDX_LIM1,WREG	;;
	INC W0,W2		;;
	MOV LCDY,W0		;;
	SUB LCDY_LIM1,WREG	;;
	MUL.UU W0,W2,W2		;;
	MOV LCDX,W0		;;
	ADD W0,W2,W0		;;
	ADD FADR0		;;
	BTSC SR,#C		;;
	INC FADR1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR FCS,#FCS_P		;;
	MOV #0x03,W0		;;
	CALL SPIPRG		;;
	MOV FADR1,W0		;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	SWAP W0			;;
	CALL SPIPRG		;;
	MOV FADR0,W0		;;
	CALL SPIPRG		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W0,SPI1BUF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
W1PA0:				;;
	BTSS SPI1STAT,#0	;;
	BRA W1PA0		;;
	MOV SPI1BUF,W0		;;
	AND #255,W0		;;
	MOV #BMPC,W2		;;
	ADD W0,W2,W2		;;
	ADD W0,W2,W2		;;
	MOV [W2],W0		;;
	SWAP W0			;;
	MOV W0,COLOR_B		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET FCS,#FCS_P		;;
	POP W3			;;
	POP W2			;;
	POP FADR1		;;
	POP FADR0		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
W1PA1:				;;
	MOV COLOR_F,W0		;;
	BTSS W1,#0         	;;
	MOV COLOR_B,W0		;;
	SWAP W0			;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;
	SWAP W0			;;
	MOV.B WREG,LATC		;;
	BCLR LCDWR,#LCDWR_P	;;
	BSET LCDWR,#LCDWR_P	;;	
	INC LCDX 		;;
	RETURN			;;
W1PB:				;;
	INC LCDX		;;
	BCLR FLAGA,#GOTOXY_F	;;	
	BSET LCDCS,#LCDCS_P	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
WLCDFX:				;;
	PUSH W1			;;
	MOV W0,W1		;;
	BCLR FLAGA,#GOTOXY_F	;;	
WLCDFX1:			;;
	CALL W1P		;;
	BTSC FLAGA,#ENF_2X_F	;;
	CALL W1P		;;
	RRNC W1,W1		;;
	DEC W2,W2		;;
	BRA NZ,WLCDFX1		;;
	BSET LCDCS,#LCDCS_P	;;
	POP W1			;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GOTOXY:					;;
	BCLR LCDCS,#LCDCS_P		;;
	BCLR LCDRS,#LCDRS_P		;;
	CLR.B LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	MOV #0x21,W0			;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDRS,#LCDRS_P		;;
	MOV LCDY,W0			;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #127,W0			;;
	SUBR LCDX,WREG			;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WGRAM:					;;
	BCLR LCDCS,#LCDCS_P		;;
	BCLR LCDRS,#LCDRS_P		;;
	CLR.B LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	MOV #0x22,W0			;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	BSET LCDCS,#LCDCS_P		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




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














ENBYTE:
	PUSH W0
	SWAP.B W0
	AND #0x000F,W0
	CALL ENNUM
	POP W0
	AND #0x000F,W0
	CALL ENNUM
	RETURN	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NUM_TRANS:				;;
	ADD.B #246,W0       ;-10	;;	
        BTSC SR,#C			;;
	ADD.B #7,W0			;;
	ADD.B #0x3A,W0			;;
	RETURN				;;
ENNUM:					;;
	CALL NUM_TRANS			;;
ENCHR:					;;
	PUSH W1				;;
	CALL FONT_PRP			;;
	BTSC FLAGA,#STRLEN_F		;;
	BRA ENCHR1			;;
	CALL FONTP 			;;ENFPRG			;;
	POP W1				;;
	RETURN				;;
ENCHR1:					;;
	MOV FONT_X,W0			;;
	BTSC FLAGA,#ENF_2X_F		;;
	ADD STR_LEN			;;
	ADD STR_LEN			;;
	POP W1				;;
	RETURN				;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FONT_PRP:				;;
	MOV FONT_TYP,W1			;;
	BRA W1				;;
	BRA FONT0_PRP  			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 			;;
	BRA FONT0_PRP 	 		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENSTR_LEN:				;;
	BSET FLAGA,#STRLEN_F		;;
	CLR STR_LEN			;;
	BRA ENSTR00			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENSTR:					;;
	BCLR FLAGA,#STRLEN_F		;;
ENSTR00:				;;
	PUSH W1				;;
	CLR FONT_TYP 			;;
ENSTR0:					;;	
        TBLRDL [W1],W0		        ;;
	BTSC W1,#0			;;
	SWAP W0				;; 
	AND #255,W0			;;
	BRA Z,ENSTR_END			;;
	CP W0,#16			;;
	BRA C,ENSTR1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
	MOV W0,FONT_TYP			;;
	INC W1,W1			;;
	BRA ENSTR0			;;
ENSTR1:					;;
	CALL ENCHR			;;
	INC W1,W1			;;
	BRA ENSTR0			;;
ENSTR_END:				;;
	CLR FONT_TYP 			;;
	BCLR FLAGA,#STRLEN_F		;;
	POP W1				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


XYA_TBL:
	MOV MENU_AMT,W5
	DEC W5,W5
	BCLR SR,#C
	RLC W5,W5 
	BRA W5
	MOV #tbloffset(XYA_TBL1),W5
	RETURN
	MOV #tbloffset(XYA_TBL2),W5
	RETURN
	MOV #tbloffset(XYA_TBL3),W5
	RETURN
	MOV #tbloffset(XYA_TBL4),W5
	RETURN
	MOV #tbloffset(XYA_TBL5),W5
	RETURN
	MOV #tbloffset(XYA_TBL6),W5
	RETURN
	MOV #tbloffset(XYA_TBL7),W5
	RETURN
	MOV #tbloffset(XYA_TBL8),W5
	RETURN
	MOV #tbloffset(XYA_TBL9),W5
	RETURN
