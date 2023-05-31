function [kor_ost] = autokorel(R, N, k)
    kor_ost = zeros(k, 1);

    sum_znam = sum(R.^2)./N(1);
    for i=1:k
        res = 0;
        for j=1:N(1)-i+1
            res = res + R(j)*R(j+i-1);
        end
        kor_ost(i) = res./(N(1)-i+1)./sum_znam;
    end
end
