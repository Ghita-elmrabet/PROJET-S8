function [MSE, SE] = my_mse(x, m, r, scale_max, filtre)
    if ~exist('filtre','var')
        filtre = "moyenneur";
    end

    if strcmp(filtre, "moyenneur")
        FILTRE = @(s) coarse_graining(s);
    elseif strcmp(filtre, "butterworth")
        FILTRE = @(s) my_butterworth(s);
    else
        throw("wrong filtre name");
    end
    
    SE = zeros(1,scale_max);
    for s = 1:scale_max
        s
        [b,a] = FILTRE(s);
        x_filtered = filter(b,a,x);
        x_downsample = x_filtered(1:s:end);
        SE(s) = my_sampen(x_downsample, m, r);
    end
    MSE = sum(SE);
end