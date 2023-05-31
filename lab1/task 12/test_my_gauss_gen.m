clear all;
clc;

X=my_gauss_gen(10000000, 0, 2);

% Задание диапазона изменения X
X_min=-6;
X_max=6;

BinNumber=140;
k=0:BinNumber;

step=(X_max - X_min)/BinNumber;
X_borders=X_min + k*step;
% Вычисление гистограммы для X
hist_X = histc(X, X_borders);

figure;
bar(X_borders, hist_X);
xlabel('X');
ylabel('Number of Points');