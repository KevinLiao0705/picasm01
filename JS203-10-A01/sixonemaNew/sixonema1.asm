;ESTABLISH 2015,11,04



;      LIST P=18F14K50,R=DEC
#INCLUDE "P18F8722.INC"



#define	VER_K	10
URX_LEN_LIM_K	EQU 64





#DEFINE PSW     STATUS  
#define	BNK	1




#define KID_M1 		0
#define KID_NUM1 	1
#define KID_NUM2 	2
#define KID_NUM3 	3
#define KID_M2 		4
#define KID_NUM4 	5
#define KID_NUM5 	6
#define KID_NUM6 	7
#define KID_M3 		8
#define KID_NUM7 	9
#define KID_NUM8 	10
#define KID_NUM9 	11
#define KID_M4 		12
#define KID_STAR 	13
#define KID_NUM0 	14
#define KID_SHARP 	15
#define KID_HANDSET 	16
#define KID_TRIANGLE 	17
#define KID_HANDFREE_ON 18
#define KID_HANDFREE_OFF 19
#define KID_OK 		20
#define KID_MUTE 	21
#define KID_VOLDOWN 	22
#define KID_VOLUP 	23
#define KID_UP 		24
#define KID_LEFT 	25
#define KID_DOWN 	26
#define KID_RIGHT 	27
#define KID_MODE 	28
#define KID_INFO 	29
#define KID_LIGHT 	30
#define KID_BOOK 	31
#define KID_PTT 	32
#define KID_PTT_RESET 	33



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

FSR1L_B		RES 1
FSR1H_B		RES 1

LCDA_PTR	RES 1
LCDB_PTR	RES 1
LCD_INX		RES 1
LCD_ACTT	RES 1


DEBUG_CNT	RES 1

SPI_ACTT	RES 1
SPI_INX		RES 1


LED_BUF0	RES 1
LED_BUF1	RES 1
LED_BUF2	RES 1
LED_BUF3	RES 1


PTT_TIM		RES 1
PREKEY		RES 1
KID		RES 1
CLICK_TIM	RES 1


KEYFLAG0	RES 1
KEYFLAG1	RES 1
KEYFLAG2	RES 1
KEYFLAG3	RES 1

INTBUF		RES 1
TIMER_FLAG0	RES 1
TIMER_FLAG1	RES 1
TMR3H_BUF	RES 1
TMR3K_BUF	RES 1
TMR3K_CNT	RES 1
RES_END		RES 1






#DEFINE EN1_O			LATE,0	
#DEFINE EN1_IO			TRISE,0	

#DEFINE EN2_O			LATE,1
#DEFINE EN2_IO			TRISE,1	

#DEFINE EN3_O			LATE,2	
#DEFINE EN3_IO			TRISE,2	

#DEFINE EN4_O			LATE,3	
#DEFINE EN4_IO			TRISE,3	

#DEFINE EN7_O			LATE,6	
#DEFINE EN7_IO			TRISE,6	

#DEFINE EN8_O			LATE,7
#DEFINE EN8_IO			TRISE,7	

#DEFINE EN9_O			LATH,2	
#DEFINE EN9_IO			TRISH,2	

#DEFINE EN10_O			LATH,3	
#DEFINE EN10_IO			TRISH,3	

#DEFINE LCDCS_I			PORTB,0	
#DEFINE LCDCS_IO		TRISB,0	

#DEFINE LCDRS_I			PORTB,2	
#DEFINE LCDRS_IO		TRISB,2	

#DEFINE TRIG1_O			LATH,0	
#DEFINE TRIG1_IO		TRISH,0	

#DEFINE SDO_O			LATC,5	
#DEFINE SDO_IO			TRISC,5	

#DEFINE SDI_I			PORTC,4	
#DEFINE SDI_IO			TRISC,4	

#DEFINE SCK_I			PORTC,3	
#DEFINE SCK_O			LATC,3	
#DEFINE SCK_IO			TRISC,3	


#DEFINE TEST_O			LATH,0	
#DEFINE TEST_IO			TRISH,0	


