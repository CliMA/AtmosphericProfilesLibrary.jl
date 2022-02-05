module AtmosphericProfilesLibrary

import Dierckx

include("AtmosProfileTypes.jl")
import .AtmosProfileTypes
const APT = AtmosProfileTypes

# Large data-based profiles
include("profiles/Soares.jl")
include("profiles/TRMM_LBA.jl")
include("profiles/Rico.jl")
include("profiles/DryBubble.jl")

end # module
