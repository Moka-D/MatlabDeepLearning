clear all;

A = mdl.functions.base.Square();
B = mdl.functions.base.Exp();
C = mdl.functions.base.Square();

x = mdl.Variable(0.5);
a = A.call(x);
b = B.call(a);
y = C.call(b);

y.grad = 1.0;
b.grad = C.backward(y.grad);
a.grad = B.backward(b.grad);
x.grad = A.backward(a.grad);
disp(x.grad)
