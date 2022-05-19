classdef Sin < mdl.Function
    methods
        function y = forward(~, x)
            y = sin(x);
        end

        function gx = backward(self, gy)
            x = self.inputs{1};
            gx = gy .* mdl.functions.cos(x);
        end
    end
end
