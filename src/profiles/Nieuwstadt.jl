""" [Nieuwstadt1993](@cite) """
Nieuwstadt_θ_liq_ice(::Type{FT}) where {FT} = z -> if z <= 1350.0
        FT(300)
    else
        FT(300) + 3 * (z - 1350) / 1000
    end

""" [Nieuwstadt1993](@cite) """
Nieuwstadt_u(::Type{FT}) where {FT} = z -> FT(0.01)

""" [Nieuwstadt1993](@cite) """
Nieuwstadt_tke(::Type{FT}) where {FT} = z -> if (z <= 1600.0)
        FT(0.1) * FT(1.46) * FT(1.46) * (1 - z / 1600)
    else
        FT(0)
    end
