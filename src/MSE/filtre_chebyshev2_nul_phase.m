function [ b,a ] = filtre_chebyshev2_nul_phase( t )
    [b,a] = cheby2(6,10,0.5/t);
    b = conv(b,flip(b));
    a = conv(a,flip(a));
end

