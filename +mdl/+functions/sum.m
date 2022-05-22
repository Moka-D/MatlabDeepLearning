function y = sum(x, axis)
    if ~exist('axis', 'var')
        axis = [];
    end

    f = mdl.functions.def.Sum(axis);
    y = f(x);
end
