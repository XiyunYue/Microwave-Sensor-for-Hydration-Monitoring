
n = 7;
A = readmatrix("0");
freq = 10^9 * A(:, 1);
amplitude = zeros(length(A(:, 1)), n);
phase = zeros(length(A(:, 1)), n);
real_zero = A(:, 2);
image_zeros = A(:, 3);
amplitude_subtract = zeros(length(A(:, 1)), n);
phase_subtract = zeros(length(A(:, 1)), n);

for i = 0 : n
    filename = strcat (int2str(i * 10));
    A = readmatrix(filename);
    amplitude_real = A(:, 2);
    amplitude_image = A(:, 3);
    amplitude_real_subtract = A(:, 2) - real_zero;
    amplitude_image_subtract = A(:, 3) - image_zeros;
    amplitude(:, i + 1) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
    phase(:, i + 1) = (180 / pi) * unwrap(angle(amplitude_image * 1j + amplitude_real));
    amplitude_subtract(:, i + 1) = sqrt((amplitude_real_subtract).^2 + (amplitude_image_subtract).^2);
    phase_subtract(:, i + 1) = (180 / pi) * unwrap(angle(amplitude_image_subtract * 1j + amplitude_real_subtract));
end

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
legend('d = 0', 'd = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60');

figure (2)
for i = 1 : n
    plot(freq,  phase(:, i), color(i));
    hold on
end
legend('d = 0', 'd = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60');

figure (3)
for i = 1 : n
    plot(freq,  amplitude_subtract(:, i), color(i));
    hold on
end
legend('d = 0', 'd = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60');

figure (4)
for i = 1 : n
    plot(freq,  phase_subtract(:, i), color(i));
    hold on
end
legend('d = 0', 'd = 10', 'd = 20', 'd = 30', 'd = 40', 'd = 50', 'd = 60');