;#DEFINE Q1_I			PORTA,4	
;#DEFINE Q2_I			PORTC,0	
;#DEFINE Q1_IO			TRISA,4	
;#DEFINE Q2_IO			TRISC,0	



;#DEFINE TEST_O			LATH,2	
;#DEFINE TEST_IO		TRISH,2	

;#DEFINE LED_O			LATB,4	
;#DEFINE LED_IO			TRISB,4	









#DEFINE C_F             STATUS,0
#DEFINE Z_F             STATUS,2






#DEFINE LCDHL_F		    	FLAGA,0
#DEFINE LCDRS_F   	 	FLAGA,1
#DEFINE PTTON_F		    	FLAGA,2
#DEFINE PTT_START_F    		FLAGA,3
;#DEFINE LOAD_DATA_F  	    	FLAGA,4
;#DEFINE URX_BUFAB_F          	FLAGA,5
;#DEFINE URX_PACKA_F	       	FLAGA,6	;FIX
;#DEFINE URX_PACKB_F	 	FLAGA,7	;FIX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





#DEFINE T0_F        	TIMER_FLAG0,0
#DEFINE T1_F        	TIMER_FLAG0,1
#DEFINE T2_F        	TIMER_FLAG0,2
#DEFINE T3_F        	TIMER_FLAG0,3
#DEFINE T4_F        	TIMER_FLAG0,4
#DEFINE T5_F        	TIMER_FLAG0,5
#DEFINE T6_F       	TIMER_FLAG0,6
#DEFINE T7_F       	TIMER_FLAG0,7

#DEFINE T8_F       	TIMER_FLAG1,1
#DEFINE T9_F       	TIMER_FLAG1,2
#DEFINE T10_F        	TIMER_FLAG1,3
#DEFINE T11_F        	TIMER_FLAG1,4
#DEFINE T12_F        	TIMER_FLAG1,5
#DEFINE T13_F       	TIMER_FLAG1,6
#DEFINE T14_F       	TIMER_FLAG1,7









LCD_TEMP		EQU 0x100
LCD_BUF			EQU 0x140
SPI_BUF			EQU 0x160




































        code        
        org 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RESET_VECTOR: 			;;
        BRA POWER_ON        	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HISR_VECTOR:			;;
        ORG 0x0008		;;
	BTFSC INTCON,INT0IF	;;
	BRA INT0PRG		;;
	BTFSC INTCON3,INT2IF	;;
	BRA INT2PRG		;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LISR_VECTOR:			;;
        ORG 0x0018		;;
	BCF INTCON3,INT2IF	;;
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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INT0PRG:				;;
	BCF INTCON,INT0IF		;;
        MOVWF W_TEMP            	;;   
        MOVFF STATUS,STATUS_TEMP	;;
	CLRF LCD_ACTT			;;
	BCF EN8_O 			;;
	BSF LCDRS_F			;;
	BTFSS LCDRS_I			;;
	BCF LCDRS_F			;;
	MOVF PORTD,W			;;
	BSF EN8_O			;;
	ANDLW 0xF0			;;
	BTFSC LCDHL_F			;;
	BRA INT1_1			;; 
	MOVWF INTBUF			;;
	SWAPF INTBUF			;;
	BSF LCDHL_F			;;	
	BRA INT0_END
INT1_1:					;;
	IORWF INTBUF			;;
	BCF LCDHL_F			;;	
;	MOVFF FSR1L,FSR1L_B		;;
;	MOVFF FSR1H,FSR1H_B		;;
	LFSR FSR1,LCD_TEMP		;;
	MOVF LCDA_PTR,W			;;
	ANDLW 0x1F			;;
	ADDWF FSR1L			;;
	ADDWF FSR1L			;;
	SWAPF INTBUF,W			;;
	MOVWF POSTINC1			;;  	
	MOVLW 0				;;
	BTFSS LCDRS_F			;;
	MOVLW 1				;;
	MOVWF POSTINC1			;;
	INCF LCDA_PTR			;;
	INCF DEBUG_CNT			;;
