+++
title = "軸"
hascode = false

tags = ["axis", "basemap", "plot"]
+++

軸に関しては，[frame](https://www.generic-mapping-tools.org/GMTjl_doc/documentation/common_opts/common_opts/index.html/) あたりが参考となる．

\toc

# 線形と両対数

最も基本的な線形のグラフと両対数のグラフの軸を描く．

```julia:./ts_linear.jl
using GMT

# linear
flout = joinpath(@OUTPUT, "ts_linear")
gmtbegin(flout, fmt="png")
basemap(
    region=(0, 10, 0, 10),     # 図の範囲
    figscale=(0.5, 0.4),       # 座標値１あたりの長さ(cm 単位)
    proj=:linear,              # 線形
    frame=(axes=:WSne),        # 軸を上(n)下(s)左(w)右(e)に描き，
                               # 文字情報は左(W)と下(S)に
    xaxis=(annot=2, ticks=1),  # x軸の文字を 2 毎，tick markを１毎に
    yaxis=(annot=5, ticks=1),  # x軸の文字を 5 毎，tick markを１毎に
    xlabel="x", ylabel="y"     # x軸に "x"，y軸に ”y" を
    )
gmtend()

# log-log
flout = joinpath(@OUTPUT, "ts_loglog")
gmtbegin(flout, fmt="png")
basemap(
    region=(0.1, 100, 0.01, 100),      # 図の範囲
    figscale=(2, 1.5),                 # 座標値１(1桁）あたりの長さ(cm 単位)
    proj=:logxy,                       # log-log にする
    frame=(axes=:WSne),
    xaxis=(annot=2, ticks=3, grid=2,   # 文字1,2,5，tick mark 1毎，
                                       # grid を1,2,5
           label="frequency/Hz"),      # 軸のラベル
    yaxis=(annot=1, ticks=1, grid = 3, # 文字を1桁毎，tick mark 1毎，
                                       # grid を1毎
           scale=:pow,                 # 文字を指数表示にする．
           label="amplitude/m")               
    )
gmtend()
```

* 線形のグラフ
\fig{./output/ts_linear}

* 両対数のグラフ
\fig{./output/ts_loglog}

# 横軸にπを入れる

sin のグラフのとき，横軸に π を入れたくなる．

```julia:./sin_theta.jl
x = range(0.0, 4pi, length=401)  # 0 から ４π を 401 個 に刻む．
y = sin.(x)
flout = joinpath(@OUTPUT, "sin_theta")
gmtbegin(flout, fmt="png")
basemap(region=(0.0, 4pi, -1.1, 1.1), figsize=(8,4),
            axes=:WSne, 
            xaxis=(custom=(pos=[0, pi/2, pi, 3pi/2,  2pi, 5pi/2, 3pi, 7pi/2, 4pi],
            type=["ag", "fg", "fag @~p@~", "fg", "fag 2@~p@~", "fg", "afg 3@~p@~", "fg", "afg 4@~p@~"]),),
            xlabel="@~q@~ [rad]",
            yaxis=(annot=0.5, ticks=0.1, grid=0.5),
            ) 
plot(x, y, pen=(0.5, :blue))
gmtend()
```

* $\sin\theta$ のグラフ
\fig{./output/sin_theta}

$\pi$ や 上付き・下付きなどの表示の仕方は，GMTマニュアルの [text](https://docs.generic-mapping-tools.org/latest/text.html) にある．
