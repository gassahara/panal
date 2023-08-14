#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  char ss[550], sss[6000];
  char ext1[5], ext2[4], ext3[6], lee[2];
  char *s1, *sa2, *temporal, *uploaderchi, *aejec, *leey, *pelaculas, *tpeliculas;
  int p,i, exito, hi, hi2, fps, fps2, fpsale, leei, lee2, sa2i;

  memset (ext1, 0, 5);
  memset (ext2, 0, 5);
  memset (ext3, 0, 6);
  uploaderchi=calloc(20, sizeof(char));
  pelaculas=calloc(20, sizeof(char));
  tpeliculas=calloc(20, sizeof(char));
  memset(tpeliculas, '!', sizeof(temporal)-1);
  temporal=calloc(20,sizeof(char));
  memset(temporal, 0, sizeof(temporal));
  s1=calloc(2, sizeof(char));
  s1[0]='!';
  s1[1]='\0';
  sa2=calloc(1024, sizeof(char));
  sa2i=1024;
  sa2[0]=' ';
  sa2[1]='\0';
  leey=calloc(1, sizeof(char));
  aejec=calloc(1, sizeof(char));
  aejec[0]='\0';
  aejec=calloc(20, sizeof(char));
  fps=15;fps2=600;
  char prueba2[]=" 600 600  \0";
  char pruebas[]=",,,\0";
  char s3[]={'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'};

  if(argc<2) {
    int comillas=0;
    free(uploaderchi);
    uploaderchi=calloc(255, sizeof(char));
    memset(uploaderchi, 0, 255);
    uploaderchi[0]='\0';
    //sprintf(uploaderchi, " ");
    printf(" DESDE STDIN \n");
    lee[1]='\0';
    while(fread(lee, 1, 1, stdin)>0) {
      lee[1]='\0';
      if((lee[0] != '\n'  || comillas) && lee[0] != '\"') {
	strcat(uploaderchi, lee);
      }
      if(lee[0]=='\"' || (!strchr(uploaderchi, '\"') && lee[0]==' ')) {
	if(comillas==1 || (!strchr(uploaderchi, '\"') && lee[0]==' ')) {
	  comillas=0;
	  printf("|%s>\n", uploaderchi);
	  argv[argc]=calloc(strlen(uploaderchi)+1, sizeof(char));
	  memset(argv[argc], 0, strlen(uploaderchi)+1);
	  strncpy(argv[argc], uploaderchi, strlen(uploaderchi));
	  uploaderchi[0]='\0';
	  //printf("|%s (%d)(%d) |\n", argv[argc], argc, strlen(argv[argc]));
	  argc++;
	} else comillas=1;
      }
      //printf(">%s (%d)< ", uploaderchi, argc);
    }
  }

  char textopagina[] = "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte </title><script src=\"../../dashjs/dist/dash.all.debug.js\"></script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte </h1><div align=center style=\"width:80%;position: relative; top:20%;left:10%;\">\n<video autoplay preload=\"true\" controls=\"true\">\n</video>\n</div></body></html>  ";
  textopagina[sizeof(textopagina)-1]='\0';
  char indice[] = "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte </title><style>table,td {border-width:1px;border-collapse:collapse;width:70%;}</style></head><body><table></table></body></html>  ";
  indice[sizeof(indice)-1]='\0';
  
  if(strlen(uploaderchi)>0) {
    printf("|%s>\n", uploaderchi);
    argv[argc]=calloc(strlen(uploaderchi)+1, sizeof(char));
    memset(argv[argc], 0, strlen(uploaderchi)+1);
    strncpy(argv[argc], uploaderchi, strlen(uploaderchi));
    uploaderchi[0]='\0';
    //printf("|%s (%d)(%d) |\n", argv[argc], argc, strlen(argv[argc]));
    argc++;
  }
  printf("\n<<< -----------  >>>\n");
  for (i = 1; i < argc; i++) {
    free(uploaderchi);
    uploaderchi=calloc(strlen(argv[i])+1, sizeof(char));
    memset(uploaderchi, 0, strlen(argv[i])+1);
    strncpy(uploaderchi, argv[i], strlen(argv[i])+1);
    printf("\n<<<lee (%d) <%s>  >>> <%s>\n", i, argv[i], uploaderchi);

    int slen=strlen(uploaderchi);
    memcpy(ext1, uploaderchi+(slen-4), (size_t)4);
    memcpy(ext2, uploaderchi+(slen-3), (size_t)3);
    memcpy(ext3, uploaderchi+(slen-5), (size_t)5);
    if(!strcmp(ext1, "webm") || !strcmp(ext3, "webm\"") || !strcmp(ext1, "mpg\"") ||  !strcmp(ext1, "mp4\"") || !strcmp(ext2, "mp4")  || !strcmp(ext2, "mpg")) {
      free(aejec);
      aejec=calloc((strlen(uploaderchi)*3)+strlen("ffmpeg -ss 3 -i  -frames:v 5 -vf \"select=gt(scene\\,0.4)\" -vsync vfr -vf fps=fps=/600 peliculas/thumb%s-%02d.jpg 1>>.comepeliculas.log 2>&1")+10, sizeof(char));
      memset(aejec, 0, (strlen(uploaderchi)*3)+strlen("ffmpeg -ss 3 -i -frames:v 5 -vf \"select=gt(scene\\,0.4)\" -vsync vfr -vf fps=fps=/600 peliculas/thumb%s-%02d.jpg 1>comepeliculas.log 2>&1")+10);

      exito=0;
      hi2=0;
      while(!exito) {
	sprintf(aejec, "rm peliculas/thumb%s*", uploaderchi);
	system(aejec);
	sprintf(aejec,"ffmpeg -ss 3 -i %s -frames:v 5 -vf \"select=gt(scene\\,0.4)\" -vsync vfr -vf fps=fps=%d/%d peliculas/thumb%s-%c02d.jpg -y 1>%s.comepeliculas.log 2>&1", uploaderchi, fps, fps2, uploaderchi, '%', uploaderchi);
	hi=system(aejec);
	sprintf(aejec, "ls -1 peliculas/thumb%s* %c wc -l", uploaderchi, '|');
	//printf("-------\n %s \n ", aejec);
	FILE *p=popen(aejec, "r");
	sprintf(aejec, "");
	leei=0;
	lee2=0;
	while(fread(lee, sizeof(char), 1, p)>0) {
	  lee[1]='\0';
	  strcat(aejec, lee);
	}	
	hi=pclose(p);
	hi=(int)strtol(aejec, NULL, 10);
	printf("\n \n thumbi=%s thumbs=%d \n", sa2, hi);
	sprintf(sa2, " ");
	sprintf(prueba2, ",%d %d,", fps, fps2);
	if(hi >= 3 && hi <= 10 && fps < 100) exito=1;
	else {
	  fpsale=0;
	  while(!fpsale) {
	    if(fps2<3) {
	      fps2=666;
	      fps=30;
	    }
	    if(fps<2) {
	      fps2=fps2*1.3;
	      fps=30;
	    }
	    if(fps>30) {
	      fps2=fps2/1.3;
	      fps=30;
	    }
	    if(hi < 4) {
	      fps++;
	    }
	    if(hi > 10) {
	      fps--;
	    }
	    if (hi2>600) {
	      fps=1000;
	      break;
	    }
	    memset(prueba2, 0, strlen(prueba2));
	    sprintf(aejec, "& %d %d", fps, fps2);
	    if(strstr(pruebas, aejec)) fpsale=0;
	    else fpsale=1;
	    printf("\n \n %d %d PROBANDO %s \n hemos probado %s \n ", hi, hi2, prueba2, pruebas);
	  }
	  hi2++;
	  if(fps==1000) break;
	  strcat(pruebas, prueba2);
	}
      }

	printf("-------\n %s \n ", aejec);

	leei=(strlen(uploaderchi)+strlen("<tr><td><a href=\".html\"></a></td><td>")+3);
      while(leei>sa2i-1) {
	free(temporal);
	temporal=calloc(sa2i, sizeof(char));
	strncpy(temporal, sa2, sa2i);
	free(sa2);
	sa2=calloc(sa2i+1024, sizeof(char));
	strncpy(sa2, temporal, sa2i);
	sa2i+=1024;
      }	    

      sa2[0]='\0';
      strcat(sa2, uploaderchi);
      strcat(sa2, ": \">");
      //printf("\n---------------------------\n CRANDO s1 %s \n -------------------------\n", s1);
      printf("-------\n thumbs=%02d frames=%d tiempo=%d \n ", strtol(aejec, NULL, 10), fps, fps2);
      sprintf(aejec, "ls -1 peliculas/thumb%s* ", uploaderchi);
      printf("-------\n %s \n ", aejec);
      strcat(sa2, "<img src=\"");
      sa2[strlen(sa2)-1]='\0';
      //printf("\n>%s<\n", sa2);
      FILE *pp=popen(aejec, "r");
      leei=1;
      lee2=strlen(sa2);
      while(fread(lee, sizeof(char), 1, pp)>0) {
	lee[1]='\0';
	if(lee[0]=='\n') {
	  strcat(sa2, "\"></td></tr>");
	  lee2+=strlen("\"></td></tr>");
	  leei=1;
	} else {
	  if(leei) {
	    strcat(sa2, "<img src=\"");
	    lee2+=strlen("\"></td></tr>");
	    leei=0;
	  }
	  strcat(sa2, lee);
	  lee2++;
	}
	while(lee2>sa2i-1) {
	  free(temporal);
	  temporal=calloc(sa2i, sizeof(char));
	  strncpy(temporal, sa2, sa2i);
	  free(sa2);
	  sa2=calloc(sa2i+1024, sizeof(char));
	  strncpy(sa2, temporal, sa2i);
	  sa2i+=1024;
	}	    
      }
      hi=pclose(pp);
      //printf("\ns1 >%s<(l %d)(s %d)\n", s1, sizeof(s1), strlen(s1));
      leei=strlen(s1);
      free(temporal);
      temporal=calloc(leei+1, sizeof(char));
      strncpy(temporal, s1, leei+1);
      free(s1);
      s1=calloc(strlen(temporal)+strlen(sa2)+2, sizeof(char));
      strncpy(s1, temporal, leei);
      strncpy(s1+leei, sa2, strlen(sa2));
      s1[leei+strlen(sa2)]='\0';
      /*      printf("\n-----------------\ntem |%s|(%d)(size %d) \n s1 |%s|(%d)(size %d) \n sa2|%s|(%d) >>>>>>>>>>>>\n ", temporal, strlen(temporal), sizeof(temporal), s1, strlen(s1), sizeof(s1),  sa2, strlen(sa2));*/
      
      sprintf(aejec, "ffmpeg -re -i %s -g 52 -ab 64k -f webm -vcodec vp8 -vb 448k -movflags frag_keyframe+empty_moov peliculas/%s.webm -y 1>>%s.comepeliculas.log 2>&1", uploaderchi, uploaderchi, uploaderchi);
      printf("-------\n %s \n ", aejec);
      exito=system(aejec);
      if(!exito) {
	printf("\n CONVERSION A webm EXITOSA\n");
	/*free(tpeliculas);
	tpeliculas=calloc(strlen("<source src=\".webm\"/>") + strlen(uploaderchi) + 3, sizeof(char));
	sprintf(tpeliculas, "<source src=\"%s.webm\"/>", uploaderchi);
	printf("\n cadenavideo=%s \n", tpeliculas);*/
      }
      else printf("\n FALLO EN LA CONVERSION WEBM \n");
      
      sprintf(aejec, "ffmpeg -re -i %s -g 52  -ab 64k -vcodec libx264 -vb 448k -f mp4 -movflags frag_keyframe+empty_moov peliculas/%s.mp4 -y 1>>%s.comepeliculas.log 2>&1", uploaderchi, uploaderchi, uploaderchi);
      printf("-------\n %s \n ", aejec); 
      exito=system(aejec);
      sprintf(aejec, " ");
    
      if(!exito) {
	printf("\n CONVERSION A MP4 EXITOSA \n");
	free(temporal);
	temporal=calloc(strlen(tpeliculas)+1, sizeof(char));
	strncpy(temporal, tpeliculas, sizeof(tpeliculas));
	free(tpeliculas);
	tpeliculas=calloc((strlen(uploaderchi)*2)+strlen("<source src=\".webm\"/> <source src=\".mp4\"/>")+2, sizeof(char));
	memset(tpeliculas, '\0', sizeof(tpeliculas));
	strcpy(tpeliculas, temporal);
	strcpy(tpeliculas+sizeof(temporal)-1, "<source src=\"%s\">");
      } else printf("\n FALLO EN LA CONVERSION A MP4\n");

      sprintf(aejec, "mv -v \"%s\" procesados/", argv[i]);
      exito=system(aejec);
      printf("-------\n %s \n ", aejec); 
      printf("\n-----------------\n cadenaindice=%s\n_______________\n ", s1);
    }
  }

  printf("   %s   ", &s1);
  return  1;
}