;	MOVFF FSR1L_B,FSR1L		;;
;	MOVFF FSR1H_B,FSR1H		;;
INT0_END:				;;
        MOVF W_TEMP,W           	;;
        MOVFF STATUS_TEMP,STATUS	;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INT2PRG:				;;
	BCF INTCON3,INT2IF		;;
	BTG INTCON2,INTEDG2		;;
	BCF LCDHL_F			;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GOTOXY_LCD:				;;
	MOVLW 0x1F			;;
	ANDWF RR0,W			;;
	MOVWF LCD_INX			;;
	CLRF DEBUG_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_LCD:				;;
	CLRF LCD_INX			;;
	MOVLW 20			;;
	MOVWF RR0			;;
	LFSR FSR0,LCD_BUF		;;
CLR_LCD0_1:				;;
	MOVLW 0x20			;;
	MOVWF POSTINC0			;;
	DECFSZ RR0			;;
	BRA CLR_LCD0_1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECLCD:					;;
	MOVF LCDB_PTR,W			;;
	XORWF LCDA_PTR,W		;;
	ANDLW #0x1F			;;
	BTFSC PSW,Z			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LFSR FSR0,LCD_TEMP		;;
	MOVF LCDB_PTR,W			;;	
	ANDLW #0x1F			;;
	ADDWF FSR0L			;;
	ADDWF FSR0L			;;
	MOVF POSTINC0,W			;;
	MOVWF RR0			;;
	MOVF POSTINC0,W			;;
	MOVWF RR1			;;
	INCF LCDB_PTR			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSS RR1,0			;;
	BRA DECLCD_3			;;
	MOVLW 0x01			;;
	XORWF RR0,W			;;
	BTFSS PSW,Z			;;	
	BRA DECLCD_1			;;
	CALL CLR_LCD			;;
	BRA DECLCD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECLCD_1:				;;
	MOVLW 0xE0			;;
	ANDWF RR0,W			;;	
	XORLW 0x80			;;
	BTFSS PSW,Z			;;
	BRA DECLCD_2			;;
	CALL GOTOXY_LCD			;;
	BRA DECLCD			;;
DECLCD_2:				;;
	BRA DECLCD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DECLCD_3:				;;
	LFSR FSR0,LCD_BUF		;;
	MOVF LCD_INX,W			;;
	ANDLW 0x1F			;;
	ADDWF FSR0L			;;
	CALL TRANS_FASC			;; 
	MOVWF POSTINC0			;;
	INCF LCD_INX			;;
	BRA DECLCD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRANS_FASC:				;;
	MOVLW 0x00			;;
	XORWF RR0,W			;;
	BTFSS PSW,Z			;;
	BRA TRANS_FASC_1		;;
	MOVLW 0x3E			;;
	RETURN				;;
TRANS_FASC_1:				;;
	MOVLW 0xF7			;;
	XORWF RR0,W			;;
	BTFSS PSW,Z			;;
	BRA TRANS_FASC_2		;;
	MOVLW '*'			;;
	RETURN				;;
TRANS_FASC_2:				;;
	MOVLW 0xD7			;;
	XORWF RR0,W			;;
	BTFSS PSW,Z			;;
	BRA TRANS_FASC_3		;;
	MOVLW '.'			;;
	RETURN				;;
