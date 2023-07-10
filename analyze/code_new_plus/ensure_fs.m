close all
clear
%%  不同中心频率
for k = 81 : 1: 90  %75已经够了
    freq = 5e8:4e6:4e9;
    fs = k * max(freq); 
    dert_f = freq(2) - freq(1);
    t_length = fs ./ dert_f; 
    t = (0 : t_length + 1) * (1 ./ fs); 
    precision = 1;
    diff_me = - 10 : precision : 10;

    figure(k)
    cf = 3.6e9;
    y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
    sig = y .* sin(2 * pi * cf * t);
    arm_thickness = 0.052;
    [delay, amplitude] = cal_arm_thickness(arm_thickness, sig, freq, t, precision);
    for b = 1 : 6
        for k = 1 : 11
            y_point = reshape(delay(b, k, :), [], 1);
            x_point = reshape(amplitude(b, k, :), [], 1);
            scatter(x_point, y_point, 30, diff_me, 'o', 'filled')
            hold on
        end
    end
    xlabel('Amplitude')
    ylabel('TOA')
    title('Center frequency =', cf)
    colorbar;
end
