classdef MatMul < mdl.Function
    methods
        function y = forward(~, x, W)
            y = x * W;
        end

        function gxs = backward(self, gy)
            [x, W] = self.inputs{:};
            gx = mdl.functions.matmul(gy, W.');
            gW = mdl.functions.matmul(x.', gy);
            gxs = {gx, gW};
        end
    end
end
