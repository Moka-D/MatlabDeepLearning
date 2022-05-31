classdef WeightDecay < mdl.common.CallableObj
    properties
        rate
    end

    methods
        function self = WeightDecay(rate)
            self.rate = rate;
        end

        function call(self, params)
            for idx = 1:length(params)
                param = params{idx};
                param.grad.data = param.grad.data + self.rate .* param.data;
            end
        end
    end
end
