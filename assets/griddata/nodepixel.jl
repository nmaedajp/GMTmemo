# This file was generated, do not modify it. # hide
#
# gridline node registration と pixel node registration のテスト
#
# データの作成
# pixel の値
x44 = reshape([Float64(i) for i=1:16], 4, 4) 
# gridline 上の値
# pixel で与えた値を元にして与えている
x55 = reshape([-1.5+div(i-1,5)*4+mod(i-1,5) for i=1:25], 5, 5)

# 配列の表示 
println("x44")
for i = 1:4
    for j = 1:4
        print("$(x44[i, j]) ")
    end
    print("\n")
end
    print("\n")
println("x55")
for i = 1:5
    for j = 1:5
        print("$(x55[i, j]) ")
    end
    print("\n")
end
#
using GMT
# grd の作成
x1 = -2.0; x2 = 2.0 # x の下限と上限
y1 = -2.0; y2 = 2.0 # y の下限と上限
# reg = 1 が pixel registration
Grd44 = mat2grid(x44, x = [x1 x2], y = [y1 y2], reg=1)
# default は gridline registration
Grd55 = mat2grid(x55, x = [x1 x2], y = [y1 y2])

# 図を描く
C = makecpt(cmap=:rainbow, range=(-2, 20)) # カラーパレットの作成
# 
flout = joinpath(@OUTPUT, "pixel")
gmtbegin(flout, fmt="png")
    grdimage(Grd44, B="afg WSne", J="X6c/6c", 
            R="-3/3/-3/3",  # 範囲を広めにとっている 
            color=C, title="pixel")
    colorbar(frame=(annot=:auto,))
gmtend()
flout = joinpath(@OUTPUT, "pixel100")
gmtbegin(flout, fmt="png")
    grdimage(Grd44, B="afg WSne", J="X6c/6c", 
            R="-3/3/-3/3",  # 範囲を広めにとっている 
            dpi=100,        # 解像度を100 dpiに 
            color=C, title="pixel 100")
    colorbar(frame=(annot=:auto,))
gmtend()
flout = joinpath(@OUTPUT, "node")
gmtbegin(flout, fmt="png")
    grdimage(Grd55, B="afg WSne", J="X6c/6c", 
            R="-3/3/-3/3",  # 範囲を広めにとっている 
            color=C, title="gridline")
    colorbar(frame=(annot=:auto,))
gmtend()
flout = joinpath(@OUTPUT, "node100")
gmtbegin(flout, fmt="png")
    grdimage(Grd55, B="afg WSne", J="X6c/6c", 
            R="-3/3/-3/3",  # 範囲を広めにとっている 
            dpi=100,        # 解像度を100 dpiに 
            color=C, title="gridline 100")
    colorbar(frame=(annot=:auto,))
gmtend()