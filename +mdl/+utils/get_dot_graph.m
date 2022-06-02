function txt = get_dot_graph(output, verbose)
    % txt = get_dot_graph(output, verbose)
    %
    % Generate a graphviz DOT text of a computational graph.
    %
    % Build a graph of functions and variables backward-reachable from the
    % output. To visualize a graphviz DOT text, you need the dot binary
    % from the graphviz package (www.graphviz.org)
    %
    % Parameters
    % ----------
    % output (mdl.Variable): Output variable from which the graph is
    %     constucted.
    % verbose (logical): If true the dot graph contains additional
    %     information such as sizes and types.
    %
    % Returns
    % -------
    % txt (char): A graphviz DOT text consisting of nodes and edges that
    %     are backward-reachable from the output
    %
    % see also: mdl.utils.plot_dot_graph

    if ~exist('verbose', 'var')
        verbose = false;
    end

    txt = '';
    funcs = mdl.common.List();
    seen_set = mdl.common.Set();

    function add_func(f)
        if ~(seen_set.isin(f))
            funcs.append(f);
            seen_set.append(f);
        end
    end

    add_func(output.creator);
    txt = strcat(txt, dot_var(output, verbose));

    while ~isempty(funcs)
        func = funcs.pop();
        txt = strcat(txt, dot_func(func));
        for idx = 1:length(func.inputs)
            x = func.inputs{idx};
            txt = strcat(txt, dot_var(x, verbose));
            if ~isempty(x.creator)
                add_func(x.creator);
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
        tmp_txt = sprintf('%s %s', v.size2str, class(v));
        name = [name, tmp_txt];
    end

    dot_var_txt = '%d [label="%s", color=orange, style=filled]';
    txt = format_with_return(dot_var_txt, v.id, name);
end


function txt = dot_func(f)
    dot_func_txt = '%d [label="%s", color=lightblue, style=filled, shape=box]';
    f_classname = strsplit(class(f), '.');
    f_classname = f_classname{end};
    txt = format_with_return(dot_func_txt, f.id, f_classname);

    dot_edge = '%d -> %d';
    for ix = 1:length(f.inputs)
        x = f.inputs{ix};
        tmp_txt = format_with_return(dot_edge, x.id, f.id);
        txt = strcat(txt, tmp_txt);
    end
    for iy = 1:length(f.outputs)
        y = f.outputs{iy};
        tmp_txt = format_with_return(dot_edge, f.id, y.id);
        txt = strcat(txt, tmp_txt);
    end
end


function txt = format_with_return(format_spec, varargin)
    txt = sprintf(format_spec, varargin{:});
    txt = strcat(txt, '\n');
end
