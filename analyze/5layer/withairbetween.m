
function [E_output, t_outpu] = withairbetween(f, singal, skin_eps, muscle_eps, skin_thickness, muscle_thickness, dis)
    t1 = speed(skin_thickness, skin_eps);
    t2 =  speed(muscle_thickness, muscle_eps);
    t3 = speed(dis, 1);
    t_outpu = 2 * t1 + t2 + 2 * t3;
    E_air = att_decay(singal, f, dis, 1);
    [E_ref1, E_tra1] = math_ref(E_air, 1, skin_eps);
    E_first_att = att_decay(E_tra1, f, skin_thickness, skin_eps);
    [E_ref2, E_tra2] = math_ref(E_first_att, skin_eps, muscle_eps);
    E_second_att = att_decay(E_tra2, f, muscle_thickness, muscle_eps);
    [E_ref3, E_tra3] = math_ref(E_second_att, muscle_eps, skin_eps);
    E_third_att = att_decay(E_tra3, f, skin_thickness, skin_eps);
    [E_ref4, E_output] = math_ref(E_third_att, skin_eps, 1);
    E_output = att_decay(E_ref4, f, dis, 1);    
end

