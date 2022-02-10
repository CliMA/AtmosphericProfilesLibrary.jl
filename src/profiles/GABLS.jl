""" :( """
GABLS_u(::Type{FT}) where {FT} = z -> FT(8.0)
""" :( """
GABLS_v(::Type{FT}) where {FT} = z -> FT(0.0)

""" :( """
GABLS_θ_liq_ice(::Type{FT}) where {FT} =
    z -> if z <= 100.0
        FT(265)
    else
        FT(265) + (z - 100) * FT(0.01)
    end

""" :( """
GABLS_q_tot(::Type{FT}) where {FT} = z -> FT(0)

""" :( """
GABLS_tke(::Type{FT}) where {FT} =
    z -> if z <= 250.0
        FT(0.4) * (1 - z / 250) * (1 - z / 250) * (1 - z / 250)
    else
        FT(0)
    end

""" :( """
GABLS_geostrophic_ug(::Type{FT}) where {FT} = z -> FT(8)
""" :( """
GABLS_geostrophic_vg(::Type{FT}) where {FT} = z -> FT(0)
