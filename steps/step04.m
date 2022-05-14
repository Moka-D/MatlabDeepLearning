clear all;

f = mdl.functions.base.Square();
x = mdl.Variable(2.0);
dy = mdl.utils.numerical_diff(f, x);
disp(dy)
