function [H,f,Hi,Mi,Hi1,Hi2] = MelFilterBank(M,K,F,Fe)
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
    
    Mmin = 1000;
    Mmax = hz2mel(Fmax);
    
    
    % MEL scale frequencies:
    Mi = zeros(1,29);
    for u=0:28
        Mi(u+1) = Mmin + (u*(Mmax-Mmin)/28);   % Bandwidth = (Mmax-Mmin)/M+1
    end
    
    
    % HERTZ scale frequencies
    
    Hi1 = zeros(1,15);
    for u=0:14
        Hi1(u+1) =  u*(1000/14);
    end
    
    
    Hi2 = zeros(1,29);
    for i=1:29
        Hi2(i) = mel2hz(Mi(i));
    end
    
    Hi = [Hi1 Hi2(2:end)];
    
    H = zeros(M,K);
    for m=1:M
        k = f<Hi(m);
        H(m,k) = 0;
        
        % First part of the triangular filter
        k = f>=Hi(m) & f<=Hi(m+1);
        H(m,k) = 2*(f(k)-Hi(m))/((Hi(m+1)-Hi(m))*(Hi(m+2)-Hi(m)));
        
        % Second part of the triangular filter
        k = f>=Hi(m+1) & f<=Hi(m+2);
        H(m,k) = 2*(Hi(m+2)-f(k))/((Hi(m+2)-Hi(m+1))*(Hi(m+2)-Hi(m)));
        
        k = f>Hi(m+2);
        H(m,k) = 0;
    end
    
    %% END.
end

        
    
    