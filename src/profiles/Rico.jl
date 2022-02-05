""" :( """
function Rico_geostrophic_ug(::Type{FT}) where {FT}
    return z -> FT(-9.9) + FT(2.0e-3) * z
end
""" :( """
function Rico_geostrophic_vg(::Type{FT}) where {FT}
    return z -> FT(-3.8)
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
