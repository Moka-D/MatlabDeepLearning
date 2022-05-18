classdef Div < mdl.Function
    methods
        function y = forward(self, x0, x1)
            y = x0 ./ x1;
        end

        function gxs = backward(self, gy)
            x0 = self.inputs{1};
            x1 = self.inputs{2};
            gx0 = gy ./ x1;
            gx1 = gy .* (-x0 ./ x1 .^ 2);
            gxs = {gx0, gx1};
        end
    end
end
