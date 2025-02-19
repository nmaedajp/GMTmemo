+++
title = "日付型の軸"
hascode = false

tags = ["axis", "basemap", "plot"]
+++

# 日付型の軸

\toc

日付型の軸については，GMT.jlのドキュメント[Cartesian time axes](https://www.generic-mapping-tools.org/GMTjl_doc/examples/frames/frames/#cartesian_time_axes/) あたりが参考となる．

## 自動で軸を描く

日付型の軸を自動でいくつか描いてみる．

```julia:./d_axis.jl
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
```

* -1時間，+49時間
\fig{./output/d_axis_h}

* -1日，+60日
\fig{./output/d_axis_d}


* -1月，+36月
\fig{./output/d_axis_m}

これらの出力をみると，字が重なっているところ，
ひとつ上のカテゴリー（時刻だけではなく日も追加，何年何月を入れたい，年月を入れたい）
など，もう少し整えたい気持ちになってくる．

## 第２軸を使う

こんなときには，第２軸を使って，軸の表記を整える．

```julia:./d_axis2.jl
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
```

* -1時間，+49時間
\fig{./output/d_axis_h2}

　　時刻を６時間毎＋日付

* -1日，+60日
\fig{./output/d_axis_d2}

　　週の月曜日の日が入っている．
縦のグリッド線は入れていない．


* -1月，+36月
\fig{./output/d_axis_m2}

　　月の１文字と年

文字の重なりなどは，作図してみないとわからないこともあるので，
結局のところはトライアル・アンド・エラーになる．
