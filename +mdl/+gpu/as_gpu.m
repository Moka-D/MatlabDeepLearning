function out = as_gpu(x)
    if isa(x, 'mdl.Variable')
        x = x.data;
    end

    if ~canUseGPU()
        error('GPU are not availabel in this environment.');
    end
    out = gpuArray(x);
end
