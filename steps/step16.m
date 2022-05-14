clear all

f_add = @(x0, x1) mdl.functions.add(x0, x1);
f_square = @(x) mdl.functions.square(x);

x = mdl.Variable(2.0);
a = f_square(x);
y = f_add(f_square(a), f_square(a));
y.backward();

disp(y.data)
disp(x.grad)
