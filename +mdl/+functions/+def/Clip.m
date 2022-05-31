classdef Clip < mdl.Function
    properties
        x_min
        x_max
    end

    methods
        function self = Clip(x_min, x_max)
            self.x_min = x_min;
            self.x_max = x_max;
        end

        function y = forward(self, x)
            y = mdl.np.clip(x, self.x_min, self.x_max);
        end

        function gx = backward(self, gy)
            x = self.inputs{1};
            mask = (x.data >= self.x_min) .* (x.data <= self.x_max);
            gx = gy .* mask;
        end
    end
end
