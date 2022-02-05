""" [Soares2004](@cite) """
Soares_q_tot(::Type{FT}) where {FT} = z -> if z <= 1350.0
        FT(5.0e-3) - FT(3.7e-4) * z / 1000
    else
        FT(5.0e-3) - FT(3.7e-4) * FT(1.35) - FT(9.4e-4) * (z - 1350) / 1000
    end
""" [Soares2004](@cite) """
Soares_θ_liq_ice(::Type{FT}) where {FT} = z -> if z <= 1350.0
        FT(300.0)
    else
        FT(300) + 2 * (z - 1350) / 1000
    end
""" [Soares2004](@cite) """
Soares_u(::Type{FT}) where {FT} = z -> FT(0.01)

""" [Soares2004](@cite) """
Soares_tke(::Type{FT}) where {FT} = z -> if z <= 1600.0
        FT(0.1) * FT(1.46) * FT(1.46) * (1 - z / 1600)
    else
        FT(0)
    end
