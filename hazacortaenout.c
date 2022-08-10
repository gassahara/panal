#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <netinet/in.h>
//#include <netinet/tcp.h>
#include <sys/socket.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/stat.h>
#include <fcntl.h>


int sizeofbuffer=1024;
char cabecera[59]="#include <string.h>\n#include <stdio.h>\n#include <stdlib.h>\n";
char parastdin[594]="char *buffer;\nbuffer=calloc(1048576, sizeof(char));\nchar *temporal;\ntemporal=calloc(1048576, sizeof(char));\nbzero(buffer, 1048576);\nbzero(temporal, 1048576);\nchar buff[2];\nint r=1;\nint rr=0;\nint rt=1048576;\nint offset=0;\nwhile(r>0) {\nr=fread(buff, sizeof(char), 1, stdin);\nif(r<1) break;\nbuffer[rr]=buff[0];\nrr++;\nwhile(rr>rt-1) {\nfree(temporal);\ntemporal=calloc(rr, sizeof(char));\nmemcpy(temporal, buffer, rr);\nfree(buffer);\nbuffer=calloc(rr+1048576, sizeof(char));\nbzero(buffer, 1048576);\nmemcpy(buffer, temporal, rr);\nrt=rr+1048576;\n}\n}\nbuffer[rr]=0;\nif(rr<=1) {\nbuffer[0]='0';\nbuffer[1]=0;}";