TRANS_FASC_3:				;;
	MOVF RR0,W			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INLED0:					;;
	MOVLW 255			;;
	MOVWF TRISD			;;
	BCF INTCON,GIE			;;
	NOP				;;
	BCF EN10_O			;;
	NOP				;;
	MOVF PORTD,W			;;	
	BSF EN10_O			;;
	BSF INTCON,GIE			;;
	XORLW 255			;;
	MOVWF LED_BUF0			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INLED1:					;;
	MOVLW 255			;;
	MOVWF TRISD			;;
	BCF INTCON,GIE			;;
	NOP				;;
	BCF EN9_O			;;
	NOP				;;
	MOVF PORTD,W			;;	
	BSF EN9_O			;;
	BSF INTCON,GIE			;;
	XORLW 255			;;
	MOVWF LED_BUF1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INLED2:					;;
	MOVLW 255			;;
	MOVWF TRISD			;;
	BCF INTCON,GIE			;;
	NOP				;;
	BCF EN7_O			;;
	NOP				;;
	MOVF PORTD,W			;;	
	BSF EN7_O			;;
	BSF INTCON,GIE			;;
	MOVWF LED_BUF2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF LED_BUF2,0			;;
	BTFSC PTTON_F			;;
	BSF LED_BUF2,0			;;
	BTFSC KEYFLAG3,7		;;
	BCF LED_BUF2,5			;;HAND SET LED
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INLED3:					;;
	MOVLW 255			;;
	MOVWF TRISD			;;
	BCF INTCON,GIE			;;
	NOP				;;
	BCF EN8_O			;;
	NOP				;;
	MOVF PORTD,W			;;	
	BSF EN8_O			;;
	BSF INTCON,GIE			;;
	MOVWF LED_BUF3			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OUTKEY0:				;;
	BCF INTCON,GIE			;;
	MOVLW 0				;;
	MOVWF TRISD			;;
	MOVF KEYFLAG0,W			;;
	MOVWF PORTD			;;
	BCF EN1_O			;;
	BSF TRIG1_O			;;
	NOP				;;
	BCF TRIG1_O			;;
	BSF EN1_O			;;
	MOVLW 255			;;
	MOVWF TRISD			;;
	BSF INTCON,GIE			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OUTKEY1:				;;
	BCF INTCON,GIE			;;
	MOVLW 0				;;
	MOVWF TRISD			;;
	MOVF KEYFLAG1,W			;;
	MOVWF PORTD			;;
	BCF EN2_O			;;
	BSF TRIG1_O			;;
	NOP				;;
	BCF TRIG1_O			;;
	BSF EN2_O			;;
	MOVLW 255			;;
	MOVWF TRISD			;;
	BSF INTCON,GIE			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OUTKEY2:				;;
	BCF INTCON,GIE			;;
	MOVLW 0				;;
	MOVWF TRISD			;;
	MOVF KEYFLAG2,W			;;
	MOVWF PORTD			;;
	BCF EN3_O			;;
	BSF TRIG1_O			;;
	NOP				;;
	BCF TRIG1_O			;;
	BSF EN3_O			;;
	MOVLW 255			;;
	MOVWF TRISD			;;
	BSF INTCON,GIE			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OUTKEY3:				;;
	BCF INTCON,GIE			;;
	MOVLW 0				;;
	MOVWF TRISD			;;
	MOVF KEYFLAG3,W			;;
	MOVWF PORTD			;;
	BCF EN4_O			;;
	BSF TRIG1_O			;;
	NOP				;;
	BCF TRIG1_O			;;
	BSF EN4_O			;;
	MOVLW 255			;;
	MOVWF TRISD			;;
	BSF INTCON,GIE			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYOUT:				;;
	BCF INTCON,GIE		;;
	MOVLW 0			;;
	MOVWF TRISD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVF KEYFLAG0,W		;;
	MOVWF PORTD		;;
	BCF EN1_O		;;
	BSF TRIG1_O		;;
	BCF TRIG1_O		;;
	BSF EN1_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVF KEYFLAG1,W		;;
	MOVWF PORTD		;;
	BCF EN2_O		;;
	BSF TRIG1_O		;;
	BCF TRIG1_O		;;
	BSF EN2_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVF KEYFLAG2,W		;;
	MOVWF PORTD		;;
	BCF EN3_O		;;
	BSF TRIG1_O		;;
	BCF TRIG1_O		;;
	BSF EN3_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVF KEYFLAG3,W		;;
	MOVWF PORTD		;;
	BCF EN4_O		;;
	BSF TRIG1_O		;;
	BCF TRIG1_O		;;
	BSF EN4_O		;;
	MOVLW 0xFF		;;
	MOVWF TRISD		;;
	BSF INTCON,GIE		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SPI:			;;	
	BCF SSP1CON1,SSPEN	;;	
	BSF TRISF,7		;;	
	MOVLW 00100101B		;;
	MOVWF SSP1CON1		;;
	MOVLW 01000000B		;;
	MOVWF SSP1STAT		;;
	CLRF SPI_INX		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TEST_SPI:
	BCF SCK_IO
