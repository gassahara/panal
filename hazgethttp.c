#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <string.h>
#include <fcntl.h>
#include <arpa/inet.h>
/*
#include <sys/stat.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <netdb.h>
#include <netinet/in.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include<sys/socket.h>    //socket
#include<arpa/inet.h> //inet_addr
*/
//void doprocessing (int sock);

int main( int argc, char *argv[] ) {
  int sockfd, newsockfd, portno, clilen;
  char buffer[256],*direccion;
  struct sockaddr_in remoteSocketInfo;
  struct hostent *hPtr;
  int socketHandle;
  char *remoteHost=argv[1];
  int portNumber=0;
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
    portNumber = 80;
  }
  int n, pid;
  int sock;
  struct sockaddr_in server;
  char message[1000] , server_reply[2000];

  //Create socket
  sock = socket(AF_INET , SOCK_STREAM , 0);
  if (sock == -1)
    {
      fwrite("NO CREO", sizeof(char), 7, stderr);
    }

  server.sin_addr.s_addr = inet_addr(argv[1]);
  server.sin_family = AF_INET;
  server.sin_port = htons( portNumber );

  //Connect to remote server
  if (connect(sock , (struct sockaddr *)&server , sizeof(server)) < 0)
    {
      perror("connect failed. Error");
      return 1;
    }

  int lee2, leei;
  struct stat *estat;
  char nam[256],namo[256],bites[1024], *get;
  printf ("[%s]", direccion);
  get=calloc(strlen(direccion)+340, sizeof(char));
  bzero(get, strlen(direccion)+340);
  memcpy(get, "GET /", 5);
  memcpy(get+5, direccion, strlen(direccion));
  sprintf(bites," HTTP/1.1\r\nHost: %s\r\nUser-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:57.0) Gecko/20100101 Firefox/57.0\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Language: en-US,en;q=0.5\r\nAccept-Encoding: gzip, deflate\r\nConnection: close\r\nUpgrade-Insecure-Requests: 1\r\n\r\n\n", argv[1]);;
  memcpy(get+(5+strlen(direccion)), bites, strlen(bites));
  bzero(buffer, 2);
  FILE *ff, *fo;
  n=1;
  int o=0;
  while (n>0 && o<strlen(get) ) {
    buffer[0]=get[o];
    //    printf("<<%s>>", buffer);
    n = send(sock,buffer,1,0);
    o++;
  }
  while( recv(sock , buffer , 1 , 0) ) {
    if(buffer[0]>0) printf("%s", buffer);
    bzero(buffer, 2);
  }
  printf ("LLLLLLLLLLLLL");
  close(sock);
  exit(0);


}
