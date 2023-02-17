function [bandwidth, amplitude, amplitude_syntony, fre_syntony] = cst_function(n, dipole)
freq = 10^9 * dipole(:, 1);
amplitude = dipole(:, 2);

sit = find(amplitude == min(amplitude));
fre_syntony = freq(sit);
amplitude_syntony = amplitude(sit);

amplitude_3dB = amplitude_syntony + 3;
freq_3dB_point1 = freq(find(abs(amplitude(1: sit) - amplitude_3dB) == ...
    min(abs(amplitude(1: sit) - amplitude_3dB))));
freq_3dB_point2 = freq(sit + find(abs(amplitude(sit: end) - amplitude_3dB) == ...
    min(abs(amplitude(sit: end) - amplitude_3dB))));
bandwidth = freq_3dB_point2 - freq_3dB_point1;
end