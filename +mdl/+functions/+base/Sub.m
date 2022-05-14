classdef Sub < mdl.Function
    methods
        function y = forward(self, x0, x1)
            y = x0 - x1;
        end

        function gx = backward(self, gy)
            gx = {gy, -gy};
        end
    end
end
