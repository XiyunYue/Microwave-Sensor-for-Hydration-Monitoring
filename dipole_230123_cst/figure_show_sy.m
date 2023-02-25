function figure_show_sy(j, L, figure_matrix)
    color_line = ['ko-'; 'ro-'; 'bo-';'go-';'mo-'];
    m = length(figure_matrix(1, :)) / 2;
    figure (j)
    for i = 1 : m
        plot(L, figure_matrix(:, i), color_line(i, :));
        hold on
    end    
    xlabel('The length of the antenna');
    ylabel('Resonance amplitude(dB)');
    title("The attenuation amplitude when resonates")
%     legend('CST resonance amplitude', 'Measured resonance amplitude');
    
    figure (j + 1)
    for i = 1 : m
        plot(L, figure_matrix(:, i + m), color_line(i, :));
        hold on
    end 
    xlabel('The length of the antenna');
    ylabel('bandwidth');
    title("3dB Bandwidth of Different Antennas")
%     legend('CST bandwidth', 'Measured bandwidth');
end