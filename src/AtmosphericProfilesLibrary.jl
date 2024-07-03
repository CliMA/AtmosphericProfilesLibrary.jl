module AtmosphericProfilesLibrary

import Interpolations as Intp

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

end # module
