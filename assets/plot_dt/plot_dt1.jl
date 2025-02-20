# This file was generated, do not modify it. # hide
using GMT
using Dates
using DelimitedFiles
using Random

nw = now()
ndata = 24
x = Array{DateTime}(undef, ndata);
for i=1:ndata
    x[i] = nw + Hour(i-1)
end
Random.seed!(20250220)
y = rand(ndata)
x1 = x[1] - Hour(1)
x2 = x[end] + Hour(1)

flnm = joinpath(@OUTPUT, "ts_date_data.txt")
open(flnm, "w") do io
    writedlm(io, [x y])
end
flout = joinpath(@OUTPUT, "plot_dt1")
gmtbegin(flout, fmt="png")
   basemap(region=(x1, x2, -0.05, 1.05), B="afg", figsize=(8, 5))
   scatter(flnm, S="c0.15", G="red", ml=(0.1,:black))
gmtend()