#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdarg.h> 
#include <assert.h>
#include <ctype.h>     
#include <dirent.h>
#include <sys/types.h>   
#include <sys/socket.h>
#include <netdb.h> 
#include <termios.h> 
#include <time.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h> 
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/shm.h> 
int main () {int segment_id; char* shared_memory; struct shmid_ds shmbuffer; 
  int segment_size; int next[2]; const int shared_segment_size = 0x6400;/*Allocate*/ 
  segment_id=shmget(IPC_PRIVATE,shared_segment_size,IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
  /*size*/shmctl(segment_id,IPC_STAT,&shmbuffer);segment_size=shmbuffer.shm_segsz; 
  typedef struct _not{int dato,alt,coori,coord,padr,apadr;char s[256];struct _not *derecho; struct _not *izquierdo;}tipoNod; 
  typedef tipoNod *pNot, *arbo; arbo *aa;shared_memory=(char*)shmat(segment_id,0,0);
  int *p ;sprintf(shared_memory," %s \n","Hello, world.");
  printf("sharing %d  \n",segment_id ) ; //p=arbo1->s+offsetof(tipoNod0,s);
  getchar();shmdt (shared_memory); return 0;}


