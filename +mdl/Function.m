classdef (Abstract) Function < mdl.common.RefObj
    properties
        inputs
        outputs
        generation
    end

    methods
        function self = Function()
            self@mdl.common.RefObj();
        end

        function outputs = call(self, varargin)
            inputs = {};
            for idx = 1:length(varargin)
                x = varargin{idx};
                inputs{idx} = mdl.as_variable(x);
            end

            xs = {};
            for idx = 1:length(inputs)
                x = inputs{idx};
                xs{idx} = x.data;
            end

            ys = self.forward(xs{:});
            if ~iscell(ys)
                ys = {ys};
            end

            outputs = {};
            for idx = 1:length(ys)
                y = ys{idx};
                outputs{idx} = mdl.Variable(y);
            end

            if mdl.Config.setget_enable_backprop
                f = @(x) x.generation;
                self.generation = max(cellfun(f, inputs));

                for idx = 1:length(outputs)
                    output = outputs{idx};
                    output.set_creator(self);
                end

                self.inputs = inputs;
                self.outputs = outputs;
            end

            if length(outputs) == 1
                outputs = outputs{1};
            end
        end
    end
end
