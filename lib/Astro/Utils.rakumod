unit module Astro::Utils;

use Math::FractionalPart :ALL;
use Math::Trig;

sub Frac(\x) is export(:Frac) {
    # APC p.8
    # Gives the fractional part of a number
    x - x.floor

}

sub Modulo(\x, \y) is export(:Modulo) {
    # APC p.8
    # Calculates x mod y
    y * Frac(x/y)
}

#| Some time conversion functions from J. L. Lawrence's
#| book "Celestial Calculations" (with modifications).
#| Chapters 2 and 3

#| decimal hours to hms
#| See p. 18
sub dayfrac2hms($hours is copy --> List) is export(:dayfrac2hms) {
    # hours must be a fraction of a day of 24 hours
    # the input's integral portion, if any, is ignored
    if not (0 <= $hours < 1) {
        note "NOTE: Input \$hours ($hours) is expected to be >= 0 and < 1";
        $hours .= afrac;
    }

    my $hreal = 24 * $hours;
    my $h = $hreal.Int;
    my $m = (60 * afrac($hreal)).Int;
    my $s = 60 * afrac(60 * afrac($hreal));
    $h, $m, $s
} # sub dayfrac2hms

constant %HISTORICAL = [
    # From J.Meeus, Astronomical Algorithms, 2 edition
    1620 => 121.0,
    1622 => 112.0,
    1624 => 103.0,
    1626 => 95.0,
    1628 => 88.0,
    1630 => 82.0,
    1632 => 77.0,
    1634 => 72.0,
    1636 => 68.0,
    1638 => 63.0,
    1640 => 60.0,
    1642 => 56.0,
    1644 => 53.0,
    1646 => 51.0,
    1648 => 48.0,
    1650 => 46.0,
    1652 => 44.0,
    1654 => 42.0,
    1656 => 40.0,
    1658 => 38.0,
    1660 => 35.0,
    1662 => 33.0,
    1664 => 31.0,
    1666 => 29.0,
    1668 => 26.0,
    1670 => 24.0,
    1672 => 22.0,
    1674 => 20.0,
    1676 => 19.0,
    1678 => 16.0,
    1680 => 14.0,
    1682 => 12.0,
    1684 => 11.0,
    1686 => 10.0,
    1688 => 9.0,
    1690 => 8.0,
    1692 => 7.0,
    1694 => 7.0,
    1696 => 7.0,
    1698 => 7.0,
    1700 => 7.0,
    1702 => 7.0,
    1704 => 8.0,
    1706 => 8.0,
    1708 => 9.0,
    1710 => 9.0,
    1712 => 9.0,
    1714 => 9.0,
    1716 => 9.0,
    1718 => 10.0,
    1720 => 10.0,
    1722 => 10.0,
    1724 => 10.0,
    1726 => 10.0,
    1728 => 10.0,
    1730 => 10.0,
    1732 => 10.0,
    1734 => 11.0,
    1736 => 11.0,
    1738 => 11.0,
    1740 => 11.0,
    1742 => 11.0,
    1744 => 12.0,
    1746 => 12.0,
    1748 => 12.0,
    1750 => 12.0,
    1752 => 13.0,
    1754 => 13.0,
    1756 => 13.0,
    1758 => 14.0,
    1760 => 14.0,
    1762 => 14.0,
    1764 => 14.0,
    1766 => 15.0,
    1768 => 15.0,
    1770 => 15.0,
    1772 => 15.0,
    1774 => 15.0,
    1776 => 16.0,
    1778 => 16.0,
    1780 => 16.0,
    1782 => 16.0,
    1784 => 16.0,
    1786 => 16.0,
    1788 => 16.0,
    1790 => 16.0,
    1792 => 15.0,
    1794 => 15.0,
    1796 => 14.0,
    1798 => 13.0,
    1800 => 13.1,
    1802 => 12.5,
    1804 => 12.2,
    1806 => 12.0,
    1808 => 12.0,
    1810 => 12.0,
    1812 => 12.0,
    1814 => 12.0,
    1816 => 12.0,
    1818 => 11.9,
    1820 => 11.6,
    1822 => 11.0,
    1824 => 10.2,
    1826 => 9.2,
    1828 => 8.2,
    1830 => 7.1,
    1832 => 6.2,
    1834 => 5.6,
    1836 => 5.4,
    1838 => 5.3,
    1840 => 5.4,
    1842 => 5.6,
    1844 => 5.9,
    1846 => 6.2,
    1848 => 6.5,
    1850 => 6.8,
    1852 => 7.1,
    1854 => 7.3,
    1856 => 7.5,
    1858 => 7.6,
    1860 => 7.7,
    1862 => 7.3,
    1864 => 6.2,
    1866 => 5.2,
    1868 => 2.7,
    1870 => 1.4,
    1872 => -1.2,
    1874 => -2.8,
    1876 => -3.8,
    1878 => -4.8,
    1880 => -5.5,
    1882 => -5.3,
    1884 => -5.6,
    1886 => -5.7,
    1888 => -5.9,
    1890 => -6.0,
    1892 => -6.3,
    1894 => -6.5,
    1896 => -6.2,
    1898 => -4.7,
    1900 => -2.8,
    1902 => -0.1,
    1904 => 2.6,
    1906 => 5.3,
    1908 => 7.7,
    1910 => 10.4,
    1912 => 13.3,
    1914 => 16.0,
    1916 => 18.2,
    1918 => 20.2,
    1920 => 21.1,
    1922 => 22.4,
    1924 => 23.5,
    1926 => 23.8,
    1928 => 24.3,
    1930 => 24.0,
    1932 => 23.9,
    1934 => 23.9,
    1936 => 23.7,
    1938 => 24.0,
    1940 => 24.3,
    1942 => 25.3,
    1944 => 26.2,
    1946 => 27.3,
    1948 => 28.2,
    1950 => 29.1,
    1952 => 30.0,
    1954 => 30.7,
    1956 => 31.4,
    1958 => 32.2,
    1960 => 33.1,
    1962 => 34.0,
    1964 => 35.0,
    1966 => 36.5,
    1968 => 38.3,
    1970 => 40.2,
    1972 => 42.2,
    1974 => 44.5,
    1976 => 46.5,
    1978 => 48.5,
    1980 => 50.5,
    1982 => 52.2,
    1984 => 53.8,
    1986 => 54.9,
    1988 => 55.8,
    1990 => 56.9,
    1992 => 58.3,
    1994 => 60.0,
    1996 => 61.6,
    1998 => 63.0,

    # From http://www.staff.science.uu.nl/~gent0113/deltat/deltat_modern.htm
    2000 => 63.8,
    2002 => 63.3,
    2004 => 64.6,
    2006 => 64.9,
    2008 => 65.5,
    2010 => 66.1,
    2012 => 68.0,
    2014 => 69.0,
    2016 => 70.0
];

