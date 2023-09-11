#include <stdio.h>

int main() {
    const long bsize=28;
    long boxes[28] = {1000000, 500000, 250000, 200000, 125000, 100000, 50000, 25000, 20000, 12500, 10000, 5000, 2500, 2000, 1250, 1000, 500, 250, 200, 125, 100, 50, 25, 20, 10, 5, 2, 1};
    long num_pellets = 1234567;
    int i = 0, j;
    for (j = bsize-1; j >=0; j--) {
      i=0;
      while (num_pellets > 0 && num_pellets >= boxes[j] && i < 10) {
	if(num_pellets<boxes[j]) break;
	printf("%ld,", boxes[j]);
	fflush(stdout);
	num_pellets -= boxes[j];
	i++;
      }
    }
    for (j = 0; j < bsize && num_pellets>0; j++) {
      while (num_pellets > 0 && num_pellets >= boxes[j]) {
	printf("%ld,", boxes[j]);
	num_pellets -= boxes[j];
      }
    }
    printf("0\n");
    return 0;
}
