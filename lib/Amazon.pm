package Amazon;
use strict;
use warnings;
use utf8;

sub new {
    my $class = shift;
    bless {
        items => {},
    }, $class;
}

1;

