classdef DataLoader < handle
    properties
        dataset
        batch_size
        shuffle
        data_size
        max_iter
        gpu
        iteration
        index
    end

    methods
        function self = DataLoader(dataset, batch_size, varargin)
            p = inputParser;
            addRequired(p, 'dataset', @(x) isa(x, 'mdl.datasets.Dataset'));
            addRequired(p, 'batch_size', @isscalar);
            addOptional(p, 'shuffle', true, @islogical);
            addParameter(p, 'gpu', false, @islogical);
            parse(p, dataset, batch_size, varargin{:});

            self.dataset = p.Results.dataset;
            self.batch_size = p.Results.batch_size;
            self.shuffle = p.Results.shuffle;
            self.data_size = length(self.dataset);
            self.max_iter = ceil(self.data_size / self.batch_size);
            self.gpu = p.Results.gpu;

            self.reset();
        end

        function reset(self)
            self.iteration = 0;
            if self.shuffle
                self.index = randperm(length(self.dataset));
            else
                self.index = 1:length(self.dataset);
            end
        end

        function [x, t] = next(self)
            if self.iteration >= self.max_iter
                self.reset();
                error('DataLoader:StopIteration', 'Stop iteration');
            end

            iter = self.iteration;
            batch_size_ = self.batch_size;
            batch_index = self.index((iter * batch_size_ + 1):((iter + 1) * batch_size_));
            batch_x = cell(batch_size_, 1);
            batch_t = cell(batch_size_, 1);

            for idx = 1:batch_size_
                [tmp_x, tmp_t] = self.dataset(batch_index(idx));
                batch_x{idx} = tmp_x;
                batch_t{idx} = tmp_t;
            end

            if size(batch_x{1, 1}) > 1
                x = cell2mat(reshape(batch_x, 1, 1, []));
            else
                x = cell2mat(batch_x);
            end
            t = cell2mat(batch_t);
            if self.gpu
                x = mdl.gpu.as_gpu(x);
                t = mdl.gpu.as_gpu(t);
            end

            self.iteration = self.iteration + 1;
        end

        function to_cpu(self)
            self.gpu = false;
        end

        function to_gpu(self)
            self.gpu = true;
        end
    end
end
