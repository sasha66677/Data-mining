%normalnoe 
function y = func_normal(param, x)
    m = param(1);
    sigm = param(2);
    if (sigm < 0)
        sigm = -1*sigm;
    end
    y = exp(-(x-m).^2./(2*sigm*sigm))./(sigm*sqrt(2*pi));
end