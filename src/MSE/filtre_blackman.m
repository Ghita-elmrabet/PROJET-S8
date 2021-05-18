function [ b,a ] = filtre_blackman( t )
    b = 0.5/t*sinc(0.5/t*(-25:25)).*blackman(51)';
    a = 1;
end

