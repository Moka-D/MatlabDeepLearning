clear all;

x = mdl.Variable(10);
f = mdl.functions.base.Square();
y = f.call(x);
disp(y.data)
