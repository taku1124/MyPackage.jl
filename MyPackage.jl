module MyPackage

using Plots
gr()

#fとtの定義
function f(x)
    return x*x/5 - 3
end
function t(x, x1, x2)
	return (f(x1)-f(x2)) * (x-x1) / (x1-x2) + f(x1)
end

a1 = []
b1 = []
anim = Animation()

#点aとbの決定
a=-3
b = 6

function hasami()
　　global a1, b1
    a1 = []
    b1 = []
    a = -3
    b = 6
    i = 0
    c = (a*f(b)-b*f(a))/(f(b)-f(a))
    while abs(f(c)) > 1e-5
	i += 1
        c = (a*f(b)-b*f(a))/(f(b)-f(a))
        if f(a)*f(c) < 0
            b = c
        else
            a = c
        end
	push!(a1, a)
	push!(b1, b)
    end
end

function hasamiuti()
　　global a1, b1
    a1 = []
    b1 = []
    a = -3
    b = 6
    i = 0
    c = (a*f(b)-b*f(a))/(f(b)-f(a))
    while abs(f(c)) > 1e-5
	i += 1
        c = (a*f(b)-b*f(a))/(f(b)-f(a))
	println(i,":",c)
        if f(a)*f(c) < 0
            b = c
        else
            a = c
        end
	push!(a1, a)
	push!(b1, b)
    end
    return c
end

function anime()
    anim = Animation()

    hasami()
    x1 = range(-10, 15, length=100)
    y2 = []

    for i in x1
        push!(y2, f(i))
    end

    for i in 1:length(a1)
	y1 = []
    	for j in x1
    	    push!(y1, t(j, a1[i], b1[i]))
	end
    	plt = plot(x1, y1,label="x=$i",
                xlims=(-10, 15), ylims=(-10, 15),
                xlabel="x",ylabel="y")
	plt = plot!(x1, y2,label="x=$i",
                xlims=(-10, 15), ylims=(-10, 15),
                xlabel="x",ylabel="y")
    	frame(anim, plt)
    end
    #gifに変換
    gif(anim, "test.gif", fps = 5)
end

end # module MyPackage
