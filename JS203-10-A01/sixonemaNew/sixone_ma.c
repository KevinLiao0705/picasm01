#include <xc.h>		
#include "evm_lcd.h"		
#include <stdio.h>
#include <stdlib.h>
#include <usart.h>
#include<timers.h>
#include <spi.h>
#include <portb.h>		// for interrupt RB0~RB3
#include <delays.h>
#include<string.h>
#include<math.h>

#pragma config OSC = INTIO67
#pragma config WDT = OFF
#pragma config LVP = OFF
#define OSC_CLOCK 8
#define CPU_SPEED OSC_CLOCK/4

#define FIRMWARE_VERSION 9
#define DEBUG 0

#define OPCODE_LCD_GET 0xA0
#define OPCODE_LCD_SET 0xA1
#define OPCODE_LED_GET 0xA2
#define OPCODE_LED_SET 0xA3
#define OPCODE_BUTTON_CLICK 0xA4

#define EN1 PORTEbits.RE0
#define EN2 PORTEbits.RE1
#define EN3 PORTEbits.RE2
#define EN4 PORTEbits.RE3
#define EN5 PORTEbits.RE4
#define EN6 PORTEbits.RE5
#define EN7 PORTEbits.RE6
#define EN8 PORTEbits.RE7
#define EN9 PORTHbits.RH2
#define EN10 PORTHbits.RH3

#define TRIG1 PORTHbits.RH0
#define TRIG2 PORTHbits.RH1

#define P1_CS PORTBbits.RB0
#define P1_RS PORTBbits.RB2
#define P1_CS_IF INTCONbits.INT0IF
#define P1_RS_IF INTCON3bits.INT2IF

#define KID_M1 0
#define KID_NUM1 1
#define KID_NUM2 2
#define KID_NUM3 3
#define KID_M2 4
#define KID_NUM4 5
#define KID_NUM5 6
#define KID_NUM6 7
#define KID_M3 8
#define KID_NUM7 9
#define KID_NUM8 10
#define KID_NUM9 11
#define KID_M4 12
#define KID_STAR 13
#define KID_NUM0 14
#define KID_SHARP 15
#define KID_HANDSET 16
#define KID_TRIANGLE 17
#define KID_HANDFREE_ON 18
#define KID_HANDFREE_OFF 19
#define KID_OK 20
#define KID_MUTE 21
#define KID_VOLDOWN 22
#define KID_VOLUP 23
#define KID_UP 24
#define KID_LEFT 25
#define KID_DOWN 26
#define KID_RIGHT 27
#define KID_MODE 28
#define KID_INFO 29
#define KID_LIGHT 30
#define KID_BOOK 31
#define KID_PTT 32
#define KID_PTT_RESET 33
#define MAX_KID KID_PTT_RESET
unsigned char b_phone_presse=0;

#define PKTIN_SIZE 100 // 0xFA 0xCE LCDDATA(20)  CHECKSUM
#define PKTOUT_SIZE 24 //(2+20+1)
#define  STATE_DELAY() delay_xus(10);


unsigned char b_pkt_in_done;
unsigned char pkt_in[PKTIN_SIZE];
unsigned char pkt_out[PKTOUT_SIZE];
unsigned int ipkt;
unsigned char state_pkt;
unsigned int swtmr0_1s_pktsend = 0, swtmr0_1s_pktrecv = 0;
unsigned char b_ovf_swtmr0_1s_pktsend = 0, b_ovf_swtmr0_1s_pktrecv = 0;
int debug[10]={0};

unsigned char LCD_state=0;
unsigned char lcd_data=0;
int size_buffer=0;
#define LCD_DIM_WIDTH 20
unsigned char lcd_buffer[LCD_DIM_WIDTH+1]={0};//20+1
unsigned char led_buffer[4]={0};
const unsigned char bScanLCD=1;
unsigned char bLCDBufferFull=0;
unsigned char bLcdChanged =0;
unsigned int lcd_index=0;
unsigned char kid=0xFF,kid_pre=0xFF;
unsigned char EN1_stored=1,EN2_stored=1,EN3_stored=1,EN4_stored=1;
unsigned char bPhonePressed=1;

