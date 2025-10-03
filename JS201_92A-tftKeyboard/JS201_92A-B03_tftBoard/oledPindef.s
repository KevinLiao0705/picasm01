
;======================================================
;=======================PIN1 
.EQU KEY_IN_I			,PORTB
.EQU KEY_IN_IO			,TRISB
.EQU KEY_IN_I_P			,0
.EQU KEY_IN_IO_P		,0

;=======================PIN2 
.EQU NC2_O			,LATB
.EQU NC2_IO			,TRISB
.EQU NC2_O_P			,1
.EQU NC2_IO_P			,1
;=======================PIN3 	PGC
;=======================PIN4 	PGD
;=======================PIN5 	VSS
;=======================PIN6 	OSC1
;=======================PIN7	 
.EQU TFT_CS_O			,LATA
.EQU TFT_CS_IO			,TRISA
.EQU TFT_CS_O_P			,3
.EQU TFT_CS_IO_P		,3
;=======================PIN8 
.EQU TFT_BK_O			,LATB
.EQU TFT_BK_IO			,TRISB
.EQU TFT_BK_O_P			,4
.EQU TFT_BK_IO_P		,4
;=======================PIN9	VSS 
.EQU TFT_RST_O			,LATA
.EQU TFT_RST_IO			,TRISA
.EQU TFT_RST_O_P		,4
.EQU TFT_RST_IO_P		,4
;=======================PIN10 	VDD
;=======================PIN11 
.EQU TFT_SCL_O			,LATB
.EQU TFT_SCL_IO			,TRISB
.EQU TFT_SCL_O_P		,5
.EQU TFT_SCL_IO_P		,5
;=======================PIN12 
.EQU TFT_A0_O			,LATB
.EQU TFT_A0_IO			,TRISB
.EQU TFT_A0_O_P			,6
.EQU TFT_A0_IO_P		,6
;=======================PIN13 
.EQU TFT_SDA_O			,LATB
.EQU TFT_SDA_I			,PORTB
.EQU TFT_SDA_IO			,TRISB
.EQU TFT_SDA_O_P		,7
.EQU TFT_SDA_I_P		,7
.EQU TFT_SDA_IO_P		,7
;=======================PIN14 
.EQU RS485_DI_O			,LATB
.EQU RS485_DI_IO		,TRISB
.EQU RS485_DI_O_P		,8
.EQU RS485_DI_IO_P		,8
;=======================PIN15 
.EQU RS485_RO_I			,PORTB
.EQU RS485_RO_IO		,TRISB
.EQU RS485_RO_I_P		,9
.EQU RS485_RO_IO_P		,9
;=======================PIN16 	VSS
;=======================PIN17	VCAP 
;=======================PIN18 	PGD
.EQU RS485_CTL_O		,LATB
.EQU RS485_CTL_IO		,TRISB
.EQU RS485_CTL_O_P		,10
.EQU RS485_CTL_IO_P		,10
;=======================PIN19	VDD 
.EQU FLASH_SCK_O		,LATB
.EQU FLASH_SCK_IO		,TRISB
.EQU FLASH_SCK_O_P		,11
.EQU FLASH_SCK_IO_P		,11
;=======================PIN20 	VSS
.EQU FLASH_D0_O			,LATB
.EQU FLASH_D0_I			,PORTB
.EQU FLASH_D0_IO		,TRISB
.EQU FLASH_D0_O_P		,12
.EQU FLASH_D0_I_P		,12
.EQU FLASH_D0_IO_P		,12

.EQU FLASHA_DI_O		,LATB
.EQU FLASHA_DI_IO		,TRISB
.EQU FLASHA_DI_O_P		,12
.EQU FLASHA_DI_IO_P		,12


;=======================PIN21 
.EQU FLASH_D1_O			,LATB
.EQU FLASH_D1_I			,PORTB
.EQU FLASH_D1_IO		,TRISB
.EQU FLASH_D1_O_P		,13
.EQU FLASH_D1_I_P		,13
.EQU FLASH_D1_IO_P		,13

.EQU FLASHA_DO_I		,PORTB
.EQU FLASHA_DO_IO		,TRISB
.EQU FLASHA_DO_I_P		,13 
.EQU FLASHA_DO_IO_P		,13

;=======================PIN22 
.EQU FLASH_D2_O			,LATB
.EQU FLASH_D2_I			,PORTB
.EQU FLASH_D2_IO		,TRISB
.EQU FLASH_D2_O_P		,14
.EQU FLASH_D2_I_P		,14
.EQU FLASH_D2_IO_P		,14

.EQU FLASHA_WP_O		,LATB
.EQU FLASHA_WP_IO		,TRISB
.EQU FLASHA_WP_O_P		,14 
.EQU FLASHA_WP_IO_P		,14 

;=======================PIN23 
.EQU FLASH_D3_O			,LATB
.EQU FLASH_D3_I			,PORTB
.EQU FLASH_D3_IO		,TRISB
.EQU FLASH_D3_O_P		,15
.EQU FLASH_D3_I_P		,15
.EQU FLASH_D3_IO_P		,15

.EQU FLASHA_HOLD_O		,LATB	
.EQU FLASHA_HOLD_IO		,TRISB	
.EQU FLASHA_HOLD_O_P		,15 
.EQU FLASHA_HOLD_IO_P		,15 


;=======================PIN24 	VSS
;=======================PIN25	VDD 
;=======================PIN26 	MCLR
;=======================PIN27 
.EQU FLASHA_CS_O		,LATA
.EQU FLASHA_CS_IO		,TRISA
.EQU FLASHA_CS_O_P		,0
.EQU FLASHA_CS_IO_P		,0

.EQU FLASHB_CS_O		,LATA
.EQU FLASHB_CS_IO		,TRISA
.EQU FLASHB_CS_O_P		,0
.EQU FLASHB_CS_IO_P		,0

;=======================PIN28 
.EQU NC28_O			,LATA
.EQU NC28_IO			,TRISA
.EQU NC28_O_P			,1
.EQU NC28_IO_P			,1
.EQU TP0_O			,LATA
.EQU TP0_IO			,TRISA
.EQU TP0_O_P			,1
.EQU TP0_IO_P			,1
