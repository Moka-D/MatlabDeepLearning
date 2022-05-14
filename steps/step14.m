clear all

x = mdl.Variable(3.0);
y = mdl.functions.add(x, x);
y.backward();
disp(x.grad);

x.cleargrad();
y = mdl.functions.add(mdl.functions.add(x, x), x);
y.backward();
disp(x.grad);
