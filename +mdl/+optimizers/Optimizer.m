classdef (Abstract) Optimizer < handle
    properties
        target
        hooks
    end

    methods
        function self = Optimizer()
            self.hooks = mdl.common.List();
        end

        function setup(self, target)
            self.target = target;
        end

        function update(self)
            params = self.target.params();
            params_list = mdl.common.List();
            for p_i = 1:length(params)
                p = params{p_i};
                if ~isempty(p.grad)
                    params_list.append(p);
                end
            end

            for f_i = 1:length(self.hooks)
                f = self.hooks{f_i};
                f(params_list.data);
            end

            for p_i = 1:length(params_list)
                p = params_list{p_i};
                self.update_one(p);
            end
        end

        function add_hook(self, f)
            self.hooks.append(f);
        end
    end

    methods (Abstract)
        update_one(self, param)
    end
end
