#ifndef _evm_LCD_h
#define _evm_LCD_h

#define DISP_2Line_8Bit	0b00111000
#define DISP_2Line_4Bit	0b00101000
#define RETURN_HOME     0b00000011
#define DISP_ON			0x0C		// Display on
#define DISP_ON_C		0x0E		// Display on, Cursor on
#define DISP_ON_B		0x0F		// Display on, Cursor on, Blink cursor
#define DISP_OFF		0x08		// Display off
#define CLR_DISP		0x01		// Clear the Display
#define CUR_S_R	     	0b00010100		//
#define CUR_S_L		    0b00010000		//
#define DISP_S_R		0b00011100   	//
#define DISP_S_L		0b00011000		//
#define RAM_INCR_DISP_S		  0b00000111		// Least Significant 7-bit are for address
#define RAM_DECR_DISP_S		  0b00000101		// Upper Left coner of the Display	
#define RAM_INCR_DISP_NOS     0b00000110
#define RAM_DECR_DISP_NOS     0b00000100


void OpenLCD(void);

void WriteCmdLCD( unsigned char LCD_CMD);

void WriteDataLCD( unsigned char LCD_CMD);

void putcLCD(unsigned char LCD_Char);

void LCD_CMD_W_Timing( void );

void LCD_DAT_W_Timing( void );

void LCD_Set_Cursor(unsigned char CurY, unsigned char CurX);



void putsLCD( char *Str);

void puthexLCD(unsigned char HEX_Val);

void LCD_L_Delay(void);

void LCD_S_Delay(void);


#endif
