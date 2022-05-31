classdef Reshape < mdl.Function
    properties
        sz
        x_sz
    end

    methods
        function self = Reshape(sz)
            self.sz = sz;
        end

        function y = forward(self, x)
            self.x_sz = size(x);
            y = mdl.np.reshape(x, self.sz);
        end

        function gx = backward(self, gy)
            gx = mdl.functions.reshape(gy, self.x_sz);
        end
    end
end
