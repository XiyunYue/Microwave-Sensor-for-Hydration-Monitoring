function [delay, amplitude] = cal_arm_thickness(arm_thickness, sig, freq, t, precision)
    SIG = merit.process.td2fd(sig', t, freq);
    se_matrix = readmatrix('skin.xlsx');
    me_matrix = readmatrix('muscle.xlsx');
    me_basic = me_matrix(1 : end - 1, 2);
    se_basic = se_matrix(1 : end - 1, 2);
    st = 0.0005 : 0.0005 : 0.003;
    n_freq = length(SIG);


    %% 设定变量
    mt = arm_thickness - st;
    for b = 1 : length(st)
        for k = 1 : 11
                se = se_basic - 6 + k;
            for j = 1 : 20 / precision + 1
                me = me_basic - 10 + precision * (j - 1);
                for i = 1 : n_freq
                    E_output(i, 1) = Transmission3layer(freq(i), 1, se(i), ...
                        me(i), st(b), mt(b));
                end
                E_out_f = SIG .* E_output;
                E_result = 2 * merit.process.fd2td(E_output, freq, t);
                E_out_t = 2 * merit.process.fd2td(E_out_f, freq, t);
                [R, lags] = xcorr(E_out_t, sig);
                [~, index] = max(abs(R));
                delay(b, k, j) = lags(index) * (t(2) - t(1));
                amplitude(b, k, j) = max(E_out_t);
            end
        end
    end
end
