function out = ndim(x)
    if isscalar(x)
        out = 0;
    elseif isrow(x)
        out = 1;
    else
        out = ndims(x);
    end
end
