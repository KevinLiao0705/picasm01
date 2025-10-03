

;======================================================
;=======================PIN1 
.EQU SW1_I			,PORTA
.EQU SW1_IO			,TRISA
.EQU SW1_I_P			,7
.EQU SW1_IO_P			,7
;=======================PIN2 
.EQU SW2_I			,PORTB
.EQU SW2_IO			,TRISB
.EQU SW2_I_P			,14
.EQU SW2_IO_P			,14
;=======================PIN3 
.EQU SW3_I			,PORTB
.EQU SW3_IO			,TRISB
.EQU SW3_I_P			,15
.EQU SW3_IO_P			,15
;=======================PIN4 
.EQU SW4_I			,PORTG
.EQU SW4_IO			,TRISG
.EQU SW4_I_P			,6
.EQU SW4_IO_P			,6
;=======================PIN5 
.EQU SW5_I			,PORTG
.EQU SW5_IO			,TRISG
.EQU SW5_I_P			,7
.EQU SW5_IO_P			,7
;=======================PIN6 
.EQU SW6_I			,PORTG
.EQU SW6_IO			,TRISG
.EQU SW6_I_P			,8
.EQU SW6_IO_P			,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SW7_I			,PORTG
.EQU SW7_IO			,TRISG
.EQU SW7_I_P			,9
.EQU SW7_IO_P			,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU TP1_O			,LATA
.EQU TP1_IO			,TRISA
.EQU TP1_O_P			,12
.EQU TP1_IO_P			,12
;=======================PIN12 
.EQU TP2_O			,LATA
.EQU TP2_IO			,TRISA
.EQU TP2_O_P			,11
.EQU TP2_IO_P			,11
;=======================PIN13 
.EQU TP3_O			,LATA
.EQU TP3_IO			,TRISA
.EQU TP3_O_P			,0
.EQU TP3_IO_P			,0
;=======================PIN14 
.EQU TP4_O			,LATA
.EQU TP4_IO			,TRISA
.EQU TP4_O_P			,1
.EQU TP4_IO_P			,1
;=======================PIN15 
.EQU TP5_O			,LATB
.EQU TP5_IO			,TRISB
.EQU TP5_O_P			,0
.EQU TP5_IO_P			,0
;=======================PIN16 
.EQU TP6_O			,LATB
.EQU TP6_IO			,TRISB
.EQU TP6_O_P			,1
.EQU TP6_IO_P			,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU SW8_I			,PORTC
.EQU SW8_IO			,TRISC
.EQU SW8_I_P			,0
.EQU SW8_IO_P			,0
;=======================PIN22 
.EQU SW9_I			,PORTC
.EQU SW9_IO			,TRISC
.EQU SW9_I_P			,1
.EQU SW9_IO_P			,1
;=======================PIN23 
.EQU SW10_I			,PORTC
.EQU SW10_IO			,TRISC
.EQU SW10_I_P			,2
.EQU SW10_IO_P			,2
;=======================PIN24
.EQU SW11_I			,PORTC
.EQU SW11_IO			,TRISC
.EQU SW11_I_P			,11
.EQU SW11_IO_P			,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
.EQU SW12_I			,PORTE
.EQU SW12_IO			,TRISE
.EQU SW12_I_P			,12
.EQU SW12_IO_P			,12
;=======================PIN28 
.EQU SW13_I			,PORTE
.EQU SW13_IO			,TRISE
.EQU SW13_I_P			,13
.EQU SW13_IO_P			,13
;=======================PIN29 
.EQU V5ADIN_I			,PORTE
.EQU V5ADIN_IO			,TRISE
.EQU V5ADIN_I_P			,14
.EQU V5ADIN_IO_P		,14
;=======================PIN30 ;TP3
.EQU SW14_I			,PORTE
.EQU SW14_IO			,TRISE
.EQU SW14_I_P			,15
.EQU SW14_IO_P			,15
;=======================PIN31 ;TP4
.EQU SW15_I			,PORTA
.EQU SW15_IO			,TRISA
.EQU SW15_I_P			,8
.EQU SW15_IO_P			,8
;=======================PIN32 
.EQU SW16_I			,PORTB
.EQU SW16_IO			,TRISB
.EQU SW16_I_P			,4
.EQU SW16_IO_P			,4
;=======================PIN33 
.EQU SW17_I			,PORTA
.EQU SW17_IO			,TRISA
.EQU SW17_I_P			,4
.EQU SW17_IO_P			,4
;=======================PIN34 
.EQU SW18_I			,PORTA
.EQU SW18_IO			,TRISA
.EQU SW18_I_P			,9
.EQU SW18_IO_P			,9
;=======================PIN35
.EQU SW19_I			,PORTC
.EQU SW19_IO			,TRISC
.EQU SW19_I_P			,3
.EQU SW19_IO_P			,3
;=======================PIN36
.EQU SW20_I			,PORTC
.EQU SW20_IO			,TRISC
.EQU SW20_I_P			,4
.EQU SW20_IO_P			,4
;=======================PIN37 
.EQU SW21_I			,PORTC
.EQU SW21_IO			,TRISC
.EQU SW21_I_P			,5
.EQU SW21_IO_P			,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
;=======================PIN40 	OSC2
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SW22_I			,PORTD
.EQU SW22_IO			,TRISD
.EQU SW22_I_P			,8
.EQU SW22_IO_P			,8
;=======================PIN43
.EQU I2C_SCK_I			,PORTB
.EQU I2C_SCK_O			,LATB
.EQU I2C_SCK_IO			,TRISB
.EQU I2C_SCK_I_P		,5 
.EQU I2C_SCK_O_P		,5 
.EQU I2C_SCK_IO_P		,5 
;=======================PIN44 
.EQU I2C_SDA_I			,PORTB
.EQU I2C_SDA_O			,LATB
.EQU I2C_SDA_IO			,TRISB
.EQU I2C_SDA_I_P		,6 
.EQU I2C_SDA_O_P		,6 
.EQU I2C_SDA_IO_P		,6 
;=======================PIN45
.EQU SW23_I			,PORTC
.EQU SW23_IO			,TRISC
.EQU SW23_I_P			,10
.EQU SW23_IO_P			,10
;=======================PIN46 TP8
.EQU NC46_O			,LATB
.EQU NC46_IO			,TRISB
.EQU NC46_O_P			,7 
.EQU NC46_IO_P			,7 
;=======================PIN47 
.EQU NC47_O			,LATC
.EQU NC47_IO			,TRISC
.EQU NC47_O_P			,13 
.EQU NC47_IO_P			,13 
;=======================PIN48
.EQU NC48_O			,LATB
.EQU NC48_IO			,TRISB
.EQU NC48_O_P			,8 
.EQU NC48_IO_P			,8 
;=======================PIN49
.EQU NC49_O			,LATB
.EQU NC49_IO			,TRISB
.EQU NC49_O_P			,9 
.EQU NC49_IO_P			,9 
;=======================PIN50 
.EQU NC50_O			,LATC
.EQU NC50_IO			,TRISC
.EQU NC50_O_P			,6 
.EQU NC50_IO_P			,6 
;=======================PIN51 
.EQU NC51_O			,LATC
.EQU NC51_IO			,TRISC
.EQU NC51_O_P			,7 
.EQU NC51_IO_P			,7 
;=======================PIN52
.EQU LED_O			,LATC
.EQU LED_IO			,TRISC
.EQU LED_O_P			,8 
.EQU LED_IO_P			,8 
;=======================PIN53
.EQU NC53_O			,LATD
.EQU NC53_IO			,TRISD
.EQU NC53_O_P			,5 
.EQU NC53_IO_P			,5 
;=======================PIN54
.EQU NC54_O			,LATD
.EQU NC54_IO			,TRISD
.EQU NC54_O_P			,6 
.EQU NC54_IO_P			,6 
;=======================PIN55
.EQU NC55_O			,LATC
.EQU NC55_IO			,TRISC
.EQU NC55_O_P			,9 
.EQU NC55_IO_P			,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
.EQU NC58_O			,LATF
.EQU NC58_IO			,TRISF
.EQU NC58_O_P			,0 
.EQU NC58_IO_P			,0 
;=======================PIN59
.EQU NC59_O			,LATF
.EQU NC59_IO			,TRISF
.EQU NC59_O_P			,1 
.EQU NC59_IO_P			,1 
;=======================PIN60
.EQU SEL1_I			,PORTB
.EQU SEL1_IO			,TRISB
.EQU SEL1_I_P			,10
.EQU SEL1_IO_P			,10
;=======================PIN61
.EQU SEL2_I			,PORTB
.EQU SEL2_IO			,TRISB
.EQU SEL2_I_P			,11
.EQU SEL2_IO_P			,11
;=======================PIN62
.EQU SEL3_I			,PORTB
.EQU SEL3_IO			,TRISB
.EQU SEL3_I_P			,12
.EQU SEL3_IO_P			,12
;=======================PIN63
.EQU SEL4_I			,PORTB
.EQU SEL4_IO			,TRISB
.EQU SEL4_I_P			,13
.EQU SEL4_IO_P			,13
;=======================PIN64
.EQU NC64_O			,LATA
.EQU NC64_IO			,TRISA
.EQU NC64_O_P			,10 
.EQU NC64_IO_P			,10 
;======================================================
;==

