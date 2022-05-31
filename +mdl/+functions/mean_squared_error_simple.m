function y = mean_squared_error_simple(x0, x1)
    x0 = mdl.as_variable(x0);
    x1 = mdl.as_variable(x1);
    dif = x0 - x1;
    y = mdl.functions.sum(dif .^ 2) ./ length(dif);
end
