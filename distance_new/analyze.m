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
amplitude_subtract_complex = zeros(1001, n);
% t = linspace(0, (length(freq) - 1) / (freq(2) - freq(1)), length(freq));
% y = exp(-(t - 1e-4).^2/2e-5^2);
% sig = y.*sin(2*pi*2e5*t);
% sig_f = fft(sig);
% plot(t, sig);
% t = 0 : 1 / (freq(2) - freq(1)) : (length(freq) - 1) / (freq(2) - freq(1));
for i = 1 : n
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
%     Y(:, i) = real(ifft(amplitude_subtract_complex(:, i)));
%     Y(:, i) = ifft(amplitude_subtract_complex);
%     Z(:, i) = conv(Y(:, i), amplitude_subtract(:, i));
%     f_sin = fftshift(fft(sin(2*pi*2e9*t)));
%     h = sig_f .* amplitude_real_subtract(:, i)';
%     Z(:, i) = ifft(h);
%     Y(:, i) = ifft(amplitude_subtract_complex(:, i));
end

% Z = Y.*sin(2*pi*2e9*t);
% 
% for i = 1 : n
%     amplitude_real_subtract(:, i) = amplitude(:, i + 1) - amplitude(:, 1);
% end

% color = zeros(n, 3);
% for i = 1 : n
%     color(i,:)=[i/n (n-i)/n i/(2 * n)];
% end

color = ['r','g','b','c','m','y','k'];

figure (1)
for i = 1 : n
    plot(freq,  amplitude(:, i), color(i));
    hold on
end
legend('d = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60', 'd = 70');

figure (2)
for i = 1 : n
    plot(freq,  phase(:, i), color(i));
    hold on
end
legend('d = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60', 'd = 70');

figure (3)
for i = 1 : n
    plot(freq,  mag2db(amplitude_subtract(:, i)), color(i));
    hold on
end
legend('d = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60', 'd = 70');

figure (4)
for i = 1 : n
    plot(freq,  phase_subtract(:, i), color(i));
    hold on
end
legend('d = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60', 'd = 70');

% figure (5)
% for i = 1 : n
% %     figure (i + 4)
% %     plot(t(2 : 100),  Y(2 : 100, i), color(i));
%     plot(t,  Y(: , i), color(i));
%     hold on
% end
% legend('d = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60', 'd = 70');
% 
% figure (5)
% for i = 1 : n
%     plot(Z(:, i), color(i));
%     hold on
% end
% legend('d = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60', 'd = 70');

% figure (6)
% for i = 1 : n
% %     figure (i + 4)
% %     plot(t(2 : 100),  Y(2 : 100, i), color(i));
%     plot(t,  Y(: , i), color(i));
%     hold on
% end
% legend('d = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60', 'd = 70');



% t = 0:1e-10:10e-9;
% 
% y = exp(-(t).^2/1e-9^2);
% 
% sig = y.*sin(2*pi*2e9*t);
% 
% plot(t, sig);

