close all
clear
%% 信号
freq = 5e8:4e6:4e9;
fs = 90 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% 验证withair
n_freq = length(freq);
[s_eps, m_eps, s_thi, m_thi] = RefreshParameters();

ait = 0.001 : 0.001 : 0.01;
% arm_thickness = 0.036 : 0.01 : 0.071;
arm_thickness = 0.036;
for j = 1 : length(ait)
    for i = 1 : n_freq
        E_output(i, 1) = withairbetween(freq(i), 1, s_eps, m_eps, ...
            s_thi, m_thi, ait(j));
    end
    E_out_f = SIG .* E_output;
    E_result = 2 * merit.process.fd2td(E_output, freq, t);
    E_out_t = 2 * merit.process.fd2td(E_out_f, freq, t);
    y = envelope(E_out_t);
    y_sig = envelope(sig);
    t_delay(j) = t(find(y == max(y))) - t(find(y_sig == max(y_sig)));
    E_amplitude(j) = mag2db(max(abs(E_out_t)));
end

figure(1)
plot(ait, t_delay)

figure(2)
plot(ait, E_amplitude)
