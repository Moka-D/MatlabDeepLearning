function y = flatten(x)
    if ismatrix(x)
        y = reshape(x.', 1, []);
    else
        y = flatten_multi(x);
    end
end

function y = flatten_multi(x)
    sz = size(x);
    dimorder = [2, 1, 3:length(sz)];
    x_permuted = permute(x, dimorder);
    y = reshape(x_permuted, 1, []);
end
