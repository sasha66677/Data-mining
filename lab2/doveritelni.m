function [interval] = doveritelni(t1, t2, C, param)
    check = length(param);
    check = check(1);
    if (check == 2)
        interval(1,1) = param(1) + t1*sqrt(C(1));  
        interval(1,2) = param(1) + t2*sqrt(C(1));
        interval(2,1) = param(2) + t1*sqrt(C(2));  
        interval(2,2) = param(2) + t2*sqrt(C(2));
    else
        interval(1) = param + t1*sqrt(C);  
        interval(2) = param + t2*sqrt(C);
    end
end