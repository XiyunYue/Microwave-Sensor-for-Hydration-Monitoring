files = string(50:10:100);
filenames = arrayfun(@(f) f+".txt", files);

[S11, fs] = loadfiles(filenames);
fs = 0:4e6:4e9;

S11 = S11 - S11(:, end);

F = fs > 1.5e9;

%% Frequency
subplot(2, 1, 1);
plot(fs, mag2db(abs(S11)));
legend(files);
subplot(2, 1, 2);
plot(fs(F), unwrap(angle(S11(F, :))));
legend(files);


%% Time
max_f = 8e9;
t_length = max_f./(fs(2) - fs(1));
ts = (0 : t_length+1)'*(1./(4*max_f));
y = exp(-(ts - 2.5e-8).^2./(2 * 3e-9^2)) .* sin(2 * pi * 2.5e9 * ts);;
Y = merit.process.td2fd(y, ts, fs);

S11_ = S11.*Y;

signals = merit.process.fd2td(S11_, fs, ts);

signals_ = envelope(signals);
signals_(:, end) = envelope(y).*max(signals_(:));

T = ts < 5e-8;
subplot(1, 1, 1);
plot(ts(T), signals_(T, :));
legend(files)

[~, max_is] = max(signals_);
max_ts = ts(max_is);
max_ts/1e-7
