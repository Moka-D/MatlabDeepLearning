classdef MeanSquaredError < mdl.Function
    methods
        function y = forward(~, x0, x1)
            dif = x0 - x1;
            y = mdl.np.sum(dif .^ 2) ./ length(dif);
        end

        function gxs = backward(self, gy)
            [x0, x1] = self.inputs{:};
            dif = x0 - x1;
            gx0 = gy .* dif .* (2 ./ length(dif));
            gx1 = -gx0;
            gxs = {gx0, gx1};
        end
    end
end
