close all
clear
%% 信号
freq = 5e8:4e6:4e9;
fs = 200 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% 设定变量
n_freq = length(freq);
[s_eps, m_eps, s_thi, m_thi] = RefreshParameters();
se_matrix = readmatrix('skin.xlsx');
me_matrix = readmatrix('muscle.xlsx');
me_basic = me_matrix(1 : end - 1, 2);
se_basic = se_matrix(1 : end - 1, 2);

%% 计算

for i = 1 : n_freq
    E_output1(i, 1) = Transmission3layer(freq(i), 1, s_eps, m_eps, ...
        s_thi, m_thi);
    E_output2(i, 1) = Transmission3layer(freq(i), 1, se_basic(i), ...
        me_basic(i), s_thi, m_thi);
end
E_out_f1 = SIG .* E_output1;
E_out_t1 = 2 * merit.process.fd2td(E_out_f1, freq, t);
[R, lags] = xcorr(E_out_t1, sig);
[~, index] = max(abs(R));
delay1 = lags(index) * (t(2) - t(1));
E_out_f2 = SIG .* E_output2;
E_out_t2 = 2 * merit.process.fd2td(E_out_f2, freq, t);
[R, lags] = xcorr(E_out_t2, sig);
[~, index] = max(abs(R));
delay2 = lags(index) * (t(2) - t(1));
delay_diff = delay2 - delay1;
plot(t, envelope(E_out_t1))
hold on
[maxValue1, maxIndex1] = max(E_out_t1);
plot(t, envelope(E_out_t2))
[maxValue2, maxIndex2] = max(E_out_t2);
legend('Constant \epsilon', 'Varies with frequency \epsilon')
xlabel('Time')
ylabel('Amplitude')