function [frames, indexes,signal] = Framing(signal,nf,ns)
    %% Inputs:
    
    % signal
    % nf: number of samples in a frame
    % ns: number of samples in an overlap
    
    %% Outputs:
    
    % frames
    % indexes: start/end of each frame
    
    %% START:
    signal = signal(:);          % Vectorization of the signal
    L = length(signal);          % Length of the signal vector
    M = floor((L-nf)/ns + 1);    % Number of frames
    
    e = L-((M-1)*ns + nf);
    if (e>0)
        signal = [signal; zeros(e,1)];
    else
        M = M-1;
    end
    
    P = ns*(0:M-1);
    Q = (1:nf)';
    indexes = P(ones(nf,1),:) + Q(:,ones(1,M));
    
    frames = signal(indexes);
    
    frames = diag(hamming(nf))*frames;
    
    %% END.
end
        