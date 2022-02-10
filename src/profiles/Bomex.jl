""" [Siebesma2003](@cite) """
Bomex_θ_liq_ice(::Type{FT}) where {FT} = z -> if z <= 520.0
        FT(298.7)
    elseif z > 520.0 && z <= 1480.0
        FT(298.7) + (z - 520) * (FT(302.4) - FT(298.7)) / (1480 - 520)
    elseif z > 1480.0 && z <= 2000
        FT(302.4) + (z - 1480) * (FT(308.2) - FT(302.4)) / (2000 - 1480)
    elseif z > 2000.0
        FT(308.2) + (z - 2000) * (FT(311.85) - FT(308.2)) / (3000 - 2000)
    else
        FT(0)
    end
""" [Siebesma2003](@cite) """
Bomex_q_tot(::Type{FT}) where {FT} = z -> if z <= 520
        (FT(17.0) + z * (FT(16.3) - 17) / 520) / 1000
    elseif z > 520.0 && z <= 1480.0
        (FT(16.3) + (z - 520) * (FT(10.7) - FT(16.3)) / (1480 - 520)) / 1000
    elseif z > 1480.0 && z <= 2000.0
        (FT(10.7) + (z - 1480) * (FT(4.2) - FT(10.7)) / (2000 - 1480)) / 1000
    elseif z > 2000.0
        (FT(4.2) + (z - 2000) * (3 - FT(4.2)) / (3000 - 2000)) / 1000
    end
""" [Siebesma2003](@cite) """
Bomex_u(::Type{FT}) where {FT} = z -> if z <= 700.0
        FT(-8.75)
    elseif z > 700.0
        FT(-8.75) + (z - 700) * (FT(-4.61) - FT(-8.75)) / (3000 - 700)
    end
""" [Siebesma2003](@cite) """
Bomex_tke(::Type{FT}) where {FT} = z -> if (z <= 2500.0)
        FT(1) - z / 3000
    else
        FT(0)
    end

# Geostrophic velocity profiles
""" :( """
Bomex_geostrophic_u(::Type{FT}) where {FT} = z -> -10 + FT(1.8e-3) * z
""" :( """
Bomex_geostrophic_v(::Type{FT}) where {FT} = z -> FT(0)

""" dTdt(Π, z) """
Bomex_dTdt(::Type{FT}) where {FT} = (Π, z) -> if z <= 1500.0
        (-2 / (3600 * 24)) * Π
    else
        (-2 / (3600 * 24) + (z - 1500) * (0 - -2 / (3600 * 24)) / (3000 - 1500)) * Π
    end

# Large-scale drying
""" :( """
Bomex_dqtdt(::Type{FT}) where {FT} = z -> if z <= 300.0
        FT(-1.2e-8)   #kg/(kg * s)
    elseif z > 300.0 && z <= 500.0
        FT(-1.2e-8) + (z - 300) * (0 - FT(-1.2e-8)) / (500 - 300) #kg/(kg * s)
    else
        FT(0)
    end

# Large scale subsidence
""" :( """
Bomex_subsidence(::Type{FT}) where {FT} = z -> if z <= 1500.0
        FT(0) + z * (FT(-0.65) / 100 - 0) / (1500 - 0)
    elseif z > 1500.0 && z <= 2100.0
        FT(-0.65) / 100 + (z - 1500) * (0 - FT(-0.65) / 100) / (2100 - 1500)
    else
        FT(0)
    end
