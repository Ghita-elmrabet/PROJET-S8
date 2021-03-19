function [LARs, coefs_ref, thetap_n, rp] = lar_function(signal, max_ordre)
       
    r      = xcorr(signal, 'biased', max_ordre);  % L'estimation bias??e de la corr??lation
    maxi_r = find(r == max(r));                   % L'indice du max de la correlation
    rp     = r(maxi_r:maxi_r+max_ordre);          % Les ??chantillons de 0 ?? P+1
    
    rp_new = rp(2:2+max_ordre-2);
    rhop_1  = flip(rp_new);
    
    coefs_ref = zeros(1,max_ordre);
    LARs      = zeros(1,max_ordre); 
    
    coefs_ref(1) = -r(maxi_r+1)/r(maxi_r);                        % a_{1}^{(1)} = rx(1)/rx(0)    
    LARs(1)      = log((1 + coefs_ref(1)) / (1 - coefs_ref(1)));
    thetap_o     = [coefs_ref(1)];

    for i=1:max_ordre-1       
        [coefs_ref(i+1), thetap_n] = coefRef_function(thetap_o, rp, i); 
        LARs(i+1) = -log((1 + coefs_ref(i+1)) / (1 - coefs_ref(i+1)));        
        thetap_o = thetap_n;
        %dernier_terme = rp(maxi_r+max_ordre)-sum(rhop_1.*thetap_o)/rp(maxi_r)+sum(rp_new.*thetap_o)
    end
    
end
