function[FPE] = estim_fpe(sigma,N,k)
    FPE = ((N+k)/(N-k))*sigma(k);
end
    
