#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if(argc < 3) return 1;
    char *term = getenv("TERM");
    if(!term || strcmp(term, "dumb") == 0) {
        return 0;
    }
    int row = atoi(argv[1]);
    int col = atoi(argv[2]);
    printf("\033[%d;%dH", row, col);
    fflush(stdout);
    return 0;
}
