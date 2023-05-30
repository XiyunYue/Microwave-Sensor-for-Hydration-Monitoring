%% 信号
eps0 = 8.854 * 10^-12;
mu0 = 4 * pi * 10^-7 ;
sig = 4;
freq = 0:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% 变量
skin_eps = 30;
muscle_eps = 50;
skin_thickness = 0.002;
muscle_thickness = 0.05;
dis = 0 : 0.01 : 0.1;
n_freq = length(freq);
n_dis = length(dis);
E_amplitude_dis = zeros(n_st, n_freq);
for i = 1 : n_freq
    for j = 1 : n_dis
        [E_output, t_output] = withairbetween(freq(i), SIG, skin_eps,...
            muscle_eps, skin_thickness, muscle_thickness, dis(j));
        E_result = 2 * merit.process.fd2td(E_output, freq, t);
        E_amplitude_dis(j, i) = max(envelope(E_result));    
    end
end

n = length(dis);
color = zeros(n, 3);
for i = 1 : n
    color(i,:)=[i/n (n - i)/n (n - i)/n];
end

figure(1)
for i = 1 : n_dis
    plot(freq, E_amplitude_dis(i, :), 'Color', color(i, :))
    hold on
end
xlabel("Frequency");
ylabel("Amplitude");
legend('0mm', '1cm', '2cm', '3mm', '4mm', '5cm', '6cm', '7mm', '8mm', '9mm', '10mm');
title('Different air distance');
diff_dis = E_amplitude_dis(1, :) - E_amplitude_dis(n_dis, :);
x_dis = freq(find(diff_dis == max(diff_dis)));
y_dis = max(diff_dis);

figure(2)
plot(freq, diff_dis)
xlabel("Frequency");
ylabel("Amplitude difference");
title('Amplitude difference in different frequency');

%% 肌肉
% skin_eps = 30;
% muscle_eps = 50;
% skin_thickness = 0.002;
% muscle_thickness = 0.03 : 0.01 : 0.07;
% n_freq = length(freq);
% n_mt = length(muscle_thickness);
% E_amplitude_mt = zeros(n_mt, n_freq);
% for i = 1 : n_freq
%     for j = 1 : n_mt
%         [E_output, t_output] = withairbetween(freq(i), SIG, skin_eps,...
%             muscle_eps, skin_thickness, muscle_thickness(j), dis);
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
% figure(1)
% for i = 1 : n_mt
%     plot(freq, E_amplitude_mt(i, :), 'Color', color(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude");
% legend('3cm', '4mm', '5mm', '6mm', '7mm');

%% 皮肤介电常数
% skin_eps = 25 : 2 : 35;
% % muscle_eps = 40 : 5 : 60;
% muscle_eps = 50;
% skin_thickness = 0.002;
% muscle_thickness = 0.05;
% n_freq = length(freq);
% n_se = length(skin_eps);
% E_amplitude_se = zeros(n_se, n_freq);
% 
% for i = 1 : n_freq
%     for j = 1 : n_se
%         [E_output, t_output] = withairbetween(freq(i), SIG, skin_eps(j),...
%             muscle_eps, skin_thickness, muscle_thickness);
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
% legend('25mm', '27mm', '29mm', '31mm', '33mm', '35mm');

%% 肌肉介电常数
% skin_eps = 30;
% muscle_eps = 40 : 5 : 60;
% skin_thickness = 0.002;
% muscle_thickness = 0.05;
% n_freq = length(freq);
% n_me = length(muscle_eps);
% E_amplitude_me = zeros(n_me, n_freq);
% 
% for i = 1 : n_freq
%     for j = 1 : n_me
%         [E_output, t_output] = withairbetween(freq(i), SIG, skin_eps,...
%             muscle_eps(j), skin_thickness, muscle_thickness);
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_me(j, i) = max(envelope(E_result));    
%     end
% end
% 
% n = length(muscle_eps);
% color = zeros(n, 3);
% for i = 1 : n
%     color(i,:)=[i/n (n - i)/n (n - i)/n];
% end
% 
% figure(1)
% for i = 1 : n_me
%     plot(freq, E_amplitude_me(i, :), 'Color', color(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude");
% legend('40mm', '45mm', '50mm', '55mm', '60mm');