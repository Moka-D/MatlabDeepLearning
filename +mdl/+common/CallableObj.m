classdef (Abstract) CallableObj < mdl.common.RefObj
    methods (Access = protected)
        function self = CallableObj()
            self@mdl.common.RefObj();
        end
    end

    methods
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

    methods (Abstract, Access = protected)
        out = call(self, varargin)
    end
end
