# 3937m: base of initial inversion
# [TODO]m: nominal domain top
# Replicating profiles from pithan_2016, building on Curry 1986.

# Place inside functions below or remove vars and keep all numerical?
import Thermodynamics as TD
import ClimaParams as CP
import Thermodynamics.Parameters as TP
FT = Float32
params = TP.ThermodynamicsParameters(FT)

const γ = FT(8E-3) # K/m
const z_600hpa = FT(3937.0)
const z_300hpa = FT(8457.61398053927)
const P_0 = FT(101300.0)
const T_0 = FT(273.0)                # K  (Surface temperature)
const T_300hpa = FT(T_0 - γ*(z_300hpa))          # K (Temperature at 300 hPa       # Atmospheric lapse rate
const α = FT(0.2340468909276249)    # Rγ/g
const g = FT(9.81)
const R = FT(287.0) # J/kg/K
hPa = FT(100.0)
#ps = [1013, 600, 300].*hPa
#zs = [0.0, 3936.83, 8457.61]

# Temperature
""" [pithan_2016]@cite """
function Larcform1_T(::Type{FT}) where {FT}
    z -> FT(if z ≤ z_300hpa # surface to 600hpa
        T_0 - γ*z # K 
    else
        T_300hpa       # T_300hpa # K
    end)               # kg/kg
end

# Pressure
""" [pithan_2016]@cite """
function Larcform1_p(::Type{FT}) where {FT}
    z -> FT(if z ≤ z_300hpa                 # surface to 300hpa
        P_0*(1-γ/T_0*z)^(1/α)
    else                                    # 300hpa to model top
        FT(300.E2)*exp(-g/(R*T_300hpa)*(z-z_300hpa))
    end)
end

""" [pithan_2016]@cite
Gives the height z corresponding to a given pressure p (Pa) in the Larcform1 profile.

"""
function Larcform1_z(::Type{FT}) where {FT}
    p -> FT(if p ≥ T(300hPa)
        return T_0/γ*(FT(1.0)-(p/P_0)^α)
    elseif p<FT(300hPa) && p≥FT(0)
        return T_0/γ*(1-(300/1013)^α) - R*T_300hpa/g*log(p/300.E2) # first term is z_300
    else
        throw(DomainError(p, "Argument must be a non-negative real number"))
    end)
end

"""
RH profile for Larcform1 up to 300hPa. 
    
Used to construct full thermodynamic state lin `conbined_thermo_state`.

"""
function Larcform1_RH_sfcto300hpa(::Type{FT}) where {FT}
    p_in = FT[0hPa, 600.0hPa, 1013.0hPa]
    RH_in = FT[0.2, 0.2, 0.8]
    prof = linear_interp(p_in, RH_in)
    ZProfile(prof ∘ Larcform1_z(FT))
end

# Construct thermodynamic state for all z in domain
p = Larcform1_p(FT)
T = Larcform1_T(FT)

RH_sfcto300hpa(z) = Larcform1_RH_sfcto300hpa(FT)(p.(z))

function combined_thermo_state(z)
    q_top = FT(3E-6) # defined above z_threshold 
    q_tot(z) = TD.q_vap_from_RH_liquid(params, p(z), T(z), RH_sfcto300hpa(p.(z)))
    #z > z_300hpa ? TD.PhaseEquil_pTq(params, p(z), T(z), q) :  TD.PhaseEquil_pTRH(params, p(z), T(z), RH(z))
    z ≤ z_300hpa ? TD.PhaseEquil_pTq(params, p(z), T(z), q_tot(z)) :
    TD.PhaseEquil_pTq(params, p(z), T(z), q_top)
end

""" [pithan_2016]@cite """
function Larcform1_q_tot(::Type{FT}) where {FT}
    ts(z) = combined_thermo_state(z)
    ZProfile(z -> FT(TD.total_specific_humidity(params, ts(z))))
end

""" [pithan_2016]@cite """
function Larcform1_RH(::Type{FT}) where {FT}
    ts(z) = combined_thermo_state(z)
    ZProfile(z -> FT(TD.relative_humidity(params, ts(z))))
end

# Geostrophic wind
""" [pithan_2016]@cite """
function Larcform1_geostrophic_u(::Type{FT}) where {FT}
    z -> FT(if z ≤ z_300hpa
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
