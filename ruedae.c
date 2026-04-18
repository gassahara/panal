
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
  char patron[1024];
  (void)strncpy(patron, argv[1], sizeof(patron) - 1);
  patron[sizeof(patron) - 1] = '\0';
	swe_set_topo(geo_lon, geo_lat, altitude_above_sea);
	  if (sscanf (sdate, "%d%*c%d%*c%d", &jday,&jmon,&jyear) < 1) exit(1);
	  double dret[2];
	  tjd=atof(patron);
	  double lst=swe_sidtime(tjd);
	  te = tjd + swe_deltat_ex(tjd, SEFLG_SWIEPH, serr);
	}
	*sss = '\0';

		iflgret = swe_calc_ut(tjd, 0, iflag2, x2, serr);
		sole=x2[0];
		printf("luna %0.6f", sole);
		iflgret = swe_calc_ut(tjd, 1, iflag2, x2, serr);
	swe_close();
		lune=x2[0];
		printf("luna %0.6f", lune);

//	if(sole>=casa7E) {RUEDAE=sole-lune;}
//	if(sole<casa7E) {RUEDAE=lune-sole;}
	RUEDAE=lune-sole;
	
//###

	if(RUEDAE<0) RUEDAE=360+RUEDAE;
	while(RUEDAE>360) RUEDAE=RUEDAE-360;	
	RUEDAE=ASCE+RUEDAE;
	if(RUEDAE<0) RUEDAE=360+RUEDAE;
	while(RUEDAE>360) RUEDAE=RUEDAE-360;
	printf("p=RUEDA&r=%04f&t=ECLIPTICO\n", RUEDAE);

	return  OK;
}
