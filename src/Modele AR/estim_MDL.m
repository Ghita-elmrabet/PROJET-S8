function[MDL] = estim_MDL(sigma,N,k)
    MDL = log(sigma(k)^2)+((k/N)*log(N));
end
    