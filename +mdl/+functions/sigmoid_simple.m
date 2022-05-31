function y = sigmoid_simple(x)
    x = mdl.as_variable(x);
    y = 1 ./ (1 + mdl.functions.exp(-x));
end
