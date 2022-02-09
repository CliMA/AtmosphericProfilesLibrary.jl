module AtmosphericProfilesLibrary

import Dierckx

# Large data-based profiles
include("profiles/Soares.jl")
include("profiles/Nieuwstadt.jl")
include("profiles/Bomex.jl")
include("profiles/TRMM_LBA.jl")
include("profiles/Rico.jl")
include("profiles/DryBubble.jl")

end # module
