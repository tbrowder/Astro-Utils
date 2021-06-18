use Test;
use Astro::Utils :ALL;

plan 4;

my $x =  4.234;
my $y = -9.5678;

my $X = Frac $x;
my $Y = Frac $y;
my $a = Modulo $x, $y;
my $b = Modulo $y, $x;

is $X, 0.234;
is $Y, 0.4322;
is-approx $a, -5.3338;
is-approx $b, 3.1342;


