clc;
clear all;
close all;

file = fopen('data12.txt', 'r');
X = fscanf(file, '%d', [8 inf])'
fclose(file);

rows = size(X);
cols = rows(2)
rows = rows(1)

X_mean = mean(X)
X_sigma = std(X)

X_norm = zeros(rows, cols);

% Нормировка входных данных для устранения неоднородности матожидания по j столбцам
for i=1:rows
    for j= 1:cols
        X_norm(i,j) = (X(i,j) - X_mean(j))/X_sigma(j);
    end
end

% Матрица ковариации = корреляционная матрица из-за нормализации 
R = (X_norm' * X_norm)/(rows-1)

% Проверка матрицы корреляции на отличие от единичной
d = 0;
for i=1:8                           
    for j=(i+1):8
        d = d + R(i,j).^2;
    end
end

% d >> hi2
d = d * rows
hi2 = chi2inv(0.95, (cols * (cols - 1)) / 2)

% R * A = A * L
[A, L] = eig(R);
% A - матрица правых собственных векторов
% L - диагональная матрица собственных значений

A = fliplr(A);
L = rot90(L,2);


Z = X_norm * A; % Проекции объектов на главные компоненты

% Проверка на совпадение сумм дисперсий
sum_z = sum(var(Z)) % Сумма выборочных дисперсий проекций объектов на главные компоненты
sum_x = sum(var(X_norm)) % Сумма выборочных дисперсий исходных признаков

% Относительная доля разброса, приходящаяся на j-ую главную компоненту
alph = zeros(8, 1);
for j=1:8
    alph(j) = L(j,j)/trace(L)' % trace - сумма диагональных элементов
end

% Относительная доля разброса, приходящаяся на главные компоненты
gamm = zeros(8, 1);
for j=1:8
    gamm(j)=0;                 
    for i=1:j
        gamm(j) = gamm(j) + alph(i);
    end
end
gamm

% Матрицу ковариации для проекций объектов на главные компоненты
COV = cov(Z);

figure;
scatter(Z(:,1), Z(:,2), 'filled');
title('Диаграмма рассеяния для первых двух первых компонент');
xlabel('Z1');
ylabel('Z2');
