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
#include <sys/wait.h> 
#include <arpa/inet.h>
#include <netinet/in.h> 
#include <netdb.h>   
char *subStr(char* str_src,int pos_ini,int cant_mov){char *subst=calloc(1,cant_mov+2),*cual[1]; int cont_mov=0,cunt_mov=0,gcant_mov=0,ggcant_mov=0,gcont_mov=0,ggcont_mov=0,ci=0,cii=0,gci=0,ggci=0,ggcii=0,gcii=0,trig=0;
*cual=strchr(str_src,46);if(*cual!=NULL){gci= (strlen(str_src)-strlen(*cual))+1;ggci=  (str_src[gci])-48;*cual=*cual+1;  
*cual=strchr(*cual,46);  if(*cual!=NULL){gcii=(strlen(str_src)-strlen(*cual))+1;ggcii= (str_src[gcii])-48;}}gcont_mov=strlen(str_src);
             while(cont_mov<=gcont_mov+0){ if(cont_mov>=pos_ini){if(cunt_mov<=cant_mov){ subst[cont_mov-pos_ini]=*str_src;cunt_mov++;} } 
				                                                 *str_src++;cont_mov++;}return subst;}     
       
void doprocessing(int sock){int qe=0,n,n1=0,n2,n3=0,n4=0,n5=0,leei,leeo=0,cuant_memoria=1048576;char lee[2],*zx,*za,*zb,*zc, az[1248577],vuffer[1248577];
  FILE *ff, *fo, fv,fw;unsigned char *nam,*nami, buffer[1248577],*namo, shared_segment_size=0x12485770;   
  int pip[2],seg, segment_id0,segment_id1,segment_size,segment_size2,cpid;; 
  struct stat *estat;struct shmid_ds shmbuffer; int *p ,next[2];   
  segment_id0=shmget(IPC_PRIVATE,shared_segment_size,IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
  segment_id1=shmget(IPC_PRIVATE,shared_segment_size,IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
  shmctl(segment_id0,IPC_STAT,&shmbuffer);segment_size=shmbuffer.shm_segsz; 
  shmctl(segment_id1,IPC_STAT,&shmbuffer);segment_size=shmbuffer.shm_segsz; 
  nam= (void*)shmat(segment_id0,0,0/*SHM_RDONLY*/);
  nami=(void*)shmat(segment_id1,0,0/*SHM_RDONLY*/);
  n=0;n2=0; bzero(buffer,1048577);printf("%d \n", getpid());
  n=recv(sock,nam,cuant_memoria,MSG_DONTWAIT);  sprintf(nami,"%d",getpid());
  if(n>0){ 
	 if(strstr (nam ,"GET / HTTP/1.1")!=NULL){strcat(nam,"HTTP/1.1 200 OK\nContent-Type: text/html\nContent-Length:     \n\n<!DOCTYPE HTML\n\n ><HTML>"); /*PUBLIC -//W3C//DTD XHTML 1.0 Strict//EN*/ 
	 printf("In %s\n",nam);while(strstr(nam,"</HTML>")==NULL ){sleep(1);} 
	 za=strstr(nam,"HTTP/1.1 200 OK\n");if(za!=NULL) {strcpy(nam,za) ;printf("completa za +%s+\n",za);//qe=0; while(qe<strlen(nam)){if(strcmp(subStr(nam,0,15),"HTTP/1.1 200 OK\n")==0)break; *nam++;qe++;} ;
	 ;n2=write(sock, nam,strlen(nam)+0);if(n2>=strlen(nam))printf("result %s\n ",nam);else printf("NO ENVIADO n2 %d %s>",n2,nam);};}
	 else {if(strstr (nam ,"GET /")!=NULL){ strcat(nam,"HTTP/1.1 200 OK\nContent-Type: image/   \nContent-Length:     \n\r\n\r\n");
	 leei=strlen(nam);printf("In %s\n",nam);while(strstr(nam,"image/  " )!=NULL){sleep(1);} ;
     zx=strstr(nam,"Content-Length"); 
     if(zx!=NULL){ za= strchr(zx,58);
		         if(za!=NULL){;zb=strstr(za,"Content-Type");
					        if(zb!=NULL){;leeo=0;strcpy(az,subStr(za,1,strlen(za)- strlen(zb)-2));leeo=atoi(az); /* */;};};} 
     zc= strchr(zb,59);if(zc!=NULL){strcpy(vuffer,subStr(nam,0, strlen(nam)-0));
     printf("vuffer %s \n",vuffer);;} 
     ff=fopen("image12.jpg","rb");// n1=read(fileno(ff), buffer, leeo); 
     fo=fopen("image.jpg","wb");  printf("leer %s %d\n",nam, leeo);      
     //n2=send(sock,nam,strlen(nam),0);
             n3 = fread(lee, 1,1,ff); n1=0; 
             while(n3>0) {if(n1==0){n2=write(sock,nam,strlen(nam));};n5=write(sock,lee,n3);/*n4=fwrite(lee,sizeof(lee),1,fo);*/;n3 = fread(lee,1,1, ff);n1++;}          
     ;printf("FUNCIONANDO %d %d %d\n",n1,n2,n5,1 );  
     if(n2==strlen(nam)){;} else printf("FALLO n2 %d \n",n2);if(n3==leeo){;} else printf("FALLO n3 %d \n",n3);;
     };};}  
  else {printf("NO FUNCIONA\n");/*close(sock)*/;} 
  shmdt(nam);sleep(0.5);close(sock);printf("result %d %d\n ",n2,n3);exit(0);} 

int main( int argc, char *argv[] ) {int sockfd, newsockfd, portno, clilen,n, pid;
  /*char buffer[256];*/ struct sockaddr_in serv_addr, cli_addr;sockfd=socket(AF_INET,SOCK_STREAM,0);
  if (sockfd < 0) {perror("ERROR opening socket"); exit(1);}portno = 5001;
  while(1) { bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);/*printf("server en %i\n", getpid());*/
    if (bind(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr))<0){portno++;;} 
    else {break;}  }
  listen(sockfd,5);clilen = sizeof(cli_addr);/*printf("original en %i\n", getpid() );*/
  while (1) {/*printf("copia en %i\n", getpid() );printf("ESPERANDO en %i\n", getpid());*/
    newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
    if (newsockfd < 0) {perror("ERROR on accept"); exit(1);} pid = fork();
    if (pid<0) { perror("ERROR on fork"); exit(1);}
    if (pid==0){close(sockfd); doprocessing(newsockfd);exit(0);} 
    else {/*printf("PADRE %i cierro %i",getpid(),newsockfd );*/close(newsockfd);} } 
}
