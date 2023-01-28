fre_syntony_test = zeros(11, 1);
fre_syntony_calculate = zeros(11, 1);
num_antenna = 18 : 28;
for n = 18 : 28
    str= strcat ('230123_dipole_',int2str(19) ,'_no') ;
    dipole =  eval(['dipole', num2str(n), 'no']);
    [fre_syntony_test(n - 17), fre_syntony_calculate(n - 17)] = test_calu(n, dipole);
end
figure (1)
xlabel('The number of nodes of the antenna');
ylabel('frequency');

plot(num_antenna, fre_syntony_calculate,'ro-','MarkerFaceColor','r')
hold on
plot(num_antenna, fre_syntony_test, 'go-','MarkerFaceColor', 'g')
legend('Expected resonant frequency', 'Actual measured resonance frequency');