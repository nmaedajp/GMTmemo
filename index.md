@def title = "GMT.jl memo"
@def tags = ["GMT", "julia", "code"]

# GMT memo

Generic Mapping Tools は，地図を作成する際に有用なツールである．
また，ふつうのグラフも作成することができる．
Windowsにインストールして，作業していた時期に [Web ページ](http://home.kanto-gakuin.ac.jp/~nmaeda/gmtpk/)を作成したが，
* バージョンが 6.x.x になって以降，随分雰囲気が変わったこと
* Windows から Mac に乗り換えたこと
* メインの言語を Fortran から julia に変更したこと
など，メモ代わりとして作ったページに自分でもあまりアクセスしなくなってしまった．

juliaには，GMT.jlというパッケージが用意されている．
このパッケージでは，juliaで処理した結果をすでにインストールされているGMTに渡す
という作業を行って，図を作成する．このような処理をおこなうものをラッパーというらしい．

julia に切り替えてからいろいろグラフを作成してきたが，
過去に作成したスクリプトがどこにあるのかが，わかりにくくなってきたので，
ここにメモとして，残していきたい．

なお，このページを作成する際には，静的なサイトジェネレーターである `Franklin.jl` を利用している．

2025年2月11日現在，`GMT6.5.0`，`julia1.11.3` を使用している．

\tableofcontents <!-- you can use \toc as well -->

## GMT のインストール
インストールについては，[GMTのダウンロードのページ](https://www.generic-mapping-tools.org/download/)から，github のページに跳び，
使用している OS に対応したインストーラーをダウンロードして，インストールする．

## julia のインストール

juliaの[ダウンロードページ](https://julialang.org/downloads/)から
使用している OS に対応したインストーラーをダウンロードして，インストールする．

## GMT.jl パッケージのインストール
`julia` のパッケージモードで，

```
(@v1.11) pkg> add GMT
```
とすれば，`GMT.jl` のインストールができる．

## その他

* 開発環境として，VSCodeを使用している．
* VSCode 上で，Jupyter notebook を使用しているので，以下をインストールしている．
  * julia の IJulia パッケージ
  * 拡張機能 jupyter 

## リンク
* Genric Mapping Tools [https://www.generic-mapping-tools.org](https://www.generic-mapping-tools.org)
* GMT.jl [https://www.generic-mapping-tools.org/GMTjl_doc/](https://www.generic-mapping-tools.org/GMTjl_doc/)