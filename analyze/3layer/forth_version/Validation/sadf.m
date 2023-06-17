clear
close all
eps0 = 8.854 * 10^-12;
mu0 = 4 * pi * 10^-7 ;
sig = 0.255;
c = 3 * 10 ^ 8;
w = 2 * pi * 2e9;
eps = 1;
alpha = sqrt(1i * w * mu0 * (sig - 1i * w * eps * eps0));
% [abs(alpha), angle(alpha)]
alpha_imag = imag(alpha);
alpha_real = real(alpha);
E_new = 1 * exp( - alpha_real * 0.005);
[abs(E_new), angle(E_new)]




% % 定义常数
% eps0 = 8.854 * 10^-12;  % 真空介电常数
% mu0 = 4 * pi * 10^-7 ;  % 真空磁导率
% c = 3 * 10 ^ 8;         % 光速
% sig = 0.255;            % 电导率
% w = 2 * pi * 2e9;       % 角频率
% eps = 40;               % 介电常数
% 
% % 定义虚数单位
% j = sqrt(-1);
% 
% % 计算复数介电常数（介电常数乘以真空介电常数）
% epsilon_star = eps*eps0 - j*(sig/w);
% 
% % 计算衰减常数 alpha
% alpha = w * sqrt(mu0*epsilon_star/2) * (sqrt(1 + (sig/(w*eps*eps0))^2) - 1)^(1/2);
% E_new = 1 * exp(- alpha * 0.005);
% disp(E_new)