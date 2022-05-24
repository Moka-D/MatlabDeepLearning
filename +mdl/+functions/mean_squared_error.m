function y = mean_squared_error(x0, x1)
    f = mdl.functions.def.MeanSquaredError();
    y = f(x0, x1);
end
