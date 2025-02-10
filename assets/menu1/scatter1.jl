# This file was generated, do not modify it. # hide
using Random
using GMT
Random.seed!(20250211) # 乱数の種を日付にしている
n = 100
x = randn(n)
y = randn(n)

flfig = joinpath(@OUTPUT, "scatter1")
scatter(x, y, savefig=flfig)