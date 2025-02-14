# This file was generated, do not modify it. # hide
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