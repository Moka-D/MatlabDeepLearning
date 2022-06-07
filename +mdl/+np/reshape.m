function y = reshape(x, varargin)
    sz = cell2mat(varargin);
    if length(sz) == 1
        sz = [1 sz];
    end

    x_flat = mdl.np.flatten(x);
    if length(sz) == 2
        y = reshape_2d(x_flat, sz);
    else
        y = reshape_multi(x_flat, sz);
    end
end


function y = reshape_2d(x_flat, sz)
    sz_flipped = flip(sz);
    if isequal(size(x_flat), sz_flipped)
        x_tmp = x_flat;
    else
        x_tmp = builtin('reshape', x_flat, sz_flipped);
    end
    y = x_tmp.';
end


function y = reshape_multi(x_flat, sz)
    sz_flipped = [flip(sz(1:2)), sz(3:end)];
    x_tmp = builtin('reshape', x_flat, sz_flipped);
    dimorder = [2, 1, 3:length(sz)];
    y = permute(x_tmp, dimorder);
end
