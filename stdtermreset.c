#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *term = getenv("TERM");
    if(!term || strcmp(term, "dumb") == 0) {
        return 0;
    }
    printf("\033[0m");
    fflush(stdout);
    return 0;
}
