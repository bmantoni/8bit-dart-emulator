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

void foo() {
    unsigned int y = 12;
    y +=8;
}
 
void main(void)
{
    foo();
}

