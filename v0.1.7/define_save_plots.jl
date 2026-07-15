import Plots

# https://github.com/jheinen/GR.jl/issues/278#issuecomment-587090846
ENV["GKSwstype"] = "nul"

scale_time_to_days(t) = t / 86400
scale_time_to_hours(t) = t / 3600
scale_z_to_kilometers(t) = t / 10^3
scale_z_to_meters(t) = t
xlabel(::typeof(scale_time_to_hours)) = "Time [hr]"
xlabel(::typeof(scale_time_to_days)) = "Time [days]"
ylabel(::typeof(scale_z_to_kilometers)) = "Altitude (z) [km]"
ylabel(::typeof(scale_z_to_meters)) = "Altitude (z) [m]"

function save_tz_profile(
        profile;
        scale_time = scale_time_to_hours,
        scale_z = scale_z_to_kilometers,
        units = "",
        label = "",
        t_range,
        z_range,
    )
    prof = profile(Float64)

    # We could alternatively use this
    # as it's nicely documenting how
    # to use the profiles, but we want
    # to scale the altitude
    # Plots.contourf(t_range, z_range, (t, z) -> prof(t, z))
    data = prof.(t_range', z_range)
    Plots.contourf(scale_time.(t_range), scale_z.(z_range), data; c = :viridis)
    Plots.xlabel!(xlabel(scale_time))
    Plots.ylabel!(ylabel(scale_z))
    Plots.title!("$(nameof(profile)) $units, ($label)")
    Plots.savefig("tz_$(nameof(profile)).png")
end

function save_z_profile(
        profile;
        xlabel,
        scale_z = scale_z_to_kilometers,
        z_range,
        unit = nothing,
    )
    prof = profile(Float64)
    # data = (z) -> prof(z)
    data = prof.(z_range)
    Plots.plot(data, scale_z.(z_range))
    unit = @something unit units(xlabel)
    Plots.xlabel!("$xlabel $unit")
    Plots.ylabel!(ylabel(scale_z))
    Plots.title!("$(nameof(profile))")
    Plots.savefig("z_$(nameof(profile)).png")
end

function save_t_profile(
        profile;
        label,
        scale_time = scale_time_to_hours,
        t_range,
    )
    prof = profile(Float64)
    # data = (t) -> prof(t)
    data = prof.(t_range)
    Plots.plot(scale_time.(t_range), data)
    Plots.xlabel!("Time $(xlabel(scale_time))")
    Plots.ylabel!("$label $(units(label))")
    Plots.title!("$(nameof(profile))")
    Plots.savefig("t_$(nameof(profile)).png")
end
