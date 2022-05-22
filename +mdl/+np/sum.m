function y = sum(x, axis)
    if ~exist('axis', 'var')
        axis = [];
    end
    if isempty(axis)
        y = sum(x, 'all');
    else
        y = sum(x, axis);
    end
end
