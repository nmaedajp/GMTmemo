# This file was generated, do not modify it. # hide
using GMT
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
Gz = mat2grid(kansu, x = x1:dx:x2, y = y1:dy:y2)

# 段彩図，等値線の作成
flout = joinpath(@OUTPUT, "kansugrd")
gmtbegin(flout, fmt="png")
    basemap(B="afg WSne", region=(x1, x2, y1, y2), J="X8c/8c", 
        xlabel="x", ylabel="y")
    grdimage(Gz, color=:rainbow)
    grdcontour(Gz, cont=2, annot=(int=4, labels=(font=8,)), labels=(dist=4,))
    colorbar(frame=(annot=:auto,))
gmtend()