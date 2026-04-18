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
                    /*reviso el interprete para saberlo */
int main(int argc, char *argv[]){int segment, segment_Id;char* shared_memory;struct shmid_ds shmbuffer; char *y;
  int segment_size; int next[2]; const int shared_segment_size = 0x6400; 
  segment_Id = atoi(argv[1]); //shmget (IPC_PRIVATE, shared_segment_size,IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR); 
  typedef struct _not{int dato,alt,coori,coord,padr,apadr;char s[256];struct _not *derecho;struct _not *izquierdo;}tipoNod;
  /*Determine size*/shmctl (segment_Id, IPC_STAT, &shmbuffer); segment_size=shmbuffer.shm_segsz;printf("NAAAAAAHH <%d> \n",segment_Id);
  /*typedef*/ tipoNod *pNot, *arbo; //shared_memory = (char*) shmat(segment_Id,0/*(void*) 0x5000000*/, 0);
                                           arbo = (tipoNod*) shmat(segment_Id,0/*(void*) 0x5000000*/, 0);
  ;char *base;size_t offset;int *b;; 
  /*shared_memory=(tipoNod1*) shmat(segment_id,(void*) 0x5000000,0); */
  printf ("shared memory reattached at address %p con %d \n", shared_memory, segment_Id);
  printf ("shared memory <%s> \n", arbo->s); /* */  //sprintf(*y," %s \n",shared_memory);
  //base=(tipoNod *)arbo; offset = offsetof(tipoNod, s)+sizeof(arbo)/*+sizeof(char *)*/+1;
  //printf("offset: %d lenshare: %d\n",offset,strlen(arbo));
  //y = (char *)(base+offset);
  //printf("NOOOOHH <%s> \n",base);printf("y: <%s>  \n", y );
  
  /*Detach*/shmdt(shared_memory);shmctl(segment_Id, IPC_RMID, 0);return 0;}
/*typedef struct x {int member_a; int member_b;} x;
int main() {x *s = malloc(sizeof(x));char *base;size_t offset;int *b;
    s->member_a=1;s->member_b=2;base=(char *)s;
    offset = offsetof(x, member_b);
    b = (int *)(base+offset);printf("%d\n", s->member_b); -
    *b = 10;     printf("%d\n", s->member_b); return 0;}*/
