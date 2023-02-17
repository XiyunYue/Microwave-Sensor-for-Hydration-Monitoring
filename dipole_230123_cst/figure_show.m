function [figure]=figure_show[]
    figure (1)
    for i=1:11
        plot(fre_data_test(:, 1), amplitude_test(:, i), 'color', color(i,:));
        hold on
    end
    legend('18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28');
    % legend('L(1)', 'L(2)', 'L(3)', 'L(4)', 'L(5)', 'L(6)', 'L(7)', 'L(8)', 'L(9)', 'L(10)', 'L(11)');
    xlabel('frequency');
    ylabel('dB');
    title("Attenuation amplitude(dB) of different numbers antennas nodes");

    % plot(fre_data(:, 1), amplitude(:, :));
    % % hold on
    % % plot(fre_data(:, 1), freq_3dB);
    % xlabel('frequency');
    % ylabel('dB');
    % legend('18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28');

    figure (2)
    plot(L, fre_syntony_test_calculate,'ro-', 'MarkerFaceColor','r');
    xlabel('The length of the antenna');
    ylabel('frequency');
    hold on
    plot(L, fre_syntony_test, 'go-', 'MarkerFaceColor', 'g');
    legend('Expected resonant frequency', 'Measured resonance frequency');
    title("Comparison of expected and actual resonant frequency")

    figure (3)
    plot(L, amplitude_syntony_test);
    xlabel('The length of the antenna');
    ylabel('syntony amplitude(dB)');
    title("The attenuation amplitude when resonates")

    figure (4)
    plot(L, phase);
    xlabel('The length of the antenna');
    ylabel('syntony phase(rad)');
    title("The attenuation phase when resonates")

    figure (5)
    plot(L, bandwidth_test);
    xlabel('The length of the antenna');
    ylabel('bandwidth');
    title("3dB Bandwidth of Different Antennas")
end