# This file was generated, do not modify it. # hide
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