function dst = scatter_add(src, value, varargin)
    S = struct();
    S(1).type = '()';
    S(1).subs = varargin;
    tmp = subsref(src, S);
    tmp = tmp + value;
    dst = subsasgn(src, S, tmp);
end
