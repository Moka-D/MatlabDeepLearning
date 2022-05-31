function y = sum(x, dim)
    if ~exist('dim', 'var')
        dim = [];
    end

    f = mdl.functions.def.Sum(dim);
    y = f(x);
end
