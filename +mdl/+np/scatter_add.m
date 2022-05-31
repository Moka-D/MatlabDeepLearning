function y = scatter_add(x, value, varargin)
    S = struct();
    S(1).type = '()';
    S(1).subs = varargin;
    tmp = subsref(x, S) + value;
    y = subsasgn(x, S, tmp);
end
