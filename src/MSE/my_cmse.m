function [CMSE, SE] = my_cmse(x, m, r, scale_max, varargin)
    FILTRE = get_filter_func_from_string(varargin);

    SE = zeros(1,scale_max);
    for s = 1:scale_max
        [b,a] = FILTRE(s);
        x_filtered = filter(b,a,x);
        for k = 0:(s-1)
            x_downsample = x_filtered(1+k:s:end);
            SE(s) = SE(s) + my_sampen(x_downsample, m, r);
        end
        SE(s) = SE(s)/s;
    end
    CMSE = sum(SE);
end