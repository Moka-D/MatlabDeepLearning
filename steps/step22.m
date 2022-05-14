clear all
mdl.initialize();

x = mdl.Variable(2.0);
y = -x;
disp(y)

y1 = 2.0 - x;
y2 = x - 1.0;
disp(y1)
disp(y2)

y = 3.0 ./ x;
disp(y)

y = x .^ 3;
y.backward();
disp(y)
