#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <utime.h>
#include <sys/time.h>

int main(int argc, char *argv[]) {
  DIR *mydirhandle;
  FILE *ff;
  struct dirent *mydirent;
  struct stat statinfo;
  struct utimbuf puttime;
  struct utimbuf maytime;
  time_t tmt;
  int n = 1;
  int pasa=0;
  stat(argv[0], &statinfo);
  puttime.actime = statinfo.st_atime;
  puttime.modtime = statinfo.st_mtime;
  maytime=puttime;
  mydirhandle = opendir("./");
  
  char lea[2];
  char *temporal, *lee;
  int geto, leei, lee2;
  temporal=calloc(20,sizeof(char));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  lee=calloc(1025, sizeof(char));
  leei=1025;
  memset(temporal, 0, 20);
  memset(lee, 0, leei);
  lee2=0;geto=0;
  bzero(lea, 2);
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0]=='\r' || lea[0]=='\n') {
      stat(lee, &statinfo);
      if(puttime.modtime<statinfo.st_mtime) {
	printf("%s\n",lee);
      }
      if(maytime.modtime<statinfo.st_mtime) {
	pasa=1;
	maytime.modtime=statinfo.st_mtime;
	//	maytime.actime=statinfo.st_mtime;
	//	utime(lee, &puttime);
	//	maytime.modtime=statinfo.st_mtime;
      }

      free(lee);
      lee=calloc(1025, sizeof(char));
      leei=1025;
      free(temporal);
      temporal=calloc(20, sizeof(char));
      memset(lee, 0, 1025);
      memset(temporal, 0, 20);
      lee2=-1;
    } else {
      lee[lee2]=lea[0];
    }
    lee2+=1;
    while(lee2>leei-1) {
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      memcpy(temporal, lee, leei);
      free(lee);
      lee=calloc(leei+1024, sizeof(char));
      memcpy(lee, temporal, leei);
      leei+=1024;
    }
  }
  free(lee);
  lee=calloc(1024, sizeof(char));

  if(pasa) {
    puttime.modtime=maytime.modtime;
    utime(argv[0], &puttime);
  }
  closedir(mydirhandle);
  return 0;
}
