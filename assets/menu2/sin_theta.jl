# This file was generated, do not modify it. # hide
x = range(0.0, 4pi, length=401)  # 0 から ４π を 401 個 に刻む．
y = sin.(x)
flout = joinpath(@OUTPUT, "sin_theta")
gmtbegin(flout, fmt="png")
basemap(region=(0.0, 4pi, -1.1, 1.1), figsize=(8,4),
            axes=:WSne, 
            xaxis=(custom=(pos=[0, pi/2, pi, 3pi/2,  2pi, 5pi/2, 3pi, 7pi/2, 4pi],
            type=["ag", "fg", "fag @~p@~", "fg", "fag 2@~p@~", "fg", "afg 3@~p@~", "fg", "afg 4@~p@~"]),),
            xlabel="@~q@~ [rad]",
            yaxis=(annot=0.5, ticks=0.1, grid=0.5),
            ) 
plot(x, y, pen=(0.5, :blue))
gmtend()