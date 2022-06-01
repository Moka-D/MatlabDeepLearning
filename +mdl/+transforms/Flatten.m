classdef Flatten < mdl.common.CallableObj
    methods (Access = protected)
        function out = call(~, array)
            out = mdl.np.flatten(array);
        end
    end
end
