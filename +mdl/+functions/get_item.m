function y = get_item(x, slices)
    f = mdl.functions.def.GetItem(slices);
    y = f(x);
end
