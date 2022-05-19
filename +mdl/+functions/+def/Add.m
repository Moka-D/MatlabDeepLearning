classdef Add < mdl.Function
    methods
        function y = forward(~, x0, x1)
            y = x0 + x1;
        end

        function gxs = backward(~, gy)
            gxs = {gy, gy};
        end
    end
end
