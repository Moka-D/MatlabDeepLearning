classdef Variable < mdl.common.IdentifiedObj
    properties
        data
        grad
        creator
        generation
        name
    end

    methods
        function self = Variable(val, name)
            self@mdl.common.IdentifiedObj();

            if ~exist('name', 'var')
                name = '';
            end

            if ~isempty(val)
                if ~isnumeric(val)
                    error('%s is not supported.', class(val));
                end
            end

            self.data = val;
            self.generation = 0;
            self.name = name;
        end

        function varargout = size(self, dim)
            n_outputs = nargout;
            varargout = cell(1, n_outputs);

            if n_outputs == 0 || n_outputs == 1
                if ~exist('dim', 'var')
                    varargout{1} = size(self.data);
                else
                    varargout{1} = size(self.data, dim);
                end
            else
                for k = 1:n_outputs
                    varargout{k} = size(self.data, k);
                end
            end
        end

        function txt = size2str(self)
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

        function txt = class(self)
            txt = class(self.data);
        end

        function txt = repr(self)
            if isempty(self.data)
                txt = 'variable(empty)';
            elseif length(self.data) == 1
                txt = sprintf('variable(%g)', self.data);
            elseif ismatrix(self.data)
                txt = 'variable([';
                rows = size(self.data, 1);
                for row = 1:rows
                    txt = [txt, num2str(self.data(row, :))];
                    if row ~= rows
                        txt = [txt, '; '];
                    end
                end
                txt = strcat(txt, '])');
            else
                txt = sprintf('variable(size=%s)', self.size2str());
            end
        end

        function disp(self)
            txt = self.repr();
            builtin('disp', txt);
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

        function r = mtimes(lhs, rhs)
            r = mdl.functions.matmul(lhs, rhs);
        end

        function r = rdivide(lhs, rhs)
            r = mdl.functions.div(lhs, rhs);
        end

        function r = power(self, c)
            r = mdl.functions.pow(self, c);
        end

        function out = reshape(self, varargin)
            sz = cell2mat(varargin);
            out = mdl.functions.reshape(self, sz);
        end

        function out = transpose(self)
            out = mdl.functions.transpose(self);
        end

        function out = sum(self, dim)
            if ~exist('dim', 'var')
                dim = [];
            end
            out = mdl.functions.sum(self, dim);
        end

        function varargout = subsref(self, s)
            switch s(1).type
                case '.'
                    [varargout{1:nargout}] = builtin('subsref', self, s);
                case '()'
                    if length(s) == 1
                        % self(indices)
                        [varargout{1:nargout}] = mdl.functions.get_item(self, s(1).subs{:});
                    else
                        error('Not a valid indexing expression.');
                    end
                case '{}'
                    [varargout{1:nargout}] = builtin('subsref', self, s);
                otherwise
                    error('Not a valid indexing expression.');
            end
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

            if isempty(self.grad)
                grad_val = ones(size(self.data));
                if mdl.gpu.on_gpu(self.data)
                    self.grad = mdl.Variable(gpuArray(grad_val));
                else
                    self.grad = mdl.Variable(grad_val);
                end
            end

            funcs = mdl.common.List();
            seen_set = mdl.common.Set();

            function add_func(f)
                if ~(seen_set.isin(f))
                    funcs.append(f);
                    seen_set.add(f);
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

                cm = mdl.ConfigManager('enable_backprop', p.Results.create_graph);
                ME = [];
                try
                    gxs = f.backward(gys{:});
                    if ~iscell(gxs)
                        gxs = {gxs};
                    end

                    for idx = 1:length(f.inputs)
                        if idx > length(gxs)
                            break
                        end
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

                if ~p.Results.retain_grad
                    for idx = 1:length(f.outputs)
                        y = f.outputs{idx};
                        y.grad = [];
                    end
                end
            end
        end

        function to_cpu(self)
            if ~isempty(self.data)
                self.data = mdl.gpu.as_cpu(self.data);
            end
        end

        function to_gpu(self)
            if ~isempty(self.data)
                self.data = mdl.gpu.as_gpu(self.data);
            end
        end
    end
end
