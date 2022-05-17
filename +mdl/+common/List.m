classdef List < handle
    properties
        data
    end

    methods
        function self = List(varargin)
            self.data = varargin;
        end

        function val = at(self, idx)
            val = self.data{idx};
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

        function idx = find(self, value)
            idx = [];
            for i_data = 1:self.length
                if self.data{i_data} == value
                    idx = horzcat(idx, i_data);
                end
            end
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
            new_data = {};

            while self.length()
                max_idx = 1;
                for idx = 1:self.length()
                    if self.data{idx}.(key) > self.data{max_idx}.(key)
                        max_idx = idx;
                    end
                end
                new_data{end + 1} = self.pop(max_idx);
            end

            self.data = new_data;
        end
    end
end
