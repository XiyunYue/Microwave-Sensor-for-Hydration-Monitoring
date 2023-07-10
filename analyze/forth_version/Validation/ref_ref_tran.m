
function E_output = ref_ref_tran(f, singal, skin_eps, muscle_eps, skin_thickness, muscle_thickness)
    [E_re1f, E_tra1] = math_ref(singal, 1,skin_eps);
    E_first_att = att_decay(E_tra1, f, skin_thickness, skin_eps);
    [E_ref2, E_tra2] = math_ref(E_first_att, skin_eps, muscle_eps);
    E_second_att = att_decay(E_ref2, f, skin_thickness, skin_eps);
    [E_ref3, E_tra3] = math_ref(E_second_att, skin_eps, 1);
    E_third_att = att_decay(E_ref3, f, skin_thickness, skin_eps);
    [E_ref4, E_output] = math_ref(E_third_att, skin_eps, muscle_eps);
end

