classdef RefObj < handle
    properties (GetAccess = public, SetAccess = private)
        hash
    end

    methods (Access = protected)
        function self = RefObj()
            self.hash = mdl.common.RefObj.increment();
        end
    end

    methods (Static, Access = private)
        function ret = increment()
            persistent stamp;
            if isempty(stamp)
                stamp = uint32(0);
            end
            stamp = stamp + uint32(1);
            ret = stamp;
        end
    end

    methods
        function ret = eq(lObj, rObj)
            ret = (lObj.hash == rObj.hash);
        end

        function ret = ne(lObj, rObj)
            ret = (lObj.hash ~= rObj.hash);
        end
    end
end
