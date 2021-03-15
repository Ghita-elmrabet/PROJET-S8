function[AIC] = estim_fpe(sigma,N,k)
    AIC = log(sigma(k)^2)+((2*k)/N);
end
    
