%% Coefficient input
n = 11; %data volume
n_start = 18;%Minimum Antenna Sections
a1 = n_start - 1;%Simplify calling functions

%% set empty matrix
num_antenna = n_start : n_start + n - 1;
color = zeros(n, 3);
phase = zeros(n, 1);
L = zeros(n, 1);

%% set empty matrix for cst
fre_syntony_cst = zeros(n, 1);
fre_syntony_cst_calculate = zeros(n, 1);
amplitude_syntony_cst = zeros(n, 1);
bandwidth_cst = zeros(n, 1);

%% set empty matrix for test
fre_syntony_test = zeros(n, 1);
fre_syntony_test_calculate = zeros(n, 1);
amplitude_syntony_test = zeros(n, 1);
bandwidth_test = zeros(n, 1);

%% Set the data matrix for test
file_start_test = strcat ('230123_dipole_',int2str(n_start) ,'_no');
A = readmatrix(file_start_test);
fre_data_test = zeros(length(A), 2 * n + 1);
amplitude_test = zeros(length(A), n);
fre_data_test(:, 1) = A(:, 1);
% x = fre_data_test(:, 1);

%% Set the data matrix for cst
file_start_cst = strcat (int2str(n_start));
B = readmatrix(file_start_cst);
fre_data_cst = zeros(length(B), 2 * n + 1);
amplitude_cst = zeros(length(B), n);
fre_data_cst(:, 1) = 10^9 * B(:, 1);

%% use function for test
for i = n_start : n_start + n - 1
    file_name_test = strcat ('230123_dipole_', int2str(i) ,'_no');
    A = readmatrix(file_name_test);
    fre_data_test(:, [2 * i - a1 * 2, 2 * i - a1 * 2 + 1]) = A(:, [2, 3]);
    [L(i - a1), bandwidth_test(i - a1), amplitude_test(:, i - a1), phase(i - a1), ...
       amplitude_syntony_test(i - a1), fre_syntony_test(i - a1), ...
       fre_syntony_test_calculate(i - a1)] = new_function(i, ...
       fre_data_test(:, [1, 2 * i - a1 * 2, 2 * i - a1 * 2 + 1]));
end

%% use function for cst
for i = n_start : n_start + n - 1
    file_name_cst = strcat (int2str(i));
    B = readmatrix(file_name_cst);
    fre_data_cst(:, i - a1 + 1) = B(:, 2);
    [bandwidth_cst(i - a1), amplitude_cst(:, i - a1), ...
        amplitude_syntony_cst(i - a1), fre_syntony_cst(i - a1)] = ...
        cst_function(i, B);
end

%% color settings
for i = 1 : n
    color(i,:)=[i/n 0 1];
end

%% Image display for test
figure (1)
for i=1:11
    plot(fre_data_test(:, 1), amplitude_test(:, i), 'color', color(i,:));
    hold on
end
legend('18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28');
% legend('L(1)', 'L(2)', 'L(3)', 'L(4)', 'L(5)', 'L(6)', 'L(7)', 'L(8)', 'L(9)', 'L(10)', 'L(11)');
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
plot(L, fre_syntony_test_calculate,'ro-', 'MarkerFaceColor','r');
hold on
plot(L, fre_syntony_test, 'go-', 'MarkerFaceColor', 'g');
hold on
plot(L, fre_syntony_cst, 'bo-', 'MarkerFaceColor', 'b');
xlabel('The length of the antenna');
ylabel('frequency');
title("Comparison of expected and actual resonant frequency");
legend('Expected resonant frequency', 'Measured resonance frequency','CST resonance frequency');

figure (3)
plot(L, amplitude_syntony_test, 'ro-', 'MarkerFaceColor', 'r');
hold on
plot(L, amplitude_syntony_cst, 'bo-', 'MarkerFaceColor', 'b');
xlabel('The length of the antenna');
ylabel('syntony amplitude(dB)');
title("The attenuation amplitude when resonates")

% 
% figure (4)
% plot(L, phase);
% xlabel('The length of the antenna');
% ylabel('syntony phase(rad)');
% title("The attenuation phase when resonates")

figure (4)
plot(L, bandwidth_test, 'ro-', 'MarkerFaceColor', 'r');
hold on
plot(L, bandwidth_cst, 'bo-', 'MarkerFaceColor', 'b');
xlabel('The length of the antenna');
ylabel('bandwidth');
title("3dB Bandwidth of Different Antennas")

%% Image display for test
figure (5)
for i=1:11
    plot(fre_data_cst(:, 1), amplitude_cst(:, i), 'color', color(i,:));
    hold on
end
legend('18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28');
% legend('L(1)', 'L(2)', 'L(3)', 'L(4)', 'L(5)', 'L(6)', 'L(7)', 'L(8)', 'L(9)', 'L(10)', 'L(11)');
xlabel('frequency');
ylabel('dB');
title("Attenuation amplitude(dB) of different numbers antennas nodes");