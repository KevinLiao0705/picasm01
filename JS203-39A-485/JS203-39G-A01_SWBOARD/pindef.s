;=======================PIN1 
;.EQU LED_O		,PORTA
;.EQU LED_IO		,TRISA
;.EQU LED_O_P		,7
;.EQU LED_IO_P		,7
;=======================PIN2 
.EQU SW1_I		,PORTB
.EQU SW1_IO		,TRISB
.EQU SW1_I_P		,14
.EQU SW1_IO_P		,14
;=======================PIN3 
.EQU SW2_I	        ,PORTB
.EQU SW2_IO	        ,TRISB
.EQU SW2_I_P	        ,15
.EQU SW2_IO_P	        ,15
;=======================PIN4 
.EQU SW3_I		,PORTG
.EQU SW3_IO	        ,TRISG
.EQU SW3_I_P	        ,6
.EQU SW3_IO_P	        ,6
;=======================PIN5 
.EQU SW4_I		,PORTG
.EQU SW4_IO	        ,TRISG
.EQU SW4_I_P	        ,7
.EQU SW4_IO_P	        ,7
;=======================PIN6 
.EQU SW5_I		,PORTG
.EQU SW5_IO	        ,TRISG
.EQU SW5_I_P	        ,8
.EQU SW5_IO_P	        ,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SW6_I		,PORTG
.EQU SW6_IO		,TRISG
.EQU SW6_I_P		,9
.EQU SW6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
;.EQU NC11_O		,LATA
;.EQU NC11_IO		,TRISA
;.EQU NC11_O_P		,12
;.EQU NC11_IO_P		,12
;=======================PIN12 
.EQU LED1_O	        ,LATA
.EQU LED1_IO		,TRISA
.EQU LED1_O_P		,11
.EQU LED1_IO_P		,11
;=======================PIN13 
.EQU LED2_O		,LATA
.EQU LED2_IO		,TRISA
.EQU LED2_O_P	        ,0
.EQU LED2_IO_P	        ,0
;=======================PIN14 
.EQU LED3_O		,LATA
.EQU LED3_IO		,TRISA
.EQU LED3_O_P		,1
.EQU LED3_IO_P	        ,1
;=======================PIN15 
.EQU LED4_O		,LATB
.EQU LED4_IO		,TRISB
.EQU LED4_O_P		,0
.EQU LED4_IO_P	,0
;=======================PIN16 
.EQU LED5_O		,LATB
.EQU LED5_IO		,TRISB
.EQU LED5_O_P		,1
.EQU LED5_IO_P	,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU LED6_O		,LATC
.EQU LED6_IO		,TRISC
.EQU LED6_O_P		,0
.EQU LED6_IO_P		,0
;=======================PIN22 
.EQU LED7_O		,LATC
.EQU LED7_IO		,TRISC
.EQU LED7_O_P		,1
.EQU LED7_IO_P		,1
;=======================PIN23 
.EQU LED8_O		,LATC
.EQU LED8_IO		,TRISC
.EQU LED8_O_P		,2
.EQU LED8_IO_P		,2
;=======================PIN24 
;EQU NC24_O		,LATC
;EQU NC24_IO		,TRISC
;EQU NC24_O_P		,11
;EQU NC24_IO_P		,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
;EQU NC27_O		,LATE
;EQU NC27_IO		,TRISE
;EQU NC27_O_P		,12
;EQU NC27_IO_P	        ,12
;=======================PIN28 
;EQU NC28_O		,LATE
;EQU NC28_IO		,TRISE
;EQU NC28_O_P		,13
;EQU NC28_IO_P	        ,13
;=======================PIN29 
;EQU NC29_O		,LATE
;EQU NC29_IO		,TRISE
;EQU NC29_O_P		,14
;EQU NC29_IO_P	        ,14
;=======================PIN30 ;TP3
;EQU NC30_O		,LATE
;EQU NC30_IO		,TRISE
;EQU NC30_O_P		,15
;EQU NC30_IO_P	        ,15
;=======================PIN31 ;TP4
;EQU NC31_I		,PORTA
;EQU NC31_IO		,TRISA
;EQU NC31_I_P		,8
;EQU NC31_IO_P		,8
;=======================PIN32 
;EQU OP_TX_I		,PORTB
;EQU OP_TX_IO		,TRISB
;EQU OP_TX_I_P		,4
;EQU OP_TX_IO_P		,4
;=======================PIN33 
;EQU OP_RX_O		,LATA
;EQU OP_RX_IO		,TRISA
;EQU OP_RX_O_P		,4
;EQU OP_RX_IO_P		,4
;=======================PIN34 
.EQU SWLED1_O		,LATA
.EQU SWLED1_IO		,TRISA
.EQU SWLED1_O_P		,9
.EQU SWLED1_IO_P	,9
;=======================PIN35
.EQU SWLED2_O		,LATC
.EQU SWLED2_IO		,TRISC
.EQU SWLED2_O_P		,3
.EQU SWLED2_IO_P	,3
;=======================PIN36
.EQU SWLED3_O		,LATC
.EQU SWLED3_IO		,TRISC
.EQU SWLED3_O_P		,4
.EQU SWLED3_IO_P	,4
;=======================PIN37 
.EQU SWLED4_O		,LATC
.EQU SWLED4_IO		,TRISC
.EQU SWLED4_O_P		,5
.EQU SWLED4_IO_P	,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
;.EQU OSC1_I	        ,PORTC
;.EQU OSC1_IO	        ,TRISC
;.EQU OSC1_I_P	        ,12 
;.EQU OSC1_IO_P	        ,12 
;=======================PIN40 	OSC2
;.EQU OSC2_I	        ,PORTC
;.EQU OSC2_IO	        ,TRISC
;.EQU OSC2_I_P	        ,15 
;.EQU OSC2_IO_P	        ,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SWLED5_O	        ,LATD
.EQU SWLED5_IO	        ,TRISD
.EQU SWLED5_O_P	        ,8 
.EQU SWLED5_IO_P	        ,8 
;=======================PIN43
.EQU SWLED6_O	        ,LATB
.EQU SWLED6_IO	        ,TRISB
.EQU SWLED6_O_P	        ,5 
.EQU SWLED6_IO_P	,5 
;=======================PIN44 
;EQU SPARE4_O		,LATB
;EQU SPARE4_IO	        ,TRISB
;EQU SPARE4_O_P	        ,6 
;EQU SPARE4_IO_P	,6 
;=======================PIN45
;EQU SPARE3_O		,LATC
;EQU SPARE3_IO		,TRISC
;EQU SPARE3_O_P	        ,10 
;EQU SPARE3_IO_P	,10
 ;=======================PIN46 TP8
