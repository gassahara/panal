#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <netdb.h>
#include <netinet/in.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/shm.h>
#include <unistd.h>

//void doprocessing (int sock);
void doprocessing (int sock) {
  int n, lee2, leei;
  struct stat *estat;
  char nam[256],namo[256];//, buffer[1048577];
  char *buffer2;
  bzero(buffer2, 1048577);
  sprintf(nam, "%i.in", getpid());
  sprintf(namo, "%i.out", getpid());
  int key=shmget(IPC_PRIVATE, 1048577, IPC_CREAT);
  buffer2=(char*)shmat(key, 0, 0);
  printf ("   %d $$$ %s %s\n", key, nam, namo);
  n=0;
  while(1) {
    bzero(buffer2,1048577);
    n=recv(sock,buffer2,1048576,MSG_DONTWAIT);
    printf("%s", buffer2);
    bzero(buffer2,1048577);
    while(buffer2[0] == 0) {
      sleep(1);
    }
    write(sock,buffer2,n);
    bzero(buffer2,1048577);
    printf("\n<%d %s*> ", buffer2);
  }
  printf ("LLLLLLLLLLLLL");
  close(sock);
  exit(0);
}


int main( int argc, char *argv[] ) {
  int sockfd, newsockfd, portno, clilen;
  char buffer[256];
  struct sockaddr_in serv_addr, cli_addr;
  int n, pid;

  /* First call to socket() function */
  sockfd = socket(AF_INET, SOCK_STREAM, 0);

  if (sockfd < 0) {
    perror("ERROR opening socket");
    exit(1);
  }

  /* Initialize socket structure */
  bzero((char *) &serv_addr, sizeof(serv_addr));
  portno = 5001;

  serv_addr.sin_family = AF_INET;
  serv_addr.sin_addr.s_addr = INADDR_ANY;
  serv_addr.sin_port = htons(portno);

  /* Now bind the host address using bind() call.*/
  printf("server en %i\n", getpid() );
  if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) {
    perror("ERROR on binding");
    exit(1);
  }

  /* Now start listening for the clients, here
   * process will go in sleep mode and will wait
   * for the incoming connection
   */

  listen(sockfd,5);
  clilen = sizeof(cli_addr);
    
  printf("original en %i\n", getpid() );
  while (1) { 
    printf("copia en %i\n", getpid() );
    printf("ESPERANDO en %i\n", pid);
    newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);

    if (newsockfd < 0) {
      perror("ERROR on accept");
      exit(1);
    }

    /* Create child process */
    pid = fork();

    if (pid < 0) {
      perror("ERROR on fork");
      exit(1);
    }

    if (pid == 0) {
      /* This is the client process */
      close(sockfd);
      printf("PADRE %i hace %i ",  getpid(), newsockfd );
      doprocessing(newsockfd);
      exit(0);
    } else {
      printf("PADRE %i c ierro %i ",  getpid(), newsockfd );
      close(newsockfd);
    }

  } /* end of while */
}
