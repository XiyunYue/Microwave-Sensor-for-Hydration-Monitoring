function arrival_time = calculate_arrival_time(signal, time)
    [~, peak_indices] = findpeaks(signal);
    t_peak = peak_indices(1);
    arrival_time = time(t_peak) - time(1);
end

function time_difference = calculate_time_difference(signal, time)
    [~, peak_indices] = findpeaks(signal);
    t_peak = peak_indices(1);
    time_difference = time(t_peak) - time(1);
end

% 继续原有的代码
freq = 0:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);
E_1 = math_att(SIG, 2e9, 1, 30);
E_result1 = 2 * merit.process.fd2td(E_1, freq, t);

arrival_time = calculate_arrival_time(E_result1, t);
time_difference = calculate_time_difference(E_result1, t);

disp('到达时间差：');
disp(arrival_time);

disp('输入信号的时间差：');
disp(time_difference);
