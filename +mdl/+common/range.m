function y = range(start, stop, step)
    if ~exist('stop', 'var')
        stop = [];
    end
    if ~exist('step', 'var')
        step = 1;
    end

    if isempty(stop)
        y = 0 : start - 1;
    else
        y = start : step : stop - step;
    end
end
