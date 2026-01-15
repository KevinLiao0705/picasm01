
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_PRETBL:				;;
	RETURN				;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




	

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




MENU_SET_TBL:
	.WORD tbloffset(MENU_IHC),TPMS_PUNIT_SET
	.WORD tbloffset(MENU_IHD),TPMS_TUNIT_SET
	.WORD 0



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_MENU_SET:				;;
	LOFFS1 #MENU_SET_TBL 		;;
LOAD_MENU_SET0:				;;
	TBLRDL [W1++],W0		;;
	TBLRDL [W1++],W2		;;
	CP0 W0				;;
	BRA Z,LOAD_MENU_SET1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP MENU_ADR			;;
	BRA NZ,LOAD_MENU_SET0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W2],W0			;;
	INC W0,W0			;;
	MOV W0,DPPSEL_CNT		;;
LOAD_MENU_SET1:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_MENU_SET:				;;
	LOFFS1 #MENU_SET_TBL 		;;
SAVE_MENU_SET0:				;;
	TBLRDL [W1++],W0		;;
	TBLRDL [W1++],W2		;;
	CP0 W0				;;
	BRA Z,SAVE_MENU_SET1		;;
	CP MENU_ADR			;;
	BRA NZ,SAVE_MENU_SET0		;;
	DEC DPPSEL_CNT,WREG		;;
	MOV W0,[W2]			;;
	MOV DPPSEL_CNT,W0		;;
	MOV W0,DPPSET_CNT		;;
SAVE_MENU_SET1:				;;
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
	MOV #180,W2
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
	MOV #96,W2
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHG_DPPDT:			;;
	PUSH W2			;;
	MUL.UU W1,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	MOV [W5],W0		;;
	IOR #5,W0		;;
	MOV W0,[W5++]		;;FLAG		
	POP W2			;;
	MOV W2,[W5++]		;;		
	RETURN			;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHG_DPPXT:			;;
	PUSH W2			;;
	MUL.UU W1,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	SWAP W0			;;
	IOR #1,W0		;;
	MOV W0,[W5++]		;;FLAG		
	POP W2			;;
	MOV [W5],W0		;;
	XOR W0,W2,W0		;;
	BTSC SR,#Z		;;
	RETURN 			;;
	MOV W2,[W5--]		;;
	BSET [W5],#1		;;		
	RETURN			;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHG_DPPX:			;;
	MUL.UU W1,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	SWAP W0			;;
	IOR #3,W0		;;
	MOV W0,[W5++]		;;FLAG		
	RETURN			;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_DPPX:			;;
	MOV DPP_AMT,W4		;;	
	MUL.UU W4,#12,W2 	;;	
	MOV #DPPBUF,W5		;;
	ADD W5,W2,W5		;;
	SWAP W0			;;
	IOR #3,W0		;;
	BRA LOAD_DPP0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_DPP_ONCE:			;;
	MOV #1,W0		;;
LOAD_DPP_XTIME:			;;
	MOV W0,DPP_ONCE_CNT	;;
LOAD_DPP_FTIME:			;;
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
	MOV W0,[W5++]		;;FLAG		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV W1,[W5++]		;;TBL ADDRESS
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC2 W5,W5		;;TIME_LIMIT
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	SETM W0			;;
	MOV W0,[W5++]		;;NOW PAGE
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX,W0		;;
	MOV W0,[W5++]		;;LCDX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY,W0		;;LCDY
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
DRAW_DPPSET:			;;
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
	SUB W0,#2,W0		;;
	MOV W0,LCDX		;;
	TBLRDL [W5++],W0	;;
	SUB W0,#2,W0		;;
	MOV W0,LCDY		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #2,W0		;;
	MOV W0,BMPX		;;
	MOV #40,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	MOV #40,W0		;;
	MOV W0,BMPX		;;
	MOV #2,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #38,W0		;;
	ADD LCDX		;;
	MOV #2,W0		;;
	MOV W0,BMPX		;;
	MOV #40,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	MOV #38,W0		;;
	SUB LCDX		;;
	MOV #38,W0		;;
	ADD LCDY		;;
	MOV #40,W0		;;
	MOV W0,BMPX		;;
	MOV #2,W0		;;
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
;10 RIGHT TIO LEFT
;11 LEFT TO RIGHT
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
	.WORD 0x0105	;BIT01 DIRECT,B2 PRESENT,B3 STOP,B8 256 COLOR
	.WORD BENZ_0_ADR0 ;BMP_ADDRESS L
	.WORD BENZ_0_ADR1 ;BMP_ADDRESS H
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

