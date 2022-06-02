classdef SoftmaxCrossEntropy < mdl.Function
    methods
        function y = forward(~, x, t)
            N = size(x, 1);
            log_z = mdl.utils.logsumexp(x, 2);
            log_p = x - log_z;
            ind = sub2ind(size(log_p), 1:N, mdl.np.flatten(t));
            log_p = log_p(ind);
            y = -mdl.np.sum(log_p) ./ N;
        end

        function y = backward(self, gy)
            [x, t] = self.inputs{:};
            [N, CLS_NUM] = size(x);

            gy = gy .* (1 ./ N);
            y = mdl.functions.softmax(x);
            % convert to one-hot
            tmp = eye(CLS_NUM, class(t));
            t_onehot = tmp(t.data, :);
            y = (y - t_onehot) .* gy;
        end
    end
end
