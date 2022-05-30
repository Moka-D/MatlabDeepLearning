function dst = scatter_add(src, value, varargin)
    ndim = mdl.np.ndim(src);
    S = struct();
    S(1).type = '()';
    S(1).subs = get_slice_cell(varargin, ndim);
    tmp = subsref(src, S);
    tmp = tmp + value;
    dst = subsasgn(src, S, tmp);
end


function out = get_slice_cell(in_slice, ndim)
    out = cell(1, ndim);
    for idx = 1:ndim
        if idx <= length(in_slice)
            out{idx} = in_slice{idx};
        else
            out{idx} = ':';
        end
    end
end
