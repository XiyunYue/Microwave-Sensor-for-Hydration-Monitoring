
se = 25 : 2 : 35;
me = 40 : 5 : 60;
st = 0.0005 : 0.0005 : 0.003;
mt = 0.03 : 0.01 : 0.07;
ait = 0.001 : 0.001 : 0.01;
arm_thickness = 0.036;
freq = 5e8:4e6:4e9;
fs = 20 * max(freq); 
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
t = (0 : t_length + 1) * (1 ./ fs); 
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);
SIG = merit.process.td2fd(sig', t, freq);
n_freq = length(freq);
for j = length(ait)
    for a = 1 : length(se)
        for b = 1 : length(st)
            dis = ait(j);
            s_thi = st(b);
            m_thi = arm_thickness -  2 * s_thi;
            for c = 1 : length(me)
                s_eps = se(a);
                m_eps = me(c);
                for i = 1 : n_freq
                    E_output(i, 1) = withairbetween(freq(i), 1, ...
                        s_eps, m_eps, s_thi, m_thi, dis);
                end
                E_out_f = SIG .* E_output;
                E_result = 2 * merit.process.fd2td(E_output, freq, t);
                E_out_t = 2 * merit.process.fd2td(E_out_f, freq, t);
                y = envelope(E_out_t);
                y_sig = envelope(sig);
                t_delay(j, a, b, c) = t(find(y == max(y))) - t(find(y_sig == max(y_sig)));
                E_amplitude(j, a, b, c) = mag2db(max(abs(E_out_t)));
            end
        end
    end
end
