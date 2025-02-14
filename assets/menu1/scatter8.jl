# This file was generated, do not modify it. # hide
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