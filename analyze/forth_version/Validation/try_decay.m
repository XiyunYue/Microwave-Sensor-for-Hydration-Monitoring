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
se = 25 : 2 : 35;
me = 40 : 5 : 60;
st = 0.0005 : 0.0005 : 0.003;
mt = 0.03 : 0.01 : 0.07;
parameter_change = 2;
parameter_name = ['s_eps'; 'm_eps'; 's_thi'; 'm_thi'];
parameter_value = ['se'; 'me'; 'st'; 'mt'];
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% 

% eps0 = 8.854 * 10^-12;
% mu0 = 4 * pi * 10^-7 ;
% sig = 4;
% c = 3 * 10 ^ 8;
% w = 2 * pi * f;
% alpha = sqrt(1i * w * mu0 * (sig + 1i * w * eps * eps0));
% E_new = E * exp(- alpha * x);
% 2 * merit.process.fd2td(E_output(:, j), freq, t);
E_new1 = 2 * merit.process.fd2td(att_decay(SIG, 2e9, 0.005, 40));
E_new2 = 2 * merit.process.fd2td(att_decay(SIG, 2e9, 0.005, 60));

plot(sig)
hold on
plot(abs(E_new1),'r')
hold on
plot(abs(E_new2),'b')