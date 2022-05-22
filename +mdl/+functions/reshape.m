function y = reshape(x, sz)
    if length(sz) == 1
        sz = [1 sz];
    end

    if isequal(size(x), sz)
        y = mdl.as_variable(x);
        return
    end
    f = mdl.functions.def.Reshape(sz);
    y = f(x);
end
