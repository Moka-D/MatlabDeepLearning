classdef Linear < mdl.Function
    methods
        function y = forward(~, x, W, b)
            y = x * W;
            if ~isempty(b)
                y = y + b;
            end
        end

        function gxs = backward(self, gy)
            [x, W, b] = self.inputs{:};
            if isempty(b.data)
                gb = [];
            else
                gb = mdl.functions.sum_to(gy, b.size);
            end
            gx = mdl.functions.matmul(gy, W.');
            gW = mdl.functions.matmul(x.', gy);
            gxs = {gx, gW, gb};
        end
    end
end
