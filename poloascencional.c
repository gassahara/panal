#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define DEGTORAD 0.0174532925199433
#define RADTODEG 57.2957795130823
double RA=29.217; //109.8; //89.64; //9.2;
double RAMC=295; //108.5;  //322.2;
double RAIC=108.5;
double ascendente=29.217; //29.0;
double declination=0; //3.966;
double obslat=10.5; //4.783;//Caracas
double lower_meridian_distance=0.0;
double upper_meridian_distance=0.0;
double diurnal_semi_arc=0.0;
double nocturnal_semi_arc=0.0;
double ascencional_difference=0.0;
double ascencional_difference_tan=0.0;
double meridian_distance=0;
double semi_arc=0;
double temp=0;
double polo=0;
double diferencia_ascencional_polo=0;
int main(int argc, char *argv[]) {
  if(fabs(declination)>0) {
    ascencional_difference=asin(tanf(obslat*DEGTORAD)* tanf(declination*DEGTORAD) )*RADTODEG;
    printf("DAL=asin(tan(%08.8f)*tan(%08.8f)=%08.8f;\n", obslat, declination, ascencional_difference);
  } else {
    ascencional_difference=asin(tanf(obslat*DEGTORAD))*RADTODEG;
    printf("DAL=asin(tan(%08.8f))=%08.8f;\n", obslat, ascencional_difference);
  }    
  
  RAIC=RA-RAIC;
  if(RAIC<0) RAIC=360+RAIC;
  lower_meridian_distance=RA-RAIC;
  if(lower_meridian_distance<0) lower_meridian_distance=360+lower_meridian_distance;
  printf("LMD=%08.8f-%08.8f=%08.8f\n",RA,RAIC,lower_meridian_distance);
  upper_meridian_distance=RA-RAMC;
  if(upper_meridian_distance<0) upper_meridian_distance=360+upper_meridian_distance;
  printf("UMD=%08.8f-%08.8f=%08.8f\n",RA,RAMC,upper_meridian_distance);
  diurnal_semi_arc=90-ascencional_difference;
  printf("DSA=%08.8f\n", diurnal_semi_arc);
  nocturnal_semi_arc=180-ascencional_difference;
  if(nocturnal_semi_arc<0) {
    nocturnal_semi_arc=360+nocturnal_semi_arc;
  }
  if(RA<ascendente) {
    meridian_distance=upper_meridian_distance;
    semi_arc=diurnal_semi_arc;
  } else {
    meridian_distance=lower_meridian_distance;
    semi_arc=nocturnal_semi_arc;
  }
  printf("MD/SA=%08.8f\n", (meridian_distance/semi_arc));
  polo=(meridian_distance/semi_arc)*(tanf(obslat*DEGTORAD)*RADTODEG);
  printf("%08.8f/%08.8f * tan(%08.8f) = %08.8f\n", meridian_distance, semi_arc, obslat, polo);
  printf("tan(P)=%08.8f\n", polo);
  if(fabs(declination)>0) {
    temp=(polo*DEGTORAD)*tanf(declination*DEGTORAD);
    printf("%08.8f\n", temp);
    printf("%08.8f\n", temp*RADTODEG);
    diferencia_ascencional_polo=asinf(temp)*RADTODEG;
  } else {
    diferencia_ascencional_polo=asinf((polo*DEGTORAD) )*RADTODEG;
    printf("%08.8f\n", diferencia_ascencional_polo);
  }
  printf("DAP=%08.8f\n", diferencia_ascencional_polo);  
  return  0;
}
 
