function [coef, thetap_n] = coefRef_function(thetap_o, rp, indice)
    
    rp_new = rp(2:2+indice-1);
    rhop  = flip(rp_new);
    
    coef = (rp(2+indice) - sum(rhop.*thetap_o)) / (rp(1) - sum(rp_new.*thetap_o)); 
    betap_old = flip(thetap_o); 
    thetap_n = [thetap_o - coef*betap_old, coef];
    
end