PORCH_SHOW_A_TBL:
	.WORD 0x0104	;BIT01 DIRECT,B2 PRESENT,B3 STOP,B8 256 COLOR
	.WORD PORCH_B_0_ADR0 ;BMP_ADDRESS L
	.WORD PORCH_B_0_ADR1 ;BMP_ADDRESS H
	.WORD 1000    	;BETWEEN TIME  
	.WORD 40	;FIRST X
	.WORD 160	;FIRST Y
	.WORD 40	;END X
	.WORD 27	;END Y
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 0 	;LIMIT YT	
	.WORD 159	;LIMIT YB
	.WORD 0x3069	;BMPX,BMPY
	.WORD 0x0000	;BACK GROUND COLOR

PORCH_SHOW_B_TBL:
	.WORD 0x0106	;BIT01 DIRECT,B2 PRESENT,B3 STOP,B8 256 COLOR
	.WORD PORCH_B_0_ADR0 ;BMP_ADDRESS L
	.WORD PORCH_B_0_ADR1 ;BMP_ADDRESS H
	.WORD 1000    	;BETWEEN TIME  
	.WORD 40	;FIRST X
	.WORD 27	;FIRST Y
	.WORD 6		;END X
	.WORD 27	;END Y
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 0 	;LIMIT YT	
	.WORD 159	;LIMIT YB
	.WORD 0x3069	;BMPX,BMPY
	.WORD 0x0000	;BACK GROUND COLOR

PLUG_SHOW_A_TBL:
	.WORD 0x0006	;BIT01 DIRECT,B2 PRESENT,B3 STOP,B8 256 COLOR
	.WORD PLUG_1_ADR0 ;BMP_ADDRESS L
	.WORD PLUG_1_ADR1 ;BMP_ADDRESS H
	.WORD 1000    	;BETWEEN TIME  
	.WORD 128	;FIRST X
	.WORD 45	;FIRST Y
	.WORD 54	;END X
	.WORD 45	;END Y
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 0 	;LIMIT YT	
	.WORD 159	;LIMIT YB
	.WORD 0x1208	;BMPX,BMPY
	.WORD 0x0000	;BACK GROUND COLOR

PLUG_SHOW_B_TBL:
	.WORD 0x0006	;BIT01 DIRECT,B2 PRESENT,B3 STOP,B8 256 COLOR
	.WORD PLUG_1_ADR0 ;BMP_ADDRESS L
	.WORD PLUG_1_ADR1 ;BMP_ADDRESS H
	.WORD 1000    	;BETWEEN TIME  
	.WORD 128	;FIRST X
	.WORD 107	;FIRST Y
	.WORD 54	;END X
	.WORD 107	;END Y
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 0 	;LIMIT YT	
	.WORD 159	;LIMIT YB
	.WORD 0x1208	;BMPX,BMPY
	.WORD 0x0000	;BACK GROUND COLOR



METER_SHOW_A_TBL:
	.WORD 0x0106	;BIT01 DIRECT,B2 PRESENT,B3 STOP,B8 256 COLOR
	.WORD METER_0_ADR0 ;BMP_ADDRESS L
	.WORD METER_0_ADR1 ;BMP_ADDRESS H
	.WORD 1000    	;BETWEEN TIME  
	.WORD 146	;FIRST X
	.WORD 25	;FIRST Y
	.WORD 72	;END X
	.WORD 25	;END Y
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 0 	;LIMIT YT	
	.WORD 159	;LIMIT YB
	.WORD 0x3231	;BMPX,BMPY
	.WORD 0x0000	;BACK GROUND COLOR

