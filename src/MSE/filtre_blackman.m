function [ b,a ] = filtre_blackman( t )
    b = 0.5/t*sinc(0.5/t*(-5:5)).*blackman(11)';
    a = 1;
end

