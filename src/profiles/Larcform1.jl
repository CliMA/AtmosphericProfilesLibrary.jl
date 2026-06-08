# Values are derived from Pithan 2016 and following assumptions:
# 1) atmospheric instantiated in hydrostatic balance
# 2) atmospheric is well described as an ideal gas
# 3) surface pressure is 1013hPa

module Larcform1_constants
    # Given constants — Pithan 2016, Table 1 and footnote a
    const γ            = 8e-3      # lapse rate (K/m)
    const T_0          = 273.0     # near-surface air temperature (K)
    const P_0          = 101300.0  # surface pressure (Pa)
    const R            = 287.0     # gas constant for air (J/kg/K)
    const g            = 9.81      # gravitational acceleration (m/s²)
    const P_tropopause = 30000.0   # tropopause pressure, 300 hPa (Pa)
    const q_top        = 3e-6      # specific humidity above tropopause (kg/kg)

    # Derived constants
    const α            = R * γ / g  # exponent in hypsometric equation (Rγ/g)
    const z_tropopause = (T_0 / γ) * (1 - (P_tropopause / P_0)^α)   # hyposmetric equation for tropopause height (m)
    const T_tropopause = T_0 - γ * z_tropopause                     # tropopause temperature (K)
end
import .Larcform1_constants as LC

""" [Pithan2016](@cite) """
Larcform1_T(::Type{FT}) where {FT} = ZProfile(z -> if z ≤ LC.z_tropopause
    FT(LC.T_0) - FT(LC.γ) * z
else
    FT(LC.T_tropopause)
end)

""" [Pithan2016](@cite) """
Larcform1_p(::Type{FT}) where {FT} = ZProfile(z -> if z ≤ LC.z_tropopause
    FT(LC.P_0) * (1 - LC.γ / LC.T_0 * z)^(1 / LC.α)
else
    FT(LC.P_tropopause) * exp(-LC.g / (LC.R * LC.T_tropopause) * (z - LC.z_tropopause))
end)

""" [Pithan2016](@cite) """
Larcform1_geostrophic_u(::Type{FT}) where {FT} = ZProfile(z ->
    z ≤ LC.z_tropopause ? FT(5) : FT(0))

""" [Pithan2016](@cite) """
Larcform1_geostrophic_v(::Type{FT}) where {FT} = ZProfile(z -> FT(0))

""" [Pithan2016](@cite) """
function Larcform1_RH(::Type{FT}) where {FT}
    rh_of_p = linear_interp(FT[0, 60000, LC.P_0], FT[0.2, 0.2, 0.8])
    ZProfile(rh_of_p ∘ Larcform1_p(FT))
end