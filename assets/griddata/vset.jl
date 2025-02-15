# This file was generated, do not modify it. # hide
using GMT
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