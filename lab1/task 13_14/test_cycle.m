clear all;
clc;

m=3;
n=4; 
Q = zeros(m, n);

sum=0;

for i = 1:m
    for j = 1:n
        Q(i,j) = 10*rand;%floor(10*rand);
        sum = sum + Q(i,j);
    end
end

disp(Q);
sum