classdef FreezeParam < mdl.common.CallableObj
    properties
        freeze_params
    end

    methods
        function self = FreezeParam(varargin)
            self.freeze_params = mdl.common.List();
            layers = varargin;
            for l_i = 1:length(layers)
                l = varargin{l_i};
                if isa(l, 'mdl.Parameter')
                    self.freeze_params.append(l);
                else
                    params = l.params();
                    for p_i = 1:length(params)
                        p = params{p_i};
                        self.freeze_params.append(p);
                    end
                end
            end
        end

        function call(self, ~)
            for idx = 1:length(self.freeze_params)
                p = self.freeze_params.at(idx);
                p.grad = [];
            end
        end
    end
end
