""" [Grabowski2006](@cite) """
function TRMM_LBA_z(::Type{FT}) where {FT}
    z_in = FT[0.130,  0.464,  0.573,  1.100,  1.653,  2.216,  2.760,
              3.297,  3.824,  4.327,  4.787,  5.242,  5.686,  6.131,
              6.578,  6.996,  7.431,  7.881,  8.300,  8.718,  9.149,
              9.611, 10.084, 10.573, 11.008, 11.460, 11.966, 12.472,
             12.971, 13.478, 13.971, 14.443, 14.956, 15.458, 16.019,
             16.491, 16.961, 17.442, 17.934, 18.397, 18.851, 19.331,
             19.809, 20.321, 20.813, 21.329, 30.000] .* 1000 .- 130 #LES z is in meters
    return z_in
end
""" [Grabowski2006](@cite) """
function TRMM_LBA_p(::Type{FT}) where {FT}
    z_in = TRMM_LBA_z(FT)
    p_in = FT[991.3, 954.2, 942.0, 886.9, 831.5, 778.9, 729.8,
              684.0, 641.7, 603.2, 570.1, 538.6, 509.1, 480.4,
              454.0, 429.6, 405.7, 382.5, 361.1, 340.9, 321.2,
              301.2, 281.8, 263.1, 246.1, 230.1, 213.2, 197.0,
              182.3, 167.9, 154.9, 143.0, 131.1, 119.7, 108.9,
              100.1,  92.1,  84.6,  77.5,  71.4,  65.9,  60.7,
               55.9,  51.3,  47.2,  43.3,  10.3] .* 100 # LES pres is in pasc
    return Dierckx.Spline1D(z_in, p_in; k = 1)
end
""" [Grabowski2006](@cite) """
function TRMM_LBA_T(::Type{FT}) where {FT}
    z_in = TRMM_LBA_z(FT)
    T_in = FT[23.70,  23.30,  22.57,  19.90,  16.91,  14.09,  11.13,
               8.29,   5.38,   2.29,  -0.66,  -3.02,  -5.28,  -7.42,
             -10.34, -12.69, -15.70, -19.21, -21.81, -24.73, -27.76,
             -30.93, -34.62, -38.58, -42.30, -46.07, -50.03, -54.67,
             -59.16, -63.60, -67.68, -70.77, -74.41, -77.51, -80.64,
             -80.69, -80.00, -81.38, -81.17, -78.32, -74.77, -74.52,
             -72.62, -70.87, -69.19, -66.90, -66.90] .+ FT(273.15) # LES T is in deg K
    return Dierckx.Spline1D(z_in, T_in; k = 1)
end
""" [Grabowski2006](@cite) """
function TRMM_LBA_RH(::Type{FT}) where {FT}
  z_in = TRMM_LBA_z(FT)
    RH_in = FT[98.00,  86.00,  88.56,  87.44,  86.67,  83.67,  79.56,
               84.78,  84.78,  89.33,  94.33,  92.00,  85.22,  77.33,
               80.11,  66.11,  72.11,  72.67,  52.22,  54.67,  51.00,
               43.78,  40.56,  43.11,  54.78,  46.11,  42.33,  43.22,
               45.33,  39.78,  33.78,  28.78,  24.67,  20.67,  17.67,
               17.11,  16.22,  14.22,  13.00,  13.00,  12.22,   9.56,
                7.78,   5.89,   4.33,   3.00,   3.00]
    return Dierckx.Spline1D(z_in, RH_in; k = 1)
