+++
title = "散布図"
hascode = false
# date = Date(2019, 3, 22)
# rss = "A short description of the page which would serve as **blurb** in a `RSS` feed; you can use basic markdown here but the whole description string must be a single line (not a multiline string). Like this one for instance. Keep in mind that styling is minimal in RSS so for instance don't expect maths or fancy styling to work; images should be ok though: ![](https://upload.wikimedia.org/wikipedia/en/3/32/Rick_and_Morty_opening_credits.jpeg)"

tags = ["scatter", "code"]
+++

\toc

# とりあえず実行

```julia:./scatter1.jl
using Random
using GMT
Random.seed!(20250211) # 乱数の種を日付にしている
n = 100
x = randn(n)
y = randn(n)

flfig = joinpath(@OUTPUT, "scatter1")
scatter(x, y, savefig=flfig)
```
\fig{./output/scatter1}

この図では，ほぼオプションを指定していない．

なお，ここで使用している `@OUTPUT` は `Franklin.jl` で設定している出力フォルダを表しているので，
通常のスクリプトには，不要である．

# 軸の設定

前の例では，図のファイルを `savefig` というオプションで指定しているが，
個人的な好みで，`gmtbegin` と `gmtend` を使用し，保存するファイル名を
`gmtbegin`の中で設定している．

ここでは，`basemap` により軸を設定し，そのスケーリングの中で，散布図を作成する．

```julia:./scatter2.jl
using Random
using GMT
Random.seed!(20250211) # 乱数の種を日付にしている
n = 100
x = randn(n)
y = randn(n)

flfig = joinpath(@OUTPUT, "scatter2")
gmtbegin(flfig, fmt="png")
    basemap(region=(-3.5, 3.5, -3.5, 3.5), 
        figscale=(1.0, 1.0), 
        proj=:linear, 
        frame=(axes=:WSne), 
        xaxis=(annot=:auto, ticks=:auto, grid=:auto), 
        yaxis=(annot=:auto, ticks=:auto, grid=:auto), 
        xlabel="x", ylabel="y")
    scatter(x, y)
gmtend()
```
\fig{./output/scatter2}

図の大きさを指定したいときは，`figscale` の代わりに `figsize=(7.0, 7.0)` と指定すれば良い．


ここでは，`GMT.jl` 風のオプションで書いているが，`GMT` のオプション形式も使うことができる．

```julia:./scatter3.jl
using Random
using GMT
Random.seed!(20250211) # 乱数の種を日付にしている
n = 100
x = randn(n)
y = randn(n)

flfig = joinpath(@OUTPUT, "scatter3")
gmtbegin(flfig, fmt="png")
    basemap(R="-3.5/3.5/-3.5/3.5", 
        J="x1c/1c", 
        B="afg WSne",
        xlabel="x", ylabel="y"
        )
    scatter(x, y)
gmtend()
```
\fig{./output/scatter3}

ただし，`xlabel="x", ylabel="y"` の部分は今風である．
まだ，慣れていないが，今風のオプションのほうが意味を想像しやすくなっている．

