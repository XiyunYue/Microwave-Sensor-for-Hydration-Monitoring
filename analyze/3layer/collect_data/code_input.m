close all
clear
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

se = 25 : 2 : 35;
me = 40 : 5 : 60;
st = 0.0005 : 0.0005 : 0.003;
mt = 0.03 : 0.01 : 0.07;

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
for i = 1 : length(me)
    y_point = reshape(t_delay_math(:, :, :, i), [], 1);
    x_point = me(i) * ones(length(y_point), 1);
    c = linspace(1,20, length(y_point));
    scatter(x_point, y_point, 10, c, 'filled')
    hold on
end

% for i = 1 : length(me)
%     y_point = reshape(t_delay_math(:, :, :, i), [], 1);
%     x_point = me(i) * ones(length(y_point), 1);
%     boxchart(x_point, y_point)
%     hold on
% end