METER_SHOW_B_TBL:
	.WORD 0x0106	;BIT01 DIRECT,B2 PRESENT,B3 STOP,B8 256 COLOR
	.WORD METER_0_ADR0 ;BMP_ADDRESS L
	.WORD METER_0_ADR1 ;BMP_ADDRESS H
	.WORD 1000    	;BETWEEN TIME  
	.WORD 146	;FIRST X
	.WORD 86	;FIRST Y
	.WORD 72	;END X
	.WORD 86	;END Y
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 0 	;LIMIT YT	
	.WORD 159	;LIMIT YB
	.WORD 0x3231	;BMPX,BMPY
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
	.WORD 100 	;BETWEEN TIME  
	.WORD 30000      ;FIRST_TIME
	.WORD 30000 	;END_TIME 		
	.WORD 0		;LIMIT XL	
	.WORD 127	;LIMIT XR	
	.WORD 144	;LIMIT YT	
	.WORD 159	;LIMIT YB
	.WORD 0x001F	;FRONT COLOR
	.WORD 0x0000	;BACK GROUND COLOR
	.WORD 128 	;FIRST X
	.WORD 0 	;END X


DYSTR_TEST_STRB:
	.WORD tbloffset(DYSTR_TEST_STR_0)
	.WORD tbloffset(DYSTR_TEST_STR_1)
        .WORD tbloffset(DYSTR_TEST_STR_2)
	.WORD tbloffset(DYSTR_TEST_STR_3)
DYSTR_TEST_STR_0:
	.ASCII "ABCDEFGHIJKL AAAAAAAAAAA\0"
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
LJSTR:				;;
	CALL TRANS_LANG		;;			
	CALL ENSTR_LEN		;;
	MOV LCDX_LIM0,W0	;;
	SUB LCDX_LIM1,WREG	;;
	INC W0,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV STR_LEN,W2          ;;	
	SUB W0,W2,W0		;;
	PUSH W0			;;
	MOV LCDX_LIM0,W0	;;	
	MOV W0,LCDX		;;
	MOV LCDY_LIM0,W0	;;	
	MOV W0,LCDY		;;
	CALL ENSTR		;;
	POP BMPX		;;
	MOV #16,W0		;;
	MOV W0,BMPY		;;
	CALL DISP_BLK		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CJSTR:
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
	MOV #102,W0		;;
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
	MOV #118,W0		;;
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
CHK_MENU_IS_DISABLE:		;;
	CP0 DPPSEL_CNT		;;	
	BRA NZ,$+4		;;
	RETURN			;;
	DEC DPPSEL_CNT,WREG	;;
	MUL.UU W0,#8,W2		;;
	MOV W2,W0		;;
	ADD MENU_ADR,WREG	;;
	ADD W0,#6,W1		;;
	TBLRDL [W1],W0		;;
	XOR W0,#1,W0		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DPPSET:				;;
	MOV DPPSET_PRE,W0	;;	
	CP DPPSET_CNT		;;
	BRA NZ,$+4		;;
	RETURN			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL C_BKBK		;;
	MOV DPPSET_PRE,W0	;;
	CALL DRAW_DPPSET	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV DPPSET_CNT,W0	;;
	MOV W0,DPPSET_PRE	;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL C_RDRD		;; 
	MOV DPPSET_CNT,W0	;;
	CALL DRAW_DPPSET	;;
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
;	LOFFS1 #A1_ARM_TBL
	MOV #0,W0
	CALL LOAD_DPP
;	LOFFS1 #A2_ARM_S_TBL
	MOV #1,W0
	CALL LOAD_DPP
;	LOFFS1 #A3_ARM_ST_TBL
	MOV #2,W0
	CALL LOAD_DPP
;	LOFFS1 #A4_PANIC_TBL
	MOV #3,W0
	CALL LOAD_DPP
;	LOFFS1 #A6_CH2_TBL
	MOV #4,W0
	CALL LOAD_DPP
