classdef Set < mdl.common.List
    methods
        function add(self, val)
            if ~self.isin(val)
                self.append(val);
            end
        end
    end
end