end
""" [Grabowski2006](@cite) """
function TRMM_LBA_u(::Type{FT}) where {FT}
    z_in = TRMM_LBA_z(FT)
    u_in = FT[0.00,   0.81,   1.17,   3.44,   3.53,   3.88,   4.09,
              3.97,   1.22,   0.16,  -1.22,  -1.72,  -2.77,  -2.65,
             -0.64,  -0.07,  -1.90,  -2.70,  -2.99,  -3.66,  -5.05,
             -6.64,  -4.74,  -5.30,  -6.07,  -4.26,  -7.52,  -8.88,
             -9.00,  -7.77,  -5.37,  -3.88,  -1.15,  -2.36,  -9.20,
             -8.01,  -5.68,  -8.83, -14.51, -15.55, -15.36, -17.67,
            -17.82, -18.94, -15.92, -15.32, -15.32]
    return Dierckx.Spline1D(z_in, u_in; k = 1)
end
""" [Grabowski2006](@cite) """
function TRMM_LBA_v(::Type{FT}) where {FT}
    z_in = TRMM_LBA_z(FT)
    v_in = FT[-0.40,  -3.51,  -3.88,  -4.77,  -5.28,  -5.85,  -5.60,
              -2.67,  -1.47,   0.57,   0.89,  -0.08,   1.11,   2.15,
               3.12,   3.22,   3.34,   1.91,   1.15,   1.01,  -0.57,
              -0.67,   0.31,   2.97,   2.32,   2.66,   4.79,   3.40,
               3.14,   3.93,   7.57,   2.58,   2.50,   6.44,   6.84,
               0.19,  -2.20,  -3.60,   0.56,   6.68,   9.41,   7.03,
               5.32,   1.14,  -0.65,   5.27,   5.27]
    return Dierckx.Spline1D(z_in, v_in; k = 1)
end

""" [Grabowski2006](@cite) """
function TRMM_LBA_tke(::Type{FT}) where {FT}
    z -> if z <= 2500.0
        FT(1) - z / 3000
    else
        FT(0)
    end
end
""" TMP TKE profile for testing """
function TRMM_LBA_tke_prescribed(::Type{FT}) where {FT}
    z_in = FT[  100.,   300.,   500.,   700.,   900.,  1100.,  1300.,  1500.,
        1700.,  1900.,  2100.,  2300.,  2500.,  2700.,  2900.,  3100.,
        3300.,  3500.,  3700.,  3900.,  4100.,  4300.,  4500.,  4700.,
        4900.,  5100.,  5300.,  5500.,  5700.,  5900.,  6100.,  6300.,
        6500.,  6700.,  6900.,  7100.,  7300.,  7500.,  7700.,  7900.,
        8100.,  8300.,  8500.,  8700.,  8900.,  9100.,  9300.,  9500.,
        9700.,  9900., 10100., 10300., 10500., 10700., 10900., 11100.,
       11300., 11500., 11700., 11900., 12100., 12300., 12500., 12700.,
       12900., 13100., 13300., 13500., 13700., 13900., 14100., 14300.,
       14500., 14700., 14900., 15100., 15300., 15500., 15700., 15900.,
       16100., 16300.]
    tke_in = FT[0.77933, 1.20996, 0.68111, 0.50049, 0.38931, 0.28228, 0.24522,
       0.31142, 0.39571, 0.46704, 0.46818, 0.48633, 0.58804, 0.58895,
       0.46073, 0.55947, 0.59531, 0.54179, 0.57923, 0.60628, 0.71299,
       1.05881, 1.12169, 1.32965, 1.42813, 1.47417, 1.51302, 1.53236,
       1.55512, 1.65502, 1.8333 , 1.9667 , 2.19276, 2.26542, 2.21068,
       2.23323, 2.3244 , 2.44234, 2.52974, 2.58182, 2.61271, 2.64374,
       2.68625, 2.73071, 2.75999, 2.77205, 2.77435, 2.78314, 2.79556,
       2.78548, 2.76144, 2.73695, 2.71783, 2.68483, 2.62265, 2.52798,
       2.44799, 2.44723, 2.49548, 2.51967, 2.45912, 2.28634, 2.04751,
       1.7938 , 1.56451, 1.37531, 1.17515, 0.96797, 0.61262, 0.26423,
       0.14929, 0.07465, 0.00635, 0.     , 0.     , 0.     , 0.     ,
       0.     , 0.     , 0.     , 0.     , 0.     ]
    return Dierckx.Spline1D(z_in, tke_in; k = 1)
