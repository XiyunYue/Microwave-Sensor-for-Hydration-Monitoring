close all
clear
%% 信号
freq = 5e8:4e6:4e9;
fs = 20 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);

%% 设定变量
n_freq = length(freq);
se = 25 : 2 : 35;
me = 40 : 2 : 60;
st = 0.0005 : 0.0005 : 0.003;
mt = 0.03 : 0.01 : 0.07;
thickness_all = 0.35 : 0.05 : 0.1;

%% 计算
for a = 1 : length(se)
    for b = 1 : length(st)
        for c = 1 : length(mt)
            for d = 1 : length(me)
                s_eps = se(a);
                s_thi = st(b);
                m_thi = mt(c);
                m_eps = me(d);
                for i = 1 : n_freq
                    E_output(i, 1) = Transmission3layer(freq(i), 1, s_eps, m_eps, ...
                        s_thi, m_thi);
                end
                E_out_f = SIG .* E_output;
                E_result = 2 * merit.process.fd2td(E_output, freq, t);
                E_out_t = 2 * merit.process.fd2td(E_out_f, freq, t);
                y = envelope(E_out_t);
                y_sig = envelope(sig);
                t_delay(a, b, c, d) = t(find(y == max(y))) - t(find(y_sig == max(y_sig)));
                t_s = t_math(s_thi, s_eps);
                t_m = t_math(m_thi, m_eps);
                t_delay_math(a, b, c, d) = 2 *t_s + t_m;
            end
        end
    end
end

%%
% shape_point = ['o', 'x', '^', 's', 'p', 'h'];
% shape_labels = {'se = 25', 'se = 27', 'se = 29', 'se = 31', 'se = 33', 'se = 35'};
% figure(1)
% for i = 1 : length(me)
%     for j = 1 : length(se)
%         y_point = reshape(t_delay_math(j, :, 1, i), [], 1);%使用图形的角越多，代表皮肤介电常数越高
%         x_point = me(i) * ones(length(y_point), 1);
%         % c = linspace(1, 20, length(y_point));
%         scatter(x_point, y_point, 30, mt, shape_point(j))%颜色越深，代表肌肉厚度越小
%         xlabel('me')
%         ylabel('TOA')
%         hold on
%     end
% end
% legend(shape_labels)
% colorbar


figure(2)%小于50的me是红色，大于50的是蓝色
% for i = 1 : length(me)
%     for j = 1 : length(se)
%         y_point = reshape(E_amplitude(j, :, i), [], 1);
%         x_point = me(i) * ones(length(y_point), 1);
%         c = linspace(1, 20, length(y_point));
%         scatter(x_point, y_point, 30, c, shape_point(j))
%         hold on
%     end
% end
% y_point = reshape(t_delay_math(:, :, 1:5), [], 1);
% x_point = reshape(E_amplitude(:, :, 1:5), [], 1);
% scatter(x_point, y_point, 30, 'r', shape_point(1), 'filled')
% hold on
% y_point = reshape(t_delay_math(:, :, 6:end), [], 1);
% x_point = reshape(E_amplitude(:, :, 6:end), [], 1);
% scatter(x_point, y_point, 30, 'b', shape_point(1), 'filled')
% xlabel('Amplitude')
% ylabel('TOA')
% 
% figure(3)%小于50的me是红色，大于50的是蓝色，皮肤介电常数不变
% y_point = reshape(t_delay_math(1, :, 1:5), [], 1);
% x_point = reshape(E_amplitude(1, :, 1:5), [], 1);
% scatter(x_point, y_point, 30, 'r', shape_point(1), 'filled')
% hold on
% y_point = reshape(t_delay_math(1, :, 6:end), [], 1);
% x_point = reshape(E_amplitude(1, :, 6:end), [], 1);
% scatter(x_point, y_point, 30, 'b', shape_point(1), 'filled')
% xlabel('Amplitude')
% ylabel('TOA')
% 
% figure(4)%小于50的me是红色，大于50的是蓝色，肌肉厚度常数不变
% y_point = reshape(t_delay_math(:, 2, 1:5), [], 1);
% x_point = reshape(E_amplitude(:, 2, 1:5), [], 1);
% scatter(x_point, y_point, 30, 'r', shape_point(1), 'filled')
% hold on
% y_point = reshape(t_delay_math(:, 2, 6:end), [], 1);
% x_point = reshape(E_amplitude(:, 2, 6:end), [], 1);
% scatter(x_point, y_point, 30, 'b', shape_point(1), 'filled')
% xlabel('Amplitude')
% ylabel('TOA')

