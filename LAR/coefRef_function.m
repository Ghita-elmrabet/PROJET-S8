function [coef, thetap] = coefRef_function(signal, ordre)

    % Calcul des parametres AR d'ordre P
    r      = xcorr(signal, 'biased', ordre+1);
    maxi_r = find(r == max(r));                 % L'indice du max de la correlation
    rp0    = r(maxi_r:maxi_r+ordre-1);          % Les échantillons de 0 à P-1
    Rp     = toeplitz(rp0);                     % La matrice de Toeplitz
    invRp  = inv(Rp);                           % L'inverse de la matrice Toeplitz
    rp1    = r(maxi_r+1:maxi_r+ordre);          % Les échantillons de 1 à P
    rp1    = rp1';
    thetap = zeros(1,ordre);                    % Les paramètres d'ordre P 
    thetap(1,:) = (- invRp * rp1)';
    % Calcul du coefficient de réflexion d'ordre P+1 : % a_{p+1}^{(p+1)}
    rhop  = flip(rp1);
    coef = (r(maxi_r+ordre+1) - sum(rhop.*thetap)) / (r(maxi_r) - sum(rp1.*thetap)); 
    
end