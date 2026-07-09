module AtmosphericProfilesLibrary

import ClimaInterpolations.Interpolation1D as CI1D
import Interpolations as Intp
import StaticArrays: SVector

abstract type AbstractProfile end
struct TimeProfile{P} <: AbstractProfile
    prof::P
end
@inline (prof::TimeProfile)(t) = prof.prof(t)

struct TimeZProfile{P} <: AbstractProfile
    prof::P
end
@inline (prof::TimeZProfile)(t, z) = prof.prof(t, z)

struct ZProfile{P} <: AbstractProfile
    prof::P
end
@inline (prof::ZProfile)(z) = prof.prof(z)

struct ΠTimeZProfile{P} <: AbstractProfile
    prof::P
end
@inline (prof::ΠTimeZProfile)(Π, t, z) = prof.prof(Π, t, z)

struct ΠZProfile{P} <: AbstractProfile
    prof::P
end
@inline (prof::ΠZProfile)(Π, z) = prof.prof(Π, z)

struct LinearInterpolation{I}
    itp::I
end

@inline (li::LinearInterpolation)(z) = li.itp(convert(eltype(li.itp.xsource), z))

@inline function linear_interp(z, x)
    @assert length(z) == length(x)
    N = length(z)
    T = promote_type(eltype(z), eltype(x))
    xsource = SVector{N,T}(z)
    fsource = SVector{N,T}(x)
    itp = CI1D.Interpolate1D(
        xsource,
        fsource;
        interpolationorder = CI1D.Linear(),
        extrapolationorder = CI1D.Flat(),
    )
    return LinearInterpolation(itp)
end

# Large data-based profiles
include("profiles/Soares.jl")
include("profiles/Nieuwstadt.jl")
include("profiles/Bomex.jl")
include("profiles/LifeCycleTan2018.jl")
include("profiles/Rico.jl")
include("profiles/TRMM_LBA.jl")
include("profiles/ARM_SGP.jl")
include("profiles/GATE_III.jl")
include("profiles/Dycoms_RF01.jl")
include("profiles/Dycoms_RF02.jl")
include("profiles/GABLS.jl")
include("profiles/SP.jl")
include("profiles/DryBubble.jl")
include("profiles/ISDAC.jl")

# Idealized profiles
include("profiles/Larcform1.jl")

end # module
