function [MSE, SE] = my_mse(x, m, r, scale_max)
    SE = zeros(1,scale_max);
    for i = 1:scale_max
        x_scaled = coarse_graining(x, i);
        SE(i) = sample_entropy(x_scaled, m, r);
    end
    MSE = sum(SE);
end