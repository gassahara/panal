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
  segment_id = shmget (IPC_PRIVATE, shared_segment_size,IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR); 
  typedef struct _not0{int dato,alt,coori,coord,padr,apadr;char ss[256];struct _not0 *derecho; struct _not0 *izquierdo;} tipoNod0;
  /*Determine size*/shmctl (segment_id, IPC_STAT, &shmbuffer); segment_size=shmbuffer.shm_segsz;
  /*typedef*/ tipoNod0 *pNot0, *arbo1; arbo1 = (tipoNod0*) shmat(segment_id, 0, 0);
  strcpy(arbo1->ss,"no se");arbo1->dato=segment_id;arbo1->alt=5; printf("HAAAA  %d \n", segment_id );   
  
  //shared_memory=(tipoNod0/*char**/)shmat(segment_id,0,0);
  printf ("attached at %p with %d \n",arbo1,segment_id); 
    
  printf ("segment size: %d %d\n", segment_size, sizeof(tipoNod0) ); /* sprintf ( segment_var , %s\n", segment_id); */
  int *p ;
  //;memcpy(arbo1->s,"Hello, world.",sizeof(arbo1) ); 
  //shared_memory=(*a)->dato;
  //sprintf(arbo1->s," %s \n" , "Hello, world." /*(a)->s*/  /* */);
  printf("sharing %s  \n", arbo1->ss ) ; /* *shared_memory++;*/
  //p=arbo1->s+offsetof(tipoNod0,s);
  //printf("qwert %d \n", p);
  //printf("sharing %p <%2x> <%d> \n",/*(*a)->alt,*/ (*a) , shared_memory, shared_memory ) ; /* *shared_memory++;*/

  getchar();
  /* Detach*/ shmdt (arbo1); return 0;}
/*recuerdo siempre escribir el segment_id en el interprete*/

