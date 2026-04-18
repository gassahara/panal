/************* UDP SERVER CODE *******************/
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <stdlib.h>
char *subStr(char* str_src,int pos_ini,int cant_mov){char *subst=calloc(1,cant_mov+2),*cual[1]; int cont_mov=0,cunt_mov=0,gcant_mov=0,ggcant_mov=0,gcont_mov=0,ggcont_mov=0,ci=0,cii=0,gci=0,ggci=0,ggcii=0,gcii=0,trig=0;
*cual=strchr(str_src,46);if(*cual!=NULL){gci= (strlen(str_src)-strlen(*cual))+1;ggci=  (str_src[gci])-48;*cual=*cual+1; 
*cual=strchr(*cual,46);  if(*cual!=NULL){gcii=(strlen(str_src)-strlen(*cual))+1;ggcii= (str_src[gcii])-48;}}gcont_mov=strlen(str_src);
             while(cont_mov<=gcont_mov+0){ if(cont_mov>=pos_ini){if(cunt_mov<=cant_mov){ subst[cont_mov-pos_ini]=*str_src;cunt_mov++;} } 
				                                                 *str_src++;cont_mov++;}return subst;}  
 
char ursok(char *yega, char *direc, int puert){int miSocket, nBytes, nBytez=strlen(yega); struct sockaddr_in serverAddr,clientAddr;char buffer[1024]="",bufffer[1024]="",myvar[1024]="";struct sockaddr_storage serverStorage; socklen_t addr_size, client_addr_size; int i;
  miSocket = socket(PF_INET, SOCK_DGRAM, 0); serverAddr.sin_family = AF_INET; 
  serverAddr.sin_port = htons(puert); serverAddr.sin_addr.s_addr = inet_addr(direc);
  memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);if(bind(miSocket,(struct sockaddr *) &serverAddr, sizeof(serverAddr))==-1) printf ("error serving \n");addr_size = sizeof serverStorage;
  while(1){nBytes = recvfrom(miSocket,bufffer,1024,0,(struct sockaddr *)&serverStorage, &addr_size)+1;    printf (" bufffer <%s>  \n",bufffer);
    for(i=0;i<nBytes-1;i++) {strcpy(myvar,subStr( yega ,i ,strlen(bufffer)-1) ); /* */ printf ("yega <%s> <%d> \n",yega,nBytez);
		                     if (strcmp(myvar,bufffer)==0){sendto(miSocket,yega,nBytez+1,0,(struct sockaddr *)&serverStorage,addr_size); i=nBytes+1;break; } 
		                     else                         {sendto(miSocket,buffer,nBytes,0,(struct sockaddr *)&serverStorage,addr_size)  ;} } } return 0;} 
           			   
int main(int argc, char* argv[]){ char recursos_contexto[1024],bwfffer[1024];strcpy(recursos_contexto, "agua=agua-1");                          
                                  printf("%d",ursok(recursos_contexto,"127.0.0.1",7891));             } 
/*strcpy(nam, subStr(argv[0],2,strlen(argv[0]) ));strcat(nam,".c"); 
  strcpy(name,"./hellosh.sh " );strcat(name,nam);system (name); return EXIT_SUCCESS;}*/ 
 
