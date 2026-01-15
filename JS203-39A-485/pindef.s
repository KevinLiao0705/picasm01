

.IFDEF JS203_39A_K01_01
;=======================PIN1 
.EQU SWS0_I		,PORTA
.EQU SWS0_IO		,TRISA
.EQU SWS0_I_P		,7
.EQU SWS0_IO_P		,7
;=======================PIN2 
.EQU SWS1_I		,PORTB
.EQU SWS1_IO		,TRISB
.EQU SWS1_I_P		,14
.EQU SWS1_IO_P		,14
;=======================PIN3 
.EQU SWS2_I		,PORTB
.EQU SWS2_IO		,TRISB
.EQU SWS2_I_P		,15
.EQU SWS2_IO_P		,15
;=======================PIN4 
.EQU SWS3_I		,PORTG
.EQU SWS3_IO		,TRISG
.EQU SWS3_I_P		,6
.EQU SWS3_IO_P		,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
.EQU NC12_O		,LATA
.EQU NC12_IO		,TRISA
.EQU NC12_O_P		,11
.EQU NC12_IO_P		,11
;=======================PIN13 
.EQU ADI_12V_I		,PORTA
.EQU ADI_12V_IO		,TRISA
.EQU ADI_12V_I_P	,0
.EQU ADI_12V_IO_P	,0
;=======================PIN14 
.EQU ADI_5V_I		,PORTA
.EQU ADI_5V_IO		,TRISA
.EQU ADI_5V_I_P		,1
.EQU ADI_5V_IO_P	,1
;=======================PIN15 
.EQU ADS0_I		,PORTB
.EQU ADS0_IO		,TRISB
.EQU ADS0_I_P		,0
.EQU ADS0_IO_P	        ,0
;=======================PIN16 
.EQU ADS1_I		,PORTB
.EQU ADS1_IO		,TRISB
.EQU ADS1_I_P		,1
.EQU ADS1_IO_P	        ,1
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
.EQU ADS2_I		,PORTE
.EQU ADS2_IO		,TRISE
.EQU ADS2_I_P		,12
.EQU ADS2_IO_P	        ,12
;=======================PIN28 
.EQU ADS3_I		,PORTE
.EQU ADS3_IO		,TRISE
.EQU ADS3_I_P		,13
.EQU ADS3_IO_P	        ,13
;=======================PIN29 
.EQU ADS4_I		,PORTE
.EQU ADS4_IO		,TRISE
.EQU ADS4_I_P		,14
.EQU ADS4_IO_P	        ,14
;=======================PIN30 ;TP3
.EQU ADS5_I		,PORTE
.EQU ADS5_IO		,TRISE
.EQU ADS5_I_P		,15
.EQU ADS5_IO_P	        ,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
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
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
.EQU LDLO_TR_O		,LATB
.EQU LDLO_TR_IO		,TRISB
.EQU LDLO_TR_O_P	,6 
.EQU LDLO_TR_IO_P	,6 
;=======================PIN45
.EQU LSEO_TR_O		,LATC
.EQU LSEO_TR_IO		,TRISC
.EQU LSEO_TR_O_P	,10 
.EQU LSEO_TR_IO_P	,10
 ;=======================PIN46 TP8
.EQU LDFO_TR_O		,LATB
.EQU LDFO_TR_IO		,TRISB
.EQU LDFO_TR_O_P	,7 
.EQU LDFO_TR_IO_P	,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;=======================PIN48
.EQU RS485EX_RO_I	,PORTB
.EQU RS485EX_RO_IO	,TRISB
.EQU RS485EX_RO_I_P	,8 
.EQU RS485EX_RO_IO_P	,8
;=======================PIN49
.EQU RS485EX_DI_O	,LATB
.EQU RS485EX_DI_IO	,TRISB
.EQU RS485EX_DI_O_P	,9 
.EQU RS485EX_DI_IO_P	,9
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
.EQU LSEI_CS_O		,LATC
.EQU LSEI_CS_IO	        ,TRISC
.EQU LSEI_CS_O_P	,8 
.EQU LSEI_CS_IO_P	,8
;=======================PIN53
.EQU LDFI_CS_O		,LATD
.EQU LDFI_CS_IO	        ,TRISD
.EQU LDFI_CS_O_P	,5 
.EQU LDFI_CS_IO_P	,5
;=======================PIN54
.EQU SEO_EN_N_O		,LATD
.EQU SEO_EN_N_IO	,TRISD
.EQU SEO_EN_N_O_P	,6 
.EQU SEO_EN_N_IO_P	,6 
;=======================PIN55
.EQU DFO_EN_N_O		,LATC
.EQU DFO_EN_N_IO	,TRISC
.EQU DFO_EN_N_O_P	,9 
.EQU DFO_EN_N_IO_P	,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
.EQU DFO_EN_P_O		,LATF
.EQU DFO_EN_P_IO	,TRISF
.EQU DFO_EN_P_O_P	,0 
.EQU DFO_EN_P_IO_P	,0 
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10

.ENDIF




