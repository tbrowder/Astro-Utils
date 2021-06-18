unit module Astro::Utils:ver<0.0.1>:auth<cpan:TBROWDER>;

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


