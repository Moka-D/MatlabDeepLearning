clear all
mdl.initialize();

x = mdl.Variable(1.0);
y = (x + 3) .^ 2;
y.backward();

disp(y)
disp(x.grad)
