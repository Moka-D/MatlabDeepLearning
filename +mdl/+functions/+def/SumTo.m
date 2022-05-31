classdef SumTo < mdl.Function
    properties
        sz
        x_sz
    end

    methods
        function self = SumTo(sz)
            self.sz = sz;
        end

        function y = forward(self, x)
            self.x_sz = size(x);
            y = mdl.utils.sum_to(x, self.sz);
        end

        function gx = backward(self, gy)
            gx = mdl.functions.broadcast_to(gy, self.x_sz);
        end
    end
end
