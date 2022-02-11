""" [Stevens2005](@cite) """
Dycoms_RF01_q_tot(::Type{FT}) where {FT} = z -> if z <= 840.0
        FT(9.0) / FT(1000.0)
    else
        FT(1.5) / FT(1000.0)
    end

""" [Stevens2005](@cite) """
Dycoms_RF01_θ_liq_ice(::Type{FT}) where {FT} = z -> if z <= 840.0
        FT(289)
    else
        FT(297.5) + (z - FT(840))^FT(1.0 / 3.0)
    end

""" [Stevens2005](@cite) """
Dycoms_RF01_u0(::Type{FT}) where {FT} = z -> FT(7)

""" [Stevens2005](@cite) """
Dycoms_RF01_v0(::Type{FT}) where {FT} = z -> FT(-5.5)

""" [Stevens2005](@cite) """
Dycoms_RF01_tke(::Type{FT}) where {FT} = z -> if z <= 800.0
        FT(1) - z / FT(1000)
    else
        FT(0)
    end
