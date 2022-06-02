classdef DataLoader < handle
    properties
        dataset
        batch_size
        shuffle
        data_size
        max_iter
        iteration
        index
    end

    methods
        function self = DataLoader(dataset, batch_size, shuffle)
            if ~exist('shuffle', 'var')
                shuffle = true;
            end

            self.dataset = dataset;
            self.batch_size = batch_size;
            self.shuffle = shuffle;
            self.data_size = length(dataset);
            self.max_iter = ceil(self.data_size / batch_size);

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
                error('DataLoader:StopIteration', 'Stop iteration')
            end

            iter = self.iteration;
            batch_size_ = self.batch_size;
            batch_index = self.index((iter * batch_size_ + 1):((iter + 1) * batch_size_));
            x = [];
            t = zeros(batch_size_, 1);

            for idx = 1:batch_size_
                [tmp_x, tmp_t] = self.dataset(batch_index(idx));
                x_dim = mdl.np.ndim(tmp_x);
                x = mdl.np.assign_at_dim(x, x_dim + 1, idx, tmp_x);
                t(idx) = tmp_t;
            end

            self.iteration = self.iteration + 1;
        end
    end
end
