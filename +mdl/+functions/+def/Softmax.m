classdef Softmax < mdl.Function
    properties
        dim
    end

    methods
        function self = Softmax(dim)
            if ~exist('dim', 'var')
                dim = 2;
            end
            self.dim = dim;
        end

        function y = forward(self, x)
            y = x - max(x, [], self.dim);
            y = exp(y);
            y = y ./ mdl.np.sum(y, self.dim);
        end

        function gx = backward(self, gy)
            y = self.outputs{1};
            gx = y .* gy;
            sumdx = gx.sum(self.dim);
            gx = gx - y .* sumdx;
        end
    end
end
