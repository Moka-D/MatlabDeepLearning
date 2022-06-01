classdef List < handle
    properties
        data
    end

    methods
        function self = List(varargin)
            self.data = varargin;
        end

        function varargout = subsref(self, s)
            switch s(1).type
                case '.'
                    [varargout{1:nargout}] = builtin('subsref', self, s);
                case '{}'
                    [varargout{1:nargout}] = builtin('subsref', self.data, s);
                case '()'
                    [varargout{1:nargout}] = builtin('subsref', self, s);
                otherwise
                    error('Not a valid indexing expression')
            end
        end

        function val = last(self)
            val = self.data{end};
        end

        function append(self, val)
            self.data{end + 1} = val;
        end

        function val = pop(self, idx)
            if ~exist('idx', 'var')
                idx = 1;
            end
            val = self.data{idx};
            self.data(idx) = [];
        end

        function ret = length(self)
            ret = length(self.data);
        end

        function ret = isempty(self)
            ret = isempty(self.data);
        end

        function idxs = find(self, value)
            idxs = zeros(size(self.data));

            for i_data = 1:self.length
                if self.data{i_data} == value
                    idxs(i_data) = i_data;
                end
            end
            idxs = idxs(idxs ~= 0);
        end

        function ret = isin(self, value)
            idx = self.find(value);
            if isempty(idx)
                ret = false;
            else
                ret = true;
            end
        end

        function sort(self, key)
            if exist('key', 'var') && isprop(self.data{1}, key)
                target_arr = cellfun(@(x) x.(key), self.data);
            else
                target_arr = cellfun(@(x) x.id, self.data);
            end

            [~, I] = sort(target_arr);
            self.data = self.data(I);
        end
    end
end
