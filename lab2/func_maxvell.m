%Maxvella
function y = func_maxvell(param, x)
    a = param(1);
    y = sqrt(2/pi)*a^3.*x.^2.*exp(-a^2.*x.^2./2);
end