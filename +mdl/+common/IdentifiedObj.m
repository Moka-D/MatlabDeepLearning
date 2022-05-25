classdef (Abstract) IdentifiedObj < handle
    properties (GetAccess = protected, SetAccess = private)
        hash
    end

    methods (Access = protected)
        function self = IdentifiedObj()
            self.hash = mdl.common.IdentifiedObj.increment();
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
        function ret = id(self)
            ret = self.hash;
        end

        function ret = eq(lobj, robj)
            ret = (lobj.hash == robj.hash);
        end

        function ret = ne(lobj, robj)
            ret = (lobj.hash ~= robj.hash);
        end

        function ret = lt(lobj, robj)
            ret = (lobj.hash < robj.hash);
        end

        function ret = gt(lobj, robj)
            ret = (lobj.hash > robj.hash);
        end
    end
end
