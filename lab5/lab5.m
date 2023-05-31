clc;
clear all
close all


fid = fopen('data12.txt','r');
X = fscanf(fid,'%f',[2,inf])';
fclose(fid);

x1 = X(:, 1);
x2 = X(:, 2);
num_rows = size(X);
num_cols = num_rows(2)
num_rows = num_rows(1);

%display data
figure
plot(x1, x2, '*');
title("data");
xlabel("X1");
ylabel("X2");

%find 4 clusters
num_clusters = 4;
%центры
%Начальное приближение в виде первых 4 строк
centres = zeros(num_clusters, num_cols);
for i=1:num_clusters
    centres(i, :) = X(i,:);
end

%U
U = zeros(num_rows, num_clusters);

eps = 1e-6;
Q_pred = 1e307;

while true
    A = squareform(pdist([centres; X], 'minkowski', 4));
    % delete first column and last row
    for j = 1:num_clusters
        A(:,1) = [ ];
    end
    for i = 1:num_rows
        A(num_clusters+1,:) = [ ];
    end
    
    [dist,clust] = min(A,[],1);
    
    U = zeros(num_rows, num_clusters);
    for i=1:num_rows
        for j=1:num_clusters
            if (clust(i) == j)
                U(i, j) = 1;
            end
        end
    end
    
    Q_m = 0;
    for i = 1:num_clusters
        id_clust = clust == i;  % выбираем объекты, принадлежащие i-му кластеру
        X_i = X(id_clust, :);  % получаем матрицу объектов i-го кластера
        dist_i = pdist(X_i);  % вычисляем попарные расстояния между объектами i-го кластера
        Q_m = Q_m + sum(dist_i);  % суммируем квадраты расстояний между объектами i-го кластера
        dist_i = [];
    end
    
    for i = 1:num_clusters
        temp = find(U(:,i)==1);
        ss = size(temp);
        ss = ss(1);
        for j = 1:num_cols
            summ = 0;
            for k = 1:ss
                summ = summ + X(temp(k),j);
            end
            centres(i,j) = summ/ss;
        end
    end
    
    
    if abs(Q_pred-Q_m) < eps
        break
    else
        Q_pred = Q_m;
    end
end

figure
gscatter(x1,x2,clust);
hold on;
t = 0:pi/180:2*pi;

scatter(centres(:,1),centres(:,2),20,'k','filled');
title('Найденные кластеры и их центры');
xlabel('X2');
ylabel('X1');