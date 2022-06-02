classdef Linear < mdl.Layer
    properties
        in_size
        out_size
        dtype
    end

    methods
        function self = Linear(out_size, varargin)
            p = inputParser;
            valid_in_size = @(x) (isempty(x) || isscalar(x));
            expected_types = {'single', 'double', 'int8', 'uint8', 'int16', ...
                              'uint16', 'int32', 'uint32', 'int64', 'uint64'};
            addParameter(p, 'nobias', false, @islogical);
            addParameter(p, 'dtype', 'single', @(x) any(validatestring(x, expected_types)));
            addParameter(p, 'in_size', [], valid_in_size);
            parse(p, varargin{:});

            self@mdl.Layer();
            self.in_size = p.Results.in_size;
            self.out_size = out_size;
            self.dtype = p.Results.dtype;

            self.addprop('W', mdl.Parameter([], 'W'));
            if ~isempty(self.in_size)
                self.init_W();
            end

            if p.Results.nobias
                self.addprop('b', []);
            else
                self.addprop('b', mdl.Parameter(zeros(1, out_size, self.dtype), 'b'));
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
            W_data = randn(I, O, self.dtype) .* sqrt(1 ./ I);
            self.W.data = W_data;
        end
    end
end
