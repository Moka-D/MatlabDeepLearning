classdef Sigmoid < mdl.Function
    methods
        function y = forward(~, x)
            y = tanh(x .* 0.5) .* 0.5 + 0.5;
        end

        function gx = backward(self, gy)
            y = self.outputs{1};
            gx = gy .* y .* (1 - y);
        end
    end
end
