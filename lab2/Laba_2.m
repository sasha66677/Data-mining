clc;
clear all;

[x, y, sigma] = getDataFile('data12.txt');

%for normal
q1 = [1, 1];
[param_norm, R_norm, J, Cov_norm] = nlinfit(x, y, @func_normal, q1);
%param_norm = nlinfit(x, y, @func_normal, q1);
y_norm = func_normal(param_norm, x);

%for hi2
[param_hi, R_hi, J, Cov_hi] = nlinfit(x, y, @func_hi, 2);
%param_hi = nlinfit(x, y, @func_hi, 2);
y_hi = func_hi(param_hi, x);


%for Maxvell
[param_maxvell, R_maxvell, J, Cov_maxvell] =  nlinfit(x, y, @func_maxvell, 1);
%param_maxvell = nlinfit(x, y, @func_maxvell, 1);
y_maxvell = func_maxvell(param_maxvell, x);

figure();
hold on;
plot(x, y, 'k');
title("Y(x)");
ylabel("y");
xlabel("x");
plot(x, y_norm, 'r');
plot(x, y_hi, 'b');
plot(x, y_maxvell, 'g');
legend('data', 'norm', 'hi^2', 'maxvell');

%Приведенное хи^2 (нормированное на число степеней свободы)
hi2_norm = getHi2Normalized(y,y_norm, sigma, length(param_norm))
hi2_hi = getHi2Normalized(y,y_hi, sigma, length(param_hi))
hi2_maxvell = getHi2Normalized(y,y_maxvell, sigma, length(param_maxvell))

%остатки
R_norm = (y - y_norm)./sigma;
R_hi = (y - y_hi)./sigma;
R_maxvell = (y - y_maxvell)./sigma;


%графики остатков
figure();
hold on;
title("Leftovers");
xlabel("x");
ylabel("R");
plot(x, R_norm, 'r');
plot(x, R_hi, 'b');
plot(x, R_maxvell, 'g');
legend('norm', 'hi^2', 'maxvell');

%Autocorrelation
N = size(y)/2;
k = (1:(N))';
A_norm = autokorel(R_norm, size(y), N(1));
A_hi = autokorel(R_hi, size(y), N(1));
A_maxvell = autokorel(R_maxvell, size(y), N(1));

%graphs Autocorrelation
figure();
hold on;
title("Autocorrelation");
xlabel("k");
ylabel("Ak");
plot(k, A_norm, 'r');
plot(k, A_hi, 'b');
plot(k, A_maxvell, 'g');
legend('norm', 'hi^2', 'maxvell');

%intervals
inter_maxvell = nlparci(param_maxvell, R_maxvell, 'covar', Cov_maxvell, 'alpha', 1-0.68)

D_maxvell = diag(Cov_maxvell);

N = size(y);
N = N(1);
St1 = tinv(0.16,N-1);
St2 = tinv(0.84,N-1);

inter_maxvell_manual = doveritelni(St1, St2, D_maxvell, param_maxvell)
























%R_left = -3;
%R_right = 3;
%BinNumber=20;
%k=0:BinNumber;
%R_bins=R_left + k*(R_right - R_left)/BinNumber;
%N_R = histc(R_maxvell, R_bins);
%figure;
%bar(R_bins, N_R);