;	LOFFS1 #A7_CH3_TBL
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
	BTSC KEY_FLAG0,#0
	BRA DPP_KEY0
	BTSC KEY_FLAG0,#1
	BRA DPP_KEY1
	BTSC KEY_FLAG0,#2
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
	INC LCDY		;;
	DEC R1			;;
	BRA NZ,DISP_BLK0	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPY,W0		;;
	SUB LCDY		;;	
	BSET FCS,#FCS_P		;;
	POP LCDY		;;
	POP LCDX		;;
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
	INC LCDY		;;
	BSET FCS,#FCS_P		;;
	POP FADR1		;;
	POP FADR0		;;
	DEC R1			;;
	BRA NZ,DISP_INP80	;;		
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV BMPY,W0
	SUB LCDY		;;	
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
	IOR TMR2_IORF
	XOR TMR2_BUF
	CLRWDT
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





FLASH_SLEEP:
	BCLR FCS,#FCS_P
	MOV #0x00B9,W0
	CALL SPIPRG
	BSET FCS,#FCS_P
	RETURN
FLASH_RESET:
	BCLR FCS,#FCS_P
	MOV #0x00AB,W0
	CALL SPIPRG
	BSET FCS,#FCS_P
	RETURN


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



ERASE_FRAM_BK:
	CALL CHK_FLASH_WEN
	CALL FLASH_WREN
	MOV #0x003D,W0
	CALL FLASH_BS
ERASE_FRAM_BK1:
	CALL FLASH_RDSR
	BTSC SPI1BUF,#0
	BRA ERASE_FRAM_BK1
	RETURN



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WRITE_FRAM_BK:				;;
	CALL CHK_FLASH_WEN		;;
	CALL FLASH_WREN			;;
	CLR FADR0			;;	
	BCLR FCS,#FCS_P			;;
	MOV #0x0002,W0			;;
	CALL SPIPRG			;;
	MOV #0x003D,W0			;;
	CALL SPIPRG			;;
	MOV #0000,W0			;;
	CALL SPIPRG			;;
	MOV #0000,W0			;;
	CALL SPIPRG			;;
	BRA WRITE_FRAM1			;;
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
VERIFY_FRAM_BK:				;;
	CALL WAIT_FLASH_READY		;;
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
	BRA VERIFY_FRAM1		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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





















INIT_OSC:
	MOV OSCCON,W0
	MOV #OSCCONL, w1
	MOV #0x46, w2
	MOV #0x57, w3
	MOV.B W2,[W1]
	MOV.B W3,[W1]
	BSET OSCCON,#1 ;32768 OSC ENABLE

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

;	MOV #0xFE1F,W0
;	MOV W0,LATB 
;	MOV #0x1C17,W0
;	MOV W0,TRISB 

	MOV #0xFF5F,W0
	MOV W0,LATB 
	MOV #0x1D5F,W0
	MOV W0,TRISB 


 	MOV #0x0300,W0
	MOV W0,LATC  
 	MOV #0x0300,W0
	MOV W0,TRISC 
	MOV #0xFFFF,W0
	MOV W0,AD1PCFG 
	BSET MRXE,#MRXE_P
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
	MOV #0xA030,W0
	MOV W0,T2CON		;BASE TIME
	;;;;;;;;;;;;;;;;;
	CLR TMR1
	BCLR IFS0,#T1IF
	MOVLF 7680,PR1
	MOV #0x8032,W0
	MOV W0,T1CON		;REAL TIME
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



LCD_OFF:
  .IFDEF NEWLCD_K		;;
	W0LCD 0x28		;;	
	W0LCD 0x10		;;
	RETURN
  .ELSE				;;
	WLCDP 0x0D,0x0000	;;<<	
	WLCDP 0x0E,0x1319	;;<<
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WLCDP 0x07,0x0036
	CALL DLYMS
	WLCDP 0x07,0x0026
	CALL DLYMS
	WLCDP 0x07,0x0004
	CALL DLYMS
	WLCDP 0x09,0x00E8
	WLCDP 0x03,0x01E0
;	WLCDP 0x03,0x01E2	;SLEEP
	WLCDP 0x03,0x01E1	;STANBY
	RETURN
  .ENDIF			;;

