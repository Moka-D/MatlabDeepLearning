classdef Sub < mdl.Function
    methods
        function y = forward(~, x0, x1)
            y = x0 - x1;
        end

        function gx = backward(~, gy)
            gx = {gy, -gy};
        end
    end
end