void delay_xus(long A);
void delay_xms(long A);
void delay_xs(long A);
void enable_high_priority_interrupt();
void external_interrupt_init();
void unitest_interrupt();
void unitest_timer0_polling(void);
void unitest_timer0_interrupt(void);
void button_click(unsigned char kid);

void buffering_lcd(unsigned char data){
   // sprintf(lcd_buffer,"0123456789012345678");
    if(data==0x80){
        lcd_index=0;
        memset(lcd_buffer,0,sizeof(lcd_buffer));
    }
    else{
        if( lcd_index < LCD_DIM_WIDTH ){
            lcd_buffer[lcd_index++]=data; 
            if(lcd_index >= LCD_DIM_WIDTH ){
               lcd_buffer[sizeof(lcd_buffer)-1]='\0';
               lcd_index = 0;
               bLCDBufferFull=1;
            }
        }
    }
    
    
     
}



void interrupt high_priority high_isr (void)
{
   
    if(bScanLCD){
        
        if(P1_RS_IF){
          P1_RS_IF=0;
          LCD_state=0;
        }

        if(P1_CS_IF){
           P1_CS_IF=0;
           if(P1_CS==0){
               EN1_stored = EN1;
               EN2_stored = EN2;
               EN3_stored = EN3;
               EN4_stored = EN4;
               EN1=EN2=EN3=EN4=1;
               
               switch(LCD_state){
                  case 0:
                      TRISD=0xFF;
                      EN8=0;
                      lcd_data=0;
                      lcd_data |= ( (PORTDbits.RD7<<7) | (PORTDbits.RD6<<6) | ( PORTDbits.RD5<<5 ) | (PORTDbits.RD4<<4) );
                      EN8=1;
                      LCD_state=1;
                      TRISD=0x00;
                      break;
                  case 1:
                      TRISD=0xFF;
                      EN8=0;
                      lcd_data |= ( (PORTDbits.RD7<<3) | (PORTDbits.RD6<<2) | (PORTDbits.RD5<<1) | (PORTDbits.RD4<<0));
                      EN8=1;
                      
                      TRISD=0x00;
                      
                      buffering_lcd(lcd_data);
                      LCD_state=0;
                      bLcdChanged=1; 
               
                      break;
                }
               
                EN1 = EN1_stored;
                EN2 = EN2_stored;
                EN3 = EN3_stored;
                EN4 = EN4_stored;

 
           }      

        }
    }
    
   
    
     
}

void interrupt low_priority low_isr(void) 
{
    if(INTCONbits.TMR0IF)   
    {
       INTCONbits.TMR0IF=0;
       WriteTimer0(0xffff-62500); // 2M/32=62500
       //PORTE^=2;
    }

}



int pkt_send(unsigned char *pkt,unsigned int size_pkt);
int pkt_in_check();
unsigned char checksum_gen(unsigned char *data,int size);
unsigned char btn_scan();


unsigned int count=0;

unsigned char checksum_gen(unsigned char *data,int size){
    int i;
    unsigned char checksum=0;
    for(i=0;i<size;i++){
        checksum ^= data[i];
    }
    return checksum;
}


int pkt_send(unsigned char pkt[],unsigned int size_pkt){
    unsigned int i=0;    
    pkt[0]=0xFA;
    pkt[1]=0xCE; 
    pkt[size_pkt-1]=0;
    for(i=0;i<size_pkt-1;i++)
             pkt[size_pkt-1]^=pkt[i];
       
    for(i=0;i<size_pkt;i++)
    {
        
        Write2USART(pkt[i]);
        //while( Busy2USART());

        while(1){
           if(Busy2USART()){
              if(b_ovf_swtmr0_1s_pktsend)
              {
                 b_ovf_swtmr0_1s_pktsend=0; 
                 break;
              }
		   }
           else{
               b_ovf_swtmr0_1s_pktsend=0;
               break;
           }
        }


        
                       
    }
}





