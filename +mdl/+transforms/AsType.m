classdef AsType < mdl.common.CallableObj
    properties
        dtype
    end

    methods
        function self = AsType(dtype)
            if ~exist('dtype', 'var')
                dtype = 'single';
            end
            self.dtype = dtype;
        end
    end

    methods (Access = protected)
        function out = call(self, array)
            out = cast(array, self.dtype);
        end
    end
end
