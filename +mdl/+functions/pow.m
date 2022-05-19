function y = pow(x, c)
    f = mdl.functions.def.Pow(c);
    y = f(x);
end
