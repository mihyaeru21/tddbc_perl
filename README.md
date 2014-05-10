# Perl限定TDDBC

* 言葉の対応表を作成する
* Amazonクラスに商品データを持たせる
* Amazonクラスにカートデータを持たせる
* カート内の商品の数を取得する処理を実装
* カートに商品を追加するメソッドを実装
* カートに入れるときに在庫より多く入れられない例外処理

以下、メモ

```
add_item_to_cart(item, amount)
カート内の特定商品の数(商品名 ) => カート内の数

商品はAmazon氏のインスタンス変数で表現する
Amazon->{items}
=>
{
      name: '',
}

カートもハッシュ
{
      商品を特定できる何か => 個数,
          商品を特定できる何か => 個数,
}

カートに入れるときに在庫より多く入れられない

pkは商品の英語名


対応表
商品   item
カート cart
価格   price
商品名 item_name
発売日 release_date
在庫   stock_amount
購入数 procure_amount
```
