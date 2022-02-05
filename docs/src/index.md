# AtmosphericProfilesLibrary.jl

AtmosphericProfilesLibrary.jl is a library of atmospheric profiles with respect to altitude (`z`) and time (`t`), using SI units.

## Scope of repository

This repository is meant to serve as a library of static functions in efforts to reduce code duplication and boiler plate. Added profiles should satisfy the following criteria to limit the scope of this library:

 - A single type argument (the float type `FT`)
   - For example, `my_new_profile(::Type{FT}) where {FT}`
 - No additional arguments
 - The return type of the profile should be a type-stable `Function` or callable object.
   - For example:
   - `prof = z->2*z` callable by `prof(z)`
   - `prof = t->2*t` callable by `prof(t)`
   - `prof = (t,z) -> z*t` callable by `prof(t, z)`
   - `prof = Dierckx.Spline1D(FT[0, 1, 2], FT[0, 2, 4]; k = 1)` callable by `prof(z)`

## How to contribute

Contributing to this repo involves 3 parts:

 - Add a reference to `docs/bibliography.bib`
 - Add a function, with signature `my_new_profile(::Type{FT}) where {FT}`, to `src/` with a doc string containing the reference
   - For example `""" [Grabowski2006](@cite) """`.
 - Add the new function to one of the `Vector`s in `docs/plot_profiles.jl`:
   - `z_profiles`
   - `t_profiles`
   - `tz_profiles`
  with appriate keyword arguments (e.g., labels and units).

Your plots should automatically appear in the documentation after finishing these three steps.

!!! warn

    Plots show units of kilometers and hours for
    convenience, but data returned from profiles
    should be in SI units (meters and seconds).
    For example:
    `prof = z->2*z`
    should be callable by `prof(z #= z is in meters=#)`.
