function [bandwidth, amplitude, phase_syntony_test, amplitude_syntony_test, fre_syntony_test, fre_syntony_calculate] = new_function(n, dipole)
c = 3 * (10 ^ 8);
wavelength = (4 + 2 * 3 * n + 1.5) * 2 * 10 ^ ( - 3);
freq = dipole(:, 1);
amplitude_real = dipole(:, 2);
amplitude_image = dipole(:, 3);
amplitude = 10 * log(sqrt(amplitude_real .^ 2 + amplitude_image .^ 2));


% d = amplitude ./ (-3);
% freq_3dB_point = freq(find(d > .99 & d < 1.01));
% % amplitude_3dB = amplitude + 3;
% % figure (n - 17)
% % plot(freq, amplitude,'r')
% % freq_3dB = -3 + 0 * freq;
% % d = amplitude ./ 3;
% % freq_3dB_point1 = find(d > .999 & d < 1.001  & freq < 1 * 10 ^ 9);
% % freq_3dB_point = @(freq) amplitude(freq) - freq_3dB(freq);
% % freq_3dB_point1 = freq_3dB_point(1);
% bandwidth = freq_3dB_point(2) - freq_3dB_point(1);

sit = find(amplitude == min(amplitude));
fre_syntony_test = freq(sit);
amplitude_syntony_test = amplitude(sit);
amplitude_3dB = amplitude_syntony_test + 3;
d = amplitude ./ amplitude_3dB;
% figure(n)
% plot(freq, d)
freq_3dB_point = freq(find(d > .9 & d < 1.1));
bandwidth = freq_3dB_point(2) - freq_3dB_point(1);

phase_syntony_test = (180 / pi) * atan(amplitude_image(sit) / ...
    amplitude_real(sit));
% freq_3dB = freq(find(abs(amplitude_3dB) == min(abs(amplitude_3dB))));
% bandwidth = freq_3dB(1) - freq_3dB(2);
% d = freq_3dB ./ 3;
% freq_3dB_point = find(d > .95 & d < 1.05);
% bandwidth = freq_3dB_point(1) - freq_3dB_point(2);

fre_syntony_calculate = c / wavelength;

end