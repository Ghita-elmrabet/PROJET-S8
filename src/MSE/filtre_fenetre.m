function [ b,a ] = filtre_fenetre( t )
    b = 0.5/t*sinc(0.5/t*(-25:25));
    a = 1;
end

