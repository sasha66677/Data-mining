function z = func(x, y)

    z = -(1+cos(18*sqrt(x.^2.+y.^2)))./((x.^2.+y.^2)+1);
end
