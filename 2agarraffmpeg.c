#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  char lee[2];
  char *ll, *ll2, *s1, *sa2, *temporal, *aejec, *leey, *uploaderchi, *uploaderchi2, *uploaderchi3, *uploaderchi4, *campo, *textopagina, *textopagina2, *uploaderchi5;
  int textopi,textopi2, p,i, hi, exito, leei, lee2, sa2i, s1i, upi, upi2, upi4,upi5, campoi, encontro;
  long int l, r;
  char textopag[]="<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte </title><script src=\"../../dashjs/dist/dash.all.debug.js\"></script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte </h1><div align=center style=\"width:80%;position: relative; top:20%;left:10%;\">\n<video autoplay preload=\"true\" controls=\"true\">\n</video>\n</div></body></html>  ";
  FILE *erchi;
  textopi=strlen(textopag)+1024;
  textopagina=calloc(textopi, sizeof(char));
  strncpy(textopagina, textopag, strlen(textopag));
  textopagina[strlen(textopag)]='\0';
  textopi2=strlen(textopag)+1024;
  textopagina2=calloc(textopi, sizeof(char));
  memset(textopagina2, 0, textopi2);
  temporal=calloc(20,sizeof(char));
  memset(temporal, 0, 20);
  upi5=1024;
  uploaderchi5=calloc(upi5,sizeof(char));
  memset(uploaderchi5, 0, upi5);
  upi4=8;
  uploaderchi4=calloc(upi4,sizeof(char));
  memset(uploaderchi4, 0, upi4);
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
  p=0;
  i=0;
  printf("\n COMIENZA \n");
  ll=strstr(sa2, "ffmpeg ");
  while(ll) {
    uploaderchi4[0]=' ';
    uploaderchi4[1]='\0';
    ll=strstr(sa2, "ffmpeg ");
    if(ll) {
      l=0;
      r=(long int)(&(*strchr(ll, '\n')));
      if (r) {
	l=r-(long int)(&(*ll));
	uploaderchi4[0]=' ';
	uploaderchi4[1]='\0';
	while(l>upi4-1) {
	  free(temporal);
	  temporal=calloc(upi4, sizeof(char));
	  strncpy(temporal, uploaderchi4, upi4);
	  free(uploaderchi4);
	  uploaderchi4=calloc(upi4+1024, sizeof(char));
	  strncpy(uploaderchi4, temporal, upi4);
	  upi4+=1024;
	}
	strncpy(uploaderchi4, ll+strlen("ffmpeg "), l-strlen("ffmpeg "));
        uploaderchi4[l-strlen("ffmpeg ")]='\0';
	if(strstr(uploaderchi4, " -i ")) {
	printf(">>%s<<\n", uploaderchi4);
	ll2=strstr(uploaderchi4, " ")+1;
	while(ll2!=NULL) {
	  while(ll2[0]==' ') ll2++;
	  if(strlen(ll2)){
	  if(ll2[0]=='-') {
	    if(!strncmp(ll2, "-i ", 3)) {
	      while(strlen(ll2)>upi) {
		free(temporal);
		temporal=calloc(upi, sizeof(char));
		strncpy(temporal, uploaderchi, upi);
		free(uploaderchi);
		uploaderchi=calloc(upi+1024, sizeof(char));
		strncpy(uploaderchi, temporal, upi);
		upi+=1024;
	      }
	      ll2=ll2+strlen("-i ");
	      while(ll2[0]==' ') ll2++;
	      strncpy(uploaderchi, ll2, (&(*strstr(ll2, " ")))-(&(*ll2)));
	      uploaderchi[(&(*strstr(ll2, " ")))-(&(*ll2))]='\0';
	      printf("\n POSIBLE:<<< %s  \n", uploaderchi);
	      while(ll2[0]!=' ') ll2++;
	    } else {
	      ll2+=strlen("-");
	      ll2=strstr(ll2, " ");
	      while(ll2[0]==' ')ll2++;
	      if(ll2[0]!='-') {
		ll2=strstr(ll2, " ")+1;
	      }
	    }
	    ll2--;
	  } else {
	    strncpy(uploaderchi2, ll2, (&(*strstr(ll2, " ")))-(&(*uploaderchi4)));
	    uploaderchi2[(&(*strstr(ll2, " ")))-(&(*uploaderchi4))-1]='\0';
	    printf("POSIBLE>>: %s\n", uploaderchi2);
	    if(fopen(uploaderchi2, "r")>0) {
	      while(strlen(s1)+strlen("<source src=\"\"> ") + strlen(uploaderchi2)+1 > s1i) {
		free(temporal);
		temporal=calloc(s1i, sizeof(char));
		strncpy(temporal, s1, s1i);
		free(s1);
		s1=calloc(s1i+1024, sizeof(char));
		strncpy(s1, temporal, s1i);
		s1i+=1024;
	      }
	      s1[0]='\0';
	      strcat(s1, "<source src=\"../");
	      strcat(s1, uploaderchi2);
	      strcat(s1, "\">");
	      printf("POSIBLE SALIDA: %s\n", uploaderchi2);
	    }
	  }
	  }
	  if(ll2 && strlen(ll2)) {
	    uploaderchi4=ll2;
	    //printf("\n ({{ %d:%d %s }})  \n", (&(*ll2)), strlen(uploaderchi4), uploaderchi4);
	  } else break;;
	  ll2=strstr(uploaderchi4, " ")+1;
	}
	}
	printf("\n ((((( %s ))))  \n", uploaderchi4);
      }
      printf(">>>>>>>>>%s<<<<<<<<\n", s1);
      if(strstr(s1, "src=\"..")!=NULL) {
	uploaderchi5[0]='\0';
	strncpy(uploaderchi5, s1+((&(*strstr(s1, "src=\"../")))-(&(*s1)))+strlen("src=\"../"), ((&(*strstr(strstr(s1, "src=\"../")+strlen("src=\"../"), "/")))-((&(*strstr(s1, "src=\"../")))+strlen("src=\"../")))+1);
	uploaderchi5[((&(*strstr(strstr(s1, "src=\"../")+strlen("src=\"../"), "/")))-((&(*strstr(s1, "src=\"../")))+strlen("src=\"../")))+1]='\0';
	printf("%s\n", uploaderchi5);
	strncpy(uploaderchi5+strlen(uploaderchi5), uploaderchi, strlen(uploaderchi)+1);
	strcpy(uploaderchi5+strlen(uploaderchi5), ".html");
	erchi=fopen(uploaderchi5, "r");
	printf("%s\n", uploaderchi5);
	if(erchi>0) {
	  printf("EL VISOR EXISTE");
	  hi=fread(lee, 1, 1, erchi);
	  lee2=0;
	  textopagina[0]='\0';
	  while(hi>0) {
	    lee[1]='\0';
	    lee2++;
	    if(lee2>textopi) {
	      free(temporal);
	      temporal=calloc(textopi, sizeof(char));
	      strncpy(temporal, textopagina, textopi);
	      free(textopagina);
	      textopagina=calloc(textopi+1024, sizeof(char));
	      strncpy(textopagina, temporal, textopi);
	      textopi+=1024;
	    }
	    textopagina[lee2-1]=lee[0];
	    textopagina[lee2]='\0';
	    hi=fread(lee, 1, 1, erchi);
	  }
	  fclose(erchi);

	  if(!strstr(strstr(textopagina, "<video"), s1)) {
	    textopagina2[0]='\0';
	    strncpy(textopagina2, textopagina, ((&(*strstr(textopagina, "</video")))-(&(*textopagina))));
	    textopagina2[((&(*strstr(textopagina, "</video")))-(&(*textopagina)))]='\0';
	    strcat(textopagina2, s1);
	    lee2=strlen(textopagina2);
	    strncpy(textopagina2+strlen(textopagina2), strstr(textopagina, "</video"), strlen(strstr(textopagina, "</video")));
	    textopagina2[lee2+((&(*strstr(strstr(textopagina, "</title"), "</h1")))-(&(*strstr(textopagina, "</title"))))]='\0';
	    printf("_________\n%s\n__________\n", textopagina2);
	  }
	} else {
	  if(textopi2<textopi+(strlen(uploaderchi)*3)+strlen(s1)) {
	    free(temporal);
	    temporal=calloc(textopi2, sizeof(char));
	    strncpy(temporal, textopagina2, textopi2);
	    free(textopagina2);
	    textopagina2=calloc(textopi2+1024, sizeof(char));
	    strncpy(textopagina2, temporal, textopi2);
	    textopi2+=1024;
	  }

	  lee2=0;
	  textopagina2[0]='\0';
	  strncpy(textopagina2, textopagina, ((&(*strstr(textopagina, "</title")))-(&(*textopagina))));
	  textopagina2[((&(*strstr(textopagina, "</title")))-(&(*textopagina)))]='\0';
	  strcat(textopagina2, uploaderchi);
	  lee2=strlen(textopagina2);
	  strncpy(textopagina2+strlen(textopagina2), strstr(textopagina, "</title"), ((&(*strstr(strstr(textopagina, "</title"), "</h1")))-(&(*strstr(textopagina, "</title")))));
	  textopagina2[lee2+((&(*strstr(strstr(textopagina, "</title"), "</h1")))-(&(*strstr(textopagina, "</title"))))]='\0';
	  strcat(textopagina2, uploaderchi);

	  lee2=strlen(textopagina2);
	  strncpy(textopagina2+strlen(textopagina2), strstr(textopagina, "</h1"), ((&(*strstr(strstr(textopagina, "</h1"), "</video")))-(&(*strstr(textopagina, "</h1")))));
	  textopagina2[lee2+((&(*strstr(strstr(textopagina, "</h1"), "</video")))-(&(*strstr(textopagina, "</h1"))))]='\0';
	  strcat(textopagina2, s1);

	  lee2=strlen(textopagina2);
	  strncpy(textopagina2+strlen(textopagina2), strstr(textopagina, "</video"), strlen(strstr(textopagina, "</video")));
	  textopagina2[lee2+strlen(strstr(textopagina, "</video"))]='\0';	
	  printf("_________\n%s\n__________\n", textopagina2);
	}
	erchi=fopen(uploaderchi5, "w+");
	fwrite(textopagina2, sizeof(char), strlen(textopagina2), erchi);
	fclose(erchi);
      }
      sa2+=((long int)(&(*ll))-(long int)(&(*sa2)))+1;
      printf(" >>>>>>>>%d<<<<<<<<<< \n", (&(*sa2)));
      //printf(" %s \n", sa2);
    }
  }
  return  1;
}
