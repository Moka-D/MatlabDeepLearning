function y = softmax_cross_entropy_simple(x, t)
    x = mdl.as_variable(x);
    t = mdl.as_variable(t);
    N = x.size(1);
    p = mdl.functions.softmax(x);
    p = mdl.functions.clip(p, 1e-15, 1.0); % To avoid log(0)
    log_p = mdl.functions.log(p);
    ind = sub2ind(size(log_p), 1:N, t.data);
    tlog_p = log_p(ind);
    y = -1 .* mdl.functions.sum(tlog_p) ./ N;
end
