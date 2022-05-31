classdef Sub < mdl.Function
    properties
        x0_sz
        x1_sz
    end

    methods
        function y = forward(self, x0, x1)
            self.x0_sz = size(x0);
            self.x1_sz = size(x1);
            y = x0 - x1;
        end

        function gxs = backward(self, gy)
            gx0 = gy;
            gx1 = -gy;
            if ~isequal(self.x0_sz, self.x1_sz)
                gx0 = mdl.functions.sum_to(gx0, self.x0_sz);
                gx1 = mdl.functions.sum_to(gx1, self.x1_sz);
            end
            gxs = {gx0, gx1};
        end
    end
end
