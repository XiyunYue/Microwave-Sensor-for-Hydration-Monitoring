
freq = 5e8:4e6:4e9;
fs = 200 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);


n_freq = length(SIG);
[s_eps, m_eps, s_thi, m_thi] = RefreshParameters();
se_matrix = readmatrix('skin.xlsx');
me_matrix = readmatrix('muscle.xlsx');
me_basic = me_matrix(1 : end - 1, 2);
se_basic = se_matrix(1 : end - 1, 2);
st = 0.0005 : 0.0005 : 0.003;
n_freq = length(freq);
arm_thickness = 0.07;
%% 设定变量
mt = arm_thickness - st;
for b = 1 : length(st)
    for k = 1 : 11
            se = se_basic - 6 + k;
        for j = 1 : 11
            me = me_basic - 12 + 2 * j;
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
for b = 1 : 6
    for k = 1 : 11
        y_point = reshape(delay(b, k, :), [], 1);
        x_point = reshape(amplitude(b, k, :), [], 1);
        scatter(x_point, y_point, 30, 'o', 'filled')
        hold on
    end
end
xlabel('Amplitude')
ylabel('TOA')
title('Center frequency =', cf)
colorbar;
