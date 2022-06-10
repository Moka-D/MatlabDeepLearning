function y = sum_to(x, sz)
    % y = mdl.utils.sum_to(x, sz)
    %
    % Sum elements along axes to output an array of a given size.
    %
    % Parameters
    % ----------
    % x (array): Input array.
    % sz:
    %
    % Returns
    % -------
    % y (array): Output array of the size.

    ndim = length(sz);
    lead = mdl.np.ndim(x) - ndim;
    lead_axis = 0:lead;

    axis = zeros(1, ndim);
    for i = 1:ndim
        sx = sz(i);
        if sx == 1
            axis(i) = i + lead;
        end
    end
    axis(axis==0) = [];
    y = sum(x, lead_axis + axis);
    if lead > 0
        y = squeeze(y);
    end
end
