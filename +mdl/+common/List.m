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

        function index = find(self, value)
            index = [];
            for i = 1:self.length
                if self.data{i} == value
                    index = horzcat(index, i);
                end
            end
        end

        function ret = isin(self, value)
            index = self.find(value);
            if isempty(index)
                ret = false;
            else
                ret = true;
            end
        end

        function sort(self, key)
            newData = {};

            while self.length()
                maxIdx = 1;
                for idx = 1:self.length()
                    if self.data{idx}.(key) > self.data{maxIdx}.(key)
                        maxIdx = idx;
                    end
                end
                newData{end + 1} = self.pop(maxIdx);
            end

            self.data = newData;
        end
    end
end
