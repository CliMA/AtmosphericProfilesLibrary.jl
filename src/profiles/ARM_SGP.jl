""" [Brown2002](@cite) """
function ARM_SGP_z(::Type{FT}) where {FT}
    z_in = FT[0.0, 50.0, 350.0, 650.0, 700.0, 1300.0, 2500.0, 5500.0 ] #LES z is in meters
    return z_in
end
""" [Brown2002](@cite) """
function ARM_SGP_θ_liq_ice(::Type{FT}) where {FT}
    z_in = ARM_SGP_z(FT)
    θ_liq_ice_in = FT[299.0, 301.5, 302.5, 303.53, 303.7, 307.13, 314.0, 343.2] # K
    profile = Dierckx.Spline1D(z_in, θ_liq_ice_in; k = 1)
    return profile
end
""" [Brown2002](@cite) """
ARM_SGP_u(::Type{FT}) where {FT} = z -> FT(10)

""" [Brown2002](@cite) """
function ARM_SGP_q_tot(::Type{FT}) where {FT}
    z_in = ARM_SGP_z(FT)
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

""" [Brown2002](@cite) """
function ARM_SGP_time(::Type{FT}) where {FT}
    t_in = FT[0.0, 3.0, 6.0, 9.0, 12.0, 14.5] .* 3600 #LES time is in sec
    return t_in
end

""" [Brown2002](@cite) """
function ARM_SGP_dTdt(::Type{FT}) where {FT}
    t_in = ARM_SGP_time(FT)
    # Advective forcing for theta [K/h] converted to [K/sec]
    AT_in = FT[0.0, 0.0, 0.0, -0.08, -0.016, -0.016] ./ 3600
    # Radiative forcing for theta [K/h] converted to [K/sec]
    RT_in = FT[-0.125, 0.0, 0.0, 0.0, 0.0, -0.1] ./ 3600
    dTdt_A = Dierckx.Spline1D(t_in, AT_in; k = 1)
    dTdt_R = Dierckx.Spline1D(t_in, RT_in; k = 1)
    return (t, z) -> if z <= 1000.0
        dTdt_A(t)+dTdt_R(t)
    elseif z > 1000.0 && z <= 2000.0
        (dTdt_A(t)+dTdt_R(t)) * (1 - (z - 1000) / 1000)
    else
        FT(0)
    end
end

""" [Brown2002](@cite) """
function ARM_SGP_dqtdt(::Type{FT}) where {FT}
    t_in = ARM_SGP_time(FT)
    # Radiative forcing for qt converted to [kg/kg/sec]
    Rqt_in = FT[0.08, 0.02, 0.04, -0.1, -0.16, -0.3] ./ 1000 ./ 3600
    dqtdt = Dierckx.Spline1D(t_in, Rqt_in; k = 1)
    return (Π, t, z) -> if z <= 1000.0
        dqtdt(t) * Π
    elseif z > 1000.0 && z <= 2000.0
        dqtdt(t) * Π * (1 - (z - 1000) / 1000)
    else
        FT(0)
    end
end
