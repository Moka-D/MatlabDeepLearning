classdef Cos < mdl.Function
    methods
        function y = forward(~, x)
            y = cos(x);
        end

        function gx = backward(self, gy)
            x = self.inputs{1};
            gx = gy .* -mdl.functions.sin(x);
        end
    end
end
