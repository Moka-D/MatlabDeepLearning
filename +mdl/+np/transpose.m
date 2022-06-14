function y = transpose(x, axes)
    if ~exist('axes', 'var')
        axes = [];
    end

    if isempty(axes)
        if ismatrix(x)
            y = x.';
        else
            y = transpose_multi(x);
        end
    else
        y = permute(x, axes);
    end
end

function y = transpose_multi(x)
    n = ndims(x);
    if n == 3
        dimorder1 = [3, 1, 2];
    else
        dimorder1 = [n-1, n, n-2:-1:3, 1, 2];
    end
    x_tmp = permute(x, dimorder1);

    if n == 3
        dimorder2 = [2, 1, 3:n];
        y = permute(x_tmp, dimorder2);
    else
        y = x_tmp;
    end
end
