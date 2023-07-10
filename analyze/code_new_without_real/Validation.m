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

%% 设定变量
n_freq = length(freq);

se = 1;
me = 1;
st = 0.02;
mt = 0.05;

%% 计算
for i = 1 : n_freq
    E_output(i, 1) = Transmission3layer(freq(i), 1, se, me, st, mt);
end
E_out_f = SIG .* E_output;
E_result = 2 * merit.process.fd2td(E_output, freq, t);
E_out_t = 2 * merit.process.fd2td(E_out_f, freq, t);
y = envelope(E_out_t);
y_sig = envelope(sig);
t_delay = t(find(y == max(y))) - t(find(y_sig == max(y_sig)));
t_s = t_math(st, se);
t_m = t_math(mt, me);
t_delay_math = 2 *t_s + t_m;


%%
disp(t_delay_math)
disp(t_delay)
