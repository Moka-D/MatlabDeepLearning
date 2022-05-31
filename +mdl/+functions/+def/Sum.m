classdef Sum < mdl.Function
    properties
        dim
        x_sz
    end

    methods
        function self = Sum(dim)
            self.dim = dim;
        end

        function y = forward(self, x)
            self.x_sz = size(x);
            y = mdl.np.sum(x, self.dim);
        end

        function gx = backward(self, gy)
            gx = mdl.functions.broadcast_to(gy, self.x_sz);
        end
    end
end
