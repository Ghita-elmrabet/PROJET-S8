function [ b,a ] = filtre_hamming( t )
    b = 0.5/t*sinc(0.5/t*(-25:25)).*hamming(51)';
    a = 1;
end

