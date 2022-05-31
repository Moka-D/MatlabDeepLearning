function y = clip(x, x_min, x_max)
    f = mdl.functions.def.Clip(x_min, x_max);
    y = f(x);
end
