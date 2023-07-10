% 生成示例数据
x = 1:10;
y1 = x;
y2 = 2*x;
y3 = 3*x;

% 设置颜色映射
cmap = colormap('winter'); % 设置颜色映射（这里使用了'jet'颜色映射）

% 计算颜色映射索引
cmin = 113; % 最小值
cmax = 118; % 最大值
num_colors = size(cmap, 1); % 颜色映射的颜色数量
c_range = cmax - cmin; % 数据范围
c_indices = fix((1:3) / 3 * c_range) + cmin; % 计算每条曲线对应的颜色索引

% 绘制曲线
plot(x, y1, 'LineWidth', 2, 'Color', cmap(c_indices(1), :));
hold on
plot(x, y2, 'LineWidth', 2, 'Color', cmap(c_indices(2), :));
hold on
plot(x, y3, 'LineWidth', 2, 'Color', cmap(c_indices(3), :));

% 添加colorbar
colormap(cmap); % 应用颜色映射
c = colorbar;
c.Label.String = '数值';

% 设置colorbar的数值范围和刻度
caxis([cmin, cmax]); % 设置颜色映射的数值范围
c.Ticks = linspace(cmin, cmax, 6); % 设置colorbar上的刻度位置
c.TickLabels = arrayfun(@(x) sprintf('%.1f', x), c.Ticks, 'UniformOutput', false); % 设置colorbar上的刻度标签
