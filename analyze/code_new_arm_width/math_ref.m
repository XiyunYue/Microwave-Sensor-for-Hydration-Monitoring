function [E_ref, E_tra] = math_ref(E, eps1, eps2)
    mu = 1;
    eta1 = sqrt(mu / eps1);
    eta2 = sqrt(mu / eps2);
    Gam = (eta2 - eta1) / (eta1 + eta2);
    tao = 2 * eta2 / (eta1 + eta2);
    E_ref = Gam * E;
    E_tra = tao * E;
end