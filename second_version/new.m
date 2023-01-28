fre_syntony_test = zeros(11, 1);
fre_syntony_calculate = zeros(11, 1);
amplitude_syntony_test = zeros(11, 1);
bandwidth = zeros(11, 1);
num_antenna = 18 : 28;
file_18 = strcat ('230123_dipole_',int2str(18) ,'_no');
A = readmatrix(file_18);
fre_data = zeros(length(A), 23);
amplitude = zeros(length(A), 11);
fre_data(:, 1) = A(:, 1);

for n = 18 : 28
    file_name = strcat ('230123_dipole_', int2str(n) ,'_no');
    A = readmatrix(file_name);
    fre_data(:, [2 * n - 34, 2 * n - 33]) = A(:, [2, 3]);
    [bandwidth(n - 17), amplitude(:, n - 17), amplitude_syntony_test(n - 17), fre_syntony_test(n - 17), fre_syntony_calculate(n - 17)] = new_function(n, fre_data(:, [1, 2 * n - 34, 2 * n - 33]));
end

figure (1)
plot(fre_data(:, 1), amplitude(:, :));
xlabel('frequency');
ylabel('dB');

figure (2)
plot(num_antenna, fre_syntony_calculate,'ro-', 'MarkerFaceColor','r');
xlabel('The number of nodes of the antenna');
ylabel('frequency');
hold on
plot(num_antenna, fre_syntony_test, 'go-', 'MarkerFaceColor', 'g');
legend('Expected resonant frequency', 'Actual measured resonance frequency');

figure (3)
plot(num_antenna, amplitude_syntony_test);
xlabel('The number of nodes of the antenna');
ylabel('syntony amplitude');

figure (4)
plot(num_antenna, bandwidth);
xlabel('The number of nodes of the antenna');
ylabel('bandwidth');