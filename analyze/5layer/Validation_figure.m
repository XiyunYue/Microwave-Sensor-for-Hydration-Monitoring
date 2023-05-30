%% 信号
freq = 0:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% 皮肤厚度
skin_eps = 30;
muscle_eps = 50;
skin_thickness = 0.001 : 0.0005 : 0.003;
muscle_thickness = 0.05;

n_freq = length(freq);
n_st = length(skin_thickness);
E_amplitude_st = zeros(n_st, n_freq);
for i = 1 : n_freq
    for j = 1 : n_st
        [E_output, t_output] = Transmission5layer(freq(i), SIG, ...
            skin_eps, muscle_eps, skin_thickness(j), muscle_thickness);
        E_result = 2 * merit.process.fd2td(E_output, freq, t);
        E_amplitude_st(j, i) = max(envelope(E_result));    
    end
end

n = length(skin_thickness);
color = zeros(n, 3);
for i = 1 : n
    color(i,:)=[i/n (n - i)/n (n - i)/n];
end

figure(1)
for i = 1 : n_st
    plot(freq, E_amplitude_st(i, :), 'Color', color(i, :))
    hold on
end
xlabel("Frequency");
ylabel("Amplitude");
legend('1mm', '1.5mm', '2mm', '2.5mm', '3mm');
title('Different skin thickness');
diff_st = abs(E_amplitude_st(1, :) - E_amplitude_st(n_st, :));
x_st = freq(find(diff_st == max(diff_st)));
y_st = max(diff_st);

figure(2)
plot(freq, diff_st)
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
%         [E_output, t_output] = Transmission5layer(freq(i), SIG, ...
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
% figure(1)
% for i = 1 : n_mt
%     plot(freq, E_amplitude_mt(i, :), 'Color', color(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude");
% legend('3cm', '4mm', '5mm', '6mm', '7mm');
% title('Different muscle thickness');
% diff_mt = abs(E_amplitude_mt(1, :) - E_amplitude_mt(n_mt, :));
% x_mt = freq(find(diff_mt == max(diff_mt)));
% y_mt = max(diff_mt);
% 
% figure(2)
% plot(freq, diff_mt)
% xlabel("Frequency");
% ylabel("Amplitude difference");
% title('Amplitude difference in different frequency');

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
%         [E_output, t_output] = Transmission5layer(freq(i), SIG, ...
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
% legend('25mm', '27mm', '29mm', '31mm', '33mm', '35mm');
% title('Different skin Permittivity');
% diff_se = abs(E_amplitude_se(1, :) - E_amplitude_se(n_se, :));
% x_se = freq(find(diff_se == max(diff_se)));
% y_se = max(diff_se);
% 
% figure(2)
% plot(freq, diff_se)
% xlabel("Frequency");
% ylabel("Amplitude difference");
% title('Amplitude difference in different frequency');

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
%         [E_output, t_output] = Transmission5layer(freq(i), SIG, ...
%             skin_eps, muscle_eps(j), skin_thickness, muscle_thickness);
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
% title('Different muscle Permittivity');
% diff_me = E_amplitude_me(1, :) - E_amplitude_me(n_me, :);
% x_me = freq(find(diff_me == min(diff_me)));
% y_me = max(diff_me);
% disp(x_me)
% figure(2)
% plot(freq, diff_me)
% % hold on 
% % plot(freq, abs(diff_me))
% xlabel("Frequency");
% ylabel("Amplitude difference");
% title('Amplitude difference in different frequency');