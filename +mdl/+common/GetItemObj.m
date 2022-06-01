classdef (Abstract) GetItemObj < handle
    methods
        function varargout = subsref(self, s)
            switch s(1).type
                case '.'
                    [varargout{1:nargout}] = builtin('subsref', self, s);
                case '()'
                    if length(s) == 1
                        % Implement self(indices)
                        [varargout{1:nargout}] = self.getitem(s.subs{:});
                    else
                        error('Not a valid indexing expression')
                    end
                case '{}'
                    [varargout{1:nargout}] = builtin('subsref', self, s);
                otherwise
                    error('Not a valid indexing expression')
            end
        end
    end

    methods (Abstract, Access = protected)
        getitem(self, varargin)
    end
end
