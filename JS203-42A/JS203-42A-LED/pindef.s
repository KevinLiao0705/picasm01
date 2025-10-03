

;======================================================
;=======================PIN1 
.EQU SW1_I			,PORTB
.EQU SW1_IO			,TRISB
.EQU SW1_I_P			,0
.EQU SW1_IO_P			,0

;=======================PIN2 
.EQU SW2_I			,PORTB
.EQU SW2_IO			,TRISB
.EQU SW2_I_P			,1
.EQU SW2_IO_P			,1
;=======================PIN3 	PGC
;=======================PIN4 	PGD
;=======================PIN5 	VSS
;=======================PIN6 	OSC1
.EQU LED2R_O			,LATA
.EQU LED2R_IO			,TRISA
.EQU LED2R_O_P			,2
.EQU LED2R_IO_P			,2

;.EQU TP1_O			,LATA
;.EQU TP1_IO			,TRISA
;.EQU TP1_O_P			,2
;.EQU TP1_IO_P			,2


;=======================PIN7	 
.EQU LED2G_O			,LATA
.EQU LED2G_IO			,TRISA
.EQU LED2G_O_P			,3
.EQU LED2G_IO_P			,3

.EQU TP1_O			,LATA
.EQU TP1_IO			,TRISA
.EQU TP1_O_P			,3
.EQU TP1_IO_P			,3


;=======================PIN8 
.EQU NC8_O			,LATB
.EQU NC8_IO			,TRISB
.EQU NC8_O_P			,4
.EQU NC8_IO_P			,4


;=======================PIN9	VSS 
.EQU SPI_CS_I			,PORTA
.EQU SPI_CS_IO			,TRISA
.EQU SPI_CS_I_P			,4
.EQU SPI_CS_IO_P		,4
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SPI_SCL_I			,PORTB
.EQU SPI_SCL_IO			,TRISB
.EQU SPI_SCL_I_P		,5
.EQU SPI_SCL_IO_P		,5
;=======================PIN12 RP38
.EQU SPI_DO_I			,PORTB
.EQU SPI_DO_IO			,TRISB
.EQU SPI_DO_I_P			,6
.EQU SPI_DO_IO_P		,6
.EQU URX1_I			,PORTB
.EQU URX1_IO			,TRISB
.EQU URX1_I_P			,6
.EQU URX1_IO_P			,6
;=======================PIN13 RP39
.EQU SPI_DI_O			,LATB
.EQU SPI_DI_IO			,TRISB
.EQU SPI_DI_O_P			,7
.EQU SPI_DI_IO_P		,7
.EQU UTX1_O			,LATB
.EQU UTX1_IO			,TRISB
.EQU UTX1_O_P			,7
.EQU UTX1_IO_P			,7

;=======================PIN14 
.EQU DB0_O			,LATB
.EQU DB0_IO			,TRISB
.EQU DB0_O_P			,8
.EQU DB0_IO_P			,8
;=======================PIN15 
.EQU DB1_O			,LATB
.EQU DB1_IO			,TRISB
.EQU DB1_O_P			,9
.EQU DB1_IO_P			,9
;=======================PIN16 	VSS
;=======================PIN17	VCAP 
;=======================PIN18 	PGD
.EQU DB2_O			,LATB
.EQU DB2_IO			,TRISB
.EQU DB2_O_P			,10
.EQU DB2_IO_P			,10
;=======================PIN19	VDD 
.EQU DB3_O			,LATB
.EQU DB3_IO			,TRISB
.EQU DB3_O_P			,11
.EQU DB3_IO_P			,11
;=======================PIN20 	VSS
.EQU DB4_O			,LATB
.EQU DB4_IO			,TRISB
.EQU DB4_O_P			,12
.EQU DB4_IO_P			,12
;=======================PIN21 
.EQU DB5_O			,LATB
.EQU DB5_IO			,TRISB
.EQU DB5_O_P			,13
.EQU DB5_IO_P			,13
;=======================PIN22 
.EQU DB6_O			,LATB
.EQU DB6_IO			,TRISB
.EQU DB6_O_P			,14
.EQU DB6_IO_P			,14
;=======================PIN23 
.EQU DB7_O			,LATB
.EQU DB7_IO			,TRISB
.EQU DB7_O_P			,15
.EQU DB7_IO_P			,15

;=======================PIN24 	VSS
;=======================PIN25	VDD 
;=======================PIN26 	MCLR
;=======================PIN27 
.EQU LED_TRIG2_O		,LATA
.EQU LED_TRIG2_IO		,TRISA
.EQU LED_TRIG2_O_P		,0
.EQU LED_TRIG2_IO_P		,0
;=======================PIN28 
.EQU LED_TRIG1_O		,LATA
.EQU LED_TRIG1_IO		,TRISA
.EQU LED_TRIG1_O_P		,1
.EQU LED_TRIG1_IO_P		,1
