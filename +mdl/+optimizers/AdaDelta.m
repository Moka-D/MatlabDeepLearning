classdef AdaDelta < mdl.optimizers.Optimizer
    properties
        rho
        eps
        msg
        msdx
    end

    methods
        function self = AdaDelta(rho, eps)
            if ~exist('rho', 'var')
                rho = 0.95;
            end
            if ~exist('eps', 'var')
                eps = 1e-6;
            end

            self@mdl.optimizers.Optimizer();
            self.rho = rho;
            self.eps = eps;
            self.msg = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
            self.msdx = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
        end

        function update_one(self, param)
            key = param.id;
            if ~isKey(self.msg, key)
                self.msg(key) = zeros(size(param.data));
                self.msdx(key) = zeros(size(param.data));
            end

            msg_ = self.msg(key);
            rho_ = self.rho;
            eps_ = self.eps;
            msdx_ = self.msdx(key);
            grad = param.grad.data;

            msg_ = msg_ .* rho_;
            msg_ = msg_ + (1 - rho_) .* grad .* grad;
            dx = sqrt((msdx_ + eps_) ./ (msg_ + eps_)) .* grad;
            msdx_ = msdx_ .* rho_;
            msdx_ = msdx_ + (1 - rho_) .* dx .* dx;
            param.data = param.data - dx;
            self.msg(key) = msg_;
            self.msdx(key) = msdx_;
        end
    end
end
