% eps = 40;
% f = 4e9;
% x = 0.005;
% eps0 = 8.854 * 10^-12;
% mu0 = 4 * pi * 10^-7 ;
% sig = 4;
% c = 3 * 10 ^ 8;
% w = 2 * pi * f;
% alpha = sqrt(1i * w * mu0 * (sig + 1i * w * eps * eps0));
% % disp(alpha);
% 
% 
% freq = 0:4e6:4e9;
% fs = 2 * max(freq); 
% dert_f = freq(2) - freq(1);
% t_length = fs ./ dert_f; 
% t = (0 : t_length + 1) * (1 ./ fs); 
% y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
% sig = y .* sin(2 * pi * 2e9 * t);
% SIG = merit.process.td2fd(sig', t, freq);
% E_new = SIG * exp(- alpha * x);
% E_result = 2 * merit.process.fd2td(E_new, freq, t);
% E_amplitude = max(envelope(E_result));
% disp(E_amplitude);





