#include <stdio.h>

int main () {
  int c[1];
  int n=0;
  printf("Enter character: ");
  
  while(fread(c, 1, 1, stdin)>0 && n<1){
    printf("-");
    n++;
  }
  printf("Character entered: ");
  printf("%02X", c);

  return(0);
}
