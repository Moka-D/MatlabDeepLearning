function y = get_item(x, varargin)
    f = mdl.functions.def.GetItem(varargin);
    y = f(x);
end
