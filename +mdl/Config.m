classdef Config
    methods (Static)
        function out = setget_enable_backprop(value)
            persistent enable_backprop;
            if nargin
                enable_backprop = value;
            end
            out = enable_backprop;
        end
    end
end
