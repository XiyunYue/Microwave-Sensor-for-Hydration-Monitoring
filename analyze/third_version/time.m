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
skin_eps = 30;
muscle_eps = 50;
skin_thickness = 0.002;
muscle_thickness = 0.05;
E_output = Transmission3layer(2e9, SIG, skin_eps, muscle_eps, skin_thickness, muscle_thickness);
plot(freq, E_output);
% E_result = 2 * merit.process.fd2td(E_output, freq, t);
% y1_abs = abs(E_output);
% y2_abs = abs(SIG);
% y2 = envelope(y1_abs);
% x2 = find(y2 == max(y2));
% y1 = envelope(y2_abs);
% x1 = find(y1 == max(y1));
% phase2 = angle(E_output(x2)); 
% phase1 = angle(SIG(x1)); 
% phase_diff = phase2 - phase1;
% frequency = 2e9;  % 信号的频率
% time_diff = phase_diff / (2 * pi * frequency);
% disp(time_diff)
% figure(1)
% plot(phase2)
% hold on
% plot(t, E_result, 'b')
% y1 = envelope(sig);
% x1 = t(find(y1 == max(y1)));
% toa = x2 - 3.5e-8;
