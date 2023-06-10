function Data = make_data_matrix(n_start, n, file_name_first, file_name_second, i)
%use i to judge if it test file or simulation value
    file_start = strcat (file_name_first, int2str(n_start), file_name_second);
    A = readmatrix(file_start);
    Data = zeros(length(A), n + 1);
    if i == 1
        Data(:, 1) = A(:, 1);
        for i = n_start : n_start + n - 1
            file_name = strcat (file_name_first, int2str(i), file_name_second);
            A = readmatrix(file_name);
            amplitude = calculate_test(A);
            Data(:, i - n_start + 2) = amplitude;
        end
    else
        Data(:, 1) = 10^9 * A(:, 1);
        for i = n_start : n_start + n - 1
            file_name = strcat (file_name_first, int2str(i), file_name_second);
            A = readmatrix(file_name);
            amplitude = A(:, 2);
            Data(:, i - n_start + 2) = amplitude;
        end        

    end
end