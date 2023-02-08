% function [bandwidth, amplitude, amplitude_syntony_test, fre_syntony_test, fre_syntony_calculate] = thin(n, dipole)
function [L, amplitude, amplitude_syntony_test, fre_syntony_test, fre_syntony_calculate] = thin(n, dipole)
c = 3 * (10 ^ 8);
L = 9 * n + 8;
wavelength = L * 4 * 10 ^ ( - 3);
freq = dipole(:, 1);
amplitude_real = dipole(:, 2);
amplitude_image = dipole(:, 3);
amplitude = mag2db(abs(amplitude_real + amplitude_image * 1i));

sit = find(amplitude == min(amplitude(1:200)));
fre_syntony_test = freq(sit);
amplitude_syntony_test = amplitude(sit);

% freq_10dB_point1 = freq(find(abs(amplitude(1: sit) + 10) == ...
%     min(abs(amplitude(1: sit) + 10))));
% freq_10dB_point2 = freq(sit + find(abs(amplitude(sit: end) + 10) == ...
%     min(abs(amplitude(sit: end) + 10))));
% bandwidth = freq_10dB_point2 - freq_10dB_point1;


% figure(n)
% plot(freq, d)

fre_syntony_calculate = c / wavelength;

end