int uvm_spi1_recv(unsigned char pkt[],unsigned int size){
    unsigned int i=0;    
    unsigned char checksum=0;
    pkt[0]=0xFA;
    pkt[1]=0xCE; 
    pkt[size-1]=0;
    
    if(ReadSPI1()==0xFA){
        if(ReadSPI1()==0xCE){
            for(i=0;i< size-2;i++)
            {     
                pkt[i]=ReadSPI1();  
            }
            
            checksum=0;
            for(i=0;i<size-1;i++){
               checksum^=pkt_in[i]; 
            }
            
            if(checksum==pkt_in[size-1]){
                return 1;
            }
            else{
                return 0;
            }
        }
        else{
            return 0;
        }
    }
    else{
        return 0;
    }
  
}


void button_press(unsigned char kid){
    TRISD=0;
    PORTD=0;
    switch(kid){
    case KID_HANDSET :
        bPhonePressed=1;
        PORTDbits.RD7=1; EN4=0; TRIG1=1; TRIG1=0; EN4=1;
        break;
    default:
        ;
    }
    
    TRISD=0xFF;

}


void button_click(unsigned char kid){
    TRISD=0;
    PORTD=0;
    
    
    switch(kid){
    case KID_M1 :
        PORTDbits.RD2=1; EN2=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD2=0; TRIG1=1; TRIG1=0; EN2=1;
        break;
    case KID_NUM1 :
        PORTDbits.RD1=1; EN1=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD1=0; TRIG1=1; TRIG1=0; EN1=1;
        break;
    case KID_NUM2 :
        PORTDbits.RD2=1; EN1=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD2=0; TRIG1=1; TRIG1=0; EN1=1;
        break;
    case KID_NUM3 :
        PORTDbits.RD3=1; EN1=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD3=0; TRIG1=1; TRIG1=0; EN1=1;      
        break;
    case KID_M2 :
        PORTDbits.RD3=1; EN2=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD3=0; TRIG1=1; TRIG1=0; EN2=1;
        break;
    case KID_NUM4 :
        PORTDbits.RD4=1; EN1=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD4=0; TRIG1=1; TRIG1=0; EN1=1;
        break;
    case KID_NUM5 :
        PORTDbits.RD5=1; EN1=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD5=0; TRIG1=1; TRIG1=0; EN1=1;
        break;
    case KID_NUM6 :
        PORTDbits.RD6=1; EN1=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD6=0; TRIG1=1; TRIG1=0; EN1=1;
        break;
    case KID_M3 :
        PORTDbits.RD4=1; EN2=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD4=0; TRIG1=1; TRIG1=0; EN2=1;        
        break;
    case KID_NUM7 :
        PORTDbits.RD7=1; EN1=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD7=0; TRIG1=1; TRIG1=0; EN1=1;
        break;
    case KID_NUM8 :
        PORTDbits.RD0=1; EN2=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD0=0; TRIG1=1; TRIG1=0; EN2=1;
        break;
    case KID_NUM9 :
        PORTDbits.RD1=1; EN2=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD1=0; TRIG1=1; TRIG1=0; EN2=1;
        break;
    case KID_M4 :
        PORTDbits.RD5=1; EN2=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD5=0; TRIG1=1; TRIG1=0; EN2=1;        
        break;
    case KID_STAR :
        PORTDbits.RD7=bPhonePressed; // special process for EN4 BUS    
        PORTDbits.RD0=1; EN4=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD0=0; TRIG1=1; TRIG1=0; EN4=1;
        break;
    case KID_NUM0 :
        PORTDbits.RD0=1; EN1=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD0=0; TRIG1=1; TRIG1=0; EN1=1;
        break;
    case KID_SHARP :
         PORTDbits.RD7=bPhonePressed; // special process for EN4 BUS
        PORTDbits.RD1=1; EN4=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD1=0; TRIG1=1; TRIG1=0; EN4=1;
        break;
    case KID_HANDSET :
        
        if(!bPhonePressed){
            bPhonePressed=1;
            PORTDbits.RD7=1; EN4=0; TRIG1=1; TRIG1=0; EN4=1;
        }
        else{
            bPhonePressed=0;
            PORTDbits.RD7=0; EN4=0; TRIG1=1; TRIG1=0; EN4=1;
        }

        break;
    case KID_TRIANGLE :
        PORTDbits.RD7=bPhonePressed; // special process for EN4 BUS
        PORTDbits.RD6=1; EN4=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD6=0; TRIG1=1; TRIG1=0; EN4=1;
        break;
    case KID_HANDFREE_ON :
         PORTDbits.RD7=bPhonePressed; // special process for EN4 BUS
        PORTDbits.RD3=1; EN4=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD3=0; TRIG1=1; TRIG1=0; EN4=1; 
        break;
    case KID_HANDFREE_OFF :
         
        PORTDbits.RD6=1; EN3=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD6=0; TRIG1=1; TRIG1=0; EN3=1;     
        
        break;
    case KID_OK :
        PORTDbits.RD7=1; EN3=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD7=0; TRIG1=1; TRIG1=0; EN3=1;
        break;
    case KID_MUTE :
        PORTDbits.RD0=1; EN3=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD0=0; TRIG1=1; TRIG1=0; EN3=1;
        break;
    case KID_VOLDOWN :
        PORTDbits.RD2=1; EN3=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD2=0; TRIG1=1; TRIG1=0; EN3=1;
        break;
    case KID_VOLUP :
        PORTDbits.RD1=1; EN3=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD1=0; TRIG1=1; TRIG1=0; EN3=1;
        break;
    case KID_UP :
        PORTDbits.RD3=1; EN3=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD3=0; TRIG1=1; TRIG1=0; EN1=3;
        break;
    case KID_LEFT :
        PORTDbits.RD7=bPhonePressed; // special process for EN4 BUS
        PORTDbits.RD4=1; EN4=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD4=0; TRIG1=1; TRIG1=0; EN4=1;
        break;
    case KID_DOWN :
        PORTDbits.RD4=1; EN3=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD4=0; TRIG1=1; TRIG1=0; EN1=3;
        break;
    case KID_RIGHT :
        // no corresponding key on the sip phone
        break;
    case KID_MODE :
        // no corresponding key on the sip phone
        break;
    case KID_INFO :
         PORTDbits.RD7=bPhonePressed; // special process for EN4 BUS
        PORTDbits.RD5=1; EN4=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD5=0; TRIG1=1; TRIG1=0; EN4=1;
        break;
    case KID_LIGHT :
         // no corresponding key on the sip phone
        break;
    case KID_BOOK :
         PORTDbits.RD7=bPhonePressed; // special process for EN4 BUS
         PORTDbits.RD2=1; EN4=0; TRIG1=1; TRIG1=0; delay_xms(50);
        PORTDbits.RD2=0; TRIG1=1; TRIG1=0; EN4=1;
        break;
    default :
         ;   
    }
    
    
     
    
    
   
    TRISD=0xFF;
    
    
}




