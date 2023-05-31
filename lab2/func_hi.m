%Releya
function y = func_hi(param, x)
    n = param(1);
    if (n < 0)
        n = -1*n;
    end
    y = 1/(2^(n/2)*gamma(n/2))*x.^(n/2-1).*exp(-x./2);
end