classdef AdaGrad < mdl.optimizers.Optimizer
    properties
        lr
        eps
        hs
    end

    methods
        function self = AdaGrad(lr, eps)
            if ~exist('lr', 'var')
                lr = 0.001;
            end
            if ~exist('eps', 'var')
                eps = 1e-8;
            end

            self@mdl.optimizers.Optimizer();
            self.lr = lr;
            self.eps = eps;
            self.hs = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
        end

        function update_one(self, param)
            h_key = param.id;
            if ~isKey(self.hs, h_key)
                self.hs(h_key) = zeros(size(param.data));
            end

            lr_ = self.lr;
            eps_ = self.eps;
            grad = param.grad.data;
            h = self.hs(h_key);

            h = h + grad .* grad;
            param.data = param.data - lr_ .* grad ./ (sqrt(h) + eps_);
            self.hs(h_key) = h;
        end
    end
end
