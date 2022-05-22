classdef Sum < mdl.Function
    properties
        axis
        x_sz
    end

    methods
        function self = Sum(axis)
            self.axis = axis;
        end

        function y = forward(self, x)
            self.x_sz = size(x);
            y = mdl.np.sum(x, self.axis);
        end

        function gx = backward(self, gy)
            gx = mdl.functions.broadcast_to(gy, self.x_sz);
        end
    end
end
