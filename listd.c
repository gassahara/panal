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
  
  while((mydirent = readdir(mydirhandle)) != NULL) {
    if((strcmp(mydirent->d_name, ".") == 0) || (strcmp(mydirent->d_name, "..") == 0)) continue;
    else {
      if(mydirent->d_type != DT_DIR) {
	stat(mydirent->d_name, &statinfo);
	if(puttime.modtime<statinfo.st_mtime) {
	  printf("%s\n",mydirent->d_name);
	}
	if(maytime.modtime<statinfo.st_mtime) {
	  pasa=1;
	  maytime.modtime=statinfo.st_mtime-20;
	  maytime.actime=statinfo.st_mtime;
	  utime(mydirent->d_name, &puttime);
	  maytime.modtime=statinfo.st_mtime-10;
	}
      }
    }
  }
  if(pasa) {
    puttime.modtime=maytime.modtime;
    utime(argv[0], &puttime);
  }
  closedir(mydirhandle);
  return 0;
}