//void doprocessing (int sock);
void hazc(char *s1, char *s2, char *s3, int lon) {
  char br[lon];
  int filf; 
  int erroo=0;
  FILE *y;
  char tempbr=0;
  int brstr=0;
  while(!erroo) {
    filf=open("/dev/urandom", O_RDONLY);
    read(filf, br, lon);
    close(filf);
    while(lon>0) {
      printf("[%02X]", abs(br[lon-1]));
      tempbr=abs(br[lon-1]);
      tempbr>>=4;
      printf("<%01X>", tempbr);
      if(tempbr>9)tempbr+=7;
      tempbr+=0x30;
      s3[brstr]=tempbr;
      tempbr=abs(br[lon-1]);
      tempbr=tempbr&0xF;
      printf("(%02X)", tempbr);
      brstr=brstr+1;
      if(tempbr>9)tempbr+=7;
      tempbr+=0x30;
      s3[brstr]=tempbr;
      lon--;
      brstr+=1;
    }
    s3[brstr]='.';
    s3[brstr+1]='c';
    s3[brstr+2]=0;
    printf("NNNN: %s\n", s3);
    errno=0;
    y=fopen(s3,"r");
    erroo=errno;
  }
  y=fopen(s3,"w+");
  fwrite(cabecera, sizeof(cabecera), 1, y);
  fprintf(y, "int pid=%ld;\n", getpid());
  fprintf(y, "int main( int argc, char *argv[] ) {\n");
  fwrite(parastdin, sizeof(parastdin), 1, y);
  fprintf(y, "\nFILE *f1=fopen(\"%s\", \"a\");\nfwrite(buffer, 1,rr,f1);\nfclose(f1);\nFILE *f2=fopen(\"%s\", \"r\");\nwhile(fread(buffer,1,1,f2)) {\nprintf(\"%s\",buffer[0]);\n}\nfclose(f2);\n}", s1, s2, "%c");
  fclose(y);
}
void doprocessing (int sock, struct sockaddr_in cli_addr) {
  int n, n2;
  int rompe=0;
  int lonnam=14;
  char namr[lonnam],nam[lonnam],namo[lonnam], buffer[sizeofbuffer+1];
  buffer[sizeofbuffer]=0;
  FILE *fo;
  n=0;
  n2=0;
  struct timespec ttimsp;
  ttimsp.tv_sec=1;
  ttimsp.tv_nsec=0;
  sprintf(namo, "./%08d.out", getpid());
  sprintf(nam, "./%08d.in", getpid());
  sprintf(namr, "./%08d.rr", getpid());

  int iu=0;
  uint32_t ou=cli_addr.sin_addr.s_addr;
  uint8_t oo=0;
  printf("\n\n\nIP ");
  while(iu<4){
    oo=(ou & 0x000000ff);
    printf("%03d.", oo);
    ou=ou>>8;
    iu++;
  }
  printf("\n\n");
  fflush(stdout);

  n=0;
  while(n<sizeofbuffer) {
    buffer[n]=0;
    n++;
  }

  int ffno=0;
  int ffnr=0;
  ffno=open(nam, O_RDWR|O_CREAT|O_EXCL|O_SYNC, S_IRWXU);
  close(ffno);
  ffno=open(namr, O_RDWR|O_CREAT|O_EXCL|O_SYNC, S_IRWXU);
  close(ffno);
  ffno=open(namo, O_RDWR|O_CREAT|O_EXCL|O_SYNC, S_IRWXU);
  close(ffno);
  char nomc[(lonnam*2)+3];
  hazc(namo, nam, nomc, lonnam);
  long posicion=0;

  int serror = 0;
  socklen_t slen = sizeof (serror);
  int retval = 0;

  while(1) {
    errno=0;
    rompe=0;
    n=recv(sock,buffer,sizeofbuffer,MSG_DONTWAIT);
    retval = getsockopt (sock, SOL_SOCKET, SO_ERROR, &serror, &slen);
    printf("\nError in :< %d %s    ..   %d %d>\n", errno, strerror(errno), retval, serror);
    if( (errno != 0 /*&& errno!=11*/) || retval || serror) rompe=1;
    if(rompe) {
      close(sock);
      kill(getpid(), SIGKILL);
      printf ("killing %d >>>\n", getpid());
      kill(getpid(), SIGKILL);
      printf ("killing %d >>>\n", getpid());
      break;
    }
    errno=0;
    ffno=open(nam, O_RDONLY);
    printf("\n %s E>%d<", nam, errno);
    if(errno) rompe=1;
    close(ffno);
    ffno=open(namo, O_RDONLY);
    printf("\n %s E>%d<", namo, errno);
    if(errno) rompe=1;
    close(ffno);
    ffno=open(nomc, O_RDONLY);
    printf("\n %s E>%d<\n", nomc, errno);
    if(errno) rompe=1;
    close(ffno);
    nanosleep(&ttimsp, NULL);
    printf(".");
    while(n>0) {
      ffno=open(nam, O_WRONLY|O_APPEND);
      if(errno) break;
      printf("\n n:%d\n%s \n",n, buffer);
      if(ffno>0) {
	write(ffno, buffer, n);
	close(ffno);
      } else{rompe=1;}
      printf("R");
      nanosleep(&ttimsp, NULL);
      n=recv(sock,buffer,sizeofbuffer,MSG_DONTWAIT);
      printf(":RR:");
      fflush(stdout);
    }
    errno=0;
    fo=fopen(namo, "r");
    printf("\n %s E>%d<", namo, errno);
    if (!errno) {
      fseek(fo, posicion, SEEK_SET);
      printf(":F:");
      fflush(stdout);
      n=sizeofbuffer;
      while(n>0) {
	n=sizeofbuffer;
	while(n>=0) {
	  buffer[n]=0;
	  n--;
	}
	n=0;
	fflush(stdout);
	n=read(fileno(fo), buffer, sizeofbuffer);
	ffnr=open(namr, O_WRONLY|O_APPEND);
	n2=write(ffnr, buffer, n);
	close(ffnr);
	n2=write(sock,buffer,n);
	printf("file: %s w(%d) r(%d)<<((%s))>>\n",namo, n2, n, buffer);
	nanosleep(&ttimsp, NULL);
	posicion+=n2;//ftell(fo);
      }
      fflush(stdout);
    } else {
      fclose(fo);
      close(sock);
      close(sock);
      break;
    }
    fclose(fo);
    printf("<B %08ld>", posicion);
    fflush(stdout);
    if(rompe) break;
  }
  close(sock);
  printf ("%d <<<", getpid());
  fflush(stdout);
  kill(getpid(), SIGTERM);
  printf ("%d <<<", getpid());
  fflush(stdout);
  kill(getpid(), SIGKILL);
  printf ("%d >>>\n", getpid());
  fflush(stdout);
  exit(0);
}


int main( int argc, char *argv[] ) {
  int sockfd, newsockfd, portno, clilen;
  struct sockaddr_in serv_addr, cli_addr;
  int pid;

  /* First call to socket() function */
  sockfd = socket(AF_INET, SOCK_STREAM, 0);

  if (sockfd < 0) {
    perror("ERROR opening socket");
    exit(1);
  }

  /* Initialize socket structure */
    portno = 5001;
  while(1) {
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);
    /* Now bind the host address using bind() call.*/
    printf("server en %i\n", getpid() );
    if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) {
      portno++;
    } else {
      break;
    }
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
    newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, (socklen_t *)&clilen);
    if (newsockfd < 0) {
      perror("ERROR on accept");
      exit(1);
    }

    /* Create child process */
    pid = fork();
    printf("=====================================");

    if (pid < 0) {
      perror("ERROR on fork");
      exit(1);
    }

    if (pid == 0) {
      /* This is the client process */
      close(sockfd);
      printf("PADRE %i hace %i ",  getpid(), newsockfd );
      doprocessing(newsockfd, cli_addr);
    } else {
      printf("\nPADRE %i cierro %i\n",  getpid(), newsockfd );
      close(newsockfd);
    }

  } /* end of while */
}