int pkt_in_check(){
     unsigned  char checksum=0;
     unsigned int i=0;debug[5]++;
     if(b_pkt_in_done){
         b_pkt_in_done=0;
         checksum=0;
         for(i=0;i<sizeof(pkt_in)-1;i++)
             checksum^=pkt_in[i]; 
    
	     if(checksum==pkt_in[PKTIN_SIZE-1]){
                  debug[6]++;
	           return 1;
	     }
	     else{
                   debug[7]++;
	           return 0;
	     }
     }
     else
     {
         return 0;
     }
}







unsigned int page=0;
char str_LCD_L1[40]={0};
char str_LCD_L2[40]={0};
char str_LCD_L1_pre[40]={0};
char str_LCD_L2_pre[40]={0};
unsigned int count_case0=0,count_case1=0;












/*
void lcd1_scan(){
	switch(LCD1_state){
		case 0:
			//Serial1.println("E rising 1");
			lcd1_data=0;
			IO_LOW(EN8);
			delay_us(5);
			lcd1_data |= ( (IO_READ(D7)<<7) | (IO_READ(D6)<<6) | (IO_READ(D5)<<5) | (IO_READ(D4)<<4));
			delay_us(5);
			IO_HIGH(EN8);
			LCD1_state=1;
			break;
		case 1:
			IO_LOW(EN8); 
			delay_us(5);
			lcd1_data |= ( (IO_READ(D7)<<3) | (IO_READ(D6)<<2) | (IO_READ(D5)<<1) | (IO_READ(D4)<<0));
			delay_us(5);
			IO_HIGH(EN8);
			pkt_out[0]=1;
			pkt_out[1]=lcd1_data;
			pkt_out[2]=0;
			pkt_send(pkt_out,sizeof(pkt_out));
			
			LCD1_state=0;
			break;
			
		}

	
}
*/
void enable_high_priority_interrupt(void){
    RCONbits.IPEN = 1;
    INTCONbits.GIEH = 1 ;
}

