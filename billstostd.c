#include <stdio.h>
#include <stdint.h>
#include <time.h>

char tokensDirplusFilename[46]="/root/panal/users/tokens/";
char filename[21];
FILE *ff;
unsigned long uid1=0;
unsigned long uid2=0;
unsigned long uid3=0;
unsigned long uid4=0;
time_t unixtime=0;
long timestamp = 0;

int aleatorio(char *charArray) {
    FILE *ffo=fopen("/dev/urandom", "r");
    uint16_t aleatorio;
    fread(&aleatorio, sizeof(aleatorio), 1, ffo);
    uint8_t longitudcadenaaleatoria = (uint8_t)((uint16_t)aleatorio % 90)+10;
    uint8_t letra = 47;
    int c=0;
    charArray[c]='/';
    charArray[c+1]='*';
    c=2;
    while (longitudcadenaaleatoria >= 0) {
      while (letra < 2 || letra == 47 || letra == 42 || letra == 127 || letra == 123 || letra == 125 || (char)letra == '/' || (char)letra == '*' || (char)letra == '+' || (char)letra == ';' || (char)letra == '}' || (char)letra == '{') {
	fread(&letra, sizeof(letra), 1, ffo);
	fread(&letra, sizeof(letra), 1, ffo);
	fread(&letra, sizeof(letra), 1, ffo);
	fread(&letra, sizeof(letra), 1, ffo);
      }
      charArray[c]=(unsigned char)letra;
      c=c+1;
      letra = 47;
      longitudcadenaaleatoria=longitudcadenaaleatoria-1;
      if(longitudcadenaaleatoria == 0) break;
    }
    fclose(ffo);
    charArray[c]='*';
    charArray[c+1]='/';
    charArray[c+2]=0;
    return 0;
}


