function [bandwidth, amplitude, amplitude_syntony_test, fre_syntony_test, fre_syntony_calculate] = thick(n, mono)
c = 3 * (10 ^ 8);
wavelength = (3 * n + 5) * 4 * 10 ^ ( - 3);
freq = mono(:, 1);
amplitude_real = mono(:, 2);
amplitude_image = mono(:, 3);
amplitude = mag2db(abs(amplitude_real + amplitude_image * j));

sit = find(amplitude == min(amplitude));
fre_syntony_test = freq(sit);
amplitude_syntony_test = amplitude(sit);

freq_10dB_point1 = freq(find(abs(amplitude(1: sit) + 10) == ...
    min(abs(amplitude(1: sit) + 10))));
freq_10dB_point2 = freq(sit + find(abs(amplitude(sit: end) + 10) == ...
    min(abs(amplitude(sit: end) + 10))));
bandwidth = freq_10dB_point2 - freq_10dB_point1;


fre_syntony_calculate = c / wavelength;

end