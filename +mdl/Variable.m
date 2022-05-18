classdef Variable < mdl.common.RefObj
    properties
        data
        grad
        creator
        generation
        name
    end

    methods
        function self = Variable(val, name)
            self@mdl.common.RefObj();

            if ~exist('name', 'var')
                name = '';
            end

            if ~isempty(val)
                if ~isnumeric(val)
                    error('%s is not supported', class(val))
                end
            end

            self.data = val;
            self.generation = 0;
            self.name = name;
        end

        function out = size(self)
            out = size(self.data);
        end

        function txt = shape(self)
            txt = '(';
            sz = size(self.data);
            for s = sz
                txt = [txt, num2str(s), ', '];
            end
            txt = txt(1:end-2);
            txt = strcat(txt, ')');
        end

        function out = ndims(self)
            out = ndims(self.data);
        end

        function out = length(self)
            out = length(self.data);
        end

        function txt = dtype(self)
            txt = class(self.data);
        end

        function disp(self)
            if isempty(self.data)
                disp('variable(empty)')
            else
                disp('variable(')
                disp(self.data)
                fprintf(', shape=%s, dtype=%s)\n', self.shape, self.dtype);
            end
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

        function backward(self, varargin)
            p = inputParser;
            addParameter(p, 'retain_grad', false, @islogical);
            addParameter(p, 'create_graph', false, @islogical);
            parse(p, varargin{:});
            retain_grad = p.Results.retain_grad;
            create_graph = p.Results.create_graph;

            if isempty(self.grad)
                self.grad = mdl.Variable(ones(size(self.data)));
            end

            funcs = mdl.common.List();
            seen_set = mdl.common.List();

            function add_func(f)
                if ~(seen_set.isin(f))
                    funcs.append(f);
                    seen_set.append(f);
                    funcs.sort('generation');
                end
            end

            add_func(self.creator);

            while ~isempty(funcs)
                f = funcs.pop();

                gys = cell(size(f.outputs));
                for idx = 1:length(f.outputs)
                    output = f.outputs{idx};
                    gys{idx} = output.grad;
                end

                cm = mdl.ConfigManager('enable_backprop', create_graph);
                ME = [];
                try
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
                            add_func(x.creator);
                        end
                    end
                catch ME
                    % NOP
                end
                cm.delete();
                if ~isempty(ME)
                    rethrow(ME);
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
end
