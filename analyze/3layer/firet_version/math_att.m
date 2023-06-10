function E_new = math_att(E, f, x, eps)
    eps0 = 8.854 * 10^-12;
    mu0 = 4 * pi * 10^-7 ;
    sig = 4;
    c = 3 * 10 ^ 8;
% %     alpha = abs(sqrt(pi * f * mu0 * esp * (sig + (2 * pi * f * esp * esp0) * 1i)));
%     alpha = 2 * pi * f * sqrt(esp) / c * 1e3;
%     E_new = E * exp(- alpha * x);





    omg = 2 * pi * f;
    alpha = omg ^ 2 * eps * mu0;
    E_new = E * exp((- alpha * x * 0.001) * 1i);
end










% 
%     omg = 2 * pi * f;
%     eps_com = eps - 1i * (sig / omg);
%     k = sqrt(omg ^ 2 * mu0 / eps_com);
% %     kr = omg * sqrt(mu0 / 2) * sqrt((sqrt(real(eps_com)^2 + imag(eps_com)^2) + real(eps_com)) / 2);
% %     ki = omg * sqrt(mu0 / 2) * sqrt((sqrt(real(eps_com)^2 + imag(eps_com)^2) - real(eps_com)) / 2);
% %     kr = real(k);
%     E_new = E * exp((- k * x * 0.001) * 1i);
% end