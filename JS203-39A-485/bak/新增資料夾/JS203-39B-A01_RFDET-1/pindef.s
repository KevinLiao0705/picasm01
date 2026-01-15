;=======================PIN1 
.EQU LED_O		,PORTA
.EQU LED_IO		,TRISA
.EQU LED_O_P		,7
.EQU LED_IO_P		,7
;=======================PIN2 
.EQU NC2_O		,LATB
.EQU NC2_IO		,TRISB
.EQU NC2_O_P		,14
.EQU NC2_IO_P		,14
;=======================PIN3 
.EQU FIBER_OUT_O	,LATB
.EQU FIBER_OUT_IO	,TRISB
.EQU FIBER_OUT_O_P	,15
.EQU FIBER_OUT_IO_P	,15
;=======================PIN4 
.EQU RS422_TX_O		,LATG
.EQU RS422_TX_IO	,TRISG
.EQU RS422_TX_O_P	,6
.EQU RS422_TX_IO_P	,6
;=======================PIN5 
.EQU NC5_O		,LATG
.EQU NC5_IO	        ,TRISG
.EQU NC5_O_P	        ,7
.EQU NC5_IO_P	        ,7
;=======================PIN6 
.EQU RS422_RX_I		,PORTG
.EQU RS422_RX_IO	,TRISG
.EQU RS422_RX_I_P	,8
.EQU RS422_RX_IO_P	,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU NC8_O		,LATG
.EQU NC8_IO		,TRISG
.EQU NC8_O_P		,9
.EQU NC8_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU NC11_O		,LATA
.EQU NC11_IO		,TRISA
.EQU NC11_O_P		,12
.EQU NC11_IO_P		,12
;=======================PIN12 
.EQU NC12_O	        ,LATA
.EQU NC12_IO		,TRISA
.EQU NC12_O_P		,11
.EQU NC12_IO_P		,11
;=======================PIN13 
.EQU NC13_O		,LATA
.EQU NC13_IO		,TRISA
.EQU NC13_O_P	        ,0
.EQU NC13_IO_P	        ,0
;=======================PIN14 
.EQU SW_EN_O		,LATA
.EQU SW_EN_IO		,TRISA
.EQU SW_EN_O_P		,1
.EQU SW_EN_IO_P	        ,1
;=======================PIN15 
.EQU SW_LE1_O		,LATB
.EQU SW_LE1_IO		,TRISB
.EQU SW_LE1_O_P		,0
.EQU SW_LE1_IO_P	,0
;=======================PIN16 
.EQU SW_LE2_O		,LATB
.EQU SW_LE2_IO		,TRISB
.EQU SW_LE2_O_P		,1
.EQU SW_LE2_IO_P	,1
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
.EQU NC24_O		,LATC
.EQU NC24_IO		,TRISC
.EQU NC24_O_P		,11
.EQU NC24_IO_P		,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
.EQU NC27_O		,LATE
.EQU NC27_IO		,TRISE
.EQU NC27_O_P		,12
.EQU NC27_IO_P	        ,12
;=======================PIN28 
.EQU NC28_O		,LATE
.EQU NC28_IO		,TRISE
.EQU NC28_O_P		,13
.EQU NC28_IO_P	        ,13
;=======================PIN29 
.EQU NC29_O		,LATE
.EQU NC29_IO		,TRISE
.EQU NC29_O_P		,14
.EQU NC29_IO_P	        ,14
;=======================PIN30 ;TP3
.EQU NC30_O		,LATE
.EQU NC30_IO		,TRISE
.EQU NC30_O_P		,15
.EQU NC30_IO_P	        ,15
;=======================PIN31 ;TP4
.EQU NC31_I		,PORTA
.EQU NC31_IO		,TRISA
.EQU NC31_I_P		,8
.EQU NC31_IO_P		,8
;=======================PIN32 
.EQU OP_TX_I		,PORTB
.EQU OP_TX_IO		,TRISB
.EQU OP_TX_I_P		,4
.EQU OP_TX_IO_P		,4
;=======================PIN33 
.EQU OP_RX_O		,LATA
.EQU OP_RX_IO		,TRISA
.EQU OP_RX_O_P		,4
.EQU OP_RX_IO_P		,4
;=======================PIN34 
.EQU NC34_O		,LATA
.EQU NC34_IO		,TRISA
.EQU NC34_O_P		,9
.EQU NC34_IO_P		,9
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
.EQU OSC1_I	        ,PORTC
.EQU OSC1_IO	        ,TRISC
.EQU OSC1_I_P	        ,12 
.EQU OSC1_IO_P	        ,12 
;=======================PIN40 	OSC2
.EQU OSC2_I	        ,PORTC
.EQU OSC2_IO	        ,TRISC
.EQU OSC2_I_P	        ,15 
.EQU OSC2_IO_P	        ,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU NC42_O	        ,LATD
.EQU NC42_IO	        ,TRISD
.EQU NC42_O_P	        ,8 
.EQU NC42_IO_P	        ,8 
;=======================PIN43
.EQU SPARE5_O	        ,LATB
.EQU SPARE5_IO	        ,TRISB
.EQU SPARE5_O_P	        ,5 
.EQU SPARE5_IO_P	,5 
.EQU TP1_O	        ,LATB
.EQU TP1_IO	        ,TRISB
.EQU TP1_O_P	        ,5 
.EQU TP1_IO_P	        ,5 
;=======================PIN44 
.EQU SPARE4_O		,LATB
.EQU SPARE4_IO	        ,TRISB
.EQU SPARE4_O_P	        ,6 
.EQU SPARE4_IO_P	,6 
;=======================PIN45
.EQU SPARE3_O		,LATC
.EQU SPARE3_IO		,TRISC
.EQU SPARE3_O_P	        ,10 
.EQU SPARE3_IO_P	,10
 ;=======================PIN46 TP8
