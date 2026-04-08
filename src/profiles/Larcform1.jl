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
    p -> FT(if p ≥ FT(300hPa)
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

""" [pithan_2016]@cite """
function Larcform1_q_tot(::Type{FT}) where {FT}
    # Capture all needed quantities as typed locals so Julia can infer the
    # closure return type (non-const module globals are type-unstable).
    p_prof    = Larcform1_p(FT)
    T_prof    = Larcform1_T(FT)
    params_FT = TP.ThermodynamicsParameters(FT)
    q_top     = FT(3E-6)
    z_top     = FT(z_300hpa)
    p_sfc     = FT(101300)  # surface pressure (Pa)
    p_600hpa  = FT(60000)   # 600 hPa (Pa)
    RH_sfc    = FT(0.8)     # RH at surface (Pithan 2016)
    RH_free   = FT(0.2)     # RH at/above 600 hPa (Pithan 2016)
    ZProfile(z -> begin
        if z ≤ z_top
            p_z = p_prof(z)
            T_z = T_prof(z)
            # Linear RH profile in pressure from 0.8 at surface to 0.2 at 600 hPa
            RH = clamp(
                RH_free + (RH_sfc - RH_free) * (p_z - p_600hpa) / (p_sfc - p_600hpa),
                RH_free, RH_sfc,
            )
            # q_vap from RH over liquid (inlined for type stability)
            p_vap_sat   = TD.saturation_vapor_pressure(params_FT, T_z, TD.Liquid())
            p_vap       = RH * p_vap_sat
            Rv_over_Rd  = TP.Rv_over_Rd(params_FT)
            p_vap / Rv_over_Rd / (p_z - (1 - 1 / Rv_over_Rd) * p_vap)
        else
            q_top
        end
    end)
end

""" [pithan_2016]@cite """
function Larcform1_RH(::Type{FT}) where {FT}
    p_prof    = Larcform1_p(FT)
    T_prof    = Larcform1_T(FT)
    params_FT = TP.ThermodynamicsParameters(FT)
    z_top     = FT(z_300hpa)
    ZProfile(z -> begin
        q_tot = Larcform1_q_tot(FT)(z)
        if z ≤ z_top
            TD.relative_humidity(params_FT, T_prof(z), p_prof(z), q_tot, FT(0), FT(0))
        else
            FT(0.2)
        end
    end)
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