.IFDEF JS203_39A_K01_02
;=======================PIN1 
.EQU SWS0_I		,PORTA
.EQU SWS0_IO		,TRISA
.EQU SWS0_I_P		,7
.EQU SWS0_IO_P		,7
;=======================PIN2 
.EQU SWS1_I		,PORTB
.EQU SWS1_IO		,TRISB
.EQU SWS1_I_P		,14
.EQU SWS1_IO_P		,14
;=======================PIN3 
.EQU SWS2_I		,PORTB
.EQU SWS2_IO		,TRISB
.EQU SWS2_I_P		,15
.EQU SWS2_IO_P		,15
;=======================PIN4 
.EQU SWS3_I		,PORTG
.EQU SWS3_IO		,TRISG
.EQU SWS3_I_P		,6
.EQU SWS3_IO_P		,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
.EQU LDFI_A0_I		,PORTA
.EQU LDFI_A0_IO		,TRISA
.EQU LDFI_A0_I_P	,11
.EQU LDFI_A0_IO_P	,11
;=======================PIN13 
.EQU NC13_I		,PORTA
.EQU NC13_IO		,TRISA
.EQU NC13_I_P	        ,0
.EQU NC13_IO_P	        ,0
;=======================PIN14 
.EQU ADI_5V_I		,PORTA
.EQU ADI_5V_IO		,TRISA
.EQU ADI_5V_I_P		,1
.EQU ADI_5V_IO_P	,1
;=======================PIN15 
.EQU ADS0_I		,PORTB
.EQU ADS0_IO		,TRISB
.EQU ADS0_I_P		,0
.EQU ADS0_IO_P	        ,0
;=======================PIN16 
.EQU ADS1_I		,PORTB
.EQU ADS1_IO		,TRISB
.EQU ADS1_I_P		,1
.EQU ADS1_IO_P	        ,1
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
.EQU ADS2_I		,PORTE
.EQU ADS2_IO		,TRISE
.EQU ADS2_I_P		,12
.EQU ADS2_IO_P	        ,12
;=======================PIN28 
.EQU ADS3_I		,PORTE
.EQU ADS3_IO		,TRISE
.EQU ADS3_I_P		,13
.EQU ADS3_IO_P	        ,13
;=======================PIN29 
.EQU LDFI_A1_I		,PORTE
.EQU LDFI_A1_IO		,TRISE
.EQU LDFI_A1_I_P	,14
.EQU LDFI_A1_IO_P	,14
;=======================PIN30 ;TP3
.EQU LDFI_A2_I		,PORTE
.EQU LDFI_A2_IO		,TRISE
.EQU LDFI_A2_I_P	,15
.EQU LDFI_A2_IO_P	,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
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
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
.EQU LDFO_A0_O		,LATB
.EQU LDFO_A0_IO		,TRISB
.EQU LDFO_A0_O_P	,6 
.EQU LDFO_A0_IO_P	,6 
;=======================PIN45
.EQU LDFI_A3_I		,PORTC
.EQU LDFI_A3_IO		,TRISC
.EQU LDFI_A3_I_P	,10 
.EQU LDFI_A3_IO_P	,10
 ;=======================PIN46 TP8
.EQU LDFO_A1_O		,LATB
.EQU LDFO_A1_IO		,TRISB
.EQU LDFO_A1_O_P	,7 
.EQU LDFO_A1_IO_P	,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;=======================PIN48
.EQU RS485EX_RO_I	,PORTB
.EQU RS485EX_RO_IO	,TRISB
.EQU RS485EX_RO_I_P	,8 
.EQU RS485EX_RO_IO_P	,8
;=======================PIN49
.EQU RS485EX_DI_O	,LATB
.EQU RS485EX_DI_IO	,TRISB
.EQU RS485EX_DI_O_P	,9 
.EQU RS485EX_DI_IO_P	,9
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
.EQU LDFO_A2_O		,LATC
.EQU LDFO_A2_IO	        ,TRISC
.EQU LDFO_A2_O_P	,8 
.EQU LDFO_A2_IO_P	,8
;=======================PIN53
.EQU DFO_EN_N_O		,LATD
.EQU DFO_EN_N_IO	,TRISD
.EQU DFO_EN_N_O_P	,5 
.EQU DFO_EN_N_IO_P	,5
;=======================PIN54
.EQU NC54_O		,LATD
.EQU NC54_IO	        ,TRISD
.EQU NC54_O_P	        ,6 
.EQU NC54_IO_P	        ,6 
;=======================PIN55
.EQU LDFO_A3_O		,LATC
.EQU LDFO_A3_IO	        ,TRISC
.EQU LDFO_A3_O_P	,9 
.EQU LDFO_A3_IO_P	,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
.EQU DFO_EN_P_O		,LATF
.EQU DFO_EN_P_IO	,TRISF
.EQU DFO_EN_P_O_P	,0 
.EQU DFO_EN_P_IO_P	,0 
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10

.ENDIF



.IFDEF JS203_39A_C01_04  ;//FIBER
;=======================PIN1 
.EQU SWS0_I		,PORTA
.EQU SWS0_IO		,TRISA
.EQU SWS0_I_P		,7
.EQU SWS0_IO_P		,7
;=======================PIN2 
.EQU SWS1_I		,PORTB
.EQU SWS1_IO		,TRISB
.EQU SWS1_I_P		,14
.EQU SWS1_IO_P		,14
;=======================PIN3 
.EQU SWS2_I		,PORTB
.EQU SWS2_IO		,TRISB
.EQU SWS2_I_P		,15
.EQU SWS2_IO_P		,15
;=======================PIN4 
.EQU SWS3_I		,PORTG
.EQU SWS3_IO		,TRISG
.EQU SWS3_I_P		,6
.EQU SWS3_IO_P		,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
.EQU NC12_O		,LATA
.EQU NC12_IO		,TRISA
.EQU NC12_O_P		,11
.EQU NC12_IO_P		,11
;=======================PIN13 
.EQU ADI_12V_I		,PORTA
.EQU ADI_12V_IO		,TRISA
.EQU ADI_12V_I_P	,0
.EQU ADI_12V_IO_P	,0
;=======================PIN14 
.EQU ADI_5V_I		,PORTA
.EQU ADI_5V_IO		,TRISA
.EQU ADI_5V_I_P		,1
.EQU ADI_5V_IO_P	,1
;=======================PIN15 
;EQU ADS0_I		,PORTB
;EQU ADS0_IO		,TRISB
;EQU ADS0_I_P		,0
;EQU ADS0_IO_P	        ,0
;=======================PIN16 
;EQU ADS1_I		,PORTB
;EQU ADS1_IO		,TRISB
;EQU ADS1_I_P		,1
;EQU ADS1_IO_P	        ,1
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
.EQU ADS2_I		,PORTE
.EQU ADS2_IO		,TRISE
.EQU ADS2_I_P		,12
.EQU ADS2_IO_P	        ,12
;=======================PIN28 
.EQU ADS3_I		,PORTE
.EQU ADS3_IO		,TRISE
.EQU ADS3_I_P		,13
.EQU ADS3_IO_P	        ,13
;=======================PIN29 
.EQU FIB_RX0_CHK_I	,PORTE
.EQU FIB_RX0_CHK_IO	,TRISE
.EQU FIB_RX0_CHK_I_P	,14
.EQU FIB_RX0_CHK_IO_P	,14
;=======================PIN30 ;TP3
.EQU FIB_RX1_CHK_I      ,PORTE
.EQU FIB_RX1_CHK_IO	,TRISE
.EQU FIB_RX1_CHK_I_P	,15
.EQU FIB_RX1_CHK_IO_P	,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
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
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
;EQU LDLO_TR_O		,LATB
;EQU LDLO_TR_IO		,TRISB
;EQU LDLO_TR_O_P	,6 
;EQU LDLO_TR_IO_P	,6 
;=======================PIN45
;EQU LSEO_TR_O		,LATC
;EQU LSEO_TR_IO		,TRISC
;EQU LSEO_TR_O_P	,10 
;EQU LSEO_TR_IO_P	,10
 ;=======================PIN46 TP8
