function figure_show_fA(j, n, data)
    color = zeros(n, 3);
    for i = 1 : n
        color(i,:)=[i/n 0 1];
    end

    figure (j)
    for i=2 : n + 1
        plot(data(:, 1), data(:, i), 'color', color(i - 1, :));
        hold on
    end

%     for i = 1 : n
%         legend(n_start + n -1);
%     end
    xlabel('frequency(Hz)');
    ylabel('dB');
    title("Attenuation amplitude(dB) of different numbers antennas nodes");
end