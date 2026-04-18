
/* &t=
  $Header: /home/dieter/sweph/RCS/swemin04fi.c,v 1.74 2008/06/16 10:07:20 dieter Exp $

  swemini.c	A minimal program to test the Swiss Ephemeris.

  Input: a date (in gregorian calendar, sequence day.month.year)
  Output: Planet positions at midnight Universal time, ecliptic coordinates,
          geocentric apparent positions relative to true equinox of date, as 
          usual in western astrology.
		
   
  Authors: Dieter Koch and Alois Treindl, Astrodienst Zurich

**************************************************************/
/* Copyright (C) 1997 - 2008 Astrodienst AG, Switzerland.  All rights reserved.
  
  License conditions
  ------------------

  This file is part of Swiss Ephemeris.

  Swiss Ephemeris is distributed with NO WARRANTY OF ANY KIND.  No author
  or distributor accepts any responsibility for the consequences of using it,
  or for whether it serves any particular purpose or works at all, unless he
  or she says so in writing.  

  Swiss Ephemeris is made available by its authors under a dual licensing
  system. The software developer, who uses any part of Swiss Ephemeris
  in his or her software, must choose between one of the two license models,
  which are
  a) GNU public license version 2 or later
  b) Swiss Ephemeris Professional License

  The choice must be made before the software developer distributes software
  containing parts of Swiss Ephemeris to others, and before any public
  service using the developed software is activated.

  If the developer choses the GNU GPL software license, he or she must fulfill
  the conditions of that license, which includes the obligation to place his
  or her whole software project under the GNU GPL or a compatible license.
  See http://www.gnu.org/licenses/old-licenses/gpl-2.0.html

  If the developer choses the Swiss Ephemeris Professional license,
  he must follow the instructions as found in http://www.astro.com/swisseph/ 
  and purchase the Swiss Ephemeris Professional Edition from Astrodienst
  and sign the corresponding license contract.

  The License grants you the right to use, copy, modify and redistribute
  Swiss Ephemeris, but only under certain conditions described in the License.
  Among other things, the License requires that the copyright notices and
  this notice be preserved on all copies.

  Authors of the Swiss Ephemeris: Dieter Koch and Alois Treindl

  The authors of Swiss Ephemeris have no control or influence over any of
  the derived works, i.e. over software or services created by other
  programmers which use Swiss Ephemeris functions.

  The names of the authors or of the copyright holder (Astrodienst) must not
  be used for promoting any software, product or service which uses or contains
  the Swiss Ephemeris. This copyright notice is the ONLY place where the
  names of the authors can legally appear, except in cases where they have
  given special permission in writing.

  The trademarks 'Swiss Ephemeris' and 'Swiss Ephemeris inside' may be used
  for promoting such software, products or services.
*/


#include "swephexp.h" 	/* this includes  "sweodef.h" */

