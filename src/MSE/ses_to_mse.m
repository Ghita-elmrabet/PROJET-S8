function [MSEs] = ses_to_mse(SEs)
    MSEs = zeros(size(SEs));
    for i=1:size(SEs,1)
        MSEs(i,:) = se_to_mse(SEs(i,:));
    end
end