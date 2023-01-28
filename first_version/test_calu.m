function [fre_syntony_test, fre_syntony_calculate] = test_calu(n, dipole)
c = 3 * (10 ^ 8);
wavelength = (4 + 2 * 3 * n + 1.5) * 2 * 10 ^ ( - 3);
freq = dipole(:, 1);
amplitude_real = dipole(:, 2);
amplitude_image = dipole(:, 3);
amplitude = sqrt(amplitude_real .^ 2 + amplitude_image .^ 2);
% 
% figure (n)
% plot(freq,amplitude,'r')

fre_syntony_test = freq(find(amplitude == min(amplitude)));

fre_syntony_calculate = c / wavelength;

end