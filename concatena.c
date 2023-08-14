#include <stdio.h>  
#include <stdlib.h>      
#include <string.h> 
#include <ctype.h>     
#include <dirent.h>
#include <sys/types.h> 

int main()
{char nada[1],buf[512],buuf[512],buff[16384],kbzal1[][256]={" ","=","||","°","&&","-","+","*","/","=>"}; int in1;DIR *pdir = NULL ;	         
	     char extension[1],*punto[255], *cual[1] ; struct dirent *pant = NULL; int n=255,m=0,cbuf=512,ccbuf=0,citems=0,a=0,ga=0,aa=0,gaa=0,aaa=0,gaaa=0;

char *subStr(char* str_src,int pos_ini,int cant_mov){char *subst=calloc(1,cant_mov+2),*cual[1]; int cont_mov=0,cunt_mov=0,gcant_mov=0,ggcant_mov=0,gcont_mov=0,ggcont_mov=0,ci=0,cii=0,gci=0,ggci=0,ggcii=0,gcii=0,trig=0;
*cual=strchr(str_src,46);if(*cual!=NULL){gci= (strlen(str_src)-strlen(*cual))+1;ggci=  (str_src[gci])-48;*cual=*cual+1; 
*cual=strchr(*cual,46);  if(*cual!=NULL){gcii=(strlen(str_src)-strlen(*cual))+1;ggcii= (str_src[gcii])-48;}}gcont_mov=strlen(str_src);
             while(cont_mov<=gcont_mov+0){/*if(cont_mov==0)*/
				 if(cont_mov>=pos_ini){if(cunt_mov<=cant_mov){ subst[cont_mov-pos_ini]=*str_src;cunt_mov++;} } 
				   *str_src++;cont_mov++;} /*printf("_sub_ <%s> \n",subst);*/return subst;}
		          
char *replc(char *str_rsrc,char *str_reste,char *str_raquel){int cant_mov=0; char *subst=calloc(1,cant_mov+2),*repla=calloc(1, str_raquel), *leftt=calloc(1,1), *rright[1],*cual[1]; int cont_mov=0,cunt_mov=0,gcant_mov=0,ggcant_mov=0,gcont_mov=0,ggcont_mov=0,ci=0,cii=0,gci=0,ggci=0,ggcii=0,gcii=0,trig=0;
*cual=strchr(str_rsrc,46);if(*cual!=NULL){gci= (strlen(str_rsrc)-strlen(*cual))+1;ggci=  (str_rsrc[gci])-48;*cual=*cual+1; 
*cual=strchr(*cual,46);  if(*cual!=NULL){gcii=(strlen(str_rsrc)-strlen(*cual))+1;ggcii= (str_rsrc[gcii])-48;}}gcont_mov=strlen(str_rsrc);  cont_mov=0;
             while(cont_mov<=gcont_mov-(strlen(str_reste) )){/* printf("seeking str_reste %s en str_rsrc %s \n",str_reste, str_rsrc); */
				                                             if(strcmp(subStr(str_rsrc,cont_mov,strlen(str_reste)-1 ),str_reste)==0){printf("working");
						  /* */                                 if (cont_mov<strlen(str_reste)-1){strcat(leftt,subStr(str_rsrc,0,(cont_mov - 0 )));  } 
				                                                else { if(cont_mov>= gcont_mov-(strlen(str_raquel) ) ) { strcat(leftt,subStr(str_rsrc,0,(cont_mov-1) /* -(strlen(str_reste)-0) */));}
																	   else                                            { strcat(leftt,subStr(str_rsrc,0,(cont_mov-1))) ;} }
				                                                strcat(leftt,str_raquel); strcat(leftt,subStr(str_rsrc,cont_mov+(strlen(str_reste)-0 ),strlen(str_rsrc)-1));				                                                
				                                           } 				                                           				                                
				 /*if(cont_mov>=pos_ini){if(cunt_mov<=cant_mov){   subst[cont_mov-pos_ini]=*str_rsrc;cunt_mov++;} }*str_rsrc++;*/ 
				   cont_mov++;/* printf("cont <%s> <%s> <%d> \n",str_rsrc,leftt,cont_mov);*/}printf("D O N E %s ", leftt ); return leftt ;}

int intrch(char *str_rsrc,char *str_reste,char *str_raquel){int cant_mov=0; char *subst=calloc(1,cant_mov+2), *raux=calloc(1,str_raquel) ,*repla=calloc(1,str_raquel),*leftt[1],*rright[1],*cual[1]; int cont_mov=0,cunt_mov=0,gcant_mov=0,ggcant_mov=0,gcont_mov=0,ggcont_mov=0,ci=0,cii=0,gci=0,ggci=0,ggcii=0,gcii=0,trig=0;
*cual=strchr(str_rsrc,46);if(*cual!=NULL){gci= (strlen(str_rsrc)-strlen(*cual))+1;ggci=  (str_rsrc[gci])-48;*cual=*cual+1; 
*cual=strchr(*cual,46);  if(*cual!=NULL){gcii=(strlen(str_rsrc)-strlen(*cual))+1;ggcii= (str_rsrc[gcii])-48;}}gcont_mov=strlen(str_rsrc);
             while(cont_mov<gcont_mov-(strlen(str_reste) )){if(strcmp(subStr(str_rsrc,cont_mov,strlen(str_reste)-1),str_reste)==0){
				                                                strcpy(raux,str_reste);
				                                                if (cont_mov<strlen(str_reste)-1){strcat(leftt,subStr(str_rsrc,0,(cont_mov-1)));}
				                                                else strcat(leftt,subStr(str_rsrc,0,(cont_mov-0)-(strlen(str_reste)-0)));
				                                                
				                                                strcat(leftt,str_raquel);
				                                                printf("_se hizo cat_ <%s> \n",leftt);/*if(strlen(str_rsrc)){;}*/ ;
				                                                strcat(leftt,subStr(str_rsrc,cont_mov+(strlen(str_reste)-0 ),strlen(str_rsrc)-1));
				                                         }				                                
				 /*if(cont_mov>=pos_ini){if(cunt_mov<=cant_mov){   subst[cont_mov-pos_ini]=*str_rsrc;cunt_mov++;} }*str_rsrc++;*/ 
				   cont_mov++;printf("cont <%s> <%s> <%d> \n",str_rsrc,leftt,cont_mov);} return cont_mov ;}                                                                      
 
int listdir(const char *paath){DIR *pdyr3 ;struct dirent *pint = NULL;char *striin[255] ;pdyr3 = opendir (paath); if (pdyr3 == NULL) { return; } 
   while (pint = readdir (pdyr3)) {if (pint == NULL) {printf ("\nERROR! "); return 0;}  
	                              if (strcmp(pint->d_name,"..")==0||strcmp(pint->d_name,".")==0){;}
                                  else{ if (pint->d_type==4||pint->d_type==10){ listdir(striin) ; }
                                        else                                  {strcpy(striin,pint->d_name);printf (" adentro *%s* \n",striin);
											if(*cual!=NULL){if (strcmp(subStr(pint->d_name, (strlen(pint->d_name)-strlen(*cual)),1) ,".c")==0) 
													               {  printf("en %d +++ my eye upon %s ",1, subStr(pint->d_name, 0,(strlen(pint->d_name)-strlen(*cual))-1)  ) ;} *cual=NULL;}
											}									 									  
									     } }   
   return 0;(void) closedir (pdyr3); }

char ADIR(const char *path){DIR *pdyr,*pdyr2 ;struct dirent *pent = NULL;struct dirent *pent2 = NULL;char *strin[255], *nocontext[255] , *gaarch[][255]={""} , *gaarcht[][255]={""} ;
                            pdyr = opendir (path);int gnarch=0;printf("-----------entrando a ---------- %s \n", path);
   while (pent = readdir (pdyr)) {/* printf("entrando -------  entrando %s ", pent->d_name); */
                                  strcpy(nocontext,pent->d_name);
                                  //if(*nocontext==*context){;} else{/*printf("-----------ADENTRO DE ---------- \n")*/;};
                                  if (pent == NULL) {printf ("\nERROR! not work"); return 0;};gaarch[0][gnarch]=pent->d_name;gaarcht[0][gnarch]=pent->d_type;
                                  printf(" <%d> <%s>\n",pent->d_type, pent->d_name);                                   
                                  if (strcmp(pent->d_name,"..")==0||strcmp(pent->d_name,".")==0){;}
                                  else{if (pent->d_type==4){ strcpy(strin,pent->d_name);printf("entrando a carpeta %s ",strin); listdir(strin);} 
                                       else{if (pent->d_type==10){ strcpy(strin,pent->d_name);printf("entrando a enlace%s ",strin); listdir(strin);}
										    else {  *cual=strchr(pent->d_name, 46); 
												  if(*cual!=NULL){
													               if (strcmp(subStr(pent->d_name, (strlen(pent->d_name)-strlen(*cual)),1) ,".c")==0 ) 
													               {  printf("en %d --- my eye upon %s ",1, subStr(pent->d_name, 0,(strlen(pent->d_name)-strlen(*cual))-1)  ) ;}  }  *cual=NULL;} }gnarch++;} 
                                                   } 
   return 0/*gnarch*/; (void) closedir (pdyr); }	
  
/*if ((in1 = fopen(zaaw[ccn],"w"))==NULL) {printf("error error \n");exit(1);}
fputc(13,in1); 
printf("-zaaw- -%s- \n",zaaw); }   fwrite(zaaw,strlen(zaaw),1, in1); 
 <html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<head> 
<div>
<form name = "foorm" id="foorm" method="GET" target="iframed">
<div >
<fieldset>
<select multiple name="tablas[]">
<div> <nav > <ul>
echo "<li> <a><option value='$f'>"."$f".$texto2."</option></a> </li>"; 
</nav>	</div> </select> 
</fieldset>
</div>
<input type="submit" value="Enviar" >
</form>
</div>
</head>  */
   printf ("% ",ADIR("."));
   return 0;
}

