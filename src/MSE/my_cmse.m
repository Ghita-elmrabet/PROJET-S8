function [CMSE, SE] = my_cmse(x, m, r, scale_max)
    SE = zeros(1,scale_max);
    for s = 1:scale_max
        x_scaled = coarse_graining(x, s);
        for k = 0:(s-1)
            x_downsample = x_scaled(1+k:s:end);
            SE(s) = SE(s) + my_sampen(x_downsample, m, r);
        end
        SE(s) = SE(s)/s;
    end
    CMSE = sum(SE);
end