int main(int argc, char *argv[])
{
  char sdate[AS_MAXCH], snam[40], serr[AS_MAXCH], splace[20];  
  int i=0, jday = 1, jmon = 1, jyear = 2000, date=0;
  double geo_lon, geo_lat, geo_lat_polo, altitude_above_sea, plon, plat, pRA=0, pDE=0;
  double jut = 0.0, thour=0, t=0, j=0;
  char s1[AS_MAXCH], s2[AS_MAXCH];
  char *begindate = NULL;
  char *sp, *sp2;
  double DM, armc, house, tjd, te, eps[6], xpo[3], xpn[3], xpin[2], x2[6], cusps[13], ascmc[10], cusps2[13], ascmc2[10];
  char ss[550], sss[6000];
  double ASCA,ASCE, RUEDAA,RUEDAE=0;
	double casa7=0;
	double casa7E=0;
	double sola,sole=0;
	double luna,lune=0;
  int32 iflag, iflag2, iflag3, iflgret;
  int p;
	iflag = SEFLG_TOPOCTR |  SEFLG_SWIEPH;
	iflag3 = SEFLG_TOPOCTR |  SEFLG_SWIEPH | SEFLG_SPEED | SEFLG_EQUATORIAL | SEFLG_RADIANS;
	iflag2 = SEFLG_TOPOCTR |  SEFLG_SWIEPH | SEFLG_SPEED ; 
	for (i = 1; i < argc; i++) {
		  if (strncmp(argv[i], "-ut", 3) == 0) {
			  if (strlen(argv[i]) > 3) {
				  *s1 = '\0';
				  strncat(s1, argv[i] + 3, 30);
				  if ((sp = strchr(s1, ':')) != NULL) {
					  *sp = '.';
					  if ((sp = strchr(s1, ':')) != NULL) {
						  strcpy(s2, sp + 1);
						  strcpy(sp, s2);
					  }
				  }
				  thour = atof(s1);
				  thour += (thour < 0 ? -.00005 : .00005);
				  /* h.mmss -> decimal */
				  t =  fmod(thour, 1) * 100;
				  j = (int) t;
				  t = (int)(fmod(t, 1) * 100);
				  thour = (int) thour + j / 60.0 + t / 3600.0;
			  }
		  } else if (strncmp(argv[i], "-b", 2) == 0) {
			  begindate = argv[i] + 2;
			  date=1;
		  } else if (strncmp(argv[i], "-topo", 5) == 0) {
			  sscanf(argv[i] + 5, "%lf,%lf,%lf", &geo_lon, &geo_lat, &altitude_above_sea);
		  } else if (strncmp(argv[i], "-nor", 4) == 0) {
			  if (strlen(argv[i]) > 4) {
				  *s1 = '\0';
				  strncat(s1, argv[i] + 4, 30);
				  if ((sp = strchr(s1, ':')) != NULL) {
					  *sp = '.';
					  if ((sp = strchr(s1, ':')) != NULL) {
						  strcpy(s2, sp + 1);
						  strcpy(sp, s2);
					  }
				  }
				  geo_lat = atof(s1);
				  geo_lat += (geo_lat < 0 ? -.00005 : .00005);
				  t =  fmod(geo_lat, 1) * 100;
				  j = (int) t;
				  t = (int)(fmod(t, 1) * 100);
				  geo_lat = (int) geo_lat + j / 60.0 + t / 3600.0;
			  }
			  
		  } else if (strncmp(argv[i], "-est", 4) == 0) {
			  if (strlen(argv[i]) > 4) {
				  *s1 = '\0';
				  strncat(s1, argv[i] + 4, 30);
				  if ((sp = strchr(s1, ':')) != NULL) {
					  *sp = '.';
					  if ((sp = strchr(s1, ':')) != NULL) {
						  strcpy(s2, sp + 1);
						  strcpy(sp, s2);
					  }
				  }
				  geo_lon = atof(s1);
				  geo_lon += (geo_lon < 0 ? -.00005 : .00005);
				  t =  fmod(geo_lon, 1) * 100;
				  j = (int) t;
				  t = (int)(fmod(t, 1) * 100);
				  geo_lon = (int) geo_lon + j / 60.0 + t / 3600.0;
			  } 
		  } else if (strncmp(argv[i], "-alt", 4) == 0) {
				  sscanf(argv[i] + 4, "%lf", &altitude_above_sea);
		  }
		
}
	swe_set_topo(geo_lon, geo_lat, altitude_above_sea);
	if(date==1) {
	  *sdate = '\0';
	  strncat(sdate, begindate, AS_MAXCH-1);
	  if (sscanf (sdate, "%d%*c%d%*c%d", &jday,&jmon,&jyear) < 1) exit(1);
	  double dret[2];
	  tjd=swe_utc_to_jd(jyear,jmon,jday,(int)thour,(thour-(int)thour)*60, 0, 1, dret, serr);
	  tjd=dret[1];
	  double lst=swe_sidtime(tjd);
	  te = tjd + swe_deltat_ex(tjd, SEFLG_SWIEPH, serr);
	  swe_set_topo(geo_lon, geo_lat, altitude_above_sea);
	  swe_houses(tjd, geo_lat, geo_lon, 'T', cusps2, ascmc2);

	  xpo[0]=ascmc[0];
	  xpo[1]=0.0;
	  xpo[2]=1.0;
	  swe_cotrans(xpo, xpn, -eps[0]); //eclipt->eq

	  DM=swe_degnorm(xpn[0]+ascmc[2]);//DM
	  geo_lat_polo=(DM/90)*DEGTORAD;
	  geo_lat_polo=geo_lat_polo*(tanl(geo_lat * DEGTORAD));
	  geo_lat_polo=atan(geo_lat_polo)*RADTODEG;

	  swe_set_topo(geo_lon, geo_lat_polo, altitude_above_sea);
	  swe_houses(tjd, geo_lat_polo, geo_lon, 'P', cusps, ascmc);
	}
	swe_calc(te, SE_ECL_NUT, iflag, eps, serr);
	*sss = '\0';
	//printf("lon=%04f lat=%04f alt=%04f %02d-%02d-%04d %02d:%02d\n", geo_lon, geo_lat, altitude_above_sea, jday, jmon, jyear, (int)thour, (int)((thour-(int)thour)*60));
	for (p = SE_SUN; p < 12; p++) {
	  if (p == SE_EARTH) continue;
	  swe_set_topo(geo_lon, geo_lat, altitude_above_sea);
	  iflgret = swe_calc_ut(tjd, p, iflag3, x2, serr);
	  if (iflgret < 0) printf("error: %s\n", serr);
	  int AO=0;
	  if(geo_lat>0) {
	    if(x2[0]*RADTODEG<=ascmc[2]) AO=1;
	    else  AO=0;
	  } else { 
	    if(x2[0]*RADTODEG>=ascmc[2]) AO=1;
	    else AO=0;
	  }
	  double lsAD=0;
	  lsAD=asin(tan(x2[1])*tan(geo_lat*DEGTORAD))*RADTODEG; //DA diferencia ascenciona;l
	  x2[0]=x2[0]*RADTODEG;
	  x2[1]=x2[1]*RADTODEG;
	  //printf("DEC %04f %04f lat %04f RA %04f lsAD %04f\n", x2[1], x2[1]*RADTODEG, geo_lat, x2[0], lsAD);

	  if(geo_lat>0 && x2[1]<0) lsAD=-lsAD;
	  if(geo_lat<0 && x2[1]>0) lsAD=-lsAD;
	  if(AO==1 && geo_lat<0) x2[0]+=lsAD;
	  if(AO==0 && geo_lat<0) x2[0]-=lsAD;
	  if(AO==0 && geo_lat>0) x2[0]+=lsAD;
	  if(AO==1 && geo_lat>0) x2[0]-=lsAD;
	  //if(AO==0) x2[0]=swe_degnorm(180-x2[0]);
	  xpo[0]=x2[0];
	  xpo[1]=x2[1];
	  xpo[2]=x2[2];
	  swe_cotrans(xpo, xpn, eps[0]);
	  xpin[0]=xpn[0];
	  xpin[1]=xpn[1];
	  xpin[2]=xpn[2];
	  house=swe_house_pos(ascmc[2], geo_lat_polo, eps[0], 'T', xpin, serr);
	  swe_get_planet_name(p, snam);
	  *ss='\0';
	  sprintf(ss,  "p=%s&RA=%04f&t=ASCENCIONAL\n", snam, x2[0]);
	  if(!strcmp(snam,"Moon")) luna=x2[0];
	  if(!strcmp(snam,"Sun")) sola=x2[0];		
	  strcat(sss, ss);
	  swe_set_topo(geo_lon, geo_lat, altitude_above_sea);
	  iflgret = swe_calc_ut(tjd, p, iflag2, x2, serr);
	  *ss='\0';
	  sprintf(ss, "p=%s&r=%04f&t=ECLIPTICO\n", snam, x2[0]);
	  if(!strcmp(snam,"Sun")) sole=x2[0];	
	  if(!strcmp(snam,"Moon")) lune=x2[0];
	  strcat(sss, ss);
	}

	for (p = 1; p <= 12; p++) {
		xpo[0]=cusps[p];
		xpo[1]=0.0;
		xpo[2]=1.0;
		swe_cotrans(xpo, xpn, -eps[0]);
		*ss='\0';
		sprintf(ss, "p=%d&r=%04f&t=ASCENCIONAL\n", p, xpn[0]);
		if(p==1) ASCA=xpn[0];
		if(p==7) casa7=xpn[0];
		strcat(sss, ss);
		*ss='\0';
		sprintf(ss, "p=%0d&r=%04f&t=ECLIPTICO\n", p, cusps2[p]);
		if(p==1) ASCE=cusps2[p];
		if(p==7) casa7E=cusps2[p];
		strcat(sss, ss);
	}
//	if(sola>=casa7) {RUEDAA=luna-sola;}
//	if(sola<casa7) {RUEDAA=sola-luna;}
	RUEDAA=luna-sola;
//	if(sole>=casa7E) {RUEDAE=sole-lune;}
//	if(sole<casa7E) {RUEDAE=lune-sole;}
	RUEDAE=lune-sole;
	
//###
    if(RUEDAA<0) RUEDAA=360+RUEDAA;
	if(RUEDAE<0) RUEDAE=360+RUEDAE;
	while(RUEDAA>360) RUEDAA=RUEDAA-360;
	while(RUEDAE>360) RUEDAE=RUEDAE-360;	
//	printf("%06f %06f %06f\n", RUEDAA, sola, luna);
//	printf("%06f %06f %06f\n", RUEDAE, sole, lune);
	RUEDAA=ASCA+RUEDAA;
	RUEDAE=ASCE+RUEDAE;
    if(RUEDAA<0) RUEDAA=360+RUEDAA;
	if(RUEDAE<0) RUEDAE=360+RUEDAE;
	while(RUEDAA>360) RUEDAA=RUEDAA-360;
	while(RUEDAE>360) RUEDAE=RUEDAE-360;
	sprintf(ss, "p=RUEDA&r=%04f&t=ASCENCIONAL\n", RUEDAA);
	strcat(sss, ss);
	sprintf(ss, "p=RUEDA&r=%04f&t=ECLIPTICO\n", RUEDAE);
		strcat(sss, ss);
	
	printf("%s", sss);
	swe_close();

	return  OK;
}
