function m = logsumexp(x, dim)
    if ~exist('dim', 'var')
        dim = 2;
    end
    m = max(x, [], dim);
    y = x - m;
    y = exp(y);
    s = sum(y, dim);
    s = log(s);
    m = m + s;
end
