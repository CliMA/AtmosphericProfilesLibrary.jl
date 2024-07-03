""" [Nieuwstadt1993](@cite) """
Nieuwstadt_θ_liq_ice(::Type{FT}) where {FT} = ZProfile(z -> if z <= 1350.0
        FT(300)
    else
        FT(300) + 3 * (z - 1350) / 1000
    end)

""" [Nieuwstadt1993](@cite) """
Nieuwstadt_u(::Type{FT}) where {FT} = ZProfile(z -> FT(0.01))

""" [Nieuwstadt1993](@cite) """
Nieuwstadt_tke(::Type{FT}) where {FT} = ZProfile(z -> if (z <= 1600.0)
        FT(0.1) * FT(1.46) * FT(1.46) * (1 - z / 1600)
    else
        FT(0)
    end)

""" TMP TKE profile for testing """
function Nieuwstadt_tke_prescribed(::Type{FT}) where {FT}
    z_in = FT[9.375, 28.125, 46.875, 65.625, 84.375, 103.125, 121.875, 140.625, 159.375, 178.125, 196.875, 215.625,
              234.375, 253.125, 271.875, 290.625, 309.375, 328.125, 346.875, 365.625, 384.375, 403.125, 421.875,
              440.625, 459.375, 478.125, 496.875, 515.625, 534.375, 553.125, 571.875, 590.625, 609.375, 628.125,
              646.875, 665.625, 684.375, 703.125, 721.875, 740.625, 759.375, 778.125, 796.875, 815.625, 834.375,
              853.125, 871.875, 890.625, 909.375, 928.125, 946.875, 965.625, 984.375, 1003.125, 1021.875, 1040.625,
              1059.375, 1078.125, 1096.875, 1115.625, 1134.375, 1153.125, 1171.875, 1190.625, 1209.375, 1228.125,
              1246.875, 1265.625, 1284.375, 1303.125, 1321.875, 1340.625, 1359.375, 1378.125, 1396.875, 1415.625,
              1434.375, 1453.125, 1471.875, 1490.625, 1509.375, 1528.125, 1546.875, 1565.625, 1584.375, 1603.125,
              1621.875, 1640.625, 1659.375, 1678.125, 1696.875, 1715.625, 1734.375, 1753.125, 1771.875, 1790.625,
              1809.375, 1828.125, 1846.875, 1865.625, 1884.375, 1903.125, 1921.875, 1940.625, 1959.375, 1978.125,
              1996.875, 2015.625, 2034.375, 2053.125, 2071.875, 2090.625, 2109.375, 2128.125, 2146.875, 2165.625,
              2184.375, 2203.125, 2221.875, 2240.625, 2259.375, 2278.125, 2296.875, 2315.625, 2334.375, 2353.125,
              2371.875, 2390.625, 2409.375, 2428.125, 2446.875, 2465.625, 2484.375, 2503.125, 2521.875, 2540.625,
              2559.375, 2578.125, 2596.875, 2615.625, 2634.375, 2653.125, 2671.875, 2690.625, 2709.375, 2728.125,
              2746.875, 2765.625, 2784.375, 2803.125, 2821.875, 2840.625, 2859.375, 2878.125, 2896.875, 2915.625,
              2934.375, 2953.125, 2971.875, 2990.625, 3009.375, 3028.125, 3046.875, 3065.625, 3084.375, 3103.125,
              3121.875, 3140.625, 3159.375, 3178.125, 3196.875, 3215.625, 3234.375, 3253.125, 3271.875, 3290.625,
              3309.375, 3328.125, 3346.875, 3365.625, 3384.375, 3403.125, 3421.875, 3440.625, 3459.375, 3478.125,
              3496.875, 3515.625, 3534.375, 3553.125, 3571.875, 3590.625, 3609.375, 3628.125, 3646.875, 3665.625,
              3684.375, 3703.125, 3721.875, 3740.625]
    tke_in = FT[0.18704, 1.0066, 1.3312, 1.5290, 1.6691, 1.7759, 1.8612, 1.9314, 1.9902, 2.0403, 2.0834, 2.1207,
                2.1533, 2.1817, 2.2065, 2.2282, 2.2472, 2.2637, 2.2779, 2.2902, 2.3006, 2.3093, 2.3164, 2.3222,
                2.3266, 2.3297, 2.3318, 2.3328, 2.3328, 2.3320, 2.3303, 2.3275, 2.3245, 2.3191, 2.3142, 2.3071,
                2.2985, 2.2925, 2.2824, 2.2746, 2.2630, 2.2532, 2.2390, 2.2255, 2.2115, 2.2012, 2.1883, 2.1731,
                2.1615, 2.1482, 2.1353, 2.1155, 2.1043, 2.0874, 2.0662, 2.0580, 2.0419, 2.0221, 2.0049, 1.9880,
                1.9621, 1.9311, 1.8952, 1.8549, 1.8102, 1.7602, 1.7046, 1.6429, 1.5748, 1.5004, 1.4194, 1.3317,
                1.2373, 1.1361, 1.0283, 0.9145, 0.7963, 0.6770, 0.5626, 0.4616, 0.3830, 0.3303, 0.2988, 0.28,
                0.2668, 0.2553, 0.2438, 0.2314, 0.2178, 0.2030, 0.1863, 0.1676, 0.1465, 0.1228, 0.0969, 0.0704,
                0.0462, 0.0284, 0.0132, 0.0021, 1.25e-06, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    not_type_stable_spline = Dierckx.Spline1D(z_in, tke_in; k = 1)
    return ZProfile(x -> FT(not_type_stable_spline(x)))
end
