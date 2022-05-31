classdef Pow < mdl.Function
    properties
        c
    end

    methods
        function self = Pow(c)
            self.c = c;
        end

        function y = forward(self, x)
            y = x .^ self.c;
        end

        function gx = backward(self, gy)
            x = self.inputs{1};
            c_ = self.c;
            gx = c_ .* x .^ (c_ - 1) .* gy;
        end
    end
end
