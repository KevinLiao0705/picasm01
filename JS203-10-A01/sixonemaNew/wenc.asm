;ESTABLISH 2015,11,04



;      LIST P=18F14K50,R=DEC
#INCLUDE "P18F8722.INC"



#define	VER_K	10
URX_LEN_LIM_K	EQU 64





#DEFINE PSW     STATUS  
#define	BNK	1




BR	        EQU 1 

bank0		idata_acs

FLAGA		RES 1
FLAGB		RES 1
FLAGC		RES 1
FLAGD		RES 1
;=======================


W_TEMP     	RES 1
STATUS_TEMP	RES 1
RR0  		RES 1
RR1  		RES 1
RR2  		RES 1
RR3  		RES 1
RR4  		RES 1
RR5		RES 1
RR6		RES 1
RR7		RES 1
RR8		RES 1

FSR0L_B		RES 1
FSR0H_B		RES 1

UTX_BCNT	RES 1
UTX_BTX		RES 1
INTBUF		RES 1
URX_BYTE_PTR	RES 1
URXB_LEN	RES 1
URXA_LEN	RES 1
TIMER_FLAG0	RES 1
TIMER_FLAG1	RES 1
TMR3H_BUF	RES 1
TMR3K_BUF	RES 1
TMR3K_CNT	RES 1
UTXCMD		RES 1
UBUF0		RES 1
UBUF1		RES 1
UBUF2		RES 1
UBUF3		RES 1
UBUF4		RES 1
UBUF5		RES 1
UTX_TIM		RES 1

ACTION		RES 1
SERNO0		RES 1
SERNO1		RES 1
PULSE0		RES 1
PULSE1		RES 1
PULSE2		RES 1
PULSE3		RES 1
PULSE4		RES 1
PULSE5		RES 1

PRTM0L		RES 1
PRTM0H		RES 1
PRTM1L		RES 1
PRTM1H		RES 1


RES_END		RES 1



UTX_BUF		EQU 0x100
URX_BUFA	EQU 0x140
URX_BUFB	EQU 0x180
URX_BUF		EQU 0x1C0








#DEFINE Q1_I			PORTA,4	
#DEFINE Q2_I			PORTC,0	
#DEFINE Q1_IO			TRISA,4	
#DEFINE Q2_IO			TRISC,0	



#DEFINE TEST_O			LATH,2	
#DEFINE TEST_IO			TRISH,2	

#DEFINE LED_O			LATB,4	
#DEFINE LED_IO			TRISB,4	









#DEFINE C_F             STATUS,0
#DEFINE Z_F             STATUS,2






#DEFINE ERR_F		    	FLAGA,0
#DEFINE URX_START_F   	 	FLAGA,1
#DEFINE URXT_F		    	FLAGA,2
#DEFINE UTX_WAITTX_F	    	FLAGA,3
#DEFINE LOAD_DATA_F  	    	FLAGA,4
#DEFINE URX_BUFAB_F          	FLAGA,5
#DEFINE URX_PACKA_F	       	FLAGA,6	;FIX
#DEFINE URX_PACKB_F	 	FLAGA,7	;FIX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





#DEFINE T1MS_F        	TIMER_FLAG0,0
#DEFINE T2MS_F        	TIMER_FLAG0,1
#DEFINE T4MS_F        	TIMER_FLAG0,2
#DEFINE T8MS_F        	TIMER_FLAG0,3
#DEFINE T16MS_F        	TIMER_FLAG0,4
#DEFINE T32MS_F        	TIMER_FLAG0,5
#DEFINE T64MS_F       	TIMER_FLAG0,6
#DEFINE T128MS_F       	TIMER_FLAG0,7

