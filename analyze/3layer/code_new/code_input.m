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
se = 25 : 2 : 35;
me = 40 : 5 : 60;
st = 0.0005 : 0.0005 : 0.003;
mt = 0.03 : 0.01 : 0.07;
parameter_change = 4;
parameter_name = ['s_eps'; 'm_eps'; 's_thi'; 'm_thi'];
parameter_value = ['se'; 'me'; 'st'; 'mt'];


%% 计算
n_parameter = length(parameter_name(parameter_change,:));
E_output = zeros(n_parameter, n_freq);
E_amplitude = zeros(n_freq, n_parameter);
toa = zeros(n_freq, n_parameter);

for j = 1 : n_parameter
    for i = 1 : n_freq
        eval([parameter_name(parameter_change,:) ' = eval([(parameter_value(parameter_change,:))+"(j)"]);']);
        E_output = Transmission3layer(freq(i), SIG, s_eps, m_eps, ...
            s_thi, m_thi);
%         y1_abs = abs(E_output);
%         y2_abs = abs(SIG);
%         y2 = envelope(y1_abs);
%         x2 = find(y2 == max(y2));
%         y1 = envelope(y2_abs);
%         x1 = find(y1 == max(y1));
%         phase2 = angle(E_output(x2)); 
%         phase1 = angle(SIG(x1)); 
%         phase_diff = phase2 - phase1; % 信号的频率
%         toa(i, j) = phase_diff / (2 * pi * freq(i));
        E_result = 2 * merit.process.fd2td(E_output, freq, t);
        E_amplitude(i, j) = max(envelope(E_result)); 
    end
end


n = n_parameter;
color = zeros(n, 3);
for i = 1 : n
    color(i, :)=[i/n (n - i)/n (n - i)/n];
end

figure(1)
for i = 1 : n_parameter
    plot(freq, E_amplitude(:, i), 'Color', color(i, :))
    hold on
end
xlabel("Frequency");
ylabel("Amplitude");

switch parameter_change
    case 1
        name = 'Different skin thickness';
    case 2
        name = 'Different muscle thickness';
    case 3
        name = 'Different skin Permittivity';
    otherwise
        name = 'Different muscle Permittivity';
end
title(name);

figure(2)
for i = 1 : n_parameter
    plot(freq, toa(:, i), 'Color', color(i, :))
    hold on
end
xlabel("Frequency");
ylabel("TOA");
