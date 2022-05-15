clear all
mdl.initialize();

x = mdl.Variable(1.0);
y = mdl.Variable(1.0);
z = goldstein(x, y);

x.name = 'x';
y.name = 'y';
z.name = 'z';
mdl.utils.plot_dot_graph(z, 'verbose', false, 'to_file', 'goldstein.png');