end


""" [Grabowski2006](@cite) """
function TRMM_LBA_radiation(::Type{FT}) where {FT}
    rad_time = range(FT(10), FT(360); length = 36) .* 60
    z_in = FT[42.5, 200.92, 456.28, 743, 1061.08, 1410.52, 1791.32, 2203.48, 2647,3121.88, 3628.12,
              4165.72, 4734.68, 5335, 5966.68, 6629.72, 7324.12,
              8049.88, 8807, 9595.48, 10415.32, 11266.52, 12149.08, 13063, 14008.28,
              14984.92, 15992.92, 17032.28, 18103, 19205.08, 20338.52, 21503.32, 22699.48]
    rad_in = [[-1.386, -1.927, -2.089, -1.969, -1.805, -1.585, -1.406, -1.317, -1.188, -1.106, -1.103, -1.025,
              -0.955, -1.045, -1.144, -1.119, -1.068, -1.092, -1.196, -1.253, -1.266, -1.306,  -0.95,  0.122,
               0.255,  0.258,  0.322,  0.135,      0,      0,      0,      0,      0],
             [ -1.23, -1.824, -2.011, -1.895, -1.729, -1.508, -1.331, -1.241, -1.109, -1.024, -1.018,  -0.94,
              -0.867, -0.953, -1.046, -1.018, -0.972, -1.006, -1.119, -1.187, -1.209, -1.259, -0.919,  0.122,
               0.264,  0.262,  0.326,  0.137,      0,      0,      0,      0,     0],
             [-1.043, -1.692, -1.906, -1.796,  -1.63,  -1.41, -1.233, -1.142,  -1.01,  -0.92, -0.911, -0.829,
              -0.754, -0.837, -0.923,  -0.89, -0.847, -0.895, -1.021, -1.101, -1.138, -1.201,  -0.88,  0.131,
               0.286,  0.259,  0.332,   0.14,      0,      0,      0,      0,      0],
             [-0.944, -1.613, -1.832,  -1.72, -1.555, -1.339, -1.163, -1.068, -0.935, -0.846, -0.835,  -0.75,
              -0.673, -0.751, -0.833, -0.798,  -0.76, -0.817, -0.952, -1.042, -1.088, -1.159, -0.853,  0.138,
               0.291,  0.265,  0.348,  0.136,      0,      0,      0,      0,      0],
             [-0.833, -1.526, -1.757, -1.648, -1.485,  -1.27, -1.093, -0.998, -0.867, -0.778, -0.761, -0.672,
              -0.594, -0.671, -0.748, -0.709, -0.676, -0.742, -0.887, -0.986, -1.041, -1.119, -0.825,  0.143,
               0.296,  0.271,  0.351,  0.138,      0,      0,      0,      0,      0],
             [-0.719, -1.425, -1.657,  -1.55, -1.392, -1.179, -1.003, -0.909, -0.778, -0.688, -0.667, -0.573,
              -0.492, -0.566, -0.639, -0.596, -0.568, -0.647, -0.804, -0.914, -0.981,  -1.07, -0.793,  0.151,
               0.303,  0.279,  0.355,  0.141,      0,      0,      0,      0,      0],
             [-0.724, -1.374, -1.585, -1.482, -1.328, -1.116, -0.936, -0.842, -0.715, -0.624, -0.598, -0.503,
              -0.421, -0.494, -0.561, -0.514,  -0.49,  -0.58, -0.745, -0.863, -0.938, -1.035, -0.764,  0.171,
               0.291,  0.284,  0.358,  0.144,      0,      0,      0,      0,      0],
             [-0.587,  -1.28, -1.513, -1.416, -1.264, -1.052, -0.874, -0.781, -0.655, -0.561, -0.532, -0.436,
              -0.354, -0.424, -0.485, -0.435, -0.417, -0.517, -0.691, -0.817, -0.898,     -1,  -0.74,  0.176,
               0.297,  0.289,   0.36,  0.146,      0,      0,      0,      0,      0],
             [-0.506, -1.194, -1.426, -1.332, -1.182, -0.972, -0.795, -0.704, -0.578,  -0.48, -0.445, -0.347,
              -0.267, -0.336, -0.391, -0.337, -0.325, -0.436,  -0.62, -0.756, -0.847,  -0.96, -0.714,   0.18,
               0.305,  0.317,  0.348,  0.158,      0,      0,      0,      0,      0],
             [-0.472,  -1.14, -1.364, -1.271, -1.123, -0.914, -0.738, -0.649, -0.522, -0.422, -0.386, -0.287,
              -0.207, -0.273, -0.322, -0.267,  -0.26, -0.379, -0.569, -0.712, -0.811, -0.931, -0.696,  0.183,
               0.311,   0.32,  0.351,   0.16,      0,      0,      0,      0,     0],
             [-0.448, -1.091, -1.305, -1.214, -1.068, -0.858, -0.682, -0.594, -0.469, -0.368, -0.329, -0.229,
              -0.149, -0.213, -0.257,   -0.2, -0.199, -0.327, -0.523, -0.668, -0.774, -0.903, -0.678,  0.186,
               0.315,  0.323,  0.355,  0.162,      0,      0,      0,      0,      0],
             [-0.405, -1.025, -1.228, -1.139, -0.996, -0.789, -0.615, -0.527, -0.402,   -0.3, -0.256, -0.156,
              -0.077, -0.136, -0.173, -0.115, -0.121, -0.259, -0.463, -0.617, -0.732, -0.869, -0.656,   0.19,
               0.322,  0.326,  0.359,  0.164,      0,      0,      0,      0,      0],
             [-0.391, -0.983, -1.174, -1.085, -0.945, -0.739, -0.566, -0.478, -0.354, -0.251, -0.205, -0.105,
              -0.027, -0.082, -0.114, -0.056, -0.069, -0.213,  -0.42, -0.579, -0.699,  -0.84, -0.642,  0.173,
               0.327,  0.329,  0.362,  0.165,      0,      0,      0,      0,      0],
             [-0.385, -0.946, -1.121, -1.032, -0.898, -0.695, -0.523, -0.434, -0.307, -0.203, -0.157, -0.057,
               0.021, -0.031, -0.059, -0.001, -0.018, -0.168, -0.381, -0.546, -0.672, -0.819, -0.629,  0.176,
               0.332,  0.332,  0.364,  0.166,      0,      0,      0,      0,      0],
             [-0.383, -0.904, -1.063, -0.972, -0.834, -0.632, -0.464, -0.378, -0.251, -0.144, -0.096,  0.001,
               0.079,  0.032,  0.011,  0.069,  0.044, -0.113, -0.332, -0.504, -0.637, -0.791, -0.611,  0.181,
               0.338,  0.335,  0.367,  0.167,      0,      0,      0,      0,      0],
             [-0.391, -0.873, -1.016, -0.929, -0.794, -0.591, -0.423, -0.337, -0.212, -0.104, -0.056,  0.043,
               0.121,  0.077,  0.058,  0.117,  0.088, -0.075, -0.298, -0.475, -0.613, -0.772, -0.599,  0.183,
               0.342,  0.337,   0.37,  0.168,      0,      0,      0,      0,      0],
             [-0.359, -0.836, -0.976, -0.888, -0.755, -0.554, -0.386,   -0.3, -0.175, -0.067, -0.018,  0.081,
                0.16,  0.119,  0.103,  0.161,  0.129, -0.039, -0.266, -0.448, -0.591, -0.755, -0.587,  0.187,
               0.345,  0.339,  0.372,  0.169,      0,      0,      0,      0,     0],
             [-0.328, -0.792, -0.928, -0.842, -0.709, -0.508, -0.341, -0.256, -0.131, -0.022,  0.029,  0.128,
               0.208,   0.17,  0.158,  0.216,  0.179,  0.005, -0.228, -0.415, -0.564, -0.733, -0.573,   0.19,
               0.384,  0.313,  0.375,   0.17,      0,      0,      0,      0,      0],
             [-0.324, -0.767, -0.893, -0.807, -0.676, -0.476,  -0.31, -0.225, -0.101,  0.008,   0.06,  0.159,
               0.239,  0.204,  0.195,  0.252,  0.212,  0.034, -0.203, -0.394, -0.546, -0.719, -0.564,  0.192,
               0.386,  0.315,  0.377,  0.171,      0,      0,      0,      0,      0],
             [ -0.31,  -0.74,  -0.86, -0.775, -0.647, -0.449, -0.283, -0.197, -0.073,  0.036,  0.089,  0.188,
               0.269,  0.235,  0.229,  0.285,  0.242,  0.061, -0.179, -0.374,  -0.53, -0.706, -0.556,  0.194,
               0.388,  0.317,  0.402,  0.158,      0,      0,      0,      0,      0],
             [-0.244, -0.694, -0.818,  -0.73, -0.605, -0.415, -0.252, -0.163, -0.037,  0.072,  0.122,   0.22,
               0.303,  0.273,  0.269,  0.324,  0.277,  0.093, -0.152,  -0.35,  -0.51, -0.691, -0.546,  0.196,
               0.39,   0.32,  0.403,  0.159,      0,      0,      0,      0,      0],
             [-0.284, -0.701, -0.803, -0.701, -0.568, -0.381, -0.225, -0.142, -0.017,  0.092,  0.143,  0.242,
               0.325,  0.298,  0.295,   0.35,    0.3,  0.112, -0.134, -0.334, -0.497,  -0.68,  -0.54,  0.198,
               0.392,  0.321,  0.404,   0.16,      0,      0,      0,      0,      0],
             [-0.281, -0.686, -0.783,  -0.68, -0.547, -0.359, -0.202, -0.119,  0.005,  0.112,  0.163,  0.261,
               0.345,  0.321,  0.319,  0.371,  0.319,   0.13, -0.118, -0.321, -0.486, -0.671, -0.534,  0.199,
               0.393,  0.323,  0.405,  0.161,      0,      0,      0,      0,      0],
             [-0.269, -0.667,  -0.76, -0.655, -0.522, -0.336, -0.181, -0.096,  0.029,  0.136,  0.188,  0.286,
                0.37,  0.346,  0.345,  0.396,  0.342,   0.15, -0.102, -0.307, -0.473, -0.661, -0.528,    0.2,
               0.393,  0.324,  0.405,  0.162,      0,      0,      0,      0,      0],
             [-0.255, -0.653, -0.747, -0.643, -0.511, -0.325, -0.169, -0.082,  0.042,  0.149,  0.204,  0.304,
               0.388,  0.363,  0.36 ,  0.409,  0.354,  0.164, -0.085, -0.289, -0.457, -0.649, -0.523,  0.193,
               0.394,  0.326,  0.406,  0.162,      0,      0,      0,      0,      0],
             [-0.265,  -0.65, -0.739, -0.634,   -0.5, -0.314, -0.159, -0.072,  0.052,  0.159,  0.215,  0.316,
               0.398,  0.374,  0.374,  0.424,   0.37,  0.181, -0.065, -0.265, -0.429, -0.627, -0.519,   0.18,
               0.394,  0.326,  0.406,  0.162,      0,      0,      0,      0,      0],
             [-0.276, -0.647, -0.731, -0.626, -0.492, -0.307, -0.152, -0.064,  0.058,  0.166,  0.227,  0.329,
               0.411,  0.389,   0.39,  0.441,  0.389,  0.207, -0.032, -0.228, -0.394, -0.596, -0.494,  0.194,
               0.376,  0.326,  0.406,  0.162,      0,      0,      0,      0,      0],
             [-0.271, -0.646,  -0.73, -0.625, -0.489, -0.303, -0.149, -0.061,  0.062,  0.169,  0.229,  0.332,
               0.412,  0.388,  0.389,  0.439,  0.387,  0.206, -0.028, -0.209, -0.347, -0.524, -0.435,  0.195,
               0.381,  0.313,  0.405,  0.162,      0,      0,      0,      0,      0],
             [-0.267, -0.647, -0.734, -0.628,  -0.49, -0.304, -0.151, -0.062,  0.061,  0.168,  0.229,  0.329,
               0.408,  0.385,  0.388,  0.438,  0.386,  0.206, -0.024, -0.194, -0.319,  -0.48,  -0.36,  0.318,
               0.405,  0.335,  0.394,  0.162,      0,      0,      0,      0,      0],
             [-0.274, -0.656, -0.745,  -0.64,   -0.5, -0.313, -0.158, -0.068,  0.054,  0.161,  0.223,  0.325,
               0.402,  0.379,  0.384,  0.438,  0.392,  0.221,  0.001, -0.164, -0.278, -0.415, -0.264,  0.445,
               0.402,  0.304,  0.389,  0.157,      0,      0,      0,      0,      0],
             [-0.289, -0.666, -0.753, -0.648, -0.508,  -0.32, -0.164, -0.073,  0.049,  0.156,   0.22,  0.321,
               0.397,  0.374,  0.377,   0.43,  0.387,  0.224,  0.014, -0.139, -0.236, -0.359, -0.211,  0.475,
                 0.4,  0.308,  0.375,  0.155,      0,      0,      0,      0,      0],
             [-0.302, -0.678, -0.765, -0.659, -0.517, -0.329, -0.176, -0.085,  0.038,  0.145,  0.208,   0.31,
               0.386,  0.362,  0.366,  0.421,  0.381,  0.224,  0.022, -0.119, -0.201,   -0.3, -0.129,  0.572,
               0.419,  0.265,  0.364,  0.154,      0,      0,      0,      0,      0],
             [-0.314, -0.696, -0.786, -0.681, -0.539, -0.349, -0.196, -0.105,  0.019,  0.127,  0.189,  0.289,
               0.364,   0.34,  0.346,  0.403,   0.37,  0.222,  0.036, -0.081, -0.133, -0.205, -0.021,  0.674,
               0.383,  0.237,  0.359,  0.151,      0,      0,      0,      0,      0],
             [-0.341, -0.719, -0.807, -0.702, -0.558, -0.367, -0.211,  -0.12,  0.003,  0.111,  0.175,  0.277,
               0.351,  0.325,  0.331,   0.39,   0.36,  0.221,  0.048, -0.046, -0.074, -0.139,  0.038,  0.726,
               0.429,  0.215,  0.347,  0.151,      0,      0,      0,      0,      0],
             [ -0.35, -0.737, -0.829, -0.724, -0.577, -0.385, -0.229, -0.136, -0.011,  0.098,  0.163,  0.266,
               0.338,   0.31,  0.316,  0.378,  0.354,  0.221,  0.062, -0.009, -0.012, -0.063,  0.119,  0.811,
               0.319,  0.201,  0.343,  0.148,      0,      0,      0,      0,      0],
             [-0.344,  -0.75, -0.856, -0.757, -0.607, -0.409,  -0.25, -0.156, -0.033,  0.076,  0.143,  0.246,
               0.316,  0.287,  0.293,  0.361,  0.345,  0.225,  0.082,  0.035,  0.071,  0.046,  0.172,  0.708,
               0.255,   0.21,  0.325,  0.146,      0,      0,      0,      0,      0]] ./ 86400

    rad_in = hcat(rad_in...)'
    profile = Dierckx.Spline2D(rad_time, z_in, rad_in; kx = 1, ky = 1)
    return profile
end