;EQU LDFO_TR_O		,LATB
;EQU LDFO_TR_IO		,TRISB
;EQU LDFO_TR_O_P	,7 
;EQU LDFO_TR_IO_P	,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;======================PIN48
;EQU RS485EX_RO_I	,PORTB
;EQU RS485EX_RO_IO	,TRISB
;EQU RS485EX_RO_I_P	,8 
;EQU RS485EX_RO_IO_P	,8
;=======================PIN49
;EQU RS485EX_DI_O	,LATB
;EQU RS485EX_DI_IO	,TRISB
;EQU RS485EX_DI_O_P	,9 
;EQU RS485EX_DI_IO_P	,9
;=======================PIN50 
.EQU FIB_TX0_CHK_O	,LATC
.EQU FIB_TX0_CHK_IO	,TRISC
.EQU FIB_TX0_CHK_O_P	,6
.EQU FIB_TX0_CHK_IO_P	,6
;=======================PIN51 
.EQU FIB_TX1_CHK_O	,LATC
.EQU FIB_TX1_CHK_IO	,TRISC
.EQU FIB_TX1_CHK_O_P	,7
.EQU FIB_TX1_CHK_IO_P	,7
;=======================PIN52
;EQU LSEI_CS_O		,LATC
;EQU LSEI_CS_IO	        ,TRISC
;EQU LSEI_CS_O_P	,8 
;EQU LSEI_CS_IO_P	,8
;=======================PIN53
;EQU LDFI_CS_O		,LATD
;EQU LDFI_CS_IO	        ,TRISD
;EQU LDFI_CS_O_P	,5 
;EQU LDFI_CS_IO_P	,5
;=======================PIN54
;EQU SEO_EN_N_O		,LATD
;EQU SEO_EN_N_IO	,TRISD
;EQU SEO_EN_N_O_P	,6 
;EQU SEO_EN_N_IO_P	,6 
;=======================PIN55
;EQU DFO_EN_N_O		,LATC
;EQU DFO_EN_N_IO	,TRISC
;EQU DFO_EN_N_O_P	,9 
;EQU DFO_EN_N_IO_P	,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
;EQU DFO_EN_P_O		,LATF
;EQU DFO_EN_P_IO	,TRISF
;EQU DFO_EN_P_O_P	,0 
;EQU DFO_EN_P_IO_P	,0 
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10

.ENDIF




.IFDEF JS203_39A_F01_02
;=======================PIN1 
.EQU SWS0_I		,PORTA
.EQU SWS0_IO		,TRISA
.EQU SWS0_I_P		,7
.EQU SWS0_IO_P		,7
;=======================PIN2 
.EQU SWS1_I		,PORTB
.EQU SWS1_IO		,TRISB
.EQU SWS1_I_P		,14
.EQU SWS1_IO_P		,14
;=======================PIN3 
.EQU SWS2_I		,PORTB
.EQU SWS2_IO		,TRISB
.EQU SWS2_I_P		,15
.EQU SWS2_IO_P		,15
;=======================PIN4 
.EQU SWS3_I		,PORTG
.EQU SWS3_IO		,TRISG
.EQU SWS3_I_P		,6
.EQU SWS3_IO_P		,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
.EQU NC12_O		,LATA
.EQU NC12_IO		,TRISA
.EQU NC12_O_P		,11
.EQU NC12_IO_P		,11
;=======================PIN13 
.EQU NC13_O		,LATA
.EQU NC13_IO		,TRISA
.EQU NC13_O_P	        ,0
.EQU NC13_IO_P	        ,0
;=======================PIN14 
.EQU ADI_5V_I		,PORTA
.EQU ADI_5V_IO		,TRISA
.EQU ADI_5V_I_P		,1
.EQU ADI_5V_IO_P	,1
;=======================PIN15 
.EQU NC15_O		,LATB
.EQU NC15_IO		,TRISB
.EQU NC15_O_P	        ,0
.EQU NC15_IO_P	        ,0
;=======================PIN16 
.EQU NC16_O		,LATB
.EQU NC16_IO		,TRISB
.EQU NC16_O_P	        ,1
.EQU NC16_IO_P	        ,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU NC21_O		,LATC
.EQU NC21_IO		,TRISC
.EQU NC21_O_P	        ,0
.EQU NC21_IO_P	        ,0
;=======================PIN22 
.EQU NC22_O		,LATC
.EQU NC22_IO		,TRISC
.EQU NC22_O_P	        ,1
.EQU NC22_IO_P	        ,1
;=======================PIN23 
.EQU NC23_O		,LATC
.EQU NC23_IO		,TRISC
.EQU NC23_O_P	        ,2
.EQU NC23_IO_P	        ,2
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
.EQU NC27_O_P	        ,12
.EQU NC27_IO_P	        ,12
;=======================PIN28 
.EQU NC28_O		,LATE
.EQU NC28_IO		,TRISE
.EQU NC28_O_P	        ,13
.EQU NC28_IO_P	        ,13
;=======================PIN29 
.EQU NC29_O		,LATE
.EQU NC29_IO		,TRISE
.EQU NC29_O_P	        ,14
.EQU NC29_IO_P	        ,14
;=======================PIN30 ;TP3
.EQU NC30_O		,LATE
.EQU NC30_IO		,TRISE
.EQU NC30_O_P	        ,15
.EQU NC30_IO_P	        ,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
;=======================PIN35
.EQU NC35_O		,LATC
.EQU NC35_IO		,TRISC
.EQU NC35_O_P	        ,3 
.EQU NC35_IO_P	        ,3 
;=======================PIN36
.EQU NC36_O		,LATC
.EQU NC36_IO		,TRISC
.EQU NC36_O_P	        ,4 
.EQU NC36_IO_P	        ,4 
;=======================PIN37 
.EQU NC37_O		,LATC
.EQU NC37_IO		,TRISC
.EQU NC37_O_P	        ,5
.EQU NC37_IO_P	        ,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
.EQU NC44_O		,LATB
.EQU NC44_IO		,TRISB
.EQU NC44_O_P	        ,6
.EQU NC44_IO_P	        ,6
;=======================PIN45
.EQU NC45_O		,LATC
.EQU NC45_IO		,TRISC
.EQU NC45_O_P	        ,10
.EQU NC45_IO_P	        ,10
 ;=======================PIN46 TP8
