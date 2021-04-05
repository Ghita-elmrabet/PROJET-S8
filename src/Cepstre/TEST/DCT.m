 function [dct] = DCT(N,M)
    %% Inputs:
    % N: number of CC
    % M: number of frames
    
    %% Outputs:
    % dct: DCT matrix
    
    %% START:
    dct = sqrt(2/N)*cos(repmat([0:N-1]',1,M).*repmat(pi*([1:M]-0.5)/M,N,1));
    %% END.
end
