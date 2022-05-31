classdef Div < mdl.Function
    methods
        function y = forward(~, x0, x1)
            y = x0 ./ x1;
        end

        function gxs = backward(self, gy)
            [x0, x1] = self.inputs{:};
            gx0 = gy ./ x1;
            gx1 = gy .* (-x0 ./ x1 .^ 2);
            if ~isequal(size(x0), size(x1))
                gx0 = mdl.functions.sum_to(gx0, size(x0));
                gx1 = mdl.functions.sum_to(gx1, size(x1));
            end
            gxs = {gx0, gx1};
        end
    end
end
