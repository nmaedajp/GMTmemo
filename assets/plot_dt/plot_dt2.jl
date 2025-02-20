# This file was generated, do not modify it. # hide
using GMT
using Dates
using Random

nw = now()
ndata = 24
x1 = x[1] - Hour(1)
x2 = x[end] + Hour(1)

x = Array{DateTime}(undef, ndata)
for i in 1:ndata
    x[i] = nw + Hour(i)
end
Random.seed!(20250220)
y = rand(ndata);

flout = joinpath(@OUTPUT, "plot_dt2")

gmtbegin(flout, fmt="png")
    basemap(region=(x1, x2, -0.05, 1.05), J="X8c/5c", B="afg WSne")  # DateTime型の軸を描く
    scatter(Dates.value.(x), y, S="c0.15", G="red", ml=(0.1,:black),  # DateTime型を数値に
            region=(Dates.value(x1), Dates.value(x2), -0.05, 1.05))   # DateTime型を数値に変換して，再スケーリング
gmtend()