function y = pow(x, c)
    f = mdl.functions.base.Pow(c);
    y = f.call(x);
end
