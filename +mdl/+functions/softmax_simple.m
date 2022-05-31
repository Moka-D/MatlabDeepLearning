function p = softmax_simple(x, dim)
    if ~exist('dim', 'var')
        dim = 2;
    end
    x = mdl.as_variable(x);
    y = mdl.functions.exp(x);
    sum_y = mdl.functions.sum(y, dim);
    p = y ./ sum_y;
end
