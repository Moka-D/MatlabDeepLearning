function r = as_variable(obj)
    if strcmp(class(obj), 'mdl.Variable')
        r = obj;
    else
        r = mdl.Variable(obj);
    end
end
