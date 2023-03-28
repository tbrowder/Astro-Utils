use Test;
use Astro::Utils :ALL;
use Math::FractionalPart :frac;
use Math::Trig:auth<zef:tbrowder>:ver<0.5.1>;

plan 18;

# subs from Montenbruck, p. 8
# show they are the same as the Raku versions
my $a =  1.24;
my $b =  1.1;
my $c = -2.3;
is Frac($a), 0.24;
is Frac($b), 0.1;
is Frac($c), 0.7;
is Frac($a), frac($a);
is Frac($b), frac($b);
is Frac($c), frac($c);

is Modulo($a,$a), ($a % $a);
is Modulo($a,$b), ($a % $b);
is Modulo($a,$c), ($a % $c);

is Modulo($b,$a), ($b % $a);
is Modulo($b,$b), ($b % $b);
is Modulo($b,$c), ($b % $c);

is Modulo($c,$a), ($c % $a);
is Modulo($c,$b), ($c % $b);
is Modulo($c,$c), ($c % $c);

# ddd
{
    my ( $d, $m, $s ) = ( 250, 46, 0.0 );
    my $exp = 250.766666666667;
    my $got = ddd($d, $m, $s);
    is-approx $got, $exp, "Sexagesimal --> decimal";
}

# polynome
my $got = polynome 10, (1, 2, 3);
cmp-ok 321, '==', $got, "Simple polynome";

# more polynome tests
my @a = map { deg2rad( ddd($_) ) }, (
    [ 23, 26, 21.448 ],
    [ 0,  0,  -4680.93 ],
    [ 0,  0,  -1.55 ],
    [ 0,  0,  1999.25 ],
    [ 0,  0,  -51.38 ],
    [ 0,  0,  -249.67 ],
    [ 0,  0,  -39.05 ],
    [ 0,  0,  7.12 ],
    [ 0,  0,  27.87 ],
    [ 0,  0,  5.79 ],
    [ 0,  0,  2.45 ]
);

my $t  = -0.127296372347707;
my $x0 = polynome( $t, @a );
my $x1 = (
    (
        (
            (
                (
                    (
                        (
                            (
                                (@a[10] * $t + @a[9]) * $t + @a[8]
                            ) * $t + @a[7]
                        ) * $t + @a[6]
                    ) * $t + @a[5]
                ) * $t + @a[4]
            ) * $t + @a[3]
        ) * $t + @a[2]
    ) * $t + @a[1]
) * $t + @a[0];
is-approx $x1, $x0, 'Polynome algorithm';
