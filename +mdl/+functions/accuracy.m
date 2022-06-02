function acc = accuracy(y, t)
    y = mdl.as_variable(y);
    t = mdl.as_variable(t);

    [~, pred_i] = max(y.data, [], 2);
    pred = mdl.np.reshape(pred_i, size(t));
    result = (pred == t.data);
    acc = mean(result);
    acc = mdl.Variable(acc);
end
