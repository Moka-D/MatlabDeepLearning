clear all

x = mdl.Variable(2.0);
y = mdl.Variable(3.0);

z = mdl.functions.add(x, y);
z.backward();
disp(z.data)
disp(x.grad)
disp(y.grad)
