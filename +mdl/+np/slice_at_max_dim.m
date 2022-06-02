function y = slice_at_max_dim(x, idx)
    assert(isscalar(idx));
    assert(~isempty(x));

    if ismatrix(x)
        y = x(idx, :);
    else
        ndim = ndims(x);
        S = struct();
        S(1).type = '()';
        S(1).subs = mdl.np.create_subs_dim(idx, ndim);
        y = subsref(x, S);
    end
end
