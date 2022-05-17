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

        function out = subsref(self, s)
            switch s(1).type
                case '.'
                    if length(s) == 1
                        % Implement self.PropertyName
                        out = self.(s.subs);
                    elseif length(s) == 2
                        prop_name = s(1).subs;
                        if strcmp(s(2).type, '{}')
                            % Implement self.PropertyName{indices}
                            out = self.(prop_name){s(2).subs{:}};
                        elseif strcmp(s(2).type, '()')
                            % Implement self.PropertyName(indices)
                            out = self.(prop_name)(s(2).subs{:});
                        else
                            error('Not a valid indexing expression')
                        end
                    else
                        error('Not a valid indexing expression')
                    end
                case '()'
                    if length(s) == 1
                        % Implement self(indices)
                        out = self.call(s.subs{:});
                    else
                        error('Not a valid indexing expression')
                    end
                otherwise
                    error('Not a valid indexing expression')
            end
        end
    end

    methods (Access = protected)
        function outputs = call(self, varargin)
            input_num = nargin - 1;
            inputs_ = cell(1, input_num);
            xs = cell(1, input_num);
            for idx = 1:input_num
                x = mdl.as_variable(varargin{idx});
                inputs_{idx} = x;
                xs{idx} = x.data;
            end

            ys = self.forward(xs{:});
            if ~iscell(ys)
                ys = {ys};
            end

            outputs = cell(size(ys));
            for idx = 1:length(ys)
                y = ys{idx};
                outputs{idx} = mdl.Variable(y);
            end

            if mdl.Config.setget_enable_backprop
                f = @(x) x.generation;
                self.generation = max(cellfun(f, inputs_));

                for idx = 1:length(outputs)
                    output = outputs{idx};
                    output.set_creator(self);
                end

                self.inputs = inputs_;
                self.outputs = outputs;
            end

            if length(outputs) == 1
                outputs = outputs{1};
            end
        end
    end
end
