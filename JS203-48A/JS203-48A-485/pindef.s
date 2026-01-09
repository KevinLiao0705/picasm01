

/*
        JS203_42A_B01 MAIN,SIP
        JS203_42A_C01 FXO,FXS,T1
        JS203_42A_H01 VOIP
        JS203_42A_E01 MAG
        JS203_42A_K01 RECORD

*/

;=======================PIN1 
;.EQU SLOTID2_I			,PORTA
;.EQU SLOTID2_IO		,TRISA
;.EQU SLOTID2_I_P		,7
;.EQU SLOTID2_IO_P		,7
;=======================PIN2 
.EQU RS485_CTL_O		,LATB
.EQU RS485_CTL_IO		,TRISB
.EQU RS485_CTL_O_P		,14
.EQU RS485_CTL_IO_P		,14
;=======================PIN3 
.EQU RS485_TX_I			,PORTB
.EQU RS485_TX_IO		,TRISB
.EQU RS485_TX_I_P		,15
.EQU RS485_TX_IO_P		,15
;=======================PIN4 
.EQU RS485_RX_O			,LATG
.EQU RS485_RX_IO		,TRISG
.EQU RS485_RX_O_P		,6
.EQU RS485_RX_IO_P		,6
;=======================PIN5 
.EQU SER_TX1_I			,PORTG
.EQU SER_TX1_IO			,TRISG
.EQU SER_TX1_I_P		,7
.EQU SER_TX1_IO_P		,7
;=======================PIN6 
.EQU SER_RX1_O			,LATG
.EQU SER_RX1_IO			,TRISG
.EQU SER_RX1_O_P		,8
.EQU SER_RX1_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
;.EQU SLOTID3_I			,PORTG
;.EQU SLOTID3_IO		,TRISG
;.EQU SLOTID3_I_P		,9
;.EQU SLOTID3_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
;.EQU MCURX1_I			,PORTA
;.EQU MCURX1_IO			,TRISA
;.EQU MCURX1_I_P		,12
;.EQU MCURX1_IO_P		,12
;=======================PIN12 
;.EQU MCURX2_I			,PORTA
;.EQU MCURX2_IO			,TRISA
;.EQU MCURX2_I_P		,11
;.EQU MCURX2_IO_P		,11
;=======================PIN13 
.EQU VRTC_I			,PORTA   ;H01
.EQU VRTC_IO			,TRISA
.EQU VRTC_I_P		        ,0
.EQU VRTC_IO_P		        ,0
;=======================PIN14 
.EQU PW_DET_I			,PORTA  
.EQU PW_DET_IO			,TRISA
.EQU PW_DET_I_P			,1
.EQU PW_DET_IO_P		,1
;=======================PIN15 
;.EQU SLOTID4_I			,LATB
;.EQU SLOTID4_IO		,TRISB
;.EQU SLOTID4_I_P		,0
;.EQU SLOTID4_IO_P		,0
;=======================PIN16 
;.EQU SW_EN_O			,LATB
;.EQU SW_EN_IO			,TRISB
;.EQU SW_EN_O_P			,1
;.EQU SW_EN_IO_P		,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU DB0_O		,LATC
.EQU DB0_I		,PORTC
.EQU DB0_IO		,TRISC
.EQU DB0_O_P		,0
.EQU DB0_I_P		,0
.EQU DB0_IO_P		,0
;=======================PIN22 
.EQU DB1_O		,LATC
.EQU DB1_I		,PORTC
.EQU DB1_IO		,TRISC
.EQU DB1_O_P		,1
.EQU DB1_I_P		,1
.EQU DB1_IO_P		,1
;=======================PIN23 
.EQU DB2_O		,LATC
.EQU DB2_I		,PORTC
.EQU DB2_IO		,TRISC
.EQU DB2_O_P		,2
.EQU DB2_I_P		,2
.EQU DB2_IO_P		,2
;=======================PIN24 
;.EQU TP1_O		,LATC   ;H01
;.EQU TP1_IO		,TRISC
;.EQU TP1_O_P		,11
;.EQU TP1_IO_P		,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
;.EQU TP2_O		,LATE   ;H01
;.EQU TP2_IO		,TRISE
;.EQU TP2_O_P		,12
;.EQU TP2_IO_P		,12
;=======================PIN28 
.EQU SLOT_ID4_I  	,PORTE  ;C01
.EQU SLOT_ID4_IO	,TRISE
.EQU SLOT_ID4_I_P	,13
.EQU SLOT_ID4_IO_P	,13
;=======================PIN29 
.EQU SLOT_ID3_I  	,PORTE  ;C01
.EQU SLOT_ID3_IO	,TRISE
.EQU SLOT_ID3_I_P	,14
.EQU SLOT_ID3_IO_P	,14
;=======================PIN30 
.EQU SLOT_ID2_I  	,PORTE  ;C01
.EQU SLOT_ID2_IO	,TRISE
.EQU SLOT_ID2_I_P	,15
.EQU SLOT_ID2_IO_P	,15
;=======================PIN31 
.EQU SLOT_ID1_I  	,PORTA  ;C01
.EQU SLOT_ID1_IO	,TRISA
.EQU SLOT_ID1_I_P	,8
.EQU SLOT_ID1_IO_P	,8
;=======================PIN32 
.EQU SLOT_ID0_I  	,PORTB  ;C01
.EQU SLOT_ID0_IO	,TRISB
.EQU SLOT_ID0_I_P	,4
.EQU SLOT_ID0_IO_P	,4
;=======================PIN33 
;.EQU T1_LED_D4P_I	,PORTA  ;C01
;.EQU T1_LED_D4P_IO	,TRISA
;.EQU T1_LED_D4P_I_P	,4 
;.EQU T1_LED_D4P_IO_P	,4 
;=======================PIN34 
;.EQU T1_LED_D4N_I	,PORTA  ;C01
;.EQU T1_LED_D4N_IO	,TRISA
;.EQU T1_LED_D4N_I_P	,9 
;.EQU T1_LED_D4N_IO_P	,9 
;=======================PIN35
.EQU DB3_O		,LATC
.EQU DB3_I		,PORTC
.EQU DB3_IO		,TRISC
.EQU DB3_O_P		,3
.EQU DB3_I_P		,3
.EQU DB3_IO_P		,3
;=======================PIN36
.EQU DB4_O		,LATC
.EQU DB4_I		,PORTC
.EQU DB4_IO		,TRISC
.EQU DB4_O_P		,4
.EQU DB4_I_P		,4
.EQU DB4_IO_P		,4
;=======================PIN37 
.EQU DB5_O		,LATC
.EQU DB5_I		,PORTC
.EQU DB5_IO		,TRISC
.EQU DB5_O_P		,5
.EQU DB5_I_P		,5
.EQU DB5_IO_P		,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
;.EQU LED1_O		,LATC
;.EQU LED1_IO	        ,TRISC
;.EQU LED1_O_P	        ,12 
;.EQU LED1_IO_P	        ,12 
;=======================PIN40 	OSC2
.EQU LED1_O		,LATC
.EQU LED1_IO	        ,TRISC
.EQU LED1_O_P	        ,15 
.EQU LED1_IO_P	        ,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU LED2_O		,LATD
.EQU LED2_IO	        ,TRISD
.EQU LED2_O_P	        ,8 
.EQU LED2_IO_P	        ,8 
;=======================PIN43
.EQU LED3_O		,LATB
.EQU LED3_IO	        ,TRISB
.EQU LED3_O_P	        ,5 
.EQU LED3_IO_P	        ,5 
;=======================PIN44 
.EQU LED4_O		,LATB
.EQU LED4_IO	        ,TRISB
.EQU LED4_O_P	        ,6 
.EQU LED4_IO_P	        ,6 
;=======================PIN45
.EQU LED5_O		,LATC
.EQU LED5_IO	        ,TRISC
.EQU LED5_O_P	        ,10 
.EQU LED5_IO_P	        ,10 
;=======================PIN46
.EQU LED7_O		,LATB
.EQU LED7_IO	        ,TRISB
.EQU LED7_O_P	        ,7 
.EQU LED7_IO_P	        ,7 
;=======================PIN47 
.EQU LED8_O		,LATC
.EQU LED8_IO	        ,TRISC
.EQU LED8_O_P	        ,13 
.EQU LED8_IO_P	        ,13 
;=======================PIN48
.EQU LED10_O		,LATB
.EQU LED10_IO	        ,TRISB
.EQU LED10_O_P	        ,8 
.EQU LED10_IO_P	        ,8 
;=======================PIN49
.EQU PWRON_O		,LATB   ;ELSE
.EQU PWRON_IO		,TRISB
.EQU PWRON_O_P		,9
.EQU PWRON_IO_P		,9
;=======================PIN50 
.EQU DB6_O		,LATC
.EQU DB6_I		,PORTC
.EQU DB6_IO		,TRISC
.EQU DB6_O_P		,6
.EQU DB6_I_P		,6
.EQU DB6_IO_P		,6
;=======================PIN51 
.EQU DB7_O		,LATC
.EQU DB7_I		,PORTC
.EQU DB7_IO		,TRISC
.EQU DB7_O_P		,7
.EQU DB7_I_P		,7
.EQU DB7_IO_P		,7
;=======================PIN52
.EQU RESET_O		,LATC   ;H01 ELSE
.EQU RESET_IO		,TRISC
.EQU RESET_O_P		,8 
.EQU RESET_IO_P		,8 
;=======================PIN53
;.EQU NC53_O		,LATD
;.EQU NC53_IO		,TRISD
;.EQU NC53_O_P		,5
;.EQU NC53_IO_P		,5
;=======================PIN54
;.EQU NC54_I		,PORTD
;.EQU NC54_IO		,TRISD
;.EQU NC54_I_P		,6
;.EQU NC54_IO_P		,6
;=======================PIN55
;.EQU PWM_O		,LATC	
;.EQU PWM_IO		,TRISC
;.EQU PWM_O_P		,9 
;.EQU PWM_IO_P		,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
.EQU TP6_O		,LATF   ;H01 ELSE
.EQU TP6_IO		,TRISF
.EQU TP6_O_P		,0
.EQU TP6_IO_P		,0
;=======================PIN59
.EQU TP7_O		,LATF   ;H01 ELSE
.EQU TP7_IO		,TRISF
.EQU TP7_O_P		,1
.EQU TP7_IO_P		,1
;=======================PIN60
.EQU TP8_O		,LATB   ;H01 ELSE
.EQU TP8_IO		,TRISB
.EQU TP8_O_P		,10
.EQU TP8_IO_P		,10
;=======================PIN61
.EQU TP9_O		,LATB
.EQU TP9_IO		,TRISB
.EQU TP9_O_P		,11 
.EQU TP9_IO_P		,11 
;=======================PIN62
;.EQU SLOTID1_I		,PORTB
;.EQU SLOTID1_IO	,TRISB
;.EQU SLOTID1_I_P	,12
;.EQU SLOTID1_IO_P	,12
;=======================PIN63
.EQU J8_I		,PORTB
.EQU J8_IO		,TRISB
.EQU J8_I_P	        ,13
.EQU J8_IO_P	        ,13
;=======================PIN64
;.EQU SLOTID1_I		,PORTA
;.EQU SLOTID1_IO	,TRISA
;.EQU SLOTID1_I_P	,10
;.EQU SLOTID1_IO_P	,10
;======================================================
