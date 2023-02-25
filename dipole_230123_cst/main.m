%% Coefficient input
n = 11; %data volume
n_start = 18;%Minimum Antenna Sections
a1 = n_start - 1;%Simplify calling functions
num_antenna = n_start : n_start + n - 1;
L = zeros(n, 1);
fre_syntony_calculate = zeros(n, 1);
for i = n_start : n_start + n - 1
    [L(i - n_start + 1), fre_syntony_calculate(i - n_start + 1)] = TheoreticalValue(i);
end

%% Set the data matrix
Data_test = make_data_matrix(n_start, n, 'Measurement\230123_dipole_', '_no', 1);
Data_cst_10 = make_data_matrix(n_start, n, "square_D10\", '', 0);
Data_cst_8 = make_data_matrix(n_start, n, "square_D8\", '', 0);

%% use function for test
[bandwidth_test, amplitude_syntony_test, fre_syntony_test] = ...
    ResonanceFunction(n, n_start, Data_test);
[bandwidth_cst_10, amplitude_syntony_cst_10, fre_syntony_cst_10] = ...
    ResonanceFunction(n, n_start, Data_cst_10);
[bandwidth_cst_8, amplitude_syntony_cst_8, fre_syntony_cst_8] = ...
    ResonanceFunction(n, n_start, Data_cst_8);

fre_matrix = [fre_syntony_calculate, fre_syntony_cst_10, fre_syntony_cst_8,...
    fre_syntony_test];

figure_matrix = [bandwidth_cst_10, bandwidth_cst_8, bandwidth_test,...
    amplitude_syntony_cst_10, amplitude_syntony_cst_8, amplitude_syntony_test];

%% Image display for test
figure_show_fA(1, n, Data_test);
figure_show_fA(2, n, Data_cst_10);
figure_show_fA(3, n, Data_cst_8);
figure_show_fre(4, L, fre_matrix);
figure_show_sy(5, L, figure_matrix);