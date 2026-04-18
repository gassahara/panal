#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>

char ursok(char *yega, char *direc, int puert){
  int miSocket,r, nBytes, nBytez=strlen(yega);
  struct sockaddr_in serverAddr,clientAddr;
  struct sockaddr_storage serverStorage;
  socklen_t addr_size, client_addr_size;
  int i;
  miSocket = socket(AF_INET, SOCK_STREAM, 0);
  serverAddr.sin_family = AF_INET; 
  serverAddr.sin_port = htons(puert);
  serverAddr.sin_addr.s_addr = inet_addr(direc);
  memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);
  while(bind(miSocket,(struct sockaddr *) &serverAddr, sizeof(serverAddr))==-1) {
    printf ("error serving \n");
    puert++;
    serverAddr.sin_port = htons(puert);
  }
  addr_size = sizeof serverStorage;
  listen(miSocket, 5);
  r=1;
  printf ("accept %i\n", puert);
  while(r>-1){
    r=accept(miSocket, (struct sockaddr *)&serverAddr,(socklen_t *)&addr_size);
    printf("%i [%i]", errno, strlen(yega));
    sendto(r,yega,strlen(yega),0,(struct sockaddr *)&serverStorage, (socklen_t)addr_size);
    close(r);
    /*
    nBytes=0;
    while(nBytes<1)nBytes = recv(r,buffer,1024,0);
    buffer[nBytes]='\0';
    printf ("leidos %i cadena %s\n",nBytes, buffer);
    */
  }
  return 0;
} 

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
  while(r<0) {r=connect(miSocket, (struct sockaddr *)&serverAddr,addr_size);printf("(%i)", r);}
  printf("sock %i r %i error %i", miSocket, r, errno);
  if(errno==EINPROGRESS) printf("EINPROGRESS");
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

void quitags(char *cadena) {
  int i=0;
  int ii=0;
  int l=0;
  while(strchr(cadena, '<')) {
    i=0;
    while(i < strlen(cadena)) {
      if(cadena[i]=='<') {
	ii=i;
	while (cadena[ii] != '>') ii++;
	l=ii-i;
	ii++;
	while(ii<strlen(cadena)+1) {
	  cadena[i]=cadena[ii];
	  ii++;
	  i++;
	}
	break;
      }
      i++;
    }
  }
}

void quitas(char *cadena) {
  int i=0;
  int ii=0;
  int l=0;
  if(cadena[i]==' ') {
    ii=i;
    while (cadena[ii] == ' ') ii++;
    l=ii-i;
    while(ii<strlen(cadena)+1) {
      cadena[i]=cadena[ii];
      ii++;
      i++;
    }
  }
  i=strlen(cadena);
  i--;
  if(cadena[i]==' ') {
    ii=i;
    while (cadena[ii] == ' ') ii--;
    cadena[ii+1]='\0';
  }
}

