classdef Transpose < mdl.Function
    properties
        axes
    end

    methods
        function self = Transpose(axes)
            if ~exist('axes', 'var')
                axes = [];
            end
            self.axes = axes;
        end

        function y = forward(self, x)
            y = mdl.np.transpose(x, self.axes);
        end

        function gx = backward(self, gy)
            if isempty(self.axes)
                gx = mdl.functions.transpose(gy);
                return
            end

            axes_len = length(self.axes);
            [~, inv_axes] = sort(rem(self.axes, axes_len+1));
            gx = mdl.functions.transpose(gy, inv_axes);
        end
    end
end
