#include <8051.h>

int main()
{
    unsigned char i, j;
    unsigned char button = 0;
    unsigned char massiv[11] = {
        0xC0, 
        0xF9, 
        0xA4, 
        0xB0, 
        0x99, 
        0x92, 
        0x82, 
        0xF8, 
        0x80, 
        0x90, 
        0xFF  
    };
    unsigned char k = 0;

    P1 = massiv[10]; 

    while (1) {
        
        if ((P3 & 0x02) == 0) { 
            button = 1;
        } else {
            button = 0;
        }

        if (button == 0) { 
            for (i = 0; i < 10; i++) {
                P2 = massiv[i]; 
                for (j = 0; j < 100; j++)
                    ;
            }
        } else { 
            P2 = massiv[k]; 
            k = (k + 3) % 10; 
            for (j = 0; j < 100; j++)
                ;
        }
    }
    return 0;
}