.EQU MCU_TX_O		,LATB
.EQU MCU_TX_IO		,TRISB
.EQU MCU_TX_O_P	        ,7 
.EQU MCU_TX_IO_P	,7
;=======================PIN47 
;.EQU NC47_O	        ,LATC
;.EQU NC47_IO	        ,TRISC
;.EQU NC47_O_P	        ,13 
;.EQU NC47_IO_P	        ,13
;=======================PIN48
.EQU MCU_RX_I	        ,PORTB
.EQU MCU_RX_IO	        ,TRISB
.EQU MCU_RX_I_P	        ,8 
.EQU MCU_RX_IO_P	,8
;=======================PIN49
;.EQU NC49_O	        ,LATB
;.EQU NC49_IO	        ,TRISB
;.EQU NC49_O_P	        ,9 
;.EQU NC49_IO_P	        ,9
;=======================PIN50 
;.EQU DB6_O		,LATC
;.EQU DB6_I		,PORTC
;.EQU DB6_IO		,TRISC
;.EQU DB6_O_P		,6
;.EQU DB6_I_P		,6
;.EQU DB6_IO_P		,6
;=======================PIN51 
;.EQU DB7_O		,LATC
;.EQU DB7_I		,PORTC
;.EQU DB7_IO		,TRISC
;.EQU DB7_O_P		,7
;.EQU DB7_I_P		,7
;.EQU DB7_IO_P		,7
;=======================PIN52
;.EQU NC52_O		,LATC
;.EQU NC52_IO	        ,TRISC
;.EQU NC52_O_P	        ,8 
;.EQU NC52_IO_P	        ,8
;=======================PIN53
;.EQU NC53_O		,LATD
;.EQU NC53_IO	        ,TRISD
;.EQU NC53_O_P	        ,5 
;.EQU NC53_IO_P	        ,5
;=======================PIN54
;.EQU NC54_O		,LATD
;.EQU NC54_IO	        ,TRISD
;.EQU NC54_O_P	        ,6 
;.EQU NC54_IO_P	        ,6 
;=======================PIN55
;.EQU NC55_O		,LATC
;.EQU NC55_IO	        ,TRISC
;.EQU NC55_O_P	        ,9 
;.EQU NC55_IO_P	        ,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
;.EQU AIR_FLOW_R_I	,PORTF
;.EQU AIR_FLOW_R_IO	,TRISF
;.EQU AIR_FLOW_R_I_P	,0 
;.EQU AIR_FLOW_R_IO_P	,0 
;=======================PIN59
;.EQU AIR_FLOW_L_I	,PORTF
;.EQU AIR_FLOW_L_IO	,TRISF
;.EQU AIR_FLOW_L_I_P	,1 
;.EQU AIR_FLOW_L_IO_P	,1
;=======================PIN60
.EQU TP1_O	        ,LATB
.EQU TP1_IO	        ,TRISB
.EQU TP1_O_P	        ,10 
.EQU TP1_IO_P	        ,10
;=======================PIN61
.EQU TP2_O	        ,LATB
.EQU TP2_IO	        ,TRISB
.EQU TP2_O_P	        ,11 
.EQU TP2_IO_P	        ,11
;=======================PIN62
.EQU TP3_O		,LATB
.EQU TP3_IO	        ,TRISB
.EQU TP3_O_P	        ,12
.EQU TP3_IO_P	        ,12
;=======================PIN63
.EQU TP4_O		,LATB
.EQU TP4_IO		,TRISB
.EQU TP4_O_P		,13
.EQU TP4_IO_P		,13
;=======================PIN64
.EQU TP5_O		,LATA
.EQU TP5_IO		,TRISA
.EQU TP5_O_P		,10
.EQU TP5_IO_P	        ,10
