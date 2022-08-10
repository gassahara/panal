#include <stdio.h>
#include <math.h>

char zodiacogradosigno[12][12]={"Aries", "Tauro", "Geminis", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagitario", "Capricornio", "Acuario", "Piscis"};
int zgs_i=0;
double planetas[10];
char ascencional_planet_names[10][10]={{'S','O','L',0},{'L','U','N','A',0},{'M','E','R','C','U','R','I','O',0},{'V','E','N','U','S',0},{'M','A','R','T','E',0},{'J','U','P','I','T','E','R',0},{'S','A','T','U','R','N','O',0},{'U','R','A','N','O',0},{'N','E','P','T','U','N','O',0},{'P','L','U','T','O',0}};
double planetas_ascencional[10]={0.17410906,162.60551804,348.47094449,357.18769526,63.68681241,59.65200111,284.24921901,275.80273485,283.35464838,227.26281228};
char ascencional_planets[13][2][10]={{{'S','O','L',0}, {'J','U','P','I','T','E','R',0}},{{'L','U','N','A',0}, {'M','E','R','C','U','R','I','O',0}},{{'L','U','N','A',0}, {'S','A','T','U','R','N','O',0}},{{'L','U','N','A',0}, {'U','R','A','N','O',0}},{{'L','U','N','A',0}, {'N','E','P','T','U','N','O',0}},{{'M','E','R','C','U','R','I','O',0}, {'L','U','N','A',0}},{{'V','E','N','U','S',0}, {'J','U','P','I','T','E','R',0}},{{'M','A','R','T','E',0}, {'J','U','P','I','T','E','R',0}},{{'J','U','P','I','T','E','R',0}, {'M','A','R','T','E',0}},{{'S','A','T','U','R','N','O',0}, {'N','E','P','T','U','N','O',0}},{{'U','R','A','N','O',0}, {'S','O','L',0}},{{'N','E','P','T','U','N','O',0}, {'S','A','T','U','R','N','O',0}},{{'P','L','U','T','O',0}, {'M','E','R','C','U','R','I','O',0}}};
char planetas_simbolo[10][13]={ {'s','o','l','.','p','n','g',0}, {'l','u','n','a','.','p','n','g',0}, {'m','e','r','c','u','r','i','o','.','p','n','g',0}, {'v','e','n','u','s','.','p','n','g',0}, {'m','a','r','t','e','.','p','n','g',0}, {'j','u','p','i','t','e','r','.','p','n','g',0}, {'s','a','t','u','r','n','o','.','p','n','g',0}, {'u','r','a','n','o','.','p','n','g',0}, {'n','e','p','t','u','n','o','.','p','n','g',0}, {'p','l','u','t','o','n','.','p','n','g',0} };
char aspectos_simbolo[5][15]={ {'c','o','n','j','u','n','c','i','o','n','.','p','n','g',0}, {'s','e','x','t','i','l','.','p','n','g',0}, {'c','u','a','d','r','a','t','u','r','a','.','p','n','g',0}, {'t','r','i','g','o','n','o','.','p','n','g',0}, {'o','p','o','s','i','c','i','o','n','.','p','n','g',0} };
double positions[10][2];
unsigned char z=0;
unsigned char p=0;
unsigned char q=0;
double posab[2][2];
double gradosab[2];
double test=0;
unsigned char indiceaspecto=0;
unsigned char indicezodiaco=0;
double gradossigno=0;
double gradostmp=0;
double  minutossigno=0;
double  segundossigno=0;
double radius=380;
double distance=550;
double radius2=300;
double radius3=300;
double grados=0;
double grados2=0;
double ASC=25;
double a=(M_PI * 2)/360;
double x=0;
double y=0;
double xx=0;
double yy=0;
double dif=1.75;
int main( int argc, char *argv[] ) {
  radius2=radius/dif;
  radius3=radius*1.28;
  z=0;
  while(z<10) {
    planetas[z]=planetas_ascencional[z];
    z++;
  }
  z=0;
  while(z<10) {
    p=0;
    while(p<10) {
      if(fabs(planetas[z]-planetas[p])<1 && z!=p) {
	planetas[p]=planetas[p]-0.6;
	planetas[z]=planetas[z]+0.6;
	z=-1;
	p=100;
      }
      p++;
    }
    z++;
  }
  printf("convert -background white  -gravity center  \\( circulocasas_n2.png \\) -distort SRT -%03.4f \\( circulozodiaco_signos.png -scale 900x900 \\)  -compose over -composite -scale 1100x1100", ASC);
  z=0;
  while(z<10) {
    grados=planetas_ascencional[z];
    grados2=10;
    grados2=grados;
    if(grados2>90) {
      while(grados2>90 && grados<270) grados2-=90;
      if(grados<=180) grados2=90-grados2;
      else grados2=grados2-(grados2*2);
    } else {
      grados2=grados2-(grados2*2);
    }
    grados=planetas[z];
    x=ceil(radius2 * sin(a*(grados+270)));
    y=ceil(radius2 * cos(a*(grados+270)));
    positions[z][0]=x+distance+(M_PI);
    positions[z][1]=y+distance+(M_PI*2);
    x=ceil(radius * sin(a*(grados+270)));
    y=ceil(radius * cos(a*(grados+270)));
    grados=planetas_ascencional[z];
    xx=ceil(radius3 * sin(a*(grados+270)));
    yy=ceil(radius3 * cos(a*(grados+270)));
    zgs_i=0;
    while((zgs_i*30)<360) {
      if(grados>(zgs_i*30) && grados<(zgs_i*30)+30) {
	indicezodiaco=zgs_i;
	gradossigno=grados-zgs_i*30;
	gradossigno=trunc(gradossigno);
	gradostmp=(grados-((zgs_i*30)+gradossigno))*100;
	minutossigno=(((gradostmp)*60)/100);
	gradostmp=(gradostmp-trunc(gradostmp))*100;
	segundossigno=(((gradostmp)*60)/100);
	break;
      }
      zgs_i++;
    }
    printf(" \\( -gravity center %s -scale 20x20 -geometry +%04.f+%04.f \\) -compose over -composite ", planetas_simbolo[z], xx, yy);

    printf(" \\( -gravity center -background none caption:\"(%s)%s,%03.f°%02.f\'%02.f\'\'\"   -geometry +%04.f+%04.f  -rotate %02.f \\) -compose over -composite ", ascencional_planet_names[z], zodiacogradosigno[indicezodiaco], gradossigno, minutossigno, segundossigno,round(x), round(y), grados2);
    z++;
  }
  z=0;
  while(z<((sizeof(ascencional_planets)/20))) {
    printf(" -gravity NorthWest -draw \"line ");
    p=0;
    q=0;
    while(p<10) {
      if( (ascencional_planets[z][0][0] == ascencional_planet_names[p][0] && ascencional_planets[z][0][1] == ascencional_planet_names[p][1] && ascencional_planets[z][0][2] == ascencional_planet_names[p][2]) || (ascencional_planets[z][1][0] == ascencional_planet_names[p][0] && ascencional_planets[z][1][1] == ascencional_planet_names[p][1] && ascencional_planets[z][1][2] == ascencional_planet_names[p][2]) ) {
	printf(" %03.2f,%03.2f ", positions[p][0], positions[p][1]);
	posab[q][0]=positions[p][0];
	posab[q][1]=positions[p][1];
	gradosab[q]=planetas_ascencional[p];
	q++;
	if(q==2) break;
      }
      p++;
    }
    printf("\" ");
    test=fabs(gradosab[0]-gradosab[1]);
    if(test>187) test=fabs(test-360);
    if(test >=0 && test < 7 ) indiceaspecto=0;
    if(test >= 57 && test <=63 ) indiceaspecto=1;
    if(test >= 83 && test <=97 ) indiceaspecto=2;
    if(test >= 113 && test <=127 ) indiceaspecto=3;
    if(test >= 173 && test <=187 ) indiceaspecto=4;
    printf(" \\( -gravity NorthWest %s -scale 20x20 -geometry +%04.f+%04.f \\) -compose over -composite ", aspectos_simbolo[indiceaspecto], posab[0][0]-((posab[0][0]-posab[1][0])/2), posab[0][1]-((posab[0][1]-posab[1][1])/2)); //+(posab[0][0]-posab[1][0])
    //printf(" \\( -gravity NorthWest -background none caption:\"%03.3f-%03.3f\"   -geometry +%04.f+%04.f \\) -compose over -composite ", gradosab[0], gradosab[1], posab[0][0]-((posab[0][0]-posab[1][0])/2), posab[0][1]-((posab[0][1]-posab[1][1])/2));
    z++;
  }
  printf(" -background green -distort SRT %03.4f -scale 700x700 -gravity center r.jpg", ASC);
}