#DEFINE T256MS_F       	TIMER_FLAG1,1
#DEFINE T512MS_F       	TIMER_FLAG1,2
#DEFINE T1S_F        	TIMER_FLAG1,3
#DEFINE T2S_F        	TIMER_FLAG1,4
#DEFINE T4S_F        	TIMER_FLAG1,5
#DEFINE T8S_F       	TIMER_FLAG1,6
#DEFINE T16S_F       	TIMER_FLAG1,7
;DEFINE T32S_F       	TIMER0_FLAG1,6
;DEFINE T64S_F       	TIMER0_FLAG1,7













































        code        
        org 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RESET_VECTOR: 			;;
        BRA POWER_ON        	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HISR_VECTOR:			;;
        ORG 0x0008		;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LISR_VECTOR:			;;
        ORG 0x0018		;;
        BTFSC PIR1,RC1IF        ;;
        BRA URX_INT		;;
	BTFSC PIR1,TX1IF	;;
        BRA UTXINT		;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANS:                      ;;
        ADDWF PCL               ;;
        RETLW 01H               ;;
        RETLW 02H               ;;
        RETLW 04H               ;;
        RETLW 08H               ;;
        RETLW 10H               ;;
        RETLW 20H               ;;
        RETLW 40H               ;;
        RETLW 80H               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASCII_TBL:			;;
	ANDLW 15		;;
	MOVWF RR1		;;
	ADDWF RR1		;;
	MOVF RR1,W		;;	
	ADDWF PC 		;;
	RETLW 30H		;;
	RETLW 31H		;;
	RETLW 32H		;;
	RETLW 33H		;;
	RETLW 34H		;;
	RETLW 35H		;;
	RETLW 36H		;;
	RETLW 37H		;;
	RETLW 38H		;;
	RETLW 39H		;;
	RETLW 41H		;;
	RETLW 42H		;;
	RETLW 43H		;;
	RETLW 44H		;;
	RETLW 45H		;;
	RETLW 46H		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXCMD_JMPTBL:			;;
	CLRF PCLATH		;;
	ANDLW 00011100B		;;
	ADDWF PC 		;;
	GOTO URXCMD_J0		;;
	GOTO URXCMD_J1		;;
	GOTO URXCMD_J2		;;
	GOTO URXCMD_J3		;;
	GOTO URXCMD_J4		;;
	GOTO URXCMD_J5		;;
	GOTO URXCMD_J6		;;
	GOTO URXCMD_J7		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTXINT:					;;
        MOVWF W_TEMP            	;;   
        MOVFF STATUS,STATUS_TEMP	;;
	MOVFF FSR0L,FSR0L_B		;;
	MOVFF FSR0H,FSR0H_B		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LFSR FSR0,UTX_BUF		;;
	MOVF UTX_BCNT,W			;;
	ADDWF FSR0L			;;
	MOVF INDF0,W			;;	
	MOVWF TXREG1			;;
	INCF UTX_BCNT			;;
	MOVF UTX_BTX,W			;;
	SUBWF UTX_BCNT,W		;;
	BTFSC PSW,C			;;
	BCF PIE1,TX1IE			;;
UTXINT_END:				;;
	MOVFF FSR0L_B,FSR0L		;;
	MOVFF FSR0H_B,FSR0H		;;
        MOVF W_TEMP,W           	;;
        MOVFF STATUS_TEMP,STATUS	;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URX_INT:				;;
        MOVWF W_TEMP            	;;   
        MOVFF STATUS,STATUS_TEMP	;;
	MOVFF FSR0L,FSR0L_B		;;
	MOVFF FSR0H,FSR0H_B		;;
	BCF PIR1,RC1IF			;;
	MOVF RCREG1,W			;;	
	MOVWF INTBUF			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW 0xEA			;;
	XORWF INTBUF,W			;;
	BTFSC PSW,Z			;;
	BRA URXI_PS			;;		 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSS URX_START_F		;;
	BRA URXI_END			;;
	MOVLW 01000000B			;;
	BTFSC URX_BUFAB_F		;;
	MOVLW 10000000B			;;
	ANDWF FLAGA,W			;;
	BTFSS PSW,Z			;;
	BRA URXI_ERR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW 0xEB			;;
	XORWF INTBUF,W			;;
	BTFSC PSW,Z			;;
	BRA URXI_PE			;;		 
	MOVLW 0xEC			;;
	XORWF INTBUF,W			;;
	BTFSC PSW,Z			;;
	BRA URXI_PT			;;		 
	MOVLW 0xAB			;;
	BTFSC URXT_F			;;
	XORWF INTBUF			;;
	BCF URXT_F			;;
	MOVLW URX_LEN_LIM_K		;;
	SUBWF URX_BYTE_PTR,W		;;	
	BTFSC PSW,C			;;
	BRA URXI_ERR			;;
	LFSR FSR0,URX_BUFA		;;
	BTFSC URX_BUFAB_F		;;
	LFSR FSR0,URX_BUFB		;;
	MOVF URX_BYTE_PTR,W		;;	
	ADDWF FSR0L			;;
	MOVF INTBUF,W			;;
	MOVWF INDF0			;;
	INCF URX_BYTE_PTR		;;	
	BRA URXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXI_PS:				;;
	BCF URXT_F			;;
	BSF URX_START_F			;;
	CLRF URX_BYTE_PTR		;;
	BRA URXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXI_PE:				;;
	BCF URXT_F			;;
	BTFSS URX_START_F		;;
	BRA URXI_END			;;
	MOVF URX_BYTE_PTR,W		;;	
	BTFSS URX_BUFAB_F		;;	
	MOVWF URXA_LEN			;;
	BTFSC URX_BUFAB_F		;;	
	MOVWF URXB_LEN			;;
	BTFSS URX_BUFAB_F		;;	
	BSF URX_PACKA_F			;;
	BTFSC URX_BUFAB_F		;;	
	BSF URX_PACKB_F			;;
	BTG URX_BUFAB_F			;;
	CLRF URX_BYTE_PTR		;; 
	BRA URXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXI_PT:				;;
	BSF URXT_F			;;
	BRA URXI_END			;;
