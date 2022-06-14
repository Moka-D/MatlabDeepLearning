function ret = on_gpu(x)
    if ~mdl.gpu.get_gpu_enable()
        ret = false;
        return
    end

    if isa(x, 'mdl.Variable')
        x = x.data;
    end
    ret = isgpuarray(x);
end
