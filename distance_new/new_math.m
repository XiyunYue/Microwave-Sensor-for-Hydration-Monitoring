%建立整个函数f(esp1,esp2,st,mt)
%皮肤厚度改为1-3
%肌肉厚度改为30-70
%如果系数一样，则应该等同于一层传播
%皮肤介电常数在25-35，肌肉在40-60
%time of arrivel,看到达时间和幅度
%x 皮肤厚度,y TOA
%x 介电常数
%validitation

%% 
skin_eps = 30;
muscle_eps = 30;
skin_thickness = 2;
muscle_thickness = 100;
% sig = 4;
t1 = speed(skin_thickness, skin_eps);
t2 =  speed(muscle_thickness, muscle_eps);
t_tran = 2 * t1 + t2;
freq = 0:4e6:4e9;
fs = 2 * max(freq); 
%采样频率（即每秒钟采集的样本数）应至少等于信号中最高频率成分的2倍,fs
dert_f = freq(2) - freq(1);
t_length = fs ./ dert_f; 
%Δf = fs / N 采样频率越高,频域分量间隔越小，从而使得频域表示更加精细。
%采样样本的共个数N，Δf是频率分辨率,也代表一共N个频率阶段
t = (0 : t_length + 1) * (1 ./ fs); 
%采样时间从0到采样总数*采样间隔，采样间隔是最大频率的倒数
y = exp(-(t - 3.5e-8).^2/(2 * 2e-9^2));
sig = y .* sin(2 * pi * 2e9 * t);%建立高斯包络时间信号
SIG = merit.process.td2fd(sig', t, freq);%变换到时域
% f = fs * (0 : (t_length/2)) / t_length;
%每个频率的分量取值为采样频率乘二分之一的采样总数
t1 = t + t_tran;
% 
% % 只试一层
% [E_ref, E_tra] = math_ref(sig, 1, 1);
% figure(1)
% plot(E_ref);
% figure(2)
% plot(E_tra);
% [E_ref1, E_tra1] = math_ref(sig, 1, 1000);
% figure(3)
% plot(E_ref1);
% figure(4)
% plot(real(E_tra1));

%% 试三层,不考虑折射后的反射
% [E_re1f, E_tra1] = math_ref(sig, 1,skin_eps);
% E_first_att = math_att(E_tra1, 2e9, skin_thickness, skin_eps);
% [E_ref2, E_tra2] = math_ref(E_first_att, skin_eps, muscle_eps);
% E_second_att = math_att(E_tra2, 2e9, muscle_thickness, muscle_eps);
% [E_ref3, E_tra3] = math_ref(E_second_att, muscle_eps, skin_eps);
% E_third_att = math_att(E_tra3, 2e9, skin_thickness, skin_eps);
% [E_ref4, E_tra4] = math_ref(E_third_att, skin_eps, 1);


%% 频域的转换
[E_re1f, E_tra1] = math_ref(SIG, 1,skin_eps);
E_first_att = math_att(E_tra1, 2e9, skin_thickness, skin_eps);
[E_ref2, E_tra2] = math_ref(E_first_att, skin_eps, muscle_eps);
E_second_att = math_att(E_tra2, 2e9, muscle_thickness, muscle_eps);
[E_ref3, E_tra3] = math_ref(E_second_att, muscle_eps, skin_eps);
E_third_att = math_att(E_tra3, 2e9, skin_thickness, skin_eps);
[E_ref4, E_tra4] = math_ref(E_third_att, skin_eps, 1);
E_output = merit.process.fd2td(E_tra4, freq, t);
S11 = mag2db(E_output' / sig);

%% 
% [E_re1f, E_tra1] = math_ref(SIG, 1,skin_eps);
% E_first_att = math_att(E_tra1, 2e9, skin_thickness, skin_eps);
% [E_ref2, E_tra2] = math_ref(E_first_att, skin_eps, muscle_eps);
% E_second_att = math_att(E_tra2, 2e9, muscle_thickness, muscle_eps);
% [E_ref3, E_tra3] = math_ref(E_second_att, muscle_eps, skin_eps);
% E_third_att = math_att(E_tra3, 2e9, skin_thickness, skin_eps);
% [E_ref4, E_tra4] = math_ref(E_third_att, skin_eps, 1);
% E_output = merit.process.fd2td(E_tra4, freq, t);
% S11 = mag2db(E_output' / sig);

%% 图像绘制 
% figure(1)
% plot(t, sig, 'g')
% hold on
% figure(2)
% plot(t1, E_output, 'r')
% plot(t1, envelope(E_output), 'r')
% xlabel("frequency");
% ylabel("signal_output");
