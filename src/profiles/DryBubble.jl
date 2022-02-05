""" :( """
function DryBubble_θ(::Type{FT}) where {FT}
    z_in = FT[
          25.,   75.,  125.,  175.,  225.,  275.,  325.,  375.,  425.,
         475.,  525.,  575.,  625.,  675.,  725.,  775.,  825.,  875.,
         925.,  975., 1025., 1075., 1125., 1175., 1225., 1275., 1325.,
        1375., 1425., 1475., 1525., 1575., 1625., 1675., 1725., 1775.,
        1825., 1875., 1925., 1975., 2025., 2075., 2125., 2175., 2225.,
        2275., 2325., 2375., 2425., 2475., 2525., 2575., 2625., 2675.,
        2725., 2775., 2825., 2875., 2925., 2975., 3025., 3075., 3125.,
        3175., 3225., 3275., 3325., 3375., 3425., 3475., 3525., 3575.,
        3625., 3675., 3725., 3775., 3825., 3875., 3925., 3975., 4025.,
        4075., 4125., 4175., 4225., 4275., 4325., 4375., 4425., 4475.,
        4525., 4575., 4625., 4675., 4725., 4775., 4825., 4875., 4925.,
        4975., 5025., 5075., 5125., 5175., 5225., 5275., 5325., 5375.,
        5425., 5475., 5525., 5575., 5625., 5675., 5725., 5775., 5825.,
        5875., 5925., 5975., 6025., 6075., 6125., 6175., 6225., 6275.,
        6325., 6375., 6425., 6475., 6525., 6575., 6625., 6675., 6725.,
        6775., 6825., 6875., 6925., 6975., 7025., 7075., 7125., 7175.,
        7225., 7275., 7325., 7375., 7425., 7475., 7525., 7575., 7625.,
        7675., 7725., 7775., 7825., 7875., 7925., 7975., 8025., 8075.,
        8125., 8175., 8225., 8275., 8325., 8375., 8425., 8475., 8525.,
        8575., 8625., 8675., 8725., 8775., 8825., 8875., 8925., 8975.,
        9025., 9075., 9125., 9175., 9225., 9275., 9325., 9375., 9425.,
        9475., 9525., 9575., 9625., 9675., 9725., 9775., 9825., 9875.,
        9925., 9975.
    ]
    θ_liq_ice_in = FT[
        299.9834, 299.9836, 299.9841, 299.985 , 299.9864, 299.9883,
        299.9907, 299.9936, 299.9972, 300.0012, 300.0058, 300.011 ,
        300.0166, 300.0228, 300.0293, 300.0363, 300.0436, 300.0512,
        300.0591, 300.0672, 300.0755, 300.0838, 300.0921, 300.1004,
        300.1086, 300.1167, 300.1245, 300.132 , 300.1393, 300.1461,
        300.1525, 300.1583, 300.1637, 300.1685, 300.1726, 300.1762,
        300.179 , 300.1812, 300.1826, 300.1833, 300.1833, 300.1826,
        300.1812, 300.179 , 300.1762, 300.1727, 300.1685, 300.1637,
        300.1584, 300.1525, 300.1461, 300.1393, 300.1321, 300.1245,
        300.1167, 300.1087, 300.1005, 300.0922, 300.0838, 300.0755,
        300.0673, 300.0592, 300.0513, 300.0437, 300.0364, 300.0294,
        300.0228, 300.0167, 300.0111, 300.0059, 300.0013, 299.9972,
        299.9937, 299.9908, 299.9884, 299.9865, 299.9851, 299.9842,
        299.9837, 299.9835, 299.9835, 299.9835, 299.9835, 299.9835,
        299.9835, 299.9835, 299.9835, 299.9835, 299.9835, 299.9835,
        299.9835, 299.9835, 299.9835, 299.9835, 299.9835, 299.9835,
        299.9835, 299.9835, 299.9835, 299.9835, 299.9835, 299.9835,
        299.9835, 299.9835, 299.9835, 299.9835, 299.9835, 299.9835,
        299.9835, 299.9835, 299.9835, 299.9835, 299.9835, 299.9835,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9836, 299.9836,
        299.9836, 299.9836, 299.9836, 299.9836, 299.9837, 299.9837,
        299.9837, 299.9837, 299.9837, 299.9837, 299.9837, 299.9837,
        299.9837, 299.9837, 299.9837, 299.9837, 299.9837, 299.9837,
        299.9837, 299.9837, 299.9837, 299.9837, 299.9837, 299.9837,
        299.9837, 299.9837
    ]
    profile = Dierckx.Spline1D(z_in, θ_liq_ice_in; k = 1)
    return profile
end
