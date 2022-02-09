""" :( """
function Rico_geostrophic_ug(::Type{FT}) where {FT}
    return z -> FT(-9.9) + FT(2.0e-3) * z
end
""" :( """
function Rico_geostrophic_vg(::Type{FT}) where {FT}
    return z -> FT(-3.8)
end

""" :( """
Rico_θ_liq_ice(::Type{FT}) where {FT} =
    z -> if z <= 740.0
        FT(297.9)
    else
        FT(297.9) + (317 - FT(297.9)) / (4000 - 740) * (z - 740)
    end

""" :( """
Rico_q_tot(::Type{FT}) where {FT} =
    z -> if z <= 740.0
        (16 + (FT(13.8) - 16) / 740 * z) / 1000
    elseif z > 740.0 && z <= 3260.0
        (FT(13.8) + (FT(2.4) - FT(13.8)) / (3260 - 740) * (z - 740)) / 1000
    else
        (FT(2.4) + (FT(1.8) - FT(2.4)) / (4000 - 3260) * (z - 3260)) / 1000
    end

""" :( """
function Rico_dqtdt(::Type{FT}) where {FT}
    return z -> if z <= 2980.0
        (-1 + FT(1.3456) / FT(2980.0) * z) / FT(86400.0) / 1000   #kg/(kg * s)
    else
        FT(0.3456) / 86400 / 1000
    end
end
""" :( """
function Rico_subsidence(::Type{FT}) where {FT}
    return z -> if z <= 2260.0
            -(FT(0.005) / FT(2260.0)) * z
        else
            FT(-0.005)
        end
end
