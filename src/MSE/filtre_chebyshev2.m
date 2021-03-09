function [ b,a ] = filtre_chebyshev2( t )
    [b,a] = cheby2(6,10,0.5/t);
end

