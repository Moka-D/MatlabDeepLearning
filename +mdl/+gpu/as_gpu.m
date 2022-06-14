function out = as_gpu(x)
    if isa(x, 'mdl.Variable')
        x = x.data;
    end

    if ~mdl.gpu.get_gpu_enable()
        error('GPU are not availabel in this environment.');
    end
    out = gpuArray(x);
end
