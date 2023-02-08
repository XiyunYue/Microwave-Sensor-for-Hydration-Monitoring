%% Coefficient input
n = 11; %data volume
n_start = 18;%Minimum Antenna Sections
a1 = n_start - 1;%Simplify calling functions

%% set empty matrix
fre_syntony_test = zeros(n, 1);
fre_syntony_calculate = zeros(n, 1);
amplitude_syntony_test = zeros(n, 1);
bandwidth = zeros(n, 1);
num_antenna = n_start : n_start + n - 1;
color = zeros(n, 3);
phase = zeros(n, 1);
L = zeros(n, 1);

%% Set the data matrix
file_start = strcat ('230123_dipole_',int2str(n_start) ,'_no');
A = readmatrix(file_start);
fre_data = zeros(length(A), 2 * n + 1);
amplitude = zeros(length(A), n);
fre_data(:, 1) = A(:, 1);
x = fre_data(:, 1);

%% use function
for i = n_start : n_start + n - 1
    file_name = strcat ('230123_dipole_', int2str(i) ,'_no');
    A = readmatrix(file_name);
    fre_data(:, [2 * i - a1 * 2, 2 * i - a1 * 2 + 1]) = A(:, [2, 3]);
    [L(i - a1), bandwidth(i - a1), amplitude(:, i - a1), phase(i - a1), ...
       amplitude_syntony_test(i - a1), fre_syntony_test(i - a1), ...
       fre_syntony_calculate(i - a1)] = new_function(i, ...
       fre_data(:, [1, 2 * i - a1 * 2, 2 * i - a1 * 2 + 1]));
end


%% color settings
for i = 1 : n
    color(i,:)=[i/n 0 1];
end

%% Image display
figure (1)
for i=1:11
    plot(fre_data(:, 1), amplitude(:, i), 'color', color(i,:));
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
plot(L, fre_syntony_calculate,'ro-', 'MarkerFaceColor','r');
xlabel('The length of the antenna');
ylabel('frequency');
hold on
plot(L, fre_syntony_test, 'go-', 'MarkerFaceColor', 'g');
legend('Expected resonant frequency', 'Measured resonance frequency');
title("Comparison of expected and actual resonant frequency")

figure (3)
plot(L, amplitude_syntony_test);
xlabel('The length of the antenna');
ylabel('syntony amplitude(dB)');
title("The attenuation amplitude when resonates")

figure (4)
plot(L, phase);
xlabel('The length of the antenna');
ylabel('syntony phase(rad)');
title("The attenuation phase when resonates")

figure (5)
plot(L, bandwidth);
xlabel('The length of the antenna');
ylabel('bandwidth');
title("3dB Bandwidth of Different Antennas")