constant TAB-SINCE = 1620;
constant TAB-UNTIL = 2016;

sub polynome(\t,     # coefficient
             @terms  # decimal values
             --> Real
            ) is export(:polynome) {
    # Calculates polynome: $a1 + $a2*$t + $a3*$t*$t + $a4*$t*$t*$t...

    # reduce { $a * $t + $b } reverse @terms; # original Perl code

    my \c = @terms.reverse;
    my \xi = (c.elems ^... 0).map: -> \i { t ** i }; # [t^(n-1), ..., t^0]
    my \axi = [+] c Z* xi;                           # [c[n-1]*t^(n-1), ..., t[*]x^0]
    [+] axi;                                         # sum of axi

    =begin comment
    # from Raku docs (Type/List.pod6)
    B<Practical example 2:> Suppose we have a polynomial represented as a list of
    integer coefficients, c[n-1], c[n-2], ..., c[0], where c[i] is the coefficient
    of xi. We can evaluate it using C<map> and C<reduce> as follows:

    sub evaluate(List:D \c where c.all ~~ Int, Rat:D \x --> Rat:D) {
        my \xi = (c.elems ^... 0).map: -> \i { x ** i }; # [x^(n-1), ..., x^0]
        my \axi = [+] c Z* xi;                           # [c[n-1]*x^(n-1), ..., c[*]x^0]
        [+] axi;                                         # sum of axi
    }

    my \c = 2,xd 3, 1;       # 2x² + 3x + 1
    say evaluate c, 3.0;   # OUTPUT: «28␤»
    say evaluate c, 10.0;  # OUTPUT: «231␤»
    =end comment

} # sub polynome

