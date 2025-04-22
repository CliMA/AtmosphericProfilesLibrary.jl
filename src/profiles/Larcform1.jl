# 3937m: base of initial inversion
# [TODO]m: nominal domain top
# Replicating profiles from pithan_2016, building on Curry 1986.

# Place inside functions below or remove vars and keep all numerical?
import Thermodynamics as TD
import ClimaParams as CP
import Thermodynamics.Parameters as TP
FT = Float64
params = TP.ThermodynamicsParameters(FT)

FT = Float64
const z_inversion = FT(3937.)   
const z_300hpa = FT(8458.)
const P_0 = FT(101300.)
const T_0 = FT(273.)                # K  (Surface temperature)
const T_300hpa = FT(273.0 - 8E-3*(z_300hpa))          # K (Temperature at 300 hPa)
const γ = FT(8E-3) # K/m            # Atmospheric lapse rate
const α = FT(0.2340468909276249)    # Rγ/g
const g = FT(9.81)
const R = FT(287.) # J/kg/K

# Temperature
""" [pithan_2016]@cite """
function Larcform1_T(::Type{FT}) where {FT}
    z -> FT(
    if z ≤ z_inversion # surface to 600hpa
        T_0 - γ*z # K 
    else
        T_300hpa       # T_300hpa # K
    end)               # kg/kg
end

# Pressure
""" [pithan_2016]@cite """
function Larcform1_P(::Type{FT}) where {FT}
    z -> FT(
    if z ≤ z_300hpa                    # surface to 300hpa
        P_0*(1-γ/T_0*z)^(1/α)
    else                           # 300hpa to model top
        FT(300.E2)*exp(-g/(R*T_300hpa)*(z-z_300hpa)) 
    end)  
end

""" [pithan_2016]@cite """
function Larcform1_z(::Type{FT}) where {FT}
    P -> FT(
    if P≥FT(300.E2)
        return T_0/γ * (FT(1.)-(P/P_0)^α)
    elseif P<FT(300.E2) && P≥FT(0)
        return T_0/γ*(1-(300/1013)^α) - R*T_300hpa/g*log(P/300.E2) # first term is z_300
    else
        throw(DomainError(P, "Argument must be a non-negative real number"))
    end)        
end

"""
RH profile for Larcform1

Only valid for z on {0, z_inversion}
"""
function Larcform1_RH(::Type{FT}) where {FT}
    z = Larcform1_z(FT)
    z_in = z.(FT(100.) .* FT[1013., 600., 300., 100.])
    RH_in = FT[0.8, 0.2, 0.2, 0.2]
    return ZProfile(linear_interp(z_in, RH_in))
end

# Construct thermodynamic state for all z in domain
p = Larcform1_P(FT)
T = Larcform1_T(FT)
RH = Larcform1_RH(FT)
q = FT(3E-6) # defined above z_threshold

function combined_thermo_state(z)
    q_top = FT(3E-6) # defined above z_threshold 
    z > z_300hpa ? 
    TD.PhaseEquil_pTq(params, p(z), T(z), q) : 
    TD.PhaseEquil_pTRH(params, p(z), T(z), RH(z))
end

""" [pithan_2016]@cite """
function Larcform1_q_tot(::Type{FT}) where {FT}
    ts(z) = combined_thermo_state(z)
    ZProfile(z -> FT(
    TD.total_specific_humidity(params, ts(z)))
    )
end

# Geostrophic wind
""" [pithan_2016]@cite """
function Larcform1_geostrophic_u(::Type{FT}) where {FT}
    z -> FT(
    if z ≤ z_300hpa
        5
    else
        0
    end)
end

# Geostrophic wind
""" [pithan_2016]@cite """
function Larcform1_geostrophic_v(::Type{FT}) where {FT}
    z -> FT(0)
end