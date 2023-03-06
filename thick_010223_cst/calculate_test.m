function amplitude = calculate_test(A)
    amplitude_real = A(:, 2);
    amplitude_image = A(:, 3);
    amplitude = mag2db(abs(amplitude_real + amplitude_image * 1i));
end