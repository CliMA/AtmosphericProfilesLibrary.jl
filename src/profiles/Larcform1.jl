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
    end)               # K
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
    
Used to construct full thermodynamic state in `combined_thermo_state`.

"""
function Larcform1_RH_sfcto300hpa(::Type{FT}) where {FT}
    p_in = FT[0hPa, 600.0hPa, 1013.0hPa]
    RH_in = FT[0.2, 0.2, 0.8]
    prof = linear_interp(p_in, RH_in)
    ZProfile(prof ∘ Larcform1_p(FT))
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
    RH_prof   = Larcform1_RH_sfcto300hpa(FT)  # z → RH (fixed: uses Larcform1_p(FT))
    params_FT = TP.ThermodynamicsParameters(FT)
    q_top     = FT(3E-6)
    z_top     = FT(z_300hpa)
    ZProfile(z -> begin
        if z ≤ z_top
            p_z = p_prof(z)
            T_z = T_prof(z)
            RH  = RH_prof(z)  # pass height z directly (Bug 3 fix)
            # q_vap from RH over liquid (inlined for type stability)
            p_vap_sat  = TD.saturation_vapor_pressure(params_FT, T_z, TD.Liquid())
            p_vap      = RH * p_vap_sat
            Rv_over_Rd = TP.Rv_over_Rd(params_FT)
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
        if z ≤ z_top
            p_z  = p_prof(z)
            T_z  = T_prof(z)
            q_tot = Larcform1_q_tot(FT)(z)
            # Invert q_tot → p_vap using the exact specific-humidity formula,
            # then divide by liquid saturation pressure to match Larcform1_q_tot
            # (which defines q_tot from RH-over-liquid). Using mixed/ice saturation
            # here would inflate RH at arctic temperatures (T << 273 K).
            Rv_over_Rd = TP.Rv_over_Rd(params_FT)
            ε          = 1 / Rv_over_Rd        # Rd/Rv ≈ 0.622
            p_vap      = q_tot * p_z / (ε + q_tot * (1 - ε))
            p_vap_sat  = TD.saturation_vapor_pressure(params_FT, T_z, TD.Liquid())
            p_vap / p_vap_sat
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
