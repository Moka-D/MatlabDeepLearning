function y = add(x0, x1)
    f = mdl.functions.base.Add();
    y = f.call(x0, x1);
end
