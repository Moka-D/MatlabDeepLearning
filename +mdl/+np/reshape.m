function y = reshape(x, varargin)
    assert(nargin >= 2)

    if length(varargin) == 1
        assert(length(varargin{1}) >= 2);
        sz = num2cell(varargin{:});
    else
        sz = varargin;
    end

    if length(sz) == 2
        sz_flipped = flip(sz);
        tmp = builtin('reshape', x, sz_flipped{:});
        y = tmp.';
    else
        y = reshape_multi(x, sz);
    end
end

function y = reshape_multi(x_flat, sz)
    sz_flipped = [sz(2), sz(1), sz(3:end)];
    tmp = builtin('reshape', x_flat, sz_flipped{:});
    dimorder = [2, 1, 3:length(sz)];
    y = permute(tmp, dimorder);
end
