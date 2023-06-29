function figure_show_fre(j, L, fre_matrix)
    color_line = ['ko-'; 'ro-'; 'bo-';'go-';'mo-'];
    figure (j)
    for i = 1 : length(fre_matrix(1, :))
        plot(L, fre_matrix(:, i), color_line(i, :));
        hold on
    end
    xlabel('The length of the antenna(mm)');
    ylabel('frequency(Hz)');
    title("Comparison of expected and actual resonant frequency");
    legend('Expected resonant frequency', 'CST resonance frequency',...
        'Measured resonance frequency');
end