# symbol
上の例では，symbolの種類，大きさ，ペンの太さ，色等を指定していない．
symobolの種類の例は，[Basic geometric symbols](https://www.generic-mapping-tools.org/GMTjl_doc/examples/plotting_functions/040_scatter/index.html) や [Symbols](https://www.generic-mapping-tools.org/GMTjl_doc/documentation/common_features/symbols/index.html)
に記載がある．

また，scatterのオプションを指定した例としては，[Scatters](https://www.generic-mapping-tools.org/GMTjl_doc/examples/plotting_functions/040_scatter/index.html) をみると，意味がわかりやすい．

## 星印：単色
```julia:./scatter4.jl
using GMT
using Random
n=100
Random.seed!(20250214)
x = randn(n)
y = randn(n)
size  =rand(n)*0.5 
flfig = joinpath(@OUTPUT, "scatter4")
gmtbegin(flfig, fmt="png")
basemap(region=(-3.5, 3.5, -3.5, 3.5), 
    figscale=(1.0, 1.0), 
    proj=:linear, 
    frame=(axes=:WSne), 
    xaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    yaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    xlabel="x", ylabel="y")
scatter(x, y, 
   marker=:*,               # マーカーの形状を星印に
   markerline =(0.3, :red), # markerline を赤色で太さ0.3pに
   markersize=size,         # markersize でマーカーサイズを指定
   color=:magenta,          # color でマーカーの色を指定
   alpha=50                 # alpha で透明度を指定
)
gmtend()
```
\fig{./output/scatter4}

## 星印：カラーパレット

値により，色を塗り分けることができる．
上の例では，`color=:magenta`のように色名で指定しているので，同じ色になっているが，
カラーパレット名を指定し，`zcolor`を指定すると，値に応じた色の塗り分けができる.

```julia:./scatter5.jl
using GMT
using Random
n=100
Random.seed!(20250214)
x = randn(n)
y = randn(n)
size  = rand(n)*0.5
zcolor = rand(n)

flfig = joinpath(@OUTPUT, "scatter5")
gmtbegin(flfig, fmt="png")
basemap(region=(-3.5, 3.5, -3.5, 3.5), 
    figscale=(1.0, 1.0), 
    proj=:linear, 
    frame=(axes=:WSne), 
    xaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    yaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    xlabel="x", ylabel="y")
scatter(x, y, 
   marker=:*,               # マーカーの形状を星印に
   markerline =(0.3, :red), # markerline を赤色で太さ0.3pに
   markersize=size,         # markersize でマーカーサイズを指定
   color=:rainbow,          # color でカラーパレットを指定
   zcolor=zcolor,            # 塗り分けるための値を指定
   alpha=50                 # alpha で透明度を指定
)
gmtend()
```
\fig{./output/scatter5}

* 大きさが変わっているのがなぜかわからず

## 長方形
長方形についても書くことはできるが，向きや大きさを描くためには，
GMTのオプションである必要があるようだ．

```julia:./scatter6.jl
using GMT
using Random
n=100
Random.seed!(20250214)
x = randn(n)
y = randn(n)
azimuth = 360.0*rand(n)
size  =rand(n)*0.5 .+ 0.15
size2 =size./2.0
color = rand(n)
C = makecpt(C="rainbow", T=(0,1,0.1), continuous=true)
 
xy=hcat(x, y, color, azimuth, size, size2) 

flfig = joinpath(@OUTPUT, "scatter6")
gmtbegin(flfig, fmt="png")
basemap(region=(-3.5, 3.5, -3.5, 3.5), 
    figscale=(1.0, 1.0), 
    proj=:linear, 
    frame=(axes=:WSne), 
    xaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    yaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    xlabel="x", ylabel="y")
scatter(xy, 
   S="J",                   # マーカーの形状を長方形に．GMTのオプション
   markerline =(0.3, :red), # markerline を赤色で太さ0.3pに
   color=C,                 # color でマーカーの色を指定．データの3列目．
   alpha=25                 # alpha で透明度を指定
)
colorbar()
gmtend()
```
\fig{./output/scatter6}

なかなか難敵．
GMTのオプションじゃないと動かないケースがある．
もともと，"J"のシンボルは `GMT.jl` のマニュアルにないので，渡し方を試さないといけない．

## 星印：GMTオプションで

* 星印をGMTオプションで描いてみる．
* 色は3番めの列（zのイメージ），大きさは4番めの列となる．
* カラーパレットを使う．

```julia:./scatter7.jl
using GMT
using Random
n=100
Random.seed!(20250214)
x = randn(n)
y = randn(n)
size  = rand(n)*0.5
z = rand(n)

C = makecpt(C="rainbow", T=(0,1,0.1), continuous=true)
xyzs = hcat(x, y, z, size)
flfig = joinpath(@OUTPUT, "scatter7")
gmtbegin(flfig, fmt="png")
basemap(region=(-3.5, 3.5, -3.5, 3.5), 
    figscale=(1.0, 1.0), 
    proj=:linear, 
    frame=(axes=:WSne), 
    xaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    yaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    xlabel="x", ylabel="y")
scatter(xyzs, 
   S="a",               # マーカーの形状を星印に
   markerline =(0.3, :red), # markerline を赤色で太さ0.3pに
#    markersize=size,       # データの中で定義しているので，不要
   color=C,          # color でカラーパレットを指定
#    zcolor=zcolor,         # データの中で定義しているので，不要
   alpha=50                 # alpha で透明度を指定
)
gmtend()
```
\fig{./output/scatter7}

* 単色で

```julia:./scatter8.jl
using GMT
using Random
n=100
Random.seed!(20250214)
x = randn(n)
y = randn(n)
size  = rand(n)*0.5
z = rand(n)

xyzs = hcat(x, y, z, size)
flfig = joinpath(@OUTPUT, "scatter8")
gmtbegin(flfig, fmt="png")
basemap(region=(-3.5, 3.5, -3.5, 3.5), 
    figscale=(1.0, 1.0), 
    proj=:linear, 
    frame=(axes=:WSne), 
    xaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    yaxis=(annot=:auto, ticks=:auto, grid=:auto), 
    xlabel="x", ylabel="y")
scatter(xyzs, 
   S="a",               # マーカーの形状を星印に
   markerline =(0.3, :red), # markerline を赤色で太さ0.3pに
#    markersize=size,       # データの中で定義しているので，不要
   color=:magenta,          # color でカラーパレットを指定
#    zcolor=zcolor,         # データの中で定義しているので，不要
   alpha=50                 # alpha で透明度を指定
)
gmtend()
```
\fig{./output/scatter8}

* 単色の場合でも，3番めの値が必要になる．使ってはいないが．
* 大きさがどちらも同じ．
* 単色 with GMT.jl 風オプションでは，座標上の大きさになっているのだろうか．

# gmtbegin と gmtend

個人的な好みで，`gmtbegin` と `gmtend` を使っているとした．
GMT Ver.6になって登場した機能で，modern mode と称している．
`GMT.jl` でも，`gmtbegin` と `gmtend` が使えたので，そのまま使っているが，
[GMTmodule](https://www.generic-mapping-tools.org/GMTjl_doc/documentation/modules/)
には，リストアップされていない，ということにこのページの作成時点で気がついた．
documentation で検索するといくつか [使用例](https://www.generic-mapping-tools.org/GMTjl_doc/search/index.html?q=gmtbegin) がでてくるのみである．

```julia:method_begin.jl
using GMT 
methods(gmtbegin)
methods(gmtend)
```
で内容を確認すると，

**gmtbegin**
~~~
<pre>
# 2 methods for generic function "gmtbegin" from GMT:
 [1] gmtbegin(name::String; fmt, verbose)
     @ ~/.julia/packages/GMT/XAbNJ/src/gmtbegin.jl:12
 [2] gmtbegin(; ...)
     @ ~/.julia/packages/GMT/XAbNJ/src/gmtbegin.jl:12
</pre>
~~~

**gmtend**
~~~
<pre>
# 2 methods for generic function "gmtend" from GMT:
 [1] gmtend(; ...)
     @ ~/.julia/packages/GMT/XAbNJ/src/gmtbegin.jl:30
 [2] gmtend(arg; show, verbose, reset)
     @ ~/.julia/packages/GMT/XAbNJ/src/gmtbegin.jl:30
</pre>
~~~
使い方としては，
gmtbegin("ファイル名", fmt="png")
というふうに，出力するファイル名とファイルの種類を指定する．
GMTの[マニュアル](https://docs.generic-mapping-tools.org/latest/begin.html)に示されたサポートしているフォーマットは，以下の表の通り

|Format|Explanation|
|:----:|:----|
|bmp|Microsoft Bit Map|
|eps|Encapsulated PostScript|
|jpg|Joint Photographic Experts Group Format|
|pdf|Portable Document Format [Default]|
|png|Portable Network Graphics|
|PNG|Portable Network Graphics (with transparency layer)|
|ppm|Portable Pixel Map|
|ps|Plain PostScript|
|tif|Tagged Image Format File|
|view|Use format set by GMT_GRAPHICS_FORMAT|

GMT.jl ですべてを確認しているわけではない．
よく使うのは，**png** と **pdf** である．