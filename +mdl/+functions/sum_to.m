function y = sum_to(x, sz)
    if isequal(size(x), sz)
        y = mdl.as_variable(x);
        return
    end
    f = mdl.functions.def.SumTo(sz);
    y = f(x);
end
