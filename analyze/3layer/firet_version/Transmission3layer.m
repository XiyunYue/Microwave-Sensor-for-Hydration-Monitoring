
function [E_output, t_outpu] = Transmission3layer(singal, skin_eps, muscle_eps, skin_thickness, muscle_thickness)
    t1 = speed(skin_thickness, skin_eps);
    t2 =  speed(muscle_thickness, muscle_eps);
    t_outpu = 2 * t1 + t2;
    [E_re1f, E_tra1] = math_ref(singal, 1,skin_eps);
    E_first_att = math_att(E_tra1, 2e9, skin_thickness, skin_eps);
    [E_ref2, E_tra2] = math_ref(E_first_att, skin_eps, muscle_eps);
    E_second_att = math_att(E_tra2, 2e9, muscle_thickness, muscle_eps);
    [E_ref3, E_tra3] = math_ref(E_second_att, muscle_eps, skin_eps);
    E_third_att = math_att(E_tra3, 2e9, skin_thickness, skin_eps);
    [E_ref4, E_output] = math_ref(E_third_att, skin_eps, 1);
end

