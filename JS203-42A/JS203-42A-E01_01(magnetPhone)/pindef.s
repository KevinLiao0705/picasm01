
;======================================================
;=======================PIN1 
;.EQU V50V_ADI_I			,PORTB
;.EQU V50V_ADI_IO		,TRISB
;.EQU V50V_ADI_I_P		,0
;.EQU V50V_ADI_IO_P		,0
;=======================PIN2 
;.EQU T32V_ADI_I		,PORTB
;.EQU T32V_ADI_IO		,TRISB
;.EQU T32V_ADI_I_P		,1
;.EQU T32V_ADI_IO_P		,1
;=======================PIN3 	PGC
;.EQU I32V_ADI_I		,PORTB
;.EQU I32V_ADI_IO		,TRISB
;.EQU I32V_ADI_I_P		,2
;.EQU I32V_ADI_IO_P		,2
;=======================PIN4 	PGD
;.EQU V32V_ADI_I		,PORTB
;.EQU V32V_ADI_IO		,TRISB
;.EQU V32V_ADI_I_P		,3
;.EQU V32V_ADI_IO_P		,3
;=======================PIN5 	VSS
;=======================PIN6 	OSC1
;.EQU ADDR_A0_I			,PORTA
;.EQU ADDR_A0_IO		,TRISA
;.EQU ADDR_A0_I_P		,2
;.EQU ADDR_A0_IO_P		,2
;=======================PIN7	OSC2 
;.EQU ADDR_A1_I			,PORTA
;.EQU ADDR_A1_IO		,TRISA
;.EQU ADDR_A1_I_P		,3
;.EQU ADDR_A1_IO_P		,3
;=======================PIN8 
.EQU TP8_O			,LATB
.EQU TP8_IO		        ,TRISB
.EQU TP8_O_P		        ,4
.EQU TP8_IO_P		        ,4
;=======================PIN9	VSS 
.EQU TP9_O			,LATA
.EQU TP9_IO		        ,TRISA
.EQU TP9_O_P		        ,4
.EQU TP9_IO_P		        ,4
;=======================PIN10 	VDD
;=======================PIN11 
.EQU TP11_O			,LATB
.EQU TP11_IO		        ,TRISB
.EQU TP11_O_P		        ,5
.EQU TP11_IO_P		        ,5
;PGD
;=======================PIN12 
.EQU TP12_O			,LATB
.EQU TP12_IO		        ,TRISB
.EQU TP12_O_P		        ,6
.EQU TP12_IO_P		        ,6
;PGC
;=======================PIN13 
.EQU DTMFB_O		        ,LATB
.EQU DTMFB_IO		        ,TRISB
.EQU DTMFB_O_P		        ,7
.EQU DTMFB_IO_P		        ,7
;=======================PIN14 
.EQU DTMFA_O		        ,LATB
.EQU DTMFA_IO		        ,TRISB
.EQU DTMFA_O_P		        ,8
.EQU DTMFA_IO_P		        ,8
;=======================PIN15 
.EQU UTX_O			,LATB
.EQU UTX_I			,PORTB
.EQU UTX_IO		        ,TRISB
.EQU UTX_O_P		        ,9
.EQU UTX_I_P		        ,9
.EQU UTX_IO_P		        ,9
;.EQU IIC_SDA_O			,LATB
;.EQU IIC_SDA_IO		,TRISB
;.EQU IIC_SDA_O_P		,9
;.EQU IIC_SDA_IO_P		,9
;=======================PIN16 	VSS
;=======================PIN17	VCAP 
;=======================PIN18 	PGD

.EQU URX_I			,PORTB
.EQU URX_IO		        ,TRISB
.EQU URX_I_P		        ,10
.EQU URX_IO_P		        ,10

;.EQU IIC_CLK_O			,LATB
;.EQU IIC_CLK_IO	        ,TRISB
;.EQU IIC_CLK_O_P		,10
;.EQU IIC_CLK_IO_P		,10
;=======================PIN19	VDD 
.EQU PHONE_SW_O			,LATB
.EQU PHONE_SW_IO		,TRISB
.EQU PHONE_SW_O_P		,11
.EQU PHONE_SW_IO_P		,11
;=======================PIN20 	VSS
.EQU RING_SW_O			,LATB
.EQU RING_SW_IO		        ,TRISB
.EQU RING_SW_O_P		,12
.EQU RING_SW_IO_P		,12
;=======================PIN21 
.EQU PSTN_SW_O			,LATB
.EQU PSTN_SW_IO		        ,TRISB
.EQU PSTN_SW_O_P		,13
.EQU PSTN_SW_IO_P		,13
;=======================PIN22 
;.EQU IOOUT_EN_O		,LATB
;.EQU IOOUT_EN_IO		,TRISB
;.EQU IOOUT_EN_O_P		,14
;.EQU IOOUT_EN_IO_P		,14
;=======================PIN23 
;.EQU LED_O			,LATB
;.EQU LED_IO			,TRISB
;.EQU LED_O_P			,15
;.EQU LED_IO_P			,15
;=======================PIN24 	VSS
;=======================PIN25	VDD 
;=======================PIN26 	MCLR
;=======================PIN27 
.EQU PSTN_DET_I			,PORTA
.EQU PSTN_DET_IO		,TRISA
.EQU PSTN_DET_I_P		,0
.EQU PSTN_DET_IO_P		,0
;=======================PIN28 
.EQU PHONE_DET_I		,PORTA
.EQU PHONE_DET_IO		,TRISA
.EQU PHONE_DET_I_P		,0
.EQU PHONE_DET_IO_P		,0
