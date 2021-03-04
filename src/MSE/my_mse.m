function [MSE, SE] = my_mse(x, m, r, scale_max)
    SE = zeros(1,scale_max);
    for s = 1:scale_max
        x_scaled = coarse_graining(x, s);
        x_scaled = x_scaled(1:s:end);
        SE(s) = my_sampen(x_scaled, m, r);
    end
    MSE = sum(SE);
end