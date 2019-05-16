function Abstandtest(situation1, situation2, situation3, situation4)
    correct = [ 'b', 'a', 'c', 'a']
    answers = [ situation1, situation2, situation3, situation4 ]

    if correct == answers
        print("Euer Ergebnis ist korrekt!");
    else 
        print("Euer Ergebnis ist noch nicht richtig!");
    end
end