function img = plot_dot_graph(output, varargin)
    p = inputParser;
    addParameter(p, 'verbose', true, @islogical);
    addParameter(p, 'to_file', 'graph.png', @ischar);
    parse(p, varargin{:});

    dot_graph = mdl.utils.get_dot_graph(output, p.Results.verbose);

    tmp_dir = '.tmp';
    if ~exist(tmp_dir, 'dir')
        mkdir(tmp_dir);
    end

    graph_path = fullfile(tmp_dir, 'tmp_graph.dot');
    fid = fopen(graph_path, 'w');
    fprintf(fid, dot_graph);
    fclose(fid);

    [~, ~, extension] = fileparts(p.Results.to_file);
    extension = strsplit(extension, '.');
    extension = extension{end};
    cmd = sprintf('dot %s -T %s -o %s', graph_path, extension, p.Results.to_file);
    system(cmd);

    try
        img = imread(p.Results.to_file);
        imshow(img);
    catch
        img = [];
    end
end
