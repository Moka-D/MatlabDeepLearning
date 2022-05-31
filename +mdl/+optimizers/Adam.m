classdef Adam < mdl.optimizers.Optimizer
    properties
        t
        alpha
        beta1
        beta2
        eps
        ms
        vs
    end

    methods
        function self = Adam(varargin)
            p = inputParser;
            addParameter(p, 'alpha', 0.001, @isscalar);
            addParameter(p, 'beta1', 0.9,   @isscalar);
            addParameter(p, 'beta2', 0.999, @isscalar);
            addParameter(p, 'eps',   1e-8,  @isscalar);
            parse(p, varargin{:});

            self@mdl.optimizers.Optimizer();
            self.t = 0;
            self.alpha = p.Results.alpha;
            self.beta1 = p.Results.beta1;
            self.beta2 = p.Results.beta2;
            self.eps = p.Results.eps;
            self.ms = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
            self.vs = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
        end

        function update(self)
            self.t = self.t + 1;
            update@mdl.optimizers.Optimizer();
        end

        function r = lr(self)
            fix1 = 1 - power(self.beta1, self.t);
            fix2 = 1 - power(self.beta2, self.t);
            r = self.alpha * sqrt(fix2) / fix1;
        end

        function update_one(self, param)
            key = param.id;
            if ~isKey(self.ms, key)
                self.ms(key) = zeros(size(param.data));
                self.vs(key) = zeros(size(param.data));
            end

            m = self.ms(key);
            v = self.vs(key);
            beta1_ = self.beta1;
            beta2_ = self.beta2;
            eps_ = self.eps;
            grad = param.grad.data;

            m = m + (1 - beta1_) .* (grad - m);
            v = v + (1 - beta2_) .* (grad .* grad - v);
            param.data = param.data - self.lr .* m ./ (sqrt(v) + eps_);
            self.ms(key) = m;
            self.vs(key) = v;
        end
    end
end
