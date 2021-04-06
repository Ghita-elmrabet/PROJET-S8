function [H,f] = MelFilterBank(M,K,F,Fe)
    %% Inputs:
    % M: number of filters in the MEL Filter Bank
    % K: NFFT/2 + 1
    % F: frequency boundaries (Fmin,Fmax)
    % Fe: sampling frequency (Hz)
    
    %% Outputs:
    % H: MEL Filter Bank matrix (one filter per row)
    % f: frequencies vector
    
    %% START:
    Fmin = F(1); 
    Fmax = F(2); 
    
    f = linspace(0,0.5*Fe,K); % Frequencies vector [0:Fe/2] (K points)
    
    Mmin = hz2mel(Fmin);
    Mmax = hz2mel(Fmax);
    
    % MEL scale frequencies:
    Mi = zeros(1,M+2);
    for u=0:M+1
        Mi(u+1) = Mmin + (u*(Mmax-Mmin)/M+1);   % Bandwidth = (Mmax-Mmin)/M+1
    end
    
    % HERTZ scale frequencies
    Hi = zeros(1,M+2);
    for i=1:M+2
        Hi(i) = mel2hz(Mi(i));
    end
    
    H = zeros(M,K);
    for m=1:M
        k = f<Hi(m);
        H(m,k) = 0;
        
        % First part of the triangular filter
        k = f>=Hi(m) & f<=Hi(m+1);
        H(m,k) = (f(k)-Hi(m))/(Hi(m+1)-Hi(m));
        
        % Second part of the triangular filter
        k = f>=Hi(m+1) & f<=Hi(m+2);
        H(m,k) = (Hi(m+2)-f(k))/(Hi(m+2)-Hi(m+1));
        
        k = f>Hi(m+2);
        H(m,k) = 0;
    end
    %% END.
end

        
    
    