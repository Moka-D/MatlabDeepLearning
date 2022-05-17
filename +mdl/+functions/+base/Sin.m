classdef Sin < mdl.Function
    methods
        function y = forward(self, x)
            y = sin(x);
        end

        function gx = backward(self, gy)
            x = self.inputs{1}.data;
            gx = gy .* cos(x);
        end
    end
end
