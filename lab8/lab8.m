clc;
close all;
clear all;

numOfVar = 2;

ab = 5;


% трёхмерный график

xs = -5 : 0.1 : 5;
ys = -5 : 0.1 : 5;
[Xplot, Yplot] = meshgrid(xs, ys);
Xplot(1, 1)
Yplot(1, 1)
Z = func(Xplot, Yplot)
surfc(xs, ys, Z);

% стохастический поиск
points = 50000;
XY = [];

for i = 1:numOfVar
    XY = [XY; -ab + 2.*ab.*rand(1, points)]; %#ok<AGROW>
end

Z_st = func(XY(1, :), XY(2, :));
[Fmin, index] = min(Z_st);
Xmin = XY(:, index)';

% метод имитации отжига (несколько раз)

results = [];
for k = 1 : 5
    
    T = 50;
    T0 = 0.0001;
    v = 0.4;
    
    X = zeros(1, 2);
    for j=1:numOfVar
        X(i) = -ab + 2.*ab.*rand();
    end
    
    X_old = X;
    l = 0;
    %сам алгоритм
    while true
        l = l + 1;
        
        for i = 1:numOfVar
            X(i) = X_old(i) + randn() * T * ((1 + l / T)^(2 * rand() - 1) - 1);
        end
        
        isGood = true;
        for i = 1:numOfVar
            if abs(X(i)) > ab
                isGood = false;
                break;
            end
        end
        
        if ~isGood
            continue;
        end
        
        F = func(X(1), X(2));
        F_old = func(X_old(1), X_old(2));
        
        delta = F - F_old;
        
        if delta < 0 || rand() < exp(-delta/T)
            X_old = X;
        else
            T = v * T;
        end
        
        if (T < T0)
            break;
        end
        
        if(T<10)
            v=0.99;
        end
    end
    
    results = [results; [F_old, X_old]]; %#ok<AGROW>
end

F_old=results(:, 1);
X_old=[results(:,2), results(:,3)];
[F_old, index] = min(F_old);

disp('     value         x         y');
disp([Fmin, Xmin]);
disp('     value         x         y');
disp([F_old, X_old(index, 1), X_old(index, 2)]);