clear all

f_square = @(x) mdl.functions.square(x);

for i = 1:10
    x = mdl.Variable(randn(1, 10000));  % big data
    y = f_square(f_square(f_square(x)));
end
