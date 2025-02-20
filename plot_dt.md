+++
title = "日付型の散布図"
hascode = false
tags = ["scatter", "basemap", "DateTime"]
+++

\toc

# 要点

* ある時から，日付，日時型のデータがプロットできなくなった．
* GMTDataset の型に日付，日時型が含まれないことによるのか．
* 軸作成の上限下限の値としては，使用できる．
* 回避策として考えたのは，以下の２つ
  * 一旦ファイルに書き出し，ファイルから読み込む．
  * 日付型を数値に変換する

# 概要

日付型のデータについては，`GMT.jl` の `v0.44.5` までは，プロットが可能だったが，
`v0.44.8` からプロットができなくなった．
バージョンが飛んでいるのは，
`v0.44.6`，`v0.44.7` をインストールしていなかったため．

この状況は，バージョンが `v1.xx.x` になっても変化していない．
(現在は，`v1.26.0`を使用)

エラーの最初の方は，
~~~
<pre>
ERROR: MethodError: no method matching GMTdataset(::Matrix{…}, 
::Vector{…}, ::Vector{…}, ::Dict{…}, ::Vector{…}, ::Vector{…}, 
::String, ::Vector{…}, ::String, ::String, ::Int64, ::Int64)
The type `GMTdataset` exists, but no method is defined for this 
combination of argument types when trying to construct it.
</pre>
~~~
となっている．
[GMTdataset](https://www.generic-mapping-tools.org/GMTjl_doc/documentation/general/types/index.html#dataset_type/) の項目をみると，
~~~
<pre>
struct GMTdataset{T<:Real, N} <: AbstractArray{T,N}
    data::Array{T,N}           # Mx2 Matrix with segment data
    ds_bbox::Vector{Float64}   # Global BoundingBox (for when there are many segments)
    bbox::Vector{Float64}      # Segment BoundingBox
    attrib::Dict{String, String} # Dictionary with attributes/values (optional)
    colnames::Vector{String}   # Column names. Antecipate using this with a future Tables inerface
    text::Vector{String}       # Array with text after data coordinates (mandatory only when plotting Text)
    header::String             # String with segment header (Optional but sometimes very useful)
    comment::Vector{String}    # Array with any dataset comments [empty after first segment]
    proj4::String              # Projection string in PROJ4 syntax (Optional)
    wkt::String                # Projection string in WKT syntax (Optional)
    epsg::Int                  # EPSG projection code (Optional)
    geom::Integer              # Geometry type. One of the GDAL's enum (wkbPoint, wkbPolygon, etc...)
end
</pre>
~~~
となっている．`T<:Real` となっているので，Date型，DateTime型は，含まれていない．
これが上のエラーの意味であろう．

これを避けるために，２つの手段を考えてみた．

* 一旦，ファイルに書き出して，ファイル名を指定する．
* Date型，DateTime型を数値に変換する

# ファイルに書き出す

エコではないが，データを一度ファイルに落とし，ファイルのデータをプロットする形を取る．

```julia:./plot_dt1.jl
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
```

\fig{./output/plot_dt1}

# 数値に変換する

軸を描くときは，DateTime型のまま使用し，
プロットするときは，DateTime型を数値に変換し，再スケーリングする．

```julia:./plot_dt2.jl
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
```

\fig{./output/plot_dt2}
