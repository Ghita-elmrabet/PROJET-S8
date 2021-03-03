function [args] = estimate_ar(sig, p)

    corr = xcorr(sig);
   
    
    midd_index = length(sig);
    t = toeplitz(corr(midd_index:midd_index+p-1));
    inv_t = inv(t);


    
    args =  -(inv_t * (corr(midd_index+1:midd_index + p)'));




end




function t = my_toeplitz(R)
    p = floor(length(R)/2) + 1; 
    t = zeros(p, p);
    for i = 0:p-1
        t(i+1, :) = (R(p-i:2*p-i-1));
    end
end