.EQU NC46_O		,LATB
.EQU NC46_IO		,TRISB
.EQU NC46_O_P	        ,7
.EQU NC46_IO_P	        ,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;=======================PIN48
.EQU RS485EX_RO_I	,PORTB
.EQU RS485EX_RO_IO	,TRISB
.EQU RS485EX_RO_I_P	,8 
.EQU RS485EX_RO_IO_P	,8
;=======================PIN49
.EQU RS485EX_DI_O	,LATB
.EQU RS485EX_DI_IO	,TRISB
.EQU RS485EX_DI_O_P	,9 
.EQU RS485EX_DI_IO_P	,9
;=======================PIN50 
.EQU WG_TRIG_EN_O	,LATC
.EQU WG_TRIG_EN_IO	,TRISC
.EQU WG_TRIG_EN_O_P	,6
.EQU WG_TRIG_EN_IO_P	,6
;=======================PIN51 
.EQU NC51_O		,LATC
.EQU NC51_IO		,TRISC
.EQU NC51_O_P	        ,7
.EQU NC51_IO_P	        ,7
;=======================PIN52
.EQU NC52_O		,LATC
.EQU NC52_IO		,TRISC
.EQU NC52_O_P	        ,8
.EQU NC52_IO_P	        ,8
;=======================PIN53
.EQU NC53_O		,LATD
.EQU NC53_IO		,TRISD
.EQU NC53_O_P	        ,5
.EQU NC53_IO_P	        ,5
;=======================PIN54
.EQU NC54_O		,LATD
.EQU NC54_IO		,TRISD
.EQU NC54_O_P	        ,6
.EQU NC54_IO_P	        ,6
;=======================PIN55
.EQU NC55_O		,LATC
.EQU NC55_IO		,TRISC
.EQU NC55_O_P	        ,9
.EQU NC55_IO_P	        ,9
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
.EQU NC58_O		,LATF
.EQU NC58_IO		,TRISF
.EQU NC58_O_P	        ,0
.EQU NC58_IO_P	        ,0
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10

.ENDIF




.IFDEF JS203_39A_M01_01  ;//RF
;=======================PIN1 
;.EQU NC1_O		,LATA
;.EQU NC1_IO	        ,TRISA
;.EQU NC1_O_P	        ,7
;.EQU NC1_IO_P	        ,7
;=======================PIN2 
.EQU RFMA_CKO_O		,LATB
.EQU RFMA_CKO_IO	,TRISB
.EQU RFMA_CKO_O_P	,14
.EQU RFMA_CKO_IO_P	,14
;=======================PIN3 
.EQU RFMA_DIO1_I	,PORTB
.EQU RFMA_DIO1_IO	,TRISB
.EQU RFMA_DIO1_I_P	,15
.EQU RFMA_DIO1_IO_P	,15
;=======================PIN4 
.EQU RFMA_DIO2_O	,LATG
.EQU RFMA_DIO2_IO	,TRISG
.EQU RFMA_DIO2_O_P	,6
.EQU RFMA_DIO2_IO_P	,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
.EQU RFMA_D0_O		,LATA
.EQU RFMA_D0_IO		,TRISA
.EQU RFMA_D0_O_P	,11
.EQU RFMA_D0_IO_P	,11
;=======================PIN13 
.EQU ADI_24V_I		,PORTA
.EQU ADI_24V_IO		,TRISA
.EQU ADI_24V_I_P	,0
.EQU ADI_24V_IO_P	,0
;=======================PIN14 
;.EQU ADI_5V_I		,PORTA
;.EQU ADI_5V_IO		,TRISA
;.EQU ADI_5V_I_P	,1
;.EQU ADI_5V_IO_P	,1
;=======================PIN15 
;EQU ADS0_I		,PORTB
;EQU ADS0_IO		,TRISB
;EQU ADS0_I_P		,0
;EQU ADS0_IO_P	        ,0
;=======================PIN16 
;EQU ADS1_I		,PORTB
;EQU ADS1_IO		,TRISB
;EQU ADS1_I_P		,1
;EQU ADS1_IO_P	        ,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU RFMA_CS_O		,LATC
.EQU RFMA_CS_IO		,TRISC
.EQU RFMA_CS_O_P	,0
.EQU RFMA_CS_IO_P	,0
;=======================PIN22 
.EQU RFMB_CS_O		,LATC
.EQU RFMB_CS_IO		,TRISC
.EQU RFMB_CS_O_P	,1
.EQU RFMB_CS_IO_P	,1
;=======================PIN23 
.EQU RFM_SCK_O		,LATC
.EQU RFM_SCK_IO		,TRISC
.EQU RFM_SCK_O_P	,2
.EQU RFM_SCK_IO_P	,2
;=======================PIN24 
.EQU RFM_SDIO_O		,LATC
.EQU RFM_SDIO_IO	,TRISC
.EQU RFM_SDIO_O_P	,11
.EQU RFM_SDIO_IO_P	,11
.EQU RFM_SDIO_I		,PORTC
.EQU RFM_SDIO_I_P	,11


