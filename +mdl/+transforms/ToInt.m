classdef ToInt < mdl.transforms.AsType
    methods
        function self = ToInt(varargin)
            p = inputParser;
            expected_types = {'int8', 'uint8', 'int16', 'uint16', 'int32', ...
                              'uint32', 'int64', 'uint64'};
            addOptional(p, 'dtype', 'int32', @(x) any(validatestring(x, expected_types)));
            parse(p, varargin{:});

            self.dtype = p.Results.dtype;
        end
    end
end
