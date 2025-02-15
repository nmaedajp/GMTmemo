# This file was generated, do not modify it. # hide
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