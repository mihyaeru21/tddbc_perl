package Amazon;
use strict;
use warnings;
use utf8;

sub new {
    my $class = shift;
    bless {
        items => {
            perfect_php => {
                name         => 'Perlfect PHP',
                price        => 3600,
                release_date => '2010-11-01',
                stock        => 2,
            }
        },
    }, $class;
}

1;

