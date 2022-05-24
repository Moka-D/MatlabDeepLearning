function y = linear(x, W, b)
    if ~exist('b', 'var')
        b = [];
    end
    f = mdl.functions.def.Linear();
    y = f(x, W, b);
end
