#! /usr/bin/perl

# See:
# https://rt.cpan.org/Public/Bug/Display.html?id=92501
#

use strict;
use warnings;

use Test::More tests => 2;

use List::Util qw(pairmap);

my @x = (
  'a' => [
    '1',
    [
      'b' => [ '2', '3', '4' ],
      'c' => [ '5', '6', '7', '8', '9', '10', '11', '12' ],
      'd' => [ '13', '14', '15', '16', '17', '18',
               '19', '20', '21', '22', '23',
               '24', '25', '26', '27', '28', '29',
               '30', '31', '32' ],
    ]
  ],
);

sub _extract {
  map { ref $_ ? pairmap(\&_extract, @$_) : $_ } @$b;
}

# TEST
is_deeply(
    [ pairmap(\&_extract, @x) ],
    [ 1 .. 32 ],
    q#recursive pairmap with map and $_ returns correct results.#,
);

# TEST
pass("Test finished and did not segfault or got corrupted memory.");
