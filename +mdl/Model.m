classdef (Abstract) Model < mdl.Layer
    methods
        function img = plot(self, varargin)
            if nargin == 1
                error('Arguments must be >1.')
            end
            if nargin >= 3 && strcmp(varargin{end-1}, 'to_file')
                if nargin <= 3
                    error('Arguments must be >3 when to_file is set.')
                end
                inputs = varargin(1:end-2);
                to_file = varargin{end};
            else
                inputs = varargin;
                to_file = 'model.png';
            end

            y = self.forward(inputs{:});
            img = mdl.utils.plot_dot_graph(y, 'verbose', true, 'to_file', to_file);
        end
    end

    methods (Abstract)
        y = forward(self, x)
    end
end
