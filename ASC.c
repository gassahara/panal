#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>


#define DEGTORAD 0.0174532925199433
#define RADTODEG 57.2957795130823
/*
 * conversion between ecliptical and equatorial cartesian coordinates
 * for ecl. to equ.  eps must be negative
 * for equ. to ecl.  eps must be positive
 */
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
  double obslon=-66.918; //Caracas
  double obslat=10.5;//Caracas
  double secocdstodays=60*60*24;
  double et=0;
  double deltaj=(et/secocdstodays);
  double deltajd=trunc(deltaj);
  double tz=4;
  double M0=15.04106864026192;
  double M1=2.423233*pow(10,-14);
  double M2=-6.628*pow(10,-23);
  double L0=99.967794687;
  double L1=360.98564736628603;
  double L2=2.907879e-13;
  double L3=-5.3020e-22;
  double ARMCa=fmod(L0+(L1*deltaj)+(L2*pow(deltaj,2))+(L3*pow(deltaj,3))-(-obslon),360);
  
  double ARMC1=M0+(M1*deltajd)+(M2*pow(deltajd,2));
  double ARMCp=(L2*(pow(deltajd,2)))+(L3*pow(deltajd,3))-(-obslon)+(ARMC1*tz);
  double ARMC0=fmod(L0+(L1*deltajd)+ARMCp, 360);
  double t=((fabs(deltaj)-fabs(deltajd))*24)+tz;
  if(deltaj<0) t=24-t;
  double normt=round(ARMCa/360);
  ARMCa-=normt*360;
  normt=round(ARMC0/360);
  ARMC0-=normt*360;
  while(ARMC0<0) {
    ARMC0=ARMC0+360;
  }
  while(ARMCa<0) {
    ARMCa=ARMCa+360;
  }
  double ARMCb=fmod(ARMC0+(ARMC1*t),360);
  while(ARMCb<0) {
    ARMCb=ARMCb+360;
  }
  
  double ARMCv=(ARMCa+ARMCb)/2;

  double ARMCrads=ARMCv*DEGTORAD;
  
  double T=deltaj/36525;
  double e =  (84381.406 + T*(-46.836769 + T*(-0.0001831 + T*(0.0020034 + T*(pow(-5.76,-7) - pow(4.34,-8)*T)))))/3600;
  e = e * DEGTORAD;

  double xpn[3], xpo[3];
  double temp1=(sin(e) * tan(obslat*DEGTORAD));
  double temp2=(cos(e)* sin(ARMCrads));
  double ASC2=(atan(cos(ARMCrads)/-(temp1+temp2)))*RADTODEG;

  double MC= atan(tan(ARMCrads)/cos(e))*RADTODEG; //(atan (sin (ARMCrads) / (cos(ARMCrads)*cos(e))))*RADTODEG;
  while(MC<0)MC+=360;
  while(ASC2<0) ASC2+=180;

  double declmc=atan( sin(ARMCv*DEGTORAD) * tan(e)) * RADTODEG;
  double declasc=atan( sin(ASC2) * tan(e)) * RADTODEG;
  double lsAD=asin(tan(declasc*DEGTORAD)*tan(obslat*DEGTORAD))*RADTODEG; //DA diferencia ascenciona;l
  double AO=0;

  //Ecuatorial
  xpo[0]=ASC2*DEGTORAD;
  xpo[1]=declasc*DEGTORAD;
  xpo[2]=1.0;

  swi_polcart(xpo, xpo);
  swi_coortrf(xpo, xpo, -(e));
  swi_cartpol(xpo, xpo);
  double ascequatorial = xpo[0] * RADTODEG;


  double RAe=ASC2;
  if(obslat>0) {
    if(RAe<=ARMCv) AO=1;
    else  AO=0;
  } else {
    if(RAe>=ARMCv) AO=1;
    else AO=0;
  }
  if(AO==1 && obslat<0) RAe+=lsAD;
  if(AO==0 && obslat<0) RAe-=lsAD;
  if(AO==0 && obslat>0) RAe+=lsAD;
  if(AO==1 && obslat>0) RAe-=lsAD;

  xpo[0]=RAe*DEGTORAD;
  xpo[1]=declasc*DEGTORAD;
  xpo[2]=1.0;

  swi_polcart(xpo, xpo);
  swi_coortrf(xpo, xpo, -(e));
  swi_cartpol(xpo, xpo);
  double RAa = xpo[0] * RADTODEG;
  /*
  xpn[1] = xpo[1] * RADTODEG;
  xpn[2] = xpo[2];
  */
  
  printf("e=%06f;RAMC=%06f;RAMC=%06f;RAMC(p)=%08.8f;ASC=%06f;DECLASC=%08f;ASC(eq)=%06f;ASC(asc)=%08.8f;ASC(asce)=%06f;MC=%08.8f;DECLMC=%08f;ASC(ramc)=%88.8f;\n", e*RADTODEG, ARMCa, ARMCb, ARMCv, ASC2, declasc, ascequatorial, RAe, RAa, MC, declmc, fmod((ARMCa+60),360));
  fflush(stdout);
}