;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
;.EQU ADS2_I		,PORTE
;.EQU ADS2_IO		,TRISE
;.EQU ADS2_I_P		,12
;.EQU ADS2_IO_P	        ,12
;=======================PIN28 
;.EQU ADS3_I		,PORTE
;.EQU ADS3_IO		,TRISE
;.EQU ADS3_I_P		,13
;.EQU ADS3_IO_P	        ,13
;=======================PIN29 
;.EQU FIB_RX0_CHK_I	,PORTE
;.EQU FIB_RX0_CHK_IO	,TRISE
;.EQU FIB_RX0_CHK_I_P	,14
;.EQU FIB_RX0_CHK_IO_P	,14
;=======================PIN30 ;TP3
;.EQU FIB_RX1_CHK_I      ,PORTE
;.EQU FIB_RX1_CHK_IO	,TRISE
;.EQU FIB_RX1_CHK_I_P	,15
;.EQU FIB_RX1_CHK_IO_P	,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
;=======================PIN35
;.EQU DB3_O		,LATC
;.EQU DB3_I		,PORTC
;.EQU DB3_IO		,TRISC
;.EQU DB3_O_P		,3
;.EQU DB3_I_P		,3
;.EQU DB3_IO_P		,3
;=======================PIN36
;.EQU DB4_O		,LATC
;.EQU DB4_I		,PORTC
;.EQU DB4_IO		,TRISC
;.EQU DB4_O_P		,4
;.EQU DB4_I_P		,4
;.EQU DB4_IO_P		,4
;=======================PIN37 
;.EQU DB5_O		,LATC
;.EQU DB5_I		,PORTC
;.EQU DB5_IO		,TRISC
;.EQU DB5_O_P		,5
;.EQU DB5_I_P		,5
;.EQU DB5_IO_P		,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
.EQU RFMB_DIO2_O	,LATB
.EQU RFMB_DIO2_IO	,TRISB
.EQU RFMB_DIO2_O_P	,6
.EQU RFMB_DIO2_IO_P	,6
;=======================PIN45
.EQU RFMB_DIO1_I	,PORTC
.EQU RFMB_DIO1_IO	,TRISC
.EQU RFMB_DIO1_I_P	,10
.EQU RFMB_DIO1_IO_P	,10
 ;=======================PIN46 TP8
.EQU RFMB_CKO_O		,LATB
.EQU RFMB_CKO_IO	,TRISB
.EQU RFMB_CKO_O_P	,7
.EQU RFMB_CKO_IO_P	,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;======================PIN48
;EQU RS485EX_RO_I	,PORTB
;EQU RS485EX_RO_IO	,TRISB
;EQU RS485EX_RO_I_P	,8 
;EQU RS485EX_RO_IO_P	,8
;=======================PIN49
;EQU RS485EX_DI_O	,LATB
;EQU RS485EX_DI_IO	,TRISB
;EQU RS485EX_DI_O_P	,9 
;EQU RS485EX_DI_IO_P	,9
;=======================PIN50 
.EQU GPS_RX_O	        ,LATC
.EQU GPS_RX_IO	        ,TRISC
.EQU GPS_RX_O_P	        ,6
.EQU GPS_RX_IO_P	,6
;=======================PIN51 
.EQU GPS_TX_I	        ,PORTC
.EQU GPS_TX_IO	        ,TRISC
.EQU GPS_TX_I_P	        ,7
.EQU GPS_TX_IO_P	,7
;=======================PIN52
.EQU GPS_RESET_O	,LATC
.EQU GPS_RESET_IO	,TRISC
.EQU GPS_RESET_O_P	,8 
.EQU GPS_RESET_IO_P	,8
;=======================PIN53
;EQU LDFI_CS_O		,LATD
;EQU LDFI_CS_IO	        ,TRISD
;EQU LDFI_CS_O_P	,5 
;EQU LDFI_CS_IO_P	,5
;=======================PIN54
;EQU SEO_EN_N_O		,LATD
;EQU SEO_EN_N_IO	,TRISD
;EQU SEO_EN_N_O_P	,6 
;EQU SEO_EN_N_IO_P	,6 
;=======================PIN55
.EQU RFMB_D0_O		,LATC
.EQU RFMB_D0_IO	        ,TRISC
.EQU RFMB_D0_O_P	,9 
.EQU RFMB_D0_IO_P	,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
;EQU DFO_EN_P_O		,LATF
;EQU DFO_EN_P_IO	,TRISF
;EQU DFO_EN_P_O_P	,0 
;EQU DFO_EN_P_IO_P	,0 
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10




.EQU RF_TEST_ERR_K            ,0x01
.EQU RF_TRIM_ERR_K            ,0x02
.EQU RF_CALI_ERR_K            ,0x03



.EQU RESET_REG 			,0x00
.EQU MODECTR_REG		,0x01
.EQU CALIBRATION_REG		,0x02
.EQU FIFO1_REG 			,0x03
.EQU FIFO2_REG 			,0x04
.EQU FIFO_REG 			,0x05
.EQU IDDATA_REG 		,0x06
.EQU RCOSC1_REG 		,0x07
.EQU RCOSC2_REG 		,0x08
.EQU RCOSC3_REG 		,0x09
.EQU CKO_REG 			,0x0A
.EQU GPIO1_REG 			,0x0B
.EQU GPIO2_REG 			,0x0C
.EQU DATARATE_REG 		,0x0D
.EQU PLL1_REG 			,0x0E
.EQU PLL2_REG			,0x0F
.EQU PLL3_REG 			,0x10
.EQU PLL4_REG			,0x11
.EQU PLL5_REG 			,0x12
.EQU CHGROUP1_REG		,0x13
.EQU CHGROUP2_REG		,0x14
.EQU TX1_REG  			,0x15
.EQU TX2_REG  			,0x16
.EQU DELAY1_REG			,0x17
.EQU DELAY2_REG			,0x18
.EQU RX_REG			,0x19
.EQU RXGAIN1_REG		,0x1A
.EQU RXGAIN2_REG		,0x1B
.EQU RXGAIN3_REG		,0x1C
.EQU RXGAIN4_REG		,0x1D
.EQU RSSI_REG			,0x1E
.EQU ADC_REG  			,0x1F
.EQU CODE1_REG 			,0x20
.EQU CODE2_REG 			,0x21
.EQU CODE3_REG 			,0x22
.EQU IFCAL1_REG  		,0x23
.EQU IFCAL2_REG  		,0x24
.EQU VCOCCAL_REG  		,0x25