URXI_ERR:				;;
	BCF URX_START_F			;;
URXI_END:				;;
	MOVFF FSR0L_B,FSR0L		;;
	MOVFF FSR0H_B,FSR0H		;;
        MOVF W_TEMP,W           	;;
        MOVFF STATUS_TEMP,STATUS	;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:			;;
	CLRF FLAGA		;;
	CLRF FLAGB		;;
	CLRF FLAGC		;;
	CLRF FLAGD		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INIT_IO:
	BCF TEST_IO		;;
	BSF Q1_IO		;;
	BSF Q2_IO		;;
	BCF LED_IO		;;	
	MOVLW 00001111B
	MOVWF ADCON1
	RETURN
	
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
POWER_ON:			;;
WAKEUP:				;;
	CLRWDT			;;
        BCF INTCON,GIEH         ;;
        BCF INTCON,GIEL         ;;      
	MOVLB 0
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	CALL INIT_IO		;;
;	CALL INIT_SFR		;;
	MOVLW 100		;;
	CALL DLYMX		;;
	CALL INIT_IO		;;
	CALL CLR_ALLRAM		;;
	CALL INIT_TIMER		;;
	CALL INIT_UART		;;
	CALL INIT_INT		;;

	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_ALLRAM:		;;
	LFSR FSR0,0	;;	
CLR_ALLRAM1:		;;
	MOVLW 0		;;
	MOVWF POSTINC0	;;
	MOVLW 0x0F	;;	
	SUBWF FSR0H,W	;;
	BTFSS PSW,C	;;
	BRA CLR_ALLRAM1	;;
	RETURN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:				;;
	CLRWDT			;;
	BTFSC T256MS_F		;;
	BTG LED_O		;;
	CALL TIMER_PRG		;;
	CALL PULSPRG
	CALL CHK_URX		;;
	CALL CHK_UTX		;;
	BRA MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PULSPRG:				;;
	MOVF TMR0L,W			;;
	MOVWF RR0			;;
	MOVF TMR1L,W			;;
	MOVWF RR2			;;
	MOVF TMR0H,W			;;
	MOVWF RR1			;;
	MOVF TMR1H,W			;;
	MOVWF RR3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVF PRTM0L,W			;;
	SUBWF RR0,W			;;
	MOVWF RR4			;;
	MOVF PRTM0H,W			;;
	SUBWFB RR1,W			;;
	MOVWF RR5			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	MOVF PRTM1L,W			;;
	SUBWF RR2,W			;;
	MOVWF RR6			;;
	MOVF PRTM1H,W			;;
	SUBWFB RR3,W			;;
	MOVWF RR7			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	MOVF RR0,W			;;
	MOVWF PRTM0L			;;					
	MOVF RR1,W			;;
	MOVWF PRTM0H			;;					
	MOVF RR2,W			;;
	MOVWF PRTM1L			;;					
	MOVF RR3,W			;;
	MOVWF PRTM1H			;;					
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVF RR4,W			;;
	SUBWF RR6,W			;;
	MOVWF RR0			;;
	MOVF RR5,W			;;
	SUBWFB RR7,W			;;
	MOVWF RR1			;;
	BTFSS RR1,7			;;
	BRA PULSPRG_1			;;
	COMF RR0			;;
	COMF RR1			;;
	INCF RR0			;;
	BTFSC PSW,Z			;;
	INCF RR1			;;
	MOVF RR0,W			;;
	SUBWF PULSE0			;;
	MOVF RR1,W			;;
	SUBWFB PULSE1			;;
	MOVLW 0				;;
	SUBWFB PULSE2			;;
	SUBWFB PULSE3			;;
	SUBWFB PULSE4			;;
	SUBWFB PULSE5			;;
	RETURN 				;;
