
function t = speed(d, eps)
    c = 3 * 10 ^ 8;
    v = c / sqrt(eps);
    t = d * 10 ^ (-3) / v;
end

