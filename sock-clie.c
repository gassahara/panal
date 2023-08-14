/************* UDP CLIENT CODE *******************/
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
char *misok(char *yega, char *direc, int puert){int miSocket, nBytes;struct sockaddr_in serverAddr;socklen_t addr_size;char buffer[1024];  
  miSocket = socket(PF_INET, SOCK_DGRAM, 0); serverAddr.sin_family = AF_INET; 
  serverAddr.sin_port = htons(puert);serverAddr.sin_addr.s_addr = inet_addr(direc);  
  memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero); addr_size = sizeof serverAddr;                                    
  while(1){nBytes = strlen(yega) +1;if (sendto(miSocket,yega,nBytes,0,(struct sockaddr *)&serverAddr,addr_size)==-1) printf("error \n"); 
           if(nBytes = recvfrom(miSocket,buffer,1024,0,NULL, NULL)<=0) {printf("error conect\n");return 0; }
           else                                                         {printf("Received from server: %s\n",buffer);return buffer; } } return 0; }

int main(int argc, char* argv[]){ int i;char *nam,*name[sizeof(argv[0])],recursos_contexto[1024],*mybar;strcpy( recursos_contexto,"agua");float c_recursos_contexto=100;
	                              printf("<%s>",misok(recursos_contexto,"127.0.0.1",7891));
	                                                            

/*strcpy(nam, subStr(argv[0],2,strlen(argv[0]) ));strcat(nam,".c");  
  strcpy(name,"./hellosh.sh " );strcat(name,nam);system (name); return EXIT_SUCCESS;}*/ 
}
