function deduct_signal = deduct_signal(index_1, index_2, x)
    n = length(x);
    fu = zeros(1, n);
    for i = 1:n
        fu(i) = x(i) - (index_1 * i + index_2 * i^2);
    end
    deduct_signal = fu;
end