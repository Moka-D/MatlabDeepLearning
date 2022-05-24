function y = linear_simple(x, W, b)
    if ~exist('b', 'var')
        b = [];
    end

    x = mdl.as_variable(x);
    W = mdl.as_variable(W);
    t = mdl.functions.matmul(x, W);
    if isempty(b)
        y = t;
        return
    end

    y = t + b;
    t.data = [];    % clear t.data for memory efficiency
end
