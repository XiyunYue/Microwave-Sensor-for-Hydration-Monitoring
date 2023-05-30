%% 信号
freq = 5e8:4e6:4e9;
fs = 2 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);


%% 设定变量
n_freq = length(freq);
[s_eps, m_eps, s_thi, m_thi] = RefreshParameters();
se = 25 : 2 : 35;
me = 40 : 5 : 60;
st = 0.0005 : 0.0005 : 0.003;
mt = 0.03 : 0.01 : 0.07;
parameter_value = ['se'; 'me'; 'st'; 'mt'];
parameter_name = ['s_eps'; 'm_eps'; 's_thi'; 'm_thi'];



%% 计算
for k = 1 : 4
    eval([parameter_name(k,:) ' = eval(parameter_value(k,:))']);
    n_parameter = length(parameter_name(k,:));
    E_output = zeros(n_parameter, n_freq);
    E_amplitude = zeros(n_parameter, n_freq);
    for j = 1 : n_parameter
        for i = 1 : n_freq
            skin_thickness = s_thi(j);
            E_output = Transmission3layer(freq(i), SIG, s_eps, ...
                m_eps, s_thi, m_thi);
            E_result = 2 * merit.process.fd2td(E_output, freq, t);
            E_amplitude(j, i) = max(envelope(E_result));                
        end
    end
    [skin_eps, muscle_eps, skin_thi, muscle_thi] = RefreshParameters();
end


%% 皮肤厚度


% n_st = length(skin_thickness);
% E_amplitude_st = zeros(n_st, n_freq);
% diff_st = zeros(n_st - 1, n_freq);
% diff_pre = zeros(n_st - 1, n_freq);
% for i = 1 : n_freq
%     for j = 1 : n_st
%         [E_output, t_output] = Transmission3layer(freq(i), SIG, ...
%             skin_eps, muscle_eps, skin_thickness(j), muscle_thickness);
%         E_result = 2 * merit.process.fd2td(E_output, freq, t);
%         E_amplitude_st(j, i) = max(envelope(E_result));    
%     end
% end
% 
% n = length(skin_thickness);
% color = zeros(n, 3);
% for i = 1 : n
%     color(i,:)=[i/n (n - i)/n (n - i)/n];
% end
% 
% figure(1)
% for i = 1 : n_st
%     plot(freq, E_amplitude_st(i, :), 'Color', color(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude");
% % set(gca, 'XScale', 'log');
% % set(gca, 'YScale', 'log');
% legend('0.5mm', '1mm', '1.5mm', '2mm', '2.5mm', '3mm');
% title('Different skin thickness');
% 
% 
% for i = 1 : n_st - 1
%     diff_st(i, :) = abs(E_amplitude_st(i, :) - E_amplitude_st(i + 1, :));
%     diff_pre(i, :) = diff_st(i, :) ./ E_amplitude_st(i + 1, :);
% %     x_st = freq(find(diff_st == max(diff_st)));
% %     y_st = max(diff_st);
% end
% 
% figure(2)
% for i = 1 : n_st - 1
%     plot(freq, diff_pre(i, :))
%     hold on
% end
% xlabel("Frequency");
% ylabel("Amplitude difference in present");
% % set(gca, 'XScale', 'log');
% % set(gca, 'YScale', 'log');
% % legend('1mm', '1.5mm', '2mm', '2.5mm', '3mm');
% title('Amplitude difference in present in different frequency');
