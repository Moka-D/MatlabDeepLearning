clear all
mdl.initialize();

x0 = mdl.Variable(1.0);
x1 = mdl.Variable(1.0);
t = mdl.functions.add(x0, x1);
y = mdl.functions.add(x0, t);
y.backward();
disp(y.grad)
disp(t.grad)
disp(x0.grad)
disp(x1.grad)

mdl.Config.setget_enable_backprop(false);
x = mdl.Variable(2.0);
y = mdl.functions.square(x);
disp(y.data)
mdl.initialize();

mdl.no_grad();
x = mdl.Variable(2.0);
y = mdl.functions.square(x);
disp(y.data)
mdl.initialize();