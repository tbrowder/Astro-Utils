[![Actions Status](https://github.com/tbrowder/Astro-Utils/workflows/test/badge.svg)](https://github.com/tbrowder/Astro-Utils/actions)

NAME
====

**Astro::Utils** - Provides utility functions for astronomical calculations

SYNOPSIS
========

```raku
use Astro::Utils :ALL;
my $x = 1.234;
my $y = 5.5678;
say Frac $x;       # OUTPUT: «0.234␤»
say Modulo $x, $y; # OUTPUT: «1.234␤»
say Modulo $y, $x; # OUTPUT: «0.6318␤»
```

DESCRIPTION
===========

Raku module **Astro::Utils** is a collection of utility functions from several popular astronomy-related books by authors such as *Montenbruck*, *Meeus*, and *Lawrence*. Also included are functions from Perl module [Astro::Montenbruck](https://github.com/skrushinsky/astro-montenbruck).

Exported functions
------------------

### Frac

```raku
sub Frac($x --> Real) is export(:Frac) {...}
```

Returns the fractional part of a number (from Ref. 1, p. 8). (Note it is the same as the `frac` function from Raku module `Math::FractionalPart`.)

### Modulo

```raku
sub Modulo($x, $y) is export(:Modulo) {...}
```

Returns $x mod $y (from Ref. 1, p. 8). (Note it is the same as the Raku infix operator `%`.)

### delta-T

```raku
sub delta-T($year, $month --> Real) is export(:delta-T) {...}
```

Returns the `delta-T` value for the given year and month.

From [https://eclipse.gsfc.nasa.gov/SEhelp/deltatpoly2004.html](https://eclipse.gsfc.nasa.gov/SEhelp/deltatpoly2004.html):

The orbital positions of the Sun and Moon required by eclipse predictions, are calculated using Terrestrial Dynamical Time (TD) because it is a uniform time scale. However, world time zones and daily life are based on Universal Time[1] (UT). In order to convert eclipse predictions from TD to UT, the difference between these two time scales must be known. The parameter delta-T (ΔT) is the arithmetic difference, in seconds, between the two as:

```raku
ΔT = TD - UT
```

### delta-T2

```raku
sub delta-T2(DateTime $T --> Real) is export(:delta-T2) {...}
```

Also returns ΔT (see routine `delta-T`), but using code based on the `delta_t` function from Ref. 3, file '../Time/DeltaT.pm'.

### dayfrac2hms

```raku
sub dayfrac2hms($dayfraction is copy --> List) is export(:dayfrac2hms) {...}
```

Returns the `$dayfraction` as a list of `hours` (Int), `minutes` (Int), and `minutes` (Real) (from Ref. 2).

`$dayfraction` must be a fraction of a day of 24 hours. The input's integral portion, if any, is ignored.

### polynome

```raku
sub polynome($t, @terms) is export(:polynome) {...}
```

Calculates the polynomial `a0*t**0 + a1*t**1 + a2*t**2 + a3*t**3...` using code based on the `polynome` function from Ref. 3, file '../Montenbruck/MathUtils.pm'.

Parameters: `$t` is the coefficient (in astronomical routines it's usually time in centuries) and `@terms` is a list of any number of decimal values.

References
----------

1. *Astronomy on the Personal Computer, 4th Edition*, Oliver Montenbruck and Thomas Pfleger, 2000, Springer-Verlag.

2. *Celestial Calculations*, J. L. Lawrence.

3. Perl module [Astro::Montenbruck](https://github.com/skrushinsky/astro-montenbruck).

AUTHOR
======

Tom Browder (tbrowder@cpan.org)

COPYRIGHT and LICENSE
=====================

Copyright © 2021 Tom Browder

This library is free software; you may redistribute or modify it under the Artistic License 2.0.

