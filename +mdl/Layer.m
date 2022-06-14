classdef (Abstract) Layer < dynamicprops & mdl.common.CallableObj
    properties
        inputs
        outputs
    end

    properties (Access = protected)
        params_
    end

    methods
        function self = Layer()
            self.params_ = mdl.common.Set();
        end

        function P = addprop(self, name, value)
            if ~isprop(self, name)
                if isa(value, 'mdl.Parameter') || isa(value, 'mdl.Layer')
                    self.params_.add(name);
                end
                P = addprop@dynamicprops(self, name);
            end
            self.(name) = value;
        end

        function out = params(self)
            out = {};
            for idx = length(self.params_):-1:1
                name = self.params_{idx};
                obj = self.(name);
                if isa(obj, 'mdl.Layer')
                    out = [out, obj.params()];
                else
                    out = [out, obj];
                end
            end
        end

        function cleargrad(self)
            params = self.params();
            for idx = 1:length(params)
                param = params{idx};
                param.cleargrad();
            end
        end

        function to_cpu(self)
            params = self.params();
            for idx = 1:length(params)
                param = params{idx};
                param.to_cpu();
            end
        end

        function to_gpu(self)
            params = self.params();
            for idx = 1:length(params)
                param = params{idx};
                param.to_gpu();
            end
        end
    end

    methods (Access = protected)
        function outputs = call(self, varargin)
            outputs = self.forward(varargin{:});
            if ~iscell(outputs)
                outputs = {outputs};
            end

            input_num = nargin - 1;
            self.inputs = cell(1, input_num);
            for idx = 1:input_num
                self.inputs{idx} = varargin{idx};
            end
            self.outputs = outputs;
            if length(outputs) == 1
                outputs = outputs{1};
            end
        end
    end

    methods (Abstract)
        y = forward(self, x)
    end
end
