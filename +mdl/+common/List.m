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
            if exist('key', 'var')
                key = [];
            end

            new_data = cell(size(self.data));
            cnt = 1;

            while self.length()
                min_idx = 1;
                for idx = 1:self.length()
                    if isempty(key)
                        condition = self.data{idx} < self.data{min_idx};
                    else
                        condition = self.data{idx}.(key) < self.data{min_idx}.(key);
                    end
                    if condition
                        min_idx = idx;
                    end
                end
                new_data{cnt} = self.pop(min_idx);
                cnt = cnt + 1;
            end
            self.data = new_data;
        end
    end
end