PULSPRG_1:				;;
	MOVF RR0,W			;;
	ADDWF PULSE0			;;
	MOVF RR1,W			;;
	ADDWFC PULSE1			;;
	MOVLW 0				;;
	ADDWFC PULSE2			;;
	ADDWFC PULSE3			;;
	ADDWFC PULSE4			;;
	ADDWFC PULSE5			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_UTX:				;;
;	BTFSS LOAD_DATA_F		;;
;	RETURN				;;
	BTFSC PIE1,TXIE			;;
	RETURN				;;
	BTFSS T256MS_F			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW 1				;;
	ADDWF SERNO0			;;
	MOVLW 0				;;
	ADDWFC SERNO1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOVLW 64
;	ADDWF PULSE0
;	MOVLW 31
;	ADDWFC PULSE1
;	MOVLW 0
;	ADDWFC PULSE2
;	MOVLW 0
;	ADDWFC PULSE3
;	MOVLW 0
;	ADDWFC PULSE4
;	MOVLW 0
;	ADDWFC PULSE5
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL UTXPULS			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_URX:				;;
	BTFSC URX_PACKA_F		;;
	BRA CHK_URXA			;;
	BTFSC URX_PACKB_F		;;
	BRA CHK_URXB			;;
	RETURN				;;
CHK_URXA:				;;
	LFSR FSR0,URX_BUFA		;;
	CALL LOAD_URX			;;
	BCF URX_PACKA_F			;;
	BTFSS ERR_F			;;
	CALL URXCMD			;;
	RETURN				;;
CHK_URXB:				;;
	LFSR FSR0,URX_BUFB		;;
	CALL LOAD_URX			;;
	BCF URX_PACKB_F			;;
	BTFSS ERR_F			;;
	CALL URXCMD			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_URX:				;;
	BSF ERR_F			;;
	MOVFF POSTINC0,RR7		;;DATA_LEN
	MOVLW URX_LEN_LIM_K		;;
	SUBWF RR7,W			;;
	BTFSC PSW,C			;;
	RETURN				;;
	MOVLW 0xAB
	MOVWF RR4			;;CHKSUM0
	CLRF RR5			;;CHKSUM1
	LFSR FSR2,URX_BUF		;;  
LOAD_URX_1:				;;
	MOVF POSTINC0,W			;;
	XORWF RR4			;;
	ADDWF RR5			;;			
	MOVWF POSTINC2			;;
	DECFSZ RR7			;;
	BRA LOAD_URX_1			;;
	MOVF POSTINC0,W			;;
	XORWF RR4,W			;;
	BTFSS PSW,Z			;;
	RETURN				;;
	MOVF POSTINC0,W			;;
	XORWF RR5,W			;;
	BTFSC PSW,Z			;;
	BCF ERR_F			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXCMD:					;;
	LFSR FSR0,URX_BUF		;;		
	MOVFF POSTINC0,UBUF0		;;group 
	MOVFF POSTINC0,UBUF1		;;command
	MOVFF POSTINC0,UBUF2		;;flag
	MOVFF POSTINC0,UBUF3		;;pack_cnt
	MOVFF POSTINC0,UBUF4		;;wdata_cnt
	MOVLW 0xA0			;;
	XORWF UBUF0,W			;;
	BTFSS PSW,Z			;;
	RETURN				;;
	MOVLW 8				;;
	SUBWF UBUF1,W			;;
	BTFSC PSW,C			;;
	RETURN				;;
	CLRF UTX_TIM			;;
	MOVF UBUF1,W			;;
	MOVWF RR0			;;
	RLCF RR0			;;	
	RLCF RR0			;;
	BCF RR0,0			;;
	BCF RR0,1			;;
	MOVF RR0,W			;;
	GOTO URXCMD_JMPTBL 		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXCMD_J0:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXCMD_J1:				;;
	CALL UTX_RESP			;;
	BSF LOAD_DATA_F			;;
	RETURN				;;
