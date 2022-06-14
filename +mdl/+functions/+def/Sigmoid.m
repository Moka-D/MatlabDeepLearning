classdef Sigmoid < mdl.Function
    methods
        function y = forward(~, x)
            % y = 1 ./ (1 + epx(-x));
            y = tanh(x .* 0.5) .* 0.5 + 0.5;    % Better implementation
        end

        function gx = backward(self, gy)
            y = self.outputs{1};
            gx = gy .* y .* (1 - y);
        end
    end
end
