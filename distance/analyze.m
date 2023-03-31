
n = 7;
A = readmatrix("10");
freq = 10^9 * A(:, 1);
amplitude = zeros(length(A(:, 1)), n);
phase = zeros(length(A(:, 1)), n);


for i = 0 : n
    filename = strcat (int2str(i * 10));
    A = readmatrix(filename);
    freq = 10^9 * A(:, 1);
    amplitude_real = A(:, 2);
    amplitude_image = A(:, 3);
    amplitude(:, i + 1) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
    phase(:, i + 1) = (180 / pi) * unwrap(angle(amplitude_image * 1j + amplitude_real));
end


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
