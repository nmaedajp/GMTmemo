# This file was generated, do not modify it. # hide
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