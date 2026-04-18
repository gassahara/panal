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
      printf("NO CREO");
    }

  server.sin_addr.s_addr = inet_addr(argv[1]);
  server.sin_family = AF_INET;
  server.sin_port = htons( portNumber );

  //Connect to remote server
  if (connect(sock , (struct sockaddr *)&server , sizeof(server)) < 0)
    {
      printf ("failed. Error");
      return 1;
    }

  close(sock);
  exit(0);


}
