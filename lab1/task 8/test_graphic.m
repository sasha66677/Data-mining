clear all;
clc;
x=0:0.1:6.28;
y=sin(x); 
grid on; % Отображение сетки
plot(x,y) % Построение графика функции
title ('Function sin(x)') % Заголовок графика
xlabel('Argument x') % Подпись по оси x
ylabel('Function y') % Подпись по оси у
print -dtiff -r200 randName