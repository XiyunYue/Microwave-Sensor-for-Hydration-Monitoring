
function E_output = tran_3(f, singal, skin_eps, muscle_eps, skin_thickness, muscle_thickness)
    
    E_output = att_decay(singal, f, muscle_thickness, muscle_eps);
end

