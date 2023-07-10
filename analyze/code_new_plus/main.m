close all
clear
%% 信号

freq = 5e8:4e6:4e9;
fs = 90 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
precision = 1;
diff_me = - 10 : precision : 10;

%% xcorr
% y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
% sig = y .* sin(2 * pi * 2e9 * t);
% SIG = merit.process.td2fd(sig', t, freq);
% for i = 1 : n_freq
%     E_output(i, 1) = Transmission3layer(freq(i), 1, s_eps, m_eps, ...
%         s_thi, m_thi);
% end
% E_out_f = SIG .* E_output;
% E_out_t = 2 * merit.process.fd2td(E_out_f, freq, t);
% y = envelope(E_out_t);
% y_sig = envelope(sig);
% t_delay = t(find(y == max(y))) - t(find(y_sig == max(y_sig)));
% [R,lags] = xcorr(E_out_t, sig);
% [~, index] = max(abs(R));
% delay = lags(index) * (t(2) - t(1));


%%  不同中心频率
% for i = 1 : 4
%     figure(i)
%     cf = 0.9e9 * i;
%     % loc_f = (cf - 5e8) / 4e6 + 1;
%     % me_cen = me_matrix(loc_f);
%     y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
%     sig = y .* sin(2 * pi * cf * t);
%     % SIG = merit.process.td2fd(sig', t, freq);
%     % E_result = 2 * merit.process.fd2td(SIG, freq, t);
%     % plot(t, E_result)
%     arm_thickness = 0.052;
%     [delay, amplitude] = cal_arm_thickness(arm_thickness, sig, freq, t, precision);
%     for b = 1 : 6
%         for k = 1 : 11
%             y_point = reshape(delay(b, k, :), [], 1);
%             x_point = reshape(amplitude(b, k, :), [], 1);
%             scatter(x_point, y_point, 30, diff_me, 'o', 'filled')
%             hold on
%         end
%     end
%     c = colorbar;
%     xlabel('Amplitude')
%     ylabel('TOA')
%     c.Label.String = '\Delta \epsilon_m';
%     title('Center frequency =', cf)
% end


%% 不同带宽
for j = 1 :2: 8
    figure(j)
    bw = 1e-9 * j;
    y = exp(-(t - 3.5e-8).^2/(2 * bw^2));
    sig = y .* sin(2 * pi * 2e9 * t);
    % SIG = merit.process.td2fd(sig', t, freq);
    % E_result = 2 * merit.process.fd2td(SIG, freq, t);
    % plot(t, E_result)    
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
    c = colorbar;
    xlabel('Amplitude')
    ylabel('TOA')
    c.Label.String = '\Delta \epsilon_m';
    title('bw =', bw)
end

