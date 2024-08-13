#include <stdio.h>
#include <stdint.h>

int main() {
    FILE *ff=fopen("/dev/urandom", "r");
    uint8_t aleatorio;
    fread(&aleatorio, 1, 10, ff);
    
    double longitudcadenaaleatoria = (uint8_t)((uint16_t)aleatorio % 105)+10;
    int letra = 47;
    printf("/*");
    while (longitudcadenaaleatoria >= 0) {
      uint8_t letra;
      while (letra < 2 || letra == 47 || letra == 42 || letra == 127 || letra == 123 || letra == 125 || (char)letra == '/' || (char)letra == '*' || (char)letra == '+' || (char)letra == ';' || (char)letra == '}' || (char)letra == '{') {
	fread(&letra, 1, 10, ff);
      }
      printf("%c", letra);
      longitudcadenaaleatoria--;
      letra = 47;
    }
    fclose(ff);
    printf("*/");
    fflush(stdout);
    return 0;
}
