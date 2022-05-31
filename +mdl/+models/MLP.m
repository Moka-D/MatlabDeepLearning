classdef MLP < mdl.Model
    methods
        function self = MLP(fc_output_sizes, activation)
            self@mdl.Model();
            if ~exist('activation', 'var')
                activation = @mdl.functions.sigmoid;
            end
            self.addprop('activation', activation);
            self.addprop('layers', mdl.common.List());

            for idx = 1:length(fc_output_sizes)
                out_size = fc_output_sizes(idx);
                layer = mdl.layers.Linear(out_size);
                self.addprop(strcat('l', num2str(idx)), layer);
                self.layers.append(layer);
            end
        end

        function y = forward(self, x)
            for l_i = 1:length(self.layers)-1
                layer = self.layers.at(l_i);
                x = self.activation(layer(x));
            end
            last_layer = self.layers.last();
            y = last_layer(x);
        end
    end
end
