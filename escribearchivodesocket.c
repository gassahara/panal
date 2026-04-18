/************* UDP CLIENT CODE *******************/
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

char *misok(char *direc, int puert){
  int miSocket, nBytes, nBytez, r, leei, lee2,tcp_keepintvl=10;
  struct sockaddr_in serverAddr;
  socklen_t addr_size;
  char buffer[1024], myvar[1024];
  char *lee, *temporal;
  lee=calloc(1024, sizeof(char));
  memset(lee, 0, 1024);
  leei=1024;
  temporal=calloc(1024, sizeof(char));
  memset(temporal, 0, 1024);
  int tipo=SOCK_STREAM;
  miSocket = socket(AF_INET, tipo , 0);
  //fcntl (miSocket, F_SETFL, O_NONBLOCK);
  serverAddr.sin_family = AF_INET; 
  serverAddr.sin_port = htons(puert);
  serverAddr.sin_addr.s_addr = inet_addr(direc);  
  memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);
  addr_size = sizeof serverAddr;
  r=-1;
  while(r<0) {r=connect(miSocket, (struct sockaddr *)&serverAddr,addr_size);}
  if(errno==EINPROGRESS) printf("EINPROGRESS");
  printf("sock %i r %i error %i", miSocket, r, errno);
  nBytes=1;
  lee2=0;
  //while(nBytes=read(miSocket, buffer,1)) {
  while(nBytes>0) {
    //nBytes=recv(miSocket, buffer,1024,MSG_DONTWAIT);
    nBytes=recv(miSocket, buffer,1, 0);
    lee2+=nBytes;
    ///*
    while(lee2>leei-1) {
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      strncpy(temporal, lee, leei);
      free(lee);
      lee=calloc(leei+1024, sizeof(char));
      strncpy(lee, temporal, leei);
      leei+=1024;
    }
    strncpy(lee+lee2-nBytes, buffer, nBytes);
    lee[lee2]='\0';
    //*/
  }
  close(miSocket);
  buffer[nBytes]='\0';
  return lee;
}

int main(int argc, char* argv[]){
  int i, leei, lee2, lea[2], *combinaciones, combi, ccombi, cc, ccc;
  char nam[1024], namm[1024],aejec[1024], *name[sizeof(argv[0])],recursos_contexto[1024],*mybar;
  char *lee, *temporal, *recibe;
  leei=1024;
  lee=calloc(leei, sizeof(char));
  memset(lee, 0, leei);
  temporal=calloc(leei, sizeof(char));
  memset(temporal, 0, leei);

  printf("%i \n", argc);
  combi=((argc-1)*(argc-1));
  combinaciones=calloc(combi, sizeof(int));
  memset(combinaciones, 0, combi);
  cc=0;
  ccc=0;
  ccombi=0;
  while(ccc<combi) {
    if(cc==argc-1) {
      cc=0;
    }
    combinaciones[ccc]=cc;
    printf("%i", cc);
    cc++;
    ccc++;
    if(ccc%(argc-1)==0) {
      ccombi++;
      cc=ccombi;
      printf(".");
    }
  }

  int fila=0;
  int celda=0;
  int v=0;
  sprintf(nam, "%s", "p");
  while(v < argc-1) {
    printf(">-- fila %i v %i --<", fila, v);
    sprintf(nam, "%s-%s", nam, argv[combinaciones[v]+1]);
    v++;
  }
  strcat(nam, ".txt");
  printf(">>>%s<<<<<", nam);
   
  FILE *ff=fopen(nam, "w");
  fclose(ff);
  cc=0;
  int contadordefindefila=0;
  while(celda<combi) {
    recibe=misok("127.0.0.1",strtol(argv[combinaciones[celda]+1], NULL, 10));
    strcat(recibe, "\n");
    //printf("<<<<<<<<<<<>>>>>>>\n %s >>>>>>><<<<<<<<\n", recibe);
    printf("\nc%i = %i (%s)\n", celda, combinaciones[celda], argv[combinaciones[celda]+1]);
    if(contadordefindefila==argc-2) {
      contadordefindefila=0;
      sprintf(aejec, "int main() { %s\n", recibe);
      sprintf(recibe, "%s", aejec);
    }
    contadordefindefila++;
    if(cc==argc-1){
      cc=0;
      fila++;
      int v=0;
      sprintf(nam, "%s", "p");
      while(v < argc-1) {
	if(fila>0) {
	  printf(">-- fila %i v %i celda %i --<", fila, v, (fila*(argc-1))+v);
	  sprintf(nam, "%s-%s", nam, argv[combinaciones[(fila*(argc-1))+v]+1]);
	} else {
	  printf(">-- fila %i v %i --<", fila, v);
	  sprintf(nam, "%s-%s", nam, argv[combinaciones[v]+1]);
	}
	v++;
      }
      strcat(nam, ".txt");
      printf(">>>%s<<<<<", nam);

      FILE *ff=fopen(nam, "w");
      fclose(ff);
    }
    ff=fopen(nam, "a");
    fwrite(recibe, sizeof(char), strlen(recibe), ff);
    fclose(ff);
    cc++;
    celda++;
  }

  //sprintf(nam, "%s.c", argv[0]);
  //if(argv[1]) strcat(nam, argv[1]);
  //printf(nam);
  //FILE *ff=fopen(name, r+);
  
}
