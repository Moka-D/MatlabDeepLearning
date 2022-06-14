function dst = assign_at_max_dim(src, idx, val)
    assert(isscalar(idx));

    dst = src;

    ndim = mdl.np.ndim(dst);
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
