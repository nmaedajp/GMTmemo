+++
title = "グリッドデータ"
hascode = false

tags = ["griddata", "basemap", "grdimage", "grdcontour", "xyz2grd", "colorbar"]
+++

\toc

# 関数からグリッドデータへ

$f(x, y)$ のような2次元の関数からグリッドデータを作る．

* vset(f, x1, x2, dx, y1, y2, dy)
  * 関数 f から範囲(x1, x2, y1, y2)のグリッドデータを作る．
  * 刻み幅は，dx，dy．

* 関数として，$f(x,y) = -0.5x^2 + y^2 + 12.5$ を定義
* グリッドデータを作って，色別の段彩図，等値線を作成する．

```julia:./kansu.jl
using GMT
#
# 関数f から 範囲(x1, x2, y1, y2)のグリッドデータを
# 刻み幅 dx，dyで作成する．
function vset(f, x1, x2, dx, y1, y2, dy)
    nx = round(Int64, (x2 - x1)/dx) + 1
    ny = round(Int64, (y2 - y1)/dy) + 1
    zz = Array{Float64}(undef, nx*ny);
    for ix = 1:nx
        x = (ix - 1) * dx + x1
        for iy = 1:ny
            y = (iy - 1) * dy + y1
            ind = (ix-1)*nx + iy
            zz[ind] = f(x, y)
        end
    end
    G = xyz2grd(zz, region=(x1, x2, y1, y2), Z="LB", I="$dx/$dy")
    return G
end
#
# ここで使う関数．
function kansu(x, y)
    z = −0.5*x^2 + y^2 +12.5
    return z
end

# データの範囲と刻み幅
x1 = -5.0; x2 = 5.0; dx = 0.2 
y1 = -5.0; y2 = 5.0; dy = 0.2

# グリッドデータを作成する
Gz = vset(kansu, x1, x2, dx, y1, y2, dy)

# 段彩図，等値線の作成
flout = joinpath(@OUTPUT, "kansu")
gmtbegin(flout, fmt="png")
    basemap(B="afg WSne", region=(x1, x2, y1, y2), J="X8c/8c", 
        xlabel="x", ylabel="y")
    grdimage(Gz, color=:rainbow)
    grdcontour(Gz, cont=2, annot=(int=4, labels=(font=8,)), labels=(dist=4,))
    colorbar(frame=(annot=:auto,))
gmtend()

# 段彩図，等値線の作成：解像度を 300 dpi に設定
flout = joinpath(@OUTPUT, "kansu300")
gmtbegin(flout, fmt="png")
    basemap(B="afg WSne", region=(x1, x2, y1, y2), J="X8c/8c", 
        xlabel="x", ylabel="y")
    grdimage(Gz, color=:rainbow, dpi=300)  # 解像度を 300dpi に設定する
    grdcontour(Gz, cont=2, annot=(int=4, labels=(font=8,)), labels=(dist=4,))
    colorbar(frame=(annot=:auto,))
gmtend()

```
\fig{./output/kansu}

ここの図をみると，グリッドの刻みである 0.2 ごとのメッシュになっているのが見える．

\fig{./output/kansu300}

解像度を 300 dpi に設定すると，なめらかに補間されるようである．

# `xyz2grd` の `Z` オプション

`xyz2grd` の `Z` オプションは，配列のデータの並び順を指定している． 

|オプションと順序|オプションと順序|
|:----:|:----:|
|Z="TL"![Z="TL"](/assets/grd/ztl.gif)|Z="TR"![Z="TR"](/assets/grd/ztr.gif)|
|Z="BL"![Z="BL"](/assets/grd/zbl.gif)|Z="BR"![Z="BR"](/assets/grd/zbr.gif)|
|Z="LT"![Z="LT"](/assets/grd/zlt.gif)|Z="LB"![Z="LB"](/assets/grd/zlb.gif)|
|Z="RT"![Z="RT"](/assets/grd/zrt.gif)|Z="RB"![Z="RB"](/assets/grd/zrb.gif)|

# mat2grid

