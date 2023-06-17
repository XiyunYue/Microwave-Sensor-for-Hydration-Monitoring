function [bandwidth, amplitude_resonance, fre_resonance] = ResonanceFunction(n, n_start, Data)
    fre_resonance = zeros(n, 1);
    amplitude_resonance = zeros(n, 1);
    bandwidth = zeros(n, 1);

    for i = n_start : n_start + n - 1
        freq = Data(:, 1);
        amplitude = Data(:, i - n_start + 2);
        sit = find(amplitude == min(amplitude));
        fre_resonance(i - n_start + 1) = freq(sit);
        amplitude_resonance(i - n_start + 1) = amplitude(sit);
        
        amplitude_3dB = amplitude_resonance(i - n_start + 1) + 3;
        freq_3dB_point1 = freq(find(abs(amplitude(1: sit) - amplitude_3dB) ...
            == min(abs(amplitude(1: sit) - amplitude_3dB))));
        freq_3dB_point2 = freq(sit + find(abs(amplitude(sit: end) - ...
            amplitude_3dB) == min(abs(amplitude(sit: end) - ...
            amplitude_3dB))));
        bandwidth(i - n_start + 1) = freq_3dB_point2 - freq_3dB_point1;
    end
end