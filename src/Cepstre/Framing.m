function [frames, indexes] = Framing(signal,Fe,nf,ns,window)
    %% Inputs:
    % signal
    % nf: 
    % ns:
    % window
    
    %% Outputs:
    % frames:
    % indexes:
    
    %% START:
    signal = signal(:);
    L = length(signal); % length of the signal vector
    M = floor((L-nf)/ns + 1); % number of frames
    
    e = L-((M-1)*ns + nf);
    if (e>0)
        diff = nf-e;
        signal = [signal; zeros(diff,1)];
    else
        M = M-1;
    end
    
    P = ns*[0:(M-1)];
    Q = [1:nf]';
    indexes = P(ones(nf,1),:) + Q(:,ones(1,M));
    
    frames = signal(indexes);
    fr = frames(:,100);
    %t = 99*ns + 1:1:nf + 99*ns;
    t = indexes(:,100)'/Fe;
    figure(2),
    plot(t,fr)
    axis tight
    xlabel('Time(s)')
    ylabel('Amplitude')
    title('The 100th frame')
    
    framesw = diag(window(nf))*frames;
    frw = framesw(:,100);
    figure(3),
    plot(t,frw)
    axis tight
    xlabel('Samples')
    ylabel('Amplitude')
    title('The 100th frame (windowed)')
    
    %% END.
end
        