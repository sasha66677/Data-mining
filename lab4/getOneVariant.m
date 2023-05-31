function [ b ] = getOneVariant( a )
    N = size(a);
    K = N(3);
    N = N(2);
    for i=1:N
        for j =1:K
            b(i,j) = a(1, i, j);
        end
    end
end