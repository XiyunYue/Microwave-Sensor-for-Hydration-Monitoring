function [t_delay, E_amplitude] = cal_arm_thickness(arm_thickness, se, me, st)
    %% 信号
    freq = 5e8:4e6:4e9;
    fs = 20 * max(freq); 
    dert_f = freq(2) - freq(1);
    t_length = fs ./ dert_f; 
    t = (0 : t_length + 1) * (1 ./ fs); 
    y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
    sig = y .* sin(2 * pi * 2e9 * t);
    SIG = merit.process.td2fd(sig', t, freq);
    
    %% 设定变量
    n_freq = length(freq);
    for a = 1 : length(se)
        for b = 1 : length(st)
            s_thi = st(b);
            m_thi = arm_thickness -  2 * s_thi;
            for c = 1 : length(me)
                s_eps = se(a);
                m_eps = me(c);
                for i = 1 : n_freq
                    E_output(i, 1) = Transmission3layer(freq(i), 1, s_eps, m_eps, ...
                        s_thi, m_thi);
                end
                E_out_f = SIG .* E_output;
                E_result = 2 * merit.process.fd2td(E_output, freq, t);
                E_out_t = 2 * merit.process.fd2td(E_out_f, freq, t);
                y = envelope(E_out_t);
                y_sig = envelope(sig);
                t_delay(a, b, c) = t(find(y == max(y))) - t(find(y_sig == max(y_sig)));
                E_amplitude(a, b, c) = mag2db(max(abs(E_out_t)));
            end
        end
    end
