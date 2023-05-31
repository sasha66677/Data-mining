function [X] = my_gauss_gen(N, M,D)
%возвращает случайные числа с распределением Гаусса (матожидание M, дисперсия D)
X=randn(N, 1).*sqrt(D) + M;
end

