
# Generate figures:
include(joinpath(@__DIR__, "src", "plot_profiles.jl"))

prof_lib = joinpath(@__DIR__, "src", "generated_profile_library.md")
open(prof_lib, "w") do io

    println(io, "```@meta")
    println(io, "# ****************************************************")
    println(io, "# ****************************************************")
    println(io, "#     THIS FILE IS AUTO-GENERATED, PLEASE DO NOT EDIT.")
    println(io, "# ****************************************************")
    println(io, "# ****************************************************")
    println(io, "```")

    println(io, "# Profile library")

    println(io, "")
    println(io, "```@meta")
    println(io, "CurrentModule = AtmosphericProfilesLibrary")
    println(io, "```")

    println(io, "")
    println(io, "```@example")
    println(io, "include(joinpath(@__DIR__, \"plot_profiles.jl\"))")
    println(io, "```")
    println(io, "")

    println(io, "## z-profiles")
    for profile in z_profiles
        fname = nameof(profile.func)
        println(io, "```@docs")
        println(io, "$fname")
        println(io, "```")
        println(io, "![](z_$fname.png)")
        println(io, "")
    end

    if !isempty(t_profiles)
        println(io, "## t-profiles")
        for profile in t_profiles
            fname = nameof(profile.func)
            println(io, "```@docs")
            println(io, "$fname")
            println(io, "```")
            println(io, "![](t_$fname.png)")
            println(io, "")
        end
    end

    println(io, "## tz-profiles")
    for profile in tz_profiles
        fname = nameof(profile.func)
        println(io, "```@docs")
        println(io, "$fname")
        println(io, "```")
        println(io, "![](tz_$fname.png)")
        println(io, "")
    end
end

@assert isfile(prof_lib)