sub delta-T2(DateTime \T --> Real) is export(:delta-T2) {
    # This routine is based on code from Ref. 3, file '../Time/DeltaT.pm'.
    my \jd = T.julian-date;
    my \ye = T.year;

    return _interpolate(jd, ye) if ye >= TAB-SINCE && ye <= TAB-UNTIL;
    my \t = ( ye - 2000 ) / 100.0;
    return polynome( t, 2177.0, 497.0, 44.1 ) if ye < 948;

    my $dt = polynome( t, 102.0, 102.0, 25.3 );
    $dt += 0.37 * ( ye - 2100 ) if ye > TAB-UNTIL && ye < 2100;
    $dt

} # sub delta-T2

sub delta-T(\year, \month --> Real) is export(:delta-T) {
    my Real $dt = 0; # ΔT

    # Using the ΔT values derived from the historical record and from
    # direct observations (see: Table 1 and Table 2 ), a series of
    # polynomial expressions have been created to simplify the
    # evaluation of ΔT for any time during the interval -1999 to
    # +3000.
    #
    # We define the decimal year "y" as follows:
    #
    # 		y = year + (month - 0.5)/12
    my \y = year + (month - 0.5)/12;

    # This gives "y" for the middle of the month, which is accurate
    # enough given the precision in the known values of ΔT. The
    # following polynomial expressions can be used calculate the value
    # of ΔT (in seconds) over the time period covered by of the Five
    # Millennium Canon of Solar Eclipses: -1999 to +3000.

    with year {

        # Before the year -500, calculate:
        #
        # 		ΔT = -20 + 32 * u^2
        # 		where:	u = (year-1820)/100
        when year < -500 {
            my \u = (year - 1820)/100;
            $dt = -20 + 32 * u**2;
        }

        # Between years -500 and +500, we use the data from Table 1,
        # except that for the year -500 we changed the value 17190 to
        # 17203.7 in order to avoid a discontinuity with the previous
        # formula at that epoch. The value for ΔT is given by a
        # polynomial of the 6th degree, which reproduces the values in
        # Table 1 with an error not larger than 4 seconds:
        #
        # 	ΔT = 10583.6 - 1014.41 * u + 33.78311 * u^2 - 5.952053 * u^3
        # 		- 0.1798452 * u^4 + 0.022174192 * u^5 + 0.0090316521 * u^6
        #
        # 	   where: u = y/100
        when -500 <= year <= +500 {
            my \u = y/100;
            $dt = 10583.6 - 1014.41 * u + 33.78311 * u**2 - 5.952053 * u**3
                  - 0.1798452 * u**4 + 0.022174192 * u**5 + 0.0090316521 * u**6;
        }

        # Between years +500 and +1600, we again use the data from Table 1
        # to derive a polynomial of the 6th degree.
        #
        # 	ΔT = 1574.2 - 556.01 * u + 71.23472 * u^2 + 0.319781 * u^3
        # 		- 0.8503463 * u^4 - 0.005050998 * u^5 + 0.0083572073 * u^6
        #
        #         where: u = (y-1000)/100
        when +500 < year <= +1600 {
            my \u = (y - 1000)/100;
            $dt = 1574.2 - 556.01 * u + 71.23472 * u**2 + 0.319781 * u**3
         		- 0.8503463 * u**4 - 0.005050998 * u**5 + 0.0083572073 * u**6;
        }


        # Between years +1600 and +1700, calculate:
        #
        # 	ΔT = 120 - 0.9808 * t - 0.01532 * t^2 + t^3 / 7129
        # 	where:  t = y - 1600
        when +1600 < year <= +1700 {
            my \t = y - 1600;
            $dt = 120 - 0.9808 * t - 0.01532 * t**2 + t**3 / 7129;
        }

        # Between years +1700 and +1800, calculate:
        #
        # 	ΔT = 8.83 + 0.1603 * t - 0.0059285 * t^2 + 0.00013336 * t^3 - t^4 / 1174000
        # 	where: t = y - 1700
        when +1700 < year <= +1800 {
            my \t = y - 1700;
            $dt = 8.83 + 0.1603 * t - 0.0059285 * t**2 + 0.00013336 * t**3 - t**4 / 1174000;
        }

        # Between years +1800 and +1860, calculate:
        #
        # 	ΔT = 13.72 - 0.332447 * t + 0.0068612 * t^2 + 0.0041116 * t^3 - 0.00037436 * t^4
        # 		+ 0.0000121272 * t^5 - 0.0000001699 * t^6 + 0.000000000875 * t^7
        # 	where: t = y - 1800
        when +1800 < year <= +1860 {
            my \t = y - 1800;
            $dt = 13.72 - 0.332447 * t + 0.0068612 * t**2 + 0.0041116 * t**3 - 0.00037436 * t**4
         		+ 0.0000121272 * t**5 - 0.0000001699 * t**6 + 0.000000000875 * t**7;
        }

        # Between years 1860 and 1900, calculate:
        #
        # 	ΔT = 7.62 + 0.5737 * t - 0.251754 * t^2 + 0.01680668 * t^3
        # 		-0.0004473624 * t^4 + t^5 / 233174
        # 	where: t = y - 1860
        when +1860 < year <= +1900 {
            my \t = y - 1860;
            $dt = 7.62 + 0.5737 * t - 0.251754 * t**2 + 0.01680668 * t**3
         		-0.0004473624 * t**4 + t**5 / 233174;
        }

        # Between years 1900 and 1920, calculate:
        #
        # 	ΔT = -2.79 + 1.494119 * t - 0.0598939 * t^2 + 0.0061966 * t^3 - 0.000197 * t^4
        # 	where: t = y - 1900
        when +1900 < year <= +1920 {
            my \t = y - 1900;
            $dt = -2.79 + 1.494119 * t - 0.0598939 * t**2 + 0.0061966 * t**3 - 0.000197 * t**4;
        }

        # Between years 1920 and 1941, calculate:
        #
        # 	ΔT = 21.20 + 0.84493*t - 0.076100 * t^2 + 0.0020936 * t^3
        # 	where: t = y - 1920
        when +1920 < year <= +1941 {
            my \t = y - 1920;
            $dt = 21.20 + 0.84493*t - 0.076100 * t**2 + 0.0020936 * t**3;
        }

        # Between years 1941 and 1961, calculate:
        #
        # 	ΔT = 29.07 + 0.407*t - t^2/233 + t^3 / 2547
        # 	where: t = y - 1950
        when +1941 < year <= +1961 {
            my \t = y - 1950;
            $dt = 29.07 + 0.407*t - t**2/233 + t**3 / 2547;
        }

        # Between years 1961 and 1986, calculate:
        #
        # 	ΔT = 45.45 + 1.067*t - t^2/260 - t^3 / 718
        # 	where: t = y - 1975
        when +1961 < year <= +1986 {
            my \t = y - 1975;
            $dt = 45.45 + 1.067*t - t**2/260 - t**3 / 718;
        }

        # Between years 1986 and 2005, calculate:
        #
        # 	ΔT = 63.86 + 0.3345 * t - 0.060374 * t^2 + 0.0017275 * t^3 + 0.000651814 * t^4
        # 		+ 0.00002373599 * t^5
        #
        # 	where: t = y - 2000
        when +1986 < year <= +2005 {
            my \t = y - 2000;
            $dt = 63.86 + 0.3345 * t - 0.060374 * t**2 + 0.0017275 * t**3 + 0.000651814 * t**4
         		+ 0.00002373599 * t**5;
        }

        # Between years 2005 and 2050, calculate:
        #
        # 	ΔT = 62.92 + 0.32217 * t + 0.005589 * t^2
        # 	where: t = y - 2000
        when +2005 < year <= +2050 {
            my \t = y - 2000;
            $dt = 62.92 + 0.32217 * t + 0.005589 * t**2;
        }

        # This expression is derived from estimated values of ΔT in the
        # years 2010 and 2050. The value for 2010 (66.9 seconds) is based
        # on a linearly extrapolation from 2005 using 0.39 seconds/year
        # (average from 1995 to 2005). The value for 2050 (93 seconds) is
        # linearly extrapolated from 2010 using 0.66 seconds/year (average
        # rate from 1901 to 2000).

        # Between years 2050 and 2150, calculate:
        #
        # 	ΔT = -20 + 32 * ((y-1820)/100)^2 - 0.5628 * (2150 - y)
        #
        #         The last term is introduced to eliminate the
        #         discontinuity at 2050.
        when +2050 < year <= +2150 {
            $dt = -20 + 32 * ((y-1820)/100)^2 - 0.5628 * (2150 - y);
        }

        # After 2150, calculate:
        #
        # 	ΔT = -20 + 32 * u^2
        #
        # 	where:	u = (year-1820)/100
        when +2150 < year {
            my \u = (year -1820)/100;
            $dt = -20 + 32 * u**2;
        }

        # All values of ΔT based on Morrison and Stephenson [2004] assume
        # a value for the Moon's secular acceleration of -26
        # arcsec/cy^2. However, the ELP-2000/82 lunar ephemeris employed
        # in the Canon uses a slightly different value of -25.858
        # arcsec/cy^2. Thus, a small correction "c" must be added to the
        # values derived from the polynomial expressions for ΔT before
        # they can be used in the Canon
        #
        # 	c = -0.000012932 * (y - 1955)^2
        #
        # Since the values of ΔT for the interval 1955 to 2005 were
        # derived independent of any lunar ephemeris, no correction is
        # needed for this period.
    }
    $dt;
} # sub delta-T

