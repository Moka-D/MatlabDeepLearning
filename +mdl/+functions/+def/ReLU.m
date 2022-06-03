classdef ReLU < mdl.Function
    methods
        function y = forward(~, x)
            y = max(x, 0);
        end

        function gx = backward(self, gy)
            x = self.inputs{1};
            mask = double(x.data > 0);
            gx = gy .* mask;
        end
    end
end
