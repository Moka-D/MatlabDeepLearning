function ret = numerical_diff(f, x, eps_)
    if ~exist('eps_', 'var')
        eps_ = 1e-4;
    end

    x0 = mdl.Variable(x.data - eps_);
    x1 = mdl.Variable(x.data + eps_);
    y0 = f.call(x0);
    y1 = f.call(x1);
    ret = (y1.data - y0.data) ./ (2 .* eps_);
end
