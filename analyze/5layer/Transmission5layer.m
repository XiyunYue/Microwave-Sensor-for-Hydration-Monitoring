
function [E_output, t_outpu] = Transmission3layer(f, singal, skin_eps, muscle_eps, skin_thickness, muscle_thickness, fat_thickness, fat_eps)
    t1 = speed(skin_thickness, skin_eps);
    t2 =  speed(muscle_thickness, muscle_eps);
    t3 =  speed(fat_thickness, fat_eps);
    t_outpu = 2 * t1 + t2 + 2 * t3;
    [E_re1f, E_tra1] = math_ref(singal, 1,skin_eps);
    E_first_att = att_decay(E_tra1, f, skin_thickness, skin_eps, sigma);
    [E_ref2, E_tra2] = math_ref(E_first_att, skin_eps, fat_eps);
    E_second_att = att_decay(E_tra2, f, fat_thickness, fat_eps, sigma);
    [E_ref3, E_tra3] = math_ref(E_second_att, fat_eps, muscle_eps);
    E_third_att = att_decay(E_tra3, f, muscle_thickness, muscle_eps, sigma);
    [E_ref4, E_tra4] = math_ref(E_third_att, muscle_eps, fat_eps);
    E_forth_att = att_decay(E_tra4, f, fat_thickness, fat_eps, sigma);
    [E_ref5, E_tra5] = math_ref(E_forth_att, fat_eps, skin_eps);
    E_fifth_att = att_decay(E_tra5, f, skin_thickness, skin_eps, sigma);
    [E_ref6, E_output] = math_ref(E_fifth_att, skin_eps, 1);

end

