#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdarg.h> 
#include <assert.h>
#include <ctype.h>     
#include <sys/types.h> 
#include <strings.h>

char *subStr(char* str_src,int pos_ini,int cant_mov){char *subst=calloc(1,cant_mov+2),*cual[1]; int cont_mov=0,cunt_mov=0,gcant_mov=0,ggcant_mov=0,gcont_mov=0,ggcont_mov=0,ci=0,cii=0,gci=0,ggci=0,ggcii=0,gcii=0,trig=0;
  *cual=strchr(str_src,46);if(*cual!=NULL){gci= (strlen(str_src)-strlen(*cual))+1;ggci=  (str_src[gci])-48;*cual=*cual+1;  
    *cual=strchr(*cual,46);  if(*cual!=NULL){gcii=(strlen(str_src)-strlen(*cual))+1;ggcii= (str_src[gcii])-48;}}gcont_mov=strlen(str_src);
  while(cont_mov<=gcont_mov+0){ if(cont_mov>=pos_ini){if(cunt_mov<=cant_mov){ subst[cont_mov-pos_ini]=*str_src;cunt_mov++;} } 
    *str_src++;cont_mov++;}return subst;} 
				                                                 
int main(int argc, char *argv[]){int ci=0,cii=0,kon0=0,kon10=0,kon20=0,kon30=0,kon=0,kon1=0,kon2=0,kon3=0,kontadorhijos=0;; 
  char *see=calloc(1,1),*cual[1], separa2[][256]={"head","form","div","body","footer"};
  char texxt[2],tag[2048],palabra[2048],auxiliar[2048],auxiliar2[2048];memset(texxt,0,2); memset(palabra,0,2048);memset(auxiliar,0,2048);memset(auxiliar2,0,2048);memset(tag,0,2048);  
	                                               
  while(fread(texxt, sizeof(char), 1, stdin)>0) {strcat(palabra,texxt);
    if(palabra[kon]==60 ) { kontadorhijos++;kon10=0; }
    else {if(palabra[kon]==62) {if (kon10==1){strcpy(auxiliar,palabra) ; kontadorhijos--; kon10=0; }
	else {
	  if(strcmp( subStr(palabra,strlen(auxiliar)+1,kon - 2),argv[1])==0){ kon2=1;} ;strcpy(auxiliar,palabra) ;kon30=strlen(tag) ; 
	  strcpy(tag,subStr(palabra,strlen(tag)-0,strlen(palabra))) ;}
	if(kontadorhijos==1){ ;}else {;} }       
      else{
	if(palabra[kon]==(char)47 ) { kon10=1;strcpy(auxiliar2,subStr(palabra,strlen(tag),(kon-strlen(tag) ) -2)) ;
	  if(kon2==1){ printf("chek this %s\n ",subStr(palabra,strlen(auxiliar),(kon-strlen(tag) ) -2 ));kon2=0;} };} } kon++;} }
