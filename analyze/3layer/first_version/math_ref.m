% function E_tra = math_ref(E, eps1, eps2)
% %     Gam = sqrt((eps2 - eps1) / (eps1 + eps1));
%     tao = 2 * eps1 / (eps1 + eps2);
% %     E_ref = Gam * E;
%     E_tra = tao * E;

% 
% 
% function [E_ref, E_tra] = math_ref(E, eps1, mu1, eps2, mu2)
%     eta1 = sqrt(mu1 / eps1);
%     eta2 = sqrt(mu2 / eps2);
%     Gam = (eta1 - eta2) / (eta1 + eta2);
%     tao = 2 * eta2 / (eta1 + eta2);
%     E_ref = Gam * E;
%     E_tra = tao * E;

function [E_ref, E_tra] = math_ref(E, eps1, eps2)
    mu = 1;
    eta1 = sqrt(mu / eps1);
    eta2 = sqrt(mu / eps2);
    Gam = (eta2 - eta1) / (eta1 + eta2);
    tao = 2 * eta2 / (eta1 + eta2);
    E_ref = Gam * E;
    E_tra = tao * E;
end
% eps1 = 1;
% eps2 = 1000000;
% mu1 = 1;
% mu2 = 1;
% eta1 = sqrt(mu1 / eps1);
% eta2 = sqrt(mu2 / eps2);
% Gam = (eta1 - eta2) / (eta1 + eta1);%反射系数
% tao = 2 * eta2 / (eta1 + eta1);%透射系数