TEST_SPI_1:	
	CLRWDT 
	MOVLW 0xCC
	MOVWF SSP1BUF
LOOP0:
	BTFSC SSP1STAT,BF
	BRA LOOP0
	MOVF SSP1BUF,W
	MOVWF RR0
	MOVLW 1
	CALL DLYMX
	BRA TEST_SPI_1	
		
LOOP:
	BTFSS SSP1STAT,BF
	BRA LOOP
	MOVF SSP1BUF,W
	MOVWF RR0
	MOVLW 0xAA
	MOVWF SSP1BUF
	MOVLW 10
	CALL DLYMX
	BRA TEST_SPI_1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_OSC:			;;
	MOVLW 01110010B		;;
	MOVWF OSCCON		;;
	BSF OSCCON,6		;;
	BSF OSCCON,5		;;
	BSF OSCCON,4		;;
;	BSF OSCCON,1		;;
;	BCF OSCCON,0		;;
	BSF OSCTUNE,6		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:			;;
	MOVLW 255		;;
	MOVWF TRISD		;;
	BSF EN1_O		;;
	BSF EN2_O		;;
	BSF EN3_O		;;
	BSF EN4_O		;;
	BSF EN7_O		;;
	BSF EN8_O		;;
	BSF EN9_O		;;
	BSF EN10_O		;;
	BCF TRIG1_O		;;
	BCF SDO_O		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF EN1_IO		;;
	BCF EN2_IO		;;
	BCF EN3_IO		;;
	BCF EN4_IO		;;
	BCF EN7_IO		;;
	BCF EN8_IO		;;
	BCF EN9_IO		;;
	BCF EN10_IO		;;
	BCF TRIG1_IO		;;
	BSF LCDRS_IO		;;
	BSF LCDCS_IO		;;
	BCF SDO_IO		;;
	BSF SDI_IO		;;
	BSF SCK_IO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW 00001111B		;;
	MOVWF ADCON1		;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
POWER_ON:			;;
WAKEUP:				;;
	CLRWDT			;;
        BCF INTCON,GIEH         ;;
        BCF INTCON,GIEL         ;;      
	MOVLB 0
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL INIT_IO		;;
	MOVLW 100		;;
	CALL DLYMX		;;
	CALL INIT_IO		;;
	CALL CLR_ALLRAM		;;
	CALL INIT_SPI		;;
	CALL INIT_RAM		;;	
	CALL INIT_TIMER		;;
	CALL INIT_INT		;;
	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_OSC:			;;
	BCF TEST_IO		;;
TEST_OSC_1:
	CLRWDT			;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	BTG TEST_O		;;
	
	BRA TEST_OSC_1		;;	
	







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
MAINT_PRG:			;;
	BTFSS T1_F		;;684US
	BRA MAINT_1		;;
	INCF SPI_ACTT		;;
	BTFSC PSW,Z		;;
	DECF SPI_ACTT		;;
	MOVLW 10		;;
	SUBWF SPI_ACTT,W	;;	
	BTFSC PSW,Z		;;
	CALL INIT_SPI		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	INCF CLICK_TIM		;;
	BTFSC PSW,Z		;;	
	DECF CLICK_TIM		;;
	MOVLW 70		;;
	SUBWF CLICK_TIM,W	;;
	BTFSC PSW,Z		;;
	CALL FREE_KEY		;;  
MAINT_1:			;;
	BTFSS T2_F		;;1.3M
	BRA MAINT_2		;;
	INCF LCD_ACTT		;;
	MOVLW 100		;;
	SUBWF LCD_ACTT,W	;;
	BTFSC PSW,C		;;
	BCF LCDHL_F		;;
