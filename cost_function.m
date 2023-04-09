function y = cost_function(x, a, b, c, d)
    y = sum(c.*exp(a*x) + d.*exp(-b*x));
end

