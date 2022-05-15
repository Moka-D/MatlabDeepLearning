function y = rosenbrock(x0, x1)
    y = 100 .* (x1 - x0 .^ 2) .^ 2 + (x0 - 1) .^ 2;
end
