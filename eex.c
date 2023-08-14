#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int
main(int argc, char *argv[])
{
  char *newargv[] = { NULL, "" };
  char *newenviron[] = { NULL };

  newargv[0] = "/bin/ls";

  execve("/bin/ls" , newargv, newenviron);
  perror("execve L");   /* execve() returns only on error */
  exit(EXIT_FAILURE);
}
