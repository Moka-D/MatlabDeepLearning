function y = transpose(x, axes)
    if ~exist('axes', 'var')
        axes = [];
    end
    f = mdl.functions.def.Transpose(axes);
    y = f(x);
end
