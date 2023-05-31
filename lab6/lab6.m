clc;
clear all;
close all;

fid = fopen('data12.txt','r');
data = fscanf(fid,'%f',[2,inf])';
fclose(fid);





x1 = data(:,1);
x2 = data(:,2);
num_rows = size(data);
num_cols = num_rows(2);
num_rows = num_rows(1);

figure
plot(x1,x2, '*');
title('data');
xlabel('X2');
ylabel('X1');

%количество кластеров
m = 4;

% init Weights
W = zeros(m, num_cols);
for i=1:m
    for j=1:num_cols
        W(i,j)=data(i,j);
    end
end

new_W = W;

%матрица соответствия принадлежности к кластерам
U = zeros(num_rows,2);

%параметры обучения
h = 0.1;
eps = 1e-6;

k_max = 50000;
for k=1:k_max
    index = randi([1 num_rows], 1)%случайным образом выбираем одно из наблюдений
    d = pdist2(data(index,:), W)%расстояние между выбранным наблюдением и каждым нейроном
    [val, pos] = min(d)%находим индекс нейрона, ближайшего к выбранному наблюдению
    
    %обновляем веса одного нейрона
    data_index = data(index,:)  % Выбираем строку данных по индексу
    diff = repmat(data_index, m, 1) - W  % Вычисляем разницу между выбранной строкой данных и матрицей W
    mask = repmat(pos == (1:m)', 1, num_cols)  % Создаем маску, где значения равны true, если pos соответствует индексу (1:m), иначе false
    new_W = W + h * diff .* mask  % Обновляем матрицу W с учетом шага обучения h, разницы diff и маски mask
    % repmat(data(index,:), m, 1) создаст матрицу 
    % размера m на num_cols, которая содержит m одинаковых копий data(index,:).

    sub = var(new_W - W);%вычисляем изменение весов
    if (sub < eps)
        W = new_W;
        break;
    end
    W = new_W;
end


disp(['iterations = ', num2str(k)]);
% классифицируем объекты
for i = 1:num_rows
    d = zeros(1, m);
    for j = 1:m
        for t = 1:num_cols
            d(j) = d(j) + (data(i,t) - W(j,t))^2;
        end
        d(j) = sqrt(d(j));
    end
    [val,pos] = min(d);%находим индекс нейрона, ближайшего к текущему наблюдению
    U(i,1) = pos;      %записываем индекс нейрона в матрицу классификации
    U(i,2) = val;      %записываем расстояние до нейрона в матрицу классификации
end

figure;
hold on;
gscatter(x1,x2,U(:,1));
hold on;
scatter(W(:,1),W(:,2),20,'k','filled');%вывод нейронов в виде черных заполненных точек размером 20
hold on;

clear x;
clear y;

title('clusters and neurons');
xlabel('X2');
ylabel('X1');