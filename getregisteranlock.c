#include <stdio.h>
#include <stdlib.h>
#include <sys/dir.h>

int main(int argc, char *argv[]) {
  static unsigned char delimiter[2]={'\n', ';'};
  static unsigned char buffer[32]="querybuscacsusuario3.sh.memoria";
  unsigned char files[20][2][134]={{"/root/panal/users/input/unencrypted","eb03c7ba58b5e30593b83b3901c1f485e0b0a0cf4ac9500cac437b9fbaf62450a8b86ee9a88a538c922ca6b13a5fb44bce54dfc94d58bc8e2d32017fb424c5c1.js.c"},{"/root/panal/users/input/unencrypted","204b666d370393770eabbc015b98987c32bd72a2ed438f9b1d0d19bbc4203e404b9fd7802c058e6dd72b2cd4b8aa50ac876bf355a58760b9058298b3c420c1e1.js.c"},{"/root/panal/users/input/unencrypted","06440f9684b0f31b90f880b4b5bb56c894f94b5bb4ef8de4fb5e5602796b44dd53ce7fbc34ab713bc1eccb6fa762f01d3d72b7b16a08d9461906f20d07086019.js.c"},{"/root/panal/users/input/unencrypted","3f485d487f4afd098ad30e9ef5bfc3335acd27d57f2b0c697fed07e55be54269364cf669ae00be9ca02e33a4f877cf41b462d31d03c234bb810fbf06f9338f61.js.c"},{"/root/panal/users/input/unencrypted","e401ba17f3a8e299f7e9e2369b47e84230b04c7e233bdde7c9da857b18c38aface9a7bdd43c46940de38f1920f0cafc75ab37fe43711891605cef19cc599ec30.js.c"},{"/root/panal/users/input/unencrypted","989d291df94e779e2edd0137bef98645e3d78b02bfd3e41717b5c8caacdf11cdcf8ac2eb233cebed14e03fdc213e8e932c61657bb16ae65a75fb74ec1c50c0b7.js.c"},{"/root/panal/users/input/unencrypted","a1295818dc5583e899d3bfa83a94cc0da3f6eb6ac23cd0545d8a42c6273cc5368981b003d4a67a7b9f2731cf85087d42e46f5d09f4f725f2ffda222cfc9f95c2.js.c"},{"/root/panal/users/input/unencrypted","982ce0a9ba28cea7f971139784f7def95035815e867b0f2d2d06932196eceaebb3f2ec15eb122e441028552d7554534069416508d5b7e48ca3a26b86ccaf1f2c.js.c"},{"/root/panal/users/input/unencrypted","092a5c2c18e5d7a66b2057334754737c57a2f3e69c9efed8d8a4416d00dab0f7dacb7647dd249389086005d382dcb360b455e99ba275502e7c9d642715881515.js.c"},{"/root/panal/users/input/unencrypted","6cd11cd13c11c1dba2cd13c404535b306f8c6604b8392801ade38d8d32c51eebff3b7ab4d90e231451b7e055419c57968f58320e2fec18cf9f54a732d8f99a59.js.c"},{"/root/panal/users/input/unencrypted","3926122fc0fce6f8961c3f8fd8b618e9d6ff44d3ea463bd398d8fae12c2202b93411aef13665658e3311632f50c36eb7136fac08726f6dcee07819579163a5a6.js.c"},{"/root/panal/users/input/unencrypted","2421398d89e508e8252f80509acba5284c3d6ad6c848a11e546b13de0b4e996a398ed380642067a24b3629532f468849b6f80351f19ea7dc13fd52b77167db10.js.c"},{"/root/panal/users/input/unencrypted","e1bcd856f82b59ded172008a454e64e798606b23bb1b1e88f9b93ea65ed81bdebd218bb7a46b9186ebb56d32b7aab0870db5f7b37243b5f321c87e853b851ba1.js.c"},{"/root/panal/users/input/unencrypted","ec50c6b64bafbdf29e752c3a517178d510a47ddd3933911a4876ae8cfd0c3d3d46776ffbdc2750a0943c47a679ee71a2a3815831757ef010419da866a65399a8.js.c"},{"/root/panal/users/input/unencrypted","9d1ffc3f783fc834a438be2bc369a26a42c428e9d519ddec8ff1f9beea4ccd883b59eaf2d3f41a3550393e5fa1978ee3279c35356dc098bd140b24c9f5e3c51e.js.c"},{"/root/panal/users/input/unencrypted","7adef1974c0bcc59168fda6d276d4272116d3cac7608d7e24125a9a0028f4a5000f36e5122bf408c49e0d96d3a73a20906243f30bdb96826e6700f85c96a710b.js.c"},{"/root/panal/users/input/unencrypted","0671dc47826f42c3d74f0284c77dc03cf7726ba7caa61e36cc3b2dd3a46626fdbf8b6ab52c614a3d86099bc52f418486903d4864c33fa67cb2b014868521e429.js.c"},{"/root/panal/users/input/unencrypted","67752bca1288a732187ed50ded4533cc51447295a311f8571cc45cf8598af7a1b902bc3e5e08f2210020a7f59adb33d1fb8020876e1be77ceb4899cb064c9471.js.c"},{"/root/panal/users/input/unencrypted","fcd52b3146c7f189bd6ade27e78a0b9952a1f01ec67b0ca7331d4a78b1af884606face285204b4de7af823b9e37b9bf9340ea4bc6311e993cd600486b9882666.js.c"},"END"};
  unsigned char lea[2];
  unsigned long aciertos[sizeof(files)/sizeof(files[0])];
  unsigned char acertados[sizeof(files)/sizeof(files[0])];
  long len=sizeof(aciertos)/sizeof(long);
  unsigned long end[len];
  unsigned long indice_a=0;
  unsigned long indice_s=0;
  unsigned char indice_d=0;
  indice_a=0;
  while(indice_a<len) {
    aciertos[indice_a]=0;
    acertados[indice_a]=0;
    end[indice_a]=0;
    indice_a++;
  }
  indice_s=0;
  fflush(stdout);
  FILE *file = fopen(buffer, "r");
  unsigned char continua=1;
  unsigned char ondelim=0;
  if (file) {
    while(fread(lea, 1, 1, file)>0) {
      indice_d=0;
      ondelim=0;
      while(indice_d<sizeof(delimiter)) {	
	if(lea[0]==delimiter[indice_d]) {
	  ondelim=1;
	}
	indice_d++;
      }
      if(ondelim) {
	indice_a=0;
	while(indice_a<len && indice_s) {
	  if(aciertos[indice_a]==indice_s && indice_s>0) {
	    acertados[indice_a]=1;
	  }
	  indice_a++;
	}
	while(indice_a<len) {
	  aciertos[indice_a]=0;
	  end[indice_a]=0;
	  indice_a++;
	}
	indice_s=0;
      } else {
	indice_a=0;
	while(indice_a<len) {
	  if(end[indice_a]==0) {
	    if(files[indice_a][1][indice_s]==lea[0]) aciertos[indice_a]++;
	    if(files[indice_a][1][indice_s]==0) end[indice_a]=1;
	  }
	  indice_a++;
	}
	indice_s++;
      }
    }
    fclose(file);
  }
  indice_a=0;
  while(indice_a<len) {
    if(acertados[indice_a]==0) printf("%s/%s\n", files[indice_a][0], files[indice_a][1]);
    indice_a++;
  }
}
