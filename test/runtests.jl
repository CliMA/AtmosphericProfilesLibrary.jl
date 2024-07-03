using Test
using AtmosphericProfilesLibrary
import AtmosphericProfilesLibrary as APL

iscallable(f) = !isempty(methods(f))

function test_profile(::Type{FT}, prof, name) where {FT}
    @debug "Testing $name"
    if prof isa APL.TimeProfile
        prof(1)
        @inferred prof(Float32(1))
    elseif prof isa APL.TimeZProfile
        prof(1, 1)
        @inferred prof(Float32(1), Float32(1))
    elseif prof isa APL.ZProfile
        prof(1)
        @inferred prof(Float32(1))
    elseif prof isa APL.ΠTimeZProfile
        prof(1,1,1)
        @inferred prof(Float32(1),Float32(1),Float32(1))
    elseif prof isa APL.ΠZProfile
        prof(1,1)
        @inferred prof(Float32(1),Float32(1))
    else
        @show name
        @show prof
        error("uncaught case")
    end
end

include("profiles.jl")

@testset "AtmosphericProfilesLibrary" begin
    for (name, prof) in profiles(Float64)
        test_profile(Float64, prof, name)
    end
    for (name, prof) in profiles(Float32)
        test_profile(Float32, prof, name)
    end
end