URXCMD_J2:				;;
	CALL UTX_RESP			;;
	CLRF PULSE0			;;
	CLRF PULSE1			;;
	CLRF PULSE2			;;
	CLRF PULSE3			;;
	CLRF PULSE4			;;
	CLRF PULSE5			;;
	CLRF SERNO0			;;
	CLRF SERNO1			;;
	RETURN				;;
URXCMD_J3:				;;
URXCMD_J4:				;;
URXCMD_J5:				;;
URXCMD_J6:				;;
URXCMD_J7:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_RESP:				;;
	BCF PIE1,TX1IE			;;		
	MOVLW 0x00			;;
	MOVWF UTXCMD			;;
	CALL UTXSTD			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTXSTD:					;;
	BTFSC PIE1,TX1IE		;;
	RETURN				;;
	CALL UTX_START			;;
	MOVLW 0xA1			;;				
	CALL LOAD_U1BYTE_C		;;
	MOVF UTXCMD,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF UBUF0,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF UBUF1,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF UBUF2,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF UBUF3,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF UBUF4,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF UBUF5,W			;;
	CALL LOAD_U1BYTE_C		;;
	CALL UTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTXPULS:				;;
	CALL UTX_START			;;
	MOVLW 0xA1			;;				
	CALL LOAD_U1BYTE_C		;;
	MOVLW 2				;;
	CALL LOAD_U1BYTE_C		;;
	MOVF ACTION,W			;; 
	CALL LOAD_U1BYTE_C		;;
	MOVF SERNO0,W			;; 
	CALL LOAD_U1BYTE_C		;;
	MOVF SERNO1,W			;; 
	CALL LOAD_U1BYTE_C		;;
	MOVF PULSE0,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF PULSE1,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF PULSE2,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF PULSE3,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF PULSE4,W			;;
	CALL LOAD_U1BYTE_C		;;
	MOVF PULSE5,W			;;
	CALL LOAD_U1BYTE_C		;;
	CALL UTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_INT:			;;
;	MOVLW 00000101B		;;
;	MOVWF CCP1CON		;;ADF_DCLK EVERY RISING EDGE
;	BSF IPR1,CCP1IP		;;
;	BCF CCP1IF_F		;; 	
;	BCF CCP1IE_F		;;
;	BSF IPR1,TMR2IP		;;
;	BCF PIR1,TMR2IF		;;	
;	BCF PIE1,TMR2IE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF IPR1,RC1IP		;;
	BCF IPR1,TX1IP		;;
	BCF PIR1,RC1IF         	;; 
	BSF PIE1,RC1IE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF RCON,IPEN		;;
        BSF INTCON,GIEH	 	;;	
        BSF INTCON,GIEL	 	;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER:			;;
        MOVLW 10101000B         ;;
        MOVWF T0CON             ;;
        MOVLW 10110001B         ;;
        MOVWF T3CON             ;;
        MOVLW 10000111B         ;;
        MOVWF T1CON             ;;
	CLRF TMR0H		;;
	CLRF TMR1H		;;	
	CLRF TMR0L		;;	
	CLRF TMR1L		;;
	CLRF PRTM0L		;;
	CLRF PRTM0H		;;
	CLRF PRTM1L		;;
	CLRF PRTM1H		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;OSC=11.0592	PREDIV=8	
