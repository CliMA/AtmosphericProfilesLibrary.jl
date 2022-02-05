using Test
using AtmosphericProfilesLibrary

iscallable(f) = !isempty(methods(f))
@testset "AtmosphericProfilesLibrary" begin
    for name in names(AtmosphericProfilesLibrary; all = true)
        startswith(string(name), "#") && continue
        name == :APT && continue
        name == :AtmosProfileTypes && continue
        name == :AtmosphericProfilesLibrary && continue
        name == :eval && continue
        name == :include && continue
        prof = getproperty(AtmosphericProfilesLibrary, name)
        iscallable(prof) || @show name
        @test iscallable(prof)
    end
end
