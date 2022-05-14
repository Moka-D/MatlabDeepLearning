clear all;

x = mdl.Variable(0.5);
a = mdl.functions.square(x);
b = mdl.functions.exp_(a);
y = mdl.functions.square(b);
y.backward();
disp(x.grad)
