function y = relu(x)
    f = mdl.functions.def.ReLU();
    y = f(x);
end
