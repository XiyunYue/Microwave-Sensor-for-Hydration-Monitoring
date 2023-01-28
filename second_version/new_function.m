function [bandwidth, amplitude, amplitude_syntony_test, fre_syntony_test, fre_syntony_calculate] = new_function(n, dipole)
c = 3 * (10 ^ 8);
wavelength = (4 + 2 * 3 * n + 1.5) * 2 * 10 ^ ( - 3);
freq = dipole(:, 1);
amplitude_real = dipole(:, 2);
amplitude_image = dipole(:, 3);
amplitude = 10 * log(sqrt(amplitude_real .^ 2 + amplitude_image .^ 2));
amplitude_3dB = amplitude + 3;
% figure (n - 17)
% plot(freq, amplitude,'r')

fre_syntony_test = freq(find(amplitude == min(amplitude)));
amplitude_syntony_test = amplitude(find(amplitude == min(amplitude)));
freq_3dB = freq(find(abs(amplitude_3dB) == min(abs(amplitude_3dB))));
bandwidth = freq_3dB(1) - freq_3dB(2);
fre_syntony_calculate = c / wavelength;

end