int writeToken(long ammount) {
    int l=0;
    unsigned char c=0;
    char continua=1;
    while (continua) {
      l=0;
      while (l<sizeof(filename)-1) {
	filename[l]=0;
	l++;
      }
      l=0;
      uint8_t letra=47;
      char low = 0;
      char high = 0;
      while (l<sizeof(filename)-1) {
	ff=fopen("/dev/urandom", "r");
	fread(&letra, 1, 1, ff);
	fclose(ff);
	low = (letra & 0x0F)+0x41;
	high = ((letra >> 4) & 0x0F)+0x41;
	filename[l]=high;
	filename[l+1]=low;
	fflush(stdout);
	l=l+2;
	letra = 47;
      }
      filename[l]=0;
      c=0;
      unsigned char m=sizeof(tokensDirplusFilename)-sizeof(filename);
      while(m+c<sizeof(tokensDirplusFilename) && filename[c]!=0) {
	if(filename[c]!=0) tokensDirplusFilename[m+c]=filename[c];
	c=c+1;
      }      
      tokensDirplusFilename[m+c]='.';
      tokensDirplusFilename[m+c+1]='c';
      tokensDirplusFilename[m+c+2]=0;
      ff = fopen(tokensDirplusFilename, "r");
      if(ff!=NULL) continua=1;
      else continua=0;
    }
    printf("/*%s*/", tokensDirplusFilename);
    fflush(stdout);
    ff=fopen("/dev/urandom", "r");
    fread(&uid1, sizeof(uid1), 1, ff);
    fclose(ff);
    ff=fopen("/dev/urandom", "r");
    fread(&uid2, sizeof(uid2), 1, ff);
    fclose(ff);
    ff=fopen("/dev/urandom", "r");
    fread(&uid3, sizeof(uid3), 1, ff);
    fclose(ff);
    ff=fopen("/dev/urandom", "r");
    fread(&uid4, sizeof(uid4), 1, ff);
    fclose(ff);
    unsigned char charArray[110];
    aleatorio(charArray);
    ff = fopen(tokensDirplusFilename, "w");
    c=0;
    while (c<110 && charArray[c]!=0) {
      fwrite(charArray+c, 1, 1, ff);
      fwrite(charArray+c, 1, 1, stdout);
      c++;
    }
    fprintf(ff, "int main() { ");
    fprintf(stdout, "int main() { ");
    aleatorio(charArray);
    c=0;
    while (c<110 && charArray[c]!=0) {
      fwrite(charArray+c, 1, 1, ff);
      fwrite(charArray+c, 1, 1, stdout);
      c++;
    }
    fprintf(ff, "char fname[%ld]=\"%s\"; ", sizeof(filename), filename);
    fprintf(stdout, "char fname[%ld]=\"%s\"; ", sizeof(filename), filename);
    aleatorio(charArray);
    c=0;
    while (c<110 && charArray[c]!=0) {
      fwrite(charArray+c, 1, 1, ff);
      fwrite(charArray+c, 1, 1, stdout);
      c++;
    }
    unixtime = time(NULL);
    timestamp = (long) unixtime;
    fprintf(ff, "long date=%ld; ", timestamp);
    fprintf(stdout, "long date=%ld; ", timestamp);
    aleatorio(charArray);
    c=0;
    while (c<110 && charArray[c]!=0) {
      fwrite(charArray+c, 1, 1, ff);
      fwrite(charArray+c, 1, 1, stdout);
      c++;
    }
    unixtime = time(NULL);
    timestamp = (long) unixtime;
    fprintf(ff, "long uid1=0x%lX; ", uid1);
    fprintf(stdout, "long uid1=0x%lX; ", uid1);

    aleatorio(charArray);
    c=0;
    while (c<110 && charArray[c]!=0) {
      fwrite(charArray+c, 1, 1, ff);
      fwrite(charArray+c, 1, 1, stdout);
      c++;
    }
    unixtime = time(NULL);
    timestamp = (long) unixtime;
    fprintf(ff, "long uid2=0x%lX; ", uid2);
    fprintf(stdout, "long uid2=0x%lX; ", uid2);
    
    aleatorio(charArray);
    c=0;
    while (c<110 && charArray[c]!=0) {
      fwrite(charArray+c, 1, 1, ff);
      fwrite(charArray+c, 1, 1, stdout);
      c++;
    }
    unixtime = time(NULL);
    timestamp = (long) unixtime;
    fprintf(ff, "long uid3=0x%lX; ", uid3);
    fprintf(stdout, "long uid3=0x%lX; ", uid3);

    aleatorio(charArray);
    c=0;
    while (c<110 && charArray[c]!=0) {
      fwrite(charArray+c, 1, 1, ff);
      fwrite(charArray+c, 1, 1, stdout);
      c++;
    }
    unixtime = time(NULL);
    timestamp = (long) unixtime;
    fprintf(ff, "long uid4=0x%lX; ", uid4);
    fprintf(stdout, "long uid4=0x%lX; ", uid4);
    fprintf(ff, "long ammount=%ld; ", ammount);
    fprintf(stdout, "long ammount=%ld; ", ammount);
    fprintf(ff, "}\n");
    fprintf(stdout, "}\n");
    fclose(ff);
    fflush(stdout);
    return 0;
}

int main() {
    const long bsize=28;    
    long boxes[28] = {1000000, 500000, 250000, 200000, 125000, 100000, 50000, 25000, 20000, 12500, 10000, 5000, 2500, 2000, 1250, 1000, 500, 250, 200, 125, 100, 50, 25, 20, 10, 5, 2, 1};
    long num_pellets = 333333;
    int i = 0, j;
    for (j = bsize-1; j >=0; j--) {
      i=0;
      while (num_pellets > 0 && num_pellets >= boxes[j] && i < 10) {
	if(num_pellets<boxes[j]) break;
	//	printf("%ld,", boxes[j]);
	writeToken(boxes[j]);
	fflush(stdout);
	num_pellets -= boxes[j];
	i++;
      }
    }
    for (j = 0; j < bsize && num_pellets>0; j++) {
      while (num_pellets > 0 && num_pellets >= boxes[j]) {
	//	printf("%ld,", boxes[j]);
	writeToken(boxes[j]);
	num_pellets -= boxes[j];
      }
    }
    printf("0\n");
    return 0;
}
