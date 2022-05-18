classdef Exp < mdl.Function
    methods
        function y = forward(self, x)
            y = exp(x);
        end

        function gx = backward(self, gy)
            x = self.inputs{1};
            gx = exp(x) .* gy;
        end
    end
end