MAINT_2:			;;
	BTFSC T4_F		;;5MS
	CALL PTTPRG		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PTTPRG:				;;
	BTFSS PTT_START_F	;;	
	RETURN			;;
	INCF PTT_TIM		;;
	MOVLW 70		;;
	XORWF PTT_TIM,W		;;
	BTFSC PSW,Z		;;	
	CALL KPUSH_PTT		;;
	MOVLW 140		;;
	XORWF PTT_TIM,W		;;
	BTFSC PSW,Z		;;	
	CALL KPUSH_M1		;;
	MOVLW 140		;;
	SUBWF PTT_TIM,W		;;
	BTFSC PSW,C		;;
	BCF PTT_START_F		;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KPUSH_M1:			;;
	MOVLW KID_M1		;;
	MOVWF KID		;;
	CALL BUTCLICK		;;		 
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KPUSH_PTT:			;;
	MOVLW KID_NUM4		;;
	BTFSS PTTON_F		;;
	MOVLW KID_NUM5		;;
	MOVWF KID		;;
	CALL BUTCLICK		;;		 
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FREE_KEY:			;;
	CLRF KEYFLAG0		;;
	CLRF KEYFLAG1		;;
	CLRF KEYFLAG2		;;
	MOVLW 0x80		;;
	ANDWF KEYFLAG3		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:				;;
	CLRWDT			;;
	CALL TIMER_PRG		;;
	CALL MAINT_PRG		;;
	CALL DECLCD		;;
	CALL SPIPRG		;;	
	BTFSS T1_F		;;
	BRA MAIN		;;
	CALL OUTKEY0		;;
	CALL OUTKEY1		;;
	CALL OUTKEY2		;;
	CALL OUTKEY3		;;
	CALL INLED0		;;
	CALL INLED1		;;
	CALL INLED2		;;
	CALL INLED3		;;
	BRA MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIPRG:				;;		
	BTFSS SSP1STAT,BF	;;
	RETURN			;;
	CLRF SPI_ACTT		;;		
	MOVF SSP1BUF,W		;;
	MOVWF RR0		;;
	MOVLW 0xA0		;;	
	XORWF RR0,W		;;
	BTFSC PSW,Z		;;
	CLRF SPI_INX		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LFSR FSR0,SPI_BUF	;;	
	MOVF SPI_INX,W		;;
	ANDLW 0x1F		;;
	ADDWF FSR0L		;;	
	MOVF RR0,W		;;
	MOVWF POSTINC0		;;	
	CALL SPIOUT		;;
	INCF SPI_INX		;;
	MOVLW 26		;;
	SUBWF SPI_INX,W		;;
	BTFSS PSW,C		;;
	RETURN			;;
	CALL CHK_KEYIN		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
CHK_KEYIN:			;;
	LFSR FSR0,SPI_BUF+1	;;
	MOVF POSTINC0,W		;;
	MOVWF RR0		;;
	MOVF POSTINC0,W		;;
	MOVWF RR1		;;
	MOVF POSTINC0,W		;;
	MOVWF RR2		;;
	MOVF RR0,W		;;
	XORWF RR1,W		;;
	BTFSS PSW,Z		;;
	RETURN			;;
	MOVF RR1,W		;;
	XORWF RR2,W		;;
	BTFSS PSW,Z		;;
	RETURN			;;
	MOVF RR0,W		;;
	XORWF PREKEY,W		;;
	BTFSC PSW,Z		;;
	RETURN			;;
	XORWF PREKEY		;;
	MOVLW 34		;;	
	SUBWF PREKEY,W		;;
	BTFSS PSW,C		;;
	BRA CHK_KEYIN_0		;;
	MOVLW 255		;;
	MOVWF KID		;;
	MOVWF PREKEY		;;
	RETURN			;;
CHK_KEYIN_0: 			;;
	MOVF PREKEY,W		;;
	MOVWF KID		;;
	MOVLW KID_HANDFREE_ON	;;
	XORWF KID,W		;;
	BTFSS PSW,Z		;;
	BRA CHK_KEYIN_1		;;
	CALL BUTCLICK		;;
	RETURN			;;
