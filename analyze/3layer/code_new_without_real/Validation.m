close all
clear
%% 信号
freq = 5e8:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));

%% 设定变量
n_freq = length(freq);
[s_eps, m_eps, s_thi, m_thi] = RefreshParameters();
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);


%% 计算
E_output = Transmission3layer(2e9, SIG, 1, 1, s_thi, m_thi);
E_result = 2 * merit.process.fd2td(E_output, 2e9, t);
t_delay(j) = t(find(y == max(y))) - t(find(sig == max(sig)));


E_amplitude = max(abs(E_result));
E_phase = (180 / pi) * unwrap(angle(E_out_f));
% E_phase = (180 / pi) * angle(real(E_output) * 1j + imag(E_output));

%% 显示
disp(E_amplitude)


