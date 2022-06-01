classdef Spiral < mdl.datasets.Dataset
    methods
        function prepare(self)
            [self.data, self.label] = mdl.datasets.get_spiral(self.train);
        end
    end
end
