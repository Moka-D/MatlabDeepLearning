classdef GetItem < mdl.Function
    properties
        slices
    end

    methods
        function self = GetItem(slices)
            self.slices = slices;
        end

        function y = forward(self, x)
            S = struct();
            S(1).type = '()';
            S(1).subs = self.slices;
            y = subsref(x, S);
        end

        function gx = backward(self, gy)
            x = self.inputs{1};
            f = mdl.functions.def.GetItemGrad(self.slices, size(x));
            gx = f(gy);
        end
    end
end
