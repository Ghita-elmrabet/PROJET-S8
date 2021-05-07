function [MSE, SE] = my_mse(x, m, r, scale_max, varargin)
    FILTRE = get_filter_func_from_string(varargin);
    
    SE = zeros(1,scale_max);
    for s = 1:scale_max
        [b,a] = FILTRE(s);
        if s > 1
            x_filtered = filter(b,a,x);
        else
            x_filtered = x;
        end
        x_downsample = x_filtered(1:s:end);
        SE(s) = my_sampen(x_downsample, m, r);
    end
    MSE = sum(SE);
end