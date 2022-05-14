classdef Variable < handle
    properties
        data
        grad
        creator
        generation
        name
    end

    methods
        function self = Variable(val, name)
            if ~exist('name', 'var')
                name = [];
            end

            if ~isempty(val)
                if ~isnumeric(val)
                    error('%s is not supported', class(val));
                end
            end

            self.data = val;
            self.generation = 0;
            self.name = name;
        end

        function out = size(self)
            out = size(self.data);
        end

        function out = ndims(self)
            out = ndims(self.data);
        end

        function out = length(self)
            out = length(self.data);
        end

        function disp(self)
            disp('variable(')
            disp(self.data)
            disp(')')
            disp('')
        end

        function r = plus(lhs, rhs)
            r = mdl.functions.add(lhs, rhs);
        end

        function r = minus(lhs, rhs)
            r = mdl.functions.sub(lhs, rhs);
        end

        function r = uminus(self)
            r = mdl.functions.neg(self);
        end

        function r = times(lhs, rhs)
            r = mdl.functions.mul(lhs, rhs);
        end

        function r = rdivide(lhs, rhs)
            r = mdl.functions.div(lhs, rhs);
        end

        function r = power(self, c)
            r = mdl.functions.pow(self, c);
        end

        function set_creator(self, func)
            self.creator = func;
            self.generation = func.generation + 1;
        end

        function cleargrad(self)
            self.grad = [];
        end

        function backward(self, retain_grad)
            if ~exist('retain_grad', 'var')
                retain_grad = false;
            end

            if isempty(self.grad)
                self.grad = ones(size(self.data));
            end

            funcs = mdl.common.List();
            seen_set = mdl.common.List();
            self.add_func(self.creator, funcs, seen_set);

            while length(funcs)
                f = funcs.pop();

                gys = {};
                for idx = 1:length(f.outputs)
                    output = f.outputs{idx};
                    gys{idx} = output.grad;
                end

                gxs = f.backward(gys{:});
                if ~iscell(gxs)
                    gxs = {gxs};
                end

                for idx = 1:length(f.inputs)
                    x = f.inputs{idx};
                    gx = gxs{idx};
                    if isempty(x.grad)
                        x.grad = gx;
                    else
                        x.grad = x.grad + gx;
                    end

                    if ~isempty(x.creator)
                        self.add_func(x.creator, funcs, seen_set);
                    end
                end

                if ~retain_grad
                    for idx = 1:length(f.outputs)
                        y = f.outputs{1};
                        y.grad = [];
                    end
                end
            end
        end
    end

    methods (Access = protected)
        function d = double(self)
            d = self.data;
        end
    end

    methods (Static, Access = private)
        function add_func(f, funcs, seen_set)
            if ~(seen_set.isin(f))
                funcs.append(f);
                seen_set.append(f);
                funcs.sort('generation');
            end
        end
    end
end
