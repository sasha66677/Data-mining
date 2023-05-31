clc;
clear all;
close all;

fid = fopen('data12.txt','r');
data = fscanf(fid,'%f',[2,inf])';
fclose(fid);

x = data(:,1);
y = data(:,2);

num_rows = size(x);
num_rows = num_rows(1)


%display data
figure
plot(x, y, '*');
title("Data points");
xlabel("x");
ylabel("y");


%calculate distance
dist_normal_euclid_ = pdist(data, 'seuclidean');
dist_city_ = pdist(data, 'cityblock');
dist_cheb_ = pdist(data, 'chebychev');

dist_normal_euclid = squareform(dist_normal_euclid_);
dist_city = squareform(dist_city_);
dist_cheb = squareform(dist_cheb_);




%link data
link = zeros(9, num_rows - 1, 3);
link_euclid_single = linkage(dist_normal_euclid, 'single');
link(1, :, :) = link_euclid_single;
link_euclid_complete = linkage(dist_normal_euclid, 'complete');
link(4, :, :) = link_euclid_complete;
link_euclid_centroid = linkage(dist_normal_euclid, 'centroid');
link(7, :, :) = link_euclid_centroid;

link_city_single = linkage(dist_city, 'single');
link(2, :, :) = link_city_single;
link_city_complete = linkage(dist_city, 'complete');
link(5, :, :) = link_city_complete;
link_city_centroid = linkage(dist_city, 'centroid');
link(8, :, :) = link_city_centroid;

link_cheb_single = linkage(dist_cheb, 'single');
link(3, :, :) = link_cheb_single;
link_cheb_complete = linkage(dist_cheb, 'complete');
link(6, :, :) = link_cheb_complete;
link_cheb_centroid = linkage(dist_cheb, 'centroid');
link(9, :, :) = link_cheb_centroid;


%coef table 
cogenetic_corr_coeff = zeros(3, 3);
cogenetic_corr_coeff(1, 1) = cophenet(link_euclid_single, dist_normal_euclid_);
cogenetic_corr_coeff(2, 1) = cophenet(link_euclid_complete, dist_normal_euclid_);
cogenetic_corr_coeff(3, 1) = cophenet(link_euclid_centroid, dist_normal_euclid_);

cogenetic_corr_coeff(1, 2) = cophenet(link_city_single, dist_city_);
cogenetic_corr_coeff(2, 2) = cophenet(link_city_complete, dist_city_);
cogenetic_corr_coeff(3, 2) = cophenet(link_city_centroid, dist_city_);

cogenetic_corr_coeff(1, 3) = cophenet(link_cheb_single, dist_cheb_);
cogenetic_corr_coeff(2, 3) = cophenet(link_cheb_complete, dist_cheb_);
cogenetic_corr_coeff(3, 3) = cophenet(link_cheb_centroid, dist_cheb_)


%find max nearest to 1
index = 1;
max_ = cogenetic_corr_coeff(1,1);
for i=1:3
    for j=1:3
        if (max_ < cogenetic_corr_coeff(i,j)) 
            max_ = cogenetic_corr_coeff(i,j);
            index = 3*(i-1) + j;
        end
    end
end
disp(index);
best = getOneVariant(link(index,:,:));


figure 
dendrogram(best);


numOfClusters = 4;
clust = cluster(best, 'maxclust', numOfClusters);


figure
hold on;
gscatter(x,y,clust);


centres = zeros(numOfClusters, 2);
dist_centres = zeros(numOfClusters, numOfClusters);
radius = zeros(numOfClusters, 1);
disper = zeros(numOfClusters, 1);


for k=1:numOfClusters
    cl = find(clust==k);%selects all the indices in T where the value is equal to k
    cl_size = size(cl);
    cl_size = cl_size(1);
    
    %centre
    cluster = zeros(cl_size, 2);
    for i=1:cl_size
        cluster(i, :) = data(cl(i), :);
        centres(k, :) = centres(k, :) + cluster(i,:);
    end
    centres(k, :) = centres(k,:)/cl_size;
    
    %radius and dispersion
    cl_dist_centr = zeros(cl_size, 1);
    for i=1:cl_size
        for j = 1:2
           cl_dist_centr(i) = cl_dist_centr(i) + (cluster(i,j)-centres(k,j))^2; 
        end
        disper(k) = disper(k) + cl_dist_centr(i);
        cl_dist_centr(i) = sqrt(cl_dist_centr(i));
    end
    
    disper(k) = disper(k)/cl_size;
    radius(k) = max(cl_dist_centr(:,1));
    
end

%distance between clasters
for i = 1:numOfClusters
    for j = i+1:numOfClusters
        for k = 1:2
            dist_centres(i,j) = dist_centres(i,j) + (centres(i,k)-centres(j,k))^2;
        end
        dist_centres(i,j) = sqrt(dist_centres(i,j));
    end
end
disp(centres);
disp(dist_centres);
disp(radius);
disp(disper);
%risunki
scatter(centres(:,1),centres(:,2));
