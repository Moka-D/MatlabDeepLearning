function y = div(x0, x1)
    f = mdl.functions.base.Div();
    y = f.call(x0, x1);
end
