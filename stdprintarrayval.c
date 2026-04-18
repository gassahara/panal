#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Usage: ./stdprintarrayval file.c array_name index
// Example: ./stdprintarrayval billboards.c status 0
int main(int argc, char *argv[]) {
    if(argc < 4) return 1;
    char *filename = argv[1];
    char *array_name = argv[2];
    int target_index = atoi(argv[3]);

    FILE *f = fopen(filename, "r");
    if(!f) return 1;

    char line[1024];
    while(fgets(line, sizeof(line), f)) {
        char search_str[256];
        snprintf(search_str, sizeof(search_str), "char %s[", array_name);
        
        if(strstr(line, search_str) != NULL && strstr(line, "=") != NULL) {
            char *p = strstr(line, "{");
            if(p) {
                p++;
                int current_index = 0;
                while(*p) {
                    if(*p == '"') {
                        p++; // skip quote
                        if(current_index == target_index) {
                            // Print up to the next quote
                            while(*p && *p != '"') {
                                putchar(*p);
                                p++;
                            }
                            fclose(f);
                            return 0;
                        } else {
                            while(*p && *p != '"') p++; // skip string
                            if(*p == '"') p++;
                            current_index++;
                        }
                    } else {
                        p++;
                    }
                }
            }
        }
    }
    fclose(f);
    return 1;
}
