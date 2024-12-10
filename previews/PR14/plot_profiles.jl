import AtmosphericProfilesLibrary
const APL = AtmosphericProfilesLibrary

function units(var::String)
    var == "θ_liq_ice" && return "[K]"
    var == "T" && return "[K]"
    var == "p" && return "[kPa]"
    var == "q_tot" && return "[kg/kg]"
    var == "u" && return "[m/s]"
    var == "v" && return "[m/s]"
    var == "tke" && return "[m^2/s^2]"
    var == "dTdt" && return "[K/s]"
    var == "dqtdt" && return "[kg/(kg s)]"
    var == "RH" && return "[%?]"
    var == "subsidence" && return "[?]"
    error("No units found for variable $var")
end

include("define_save_plots.jl")

const z_range = range(0, stop = 2.5e4, length = 100);
const t_range = range(0, stop = 4e4, length = 100);

#####
##### z-t profiles
#####
tz_profiles = [
    (; func = APL.TRMM_LBA_radiation, kwargs = (; z_range, t_range)),
]

#####
##### z profiles
#####
z_profiles = [
    (; func = APL.Soares_q_tot         , kwargs = (;z_range, xlabel = "q_tot")),
    (; func = APL.Soares_θ_liq_ice     , kwargs = (;z_range, xlabel = "θ_liq_ice")),
    (; func = APL.Soares_u             , kwargs = (;z_range, xlabel = "u")),
    (; func = APL.Soares_tke           , kwargs = (;z_range, xlabel = "tke")),
    (; func = APL.Nieuwstadt_θ_liq_ice , kwargs = (;z_range, xlabel = "θ_liq_ice")),
    (; func = APL.Nieuwstadt_u         , kwargs = (;z_range, xlabel = "u")),
    (; func = APL.Nieuwstadt_tke       , kwargs = (;z_range, xlabel = "tke")),
    (; func = APL.Bomex_q_tot          , kwargs = (;z_range, xlabel = "q_tot")),
    (; func = APL.Bomex_θ_liq_ice      , kwargs = (;z_range, xlabel = "θ_liq_ice")),
    (; func = APL.Bomex_u              , kwargs = (;z_range, xlabel = "u")),
    (; func = APL.Bomex_tke            , kwargs = (;z_range, xlabel = "tke")),
    (; func = APL.Bomex_geostrophic_u  , kwargs = (;z_range, xlabel = "u")),
    (; func = APL.Bomex_geostrophic_v  , kwargs = (;z_range, xlabel = "v")),
    # (; func = APL.Bomex_dTdt           , kwargs = (;z_range, xlabel = "dTdt")), # depends on Π
    (; func = APL.Bomex_dqtdt          , kwargs = (;z_range, xlabel = "dqtdt")),
    (; func = APL.Bomex_subsidence     , kwargs = (;z_range, xlabel = "subsidence")),

    (; func = APL.LifeCycleTan2018_θ_liq_ice  , kwargs = (;z_range, xlabel = "θ_liq_ice")),
    (; func = APL.LifeCycleTan2018_q_tot      , kwargs = (;z_range, xlabel = "q_tot")),
    (; func = APL.LifeCycleTan2018_u          , kwargs = (;z_range, xlabel = "u")),
    (; func = APL.LifeCycleTan2018_tke        , kwargs = (;z_range, xlabel = "tke")),
    # (; func = APL.LifeCycleTan2018_dTdt       , kwargs = (;z_range, xlabel = "dTdt")), # depends on Π
    (; func = APL.LifeCycleTan2018_dqtdt      , kwargs = (;z_range, xlabel = "dqtdt")),
    (; func = APL.LifeCycleTan2018_subsidence , kwargs = (;z_range, xlabel = "subsidence")),

    (; func = APL.Rico_θ_liq_ice       , kwargs = (;z_range, xlabel = "θ_liq_ice")),
    (; func = APL.Rico_q_tot           , kwargs = (;z_range, xlabel = "q_tot")),
    (; func = APL.Rico_geostrophic_ug  , kwargs = (;z_range, xlabel = "u")),
    (; func = APL.Rico_geostrophic_vg  , kwargs = (;z_range, xlabel = "v")),
    (; func = APL.Rico_dqtdt           , kwargs = (;z_range, xlabel = "dqtdt")),
    (; func = APL.Rico_subsidence      , kwargs = (;z_range, xlabel = "v")),

    (; func = APL.TRMM_LBA_p_in        , kwargs = (;z_range, xlabel = "p")),
    (; func = APL.TRMM_LBA_T_in        , kwargs = (;z_range, xlabel = "T")),
    (; func = APL.TRMM_LBA_RH_in       , kwargs = (;z_range, xlabel = "RH")),
    (; func = APL.TRMM_LBA_u_in        , kwargs = (;z_range, xlabel = "u")),
    (; func = APL.TRMM_LBA_v_in        , kwargs = (;z_range, xlabel = "v")),

    (; func = APL.ARM_SGP_θ_liq_ice    , kwargs = (;z_range, xlabel = "θ_liq_ice")),
    (; func = APL.ARM_SGP_q_tot        , kwargs = (;z_range, xlabel = "q_tot")),
    (; func = APL.ARM_SGP_tke          , kwargs = (;z_range, xlabel = "tke")),

    (; func = APL.GATE_III_q_tot       , kwargs = (;z_range, xlabel = "q_tot")),
    (; func = APL.GATE_III_u           , kwargs = (;z_range, xlabel = "u")),
    (; func = APL.GATE_III_T           , kwargs = (;z_range, xlabel = "T")),
    (; func = APL.GATE_III_tke         , kwargs = (;z_range, xlabel = "tke")),

    (; func = APL.DryBubble_θ          , kwargs = (;z_range, xlabel = "θ_liq_ice")),
]

#####
##### t profiles
#####
t_profiles = []

for profile in t_profiles
    # We don't have t-profiles yet.
    # @info "Saving t-profile $(nameof(profile.func))" # for debugging
    # save_t_profile(profile.func; profile.kwargs...)
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