%% 生成信号
freq = 0:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% 参数变换范围
skin_eps = 25 : 1 : 35;
muscle_eps = 40 : 60;
skin_thickness = 1 : 1 : 3;
muscle_thickness = 30 : 2 : 70;

%% 计算skin_eps不同参数
amplitude_max_eps = zeros(length(skin_eps), length(muscle_eps));
time_of_arrivel_eps = zeros(length(skin_eps), length(muscle_eps));
for j = 1 : length(muscle_eps)
    for i = 1 : length(skin_eps)
        [E_output, t_output] = Transmission3layer(SIG, skin_eps(i), muscle_eps(j), 2, 50);
        E_result = 2 * merit.process.fd2td(E_output, freq, t);
        y = envelope(E_result);
        amplitude_max_eps(i, j) = y(find(y == max(y)));
        time_of_arrivel_eps(i, j) = t_output;
    end
end

n = length(skin_eps);
color = zeros(n, 3);
for i = 1 : n
    color(i,:) =  [i/n (n - i)/n (n - i)/n];
end

% figure (1)
% set(gcf, 'Position', [100, 100, 6*dpi, 8*dpi]);
% for i = 1 : n
%     plot(muscle_eps, amplitude_max_eps(i, :), 'Color', color(i, :));
%     hold on
% end
% xlabel("muscle eps");
% ylabel("amplitude max");
% legend('25', '26', '27', '28', '29', '30', '31', '32','33', '34', '35');

figure (2)
for i = 1 : n
    plot(muscle_eps, time_of_arrivel_eps(i, :), 'Color', color(i, :));
    hold on
end
xlabel("muscle eps");
ylabel("time of arrivel");
legend('25', '26', '27', '28', '29', '30', '31', '32','33', '34', '35');

%% 计算thickness不同参数
% amplitude_max_tn = zeros(length(skin_thickness), length(muscle_thickness));
% time_of_arrivel_tn = zeros(length(skin_thickness), length(muscle_thickness));
% for j = 1 : length(muscle_thickness)
%     for i = 1 : length(skin_thickness)
%         [E_output, t_output] = Transmission3layer(SIG, 30, 50, skin_thickness(i), muscle_thickness(j));
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         y = envelope(E_result);
%         amplitude_max_tn(i, j) = y(find(y == max(y)));
%         time_of_arrivel_tn(i, j) = t_output;
%     end
% end
% 
% n = length(skin_thickness);
% color = zeros(n, 3);
% for i = 1 : n
%     color(i, :) = [i/n, (n - i)/n, (n - i)/n];
% end
% 
% figure (1)
% for i = 1 : n
%     plot(muscle_thickness, time_of_arrivel_tn(i, :), 'Color', color(i, :));
%     hold on
% end
% xlabel("muscle thickness");
% ylabel("time of arrivel");
% legend('2', '3', '4');
