function GrauwertUeberpruefung(func)
    red = 1
    green = 1
    blue = 1

    # Sinnvolle Überprüfung?!

    if round(func(red, green, blue) * 1000) / 1000 == 1
        println("Euer Term ist korrekt.")
    else
        println("Euer Term ist noch nicht richtig.")
    end
end