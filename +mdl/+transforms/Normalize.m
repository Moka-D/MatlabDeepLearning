classdef Normalize < mdl.common.CallableObj
    % mdl.transforms.Normalize(mean_, std_)
    %
    % Normalize a array with mean and standard deviation.
    %
    % Parameters
    % ----------
    % mean_ (numeric or array) : mean for all values or array of mean for
    %     each channel.
    % std_ (numeric, or array)

    properties
        mean
        std
    end

    methods
        function self = Normalize(mean_, std_)
            if ~exist('mean_', 'var')
                mean_ = 0;
            end
            if ~exist('std_', 'var')
                std_ = 1;
            end
            self.mean = mean_;
            self.std = std_;
        end
    end

    methods (Access = protected)
        function out = call(self, array)
            mean_ = self.mean;
            std_ = self.std;

            if ~isscalar(mean_)
                msz = 1 * mdl.np.ndim(array);
                if length(self.mean) == 1
                    msz(1) = length(array);
                else
                    msz(1) = length(self.mean);
                end
                mean_ = mdl.np.reshape(cast(self.mean, class(array)), msz);
            end
            if ~isscalar(std_)
                rsz = 1 * mdl.np.ndim(array);
                if length(self.std) == 1
                    rsz(1) = length(array);
                else
                    rsz(1) = length(self.std);
                end
                std_ = mdl.np.reshape(cast(self.std, class(array)), rsz);
            end

            out = (array - mean_) ./ std_;
        end
    end
end
