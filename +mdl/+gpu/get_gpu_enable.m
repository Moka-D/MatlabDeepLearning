function ret = get_gpu_enable()
    persistent gpu_enable
    if isempty(gpu_enable)
        gpu_enable = canUseGPU();
    end
    ret = gpu_enable;
end
