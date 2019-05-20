using LinearAlgebra # This line is needed to provide support for dot() and norm() functions within the Jupyter notebook

module MachineLearning
    using IJulia # Used in order to provide the display() method (see below)

    export Ampel
    export AmpelSW
    export GrauwertUeberpruefung
    export Ampeltest
    export Abstandtest
    export Abstand
    export AbstandKorrekt
    export TestdatensatzAnzeigen
    export PunkteAnzeigen

    # Include all Julia files
    include("./Ampel.jl")
    include("./GrauwertUeberpruefung.jl")
    include("./Abstandtest.jl")
    include("./Abstand.jl")
    include("./Punkte.jl")
    include("./DreiPhasen.jl")

    # The following lines are used to enable auto-numbering equations (see https://stackoverflow.com/a/42940005)
    javascript = """
    MathJax.Hub.Config({
        TeX: { equationNumbers: { autoNumber: "AMS" } }
    });
    """

    display("text/javascript", javascript)
end