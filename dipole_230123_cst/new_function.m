function [L, bandwidth, amplitude, phase_syntony_test, amplitude_syntony_test, fre_syntony_test, fre_syntony_calculate] = new_function(n, dipole)
c = 3 * (10 ^ 8);
L = 4 + 2 * 3 * n + 1.5;
wavelength = L * 2 * 10 ^ ( - 3);
freq = dipole(:, 1);
amplitude_real = dipole(:, 2);
amplitude_image = dipole(:, 3);
amplitude = mag2db(abs(amplitude_real + amplitude_image * 1i));

sit = find(amplitude == min(amplitude));
fre_syntony_test = freq(sit);
amplitude_syntony_test = amplitude(sit);

amplitude_3dB = amplitude_syntony_test + 3;
freq_3dB_point1 = freq(find(abs(amplitude(1: sit) - amplitude_3dB) == ...
    min(abs(amplitude(1: sit) - amplitude_3dB))));
freq_3dB_point2 = freq(sit + find(abs(amplitude(sit: end) - amplitude_3dB) == ...
    min(abs(amplitude(sit: end) - amplitude_3dB))));
bandwidth = freq_3dB_point2 - freq_3dB_point1;

phase_syntony_test = (180 / pi) * atan(amplitude_image(sit) / ...
    amplitude_real(sit));

fre_syntony_calculate = c / wavelength;

end