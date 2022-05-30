classdef SGD < mdl.optimizers.Optimizer
    properties
        lr
    end

    methods
        function self = SGD(lr)
            if ~exist('lr', 'var')
                lr = 0.01;
            end
            self@mdl.optimizers.Optimizer();
            self.lr = lr;
        end

        function update_one(self, param)
            param.data = param.data - self.lr .* param.grad.data;
        end
    end
end
