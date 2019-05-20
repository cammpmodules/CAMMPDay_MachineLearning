using Plots
using BlackBoxOptim

NumberOfRedPoints = 10
NumberOfBluePoints = 10
x1 = [
    -4.14707010696915,
    -4.06887045816803,
    -3.80949869442488,
    -5.94428416199490,
    -1.56161970718490,
    -2.67480946054380,
    -3.75492831916970,
    -1.62970145990477,
    -4.71151641885370,
    -3.10224244608549,
    0.758552958392642,
    1.31920673916550,
    1.31285859663743,
    0.135120082675544,
    0.969948703803731,
    0.835120980790962,
    1.62770728752873,
    2.09326566903948,
    2.10927329761440,
    0.136347178011286
]

x2 = [
    1.07735909113043,
    -0.214117043615409,
    -0.113500741486764,
    0.993150671896652,
    2.53263030828475,
    0.230334086246318,
    1.37137881276006,
    0.774415597728748,
    2.11735613881447,
    -0.0890642950522358,
    -1.96744253583503,
    -1.44747297888778,
    -0.899389782119134,
    -0.455788104496049,
    -1.91406886682457,
    -3.49159031063761,
    -2.74230183725986,
    -3.06158173331999,
    0.350457224002042,
    -2.61560188146689
]

t = ones(NumberOfRedPoints + NumberOfBluePoints,1);

function TestdatensatzAnzeigen()
    epsilon = 0.5; # epsilon for x and y limits (which is added to maximum / subtracted from minimum)

    plot(x1[1:NumberOfRedPoints], x2[1:NumberOfRedPoints], markercolor = :red, seriestype=:scatter, legend = false, xlims=(minimum(x1) - epsilon, maximum(x1) + epsilon), ylims=(minimum(x2) - epsilon, maximum(x2) + epsilon))
    plot!(x1[NumberOfRedPoints+1:end], x2[NumberOfRedPoints+1:end], markercolor = :blue, seriestype=:scatter, legend = false)
end

function TrennfunktionErmitteln()
    t[1:NumberOfRedPoints] = -t[1:NumberOfRedPoints];

    res = bboptimize(distance, NumDimensions=4);
    result = best_candidate(res);

    n1 = result[1]
    n2 = result[2]
    p1 = result[3]
    p2 = result[4]

    l = range(minimum(x1), maximum(x2), length=100);
    f1 = -(n1.*l.-(n1*p1+n2*p2))/n2;

    n1 = 9.00444097676710
    n2 = -4.28321962359253
    p1 = 0.570662710124255	
    p2 = 2.90978487406280

    f2 = -(n1.*l.-(n1*p1+n2*p2))/n2;

    TestdatensatzAnzeigen()
    plot!(l, f1, color = :black, linestyle = :dash)
    plot!(l, f2, color = :green, linestyle = :dash)
end

function distance(u)
    # parameters to be optimized
    n1 = u[1]
    n2 = u[2]
    p1 = u[3]
    p2 = u[4]

    f = t .*(n1 .* x1+ n2 .*x2 .- (n1*p1+n2*p2)) ./sqrt(n1^2+n2^2)
    return maximum(f)
end