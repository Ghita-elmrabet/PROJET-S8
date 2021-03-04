function [ Y ] = coarse_graining( X,t )
    h = ones(1,t)./t;
    Y = conv(X,h);
    Y = Y(t:end-t+1);
end

