#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <linux/tcp.h>
#include <string.h>
#include <fcntl.h>

//void doprocessing (int sock);
void doprocessing (int sock) {
  int n, n2, lee2, leei;
  struct stat *estat;
  char nam[256],namo[256], buffer[1048577], buff[2];
  bzero(buffer, 1048577);
  sprintf(nam, "%i.in", getpid());
  sprintf(namo, "%i.out", getpid());
  FILE *ff, *fo;
  printf ("%s %s\n", nam, namo);
  n=0;
  n2=0;
  while(1) {
    bzero(buffer,1048577);
    n=recv(sock,buffer,1048576,MSG_DONTWAIT);
    if (n > 0) {
      ff=fopen(nam, "a");
      if(ff>0) {
    	fwrite(buffer, sizeof(char), n, ff);
	fclose(ff);
      } else{break;}
    }
    fo=fopen(namo, "r");
    if (fo > 0) {
      bzero(buffer,1048577);
      n=read(fileno(fo), buffer, 1048576);
      while(n>0) {
	printf("\nw %d ", getpid());
	n2=write(sock,buffer,n);
	if(n2<n) {
	  fclose(fo);
	  unlink(namo);
	  break;
	}
	//	printf("(%d +) ", n2);
	bzero(buffer,1048577);
	n=read(fileno(fo), buffer, 1048576);
	//write(sock,buffer,n);
	//	printf("<%d *> ", n);
      }
      fclose(fo);
      unlink(namo);
      printf("<B %s> ", namo);
    }
    sleep(1);
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
