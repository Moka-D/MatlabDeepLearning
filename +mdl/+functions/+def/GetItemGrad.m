classdef GetItemGrad < mdl.Function
    properties
        slices
        in_size
    end

    methods
        function self = GetItemGrad(slices, in_size)
            self.slices = slices;
            self.in_size = in_size;
        end

        function gx = forward(self, gy)
            gx = zeros(self.in_size);
            gx = mdl.np.scatter_add(gx, gy, self.slices{:});
        end

        function ggy = backward(self, ggx)
            ggy = mdl.functions.get_item(ggx, self.slices{:});
        end
    end
end
