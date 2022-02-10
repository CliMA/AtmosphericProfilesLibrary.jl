""" [Khairoutdinov2009](@cite) """
function GATE_III_z(::Type{FT}) where {FT}
    z_in = FT[ 0.0,   0.5,  1.0,  1.5,  2.0,   2.5,    3.0,   3.5,   4.0,   4.5,   5.0,  5.5,  6.0,  6.5,
               7.0, 7.5, 8.0,  8.5,   9.0,   9.5, 10.0,   10.5,   11.0, 11.5, 12.0, 12.5, 13.0, 13.5, 14.0,
               14.5, 15.0, 15.5, 16.0, 16.5, 17.0, 17.5, 18.0, 27.0] .* 1000 #z is in meters
    return z_in
end

""" [Khairoutdinov2009](@cite) """
function GATE_III_q_tot(::Type{FT}) where {FT}
    z_in = GATE_III_z(FT)
    r_in = FT[16.5,  16.5, 13.5, 12.0, 10.0,   8.7,    7.1,   6.1,   5.2,   4.5,   3.6,  3.0,  2.3, 1.75, 1.3,
               0.9, 0.5, 0.25, 0.125, 0.065, 0.003, 0.0015, 0.0007,  0.0003,  0.0001,  0.0001,  0.0001,  0.0001,
               0.0001,  0.0001,  0.0001,  0.0001,  0.0001,  0.0001,  0.0001,  0.0001,  0.0001, 0.0001] ./ 1000 # mixing ratio should be in kg/kg
    q_tot = r_in ./ (1 .+ r_in) # convert mixing ratio to specific humidity
    profile = Dierckx.Spline1D(z_in, q_tot; k = 1)
    return profile
end


""" [Khairoutdinov2009](@cite) """
function GATE_III_u(::Type{FT}) where {FT}
    z_in = GATE_III_z(FT)
    U_in = FT[  -1, -1.75, -2.5, -3.6, -6.0, -8.75, -11.75, -13.0, -13.1, -12.1, -11.0, -8.5, -5.0, -2.6, 0.0,
               0.5, 0.4,  0.3,   0.0,  -1.0, -2.5,   -3.5,   -4.5, -4.8, -5.0, -3.5, -2.0, -1.0, -1.0, -1.0,
               -1.5, -2.0, -2.5, -2.6, -2.7, -3.0, -3.0, -3.0] # [m/s]
    profile = Dierckx.Spline1D(z_in, U_in; k = 1)
    return profile
end

""" [Khairoutdinov2009](@cite) """
function GATE_III_T(::Type{FT}) where {FT}
    # temperature is taken from a different input plot at different z levels
    z_in = GATE_III_z(FT)
    T_in = FT[299.184, 294.836, 294.261, 288.773, 276.698, 265.004, 253.930, 243.662, 227.674, 214.266, 207.757, 201.973, 198.278, 197.414, 198.110, 198.110]
    z_T_in = FT[0.0, 0.492, 0.700, 1.698, 3.928, 6.039, 7.795, 9.137, 11.055, 12.645, 13.521, 14.486, 15.448, 16.436, 17.293, 22.0] .* 1000 # for km
    profile = Dierckx.Spline1D(z_T_in, T_in; k = 1)
    return profile
end

""" [Khairoutdinov2009](@cite) """
function GATE_III_tke(::Type{FT}) where {FT}
    return z -> if z <= 2500.0
            FT(1) - z / 3000.0
        else
            FT(0)
        end
end
