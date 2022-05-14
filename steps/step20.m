clear all
mdl.initialize();

a = mdl.Variable(3.0);
b = mdl.Variable(2.0);
c = mdl.Variable(1.0);

y = a .* b + c;
y.backward();

disp(y.data)
disp(a.grad)
disp(b.grad)
