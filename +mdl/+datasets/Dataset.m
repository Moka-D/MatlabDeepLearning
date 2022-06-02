classdef (Abstract) Dataset < mdl.common.GetItemObj
    properties
        train
        transform
        target_transform
        data
        label
    end

    methods
        function self = Dataset(varargin)
            p = inputParser;
            valid_callable = @(x) isempty(x) || ...
                isa(x, 'function_handle') || isa(x, 'mdl.common.CallableObj');
            addOptional(p, 'train', true, @islogical);
            addParameter(p, 'transform', [], valid_callable);
            addParameter(p, 'target_transform', [], valid_callable);
            parse(p, varargin{:});

            self.train = p.Results.train;
            self.transform = p.Results.transform;
            self.target_transform = p.Results.target_transform;
            if isempty(self.transform)
                self.transform = @(x) x;
            end
            if isempty(self.target_transform)
                self.target_transform = @(x) x;
            end
            self.prepare();
        end

        function out = length(self)
            out = length(self.data);
        end
    end

    methods (Access = protected)
        function [data, label] = getitem(self, index)
            assert(isscalar(index));
            data = self.transform(mdl.np.slice_at_max_dim(self.data, index));
            if isempty(self.label)
                label = [];
            else
                label = self.target_transform(self.label(index));
            end
        end
    end

    methods (Abstract)
        prepare(self)
    end
end
