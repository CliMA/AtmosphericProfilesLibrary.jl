using Test
using AtmosphericProfilesLibrary

iscallable(f) = !isempty(methods(f))
@testset "AtmosphericProfilesLibrary" begin
    for name in names(AtmosphericProfilesLibrary; all = true)
        startswith(string(name), "#") && continue
        name == :AtmosphericProfilesLibrary && continue
        name == :TRMM_LBA_z_in && continue # returns an array for other profiles
        name == :ARM_SGP_z_in && continue # returns an array for other profiles
        name == :GATE_III_z_in && continue # returns an array for other profiles
        name == :eval && continue
        name == :include && continue
        prof = getproperty(AtmosphericProfilesLibrary, name)
        iscallable(prof) || @show name

        # Test that function is callable
        @test iscallable(prof)
        # Test for type-stability
        @test @inferred Float32 iscallable(prof(Float32))
    end
end
