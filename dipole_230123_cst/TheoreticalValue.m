function [L, fre_syntony_calculate] = TheoreticalValue(n)
    c = 3 * (10 ^ 8);
    L = 4 + 2 * 3 * n + 1.5;
    wavelength = L * 2 * 10 ^ ( - 3);
    fre_syntony_calculate = c / wavelength;
end