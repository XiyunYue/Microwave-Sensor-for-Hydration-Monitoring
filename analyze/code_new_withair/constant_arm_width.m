close all
clear
%% 信号
freq = 5e8:4e6:4e9;
fs = 90 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));

%% 设定变量
n_freq = length(freq);
[s_eps, m_eps, s_thi, m_thi] = RefreshParameters();
se = 25 : 2 : 35;
me = 40 : 2 : 60;
st = 0.0005 : 0.0005 : 0.003;
% mt = 0.03 : 0.01 : 0.07;
ait = 0.001 : 0.003 : 0.01;
arm_thickness = 0.036 : 0.01 : 0.071;
% arm_thickness = 0.06;

%% 间隙不同的影响
for j = 1 : length(arm_thickness) 
    figure(j)
    [t_delay, E_amplitude] = cal_arm_thickness(arm_thickness(j), se, me, st, ait);
    for k = 1 : length(se)
        for h = 1 : length(st)
            for i = 1 : length(ait)
                y_point = reshape(t_delay(i, k, h, :), [], 1);
                x_point = reshape(E_amplitude(i, k, h, :), [], 1);
                scatter(x_point, y_point, 30, me, 'o', 'filled')
                hold on
            end
        end
    end
    xlabel('Amplitude')
    ylabel('TOA')
    title(arm_thickness(j))
    colorbar;
end

%% 最优解的间隙
% for j = 1 : length(ait)
%     figure(j)
%     [t_delay, E_amplitude] = cal_arm_thickness(arm_thickness, se, me, st, ait(j));
%     for k = 1 : length(se)
%         for h = 1 : length(st)
%             y_point = reshape(t_delay(1, k, h, :), [], 1);
%             x_point = reshape(E_amplitude(1, k, h, :), [], 1);
%             scatter(x_point, y_point, 30, me, 'o', 'filled')
%             hold on
%         end
%     end
%     xlabel('Amplitude')
%     ylabel('TOA')
%     colorbar;
%     title('Air distance = ', ait(j))
% end