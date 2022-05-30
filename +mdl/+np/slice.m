function y = slice(x, varargin)
    ndim = mdl.np.ndim(x);
    S = struct();
    S(1).type = '()';
    S(1).subs = get_slice_cell(varargin, ndim);
    y = subsref(x, S);
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
