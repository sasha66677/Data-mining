function [X,Y]=my_func(X_left, X_right, Y_left, Y_right, N)
% Генерация N значений случайной величины X в области задания X
X=X_left + rand(N,1)*(X_right - X_left);
% Генерация N значений случайной величины Y в области задания Y
Y=Y_left + rand(N,1)*(Y_right - Y_left);