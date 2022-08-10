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
	int bytesPerPixel;
	int OFFSETD[1];
        fseek(imageFile, DATA_OFFSET_OFFSET, SEEK_SET);
        fread(&dataOffset, 4, 1, imageFile);
        fseek(imageFile, WIDTH_OFFSET, SEEK_SET);
        fread(width, 4, 1, imageFile);
        fseek(imageFile, HEIGHT_OFFSET, SEEK_SET);
        fread(height, 4, 1, imageFile);
        int bitsPerPixel[1];
	bitsPerPixel[0]=0;
        fseek(imageFile, BITS_PER_PIXEL_OFFSET, SEEK_SET);
        fread(bitsPerPixel, 2, 1, imageFile);
        bytesPerPixel = (bitsPerPixel[0]) / 8;
        fseek(imageFile, DATA_OFFSET_OFFSET, SEEK_SET);
        fread(OFFSETD, 4, 1, imageFile);
        int i = 0;
	unsigned char bb[bytesPerPixel];
	int c=0;
	printf("0px 0px red");
	fseek(imageFile, OFFSETD[0], SEEK_SET);
        for (i = 1; i <= height[0]; i++) {
	  c=0;
	    while(c<=width[0]) {
	      printf(",");
		fread(bb, bytesPerPixel, 1, imageFile);
		printf("%dpx %dpx red", c*100, i*100);
		fflush(stdout);
		c++;
	    }
        }
        fclose(imageFile);
}
