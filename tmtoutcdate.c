#include <time.h>
#include <stdio.h>
#include <stdlib.h>   // for putenv
 
int main(void)
{
    time_t t=-203209439068/1000;
    struct tm *buf;
    buf=gmtime(&t);
    printf("%d/%d/%d %d:%d UTC", 1900+buf->tm_year, buf->tm_mon+1, buf->tm_mday, buf->tm_hour, buf->tm_min);
}