LCD_ON:
  .IFDEF NEWLCD_K		;;
	W0LCD 0x11		;;
	W0LCD 0x29		;;	
	RETURN
  .ELSE
	WLCDP 0x00,0X0001
	MOV #10,W0
	CALL DLYMX
	WLCDP 0x03,0x0148
	CALL DLYMS
	WLCDP 0x0D,0x0013	;;<<
	WLCDP 0x0E,0x3319
	;;;;;;;;;;;;;;;;;;;;;;;;
	WLCDP 0x03,0x0148
	WLCDP 0x09,0x0044
	WLCDP 0x07,0x0005
	CALL DLYMS
	WLCDP 0x07,0x0025
	WLCDP 0x07,0x0027
	CALL DLYMS
	WLCDP 0x07,0x0037
	WLCDP 0x03,0x0148
	RETURN
  .ENDIF	


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
  .IFDEF NEWLCD_K
	CALL RESET_LCD
	W0LCD 0x11		;;SLEEP OUT	
	W0LCD 0x13		;;ENTER NORMAL MODE
	W0LCD 0x29		;;
	W8LCD 0x3A,0x55		;;		
;	W8LCD 0x36,0x08		;;		
	W8LCD 0x26,0x08		;;

	RETURN
  .ELSE	
	CALL RESET_LCD
	WLCDP 0x00,0x0001 	;;<<
	WLCDP 0x07,0x0004 
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
	RETURN
  .ENDIF 
INIT_LCD1:
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
RESET_LCD:				;;
	BSET LCDCS,#LCDCS_P 		;;
	BCLR LCDRST,#LCDRST_P		;;
	MOV #2,W0			;;
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
	MOV #0x3F08,W0		;;UART1
	MOV W0,RPINR18		;;
	MOV #0x0003,W0		;;
	MOV W0,RPOR3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #0x0A00,W0		;;
;	MOV W0,RPINR0		;;INT1
;	MOV #0x0002,W0		;;
;	MOV W0,RPINR1		;;INT2
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x1F18,W0		;;
	MOV W0,RPINR20		;;SDI1
	MOV #0x081F,W0		;;
	MOV W0,RPOR4		;;SCLK1
	MOV #0x071F,W0		;;
	MOV W0,RPOR12		;;SDO1
	MOV #0x1600,W0		;;
	MOV W0,RPOR2		;;OC5
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

C_YLYL:
	MOV #0x07FF,W0
	MOV W0,COLOR_F
	MOV W0,COLOR_B
	RETURN

C_RDRD:
	MOV #0x001F,W0
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

C_WTWT:
	MOV #0xFFFF,W0
	MOV W0,COLOR_F
	MOV W0,COLOR_B
	RETURN




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
W1P:				;;
	BTSC FLAGA,#GOTOXY_F	;;
	BRA W1PA		;;
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
  .IFDEF NEWLCD_K			;;
	BCLR LCDCS,#LCDCS_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BCLR LCDRS,#LCDRS_P		;;	
	MOV #0x2A,W0             	;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;	
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDRS,#LCDRS_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR.B LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDX,W0			;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR.B LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #127,W0			;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDCS,#LCDCS_P		;;
	NOP				;;
	NOP				;;
	NOP				;;
	NOP				;;
	BCLR LCDCS,#LCDCS_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BCLR LCDRS,#LCDRS_P		;;	
	MOV #0x2B,W0             	;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;	
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDRS,#LCDRS_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR.B LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV LCDY,W0			;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR.B LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #159,W0			;;
	MOV.B WREG,LATC			;;
	BCLR LCDWR,#LCDWR_P		;;
	BSET LCDWR,#LCDWR_P		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET LCDCS,#LCDCS_P		;;
	RETURN



  .ELSE					;;
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
  .ENDIF 	

















ENBYTE:
	PUSH W0
	SWAP.B W0
;	AND #0x000F,W0
	CALL ENNUM
	POP W0
;	AND #0x000F,W0
	CALL ENNUM
	RETURN	

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
ENNUM:					;;
	AND #15,W0			;;
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
	BTSC FLAGC,#RAMSTR_F		;;
        MOV #RAMSTR_BUF,W1	        ;;
ENSTR0:					;;	
	BTSS FLAGC,#RAMSTR_F		;;
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
	CP W0,#8			;;
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
