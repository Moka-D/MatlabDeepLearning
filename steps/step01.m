clear all;

x = mdl.Variable([1 2]);
disp(x.data)

x.data = [1 2 3; 2 3 4; 5 6 7; 8 9 10];
disp(x.data)
