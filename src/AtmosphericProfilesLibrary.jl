module AtmosphericProfilesLibrary

import Dierckx

# Large data-based profiles
include("profiles/Soares.jl")
include("profiles/Nieuwstadt.jl")
include("profiles/Bomex.jl")
include("profiles/LifeCycleTan2018.jl")
include("profiles/Rico.jl")
include("profiles/TRMM_LBA.jl")
include("profiles/ARM_SGP.jl")
include("profiles/DryBubble.jl")

end # module