;TIMER_FLAG0.0=740.74US 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TIMER_PRG:				;;
	CLRF TIMER_FLAG0		;;	
	CLRF TIMER_FLAG1		;;
	MOVF TMR3L,W			;;
	MOVF TMR3H,W			;;
	XORWF TMR3H_BUF,W		;;
	BTFSC PSW,Z			;;
	RETURN				;;
	XORWF TMR3H_BUF			;;2048
	MOVWF TIMER_FLAG0		;;
	BTFSS TIMER_FLAG0,7 		;;
	RETURN				;;
	INCF TMR3K_CNT			;;
	MOVF TMR3K_CNT,W		;;
	XORWF TMR3K_BUF,W		;;
	MOVWF TIMER_FLAG1		;;
	XORWF TMR3K_BUF			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_TEST:				;;
	BTFSC PIE1,TX1IE		;;
	RETURN				;;
	CALL UTX_START			;;
	MOVLW 0xA1			;;				
	CALL LOAD_U1BYTE_C		;;
	MOVLW 0x00			;;
	CALL LOAD_U1BYTE_C		;;
	CALL UTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_START:				;;
	CLRF UTX_BTX			;;
	CLRF UTX_BCNT			;;
	CLRF RR6			;;UTX_LEN
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW 0xAB			;;
	MOVWF RR4			;;CHKSUM0
	CLRF RR5			;;CHKSUM1
	LFSR FSR0,UTX_BUF		;;
	MOVLW 0xEA			;;
	CALL LOAD_U1BYTE_A		;;
	MOVF RR6,W			;;
	CALL LOAD_U1BYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1BYTE_A:				;;
	MOVWF POSTINC0			;;
	INCF UTX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1BYTE_B:				;;
	MOVWF RR0			;;
	MOVLW 0xEA			;;
	XORWF RR0,W			;;
	BTFSC PSW,Z			;;
	BRA LOAD_U1BYTE_B1		;;	
	MOVLW 0xEB			;;
	XORWF RR0,W			;;
	BTFSC PSW,Z			;;
	BRA LOAD_U1BYTE_B1		;;	
	MOVLW 0xEC			;;
	XORWF RR0,W			;;
	BTFSC PSW,Z			;;
	BRA LOAD_U1BYTE_B1		;;	
	MOVF RR0,W			;;
	MOVWF POSTINC0			;;
	INCF UTX_BTX			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1BYTE_B1:				;;
	MOVLW 0xEC			;;
	MOVWF POSTINC0			;;
	INCF UTX_BTX			;;
	MOVF RR0,W			;;
	XORLW 0xAB			;;
	MOVWF POSTINC0			;;
	INCF UTX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_U1BYTE_C:				;;
	XORWF RR4			;;
	ADDWF RR5			;;
	INCF RR6			;; 
	CALL LOAD_U1BYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_END:				;;
	MOVF RR4,W			;;
	CALL LOAD_U1BYTE_B		;;
	MOVF RR5,W			;;
	CALL LOAD_U1BYTE_B		;;
	MOVLW 0xEB			;;
	CALL LOAD_U1BYTE_A		;;
	LFSR FSR0,UTX_BUF+1		;;
	MOVF RR6,W			;;
	CALL LOAD_U1BYTE_B		;;
	DECF UTX_BTX			;;
	CLRF UTX_BCNT			;;
	BSF PIE1,TX1IE			;;
	BCF UTX_WAITTX_F		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART:			;;
	MOVLW 00100100B		;;
	MOVWF TXSTA1		;;
	MOVLW 10010000B		;;
	MOVWF RCSTA1		;;
	MOVLW 00001000B		;;
	MOVWF BAUDCON1		;;
	MOVLW 23 		;;11.0592 115200	
	MOVWF SPBRG1		;;
	MOVLW 0			;;
	MOVWF SPBRGH1		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
DLYMS:				;;
        MOVLW 1			;;
DLYMX:				;;
        MOVWF RR0		;;
DLY1:				;;
	CLRWDT			;;
        MOVLW 250		;;
DLY0:				;;
        ADDLW 255		;;
        BTFSS PSW,Z		;;
        BRA DLY0		;;
        DECFSZ RR0		;;
        BRA DLY1		;;
        RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




        
        END

