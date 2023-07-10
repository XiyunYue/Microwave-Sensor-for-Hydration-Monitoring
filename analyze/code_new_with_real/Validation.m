%% 生成信号
freq = 0:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = 2 * merit.process.td2fd(sig', t, freq);
% figure(1)
% plot(sig)
% E_result1 = merit.process.fd2td(SIG, freq, t);
% figure(2)
% plot(E_result1)%直接乘2
%% 尝试运行函数
% [E_output, t_output] = Transmission3layer(SIG, 30, 30, 2, 40);
% E_result = merit.process.fd2td(E_output, freq, t);
% t_result = t + t_output;
% y = envelope(E_result);
% amplitude_max = y(find(y == max(y)));
% disp(amplitude_max)
% figure(1)
% plot(t, sig, 'g')
% hold on
% plot(t_result, E_result, 'b')
% hold on
% plot(t_result, y, 'r')
% xlabel("frequency");
% ylabel("signal_output");

%% 理想介质和理想导体
% [E_ref, E_tra] = math_ref(SIG, 1, 1);
% E_output = 2 * merit.process.fd2td(E_tra, freq, t);
% E_input = 2 * merit.process.fd2td(SIG, freq, t);
% y1 = envelope(E_input);
% x1 = max(y1);
% y2 = envelope(E_output);
% x2 = max(y2);
% disp(x1)
% disp(x2)

%% 如果系数一样，则应该等同于一层传播
% [E_output_3d, t_output] = Transmission3layer(SIG, 1, 1, 2, 300);%因为函数里默认从空气到皮肤了
% E_output_1d = math_att(SIG, 2e9, 304, 1);
% E_result3 = 2 * merit.process.fd2td(E_output_3d, freq, t);
% E_result1 = 2 * merit.process.fd2td(E_output_1d, freq, t);
% 
% % E_result = merit.process.fd2td(E_output_1d, freq, t);
% % plot(E_result)
% % x = find(max(E_result3));
% y1 = envelope(E_result1);
% x1 = max(y1);
% y2 = envelope(E_result3);
% x2 = max(y2);
% % amplitude_max = y(find(y == max(y)));
% disp(x1)
% disp(x2)
% figure(3)
% plot(t, E_result1, 'g')
% % hold on
% figure(4)
% plot(t, E_result3 , 'b')
% xlabel("frequency");
% ylabel("signal_output");
% 

%% 改变介电常数看是否影响
% [E_output1, t_output1] = Transmission3layer(SIG, 30, 50, 1, 40);
% [E_output2, t_output2] = Transmission3layer(SIG, 30, 100, 1, 40);
% E_result1 = 2 * merit.process.fd2td(E_output1, freq, t);
% E_result2 = 2 * merit.process.fd2td(E_output2, freq, t);
% y1 = envelope(E_result1);
% x1 = max(y1);
% y2 = envelope(E_result2);
% x2 = max(y2);
% disp(x1)
% disp(x2)
% figure(3)
% plot(t, envelope(E_result1), 'g')
% hold on
% plot(t, envelope(E_result2), 'b')
% xlabel("frequency");
% ylabel("signal_output");

%% 检查厚度函数
E_1 = att_decay(SIG, 2e9, 1, 30);
E_2 = att_decay(SIG, 2e9, 10, 30);
E_result1 = 2 * merit.process.fd2td(E_1, freq, t);
E_result2 = 2 * merit.process.fd2td(E_2, freq, t);
y1 = envelope(E_result1);
x1 = max(y1);
y2 = envelope(E_result2);
x2 = max(y2);
disp(x1)
disp(x2)
figure(3)
plot(t, envelope(E_result1), 'g')
hold on
plot(t, envelope(E_result2), 'b')
xlabel("frequency");
ylabel("signal_output");

%% 参数变换范围
skin_eps = 25 : 0.5 : 35;
muscle_eps = 40 : 60;
skin_thickness = 1 : 0.1 : 3;
muscle_thickness = 30 : 2 : 70;

%% 计算skin_eps不同参数
% amplitude_max = zeros(length(skin_eps), 1);
% time_of_arrivel = zeros(length(skin_eps), 1);
% for i = 1 : length(skin_eps)
%     k = skin_eps(i);
%     [E_output, t_output] = Transmission3layer(SIG, k, 50, 2, 50);
%     E_result = merit.process.fd2td(E_output, freq, t);
%     y = envelope(E_result);
%     amplitude_max(i) = y(find(y == max(y)));
%     time_of_arrivel(i) = t_output;
% end
% figure(1)
% plot(skin_eps, amplitude_max, 'g')
% xlabel("skin eps");
% ylabel("amplitude max");
% 
% figure(2)
% plot(skin_eps, time_of_arrivel, 'g')
% xlabel("skin eps");
% ylabel("TOA");

%% 计算muscle_eps不同参数
% amplitude_max = zeros(length(muscle_eps), 1);
% time_of_arrivel = zeros(length(muscle_eps), 1);
% for i = 1 : length(muscle_eps)
%     k = muscle_eps(i);
%     [E_output, t_output] = Transmission3layer(SIG, 30, k, 2, 50);
%     E_result = merit.process.fd2td(E_output, freq, t);
%     y = envelope(E_result);
%     amplitude_max(i) = y(find(y == max(y)));
%     time_of_arrivel(i) = t_output;
% end
% figure(1)
% plot(muscle_eps, amplitude_max, 'g')
% xlabel("muscle eps");
% ylabel("amplitude max");
% 
% figure(2)
% plot(muscle_eps, time_of_arrivel, 'r')
% xlabel("muscle eps");
% ylabel("TOA");

%% 计算skin_thickness不同参数
% amplitude_max = zeros(length(skin_thickness), 1);
% time_of_arrivel = zeros(length(skin_thickness), 1);
% for i = 1 : length(skin_thickness)
%     k = skin_thickness(i);
%     [E_output, t_output] = Transmission3layer(SIG, 30, 50, k, 50);
%     E_result = merit.process.fd2td(E_output, freq, t);
%     y = envelope(E_result);
%     amplitude_max(i) = y(find(y == max(y)));
%     time_of_arrivel(i) = t_output;
% end
% figure(1)
% plot(skin_thickness, amplitude_max, 'g')
% xlabel("skin thickness");
% ylabel("amplitude max");
% 
% figure(2)
% plot(skin_thickness, time_of_arrivel, 'r')
% xlabel("skin thickness");
% ylabel("TOA");

%% 计算muscle_thickness不同参数
% amplitude_max = zeros(length(muscle_thickness), 1);
% time_of_arrivel = zeros(length(muscle_thickness), 1);
% for i = 1 : length(muscle_thickness)
%     k = muscle_thickness(i);
%     [E_output, t_output] = Transmission3layer(SIG, 30, 50, 2, k);
%     E_result = merit.process.fd2td(E_output, freq, t);
%     y = envelope(E_result);
%     amplitude_max(i) = y(find(y == max(y)));
% %     amplitude_max(i) = max(E_result);
%     time_of_arrivel(i) = t_output;
% end
% figure(1)
% plot(muscle_thickness, amplitude_max, 'g')
% xlabel("muscle thickness");
% ylabel("amplitude max");
% 
% figure(2)
% plot(muscle_thickness, time_of_arrivel, 'r')
% xlabel("muscle thickness");
% ylabel("TOA");
