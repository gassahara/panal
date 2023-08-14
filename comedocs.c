#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  char ss[550], sss[6000];
  char s1[3], ext1[5], ext2[4];
  char *uploaderchi, *aejec;
  int p,i;
  s1[0]='\0';
  aejec[0]='\0';
  memset (ext1, 0, 5);
  memset (ext2, 0, 5);
  uploaderchi=calloc(1, sizeof(char));
  aejec=calloc(1, sizeof(char));
  
  for (i = 1; i < argc; i++) {
    free(uploaderchi);
    uploaderchi=calloc(strlen(argv[i])+1, sizeof(char));
    memset(uploaderchi, 0, strlen(argv[i])+1);
    strcpy(uploaderchi, argv[i]);
    int slen=strlen(uploaderchi);
    memcpy(ext1, uploaderchi+(slen-4), (size_t)4);
    memcpy(ext2, uploaderchi+(slen-3), (size_t)3);
    if(!strcmp(ext1, "docx") || !strcmp(ext2, "odt")) {
      strcat(s1, "<td>");
      strcat(s1, uploaderchi);
      strcat(s1, "</td>\n");

      free(aejec);
      aejec=calloc((strlen(uploaderchi)*4)+strlen("cp \"\" \".zip\"; 7z x \".zip\" -oconvertido;sleep 2")+1, sizeof(char));
      memset(aejec, 0, (strlen(uploaderchi)*4)+strlen("cp \"\" \".zip\"; 7z x \".zip\" -oconvertido;sleep 2")+1);
      sprintf(aejec, "cp \"%s\" \"%s.zip\"; 7z x \"%s.zip\" -y -o%sconvertido;sleep 2", uploaderchi, uploaderchi, uploaderchi, uploaderchi);
      printf("-------\n %s \n ", aejec); 
      if(!system(aejec)) printf("FUNCIONO\n");
      else "NO FUNC\n";

      sprintf(aejec, "chmod 775 \"%sconvertido\" -R", uploaderchi);
      printf("-------\n %s \n ", aejec); 

      sprintf(aejec, "test -e %sconvertido/content.xml", uploaderchi);
      if(!system(aejec)) printf("\nESTA CONTENT\n");

      sprintf(aejec, "test -e %sconvertido/word/document.xml", uploaderchi);
      if(!system(aejec)) printf("\nESTA DOCUMENT\n");
    }
  }
  printf("%s", s1);
  return  1;
}
