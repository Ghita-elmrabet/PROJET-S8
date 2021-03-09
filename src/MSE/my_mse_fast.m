function [MSE, SE] = my_mse_fast(x, m, r, scale_max, varargin)
    FILTRE = get_filter_func_from_string(varargin);
    
    SE = zeros(1,scale_max);
    for s = 1:scale_max
        [b,a] = FILTRE(s);
        x_filtered = filter(b,a,x);
        x_downsample = x_filtered(1:s:end);
        SE(s) = my_sampen_fast(x_downsample, m, r);
    end
    MSE = sum(SE);
end