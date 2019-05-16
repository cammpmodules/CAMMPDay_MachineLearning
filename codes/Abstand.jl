function Abstand(d)
    p = [1, 1, 1]
    x = [0, 0, 0]
    n = [0, 0, 1]

    distance = d(p, x, n)

    if distance == 1
        print("Euer Ergebnis ist korrekt!")
    else
        println("Euer Ergebnis ist noch nicht ganz richtig! Habt ihr den Vektor PX richtig gebildet?")
    end
end

function AbstandKorrekt(d)
    p = [1, 1, 1]
    x = [0, 0, 0]
    n = [0, 0, -1]
    t = -1

    distanceBelow = d(p, x, n, t)
    distanceAbove = d(-p, x, n, -t)

    if distanceBelow == 1 && distanceAbove == 1
        print("Euer Ergebnis ist korrekt!")
    else
        println("Euer Ergebnis ist noch nicht ganz richtig!")
    end
end