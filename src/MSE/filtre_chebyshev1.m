function [ b,a ] = filtre_chebyshev1( t )
    [b,a] = cheby1(6,10,0.5/t);
end

