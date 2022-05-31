function ret = numerical_diff(f, x, eps)
    if ~exist('eps', 'var')
        eps = 1e-4;
    end

    x0 = mdl.Variable(x.data - eps);
    x1 = mdl.Variable(x.data + eps);
    y0 = f(x0);
    y1 = f(x1);
    ret = (y1.data - y0.data) ./ (2 .* eps);
end
