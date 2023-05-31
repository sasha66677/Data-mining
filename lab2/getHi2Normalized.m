function [hi2_norm] = getHi2Normalized(y,y_new, sigma, p)
%GETHI2NORMALIZED returns hi^2 njrmalized kriterium
hi2 = sum(((y_new-y)./sigma).^2);
hi2 = hi2(1);
siz = length(y(:, 1));
hi2_norm = hi2/(siz-p-1);
end

