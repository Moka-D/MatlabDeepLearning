classdef Tanh < mdl.Function
    methods
        function y = forward(~, x)
            y = tanh(x);
        end

        function gx = backward(self, gy)
            y = self.outputs{1};
            gx = gy .* (1 - y .* y);
        end
    end
end
