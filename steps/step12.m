clear all

x0 = mdl.Variable(2);
x1 = mdl.Variable(3);
y = mdl.functions.add(x0, x1);
disp(y.data)
