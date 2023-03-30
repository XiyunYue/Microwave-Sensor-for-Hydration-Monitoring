n = 4;
A = readmatrix("S11-nothing");
freq = 10^9 * A(:, 1);
phase = zeros(length(freq) : n + 1);
amplitude = zeros(length(freq) : n + 1);
amplitude_real = A(:, 2);
amplitude_image = A(:, 3);
amplitude(:,1) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
phase(:,1) = (180 / pi) * angle(amplitude_image * 1i + amplitude_real);
B = readmatrix("S11-small");
amplitude_real = B(:, 2);
amplitude_image = B(:, 3);
amplitude(:,2) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
phase(:,2) = (180 / pi) * angle(amplitude_image * 1i + amplitude_real);
C = readmatrix("S11-big");
amplitude_real = C(:, 2);
amplitude_image = C(:, 3);
amplitude(:,3) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
phase(:,3) = (180 / pi) * angle(amplitude_image * 1i + amplitude_real);
D = readmatrix("S11-muscle");
amplitude_real = D(:, 2);
amplitude_image = D(:, 3);
amplitude(:,4) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
phase(:,4) = (180 / pi) * angle(amplitude_image * 1i + amplitude_real);

E = readmatrix("S21-nothing");
phase_s21 = zeros(length(freq) : n + 1);
amplitude_s21 = zeros(length(freq) : n + 1);
amplitude_real = E(:, 2);
amplitude_image = E(:, 3);
amplitude_s21(:,1) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
phase_s21(:,1) = (180 / pi) * angle(amplitude_image * 1i + amplitude_real);
F = readmatrix("S21-small");
amplitude_real = F(:, 2);
amplitude_image = F(:, 3);
amplitude_s21(:,2) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
phase_s21(:,2) = (180 / pi) * angle(amplitude_image * 1i + amplitude_real);
G = readmatrix("S21-big");
amplitude_real = G(:, 2);
amplitude_image = G(:, 3);
amplitude_s21(:,3) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
phase_s21(:,3) = (180 / pi) * angle(amplitude_image * 1i + amplitude_real);
H = readmatrix("S21-muscle");
amplitude_real = H(:, 2);
amplitude_image = H(:, 3);
amplitude_s21(:,4) = sqrt((amplitude_real).^2 + (amplitude_image).^2);
phase_s21(:,4) = (180 / pi) * angle(amplitude_image * 1i + amplitude_real);



% C = readmatrix("S21-nothing");
% amplitude_s21 = C(:, 2);
% D = readmatrix("S21-BLOCK");
% amplitude_s21 = [amplitude_s21, D(:, 2)];
% F = readmatrix("S21-block2");
% amplitude_s21 = [amplitude_s21, F(:, 2)];
% H = readmatrix("S21-muscle");
% amplitude_s21 = [amplitude_s21, H(:, 2)];
% 


color_line = ['r-'; 'b-'; 'g-';'y-';'m-'];
figure (1)
for i = 1 : length(amplitude(1, :))
    plot(freq,  amplitude(:, i), color_line(i, :));
    hold on
end
figure (2)
for i = 1 : length(amplitude(1, :))
    plot(freq,  phase(:, i), color_line(i, :));
    hold on
end

color_line = ['r-'; 'b-'; 'g-';'y-';'m-'];
figure (3)
for i = 1 : length(amplitude(1, :))
    plot(freq,  amplitude_s21(:, i), color_line(i, :));
    hold on
end
figure (4)
for i = 1 : length(amplitude(1, :))
    plot(freq,  phase_s21(:, i), color_line(i, :));
    hold on
end


% 
% figure (2)
% for i = 1 : length(amplitude_s11(1, :))
%     plot(freq,  amplitude_s21(:, i), color_line(i, :));
%     hold on
% end



% sit = find(amplitude == min(amplitude));
% fre_syntony = freq(sit);
% amplitude_syntony = amplitude(sit);
