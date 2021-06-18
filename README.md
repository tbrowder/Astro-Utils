[![Actions Status](https://github.com/tbrowder/Astro-Utils/workflows/test/badge.svg)](https://github.com/tbrowder/Astro-Utils/actions)

NAME
====

**Astro::Utils** - Provides utility functions for astronomical calculations

SYNOPSIS
========

```raku
use Astro::Utils :ALL;
my $x = 1.234;
my $x = 5.5678;
say Frac $x;
say Modulo $x, $y;
say Modulo $y, $x;
```

DESCRIPTION
===========

**Astro::Utils** is a collection of utility functions from several popular astronomy-related books by authors such as Montenbruck, Meeus, and Lawrence.

Exported functions
------------------

### Frac

```raku
sub Frac(\x --> Real) is export(:Frac) {...}
```

Returns the fractional part of a number (from Ref. 1, p. 8).

### Modulo

```raku
sub Modulo(\x, \y) is export(:Modulo) {...}
```

Returns x mod y (from Ref. 1, p. 8).

References
----------

1. *Astronomy on the Personal Computer, 4th Edition*, Oliver Montenbruck and Thomas Pfleger, 2000, Springer-Verlag.

AUTHOR
======

Tom Browder (tbrowder@cpan.org)

COPYRIGHT and LICENSE
=====================

Copyright © 2021 Tom Browder

This library is free software; you may redistribute or modify it under the Artistic License 2.0.

