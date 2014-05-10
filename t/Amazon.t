#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;
binmode STDOUT, ":utf8";

subtest 'クラスの基本的な要素' => sub {
    use_ok 'Amazon';
    my $amazon = Amazon->new();
    isa_ok $amazon, 'Amazon';
    can_ok $amazon, qw( new );
};

subtest 'アイテムあるよ' => sub {
    my $amazon = Amazon->new();
    is defined $amazon->{items}, 1, '商品ハッシュが定義されている';
    # TODO: valuesまでテストするの微妙かもしれない。構造のみテストしたい
    is_deeply $amazon->{items}->{perfect_php},
        {
            name         => 'Perlfect PHP',
            price        => 3600,
            release_date => '2010-11-01',
            stock        => 2,
        }, '問題1のデータを持っていること';
};

subtest 'カートあるよ' => sub {
    my $amazon = Amazon->new();
    is defined $amazon->{cart}, 1, 'カートハッシュが定義されている';
};

done_testing;

