classdef Square < mdl.Function
    methods
        function y = forward(self, x)
            y = x .^ 2;
        end

        function gx = backward(self, gy)
            x = self.inputs{1}.data;
            gx = 2 .* x .* gy;
        end
    end
end
