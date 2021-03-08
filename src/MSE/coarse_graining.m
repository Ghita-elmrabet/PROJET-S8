function [ b,a ] = coarse_graining( t )
    b = ones(1,t)./t;
    a = 1;
end

