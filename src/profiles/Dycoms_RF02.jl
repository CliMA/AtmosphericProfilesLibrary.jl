""" [Ackerman2009](@cite) """
Dycoms_RF02_q_tot(::Type{FT}) where {FT} = z -> if z <= 840.0
        FT(9.45) / FT(1000.0)
    else
        (FT(5) - FT(3) * (FT(1) - exp(-(z - FT(795)) / FT(500)))) / FT(1000)
    end

""" [Ackerman2009](@cite) """
Dycoms_RF02_θ_liq_ice(::Type{FT}) where {FT} = z -> if z <= 795.0
        FT(288.3)
    else
        FT(295.0) + (z - FT(795))^FT(1.0 / 3.0)
    end

""" [Ackerman2009](@cite) """
Dycoms_RF02_u0(::Type{FT}) where {FT} = z -> FT(5)

""" [Ackerman2009](@cite) """
Dycoms_RF02_v0(::Type{FT}) where {FT} = z -> FT(-5.5)

""" [Ackerman2009](@cite) """
function Dycoms_RF02_u(::Type{FT}) where {FT}
    u0 = Dycoms_RF02_u0(FT)
    return z -> FT(3) + FT(4.3) * z / FT(1000) - u0(z)
end

""" [Ackerman2009](@cite) """
function Dycoms_RF02_v(::Type{FT}) where {FT}
    v0 = Dycoms_RF02_v0(FT)
    return z -> FT(-9) + FT(5.6) * z / FT(1000) - v0(z)
end

""" [Ackerman2009](@cite) """
Dycoms_RF02_tke(::Type{FT}) where {FT} = z -> if z <= 795.0
        FT(1) - z / FT(1000)
    else
        FT(0)
    end