void external_interrupt_init(void){
    OpenRB0INT(PORTB_CHANGE_INT_ON & PORTB_PULLUPS_ON  & FALLING_EDGE_INT );//LCD-CS
    OpenRB2INT(PORTB_CHANGE_INT_ON & PORTB_PULLUPS_ON &  RISING_EDGE_INT & PORTB_INT_PRIO_HIGH );//LCD-RS
}



unsigned char switcher_scan(void){
	unsigned char i=0,j=0;
	for(i=0;i<4;i++){
		PORTH = ( PORTH & 0xF0 ) | 0x0F;
		PORTH =  PORTH &( ~ ( 1 << i) ); 
		//delay_xms(10);
		for(j=0;j<5;j++){
				if (  (PORTG & (1<<j)) == 0 ) {						
						return 5*i+j;				
				}			
		}
	}
	PORTH = 0xFF;
	return 40;
}


void delay_xus(long A) {
//This function is only good for OSC_CLOCK higher than 4MHz
	long i;
	for(i=0;i<A;i++) {
         Delay1TCY();		
         Delay1TCY();		
	}
}



void delay_xms(long A) {
//This function is only good for OSC_CLOCK higher than 4MHz
	long i;
	for(i=0;i<A;i++) Delay1KTCYx((CPU_SPEED));		
}

void delay_xs(long A) {
//This function is only good for OSC_CLOCK higher than 4MHz
	long i;
	for(i=0;i<A;i++) Delay10KTCYx(100*(CPU_SPEED));		
}

unsigned char SPI1_PutRead(unsigned char valueToBeRead){
    SSP1BUF =  valueToBeRead;
    while(SSP1IF);
    SSP1IF=0;
    return SSP1BUF;
}



