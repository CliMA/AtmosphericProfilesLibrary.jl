import AtmosphericProfilesLibrary
const APL = AtmosphericProfilesLibrary

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
    (; func = APL.Soares_q_tot        , kwargs = (;z_range, xlabel = "q_tot [1]")),
    (; func = APL.Soares_θ_liq_ice    , kwargs = (;z_range, xlabel = "θ_liq_ice [K]")),
    (; func = APL.Soares_u            , kwargs = (;z_range, xlabel = "u [m/s]")),
    (; func = APL.Soares_tke          , kwargs = (;z_range, xlabel = "tke [m^2/s^2]")),
    (; func = APL.TRMM_LBA_p_in       , kwargs = (;z_range, xlabel = "p [kPa]")),
    (; func = APL.TRMM_LBA_T_in       , kwargs = (;z_range, xlabel = "T [K]")),
    (; func = APL.TRMM_LBA_RH_in      , kwargs = (;z_range, xlabel = "RH [%]")),
    (; func = APL.TRMM_LBA_u_in       , kwargs = (;z_range, xlabel = "u [m/s]")),
    (; func = APL.TRMM_LBA_v_in       , kwargs = (;z_range, xlabel = "v [m/s]")),
    (; func = APL.Rico_geostrophic_ug , kwargs = (;z_range, xlabel = "u [m/s]")),
    (; func = APL.Rico_geostrophic_vg , kwargs = (;z_range, xlabel = "v [m/s]")),
    (; func = APL.Rico_dqtdt          , kwargs = (;z_range, xlabel = "dqdt [?/s]")),
    (; func = APL.Rico_subsidence     , kwargs = (;z_range, xlabel = "v [?/s]")),
    (; func = APL.DryBubble_θ         , kwargs = (;z_range, xlabel = "θ_liq_ice [K]")),
]

#####
##### t profiles
#####
t_profiles = []

for profile in t_profiles
    # We don't have t-profiles yet.
    # save_t_profile(profile.func; profile.kwargs...)
end
for profile in tz_profiles
    save_tz_profile(profile.func; profile.kwargs...)
end
for profile in z_profiles
    save_z_profile(profile.func; profile.kwargs...)
end

nothing