.EQU VCOCAL1_REG  		,0x26
.EQU VCOCAL2_REG  		,0x27
.EQU VCODEVCAL1_REG             ,0x28
.EQU VCODEVCAL2_REG             ,0x29
.EQU DSA_REG 	 		,0x2A
.EQU VCOMODDELAY_REG		,0x2B
.EQU BATTERY_REG  		,0x2C
.EQU TXTEST_REG  		,0x2D
.EQU RXDEM1_REG  		,0x2E
.EQU RXDEM2_REG  		,0x2F
.EQU CPC1_REG			,0x30
.EQU CPC2_REG			,0x31
.EQU CRYSTALTEST_REG		,0x32
.EQU PLLTEST_REG   		,0x33
.EQU VCOTEST_REG 		,0x34
.EQU RFANALOG_REG 		,0x35
.EQU KEYDATA_REG 		,0x36
.EQU CHSELECT_REG		,0x37
.EQU ROMP_REG 			,0x38
.EQU DATARATE_REG		,0x39
.EQU FCR_REG 			,0x3A
.EQU ARD_REG 			,0x3B
.EQU AFEP_REG 			,0x3C
.EQU FCB_REG 			,0x3D
.EQU KEYC_REG 			,0x3E
.EQU USID_REG 			,0x3F

;strobe command
.EQU CMD_SLEEP		        ,0x80	;1000,xxxx	SLEEP mode
.EQU CMD_IDLE		        ,0x90	;1001,xxxx	IDLE mode
.EQU CMD_STBY		        ,0xA0	;1010,xxxx      Standby mode
.EQU CMD_PLL			,0xB0	;1011,xxxx	PLL mode
.EQU CMD_RX			,0xC0	;1100,xxxx	RX mode
.EQU CMD_TX			,0xD0	;1101,xxxx	TX mode
.EQU CMD_TFR			,0xE0	;1110,xxxx	TX FIFO reset
.EQU CMD_RFR			,0xF0	;1111,xxxx	RX FIFO reset



.ENDIF




.IFDEF JS203_39A_L01_02  ;//LA
;=======================PIN1 
;.EQU SWS0_I		,PORTA
;.EQU SWS0_IO		,TRISA
;.EQU SWS0_I_P		,7
;.EQU SWS0_IO_P		,7
;=======================PIN2 
;.EQU SWS1_I		,PORTB
;.EQU SWS1_IO		,TRISB
;.EQU SWS1_I_P		,14
;.EQU SWS1_IO_P		,14
;=======================PIN3 
;.EQU SWS2_I		,PORTB
;.EQU SWS2_IO		,TRISB
;.EQU SWS2_I_P		,15
;.EQU SWS2_IO_P		,15
;=======================PIN4 
;.EQU SWS3_I		,PORTG
;.EQU SWS3_IO		,TRISG
;.EQU SWS3_I_P		,6
;.EQU SWS3_IO_P		,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
;.EQU NC12_O		,LATA
;.EQU NC12_IO		,TRISA
;.EQU NC12_O_P		,11
;.EQU NC12_IO_P		,11
;=======================PIN13 
;.EQU ADI_12V_I		,PORTA
;.EQU ADI_12V_IO	,TRISA
;.EQU ADI_12V_I_P	,0
;.EQU ADI_12V_IO_P	,0
;=======================PIN14 
.EQU ADI_5V_I		,PORTA
.EQU ADI_5V_IO		,TRISA
.EQU ADI_5V_I_P		,1
.EQU ADI_5V_IO_P	,1
;=======================PIN15 
;EQU ADS0_I		,PORTB
;EQU ADS0_IO		,TRISB
;EQU ADS0_I_P		,0
;EQU ADS0_IO_P	        ,0
;=======================PIN16 
;EQU ADS1_I		,PORTB
;EQU ADS1_IO		,TRISB
;EQU ADS1_I_P		,1
;EQU ADS1_IO_P	        ,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU TEST_LACH_0_O		,LATC
.EQU TEST_LACH_0_I		,PORTC
.EQU TEST_LACH_0_IO		,TRISC
.EQU TEST_LACH_0_O_P		,0
.EQU TEST_LACH_0_I_P		,0
.EQU TEST_LACH_0_IO_P		,0
;=======================PIN22 
.EQU TEST_LACH_1_O		,LATC
.EQU TEST_LACH_1_I		,PORTC
.EQU TEST_LACH_1_IO		,TRISC
.EQU TEST_LACH_1_O_P		,1
.EQU TEST_LACH_1_I_P		,1
.EQU TEST_LACH_1_IO_P		,1
;=======================PIN23 
.EQU TEST_LACH_2_O		,LATC
.EQU TEST_LACH_2_I		,PORTC
.EQU TEST_LACH_2_IO		,TRISC
.EQU TEST_LACH_2_O_P		,2
.EQU TEST_LACH_2_I_P		,2
.EQU TEST_LACH_2_IO_P		,2
;=======================PIN24 
;.EQU NC24_O		,LATC
;.EQU NC24_IO		,TRISC
;.EQU NC24_O_P		,11
;.EQU NC24_IO_P		,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
;.EQU ADS2_I		,PORTE
;.EQU ADS2_IO		,TRISE
;.EQU ADS2_I_P		,12
;.EQU ADS2_IO_P	        ,12
;=======================PIN28 
;.EQU ADS3_I		,PORTE
;.EQU ADS3_IO		,TRISE
;.EQU ADS3_I_P		,13
;.EQU ADS3_IO_P	        ,13
;=======================PIN29 
;.EQU FIB_RX0_CHK_I	,PORTE
;.EQU FIB_RX0_CHK_IO	,TRISE
;.EQU FIB_RX0_CHK_I_P	,14
;.EQU FIB_RX0_CHK_IO_P	,14
;=======================PIN30 ;TP3
;.EQU FIB_RX1_CHK_I      ,PORTE
;.EQU FIB_RX1_CHK_IO	,TRISE
;.EQU FIB_RX1_CHK_I_P	,15
;.EQU FIB_RX1_CHK_IO_P	,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
;=======================PIN35
.EQU TEST_LACH_3_O		,LATC
.EQU TEST_LACH_3_I		,PORTC
.EQU TEST_LACH_3_IO		,TRISC
.EQU TEST_LACH_3_O_P		,3
.EQU TEST_LACH_3_I_P		,3
.EQU TEST_LACH_3_IO_P		,3
;=======================PIN36
.EQU TEST_LACH_4_O		,LATC
.EQU TEST_LACH_4_I		,PORTC
.EQU TEST_LACH_4_IO		,TRISC
.EQU TEST_LACH_4_O_P		,4
.EQU TEST_LACH_4_I_P		,4
.EQU TEST_LACH_4_IO_P		,4
;=======================PIN37 
.EQU TEST_LACH_5_O		,LATC
.EQU TEST_LACH_5_I		,PORTC
.EQU TEST_LACH_5_IO		,TRISC
.EQU TEST_LACH_5_O_P		,5
.EQU TEST_LACH_5_I_P		,5
.EQU TEST_LACH_5_IO_P		,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
;EQU LDLO_TR_O		,LATB
;EQU LDLO_TR_IO		,TRISB
;EQU LDLO_TR_O_P	,6 
;EQU LDLO_TR_IO_P	,6 
;=======================PIN45
;EQU LSEO_TR_O		,LATC
;EQU LSEO_TR_IO		,TRISC
;EQU LSEO_TR_O_P	,10 
;EQU LSEO_TR_IO_P	,10
 ;=======================PIN46 TP8
