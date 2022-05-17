function r = as_variable(obj)
    if isa(obj, 'mdl.Variable')
        r = obj;
    else
        r = mdl.Variable(obj);
    end
end