void sixone_ma()
{
  unsigned char spi_pkt[24]={0};// 0xFA(1) 0xCE(1) opcode(1) data(20) Checksum(1)
  unsigned char spi_buffer[100]={0};// 0xFA(1) 0xCE(1) opcode(1) data(20) Checksum(1)
  unsigned char led_buffer[4]={0};
  unsigned char tmp,opcode,data;
  unsigned long int timer_ms_button=0;
  int i;
  int state=0;
  unsigned char checksum=0,opcode=0;
  unsigned char counterPTT=0;
  OSCCON = (OSCCON&0b10001111)|0b01110000 ; // Fosc = 8MHz Fcy=2MHz Tcy=0.5us
  external_interrupt_init();
  enable_high_priority_interrupt();
  TRISB|=0x0F;
  OpenSPI1( SLV_SSOFF, MODE_00, SMPEND); // if OSCCON is configured as Fosc=8MHz, the Fspi = 8MHz/4 = 2MHz
    
     // initial enable and  trigger pins.
  TRISE=0;
  TRISH&=0b11110000;
  PORTE=0xff;
  EN9=1;
  EN10=1;
  TRIG1=0;
  TRIG2=0;

    // initial button bus.
  TRISD=0;
    
  PORTD=0; EN1=0;  TRIG1=1;  TRIG1=0; EN1=1; 
  PORTD=0; EN2=0; TRIG1=1; TRIG1=0; EN2=1;
  PORTD=0; EN3=0; TRIG1=1; TRIG1=0; EN3=1;
  PORTD=0; EN4=0; TRIG1=1; TRIG1=0; EN4=1;
  PORTDbits.RD7=1; EN4=0; TRIG1=1; TRIG1=0; EN4=1;
  TRISD=0xFF;
    
  TRISCbits.TRISC6=0;
    

    //while(1)WriteSPI1(ReadSPI1()+1);
    
  while(1)
  {
    opcode=ReadSPI1();
    switch(opcode)
    {
      case OPCODE_LCD_GET:  
         memcpy(spi_buffer,                   lcd_buffer, sizeof(lcd_buffer));
         memcpy(spi_buffer+sizeof(lcd_buffer),led_buffer, sizeof(led_buffer));
         for(i=0;i<(sizeof(lcd_buffer)+sizeof(led_buffer));i++)
	 {
           //spi_buffer[i]=i;
           WriteSPI1(spi_buffer[i]);
           spi_buffer[i]=SSP1BUF;
         }
         if( (spi_buffer[0] == spi_buffer[1]) && (spi_buffer[1] == spi_buffer[2]) )
	 {
           kid = spi_buffer[0];
         }
         if( kid!=kid_pre )
         {
           if(  (kid>=0) && (kid<=MAX_KID) )
	   {
             switch(kid)
	     {
               case KID_HANDFREE_ON:
                 TRISD=0xFF;
                 EN7=0;  delay_xus(1);led_buffer[2]=PORTD;  EN7=1;
                 if( (led_buffer[2]&0x02) == 0x02  )
	 	 { // Phone-LED low with level is in light status
                   button_press(KID_HANDSET);
                 } 
                 button_click(kid);
                 break;
                                    
               case KID_HANDFREE_OFF:
                 button_click(kid); 
                 // Auto-go-on-hook :  If LED is dark, then go on hook automatically.
                 TRISD=0xFF;
                 EN7=0;  delay_xus(1);led_buffer[2]=PORTD;  EN7=1;
                 if( (led_buffer[2]&0x02)==0  )
		 { // Phone-LED low with level is in light status
                   button_press(KID_HANDSET);
                 } 
                                    
                 break;
                                    
               case KID_PTT:
                 button_click(KID_M1);
                 delay_xms(350);
                 if((++counterPTT)&0x01)
		 {
                   button_click(KID_NUM4);
                 }
                 else
		 {
                   button_click(KID_NUM5);
                 }
                 delay_xms(350);
                 button_click(KID_M1);
                 break;
                                    
               case KID_PTT_RESET:
                 counterPTT=0;
                 delay_xms(1000);
                                
                 break;
               default:
                 button_click(kid); 
                                   
             }
           }
           else
	   {
             kid=0xFF;
           }
           kid_pre = kid ;
         }
 
 
                    break;
                default:
                    ;
            }
            
            
            TRISD=0xFF;
            EN10=0; delay_xus(1);led_buffer[0]=~PORTD;  EN10=1;
            EN9=0;  delay_xus(1);led_buffer[1]=~PORTD;  EN9=1;
             
            EN7=0;  delay_xus(1);led_buffer[2]=PORTD;  EN7=1;
            EN8=0;  delay_xus(1);led_buffer[3]=PORTD;  EN8=1;
            
            if(counterPTT&0x01){
                led_buffer[2] |= 0x01 ;           
            }
            else{
                led_buffer[2] &= (~0x01);           
            }
             
            
            
            
           
            // remember to add LED19 scan in the near future
            

             //delay_xms(1);
            
                
    }

    
}


void main() {
   sixone_ma();
}