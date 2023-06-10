%% 生成信号
freq = 0:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);



%% 如果系数一样，则应该等同于一层传播
E_output_1d = math_att(SIG, 2e9, 34, 30);
E_result1 = merit.process.fd2td(E_output_1d, freq, t);
[E_re1f, E_tra1] = math_ref(SIG, 30, 30);
figure(3)
plot(E_output_1d, 'g')
hold on
plot(E_tra1, 'b')