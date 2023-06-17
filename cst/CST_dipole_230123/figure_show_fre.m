function figure_show_fre(j, L, fre_matrix)
    color_line = ['ko-'; 'ro-'; 'bo-';'go-';'mo-'];
    figure (j)
    for i = 1 : length(fre_matrix(1, :))
        plot(L, fre_matrix(:, i), color_line(i, :));
        hold on
    end
    xlabel('The length of the antenna');
    ylabel('frequency');
    title("Comparison of expected and actual resonant frequency");
    legend('Expected resonant frequency', 'CST resonance frequency w=10',...
        'CST resonance frequency w=8', 'Measured resonance frequency');
end