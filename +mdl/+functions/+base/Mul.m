classdef Mul < mdl.Function
    methods
        function y = forward(self, x0, x1)
            y = x0 .* x1;
        end

        function gxs = backward(self, gy)
            x0 = self.inputs{1}.data
            x1 = self.inputs{2}.data
            gxs = {gy .* x1, gy .* x0};
        end
    end
end
