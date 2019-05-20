using Plots
using CSV
using Colors

plotlyjs()

function PunkteLaden(color)
    path = string("./codes/data/", color, ".csv")

    x1 = [ ]
    x2 = [ ]
    x3 = [ ]

    for row in CSV.File(path, header = false, delim = ",")
        x1 = [x1; row.Column1 ]
        x2 = [x2; row.Column2 ]
        x3 = [x3; row.Column3 ]
    end

    return [x1 x2 x3]
end

function PunkteAnzeigen()
    greenPoints = PunkteLaden("green")
    yellowPoints = PunkteLaden("yellow")
    redPoints = PunkteLaden("red")

    scatter(greenPoints[:, 1], greenPoints[:, 2], greenPoints[:, 3], markercolor = parse(Colorant, "green"), label = "Grüne Ampel", xlabel="x1", ylabel="x2", zlabel="x3")
    scatter!(yellowPoints[:, 1], yellowPoints[:, 2], yellowPoints[:, 3], markercolor = parse(Colorant, "yellow"), label = "Gelbe Ampel")
    scatter!(redPoints[:, 1], redPoints[:, 2], redPoints[:, 3], markercolor = parse(Colorant, "red"), label = "Rote Ampel")
end