%% 信号
freq = 5e8:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% mt时间关系
% skin_eps = 30;
% muscle_eps = 50;
% skin_thickness = 0.002;
% muscle_thickness = 0.03 : 0.001 : 0.07;
% n_freq = length(freq);
% n_mt = length(muscle_thickness);
% E_amplitude_mt = zeros(n_mt, n_freq);
% t_arrive = zeros(n_mt, 1);
% 
% for j = 1 : n_mt
%     for i = 1 : n_freq
%         [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
%             skin_eps, muscle_eps, skin_thickness, muscle_thickness(j));
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_mt(j, i) = max(envelope(E_result));    
%     end
%     t_arrive(j) = t_output;
% end
% 
% figure(1)
% plot(muscle_thickness, 1e12 * t_arrive)
% xlabel("Muscle thickness");
% % set(gca, 'XScale', 'log');
% ylabel("Time delay(ps)");
% title('Time delay with different muscle thickness');

%% st时间关系
% skin_eps = 30;
% muscle_eps = 50;
% skin_thickness = 0.001 : 0.0001 : 0.003;
% muscle_thickness = 0.05;
% n_freq = length(freq);
% n_st = length(skin_thickness);
% E_amplitude_st = zeros(n_st, n_freq);
% t_arrive = zeros(n_st, 1);
% 
% for j = 1 : n_st
%     for i = 1 : n_freq
%         [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
%             skin_eps, muscle_eps, skin_thickness(j), muscle_thickness);
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_st(j, i) = max(envelope(E_result));    
%     end
%     t_arrive(j) = t_output;
% end
% 
% figure(1)
% plot(skin_thickness, 1e12 * t_arrive)
% xlabel("Skin thickness");
% % set(gca, 'XScale', 'log');
% ylabel("Time delay(ps)");
% title('Time delay with different skin thickness');

