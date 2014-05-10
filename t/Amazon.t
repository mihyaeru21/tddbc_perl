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
    can_ok $amazon, qw( new get_amount add_item );
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

subtest 'カートに商品を追加できる' => sub {
    my $amazon = Amazon->new();
    my $item_name = 'perfect_php';
    is $amazon->get_amount($item_name), 0, '最初は0になっている';

    $amazon->add_item($item_name, 1);
    is $amazon->get_amount($item_name), 1, '追加した分が加算されている';

    $amazon->add_item($item_name, 2);
    is $amazon->get_amount($item_name), 3, 'さらに追加した分が加算されている';

    $amazon->add_item($item_name);
    is $amazon->get_amount($item_name), 4, '第二引数を省略すると1追加する扱いにする';
};

#subtest 'カート内の特定商品の個数を確認できる' => sub {
#    my $amazon = Amazon->new();
#    is $amazon->get_amount('perfect_php'),
#};

done_testing;

