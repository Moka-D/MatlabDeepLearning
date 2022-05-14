clear all;

a = mdl.Variable(2);
b = mdl.Variable(3);
c = mdl.Variable(-1);
d = mdl.Variable(0);
e = mdl.Variable(1);

list = mdl.common.List(a, b, c, d, e);
list.sort('data');
actual = list.at(1);
assert(c == actual)
