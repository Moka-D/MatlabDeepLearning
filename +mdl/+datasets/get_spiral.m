function [x, t] = get_spiral(train)
    if ~exist('train', 'var')
        train = true;
    end

    if train
        seed = 1984;
    else
        seed = 2020;
    end
    rng(seed);

    num_data = 100;
    num_class = 3;
    input_dim = 2;
    data_size = num_class .* num_data;
    x = zeros(data_size, input_dim, 'single');
    t = zeros(data_size, 1, 'int32');

    for c_i = 1:num_class
        for d_i = 1:num_data
            rate = (d_i - 1) ./ num_data;
            radius = 1.0 .* rate;
            theta = (c_i - 1) .* 4.0 + 4.0 .* rate + randn .* 0.2;
            ix = num_data .* (c_i - 1) + d_i;
            x(ix, :) = [radius .* sin(theta) radius .* cos(theta)];
            t(ix) = c_i;
        end
    end

    % Shuffle
    indices = randperm(num_data .* num_class);
    x = x(indices, :);
    t = t(indices);
end
