function y = broadcast_to(x, sz)
    f = mdl.functions.def.BroadcastTo(sz);
    y = f(x);
end
