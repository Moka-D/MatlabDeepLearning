classdef MomentumSGD < mdl.optimizers.Optimizer
    properties
        lr
        momentum
        vs
    end

    methods
        function self = MomentumSGD(lr, momentum)
            if ~exist('lr', 'var')
                lr = 0.01;
            end
            if ~exist('momentum', 'var')
                momentum = 0.9;
            end

            self@mdl.optimizers.Optimizer();
            self.lr = lr;
            self.momentum = momentum;
            self.vs = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
        end

        function update_one(self, param)
            v_key = param.id;
            if ~isKey(self.vs, v_key)
                self.vs(v_key) = zeros(size(param.data));
            end

            v = self.vs(v_key);
            v = v .* self.momentum - self.lr .* param.grad.data;
            param.data = param.data + v;
            self.vs(v_key) = v;
        end
    end
end
