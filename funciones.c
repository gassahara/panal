/* anadir busquedas en trozos incompletos */ 
char *subStr(char* str_src,int pos_ini,int cant_mov){char *subst=calloc(1,cant_mov+2); int cont_mov=pos_ini,cunt_mov=0,gcont_mov=strlen(str_src);
while(cont_mov<=gcont_mov){if(cunt_mov<=cant_mov){ subst[cont_mov-pos_ini]=*str_src;cunt_mov++;} *str_src++;cont_mov++;}return subst;}      

  
char *replc(char *str_rsrc,char *str_reste,char *str_raquel){int cant_mov=0; char *subst=calloc(1,cant_mov+2),*repla=calloc(1, str_raquel), *leftt=calloc(1,1), *rright[1],xcual[256],*cual[1]; 
int cont_mov=0,cunt_mov=0,gcant_mov=0,ggcant_mov=0,gcont_mov=0,ggcont_mov=0,ci=0,cii=0,gci=0,ggci=0,ggcii=0,gcii=0,trig=0;
/*printf("\n BEGINING REPLC mycaden %s este -%s- por este -%s- \n",str_rsrc,str_reste,str_raquel);*/
*cual=strchr(str_rsrc,46);if(*cual!=NULL){strcpy(xcual,*cual);gci= (strlen(str_rsrc)-strlen(xcual))+1;ggci=  (str_rsrc[gci])-48;*cual=*cual+1; 
*cual=strchr(*cual,46);  if(*cual!=NULL){strcpy(xcual,*cual);gcii=(strlen(str_rsrc)-strlen(xcual))+1;ggcii= (str_rsrc[gcii])-48;}}gcont_mov=strlen(str_rsrc);  cont_mov=0;
             while(cont_mov<=gcont_mov-(strlen(str_reste) )){cont_mov++;  
				                                             if(strcmp(subStr(str_rsrc,cont_mov,strlen(str_reste)-1 ),str_reste)==0){/*printf("working %s \n",leftt);*/
						                                        if (cont_mov <= strlen(str_reste) - 1 ){strcpy(leftt,subStr(str_rsrc,0,(cont_mov - 1 ))); /*printf("_w0rk1ng_ %s cont_mov %d\n",leftt,cont_mov)*/;} 
				                                                else { if(cont_mov>= gcont_mov-(strlen(str_raquel) ) ) { /*printf("TRABAJANDO AQUI -%s- \n",subStr(str_rsrc,(cont_mov),0));*/
																	                                                     if(strcmp(subStr(str_rsrc,(cont_mov),0)," ")==0){/*printf("_w0rk1ng_1-A %s \n",leftt);*/ 
																	                                                          strcat(leftt,subStr(str_rsrc,0,(cont_mov - 0))); /*printf("_w0rk1ng_1-A %s \n",leftt);*/} 
																	                                                     else {strcat(leftt,subStr(str_rsrc,0,(cont_mov - 1)));/*printf("_w0rk1ng_1   %s \n",leftt);*/ ;} }
																	   else                                            { if(str_rsrc[cont_mov-1]==(char)32)if(str_raquel[0]==(char)32)strcpy(leftt,subStr(str_rsrc,0,(cont_mov-2))) ;
																		                                                                                   else                       strcpy(leftt,subStr(str_rsrc,0,(cont_mov-1))) ;      
																		                                                 else                              strcpy(leftt,subStr(str_rsrc,0,(cont_mov-1))) ;
																		                                                 /*printf("_w0rk1ng_2 -%s- \n",leftt)*/;} }
				                                                if(str_raquel[0]==(char)32){;} else {if(leftt[strlen(leftt)-1]==(char)32){;} /*else strcat(leftt," ");-*/}
				                                                /*printf("wOrKiNg leftt -%s- str_raquel -%s- \n",leftt,str_raquel);*/
				                                                /*printf("CADENA DE MIERDA -%s- \n",subStr(str_rsrc,cont_mov+(strlen(str_reste) + 0 ) + 0,strlen(str_rsrc)-0));*/
				                                                strcat(leftt,str_raquel);/*printf("not wOrKiNg leftt -%s- str_raquel -%s- leftt[strlen(leftt)-1] -%c-  \n",leftt,str_raquel,leftt[strlen(leftt)-1]);*/
				                                                if(leftt[strlen(leftt)-1]==(char)32){strcat(leftt,subStr(str_rsrc,cont_mov+(strlen(str_reste) + 0 ) + 1,strlen(str_rsrc)-0));}  
				                                                else                                {if(str_rsrc[cont_mov+(strlen(str_reste))]!=(char)32)strcat(leftt," ");strcat(leftt,subStr(str_rsrc,cont_mov+(strlen(str_reste) + 0 ) - 0,strlen(str_rsrc)-0));}
				                                                /*printf("WORKING %s \n",leftt);*/  
				                                           } 				                                           				                                
				 /*if(cont_mov>=pos_ini){if(cunt_mov<=cant_mov){   subst[cont_mov-pos_ini]=*str_rsrc;cunt_mov++;} }*str_rsrc++;*/ 
				    /* */}printf("D O N E *%s* \n", leftt ); return leftt ;} 
 				       
