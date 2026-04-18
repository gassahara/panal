#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *term = getenv("TERM");
    if(!term || strcmp(term, "dumb") == 0) {
        printf("\n\n\n\n\n"); // Fallback simple scroll
        return 0;
    }
    printf("\033[2J\033[H");
    fflush(stdout);
    return 0;
}
