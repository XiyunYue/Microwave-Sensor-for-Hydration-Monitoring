%% Coefficient input
n = 8; %data volume
n_start = 18;%Minimum Antenna Sections
a1 = n_start - 1;%Simplify calling functions
num_antenna = n_start : n_start + n - 1;
L = zeros(n, 1);
fre_syntony_calculate = zeros(n, 1);
for i = n_start : n_start + n - 1
    [L(i - n_start + 1), fre_syntony_calculate(i - n_start + 1)] = TheoreticalValue(i);
end

%% Set the data matrix
Data_test = make_data_matrix(n_start, n, 'measurement\monopole2_', '', 1);
Data_cst_boundary = make_data_matrix(n_start, n, "boundary\", '', 0);

%% use function for test
[bandwidth_test, amplitude_syntony_test, fre_syntony_test] = ...
    ResonanceFunction(n, n_start, Data_test);
[bandwidth_cst, amplitude_syntony_cst, fre_syntony_cst_boundary] = ...
    ResonanceFunction(n, n_start, Data_cst_boundary);

fre_matrix = [fre_syntony_calculate, fre_syntony_cst_boundary, fre_syntony_test];

figure_matrix = [bandwidth_cst, bandwidth_test, ...
    amplitude_syntony_cst, amplitude_syntony_test];

%% Image display for test
figure_show_fA(1, n, Data_test);
figure_show_fA(2, n, Data_cst_boundary);
figure_show_fre(3, L, fre_matrix);
figure_show_sy(4, L, figure_matrix);