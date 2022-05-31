classdef BroadcastTo < mdl.Function
    properties
        sz
        x_sz
    end

    methods
        function self = BroadcastTo(sz)
            self.sz = sz;
        end

        function y = forward(self, x)
            self.x_sz = size(x);
            y = mdl.np.broadcast_to(x, self.sz);
        end

        function gx = backward(self, gy)
            gx = mdl.functions(gy, self.x_sz);
        end
    end
end
