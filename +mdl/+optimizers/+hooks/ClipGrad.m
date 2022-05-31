classdef ClipGrad < mdl.common.CallableObj
    properties
        max_norm
    end

    methods
        function self = ClipGrad(max_norm)
            self.max_norm = max_norm;
        end

        function call(self, params)
            total_norm = 0;
            for idx = 1:length(params)
                param = params{idx};
                total_norm = total_norm + mdl.np.sum(param.grad.data .^ 2);
            end
            total_norm = sqrt(total_norm);

            rate = self.max_norm / (total_norm + 1e-6);
            if rate < 1
                for idx = 1:length(params)
                    param = params{idx};
                    param.grad.data = param.grad.data .* rate;
                end
            end
        end
    end
end
