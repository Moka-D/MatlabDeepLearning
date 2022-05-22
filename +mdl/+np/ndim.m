function out = ndim(x)
    if isscalar(x)
        out = 0;
    elseif ismatrix(x) && size(x, 1) == 1
        out = 1;
    else
        out = ndims(x);
    end
end
