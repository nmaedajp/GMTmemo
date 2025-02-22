# This file was generated, do not modify it. # hide
using GMT
#
# 関数f から 範囲(x1, x2, y1, y2)のグリッドデータを
# 刻み幅 dx，dyで作成する．
function vset(f, x1, x2, dx, y1, y2, dy)
    nx = round(Int64, (x2 - x1)/dx) + 1
    ny = round(Int64, (y2 - y1)/dy) + 1
    zz = Array{Float64}(undef, nx*ny);
    for ix = 1:nx
        x = (ix - 1) * dx + x1
        for iy = 1:ny
            y = (iy - 1) * dy + y1
            ind = (ix-1)*nx + iy
            zz[ind] = f(x, y)
        end
    end
    G = xyz2grd(zz, region=(x1, x2, y1, y2), Z="LB", I="$dx/$dy")
    return G
end
#
# ここで使う関数．
function kansu(x, y)
    z = −0.5*x^2 + y^2 +12.5
    return z
end

# データの範囲と刻み幅
x1 = -5.0; x2 = 5.0; dx = 0.2 
y1 = -5.0; y2 = 5.0; dy = 0.2

# グリッドデータを作成する
Gz = vset(kansu, x1, x2, dx, y1, y2, dy)

# 段彩図，等値線の作成
flout = joinpath(@OUTPUT, "kansu")
gmtbegin(flout, fmt="png")
    basemap(B="afg WSne", region=(x1, x2, y1, y2), J="X8c/8c", 
        xlabel="x", ylabel="y")
    grdimage(Gz, color=:rainbow)
    grdcontour(Gz, cont=2, annot=(int=4, labels=(font=8,)), labels=(dist=4,))
    colorbar(frame=(annot=:auto,))
gmtend()

# 段彩図，等値線の作成：解像度を 300 dpi に設定
flout = joinpath(@OUTPUT, "kansu300")
gmtbegin(flout, fmt="png")
    basemap(B="afg WSne", region=(x1, x2, y1, y2), J="X8c/8c", 
        xlabel="x", ylabel="y")
    grdimage(Gz, color=:rainbow, dpi=300)  # 解像度を 300dpi に設定する
    grdcontour(Gz, cont=2, annot=(int=4, labels=(font=8,)), labels=(dist=4,))
    colorbar(frame=(annot=:auto,))
gmtend()