%% 皮肤厚度
% skin_eps = 30;
% muscle_eps = 50;
% skin_thickness = 0.0005 : 0.0005 : 0.003;
% muscle_thickness = 0.05;
% 
% n_freq = length(freq);
% n_st = length(skin_thickness);
% E_amplitude_st = zeros(n_st, n_freq);
% diff_st = zeros(n_st - 1, n_freq);
% diff_pre = zeros(n_st - 1, n_freq);
% for i = 1 : n_freq
%     for j = 1 : n_st
%         [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
%             skin_eps, muscle_eps, skin_thickness(j), muscle_thickness);
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_st(j, i) = max(envelope(E_result));    
%     end
% end
% 
% n = length(skin_thickness);
% color = zeros(n, 3);
% for i = 1 : n
%     color(i,:)=[i/n (n - i)/n (n - i)/n];
% end
% 
% figure(1)
% for i = 1 : n_st
%     plot(freq, E_amplitude_st(i, :), 'Color', color(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude");
% % set(gca, 'XScale', 'log');
% % set(gca, 'YScale', 'log');
% legend('0.5mm', '1mm', '1.5mm', '2mm', '2.5mm', '3mm');
% title('Different skin thickness');
% 
% 
% for i = 1 : n_st - 1
%     diff_st(i, :) = abs(E_amplitude_st(i, :) - E_amplitude_st(i + 1, :));
%     diff_pre(i, :) = diff_st(i, :) ./ E_amplitude_st(i + 1, :);
% %     x_st = freq(find(diff_st == max(diff_st)));
% %     y_st = max(diff_st);
% end
% 
% figure(2)
% for i = 1 : n_st - 1
%     plot(freq, diff_pre(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude difference in present");
% % set(gca, 'XScale', 'log');
% % set(gca, 'YScale', 'log');
% % legend('1mm', '1.5mm', '2mm', '2.5mm', '3mm');
% title('Amplitude difference in present in different frequency');

%% 肌肉
% skin_eps = 30;
% muscle_eps = 50;
% skin_thickness = 0.002;
% muscle_thickness = 0.03 : 0.01 : 0.07;
% n_freq = length(freq);
% n_mt = length(muscle_thickness);
% E_amplitude_mt = zeros(n_mt, n_freq);
% t_output = zeros(n_mt);
% 
% diff_mt = zeros(n_mt - 1, n_freq);
% diff_pre = zeros(n_mt - 1, n_freq);
% 
% for i = 1 : n_freq
%     for j = 1 : n_mt
%         [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
%             skin_eps, muscle_eps, skin_thickness, muscle_thickness(j));
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_mt(j, i) = max(envelope(E_result));    
%     end
% end
% 
% n = length(muscle_thickness);
% color = zeros(n, 3);
% for i = 1 : n
%     color(i,:)=[i/n (n - i)/n (n - i)/n];
% end
% 
% 
% figure(1)
% for i = 1 : n_mt
%     plot(freq, E_amplitude_mt(i, :), 'Color', color(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude");
% legend('3cm', '4cm', '5cm', '6cm', '7cm');
% title('Different muscle thickness');
% 
% for i = 1 : n_mt - 1
%     diff_mt(i, :) = E_amplitude_mt(i, :) - E_amplitude_mt(i + 1, :);
%     diff_pre(i, :) = diff_mt(i, :) ./ E_amplitude_mt(i + 1, :);
% end
% 
% 
% figure(2)
% for i = 1 : n_mt - 1
%     plot(freq, diff_pre(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude difference");
% legend('3-4cm', '4-5cm', '5-6cm', '6-7cm');
% title('Amplitude difference in different frequency');

%% 皮肤介电常数
% skin_eps = 25 : 2 : 35;
% muscle_eps = 50;
% skin_thickness = 0.002;
% muscle_thickness = 0.05;
% n_freq = length(freq);
% n_se = length(skin_eps);
% E_amplitude_se = zeros(n_se, n_freq);
% diff_se = zeros(n_se - 1, n_freq);
% diff_pre = zeros(n_se - 1, n_freq);
% 
% for i = 1 : n_freq
%     for j = 1 : n_se
%         [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
%             skin_eps(j), muscle_eps, skin_thickness, muscle_thickness);
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_se(j, i) = max(envelope(E_result));    
%     end
% end
% 
% n = length(skin_eps);
% color = zeros(n, 3);
% for i = 1 : n
%     color(i,:)=[i/n (n - i)/n (n - i)/n];
% end
% 
% figure(1)
% for i = 1 : n_se
%     plot(freq, E_amplitude_se(i, :), 'Color', color(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude");
% % set(gca, 'YScale', 'log');
% % set(gca, 'XScale', 'log');
% legend('25', '27', '29', '31', '33', '35');
% title('Different skin Permittivity');
% 
% for i = 1 : n_se - 1
%     diff_se(i, :) = abs(E_amplitude_se(i, :) - E_amplitude_se(i + 1, :));
%     diff_pre(i, :) = diff_se(i, :) ./ E_amplitude_se(i + 1, :);
% end
% 
% figure(2)
% plot(freq, diff_pre(i, :))
% xlabel("Frequency");
% ylabel("Amplitude difference");
% title('Amplitude difference in different frequency');

%% se时间关系
% skin_eps = 25 : 1 : 35;
% % muscle_eps = 40 : 5 : 60;
% muscle_eps = 50;
% skin_thickness = 0.002;
% muscle_thickness = 0.05;
% n_freq = length(freq);
% n_se = length(skin_eps);
% E_amplitude_mt = zeros(n_se, n_freq);
% t_arrive = zeros(n_se, 1);
% 
% for j = 1 : n_se
%     for i = 1 : n_freq
%         [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
%             skin_eps(j), muscle_eps, skin_thickness, muscle_thickness);
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_se(j, i) = max(envelope(E_result));    
%     end
%     t_arrive(j) = t_output;
% end
% 
% figure(1)
% plot(skin_eps, 1e12 * t_arrive)
% xlabel("Skin's Relative Permittivity");
% set(gca, 'XScale', 'log');
% ylabel("Time delay(ps)");
% title('Time delay with different skin permittivity');
% 
% 
% dx = diff(skin_eps);  % 计算x的差分
% dy = diff(1e12 * t_arrive);  % 计算y的差分
% slope = dy ./ dx;  % 斜率等于y的差分除以x的差分
% figure(2)
% plot(skin_eps(2 : end), slope)

%% me时间关系
% skin_eps = 30;
% muscle_eps = 40 : 5 : 60;
% skin_thickness = 0.002;
% muscle_thickness = 0.05;
% n_freq = length(freq);
% n_me = length(muscle_eps);
% E_amplitude_mt = zeros(n_me, n_freq);
% t_arrive = zeros(n_me, 1);
% 
% for j = 1 : n_me
%     for i = 1 : n_freq
%         [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
%             skin_eps, muscle_eps(j), skin_thickness, muscle_thickness);
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_me(j, i) = max(envelope(E_result));    
%     end
%     t_arrive(j) = t_output;
% end
% 
% figure(1)
% plot(muscle_eps, 1e12 * t_arrive)
% xlabel("Muscle's Relative Permittivity");
% set(gca, 'XScale', 'log');
% ylabel("Time delay(ps)");
% title('Time delay with different muscle permittivity');

%% 肌肉介电常数
skin_eps = 30;
muscle_eps = 40 : 5 : 60;
skin_thickness = 0.002;
muscle_thickness = 0.05;
n_freq = length(freq);
n_me = length(muscle_eps);
E_amplitude_me = zeros(n_me, n_freq);

diff_me = zeros(n_me - 1, n_freq);
diff_pre = zeros(n_me - 1, n_freq);
for i = 1 : n_freq
    for j = 1 : n_me
        [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
            skin_eps, muscle_eps(j), skin_thickness, muscle_thickness);
        E_result = 2 * merit.process.fd2td(E_output, freq, t);
        E_amplitude_me(j, i) = max(envelope(E_result));    
    end
end

n = length(muscle_eps);
color = zeros(n, 3);
for i = 1 : n
    color(i,:)=[i/n (n - i)/n (n - i)/n];
end

figure(2)
for i = 1 : n_me
    plot(freq, E_amplitude_me(i, :), 'Color', color(i, :))
    hold on
end
xlabel("Frequency");
ylabel("Amplitude");
legend('40', '45', '50', '55', '60');
title('Different muscle Permittivity');

for i = 1 : n_me - 1
    diff_me(i, :) = E_amplitude_me(i, :) - E_amplitude_me(i + 1, :);
    diff_pre(i, :) = diff_me(i, :) ./ E_amplitude_me(i + 1, :);
end

% figure(2)
% for i = 1 : n_me - 1
%     plot(freq, diff_pre(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude difference");
% legend('40-45mm', '45-50mm', '50-55mm', '55-60mm');
% title('Amplitude difference in different frequency');