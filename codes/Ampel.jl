using Plots
using DataFrames
using IJulia

rectangle(w, h, x, y) = Shape(x .+ [0, w, w, 0], y .+ [0, 0, h, h])

function getRGB(rgb) 
    if length(rgb) != 3
        error("Der RGB-Wert enthält nicht genau drei Werte")
    end

    if rgb[1] < 0 || rgb[1] > 255
        error("Der erste RGB-Wert muss zwischen 0 und 255 liegen")
    end

    if rgb[2] < 0 || rgb[2] > 255
        error("Der zweite RGB-Wert muss zwischen 0 und 255 liegen")
    end

    if rgb[3] < 0 || rgb[3] > 255
        error("Der dritte RGB-Wert muss zwischen 0 und 255 liegen")
    end

    return RGB(rgb[1] / 255, rgb[2] / 255, rgb[3] / 255)
end

function drawLights(colorTop, colorMiddle, colorBottom = :nothing) 
    plot(rectangle(1, 1, 0, 1), fillcolor = colorTop, xlim = 1, xaxis = false, yaxis = false, legend = false, size = (200, 300))
    plot!(rectangle(1, 1, 0, 0), fillcolor = colorMiddle)

    if colorBottom != :nothing
        plot!(rectangle(1, 1, 0, -1), fillcolor = colorBottom)
    end
end

function Ampel(rgbTop, rgbBottom)
    colorTop = getRGB(rgbTop)
    colorBottom = getRGB(rgbBottom)
    
    drawLights(colorTop, colorBottom)
end

function Ampel(rgbTop, rgbMiddle, rgbBottom)
    colorTop = getRGB(rgbTop)
    colorMiddle = getRGB(rgbMiddle)
    colorBottom = getRGB(rgbBottom)
    
    drawLights(colorTop, colorMiddle, colorBottom)
end

function AmpelSW(rgbTop, rgbBottom, func) 
    colorTop = getRGB(fill(func(rgbTop[1], rgbTop[2], rgbTop[3]), 3))
    colorBottom = getRGB(fill(func(rgbBottom[1], rgbBottom[2], rgbBottom[3]), 3))

    drawLights(colorTop, colorBottom)
end

function Ampeltest(number, m, b, x1, x2)
    # Display lights
    ratios = Dict("red" => 0.299, "green" => 0.587, "blue" => 0.114)
    lights = [
        Dict("x1" => [ 30 / ratios["red"], 0, 0], "x2" => fill(50, 3)),
        Dict("x1" => fill(40, 3), "x2" => [0, 120/ratios["green"], 0]),
        Dict("x1" => [ 45 / ratios["red"], 0, 0], "x2" => fill(58, 3)),
        Dict("x1" => [ 70, 0, 0], "x2" => fill(30, 3)),
        Dict("x1" => fill(50, 3), "x2" => [0, 65 / ratios["green"], 0]),
        Dict("x1" => fill(20, 3), "x2" => [0, 100 / ratios["green"], 0])
    ]

    display(Ampel(lights[number]["x1"], lights[number]["x2"]))

    lines = Dict(
        "a" => Dict("m" => (47.5/36.85), "b" => 6.25),
        "b" => Dict("m" => (22.5/54.17), "b" => 37.5),
        "c" => Dict("m" => 0, "b" => 60)
    )

    # Compute results

    results = Matrix(undef, 0, 2)

    for line in ["a", "b", "c"]
        results = [results; line getResult(lines[line]["m"], lines[line]["b"], x1, x2)]
    end

    results = [ results; "eigene Gerade" getResult(m, b, x1, x2)]
    df = convert(DataFrame, results)
    names!(df, [Symbol("Gerade"), Symbol("Klassifizierung")])

    display(df)
end

function getResult(m, b, x1, x2)
    d = (x1 * m + b - x2)

    return d < 0 ? "grün" : "rot"
end