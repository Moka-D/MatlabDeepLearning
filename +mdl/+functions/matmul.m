function y = matmul(x, W)
    f = mdl.functions.def.MatMul();
    y = f(x, W);
end
