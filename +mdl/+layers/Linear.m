classdef Linear < mdl.Layer
    methods
        function self = Linear(out_size, varargin)
            p = inputParser;
            valid_in_size = @(x) (isempty(x) || isscalar(x));
            addParameter(p, 'nobias', false, @islogical);
            addParameter(p, 'in_size', [], valid_in_size);
            parse(p, varargin{:});

            self@mdl.Layer();
            self.addprop('in_size', p.Results.in_size);
            self.addprop('out_size', out_size);

            self.addprop('W', mdl.Parameter([], 'W'));
            if ~isempty(self.in_size)
                self.init_W();
            end

            if p.Results.nobias
                self.addprop('b', []);
            else
                self.addprop('b', mdl.Parameter(zeros(1, out_size), 'b'));
            end
        end

        function y = forward(self, x)
            if isempty(self.W.data)
                self.in_size = size(x, 2);
                self.init_W();
            end
            y = mdl.functions.linear(x, self.W, self.b);
        end
    end

    methods (Access = private)
        function init_W(self)
            I = self.in_size;
            O = self.out_size;
            W_data = randn(I, O) ./ sqrt(1 ./ self.in_size);
            self.W.data = W_data;
        end
    end
end
