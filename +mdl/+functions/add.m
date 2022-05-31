function y = add(x0, x1)
    f = mdl.functions.def.Add();
    y = f(x0, x1);
end
