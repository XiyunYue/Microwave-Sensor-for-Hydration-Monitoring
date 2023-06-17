size(amplitude_real_subtract)
tmp = amplitude_real_subtract + 1j*amplitude_image_subtract;
% Y = ifft(tmp);
Y = real(ifft(tmp));
figure
plot(Y)
