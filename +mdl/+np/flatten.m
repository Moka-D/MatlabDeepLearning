function y = flatten(x)
    if ismatrix(x)
        if size(x, 1) == 1
            y = x;
        elseif size(x, 2) == 1
            y = x.';
        else
            x_T = x.';
            y = x_T(:);
        end
    else
        y = flatten_multi(x);
    end
end


function y = flatten_multi(x)
    sz = size(x);
    dimorder = [2, 1, 3:length(sz)];
    x_permuted = permute(x, dimorder);
    y = x_permuted(:);
end
