classdef Add < mdl.Function
    methods
        function y = forward(self, x0, x1)
            y = x0 + x1;
        end

        function gxs = backward(self, gy)
            gxs = {gy, gy};
        end
    end
end
