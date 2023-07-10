me = 40 : 60;
eps0 = 8.854 * 10^-12;
mu0 = 4 * pi * 10^-7;
% f = (4 * sqrt(1 ./ (30 * me))) ./ ((sqrt(1/30) + sqrt(1./me)).^2);
f = (4 * sqrt(30 * me)) ./ ((sqrt(30) + sqrt(me)).^2);
plot(me, mag2db(f))