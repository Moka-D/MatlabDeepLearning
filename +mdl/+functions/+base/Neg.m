classdef Neg < mdl.Function
    methods
        function y = forward(self, x)
            y = -x;
        end

        function gx = backward(self, gy)
            gx = -gy;
        end
    end
end
