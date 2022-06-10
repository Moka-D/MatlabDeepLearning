function out = as_cpu(x)
    if isa(x, 'mdl.Variable')
        x = x.data;
    end

    if mdl.gpu.on_gpu(x)
        out = gather(x);
    else
        out = x;
    end
end
