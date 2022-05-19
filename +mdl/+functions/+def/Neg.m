classdef Neg < mdl.Function
    methods
        function y = forward(~, x)
            y = -x;
        end

        function gx = backward(~, gy)
            gx = -gy;
        end
    end
end
