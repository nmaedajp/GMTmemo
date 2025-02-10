# This file was generated, do not modify it. # hide
using Random
using GMT
Random.seed!(20250211) # 乱数の種を日付にしている
n = 100
x = randn(n)
y = randn(n)

flfig = joinpath(@OUTPUT, "scatter3")
gmtbegin(flfig, fmt="png")
    basemap(R="-3.5/3.5/-3.5/3.5", 
        J="x1c/1c", 
        B="afg WSne",
        xlabel="x", ylabel="y"
        )
    scatter(x, y)
gmtend()