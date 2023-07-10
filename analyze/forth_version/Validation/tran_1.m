
function E_output = tran_1(f, singal, skin_eps, muscle_eps, skin_thickness, muscle_thickness)
    [E_re1f, E_tra1] = math_ref(singal, 1,skin_eps);
    E_first_att = att_decay(E_tra1, f, skin_thickness, skin_eps);
    [E_ref2, E_output] = math_ref(E_first_att, skin_eps, muscle_eps);
end

