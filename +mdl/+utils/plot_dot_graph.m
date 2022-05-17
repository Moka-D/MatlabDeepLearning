function plot_dot_graph(output, varargin)
    p = inputParser;
    addParameter(p, 'verbose', true, @islogical);
    addParameter(p, 'to_file', 'graph.png', @ischar);
    parse(p, varargin{:});
    verbose = p.Results.verbose;
    to_file = p.Results.to_file;

    dot_graph = mdl.utils.get_dot_graph(output, verbose);

    tmp_dir = '.tmp';
    if ~exist(tmp_dir, 'dir')
        mkdir(tmp_dir);
    end

    graph_path = fullfile(tmp_dir, 'tmp_graph.dot');
    fid = fopen(graph_path, 'w');
    fprintf(fid, dot_graph);
    fclose(fid);

    [~, ~, extension] = fileparts(to_file);
    extension = strsplit(extension, '.');
    extension = extension{end};
    cmd = sprintf('dot %s -T %s -o %s', graph_path, extension, to_file);
    system(cmd);

    try
        img = imread(to_file);
        imshow(img);
    catch
        % NOP
    end
end
