function [ b,a ] = my_butterworth( t )
    N = 6; % ordre du filtre
    [b,a] = butter(N,0.5/t);
end

