use Test;
use Astro::Utils :ALL;

my $dt;

plan 40;

$dt = delta-T(2006, 1);
cmp-ok $dt, '<', 70, "is delta-T ($dt) < 70";

# delta-T test data from the NASA site:
#   https://eclipse.gsfc.nasa.gov/SEhelp/deltat2004.html#tab1

# Table 1 - Values of ΔT Derived from Historical Records
# Year	   ΔT       Standard Error
#       (seconds)    (seconds)
# 28 entries
my $table1 = q:to/HERE/;
 -500	17190	       430
 -400	15530	       390
 -300	14080	       360
 -200	12790	       330
 -100	11640	       290
 0	10580	       260
 100	9600	       240
 200	8640	       210
 300	7680	       180
 400	6700	       160
 500	5710	       140
 600	4740	       120
 700	3810	       100
 800	2960	       80
 900	2200	       70
 1000	1570	       55
 1100	1090	       40
 1200	740	       30
 1300	490	       20
 1400	320	       20
 1500	200	       20
 1600	120	       20
 1700	9	       5
 1750	13	       2
 1800	14	       1
 1850	7	       1
 1900	-3	       1
 1950	29	       0.1
HERE

for $table1.lines -> $line {
    my $year   = $line.words[0];
    my $deltaT = $line.words[1].Num;
    my $stderr = $line.words[2].Num;

    my $dt = delta-T $year, 1;
    is-approx $dt, $deltaT, 0.9 * $stderr;
}

# Table 2 - Recent Values of ΔT from Direct Observations
# Year	  ΔT      5-year    Average 1-year
#      (seconds)  Change      Change
#                 (seconds) (seconds)
# 11 entries
my $table2 = q:to/HERE/;
 1955.0  +31.1	    -	-
 1960.0  +33.2	    2.1	      0.42
 1965.0  +35.7	    2.5	      0.50
 1970.0  +40.2	    4.5	      0.90
 1975.0  +45.5	    5.3	      1.06
 1980.0  +50.5	    5.0	      1.00
 1985.0  +54.3	    3.8	      0.76
 1990.0  +56.9	    2.6	      0.52
 1995.0  +60.8	    3.9	      0.78
 2000.0  +63.8	    3.0	      0.60
 2005.0  +64.7	    0.9	      0.18
HERE

for $table2.lines -> $line {
    my $year    = $line.words[0].Int;
    my $deltaT  = $line.words[1].Num;
    my $avg5yr  = $line.words[2].Num;
    my $avg1yr  = $line.words[3].Num;

    my $dt = delta-T $year, 1;
    is-approx $dt, $deltaT, 0.1 * $deltaT;
}
