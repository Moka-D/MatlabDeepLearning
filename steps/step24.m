clear all
mdl.initialize();

tx = ty = linspace(-8, 8, 41).';
[xx, yy] = meshgrid(tx, ty);

%tz = sphere_(xx, yy);
%mesh(tx, ty, tz);
%title("Sphere function")

x = mdl.Variable(1.0);
y = mdl.Variable(1.0);
z = sphere_(x, y);
z.backward();
disp(x.grad)
disp(y.grad)

%tz = matyas(xx, yy);
%mesh(tx, ty, tz);
%title("Matyas function")

x.cleargrad();
y.cleargrad();
z = matyas(x, y);
z.backward();
disp(x.grad);
disp(y.grad);

tz = goldstein(xx, yy);
mesh(tx, ty, tz);
title("Goldstein-Price function")

x.cleargrad();
y.cleargrad();
z = goldstein(x, y);
z.backward();
disp(x.grad);
disp(y.grad);
