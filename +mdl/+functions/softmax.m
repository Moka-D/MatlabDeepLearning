function p = softmax(x, dim)
    if ~exist('dim', 'var')
        dim = 2;
    end
    f = mdl.functions.def.Softmax(dim);
    p = f(x);
end
