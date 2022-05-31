function y = softmax_cross_entropy(x, t)
    f = mdl.functions.def.SoftmaxCrossEntropy();
    y = f(x, t);
end
