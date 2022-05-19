classdef Mul < mdl.Function
    methods
        function y = forward(~, x0, x1)
            y = x0 .* x1;
        end

        function gxs = backward(self, gy)
            [x0, x1] = self.inputs{:};
            gxs = {gy .* x1, gy .* x0};
        end
    end
end
