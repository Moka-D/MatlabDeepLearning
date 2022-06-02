function subs = create_subs_dim(idx, ndim)
    subs = cell(1, ndim);
    subs(:) = {':'};
    subs{ndim} = idx;
end
