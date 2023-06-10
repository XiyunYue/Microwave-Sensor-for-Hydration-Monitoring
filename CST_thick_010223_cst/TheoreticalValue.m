function [L, fre_syntony_calculate] = TheoreticalValue(n)
    c = 3 * (10 ^ 8);
    L = 3 * n + 5;
    wavelength = L * 4 * 10 ^ ( - 3);
    fre_syntony_calculate = c / wavelength;
end