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
        cart => {
        },
    }, $class;
}

sub get_amount {
    my ($self, $item_name) = @_;
    return $self->{cart}->{$item_name} // 0;
}

sub add_item {
    my ($self, $item_name, $amount) = @_;
    $self->{cart}->{$item_name} += $amount;
}


1;

