clear all
mdl.initialize();

x = mdl.Variable([1 2 3; 4 5 6]);
x.name = 'x';

disp(x.name)
disp(x.size)
disp(x)
