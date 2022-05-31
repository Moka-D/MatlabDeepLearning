function y = sum(x, axis)
    if ~exist('axis', 'var')
        y = sum(x, 'all');
    else
        y = sum(x, axis);
    end
end
