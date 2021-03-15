function [MSEs] = se_to_mse(SE)
    MSEs = zeros(1,length(SE));
    MSEs(1) = SE(1);
    for i=2:length(SE)
        MSEs(i) = MSEs(i-1) + SE(i);
    end
end