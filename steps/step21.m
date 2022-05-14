clear all
mdl.initialize();

x = mdl.Variable(2);
y = x + 3;
disp(y.data)

y = 1 + 3 .* x;
disp(y.data);
