using AtmosphericProfilesLibrary, Documenter
using DocumenterCitations
import Glob

# https://github.com/jheinen/GR.jl/issues/278#issuecomment-587090846
ENV["GKSwstype"] = "nul"

bib = CitationBibliography(joinpath(@__DIR__, "bibliography.bib"))

include("generate_profile_library.jl")

#! format: off
pages = Any[
    "Home" => "index.md",
    "Profile library" => "generated_profile_library.md",
    "References" => "References.md",
]

mathengine = MathJax(Dict(
    :TeX => Dict(
        :equationNumbers => Dict(:autoNumber => "AMS"),
        :Macros => Dict(),
    ),
))

format = Documenter.HTML(
    prettyurls = get(ENV, "CI", nothing) == "true",
    mathengine = mathengine,
    collapselevel = 1,
)
#! format: on

makedocs(
    plugins = [bib],
    sitename = "AtmosphericProfilesLibrary.jl",
    format = format,
    checkdocs = :exports,
    clean = true,
    doctest = true,
    modules = [AtmosphericProfilesLibrary],
    pages = pages,
)

deploydocs(
    repo = "github.com/CliMA/AtmosphericProfilesLibrary.jl.git",
    target = "build",
    push_preview = true,
    devbranch = "main",
    forcepush = true,
)

# Remove temp files (e.g., .DS_Store)
for (root, _, files) in Base.Filesystem.walkdir(pkgdir(AtmosphericProfilesLibrary))
    for f in files
        file = joinpath(root, f)
        if endswith(file, ".DS_Store")
            rm(file; force = true)
        end
        occursin("build/", file) && continue
        if endswith(file, ".png")
            rm(file; force = true)
        end
    end
end
