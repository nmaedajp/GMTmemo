# This file was generated, do not modify it. # hide
using Dates
using GMT

nw = now()

# -1時間，+49時間
x1h = nw - Hour(1); x2h = nw + Hour(49)
flout = joinpath(@OUTPUT, "d_axis_h")
gmtbegin(flout, fmt="png")
basemap(region=(x1h, x2h, 0, 1), J="X9c/3c", 
        B="afg WSne", 
        ylabel="y")
gmtend()

# -1日，+60日
x1d = nw - Day(1); x2d = nw + Day(60)
flout = joinpath(@OUTPUT, "d_axis_d")
gmtbegin(flout, fmt="png")
basemap(region=(x1d, x2d, 0, 1), J="X9c/3c", 
        B="afg WSne", 
        ylabel="y")
gmtend()

# -1月，+36月
x1m = nw - Month(1); x2m = nw + Month(36)
flout = joinpath(@OUTPUT, "d_axis_m")
gmtbegin(flout, fmt="png")
basemap(region=(x1m, x2m, 0, 1), J="X9c/3c", 
        B="afg WSne", 
        ylabel="y")
gmtend()