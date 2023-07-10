% 创建一些示例数据
data = [randn(100, 1); randn(100, 1) + 2]; % 两组数据，第一组均值为0，第二组均值为2

% 绘制箱线图
boxplot(data);

% 添加标题和轴标签
title('箱线图');
xlabel('数据组');
ylabel('数值');
