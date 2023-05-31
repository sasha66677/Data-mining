clc;
clear all;
close all;

Learn = readmatrix('Learning_data12.txt')'
PCA = readmatrix('PCA_data12.txt')

heigth = 3;
width = 2;
Net = newsom([1, 8; 1, 8; 1, 8; 1, 8; 1, 8; 1, 8; 1, 8; 1, 8;], [heigth width]);
%Net = newsom(Learn,[heigth width]);

Net.trainParam.epochs = 100;
Net = train(Net, Learn);    

% результаты
Res = sim(Net, Learn);

% индексы кластеров и их количество
[indClust, n] = vec2ind(Res);


Learn = Learn';

minL = min(Learn,[],'all');
maxL = max(Learn,[],'all');

% графики для каждого кластера
% + средние значения кластеров
figure
for num = 1:n
    index_pos = find(indClust == num);
    cluster = Learn(index_pos,:);
    m(num,:) = mean(cluster);
    subplot(heigth,width,num);
    plot(1:8, m(num,:),'r*');
    ylim([minL maxL]);
end

% центры кластеров для переменной PCA
for num = 1:n
    index_pos = find(indClust == num);
    cluster = PCA(index_pos,:);
    centres(num,:) = sum(cluster)./size(cluster,1);
end
    
% Построить графики переменной PCA с отображением кластеров и центров
% каждого кластера
figure
gscatter(PCA(:,1),PCA(:,2),indClust')
hold on;
scatter(centres(:,1),centres(:,2),'*')

% Найти минимальное и максимальное значения переменной PCA
minL = min(PCA,[],1);
maxL = max(PCA,[],1);

% Построить графики для каждого кластера, отображая элементы кластера
% на графике
for num = 1:n
    index = find(indClust == num);
    figure
    scatter(PCA(index,1),PCA(index,2),'r')
    name = "Cluster " + num2str(num);
    title(name);
    ylim([minL(2) maxL(2)]);
    xlim([minL(1) maxL(1)]);
end