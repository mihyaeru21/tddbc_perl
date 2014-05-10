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
    can_ok $amazon, qw( new get_amount add_item get_stock );
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
            stock        => 5,
        }, '問題1のデータを持っていること';
};

subtest 'カートあるよ' => sub {
    my $amazon = Amazon->new();
    is defined $amazon->{cart}, 1, 'カートハッシュが定義されている';
};

subtest 'get_amount()のバリデーション' => sub {
    my $amazon = Amazon->new();
    dies_ok { $amazon->get_amount() }, '引数が無いときに例外を投げること';
};

subtest 'Amazonが扱っていない商品について' => sub {
    my $amazon = Amazon->new();
    throws_ok { $amazon->get_amount('hoge') } qr/ERROR: unstored item/, 'amazonが扱っていない商品が指定された時に例外を投げること';
    throws_ok { $amazon->add_item('hoge') } qr/ERROR: unstored item/, 'amazonが扱っていない商品をカートに入れようとすると例外を投げること';
};

subtest 'カートに商品を追加できる' => sub {
    my $amazon = Amazon->new();
    my $item_name = 'perfect_php';
    is $amazon->get_amount($item_name), 0, '最初は0になっている';
    is $amazon->get_stock($item_name), 5, '最初は在庫は5個';

    $amazon->add_item($item_name);
    is $amazon->get_amount($item_name), 1, '第二引数を省略すると1追加する扱いにする';
    is $amazon->get_stock($item_name), 4, '在庫が減る';

    $amazon->add_item($item_name, 2);
    is $amazon->get_amount($item_name), 3, 'さらに追加した分が加算されている';
    is $amazon->get_stock($item_name), 2, '在庫が減る';

    throws_ok { $amazon->add_item($item_name, 3) } qr/ERROR: no stock/, '在庫数より多くなるようにカートに追加しようとすると例外を投げること';
};

done_testing;