;EQU LDFO_TR_O		,LATB
;EQU LDFO_TR_IO		,TRISB
;EQU LDFO_TR_O_P	,7 
;EQU LDFO_TR_IO_P	,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;======================PIN48
;EQU RS485EX_RO_I	,PORTB
;EQU RS485EX_RO_IO	,TRISB
;EQU RS485EX_RO_I_P	,8 
;EQU RS485EX_RO_IO_P	,8
;=======================PIN49
;EQU RS485EX_DI_O	,LATB
;EQU RS485EX_DI_IO	,TRISB
;EQU RS485EX_DI_O_P	,9 
;EQU RS485EX_DI_IO_P	,9
;=======================PIN50 
.EQU TEST_LACH_6_O		,LATC
.EQU TEST_LACH_6_I		,PORTC
.EQU TEST_LACH_6_IO		,TRISC
.EQU TEST_LACH_6_O_P		,6
.EQU TEST_LACH_6_I_P		,6
.EQU TEST_LACH_6_IO_P		,6

;=======================PIN51 
.EQU TEST_LACH_7_O		,LATC
.EQU TEST_LACH_7_I		,PORTC
.EQU TEST_LACH_7_IO		,TRISC
.EQU TEST_LACH_7_O_P		,7
.EQU TEST_LACH_7_I_P		,7
.EQU TEST_LACH_7_IO_P		,7
;=======================PIN52
;EQU LSEI_CS_O		,LATC
;EQU LSEI_CS_IO	        ,TRISC
;EQU LSEI_CS_O_P	,8 
;EQU LSEI_CS_IO_P	,8
;=======================PIN53
;EQU LDFI_CS_O		,LATD
;EQU LDFI_CS_IO	        ,TRISD
;EQU LDFI_CS_O_P	,5 
;EQU LDFI_CS_IO_P	,5
;=======================PIN54
;EQU SEO_EN_N_O		,LATD
;EQU SEO_EN_N_IO	,TRISD
;EQU SEO_EN_N_O_P	,6 
;EQU SEO_EN_N_IO_P	,6 
;=======================PIN55
;EQU DFO_EN_N_O		,LATC
;EQU DFO_EN_N_IO	,TRISC
;EQU DFO_EN_N_O_P	,9 
;EQU DFO_EN_N_IO_P	,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
;EQU DFO_EN_P_O		,LATF
;EQU DFO_EN_P_IO	,TRISF
;EQU DFO_EN_P_O_P	,0 
;EQU DFO_EN_P_IO_P	,0 
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10

.ENDIF



