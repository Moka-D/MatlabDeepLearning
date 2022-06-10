function ret = on_gpu(x)
    if ~canUseGPU()
        ret = false;
        return
    end

    if isa(x, 'mdl.Variable')
        x = x.data;
    end
    ret = isgpuarray(x);
end
