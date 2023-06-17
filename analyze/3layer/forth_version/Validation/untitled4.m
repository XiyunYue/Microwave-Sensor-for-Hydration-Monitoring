x = 1:4; % x轴数据
y = [1, 2, 3, 4; 4, 5, 6, 7; 7, 8, 9,10; 10,11,12,13]; % y轴数据，每一列对应一个曲线

num_curves = size(y, 2); % 曲线个数

% 绘制曲线
figure;
hold on;
for i = 1:num_curves
    plot(x, y(:, i), 'LineWidth', 2);
end
hold off;

% 生成图例标签
legend_labels = cell(1, num_curves); % 用于存储图例标签的单元格数组
for i = 1:num_curves
    legend_labels{i} = ['曲线 ' num2str(i)];
end

% 显示图例
legend(legend_labels);
