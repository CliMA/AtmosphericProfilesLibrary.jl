import AtmosphericProfilesLibrary
const APL = AtmosphericProfilesLibrary

function units(var::String)
    var == "θ_liq_ice" && return "[K]"
    var == "T" && return "[K]"
    var == "p" && return "[kPa]"
    var == "q_tot" && return "[kg/kg]"
    var == "u" && return "[m/s]"
    var == "v" && return "[m/s]"
    var == "ug" && return "[m/s]"
    var == "vg" && return "[m/s]"
    var == "u0" && return "[m/s]"
    var == "v0" && return "[m/s]"
    var == "shf" && return "[W/m^2]"
    var == "lhf" && return "[W/m^2]"
    var == "tke" && return "[m^2/s^2]"
    var == "dTdt" && return "[K/s]"
    var == "dqtdt" && return "[kg/(kg s)]"
    var == "area" && return "[1]"
    var == "w" && return "[m/s]"
    var == "RH" && return "[%?]"
    var == "subsidence" && return "[?]"
    error("No units found for variable $var")
end

include("define_save_plots.jl")

const zr_hi = range(0, stop = 2.5e4, length = 100);
const zr_lo = range(0, stop = 4000.0, length = 100);
const t_range = range(0, stop = 3600*15, length = 200);

#####
##### z-t profiles
#####
tz_profiles = [
    (; func = APL.TRMM_LBA_radiation, kwargs = (;z_range = zr_hi, t_range, label = "radiation")),
    (; func = APL.ARM_SGP_dTdt      , kwargs = (;z_range = zr_lo, t_range, label = "dTdt", units = "[K/s]")),
]

