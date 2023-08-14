#include <stdio.h>
#include <math.h>
#include "src/cspice/SpiceUsr.h"

int main()
{

#define EARTH           399
#define MOON            301
#define N               100
#define TIMLEN          30

  SpiceChar               utc    [TIMLEN];
  SpiceDouble             begin;
  SpiceDouble             delta;
  SpiceDouble             end;
  SpiceDouble             et;
  SpiceDouble             lt;
  SpiceDouble             pos    [3];
  SpiceInt                handle;
  SpiceDouble             state [6];
  SpiceDouble      ra;
  SpiceDouble      dec;
  SpiceDouble      r;
  /*
    Load the binary SPK ephemeris file.
  */

  furnsh_c ( "doc/html/lessons/toolkit_programs/kernels/lsk/naif0008.tls" );
    furnsh_c ( "data/de430.bsp"   );
    spklef_c ( "data/de430.bsp", &handle );

  /*
    Divide the interval of coverage [begin,end] into
    n steps.  At each step, compute the position, and
    print out the epoch in UTC time and position norm.
  */
  int n=100;
  utc2et_c ( "1983/03/20 14:13:00", &begin );
  utc2et_c ( "1983/05/20 14:13:00", &end );
  delta = ( end - begin ) / n;
  int i=0;
  SpiceDouble mpar, alt_topoc, gclat, rho, lat;
  lat=10.5;
    for ( i = 0;  i < n;  i++ )
      {
	et  =  begin + (i * delta);
 	spkgps_c ( MOON, et, "J2000", EARTH, pos, &lt );
	et2utc_c ( et, "C", 0, 20, utc );
	recrad_c ( pos, &r, &ra, &dec );
	double dra=ra*dpr_c();
	printf   ( "%s  d(km) %06f d(r) %06f RA %06f DEC %06f s %06f %06f g\n", utc, vnorm_c(pos) , r, dra, dec*dpr_c(), round(dra/30), ((dra/30)-round(dra/30))*60 );
	spkgeo_c ( MOON, et, "J2000", EARTH, state, &lt );
	printf ( "UTC = %s; ||dis|| = %f\n", utc, vnorm_c(state) );
        r=vnorm_c(state)/6371;
	mpar = asin( 1/r );
	alt_topoc = 900 - mpar * cos(900);

	gclat = lat - 0.1924 * sin(2*lat);
	rho   = 0.99833 + 0.00167 * cos(2*lat);
      }

  return ( 0 );
}

