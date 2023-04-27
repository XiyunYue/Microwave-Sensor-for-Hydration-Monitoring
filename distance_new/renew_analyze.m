%% read first file
n = 7;
A = readmatrix("0");
freq = 10^9 * A(:, 1);
real_zero = A(:, 2);
image_zeros = A(:, 3);

%% zeros matric build
amplitude = zeros(length(A(:, 1)), n);
phase = zeros(length(A(:, 1)), n);
amplitude_subtract = zeros(length(A(:, 1)), n);
phase_subtract = zeros(length(A(:, 1)), n);
Y = zeros(length(A(:, 1)), n);
Z = zeros(1001, n);
amplitude_complex = zeros(1001, n);
pesponse_time = zeros(1001, n); 
pesponse_freq = zeros(1001, n); 
amplitude_subtract_complex = zeros(1001, n);

%% calculate the time vector
fs = 2 * max(freq); 
%采样频率（即每秒钟采集的样本数）应至少等于信号中最高频率成分的2倍,fs
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
%Δf = fs / N 采样频率越高,频域分量间隔越小，从而使得频域表示更加精细。
%采样样本的共个数N，Δf是频率分辨率,也代表一共N个频率阶段
t = (0 : t_length + 1) * (1 ./ fs); 
%采样时间从0到采样总数*采样间隔，采样间隔是最大频率的倒数
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2.5e9 * t);%建立高斯包络时间信号
SIG = mag2db(abs(fft(sig)));%进行dB变化
f = fs * (0 : (t_length/2)) / t_length;
%每个频率的分量取值为采样频率乘二分之一的采样总数
sig_f_real = real(SIG);
sig_f_imag = imag(SIG);


%%
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

