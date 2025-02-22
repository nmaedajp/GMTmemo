+++
title = "グリッドデータ"
hascode = false

tags = ["griddata", "basemap", "grdimage", "grdcontour", "xyz2grd", "colorbar"]
+++

# グリッドデータ

\toc

## 関数からグリッドデータへ

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

## `xyz2grd` の `Z` オプション

`xyz2grd` の `Z` オプションは，配列のデータの並び順を指定している． 

|オプションと順序|オプションと順序|
|:----:|:----:|
|Z="TL"![Z="TL"](/assets/grd/ztl.gif)|Z="TR"![Z="TR"](/assets/grd/ztr.gif)|
|Z="BL"![Z="BL"](/assets/grd/zbl.gif)|Z="BR"![Z="BR"](/assets/grd/zbr.gif)|
|Z="LT"![Z="LT"](/assets/grd/zlt.gif)|Z="LB"![Z="LB"](/assets/grd/zlb.gif)|
|Z="RT"![Z="RT"](/assets/grd/zrt.gif)|Z="RB"![Z="RB"](/assets/grd/zrb.gif)|

## mat2grid

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
