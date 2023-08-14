#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>


#define DEGTORAD 0.0174532925199433
#define RADTODEG 57.2957795130823
void swi_coortrf(double *xpo, double *xpn, double eps) {
  double sineps, coseps;
  double x[3];
  sineps = sin(eps);
  coseps = cos(eps);
  x[0] = xpo[0];
  x[1] = xpo[1] * coseps + (xpo[2] * sineps);
  x[2] = -xpo[1] * sineps + (xpo[2] * coseps);
  xpn[0] = x[0];
  xpn[1] = x[1]; 
  xpn[2] = x[2];
}

/* conversion from polar (l[3]) to cartesian coordinates (x[3]).
 * x = l is allowed.
 */
void swi_polcart(double *l, double *x) {
  double xx[3];
  double cosl1;
  cosl1 = cos(l[1]);
  xx[0] = l[2] * cosl1 * cos(l[0]);
  xx[1] = l[2] * cosl1 * sin(l[0]);
  xx[2] = l[2] * sin(l[1]);
  x[0] = xx[0];
  x[1] = xx[1];
  x[2] = xx[2];
}

/* conversion of cartesian (x[3]) to polar coordinates (l[3]).
 * x = l is allowed.
 * if |x| = 0, then lon, lat and rad := 0.
 */
void swi_cartpol(double *x, double *l) 
{
  double rxy;
  double ll[3];
  if (x[0] == 0 && x[1] == 0 && x[2] == 0) {
    l[0] = l[1] = l[2] = 0;
    return;
  }
  rxy = x[0]*x[0] + x[1]*x[1];
  ll[2] = sqrt(rxy + x[2]*x[2]);
  rxy = sqrt(rxy);
  ll[0] = atan2(x[1], x[0]);
  if (ll[0] < 0.0) ll[0] += (2*M_PI);
  ll[1] = atan(x[2] / rxy);
  l[0] = ll[0];
  l[1] = ll[1];
  l[2] = ll[2];
}

int main(int argc, char *argv[] ) {
  double ARMC=0;
  double ASC=0;
  double MC=0;
  double obslat=0;
  int AO=0;
  double RA=0;
  double RAe=0;
  double DECL=0;
  double e=0;
  double xpo[3];


  double lsAD=asin(tan(DECL*DEGTORAD)*tan(obslat*DEGTORAD))*RADTODEG; //DA diferencia ascenciona;l
  xpo[0]=RA*DEGTORAD;
  xpo[1]=DECL*DEGTORAD;
  xpo[2]=1.0;
  swi_polcart(xpo, xpo);
  swi_coortrf(xpo, xpo, -(e*DEGTORAD));
  swi_cartpol(xpo, xpo);
  if(RA>180) RAe = 360-(xpo[0] * RADTODEG);
  else RAe = (xpo[0] * RADTODEG);  
  printf("RA(eq): %06f DECL: %06f \n", RAe, xpo[1]*RADTODEG);
  
  if(obslat>0) {
    if(RA<=ARMC) AO=1;
    else  AO=0;
  } else {
    if(RA>=ARMC) AO=1;
    else AO=0;
  }
  /*
  if(obslat>0 && DECL<0) lsAD=-lsAD;
  if(obslat<0 && DECL>0) lsAD=-lsAD;
  */
  if(AO==1 && obslat<0) RAe+=lsAD;
  if(AO==0 && obslat<0) RAe-=lsAD;
  if(AO==0 && obslat>0) RAe+=lsAD;
  if(AO==1 && obslat>0) RAe-=lsAD;
  printf("RA(Asc-eq): %06f \n", RAe);
  fflush(stdout);
}
