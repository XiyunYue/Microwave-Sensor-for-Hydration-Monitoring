%% 系数输入
n = 11; %数据个数
n_start = 18;%开始天线节数
a1 = n_start - 1;%简化调用函数

%% 设置空矩阵
fre_syntony_test = zeros(n, 1);
fre_syntony_calculate = zeros(n, 1);
amplitude_syntony_test = zeros(n, 1);
bandwidth = zeros(n, 1);
num_antenna = n_start : n_start + n - 1;
color = zeros(n, 3);
phase = zeros(n, 1);

%% 设置data矩阵
file_start = strcat ('230123_dipole_',int2str(n_start) ,'_no');
A = readmatrix(file_start);
fre_data = zeros(length(A), 2 * n + 1);
amplitude = zeros(length(A), n);
fre_data(:, 1) = A(:, 1);
x = fre_data(:, 1);

%% 导入参数
for i = n_start : n_start + n - 1
    file_name = strcat ('230123_dipole_', int2str(i) ,'_no');
    A = readmatrix(file_name);
    fre_data(:, [2 * i - a1 * 2, 2 * i - a1 * 2 + 1]) = A(:, [2, 3]);
    [bandwidth(i - a1), amplitude(:, i - a1), phase(i - a1), ...
       amplitude_syntony_test(i - a1), fre_syntony_test(i - a1), ...
       fre_syntony_calculate(i - a1)] = new_function(i, ...
       fre_data(:, [1, 2 * i - a1 * 2, 2 * i - a1 * 2 + 1]));
end


%% 颜色设置
for i = 1 : n
    color(i,:)=[i/n 0 1];
end

%% 画图
figure (1)
for i=1:11
    plot(fre_data(:, 1), amplitude(:, i), 'color', color(i,:));
    hold on
end
legend('18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28');
xlabel('frequency');
ylabel('dB');
title("Attenuation amplitude(dB) of different numbers antennas nodes");

% plot(fre_data(:, 1), amplitude(:, :));
% % hold on
% % plot(fre_data(:, 1), freq_3dB);
% xlabel('frequency');
% ylabel('dB');
% legend('18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28');

figure (2)
plot(num_antenna, fre_syntony_calculate,'ro-', 'MarkerFaceColor','r');
xlabel('The number of nodes of the antenna');
ylabel('frequency');
hold on
plot(num_antenna, fre_syntony_test, 'go-', 'MarkerFaceColor', 'g');
legend('Expected resonant frequency', 'Measured resonance frequency');
title("Comparison of expected and actual resonant frequency")

figure (3)
plot(num_antenna, amplitude_syntony_test);
xlabel('The number of nodes of the antenna');
ylabel('syntony amplitude(dB)');
title("The attenuation amplitude when resonates")

figure (4)
plot(num_antenna, phase);
xlabel('The number of nodes of the antenna');
ylabel('syntony phase(rad)');
title("The attenuation phase when resonates")

figure (5)
plot(num_antenna, bandwidth);
xlabel('The number of nodes of the antenna');
ylabel('bandwidth');
title("3dB Bandwidth of Different Antennas")