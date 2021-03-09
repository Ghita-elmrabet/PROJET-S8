function [ b,a ] = filtre_chebyshev1_nul_phase( t )
    [b,a] = cheby1(6,10,0.5/t);
    b = conv(b,flip(b));
    a = conv(a,flip(a));
end

