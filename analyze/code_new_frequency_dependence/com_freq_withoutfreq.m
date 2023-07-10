close all
clear
%% 信号
freq = 5e8:4e6:4e9;
fs = 4000 * max(freq); 
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
parameter_change = 3;
parameter_name = ['s_eps'; 'm_eps'; 's_thi'; 'm_thi'];
parameter_value = ['se'; 'me'; 'st'; 'mt'];
st = 0.0005 : 0.0005 : 0.003;
mt = 0.03 : 0.01 : 0.07;

%% 计算
n_parameter = length(st);
for j = 1 : n_parameter
    for i = 1 : n_freq
        m_thi = 0.052 - 2 * st(j);
        E_output1(i, j) = Transmission3layer(freq(i), 1, se_basic(i), ...
            me_basic(i), st(j), m_thi);
        E_output2(i, j) = Transmission3layer(freq(i), 1, s_eps, m_eps, ...
            st(j), m_thi);
    end
    E_out_f1(:, j) = SIG .* E_output1(:, j);
    E_result1(:, j) = 2 * merit.process.fd2td(E_output1(:, j), freq, t);
    E_out_t1(:, j) = 2 * merit.process.fd2td(E_out_f1(:, j), freq, t);
    [R, lags] = xcorr(E_out_t1(:, j), sig);
    [~, index] = max(abs(R));
    delay1(j) = lags(index) * (t(2) - t(1));

    E_out_f2(:, j) = SIG .* E_output2(:, j);
    E_result2(:, j) = 2 * merit.process.fd2td(E_output2(:, j), freq, t);
    E_out_t2(:, j) = 2 * merit.process.fd2td(E_out_f2(:, j), freq, t);
    [R, lags] = xcorr(E_out_t2(:, j), sig);
    [~, index] = max(abs(R));
    delay2(j) = lags(index) * (t(2) - t(1));
end

%% 绘图
n = length(delay1);
color = zeros(n, 3);
for i = 1 : n
    color(i, :)=[i/n (n - i)/n (n - i)/n];
end

switch parameter_change
    case 1
        name = 'Different skin Permittivity';
    case 2
        name = 'Different muscle Permittivity';
    case 3
        name = 'Different muscle thickness';
    otherwise
end
legend_labels = cell(1, n); 

%% 
if parameter_change == 2
    for i = 1 : 10
        legend_labels{i} =  ['me' num2str(i-10)];
    end
    for i = 10 : 20
        legend_labels{i} =  ['me+' num2str(i-10)];
    end
elseif parameter_change == 1
    for i = 1 : 5
        legend_labels{i} =  ['se' num2str(i-5)];
    end
    for i = 6 : 10
        legend_labels{i} =  ['se+' num2str(i-5)];
    end
elseif parameter_change == 3
    for i = 1 : n
        legend_labels{i} = ['mt=' mat2str(0.052 - 2 * st(i))];
    end
else
end

%% 
% figure(1)
% for i = 1 : n
%     plot(t, E_result2(:, i), 'Color', color(i, :))
%     hold on
% end
% xlabel("Time");
% ylabel("Amplitude");
% title(strcat("Pulse signal with ", name));
% legend(legend_labels);

figure(2)
plot(0.052 - 2 * eval(parameter_value(parameter_change, :)), max(envelope(E_result1)))
hold on
plot(0.052 - 2 * eval(parameter_value(parameter_change, :)), max(envelope(E_result2)))
title(name);
xlabel('muscle thickness');
ylabel("Amplitude max");

figure(3)
plot(0.052 - 2 * eval(parameter_value(parameter_change, :)), max(envelope(E_result2)) - max(envelope(E_result1)))
title(name);
xlabel('muscle thickness');
ylabel("Amplitude different");

figure(4)
plot(0.052 - 2 * eval(parameter_value(parameter_change, :)), delay2)
hold on
plot(0.052 - 2 * eval(parameter_value(parameter_change, :)), delay1)
title(name);
xlabel('muscle thickness');
ylabel("Amplitude max");

figure(5)
plot(0.052 - 2 * eval(parameter_value(parameter_change, :)), delay2 - delay1)
title(name);
xlabel('muscle thickness');
ylabel("Amplitude different");