CHK_KEYIN_1: 			;;
	MOVLW KID_HANDFREE_OFF	;;
	XORWF KID,W		;;
	BTFSS PSW,Z		;;
	BRA CHK_KEYIN_2		;;
	CALL BUTCLICK		;;
	MOVLW KID_HANDSET	;;	
	CALL BUTPRESS		;;
	RETURN			;;
CHK_KEYIN_2: 			;;
	MOVLW KID_PTT		;;
	XORWF KID,W		;;
	BTFSS PSW,Z		;;
	BRA CHK_KEYIN_3		;;
	CALL KPUSH_M1		;;
	BSF PTT_START_F		;;
	BTG PTTON_F		;;
	CLRF PTT_TIM		;;
	RETURN			;;	
CHK_KEYIN_3: 			;;
	MOVLW KID_PTT_RESET	;;
	XORWF KID,W		;;
	BTFSS PSW,Z		;;
	BRA CHK_KEYIN_4		;;
	BCF PTTON_F		;;		
	BCF PTT_START_F		;;
	RETURN			;;	
CHK_KEYIN_4: 			;;
	CALL BUTCLICK		;;	
	RETURN			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BUTPRESS:			;;
	MOVWF RR0		;;
	MOVLW KID_HANDSET	;;
	XORWF RR0,W		;;
	BTFSC PSW,Z		;;
	BRA BUTPRESS_HANDSET	;;
	RETURN			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
BUTPRESS_HANDSET:		;;
	BSF KEYFLAG3,7		;;	
	RETURN			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BUTFREE:			;;
	MOVWF RR0		;;
	MOVLW KID_HANDSET	;;
	XORWF RR0,W		;;
	BTFSC PSW,Z		;;
	BRA BUTFREE_HANDSET	;;
	RETURN			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
BUTFREE_HANDSET:		;;
	BCF KEYFLAG0,7		;;	
	RETURN			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BUTCLICK:			;;
	MOVLW KID_M1		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_M1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM1		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM1		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM2		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM3		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_M2		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_M2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM4		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM5		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM5		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM6		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_M3		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_M3		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM7		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM7		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM8		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM8		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM9		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM9		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_M4		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_M4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_STAR		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_STAR		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_NUM0		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_NUM0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_SHARP		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_SHARP		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_HANDSET	;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_HANDSET	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_TRIANGLE	;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_TRIANGLE	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_HANDFREE_ON	;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_HANDFREE_ON	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_HANDFREE_OFF	;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_HANDFREE_OFF	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_OK		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_OK		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_MUTE		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_MUTE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_VOLDOWN	;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_VOLDOWN	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_VOLUP		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_VOLUP		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_UP		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_UP		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_LEFT		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_LEFT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_DOWN		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_DOWN		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_RIGHT		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_RIGHT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_MODE		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_MODE		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_INFO		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_INFO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_LIGHT		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_LIGHT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOVLW KID_BOOK		;;
	XORWF KID,W		;;
	BTFSC PSW,Z		;;
	BRA CLICK_BOOK		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_M1:			;;
	BSF KEYFLAG1,2		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM1:			;;
	BSF KEYFLAG0,1		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM2:			;;
	BSF KEYFLAG0,2		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM3:			;;
	BSF KEYFLAG0,3		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_M2:			;;
	BSF KEYFLAG1,3		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM4:			;;
	BSF KEYFLAG0,4		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM5:			;;
	BSF KEYFLAG0,5		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM6:			;;
	BSF KEYFLAG0,6		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_M3:			;;
	BSF KEYFLAG1,4		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM7:			;;
	BSF KEYFLAG0,7		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM8:			;;
	BSF KEYFLAG1,0		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM9:			;;
	BSF KEYFLAG1,1		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_M4:			;;
	BSF KEYFLAG1,5		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_STAR:			;;<<<<
