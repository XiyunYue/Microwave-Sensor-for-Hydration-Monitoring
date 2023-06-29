shape_point = ['o', 'x', '^', 's', 'p', 'h'];
shape_labels = {'Shape 1', 'Shape 2', 'Shape 3', 'Shape 4', 'Shape 5', 'Shape 6'};

figure(1)
for i = 1 : length(me)
    for j = 1 : length(se)
        y_point = reshape(t_delay_math(j, :, i), [], 1);
        x_point = me(i) * ones(length(y_point), 1);
        c = linspace(1, 20, length(y_point));
        scatter(x_point, y_point, 30, c, shape_point(j))
        xlabel('me')
        ylabel('TOA')
        hold on
    end
end

legend(shape_labels)
