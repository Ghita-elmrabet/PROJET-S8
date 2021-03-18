function [LARs, coefs_ref, thetap_n, rp] = lar_function(signal, max_ordre)
       
    r      = xcorr(signal, 'biased', max_ordre);  % L'estimation biasée de la corrélation
    maxi_r = find(r == max(r));                   % L'indice du max de la correlation
    rp     = r(maxi_r:maxi_r+max_ordre);          % Les échantillons de 0 à P+1
    
    coefs_ref = zeros(1,max_ordre);
    LARs      = zeros(1,max_ordre); 
    
    coefs_ref(1) = -r(maxi_r+1)/r(maxi_r);                        % a_{1}^{(1)} = rx(1)/rx(0)    
    LARs(1)      = log((1 + coefs_ref(1)) / (1 - coefs_ref(1)));
    thetap_o     = [coefs_ref(1)];
    for i=1:max_ordre-1       
        [coefs_ref(i+1), thetap_n] = coefRef_function(thetap_o, rp, i);
        LARs(i+1) = log((1 + coefs_ref(i+1)) / (1 - coefs_ref(i+1)));        
        thetap_o = thetap_n;       
    end

end
