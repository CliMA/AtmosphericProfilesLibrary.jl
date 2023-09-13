#= This is an experimental design, but perhaps it's not needed.=#
module AtmosProfileTypes

abstract type AbstractProfileType end
abstract type AbstractProfile1D <: AbstractProfileType end
abstract type AbstractProfile2D <: AbstractProfileType end
struct zProfile <: AbstractProfile1D end
struct tProfile <: AbstractProfile1D end
struct tzProfile <: AbstractProfile2D end

"""
    AtmosphericProfile{T}(profile::P)

An atmospheric profile, which is callable
object or function with arguments:

    - `profile(z)` (altitude [m])
    - `profile(t)` (time [s])
    - `profile(t, z)` (time [s], altitude [m])

For example, if we just use a function, we have
```julia
profile = z-> 2*z
```
We can call this function with `profile(10.0)`.
"""
struct AtmosphericProfile{T, P}
    profile::P
    AtmosphericProfile{T}(profile::P) where {T, P} = new{T, P}(profile)
end

function (p::AtmosphericProfile{<:AbstractProfile2D})(t, z)
    p.profile(t, z)
end

function (p::AtmosphericProfile{<:AbstractProfile1D})(z_or_t)
    p.profile(z_or_t)
end

end # module