;	BSF KEYFLAG3,7		;;
	BSF KEYFLAG3,0		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_NUM0:			;;
	BSF KEYFLAG0,0		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_SHARP:			;;
;	BSF KEYFLAG3,7		;;
	BSF KEYFLAG3,1		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_HANDSET:			;;
	BTG KEYFLAG3,7		;; 
;	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_TRIANGLE:			;;
;	BSF KEYFLAG3,7		;;
	BSF KEYFLAG3,6		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_HANDFREE_ON:		;;
;	BSF KEYFLAG3,7		;;
	BSF KEYFLAG3,3		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_HANDFREE_OFF:		;;
	BSF KEYFLAG2,6		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_OK:			;;
	BSF KEYFLAG2,7		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_MUTE:			;;
	BSF KEYFLAG2,0		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_VOLDOWN:			;;
	BSF KEYFLAG2,2		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_VOLUP:			;;
	BSF KEYFLAG2,1		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_UP:			;;
	BSF KEYFLAG2,3		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_LEFT:			;;
;	BSF KEYFLAG3,7		;;
	BSF KEYFLAG3,4		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_DOWN:			;;
	BSF KEYFLAG2,4		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_RIGHT:			;;
;	BSF KEYFLAG0,0		;;
;	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_MODE:			;;
;	BSF KEYFLAG0,0		;;
;	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_INFO:			;;
	BSF KEYFLAG3,7		;;
	BSF KEYFLAG3,5		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_LIGHT:			;;
;	BSF KEYFLAG0,0		;;
;	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLICK_BOOK:			;;
	BSF KEYFLAG3,7		;;
	BSF KEYFLAG3,2		;;
	CLRF CLICK_TIM		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIOUT:				;;
	MOVLW 20		;;	
	SUBWF SPI_INX,W		;;
	BTFSC PSW,C		;;
	BRA SPIOUT_1		;;	
	LFSR FSR0,LCD_BUF	;;
	MOVF SPI_INX,W		;;
	ANDLW 0x1F		;;
	ADDWF FSR0L		;;
	MOVF POSTINC0,W		;;
	MOVWF SSP1BUF		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIOUT_1:			;;
	BTFSS PSW,Z		;;
	BRA SPIOUT_2		;;
	MOVLW 0			;;
	MOVWF SSP1BUF		;;
	RETURN			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPIOUT_2:			;;
	ADDLW 255		;;
	ANDLW 0x03		;;
	LFSR FSR0,LED_BUF0	;;
	ADDWF FSR0L		;;
	MOVF POSTINC0,W		;;
	MOVWF SSP1BUF		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:			;;
	CLRF FLAGA		;;
	CLRF FLAGB		;;
	CLRF FLAGC		;;
	CLRF FLAGD		;;
	CLRF LCDA_PTR		;;
	CLRF LCDB_PTR		;;
	BCF LCDHL_F		;;	
	CALL CLR_LCD		;;
	CLRF KEYFLAG0		;;
	CLRF KEYFLAG1		;;
	CLRF KEYFLAG2 		;;
	CLRF KEYFLAG3		;;
	BSF KEYFLAG3,7		;;
	CALL KEYOUT		;;
	RETURN			;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_INT:			;;
;	BSF INTCON2,RBPU	;;	
	BCF INTCON,INT0IF	;;
	BCF INTCON2,INTEDG0	;;0:FALL 1:RISE
				;;
	BCF INTCON3,INT2IF	;;
	BCF INTCON3,INT2IP	;;0 LOW PRI 1:HIGH PRI
	BSF INTCON2,INTEDG2	;;0:FALL 1:RISE
				;;
	BSF INTCON,INT0IE	;;
	BSF INTCON3,INT2IE	;;
				;;
        BSF INTCON,GIEH	 	;;	
        BSF INTCON,GIEL	 	;;


	RETURN			
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
        MOVLW 10110001B         ;;
        MOVWF T3CON             ;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;OSC=24MHZ	PREDIV=8	
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
	XORWF TMR3H_BUF			;;340US
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

