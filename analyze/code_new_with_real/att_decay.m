function E_new = att_decay(E, f, x, eps, sig)
    eps0 = 8.854 * 10^-12;
    mu0 = 4 * pi * 10^-7;
    c = 3 * 10 ^ 8;
    w = 2 * pi * f;
    % alpha = sqrt(1i * w * mu0 * (sig + 1i * w * eps * eps0));
    eps_c = eps + sig / (1j * w * eps0);
    alpha = 1j * w * sqrt(mu0 * eps_c * eps0);
    E_new = E * exp( - alpha * x);
end