#####
##### z profiles
#####
z_profiles = [
    (; func = APL.Soares_q_tot         , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.Soares_θ_liq_ice     , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.Soares_u             , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.Soares_tke           , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.Soares_tke_prescribed, kwargs = (;z_range = zr_lo, xlabel = "tke")),

    (; func = APL.Nieuwstadt_θ_liq_ice     , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.Nieuwstadt_u             , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.Nieuwstadt_tke           , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.Nieuwstadt_tke_prescribed, kwargs = (;z_range = zr_lo, xlabel = "tke")),

    (; func = APL.Bomex_q_tot          , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.Bomex_θ_liq_ice      , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.Bomex_u              , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.Bomex_tke            , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.Bomex_tke_prescribed , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.Bomex_geostrophic_u  , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.Bomex_geostrophic_v  , kwargs = (;z_range = zr_lo, xlabel = "v")),
    # (; func = APL.Bomex_dTdt           , kwargs = (;z_range = zr_lo, xlabel = "dTdt")), # Callable by (Π, z)
    (; func = APL.Bomex_dqtdt          , kwargs = (;z_range = zr_lo, xlabel = "dqtdt")),
    (; func = APL.Bomex_subsidence     , kwargs = (;z_range = zr_lo, xlabel = "subsidence")),

    (; func = APL.LifeCycleTan2018_θ_liq_ice  , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.LifeCycleTan2018_q_tot      , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.LifeCycleTan2018_u          , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.LifeCycleTan2018_tke        , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.LifeCycleTan2018_tke_prescribed, kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.LifeCycleTan2018_geostrophic_u,  kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.LifeCycleTan2018_geostrophic_v,  kwargs = (;z_range = zr_lo, xlabel = "v")),
    # (; func = APL.LifeCycleTan2018_dTdt       , kwargs = (;z_range = zr_lo, xlabel = "dTdt")), # callable by (Π, z)
    (; func = APL.LifeCycleTan2018_dqtdt      , kwargs = (;z_range = zr_lo, xlabel = "dqtdt")),
    (; func = APL.LifeCycleTan2018_subsidence , kwargs = (;z_range = zr_lo, xlabel = "subsidence")),

    (; func = APL.Rico_u               , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.Rico_v               , kwargs = (;z_range = zr_lo, xlabel = "v")),
    (; func = APL.Rico_θ_liq_ice       , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.Rico_q_tot           , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.Rico_geostrophic_ug  , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.Rico_geostrophic_vg  , kwargs = (;z_range = zr_lo, xlabel = "v")),
    # (; func = APL.Rico_dTdt            , kwargs = (;z_range = zr_lo, xlabel = "dTdt")), # callable by (Π, z)
    (; func = APL.Rico_dqtdt           , kwargs = (;z_range = zr_lo, xlabel = "dqtdt")),
    (; func = APL.Rico_subsidence      , kwargs = (;z_range = zr_lo, xlabel = "v")),
    (; func = APL.Rico_tke_prescribed  , kwargs = (;z_range = zr_lo, xlabel = "tke")),

    (; func = APL.TRMM_LBA_p             , kwargs = (;z_range = zr_hi, xlabel = "p")),
    (; func = APL.TRMM_LBA_T             , kwargs = (;z_range = zr_hi, xlabel = "T")),
    (; func = APL.TRMM_LBA_RH            , kwargs = (;z_range = zr_hi, xlabel = "RH")),
    (; func = APL.TRMM_LBA_u             , kwargs = (;z_range = zr_hi, xlabel = "u")),
    (; func = APL.TRMM_LBA_v             , kwargs = (;z_range = zr_hi, xlabel = "v")),
    (; func = APL.TRMM_LBA_tke           , kwargs = (;z_range = zr_hi, xlabel = "tke")),
    (; func = APL.TRMM_LBA_tke_prescribed, kwargs = (;z_range = zr_hi, xlabel = "tke")),

    (; func = APL.ARM_SGP_u              , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.ARM_SGP_θ_liq_ice      , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.ARM_SGP_q_tot          , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.ARM_SGP_tke            , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.ARM_SGP_tke_prescribed , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    # (; func = APL.ARM_SGP_dqtdt        , kwargs = (;z_range = zr_lo, xlabel = "dqdt")), # callable by `(Π, t, z)`

    (; func = APL.GATE_III_q_tot       , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.GATE_III_u           , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.GATE_III_T           , kwargs = (;z_range = zr_lo, xlabel = "T")),
    (; func = APL.GATE_III_tke         , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.GATE_III_dqtdt       , kwargs = (;z_range = zr_lo, xlabel = "dqtdt")),
    (; func = APL.GATE_III_dTdt        , kwargs = (;z_range = zr_lo, xlabel = "dTdt")),

    (; func = APL.Dycoms_RF01_θ_liq_ice     , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.Dycoms_RF01_q_tot         , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.Dycoms_RF01_u0            , kwargs = (;z_range = zr_lo, xlabel = "u0")),
    (; func = APL.Dycoms_RF01_v0            , kwargs = (;z_range = zr_lo, xlabel = "v0")),
    (; func = APL.Dycoms_RF01_tke           , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.Dycoms_RF01_tke_prescribed, kwargs = (;z_range = zr_lo, xlabel = "tke")),

    (; func = APL.Dycoms_RF02_θ_liq_ice  , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.Dycoms_RF02_q_tot      , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.Dycoms_RF02_u          , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.Dycoms_RF02_v          , kwargs = (;z_range = zr_lo, xlabel = "v")),
    (; func = APL.Dycoms_RF02_tke        , kwargs = (;z_range = zr_lo, xlabel = "tke")),

    (; func = APL.GABLS_u              , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.GABLS_v              , kwargs = (;z_range = zr_lo, xlabel = "v")),
    (; func = APL.GABLS_θ_liq_ice      , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.GABLS_q_tot          , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.GABLS_tke            , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.GABLS_tke_prescribed , kwargs = (;z_range = zr_lo, xlabel = "tke")),
    (; func = APL.GABLS_geostrophic_ug , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.GABLS_geostrophic_vg , kwargs = (;z_range = zr_lo, xlabel = "v")),

    (; func = APL.SP_u                 , kwargs = (;z_range = zr_lo, xlabel = "u")),
    (; func = APL.SP_v                 , kwargs = (;z_range = zr_lo, xlabel = "v")),
    (; func = APL.SP_θ_liq_ice         , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.SP_q_tot             , kwargs = (;z_range = zr_lo, xlabel = "q_tot")),
    (; func = APL.SP_geostrophic_u     , kwargs = (;z_range = zr_lo, xlabel = "ug")),
    (; func = APL.SP_geostrophic_v     , kwargs = (;z_range = zr_lo, xlabel = "vg")),

    (; func = APL.DryBubble_θ_liq_ice          , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.DryBubble_updrafts_θ_liq_ice , kwargs = (;z_range = zr_lo, xlabel = "θ_liq_ice")),
    (; func = APL.DryBubble_updrafts_area      , kwargs = (;z_range = zr_lo, xlabel = "area")),
    (; func = APL.DryBubble_updrafts_w         , kwargs = (;z_range = zr_lo, xlabel = "w")),
    (; func = APL.DryBubble_updrafts_T         , kwargs = (;z_range = zr_lo, xlabel = "T")),


]

#####
##### t profiles
#####
t_profiles = [
    (; func = APL.ARM_SGP_shf         , kwargs = (;t_range, label = "shf")),
    (; func = APL.ARM_SGP_lhf         , kwargs = (;t_range, label = "lhf")),
]

for profile in t_profiles
    # We don't have t-profiles yet.
    # @info "Saving t-profile $(nameof(profile.func))" # for debugging
    save_t_profile(profile.func; profile.kwargs...)
end
for profile in tz_profiles
    # @info "Saving tz-profile $(nameof(profile.func))" # for debugging
    save_tz_profile(profile.func; profile.kwargs...)
end
for profile in z_profiles
    # @info "Saving z-profile $(nameof(profile.func))" # for debugging
    save_z_profile(profile.func; profile.kwargs...)
end

nothing
