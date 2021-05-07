function [ b,a ] = filtre_blackman_coff( t, coff, N )
    L = floor(N/2);
    b = coff(t)*sinc(coff(t)*(-L:L)).*blackman(2*L+1)';
    a = 1;
end

