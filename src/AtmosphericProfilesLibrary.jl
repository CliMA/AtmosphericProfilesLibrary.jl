module AtmosphericProfilesLibrary

import ClimaInterpolations.Interpolation1D as CI1D
import Interpolations as Intp
import StaticArrays: SMatrix, SVector

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

struct BilinearInterpolation{I}
    itp::I
end

struct Interpolate2D{X, Y, F, EO}
    xsource::X
    ysource::Y
    fsource::F
    extrapolationorder::EO
end

@inline (itp::Interpolate2D)(x, y) = bilinear_eval(itp, x, y)

@inline (bi::BilinearInterpolation)(t, z) = bi.itp(t, z)

@inline function bilinear_eval(itp::Interpolate2D, x, y)
    T = eltype(itp.fsource)
    x = convert(T, x)
    y = convert(T, y)

    stx, enx = CI1D.get_stencil(
        CI1D.Linear(),
        itp.xsource,
        x;
        extrapolate = itp.extrapolationorder,
    )
    sty, eny = CI1D.get_stencil(
        CI1D.Linear(),
        itp.ysource,
        y;
        extrapolate = itp.extrapolationorder,
    )

    if stx == enx && sty == eny
        return @inbounds itp.fsource[stx, sty]
    elseif stx == enx
        return CI1D.interpolate(
            SVector(itp.ysource[sty], itp.ysource[eny]),
            SVector(itp.fsource[stx, sty], itp.fsource[stx, eny]),
            y,
        )
    elseif sty == eny
        return CI1D.interpolate(
            SVector(itp.xsource[stx], itp.xsource[enx]),
            SVector(itp.fsource[stx, sty], itp.fsource[enx, sty]),
            x,
        )
    end

    @inbounds begin
        lx = itp.xsource[enx] - itp.xsource[stx]
        ly = itp.ysource[eny] - itp.ysource[sty]
        dx1 = x - itp.xsource[stx]
        dx2 = itp.xsource[enx] - x
        dy1 = y - itp.ysource[sty]
        dy2 = itp.ysource[eny] - y
        fac = inv(lx * ly)
        return (
            dx2 * dy2 * itp.fsource[stx, sty] +
            dx1 * dy2 * itp.fsource[enx, sty] +
            dx2 * dy1 * itp.fsource[stx, eny] +
            dx1 * dy1 * itp.fsource[enx, eny]
        ) * fac
    end
end

@inline function bilinear_interp(t, z, f)
    @assert size(f) == (length(t), length(z))
    Nt, Nz = length(t), length(z)
    T = promote_type(eltype(t), eltype(z), eltype(f))
    itp = Interpolate2D(
        SVector{Nt,T}(t),
        SVector{Nz,T}(z),
        SMatrix{Nt,Nz,T}(f),
        CI1D.Flat(),
    )
    return BilinearInterpolation(itp)
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
