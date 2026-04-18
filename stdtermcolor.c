#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    // Usage: ./stdtermcolor <fg> [bg]
    // where fg and bg are ints 30-37 and 40-47
    if(argc < 2) return 1;
    char *term = getenv("TERM");
    if(!term || strcmp(term, "dumb") == 0) {
        return 0;
    }
    int fg = atoi(argv[1]);
    if(argc == 3) {
        int bg = atoi(argv[2]);
        printf("\033[%d;%dm", fg, bg);
    } else {
        printf("\033[%dm", fg);
    }
    fflush(stdout);
    return 0;
}
