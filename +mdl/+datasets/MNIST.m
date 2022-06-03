classdef MNIST < mdl.datasets.Dataset
    methods
        function self = MNIST(varargin)
            default_transform = mdl.transforms.Compose({mdl.transforms.Flatten(), ...
                                                        mdl.transforms.ToSingle(), ...
                                                        mdl.transforms.Normalize(0, 255)});
            p = inputParser;
            valid_callable = @(x) isempty(x) || ...
                isa(x, 'function_handle') || isa(x, 'mdl.common.CallableObj');
            addOptional(p, 'train', true, @islogical);
            addParameter(p, 'transform', default_transform, valid_callable);
            addParameter(p, 'target_transform', [], valid_callable);
            parse(p, varargin{:});

            self@mdl.datasets.Dataset(p.Results.train, ...
                                      'transform', p.Results.transform, ...
                                      'target_transform', p.Results.target_transform);
        end

        function prepare(self)
            url = 'http://yann.lecun.com/exdb/mnist/';
            train_files = containers.Map({'target', 'label'}, ...
                {'train-images-idx3-ubyte.gz', 'train-labels-idx1-ubyte.gz'});
            test_files = containers.Map({'target', 'label'}, ...
                {'t10k-images-idx3-ubyte.gz', 't10k-labels-idx1-ubyte.gz'});

            if self.train
                files = train_files;
            else
                files = test_files;
            end
            data_path = mdl.utils.get_file(strcat(url, files('target')));
            label_path = mdl.utils.get_file(strcat(url, files('label')));

            self.data = self.load_data(data_path);
            self.label = self.load_label(label_path);
        end

        function show(self, row, col)
            if ~exist('row', 'var')
                row = 10;
            end
            if ~exist('col', 'var')
                col = 10;
            end

            H = 28;
            W = 28;
            img = zeros(H * row, W * col);
            for r = mdl.common.range(row)
                for c = mdl.common.range(col)
                    img((r * H + 1):((r + 1) * H), (c * W + 1):((c + 1) * W)) = ...
                        mdl.np.reshape(mdl.np.slice_at_max_dim(self.data, randi([1, length(self.data)])), H, W);
                end
            end
            imshow(img, 'Interpolation', 'nearest')
        end
    end

    methods (Static)
        function out = labels()
            ids = 1:10;
            strs = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
            out = containers.Map(ids, strs);
        end
    end

    methods (Access = private)
        function labels = load_label(~, filepath)
            unziped_filepath = char(gunzip(filepath));
            [fid, msg] = fopen(unziped_filepath, 'r', 'b');
            ME = [];
            try
                if fid < 0
                    error(msg);
                end

                % Read the magic number
                magic_num = fread(fid, 1, 'int32', 0, 'b');
                assert(magic_num == 2049);

                num_items = fread(fid, 1, 'int32', 0, 'b');

                labels = fread(fid, inf, 'unsigned char=>double');
                labels = reshape(labels, num_items, 1); % num_items x 1
                labels = labels + 1;
            catch ME
                % NOP
            end
            fclose(fid);
            delete(unziped_filepath);
            if ~isempty(ME)
                rethrow(ME);
            end
        end

        function data = load_data(~, filepath)
            unziped_filepath = char(gunzip(filepath));
            [fid, msg] = fopen(unziped_filepath, 'r', 'b');
            ME = [];
            try
                if fid < 0
                    error(msg);
                end

                % Read the magic number
                magic_num = fread(fid, 1, 'int32', 0, 'b');
                assert(magic_num == 2051);

                % Read the number of images, rows and columns
                num_images = fread(fid, 1, 'int32', 0, 'b');
                num_rows   = fread(fid, 1, 'int32', 0, 'b');
                num_cols   = fread(fid, 1, 'int32', 0, 'b');

                % Read the image data
                data = fread(fid, inf, 'unsigned char=>uint8');

                % Reshape the data to array X
                data = reshape(data, num_cols, num_rows, num_images);
                data = permute(data, [2 1 3]);
                [H, W, ~] = size(data);
                data = reshape(data, [H, W, 1, num_images]);
            catch ME
                % NOP
            end
            fclose(fid);
            delete(unziped_filepath);
            if ~isempty(ME)
                rethrow(ME);
            end
        end
    end
end
