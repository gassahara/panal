#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <string.h>
#include <fcntl.h>
#include <arpa/inet.h>

int main( int argc, char *argv[] ) {
  char buffer[2],*direccion;
  int n, sock;
  struct sockaddr_in server;
  char *remoteHost=argv[1];
  int portNumber=0;
  n=1;
  int o=0;
  int r=1;

  if(strchr(argv[1], 0x2f)) {
    direccion=calloc(strlen(strchr(argv[1], '/')+1), sizeof(char));
    bzero(direccion, strlen(strchr(argv[1], '/')+1));
    memcpy(direccion, strchr(argv[1], '/')+1, strlen(strchr(argv[1], '/')+1));
    int ii=0;
    while(ii<strlen(argv[1])) {
      if(remoteHost[ii]=='/') remoteHost[ii]=0;
      ii++;
    }
  }  else direccion="";
  if(strchr(argv[1], ':')) {
    portNumber=atoi(strchr(argv[1], ':')+1);
    int i=0;
    while(i<strlen(remoteHost)) {
      if(remoteHost[i]==':') remoteHost[i]=0;
      i++;
    }
  } else {
    portNumber = 5001;
  }
  //Create socket
  sock = socket(AF_INET , SOCK_STREAM , 0);
  if (sock == -1)
    {
      printf("Could not create socket");
    }

  server.sin_addr.s_addr = inet_addr(argv[1]);
  server.sin_family = AF_INET;
  server.sin_port = htons( portNumber );

  //Connect to remote server
  fcntl(sock, F_SETFL, O_NONBLOCK);
  while (connect(sock , (struct sockaddr *)&server , sizeof(server)) < 0)
    {
      perror("connect failed. Error");
      //return 1;
    }

  bzero(buffer, sizeof(buffer));
  while(r>0) {
    r=fread(buffer, sizeof(char), 1, stdin);
    if(r<1) break;
    n = send(sock,buffer,1,0);
    o++;
  }

  bzero(buffer, sizeof(buffer));
  n=0;
  while( n < 1) {
    n=recv(sock , buffer , 1 , MSG_WAITALL);
  }
  printf("%s", buffer);
  while( n > 0) {
    n=recv(sock,buffer,1,MSG_WAITALL);
    if(buffer[0]>0) printf("%s", buffer);
    bzero(buffer, 2);
  }
  close(sock);
  exit(0);
}
