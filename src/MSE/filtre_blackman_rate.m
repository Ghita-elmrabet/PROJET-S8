function [ b,a ] = filtre_blackman_rate( t, rate, N )
    L = floor(N/2);
    b = 0.5/t^rate*sinc((-L:L)/t^rate).*blackman(2*L+1)';
    a = 1;
end

