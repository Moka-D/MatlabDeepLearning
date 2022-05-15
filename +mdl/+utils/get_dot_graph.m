function txt = get_dot_graph(output, verbose)
    if ~exist('verbose', 'var')
        verbose = false;
    end

    txt = '';
    funcs = mdl.common.List();
    seen_set = mdl.common.List();

    mdl.common.add_func(output.creator, funcs, seen_set);
    txt = strcat(txt, dot_var(output, verbose));

    while length(funcs)
        func = funcs.pop();
        txt = strcat(txt, dot_func(func));
        for idx = 1:length(func.inputs)
            x = func.inputs{idx};
            txt = strcat(txt, dot_var(x, verbose));
            if ~isempty(x.creator)
                mdl.common.add_func(x.creator, funcs, seen_set);
            end
        end
    end

    txt = ['digraph g {\n', txt, '}'];
end


function txt = dot_var(v, verbose)
    if isempty(v.name)
        name = '';
    else
        name = v.name;
    end

    if verbose && ~isempty(v.data)
        if ~isempty(v.name)
            name = [name, ': '];
        end
        tmp_txt = sprintf('%s %s', v.shape, v.dtype);
        name = [name, tmp_txt];
    end

    dot_var_txt = '%d [label="%s", color=orange, style=filled]\n';
    txt = sprintf(dot_var_txt, id(v), name);
end


function txt = dot_func(f)
    dot_func_txt = '%d [label="%s", color=lightblue, style=filled, shape=box]\n';
    f_classname = strsplit(class(f), '.'){end};
    txt = sprintf(dot_func_txt, id(f), f_classname);

    dot_edge = '%d -> %d\n';
    for ix = 1:length(f.inputs)
        x = f.inputs{ix};
        tmp_txt = sprintf(dot_edge, id(x), id(f));
        txt = strcat(txt, tmp_txt);
    end
    for iy = 1:length(f.outputs)
        y = f.outputs{iy};
        tmp_txt = sprintf(dot_edge, id(f), id(y));
        txt = strcat(txt, tmp_txt);
    end
end
