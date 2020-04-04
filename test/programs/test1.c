//
// PIC12F675 example: blink an LED on pin GP5
// Written by Ted Burke - 18-2-2017
//
// To compile:
//
//    xc8 --chip=12F675 main.c
//
 
#include <xc.h>
 
#pragma config FOSC=INTRCIO,WDTE=OFF,MCLRE=OFF,BOREN=OFF
 
void main(void)
{
    TRISIO = 0b11011111; // Make pin GP5 a digital output
     
    GP5 = 1;         // Set pin GP5 high
    _delay(500000);  // 0.5 second delay
    GP5 = 0;         // Set pin GP5 low
    _delay(500000);  // 0.5 second delay
}
