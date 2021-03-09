function [ b,a ] = filtre_moyenneur( t )
    b = ones(1,t)./t;
    a = 1;
end