* わざわざ`vset`という関数を作らなくても，`mat2grid` という関数があった．
* 説明は，[mat2grid](https://www.generic-mapping-tools.org/GMTjl_doc/documentation/utilities/mat2grid/index.html) にある．

```julia:./kansugrd.jl
using GMT
#
# ここで使う関数．
function kansu(x, y)
    z = −0.5*x^2 + y^2 +12.5
    return z
end

# データの範囲と刻み幅
x1 = -5.0; x2 = 5.0; dx = 0.2 
y1 = -5.0; y2 = 5.0; dy = 0.2

# グリッドデータを作成する
Gz = mat2grid(kansu, x = x1:dx:x2, y = y1:dy:y2)

# 段彩図，等値線の作成
flout = joinpath(@OUTPUT, "kansugrd")
gmtbegin(flout, fmt="png")
    basemap(B="afg WSne", region=(x1, x2, y1, y2), J="X8c/8c", 
        xlabel="x", ylabel="y")
    grdimage(Gz, color=:rainbow)
    grdcontour(Gz, cont=2, annot=(int=4, labels=(font=8,)), labels=(dist=4,))
    colorbar(frame=(annot=:auto,))
gmtend()
```

\fig{./output/kansugrd}

# gridline node と pixel node
@@date
20250301
@@
`mat2grid` は名前の通り，配列から grd 形式を作成する関数である．
配列を grd 形式に変換するとき，glidline node registration と
pixel node registration という指定の仕方がある．
イメージとしては，

![glidline と pixel](/assets/grd/grid_node.jpg) 

に示したように，grid 線の交点の値とするか，
grid の真ん中の値をするか，の違いである．

## テストコード

```julia:./nodepixel.jl
#
# gridline node registration と pixel node registration のテスト
#
# データの作成
# pixel の値
x44 = reshape([Float64(i) for i=1:16], 4, 4) 
# gridline 上の値
# pixel で与えた値を元にして与えている
x55 = reshape([-1.5+div(i-1,5)*4+mod(i-1,5) for i=1:25], 5, 5)

# 配列の表示 
println("x44")
for i = 1:4
    for j = 1:4
        print("$(x44[i, j]) ")
    end
    print("\n")
end
    print("\n")
println("x55")
for i = 1:5
    for j = 1:5
        print("$(x55[i, j]) ")
    end
    print("\n")
end
#
using GMT
# grd の作成
x1 = -2.0; x2 = 2.0 # x の下限と上限
y1 = -2.0; y2 = 2.0 # y の下限と上限
# reg = 1 が pixel registration
Grd44 = mat2grid(x44, x = [x1 x2], y = [y1 y2], reg=1)
# default は gridline registration
Grd55 = mat2grid(x55, x = [x1 x2], y = [y1 y2])

# 図を描く
C = makecpt(cmap=:rainbow, range=(-2, 20)) # カラーパレットの作成
# 
flout = joinpath(@OUTPUT, "pixel")
gmtbegin(flout, fmt="png")
    grdimage(Grd44, B="afg WSne", J="X6c/6c", 
            R="-3/3/-3/3",  # 範囲を広めにとっている 
            color=C, title="pixel")
    colorbar(frame=(annot=:auto,))
gmtend()
flout = joinpath(@OUTPUT, "pixel100")
gmtbegin(flout, fmt="png")
    grdimage(Grd44, B="afg WSne", J="X6c/6c", 
            R="-3/3/-3/3",  # 範囲を広めにとっている 
            dpi=100,        # 解像度を100 dpiに 
            color=C, title="pixel 100")
    colorbar(frame=(annot=:auto,))
gmtend()
flout = joinpath(@OUTPUT, "node")
gmtbegin(flout, fmt="png")
    grdimage(Grd55, B="afg WSne", J="X6c/6c", 
            R="-3/3/-3/3",  # 範囲を広めにとっている 
            color=C, title="gridline")
    colorbar(frame=(annot=:auto,))
gmtend()
flout = joinpath(@OUTPUT, "node100")
gmtbegin(flout, fmt="png")
    grdimage(Grd55, B="afg WSne", J="X6c/6c", 
            R="-3/3/-3/3",  # 範囲を広めにとっている 
            dpi=100,        # 解像度を100 dpiに 
            color=C, title="gridline 100")
    colorbar(frame=(annot=:auto,))
gmtend()
```
## x44 と x55 の値
  * x44 は単純に 1〜16 を並べただけ
  * x55 は x44 をみて作成している．
\output{./nodepixel}

## 配列とグリッドへの割当
下の図は，pixel node registration

\fig{./output/pixel}

これをみると
* 値は左下から上へ増えていき，右に移って再び下から上に増えていく
* 配列のメモリ上での順序に従って，上に示した `Z=”LB"` の感じでグリッドにあてはめられている．

## gridline node registration
下の図は，gridline node registration

\fig{./output/node}

* 割当の順序は，pixel node registration と同じで，メモリ上の順序で `Z=”LB"` の感じ
* x，y の 指定した範囲を半グリッド分はみ出している．
* GMT の `grdimage` でも，このようになるかどうかは，未確認．

## dpi オプション
`grdimage` のオプションで，`dpi=100` をつけると解像度が上がる．
そして，補間した値に基づいて，図を作成してくれる．

どちらも，`dpi=100` を指定して図を作成した．

\fig{./output/pixel100}

　　

\fig{./output/node100}

* `dpi=100` のオプションを付けると，どちらも，指定した x，yの範囲に収まっている．
* 補間は，grid の範囲についてのみ行われている．

なお，関数については，pixel node registration の指定をすると，
グリッドの数が合わないといわれて，エラーとなった．
