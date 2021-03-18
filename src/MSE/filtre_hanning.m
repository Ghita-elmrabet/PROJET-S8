function [ b,a ] = filtre_hanning( t )
    b = 0.5/t*sinc(0.5/t*(-25:25)).*hanning(51)';
    a = 1;
end

