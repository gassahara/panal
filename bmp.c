#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#define DATA_OFFSET_OFFSET 0x000A
#define WIDTH_OFFSET 0x0012
#define HEIGHT_OFFSET 0x0016
#define BITS_PER_PIXEL_OFFSET 0x001C

int main() {
        FILE *imageFile = fopen("/home/user/Downloads/imgs/F1.bmp", "rb");
        int dataOffset;
	int height[1];
	int width[1];
	height[0]=0;
	width[0]=0;
	int OFFSETD[1];
	int bytesPerPixel;
        fseek(imageFile, DATA_OFFSET_OFFSET, SEEK_SET);
        fread(&dataOffset, 4, 1, imageFile);
        fseek(imageFile, WIDTH_OFFSET, SEEK_SET);
        fread(width, 4, 1, imageFile);
        fseek(imageFile, HEIGHT_OFFSET, SEEK_SET);
        fread(height, 4, 1, imageFile);
        fseek(imageFile, DATA_OFFSET_OFFSET, SEEK_SET);
        fread(OFFSETD, 4, 1, imageFile);
	while(fmod((float)width[0], 4)!=0) width[0]++;
        int bitsPerPixel[1];
	bitsPerPixel[0]=0;
        fseek(imageFile, BITS_PER_PIXEL_OFFSET, SEEK_SET);
        fread(bitsPerPixel, 2, 1, imageFile);
        bytesPerPixel = (bitsPerPixel[0]) / 8;
        int i = 0;
	unsigned char bb[bytesPerPixel];
	int c=0;
	int d=0;
	char read[4];
	printf("0px 0px #000000");
	fseek(imageFile, OFFSETD[0], SEEK_SET);
        for (i = 1; i <= height[0]; i++) {
	  c=0;
	    fseek(imageFile, OFFSETD[0]+((width[0]*(height[0]-i)*bytesPerPixel)), SEEK_SET);
	  while(c<width[0]) {
	    printf(",");
	    d=bytesPerPixel-1;
	    while(d>=0) {
	      bb[d]=0;
	      d--;
	    }
	    fread(bb, bytesPerPixel, 1, imageFile);
	    printf("%dpx %dpx #", c*10, i*10);
	    d=bytesPerPixel-1;
	    while(d>=0) {
	      printf("%02X", bb[d]);
	      d--;
	    }
	    fflush(stdout);
	    c++;
	  }
        }
        fclose(imageFile);
}
