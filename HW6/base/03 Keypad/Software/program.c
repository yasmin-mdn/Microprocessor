#include <mega32.h>
#include <alcd.h>
#include <delay.h>      
#include <stdlib.h>

#define KEYPAD_R1 PORTD.0
#define KEYPAD_R2 PORTD.1
#define KEYPAD_R3 PORTD.2
#define KEYPAD_R4 PORTD.3
#define KEYPAD_C1 PIND.4
#define KEYPAD_C2 PIND.5
#define KEYPAD_C3 PIND.6
#define KEYPAD_C4 PIND.7

#define KEYPAD_NUM0 0
#define KEYPAD_NUM1 1
#define KEYPAD_NUM2 2
#define KEYPAD_NUM3 3
#define KEYPAD_NUM4 4
#define KEYPAD_NUM5 5
#define KEYPAD_NUM6 6
#define KEYPAD_NUM7 7
#define KEYPAD_NUM8 8
#define KEYPAD_NUM9 9

unsigned char keypad_scan();

float number[3];
int counter = 0;

void main(void) {
    unsigned char key_res;
    DDRC = 0xFF;
    DDRD = 0x0F;
    PORTC = 0x00;

    lcd_init(16);
    lcd_clear();

    while (1) {
        key_res = keypad_scan();
        
        if (key_res != 255) {
            while (keypad_scan() != 255);
            delay_ms(20);
            lcd_putchar(key_res + 48);
            number[counter] *= 10;
            number[counter] += key_res;   
        }
    }
}


unsigned char keypad_scan() {
    unsigned char result = 255;

    ////////////////////////  ROW1 ////////////////////////
    KEYPAD_R1 = 1;
    KEYPAD_R2 = 0; 
    KEYPAD_R3 = 0; 
    KEYPAD_R4 = 0;
    
    delay_ms(5);
    if (KEYPAD_C1)
        result = KEYPAD_NUM7;
    else if (KEYPAD_C2)
        result = KEYPAD_NUM8;
    else if (KEYPAD_C3)
        result = KEYPAD_NUM9;

    ////////////////////////  ROW2 ////////////////////////
    KEYPAD_R1 = 0;
    KEYPAD_R2 = 1; 
    KEYPAD_R3 = 0;
    KEYPAD_R4 = 0;
    
    delay_ms(5);
    if (KEYPAD_C1)
        result = KEYPAD_NUM4;
    else if (KEYPAD_C2)
        result = KEYPAD_NUM5;
    else if (KEYPAD_C3)
        result = KEYPAD_NUM6;

    ////////////////////////  ROW3 ////////////////////////
    KEYPAD_R1 = 0;
    KEYPAD_R2 = 0;
    KEYPAD_R3 = 1;
    KEYPAD_R4 = 0;
    
    delay_ms(5);
    if (KEYPAD_C1)
        result = KEYPAD_NUM1;
    else if (KEYPAD_C2)
        result = KEYPAD_NUM2;
    else if (KEYPAD_C3)
        result = KEYPAD_NUM3;

    ////////////////////////  ROW4 ////////////////////////
    KEYPAD_R1 = 0;
    KEYPAD_R2 = 0;
    KEYPAD_R3 = 0;
    KEYPAD_R4 = 1;
    
    delay_ms(5);
    if (KEYPAD_C2)
        result = KEYPAD_NUM0;

    return result;
}
