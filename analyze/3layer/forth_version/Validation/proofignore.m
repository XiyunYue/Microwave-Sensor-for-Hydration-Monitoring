close all
clear
%% 信号
freq = 5e8:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% 设定变量
n_freq = length(freq);
[s_eps, m_eps, s_thi, m_thi] = RefreshParameters();
for i = 1 : n_freq
    E_output1(i) = compare_ref(freq(i), 1, s_eps, m_eps, s_thi, m_thi); 
    E_output2(i) = ref_ref_tran(freq(i), 1, s_eps, m_eps, s_thi, m_thi); 
end
E_out_f1 = SIG .* E_output1';
E_out_f2 = SIG .* E_output2';
E_result1 = 2 * merit.process.fd2td(E_out_f1, freq, t);
E_result2 = 2 * merit.process.fd2td(E_out_f2, freq, t);
y1 = max(envelope(E_result1));
y2 = max(envelope(E_result2));
disp(y1)
disp(y2)
disp(y2/y1)