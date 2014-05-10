package Amazon;
use strict;
use warnings;
use utf8;
use Smart::Args;

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
    args_pos(
        my $self,
        my $item_name => { isa => 'Str', optional => 0 },
        my $amount => { isa => 'Str', optional => 1, default => 1 },
    );

    $self->{cart}->{$item_name} += $amount;
}


1;

