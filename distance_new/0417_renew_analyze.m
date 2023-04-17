

n = 7;
A = readmatrix("0");
freq = 10^9 * A(:, 1);
amplitude = zeros(length(A(:, 1)), n);
phase = zeros(length(A(:, 1)), n);
real_zero = A(:, 2);
image_zeros = A(:, 3);
amplitude_subtract = zeros(length(A(:, 1)), n);
phase_subtract = zeros(length(A(:, 1)), n);
Y = zeros(length(A(:, 1)), n);
Z = zeros(1001, n);
amplitude_complex = zeros(1001, n);
pesponse_time = zeros(1001, n); 
pesponse_freq = zeros(1001, n); 
amplitude_subtract_complex = zeros(1001, n);
max_f = 8e9;
t_length = max_f./(freq(2) - freq(1));

% t = linspace(0, (length(freq) - 1) / (freq(2) - freq(1dif)), length(freq));
t = (0 : t_length+1)*(1./max_f);
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2.5e9 * t);
SIG = mag2db(abs(fft(sig)));
f = 8e9 * (0:(t_length/2))/t_length;
sig_f_real = real(sig_f);
sig_f_imag = imag(sig_f);

for i = 1 : 2
    filename = strcat (int2str(i * 10));
    A = readmatrix(filename);
    amplitude_real = A(:, 2);
    amplitude_image = A(:, 3);
    amplitude_complex(:, i) = amplitude_real + 1j * amplitude_image;
    amplitude_real_subtract = A(:, 2) - real_zero;
    amplitude_image_subtract = A(:, 3) - image_zeros;
    amplitude(:, i) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
    phase(:, i) = (180 / pi) * unwrap(angle(amplitude_image * 1j + amplitude_real));
    amplitude_subtract_complex(:, i) = amplitude_image_subtract * 1j + amplitude_real_subtract;
    amplitude_subtract(:, i) = sqrt((amplitude_real_subtract).^2 + (amplitude_image_subtract).^2);
    phase_subtract(:, i) = (180 / pi) * unwrap(angle(amplitude_subtract_complex(:, i)));
    pesponse_freq(:, i) = SIG(1:1001) .* amplitude_subtract_complex(:, i)';
    pesponse_time(:, i) = real(fftshift(ifft(pesponse_freq(:, i))));
end

color = ['r','g','b','c','m','y','k'];
figure (5)
for i = 1 : n
    plot(t(1:1001), pesponse_time(:, i), color(i));
    hold on
end
legend('d = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60', 'd = 70');

