function dst = assign_at_dim(src, ndim, idx, val)
    assert(isscalar(idx));
    assert(isscalar(ndim));

    dst = src;
    if ndim == 1
        dst(idx) = val;
    elseif ndim == 2
        dst(idx, :) = val;
    else
        S = struct();
        S(1).type = '()';
        S(1).subs = mdl.np.create_subs_dim(idx, ndim);
        dst = subsasgn(dst, S, val);
    end
end
