function [LARs, coefs_ref, thetap] = lar_function(signal, max_ordre)
    coefs_ref = zeros(1,max_ordre);
    LARs = zeros(1,max_ordre);
    
    r      = xcorr(signal, 'biased', max_ordre+1);
    maxi_r = find(r == max(r));         % L'indice du max de la correlation
    coefs_ref(1) = r(maxi_r+1)/r(maxi_r); % a_{1}^{(1)} = rx(1)/rx(0)
    % Calcul du LAR correspondant
    LARs(1) = log((1 + coefs_ref(1)) / (1 - coefs_ref(1)));
        
    for i=1:max_ordre-1
        thetap = [];
        [coefs_ref(i+1), thetap] = coefRef_function(signal, i);
        LARs(i+1) = log((1 + coefs_ref(i+1)) / (1 - coefs_ref(i+1)));
    end

end

