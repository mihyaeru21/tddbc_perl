package Amazon;
use strict;
use warnings;
use utf8;
use Smart::Args;

use constant SHIP_METHOD => {
    NORMAL_SHIP => 0,
    OISOGI_SHIP => 200,
};

use constant PURCHAS_METHOD => {
    CREDIT_CARD => 0,
    CACHE       => 200,
    ATM         => 100,
};

sub new {
    my $class = shift;
    bless {
        items => {
            perfect_php => {
                name         => 'Perlfect PHP',
                price        => 3600,
                release_date => '2010-11-01',
                stock        => 5,
            }
        },
        cart => {},
        ship_method     => 'NORMAL_SHIP',
        purchase_method => 'CACHE',
    }, $class;
}

sub get_stock {
    args_pos(
        my $self,
        my $item_name => { isa => 'Str', optional => 0 },
    );
    return $self->{items}->{$item_name}->{stock};
}

sub get_amount {
    args_pos(
        my $self,
        my $item_name => { isa => 'Str', optional => 0 },
    );
    _die_with_unstored_item($self, $item_name);
    return $self->{cart}->{$item_name} // 0;
}

sub add_item {
    args_pos(
        my $self,
        my $item_name => { isa => 'Str', optional => 0 },
        my $amount => { isa => 'Str', optional => 1, default => 1 },
    );

    die 'ERROR: no stock'
        if $self->get_amount($item_name) + $amount > $self->{items}->{$item_name}->{stock};

    $self->{cart}->{$item_name} += $amount;
    $self->{items}->{$item_name}->{stock} -= $amount;
}

sub _die_with_unstored_item {
    my ($self, $item_name) = @_;
    die 'ERROR: unstored item' unless defined $self->{items}->{$item_name};
}

sub get_purchase_method{
    my $self = shift;

    return {
        SHIP_METHOD    => $self->{ship_method},
        PURCHAS_METHOD => $self->{purchase_method},
    };
}

sub set_purchase_method {
    my( $self, $methods ) = @_;
    $self->{ship_method} = $methods->{ship};
    $self->{purchase_method} = $methods->{purchase};
}

sub get_commission {
    my ($self) = @_;
    my $ship = $self->{ship_method};
    my $purchase = $self->{purchase_method};
    return SHIP_METHOD->{$ship} + PURCHAS_METHOD->{$purchase};
}

1;
