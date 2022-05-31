function y = clip(x, x_min, x_max)
    y = x;
    if ~isempty(x_min)
        under_min_idx = x < x_min;
        y(under_min_idx) = x_min;
    end
    if ~isempty(x_max)
        over_max_idx = x > x_max;
        y(over_max_idx) = x_max;
    end
end