int main(int argc, char *argv[])
{
  char aejec[1024], ss[550], sss[6000];
  char lea[2];
  char *documento, *salida, *procesado, *temporal, *lee, *variable;
  int p,i,iri,ifi,i2, exito, hi, hi2, cols, colsp, procesi, sali, leei, lee2;
  char sepcelda[]="<td>\0<td \0table:table-cell\0", sepceldaf[]="</td>\0</td>\0/table:table-cell\0", seprow[]={ "</tr>\0</tr>\0table:table-row\0" };

  temporal=calloc(20,sizeof(char));
  memset(temporal, 0, sizeof(temporal));
  procesado=calloc(20,sizeof(char));
  memset(procesado, 0, sizeof(documento));
  procesi=1025;
  documento=calloc(20,sizeof(char));
  memset(documento, 0, sizeof(documento));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  sali=1024;
  salida=calloc(sali,sizeof(char));
  memset(salida, 0, sali);
  variable=calloc(1024,sizeof(char));
  memset(variable, 1024, sali);
  lee=calloc(1025, sizeof(char));
  leei=1025;


  if(argc<3) {
    memset(lee, 0, leei);
    lee2=0;
    p=1;
    while(fread(lea, sizeof(char), 1, stdin)>0) {
      lee[lee2]=lea[0];
      lee2+=1;
      while(lee2>leei-1) {
	free(temporal);
	temporal=calloc(leei, sizeof(char));
	strncpy(temporal, lee, leei);
	free(lee);
	lee=calloc(leei+1024, sizeof(char));
	strncpy(lee, temporal, leei);
	leei+=1024;
      }
    }
  }
  free(documento);
  documento=calloc(leei, sizeof(char));
  memcpy(documento, lee, leei);
  documento[leei]='\0';
  printf("Extendiendo lee\n");
  free(lee);
  lee=calloc(1024, sizeof(char));
  i=0;
  ifi=0;
  iri=0;
  while(i<sizeof(sepcelda)) {
    cols=0;
    colsp=0;
    procesado=calloc(leei, sizeof(char));
    memcpy(procesado, documento, leei);
    i2=0;
    while(i2<strlen(documento)) {
      if(strstr(documento,sepcelda+i) && strstr(documento,sepceldaf+ifi) && strstr(documento,seprow+iri)) {
	documento=strstr(documento, sepcelda+i);
	documento=strstr(documento, ">")+1;
	strncpy(procesado, documento, ((&(*strstr(documento, sepceldaf+ifi)))-(&(*(documento)))));
	procesado[((&(*strstr(documento, sepceldaf+ifi)))-(&(*(documento))))]='\0';
	quitags(procesado);
	quitas(procesado);
	documento+=(int)((&(*strstr(documento, sepceldaf+ifi)))-(&(*documento)));
	if(cols>0) {
	  if(!strstr(salida, variable)) {
	    if(strcmp(procesado, "0")==0 || strncmp(procesado, "0.0", 3)==0 || strtod(procesado, NULL)>0.00) {
	      sprintf(lee, "\ndouble %s = %06f;printf(\"<tr><td>%s</td><td>%06f</td></tr>\");",  variable, strtod(procesado, NULL), variable, strtod(procesado, NULL));
	      strcpy(variable, lee);
	    } else {
	      sprintf(lee, "\nchar *%s;\n%s=calloc(strlen(\"%s\"), sizeof(char));\nstrcpy(%s,\"%s\");\nprintf(\"<tr><td>%s</td><td>%s</td>\");", variable, variable, procesado, variable,  procesado, variable, procesado);
	      strcpy(variable, lee);
	    }
	  } else {
	    if(strcmp(procesado, "0")==0 || strncmp(procesado, "0.0", 3)==0 || strtod(procesado, NULL)>0.00) {
	      sprintf(variable, "%s=%s;\n", variable, procesado);
	    } else {
	      sprintf(lee, "free(%s);%s=calloc(strlen(\"%s\"),sizeof(char)); strcpy(%s,\"%s\");\n", variable, variable, variable, variable, procesado, variable, procesado);
	      strcpy(variable, lee);
	    }
	  }
	  while(strlen(salida)+strlen(variable)>sali) {
	    free(temporal);
	    temporal=calloc(sali, sizeof(char));
	    strncpy(temporal, salida, sali);
	    printf("Extendiendo salida\n");
	    free(salida);
	    salida=calloc(sali+1024, sizeof(char));
	    strncpy(salida, temporal, sali);
	    sali+=1024;
	    printf("salida mide %i\n", sali);
	  }
	  strcat(salida, variable);
	  //sprintf(salida, "%s%s", salida, variable);
	  variable[0]='\0';
	  cols=0;
	  documento+=(int)((&(*strstr(documento, seprow+iri)))-(&(*documento)));
	} else {
	  if(procesado && strlen(procesado)){
	    //printf("double %s=", procesado);
	    sprintf(variable, "%s", procesado);
	    cols++;
	  }else {
	    documento+=(int)((&(*strstr(documento, sepceldaf+ifi)))-(&(*documento)));
	  }
	}
      }
      documento++;
      i2++;
    }
    i+=strlen(sepcelda+i)+1;
    iri+=strlen(seprow+i)+1;
    ifi+=strlen(sepceldaf+ifi)+1;
  }
  //quitags(salida);
  //free(documento);free(procesado);
  if(strlen(salida)) ursok(salida, "127.0.0.1", strtol(argv[1], NULL, 10)+1);
  return  1;
}
