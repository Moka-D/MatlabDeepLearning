function y = sub(x0, x1)
    f = mdl.functions.base.Sub();
    y = f.call(x0, x1);
end
