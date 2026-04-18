#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Usage: ./stdreplacearrayval file.c array_name index "new_value"
// Example: ./stdreplacearrayval billboards.c status 0 "disabled"
int main(int argc, char *argv[]) {
    if(argc < 5) return 1;
    char *filename = argv[1];
    char *array_name = argv[2];
    int target_index = atoi(argv[3]);
    char *new_value = argv[4];

    FILE *f = fopen(filename, "r");
    if(!f) return 1;
    
    char tmp_name[256];
    snprintf(tmp_name, sizeof(tmp_name), "%s.tmp", filename);
    FILE *out = fopen(tmp_name, "w");
    if(!out) {
        fclose(f);
        return 1;
    }

    char line[1024];
    while(fgets(line, sizeof(line), f)) {
        // Look for declaration like: char array_name[...][...] = {"val", "val"};
        char search_str[256];
        snprintf(search_str, sizeof(search_str), "char %s[", array_name);
        
        if(strstr(line, search_str) != NULL && strstr(line, "=") != NULL) {
            // Found the array initialization. We must replace the Nth string between quotes.
            char *p = strstr(line, "{");
            if(p) {
                // Write everything up to the curly brace directly
                int pre_len = (p - line) + 1;
                fwrite(line, 1, pre_len, out);
                p++;
                
                int current_index = 0;
                while(*p) {
                    if(*p == '"') {
                        if(current_index == target_index) {
                            fprintf(out, "\"%s\"", new_value);
                            p++; // skip original quote
                            // skip until next quote
                            while(*p && *p != '"') p++;
                            if(*p == '"') p++; // skip output quote
                            current_index++;
                        } else {
                            fputc(*p, out);
                            p++;
                            while(*p && *p != '"') {
                                fputc(*p, out);
                                p++;
                            }
                            if(*p == '"') {
                                fputc(*p, out);
                                p++;
                            }
                            current_index++;
                        }
                    } else {
                        fputc(*p, out);
                        p++;
                    }
                }
            } else {
                // Unexpected format, just pass it through
                fputs(line, out);
            }
        } else {
            fputs(line, out);
        }
    }
    fclose(f);
    fclose(out);
    
    rename(tmp_name, filename);
    return 0;
}
