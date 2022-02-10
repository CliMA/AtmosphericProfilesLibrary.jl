""" [Brown2002](@cite) """
function ARM_SGP_z_in(::Type{FT}) where {FT}
    z_in = FT[0.0, 50.0, 350.0, 650.0, 700.0, 1300.0, 2500.0, 5500.0 ] #LES z is in meters
    return z_in
end
""" [Brown2002](@cite) """
function ARM_SGP_θ_liq_ice(::Type{FT}) where {FT}
    z_in = ARM_SGP_z_in(FT)
    θ_liq_ice_in = FT[299.0, 301.5, 302.5, 303.53, 303.7, 307.13, 314.0, 343.2] # K
    profile = Dierckx.Spline1D(z_in, θ_liq_ice_in; k = 1)
    return profile
end
""" [Brown2002](@cite) """
ARM_SGP_u(::Type{FT}) where {FT} = z -> FT(10)

""" [Brown2002](@cite) """
function ARM_SGP_q_tot(::Type{FT}) where {FT}
    z_in = ARM_SGP_z_in(FT)
    r_in = FT[15.2,15.17,14.98,14.8,14.7,13.5,3.0,3.0] ./ 1000 # qt should be in kg/kg
    q_tot_in = r_in ./ (1 .+ r_in)
    profile = Dierckx.Spline1D(z_in, q_tot_in; k = 1)
    return profile
end
""" [Brown2002](@cite) """
function ARM_SGP_tke(::Type{FT}) where {FT}
    return z -> if z <= 2500.0
        FT(1) - z / 3000
    else
        FT(0)
    end
end
