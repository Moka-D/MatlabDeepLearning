classdef Log < mdl.Function
    methods
        function y = forward(~, x)
            y = log(x);
        end

        function gx = backward(self, gy)
            x = self.inputs{1};
            gx = gy ./ x;
        end
    end
end