/* PENDIENTE str_rsrce por stdin y un solo argumento 4132 la posicion es la que deseo y el numero es la posicion actual*/ 
/* construir una abstraccion para que cada uno de los elementos de una lista conozca  su posicion            */		                                                                                 
/*  char rsrce[]=" aaa bbb ccc asdf ",list[]=" 2 1 4 3 ",dlist[]=" 1 4 3 2 " ;*/               
int rordr(char* str_rsrce,char* list,char* dlist){  	   
	     int cant_mov=0,cont_mob=0,cunt_mob=0,cuntmob=0,cunt_mub=0, cumt_mub=0, comt_mob=0, cont_mov=0,cont_muv=0,cunt_mov=0, cunt_muv=0, kont_aquel=0, gcant_mov=0,ggcant_mov=0,gcont_mov=0, gcont_muv=0, ggcont_mov=0,
	     ci=0,cii=0,gci=0,ggci=0,qgci=0 ,dgci=0,qggci=0,dggci=0,ggcii=0,gcii=0,qgcii=0,wgci=0,wgcii=0,dgcii=0,trig=0, marcador=0;
	         char *subst=calloc(1,cant_mov+2),xcual[256],*cual[1],xquien[256], *quien[1],xwquien[256], *wquien[1],xdquien[256], *dquien[1], *str_rest[strlen(str_rsrce)], *str_aux[1] , *str_awx=calloc(1,strlen(str_rsrce)) , str_rakel[256],
              *str_rdes=calloc(1,strlen(str_rsrce)),*str_sdes=calloc(1,strlen(str_rsrce)),*str_tdes=calloc(1,strlen(str_rsrce)),*str_rsorce=calloc(1,strlen(str_rsrce)) ; strcpy(str_rdes,str_rsrce); strcpy(str_sdes,str_rsrce); gcont_mov=strlen(str_rsrce);strcpy(str_rsorce,str_rsrce);
              /*while(cunt_muv>=){ cunt_muv-- ;}*/*quien=*quien+1;*quien=strchr(list,32); 
			  while(*quien!=NULL){  strcpy(xquien,*quien);
					                        if(*quien!=NULL){qgci=(strlen(list)-strlen(xquien))+0;*quien=*quien+1;*quien=strchr(*quien,32);
											                 if(*quien!=NULL){ strcpy(xquien,*quien);qgcii= (strlen(list)-strlen(xquien))+0; }											                 
											                } cunt_muv++; cunt_mub=atoi( subStr(list,qgci,qgcii-qgci) ) ; 
				*cual=strchr(str_rsrce,32); 
                while(*cual!=NULL){ 	                        				                                         
                                  if(cont_mov<=gcont_mov+0){  //printf("EXTERNO cual -%s\- cual -%s- str_rsrce -%s-\n",xcual,*cual,str_rsrce);
				                            if(*cual!=NULL){strcpy(xcual,*cual);ci= (strlen(str_rsrce)-strlen(xcual)) + 1 ;*cual=*cual+1; *cual=strchr(*cual,32);  
					                               if(*cual!=NULL){strcpy(xcual,*cual);gcii=(strlen(str_rsrce)-strlen(xcual)) + 0;}  marcador=gcii; }
					                        cunt_mov++;	      
				                            /*printf(" en LIST %s  pedazo <%d> cunt_mov %d que sea igual a cunt_mub %d PEDAZO BUSCADO %s\n ",*quien, cunt_mub, cunt_mov, cunt_muv,subStr(list,qgci,qgcii-qgci))*/; 
				                            if (cunt_mov==cunt_mub){  /*printf("ERROR? str_rsrce %s \n", str_rsrce );*/ strcpy(str_rest, subStr(str_rsrce, ci,(gcii - ci) - 1 ));  
												cont_muv=0;gcont_muv = strlen(list);cunt_mob=0;
				                                while(cont_muv<=gcont_muv){ cunt_mob=0; /*printf("voy por %d str_rdes %s de str_rsrce %s CON str_rest -%s- \n ", cunt_muv , str_rdes, str_rsrce,str_rest);*/
								  					                       *dquien=strchr(dlist,32);  
												                            while(*dquien!=NULL){ strcpy(xdquien,*dquien);
																				if(*dquien!=NULL){dgci= (strlen(dlist)-strlen(xdquien))+0;*dquien=*dquien+1;
																				*dquien=strchr(*dquien,32); if(*dquien!=NULL){strcpy(xdquien,*dquien);dgcii=(strlen(dlist)-strlen(xdquien))+0;} }  																			
																				cumt_mub=atoi( subStr(dlist,dgci,dgcii-dgci) );cont_mob++;/*printf("ahora dlist <%s> HAY cunt_mob %d ESTE cunt_mub -%d- por ESTE OTRO cumt_mub <%d> VEO cont_mob %d y busco a cunt_muv <%d> \n ",dlist,cunt_mob,cunt_mub,cumt_mub,cont_mob,cunt_muv,cont_mob,cunt_muv);*/
																				if (cont_mob==cunt_muv){ 
																					                    while(cunt_mob<=gcont_mov){ *wquien=strchr(str_rdes,32); 
																				 	                              while (*wquien!=NULL) {strcpy(xwquien,*wquien);
																				                                    if(*wquien!=NULL){if(cumt_mub==1) wgci=(strlen(str_rdes)-strlen(xwquien))+1;
																														              else wgci=(strlen(str_rdes)-strlen(xwquien))+0;   
																														              *wquien=*wquien+1;*wquien=strchr(*wquien,32); 
																										  		  	                  if(*wquien!=NULL){strcpy(xwquien,*wquien);wgcii=(strlen(str_rdes)-strlen(xwquien)) - 0 ;} }
																										  		  	                  /*printf("SACANDO ESTE -%s- cuanto -wquien- -%s- len? %d str_rdes -%s- \n",*wquien,xwquien,strlen(xwquien),str_rdes)*/;comt_mob++;	
																					                                if(comt_mob==cumt_mub){ /*printf(" ENTRE  dlist >%s> wquien <%s> str_rdes -%s-  comt_mob <%d> cumt_mub <%d>  wgci %d wgcii-wgci %d\n", dlist, *wquien, str_rdes,comt_mob, cumt_mub ,wgci,wgcii-wgci )*/; 
																										  		     	      strcpy(str_rakel, subStr(str_rdes,wgci,(wgcii-wgci) - 1 )); 
																										  		     	      strcpy(str_aux, str_rakel); strcpy(str_awx, "00") ; printf("todavia str_rakel <%s> str_rdes <%s> \n", str_rakel,str_rdes); 	 																												  																						                                  
																					                                          strcpy(str_rdes, replc( str_rdes, str_rakel , str_awx ) );   printf("todavia No   str_rdes <%s>  str_rakel -%s- str_awx %s \n", str_rdes, str_rakel , str_awx);
																					                                          strcpy(str_sdes, replc( str_rdes, str_rest , str_rakel ) );  printf("todavia NNOO   str_rdes <%s> str_rest <%s> str_rakel <%s> \n",  str_rdes ,str_rest , str_rakel);
																					                                          strcpy(str_tdes, replc( str_sdes, str_awx , str_rest ) );    printf("OOOOOOOO  str_rdes %s str_tdes %s \n",  str_rdes , str_tdes);
																					                                          printf(" YYYYEEEESSSS--3 str_rdes -%s- wquien <%s> p_rakel <%s> str_rakel %s str_awx %s str_rest %s \n ",str_rdes,xwquien, subStr(str_rdes,wgci,wgcii-wgci), str_rakel, str_awx , str_rest);getchar();
																					                                          strcpy(str_rdes,str_rsorce); strcpy(str_sdes,str_rsorce); printf("QUEDA str_rdes -%s- str_rsrce -%s- \n ", str_rdes,str_rsrce);
																					                                          while (gci>0){ gci--;*str_rsrce--; /* */;}  
																					                                          /*printf("str_rdes antes de while <%s> str_rsrce <%s>  \n ", str_rdes, str_rsrce );
																					                                          printf ("andando %s str_rdes <%s> \n", str_rsrce, str_rdes); getchar();*/
																					                                          cont_mov=gcont_mov+1;cont_mob=0;cunt_mov=0;cont_mob=0;cont_mov=0;cont_muv=gcont_muv+1;comt_mob=0;cunt_mob=gcont_mov+1;
																					                                          *cual=NULL;*dquien=NULL;*wquien=NULL;break;
																					                                }  
																					                                *wquien=*wquien+1; 
																					                                }cunt_mob++;}   	  
																		                               if (wgci>= 0 ){if(cunt_mob>=gcont_mov+1){;} 
																									   	              else                     {while (wgci>=0){ *str_rdes++;wgci--;/* */; } } } 
																		                               else {*str_rdes=*str_rdes+2 ; /* */; }	 
																		                             } 
																		        else{ ;}  
																		        
																				if (dgci>= 0 ){ while (dgci>=0){  dgci--; } } else {*dlist=*dlist+2 ;/*printf("dAQUI se cumple %s\n",qgci) */;}		}													                          
										        cont_muv++;}  } 
										    else { /* */;}
								  }   		
								  else{break;}		                                  		                            
				                  /* */ cont_mov=cont_mov+(strlen(str_rsrce)-strlen(cual));} 
				                  cont_mov= 0;
				return cunt_muv ;}
