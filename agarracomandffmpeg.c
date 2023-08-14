#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  char ext1[5], ext2[4], ext3[6], lee[2];
  char *s1, *sa2, *temporal, *aejec, *leey, *uploaderchi, *uploaderchi2, *uploaderchi3, *campo;
  int p,i, hi, exito, leei, lee2, sa2i, s1i, upi, upi2, campoi, encontro;

  memset (ext1, 0, 5);
  memset (ext2, 0, 5);
  memset (ext3, 0, 6);
  temporal=calloc(20,sizeof(char));
  memset(temporal, 0, 20);
  upi=8;
  uploaderchi=calloc(upi,sizeof(char));
  memset(uploaderchi, 0, upi);
  upi2=1024;
  uploaderchi2=calloc(upi2,sizeof(char));
  memset(uploaderchi2, 0, upi2);
  campoi=64;
  campo=calloc(upi2,sizeof(char));
  memset(campo, 0, campoi);
  s1=calloc(1024, sizeof(char));
  s1i=1024;
  s1[0]='!';
  s1[1]='\0';
  uploaderchi[0]=' ';
  uploaderchi[1]='\0';
  sa2=calloc(1024, sizeof(char));
  sa2i=1024;
  sa2[0]=' ';
  sa2[1]='\0';
  leey=calloc(1, sizeof(char));
  aejec=calloc(1, sizeof(char));
  aejec[0]='\0';
  aejec=calloc(20, sizeof(char));
  encontro=0;
  char s3[]={'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'};

  if(argc<2) {
    printf(" DESDE STDIN \n");
    exito=1;
    lee2=0;
    while(exito>0) {
      exito=fread(lee, 1, 1, stdin);
      lee[1]='\0';
      strcat(sa2, lee);;
      lee2++;
      while(lee2>sa2i-2) {
	free(temporal);
	temporal=calloc(sa2i, sizeof(char));
	strncpy(temporal, sa2, sa2i);
	free(sa2);
	sa2=calloc(sa2i+1024, sizeof(char));
	strncpy(sa2, temporal, sa2i);
	sa2i+=1024;
      }
    }
    sa2[lee2]='\0';
  }

  for (i = 1; i < argc; i++) {
      sa2[strlen(sa2)]='\0';
      FILE *pp=fopen(argv[i], "r");
      leei=1;
      lee2=strlen(sa2);
      while(fread(lee, sizeof(char), 1, pp)>0) {
	lee[1]='\0';
	lee2++;
	while(lee2>sa2i-1) {
	  free(temporal);
	  temporal=calloc(sa2i, sizeof(char));
	  strncpy(temporal, sa2, sa2i);
	  free(sa2);
	  sa2=calloc(sa2i+1024, sizeof(char));
	  strncpy(sa2, temporal, sa2i);
	  sa2i+=1024;
	}	    
	strcat(sa2, lee);
      }
      hi=pclose(pp);
  }

  char *textopagina;
  textopagina=calloc(strlen("<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte </title><script src=\"../../dashjs/dist/dash.all.debug.js\"></script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte </h1><div align=center style=\"width:80%;position: relative; top:20%;left:10%;\">\n<video autoplay preload=\"true\" controls=\"true\">\n</video>\n</div></body></html>  ")+2, sizeof(char));
  textopagina[0]=' ';
  textopagina[1]='\0';
  strcat(textopagina,"<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte </title><script src=\"../../dashjs/dist/dash.all.debug.js\"></script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte </h1><div align=center style=\"width:80%;position: relative; top:20%;left:10%;\">\n<video autoplay preload=\"true\" controls=\"true\">\n</video>\n</div></body></html>  ");
  /*  char *indice;
  indice=calloc(strlen("<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte </title><style>table,td {border-width:1px;border-collapse:collapse;width:70%;}</style></head><body><table></table></body></html>  ")+2, sizeof(char));
  indice[0]=' ';
  indice[1]='\0';
  strcat(indice, "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte </title><style>table,td {border-width:1px;border-collapse:collapse;width:70%;}</style></head><body><table></table></body></html>");*/
  char indice[]="<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte </title><style>table,td {border-width:1px;border-collapse:collapse;width:70%;}</style></head><body><table></table></body></html>";
  p=0;
  i=0;
  printf("\n COMIENZA \n");
  while(p<sa2i && sa2[p]!=0) {
    if(sa2[p]=='\n') {
      while(i<p) {
	while(sa2[i]==' ') i++;
	if(!strncmp(sa2+i, "ffmpeg ", strlen("ffmpeg "))) {
	  printf("\n ENCONTRE FFMPEG \n");
	  i+=strlen("ffmpeg");
	  leei=i;
	  while(leei<p) {
	    while(sa2[leei]==' ' && leei<p) leei++;
	    //printf("\n>%c %d %d %d<\n ", sa2[leei], p, strlen(sa2), sa2i);
	    if(sa2[leei]=='-') {
	      lee2=1;
	      while(leei<p && sa2[leei]!=' ') {
		campo[lee2-1]=sa2[leei];
		campo[lee2]='\0';
		leei++;
		lee2++;
		while(lee2>campoi-1) {
		  free(temporal);
		  temporal=calloc(campoi, sizeof(char));
		  strncpy(temporal, campo, campoi);
		  free(campo);
		  campo=calloc(campoi+64, sizeof(char));
		  strncpy(campo, temporal, campoi);
		  campoi+=64;
		}	    
	      }
	      while(sa2[leei]==' ' && leei<p) leei++;
	      if(sa2[leei]!='-') {
		if(strcmp(campo, "-i")) {
		  while(sa2[leei]!=' ' && leei<p) leei++;
		} else {
		  while(sa2[leei]==' ') leei++;
		  printf("Entro como: ");
		  lee2=1;
		  while(leei<p && sa2[leei]!=' ') {
		    uploaderchi[lee2-1]=sa2[leei];
		    uploaderchi[lee2]='\0';
		    leei++;
		    lee2++;
		    while(lee2>upi-1) {
		      free(temporal);
		      temporal=calloc(upi, sizeof(char));
		      strncpy(temporal, uploaderchi, upi);
		      free(uploaderchi);
		      uploaderchi=calloc(upi+1024, sizeof(char));
		      strncpy(uploaderchi, temporal, upi);
		      upi+=1024;
		    }	    
		  }
		  printf(" %s \n", uploaderchi);
		}
	      }
	    } else {
	      lee2=strlen(uploaderchi2)+strlen("<source src=\"../> ")+10;
	      if(lee2>upi2-1) {
		free(temporal);
		temporal=calloc(upi2, sizeof(char));
		strncpy(temporal, uploaderchi2, upi2);
		free(uploaderchi2);
		uploaderchi2=calloc(upi2+64, sizeof(char));
		strncpy(uploaderchi2, temporal, upi2);
		upi2+=64;
	      }
	      strcat(uploaderchi2, "<source src=\"../");
	      lee2=strlen(uploaderchi2);

	      while(sa2[leei]!=' ' && leei<p) {
		uploaderchi2[lee2]=sa2[leei];
		leei++;
		lee2++;
		while(lee2>upi2-1) {
		  free(temporal);
		  temporal=calloc(upi2, sizeof(char));
		  strncpy(temporal, uploaderchi2, upi2);
		  free(uploaderchi2);
		  uploaderchi2=calloc(upi2+64, sizeof(char));
		  strncpy(uploaderchi2, temporal, upi2);
		  upi2+=64;
		}	    
		uploaderchi2[lee2]='\0';
	      }
	      if(lee2) {
		strcat(uploaderchi2, "\"/>");
	      }
	    }
	  }
	}
	i++;
      }
    }
    p++;
  }
  /*
  char *ll=strstr(indice, "</title");
  long int l=0;
  long int r=(long int)(&(*indice));
  if(ll) l=(-r+(long int)(&(*ll)));
  */
  uploaderchi3=calloc(strlen("peliculas/")+strlen(uploaderchi)+strlen(".html")+2, sizeof(char));
  free(s1);
  s1=calloc(strlen(uploaderchi)*2+strlen(textopagina)+strlen(uploaderchi2)+2, sizeof(char));
  sprintf(s1, "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte %s</title><script src=\"../../dashjs/dist/dash.all.debug.js\"></script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte %s</h1><div align=center style=\"width:80%;position: relative; top:20%;left:10%;\">\n<video autoplay preload=\"true\" controls=\"true\">%s\n</video>\n</div></body></html>", uploaderchi, uploaderchi, uploaderchi2);
  sprintf(uploaderchi3, "peliculas/%s.html", uploaderchi);
  FILE *f=fopen(uploaderchi3, "a+");
  p=fread(lee, 1, 1, f);
  if(p<=0) {
    fclose(f);
    f=fopen(uploaderchi3, "w+");
    printf("\n CREANDO \n %s \n", uploaderchi3);
    fwrite(s1, sizeof(char), strlen(s1), f);
  } else {
    fclose(f);
    fopen(uploaderchi3, "r+");
    leei=-7;
    p=1;
    while(p>0) {
      leei--;
      fseek(f, leei, SEEK_END);
      p=fread(s3, sizeof(char), 7, f);
      s3[8]='\0';
      if(p>0 && !strcmp(s3, "</video")) {
	fseek(f, leei, SEEK_END);
	exito=1;
	sa2[0]=' ';
	sa2[1]='\0';
	while(exito>0) {
	  exito=fread(lee, 1, 1, f);
	  lee[1]='\0';
	  lee2++;
	  while(lee2>sa2i-1) {
	    free(temporal);
	    temporal=calloc(sa2i, sizeof(char));
	    strncpy(temporal, sa2, sa2i);
	    free(sa2);
	    sa2=calloc(sa2i+1024, sizeof(char));
	    strncpy(sa2, temporal, sa2i);
	    sa2i+=1024;
	  }
	  strcat(sa2, lee);
	}
	fseek(f, leei, SEEK_END);
	fwrite(uploaderchi2, sizeof(char), strlen(uploaderchi2), f);
	fwrite(sa2, sizeof(char), strlen(sa2), f);
	break;
      }
    }
  }
  fclose(f);
  return  1;
}
