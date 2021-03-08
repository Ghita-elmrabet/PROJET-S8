function [CMSE, SE] = my_cmse(x, m, r, scale_max, filtre)
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
        for k = 0:(s-1)
            x_downsample = x_filtered(1+k:s:end);
            SE(s) = SE(s) + my_sampen(x_downsample, m, r);
        end
        SE(s) = SE(s)/s;
    end
    CMSE = sum(SE);
end