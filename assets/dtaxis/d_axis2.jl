# This file was generated, do not modify it. # hide
using Dates
using GMT

nw = now()

# -1時間，+49時間
x1h = nw - Hour(1); x2h = nw + Hour(49)
flout = joinpath(@OUTPUT, "d_axis_h2")
gmtbegin(flout, fmt="png")
basemap(region=(x1h, x2h, 0, 1), J="X9c/3c", 
        xaxis=(annot=6, annot_unit=:hour, ticks=3, ticks_unit=:hour, 
               grid=:auto),
        xaxis2=(annot=1, annot_unit=:date, ticks=1, ticks_unit=:date),
        yaxis=(annot=:auto, ticks=:auto, grid=:auto),
        ylabel="y",
        par=(FORMAT_TIME_SECONDARY_MAP="abbreviated", 
             FORMAT_DATE_MAP="\"o dd\"", FORMAT_CLOCK_MAP="hh", 
             FONT_ANNOT_PRIMARY=9)
        )
gmtend()

# -1日，+60日
x1d = nw - Day(1); x2d = nw + Day(60)
flout = joinpath(@OUTPUT, "d_axis_d2")
gmtbegin(flout, fmt="png")
basemap(region=(x1d, x2d, 0, 1), J="X9c/3c", 
        xaxis=(annot=7, annot_unit=:day_week, 
               ticks=1, ticks_unit=:day_date),
        xaxis2=(annot=1, annot_unit=:month, ticks=1, ticks_unit=:month),
        yaxis=(annot=:auto, ticks=:auto, grid=:auto),
        ylabel="y", 
        conf=(FORMAT_TIME_SECONDARY_MAP="abbreviated", 
              FORMAT_DATE_MAP="\"o yyyy\"", 
              FONT_ANNOT_PRIMARY="7p", FONT_ANNOT_SECONDARY="8p"),
        )
gmtend()

# -1月，+36月
x1m = nw - Month(1); x2m = nw + Month(36)
flout = joinpath(@OUTPUT, "d_axis_m2")
gmtbegin(flout, fmt="png")
basemap(region=(x1m, x2m, 0, 1), J="X9c/3c", 
        xaxis=(annot=1, annot_unit=:month, ticks=1, ticks_unit=:month, 
               grid=:auto),
        xaxis2=(annot=1, annot_unit=:year, ticks=1, ticks_unit=:year),
        yaxis=(annot=:auto, ticks=:auto, grid=:auto),
        ylabel="y", 
        conf=(FORMAT_TIME_PRIMARY_MAP="character", FORMAT_DATE_MAP="\"o\"", 
              FONT_ANNOT_PRIMARY="8p"), 
        )
gmtend()