.EQU MCU_RX2_I		,PORTB
.EQU MCU_RX2_IO		,TRISB
.EQU MCU_RX2_I_P	,7 
.EQU MCU_RX2_IO_P	,7
;=======================PIN47 
.EQU NC47_O	        ,LATC
.EQU NC47_IO	        ,TRISC
.EQU NC47_O_P	        ,13 
.EQU NC47_IO_P	        ,13
;=======================PIN48
.EQU MCU_TX2_O	        ,LATB
.EQU MCU_TX2_IO	        ,TRISB
.EQU MCU_TX2_O_P	,8 
.EQU MCU_TX2_IO_P	,8
;=======================PIN49
.EQU NC49_O	        ,LATB
.EQU NC49_IO	        ,TRISB
.EQU NC49_O_P	        ,9 
.EQU NC49_IO_P	        ,9
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
.EQU NC52_O		,LATC
.EQU NC52_IO	        ,TRISC
.EQU NC52_O_P	        ,8 
.EQU NC52_IO_P	        ,8
;=======================PIN53
.EQU NC53_O		,LATD
.EQU NC53_IO	        ,TRISD
.EQU NC53_O_P	        ,5 
.EQU NC53_IO_P	        ,5
;=======================PIN54
.EQU NC54_O		,LATD
.EQU NC54_IO	        ,TRISD
.EQU NC54_O_P	        ,6 
.EQU NC54_IO_P	        ,6 
;=======================PIN55
.EQU NC55_O		,LATC
.EQU NC55_IO	        ,TRISC
.EQU NC55_O_P	        ,9 
.EQU NC55_IO_P	        ,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
.EQU AIR_FLOW_R_I	,PORTF
.EQU AIR_FLOW_R_IO	,TRISF
.EQU AIR_FLOW_R_I_P	,0 
.EQU AIR_FLOW_R_IO_P	,0 
;=======================PIN59
.EQU AIR_FLOW_L_I	,PORTF
.EQU AIR_FLOW_L_IO	,TRISF
.EQU AIR_FLOW_L_I_P	,1 
.EQU AIR_FLOW_L_IO_P	,1
;=======================PIN60
.EQU WGSW_LOAD_I	,PORTB
.EQU WGSW_LOAD_IO	,TRISB
.EQU WGSW_LOAD_I_P	,10 
.EQU WGSW_LOAD_IO_P	,10
;=======================PIN61
.EQU AIR_FLOW_M_I	,PORTB
.EQU AIR_FLOW_M_IO	,TRISB
.EQU AIR_FLOW_M_I_P	,11 
.EQU AIR_FLOW_M_IO_P	,11
;=======================PIN62
.EQU WGSW_ANT_I		,PORTB
.EQU WGSW_ANT_IO	,TRISB
.EQU WGSW_ANT_I_P	,12
.EQU WGSW_ANT_IO_P	,12
;=======================PIN63
.EQU NC63_O		,LATB
.EQU NC63_IO		,TRISB
.EQU NC63_O_P		,13
.EQU NC63_IO_P		,13
;=======================PIN64
.EQU ATT_LE_O		,LATA
.EQU ATT_LE_IO		,TRISA
.EQU ATT_LE_O_P		,10
.EQU ATT_LE_IO_P	,10