.IFDEF JS203_39A_A01_03  ;//IPC
;=======================PIN1 
;.EQU SWS0_I		,PORTA
;.EQU SWS0_IO		,TRISA
;.EQU SWS0_I_P		,7
;.EQU SWS0_IO_P		,7
;=======================PIN2 
;.EQU SWS1_I		,PORTB
;.EQU SWS1_IO		,TRISB
;.EQU SWS1_I_P		,14
;.EQU SWS1_IO_P		,14
;=======================PIN3 
;.EQU SWS2_I		,PORTB
;.EQU SWS2_IO		,TRISB
;.EQU SWS2_I_P		,15
;.EQU SWS2_IO_P		,15
;=======================PIN4 
;.EQU SWS3_I		,PORTG
;.EQU SWS3_IO		,TRISG
;.EQU SWS3_I_P		,6
;.EQU SWS3_IO_P		,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
;.EQU NC12_O		,LATA
;.EQU NC12_IO		,TRISA
;.EQU NC12_O_P		,11
;.EQU NC12_IO_P		,11
;=======================PIN13 
.EQU ADI_12V_I		,PORTA
.EQU ADI_12V_IO	        ,TRISA
.EQU ADI_12V_I_P	,0
.EQU ADI_12V_IO_P	,0
;=======================PIN14 
.EQU ADI_5V_I		,PORTA
.EQU ADI_5V_IO		,TRISA
.EQU ADI_5V_I_P		,1
.EQU ADI_5V_IO_P	,1
;=======================PIN15 
;EQU ADS0_I		,PORTB
;EQU ADS0_IO		,TRISB
;EQU ADS0_I_P		,0
;EQU ADS0_IO_P	        ,0
;=======================PIN16 
;EQU ADS1_I		,PORTB
;EQU ADS1_IO		,TRISB
;EQU ADS1_I_P		,1
;EQU ADS1_IO_P	        ,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
;.EQU TEST_LACH_0_O		,LATC
;.EQU TEST_LACH_0_I		,PORTC
;.EQU TEST_LACH_0_IO		,TRISC
;.EQU TEST_LACH_0_O_P		,0
;.EQU TEST_LACH_0_I_P		,0
;.EQU TEST_LACH_0_IO_P		,0
;=======================PIN22 
;.EQU TEST_LACH_1_O		,LATC
;.EQU TEST_LACH_1_I		,PORTC
;.EQU TEST_LACH_1_IO		,TRISC
;.EQU TEST_LACH_1_O_P		,1
;.EQU TEST_LACH_1_I_P		,1
;.EQU TEST_LACH_1_IO_P		,1
;=======================PIN23 
;.EQU TEST_LACH_2_O		,LATC
;.EQU TEST_LACH_2_I		,PORTC
;.EQU TEST_LACH_2_IO		,TRISC
;.EQU TEST_LACH_2_O_P		,2
;.EQU TEST_LACH_2_I_P		,2
;.EQU TEST_LACH_2_IO_P		,2
;=======================PIN24 
.EQU IPC_SYS_RST_O		,LATC
.EQU IPC_SYS_RST_IO		,TRISC
.EQU IPC_SYS_RST_O_P		,11
.EQU IPC_SYS_RST_IO_P		,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
;.EQU ADS2_I		,PORTE
;.EQU ADS2_IO		,TRISE
;.EQU ADS2_I_P		,12
;.EQU ADS2_IO_P	        ,12
;=======================PIN28 
;.EQU ADS3_I		,PORTE
;.EQU ADS3_IO		,TRISE
;.EQU ADS3_I_P		,13
;.EQU ADS3_IO_P	        ,13
;=======================PIN29 
;.EQU FIB_RX0_CHK_I	,PORTE
;.EQU FIB_RX0_CHK_IO	,TRISE
;.EQU FIB_RX0_CHK_I_P	,14
;.EQU FIB_RX0_CHK_IO_P	,14
;=======================PIN30 ;TP3
;.EQU FIB_RX1_CHK_I      ,PORTE
;.EQU FIB_RX1_CHK_IO	,TRISE
;.EQU FIB_RX1_CHK_I_P	,15
;.EQU FIB_RX1_CHK_IO_P	,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
;=======================PIN35
;.EQU TEST_LACH_3_O		,LATC
;.EQU TEST_LACH_3_I		,PORTC
;.EQU TEST_LACH_3_IO		,TRISC
;.EQU TEST_LACH_3_O_P		,3
;.EQU TEST_LACH_3_I_P		,3
;.EQU TEST_LACH_3_IO_P		,3
;=======================PIN36
;.EQU TEST_LACH_4_O		,LATC
;.EQU TEST_LACH_4_I		,PORTC
;.EQU TEST_LACH_4_IO		,TRISC
;.EQU TEST_LACH_4_O_P		,4
;.EQU TEST_LACH_4_I_P		,4
;.EQU TEST_LACH_4_IO_P		,4
;=======================PIN37 
;.EQU TEST_LACH_5_O		,LATC
;.EQU TEST_LACH_5_I		,PORTC
;.EQU TEST_LACH_5_IO		,TRISC
;.EQU TEST_LACH_5_O_P		,5
;.EQU TEST_LACH_5_I_P		,5
;.EQU TEST_LACH_5_IO_P		,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
;EQU LDLO_TR_O		,LATB
;EQU LDLO_TR_IO		,TRISB
;EQU LDLO_TR_O_P	,6 
;EQU LDLO_TR_IO_P	,6 
;=======================PIN45
;EQU LSEO_TR_O		,LATC
;EQU LSEO_TR_IO		,TRISC
;EQU LSEO_TR_O_P	,10 
;EQU LSEO_TR_IO_P	,10
 ;=======================PIN46 TP8
;EQU LDFO_TR_O		,LATB
;EQU LDFO_TR_IO		,TRISB
;EQU LDFO_TR_O_P	,7 
;EQU LDFO_TR_IO_P	,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;======================PIN48
;EQU RS485EX_RO_I	,PORTB
;EQU RS485EX_RO_IO	,TRISB
;EQU RS485EX_RO_I_P	,8 
;EQU RS485EX_RO_IO_P	,8
;=======================PIN49
;EQU RS485EX_DI_O	,LATB
;EQU RS485EX_DI_IO	,TRISB
;EQU RS485EX_DI_O_P	,9 
;EQU RS485EX_DI_IO_P	,9
;=======================PIN50 
;.EQU TEST_LACH_6_O		,LATC
;.EQU TEST_LACH_6_I		,PORTC
;.EQU TEST_LACH_6_IO		,TRISC
;.EQU TEST_LACH_6_O_P		,6
;.EQU TEST_LACH_6_I_P		,6
;.EQU TEST_LACH_6_IO_P		,6

;=======================PIN51 
;.EQU TEST_LACH_7_O		,LATC
;.EQU TEST_LACH_7_I		,PORTC
;.EQU TEST_LACH_7_IO		,TRISC
;.EQU TEST_LACH_7_O_P		,7
;.EQU TEST_LACH_7_I_P		,7
;.EQU TEST_LACH_7_IO_P		,7
;=======================PIN52
;EQU LSEI_CS_O		,LATC
;EQU LSEI_CS_IO	        ,TRISC
;EQU LSEI_CS_O_P	,8 
;EQU LSEI_CS_IO_P	,8
;=======================PIN53
;EQU LDFI_CS_O		,LATD
;EQU LDFI_CS_IO	        ,TRISD
;EQU LDFI_CS_O_P	,5 
;EQU LDFI_CS_IO_P	,5
;=======================PIN54
;EQU SEO_EN_N_O		,LATD
;EQU SEO_EN_N_IO	,TRISD
;EQU SEO_EN_N_O_P	,6 
;EQU SEO_EN_N_IO_P	,6 
;=======================PIN55
;EQU DFO_EN_N_O		,LATC
;EQU DFO_EN_N_IO	,TRISC
;EQU DFO_EN_N_O_P	,9 
;EQU DFO_EN_N_IO_P	,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
;EQU DFO_EN_P_O		,LATF
;EQU DFO_EN_P_IO	,TRISF
;EQU DFO_EN_P_O_P	,0 
;EQU DFO_EN_P_IO_P	,0 
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10

.ENDIF