sub _interpolate(\jd, \ye) {
    # A private function using code based on the `_interpolate`
    # function from Ref. 3, file '../Time/DeltaT.pm'.

    # For a historical range from 1620 to a recent year, we
    # interpolate from a table of observed values. Outside that range
    # we use formulae.

    # Last value in the table
    if ( ye == TAB-UNTIL ) {
        return %HISTORICAL{TAB-UNTIL};
    }

    # 1620 - 20xx
    my \y0 =
        ye % 2 == 0 ?? ye !! ye - 1;   # there are only even numbers in the table
    my \y1 = y0 + 2;
    my \d0 = %HISTORICAL{y0};
    my \d1 = %HISTORICAL{y1};
    my \j0 = DateTime.new(:year(y0), :month(1), :day(1)).julian-data; # cal2jd( y0, 1, 1 );
    my \j1 = DateTime.new(:year(y1), :month(1), :day(1)).julian-data; # cal2jd( y1, 1, 1 );

    # simple linear interpolation between two values
    ( ( jd - j0 ) * ( d1 - d0 ) / ( j1 - j0 ) ) + d0;
} # sub _interpolate

sub ddd(*@args) is export(:ddd)  {
    my $sgn = (@args.any < 0) ?? -1 !! +1;
    my ( $d, $m, $s ) = map { abs( @args[$_] || 0 ) }, ( 0 .. 2 );
    return $sgn * ( $d + ( $m + $s / 60.0 ) / 60.0 );
} # sub ddd
