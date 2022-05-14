clear all

x0 = mdl.Variable(2);
x1 = mdl.Variable(3);
xs = {x0, x1};
f = mdl.functions.base.Add();
ys = f.call(xs);
y = ys{1};
disp(y.data)
