classdef Compose < mdl.common.CallableObj
    % mdl.transforms.Compose(transforms)
    %
    % Compose several transforms.
    %
    % Parameters
    % ----------
    % transforms (mdl.common.List) : list of transforms

    properties
        transforms
    end

    methods
        function self = Compose(transforms)
            if ~exist('transforms', 'var')
                transforms = [];
            end
            self.transforms = transforms;
        end
    end

    methods (Access = protected)
        function img = call(self, img)
            if isempty(self.transforms)
                return
            end

            for t_i = 1:length(self.transforms)
                t = self.transforms{t_i};
                img = t(img);
            end
        end
    end
end
