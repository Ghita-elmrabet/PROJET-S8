function [H,f] = MelFilterBank(M,K,F,Fe)
    %% Inputs:
    % M: number of MEL filters
    % K: legth of each MEL filter
    % F: frequency boundaries (Fmin,Fmax)
    % Fe: sampling frequency (Hz)
    
    %% Outputs:
    % H: MEL Filter Bank matrix (one filter per row)
    % f: frequencies vector
    
    %% START:
    Fmin = F(1); % lower cutoff frequency of the filterbank (Hz)
    Fmax = F(2); % higher cutoff frequency of the filterbank (Hz)
    
    f = linspace(0,0.5*Fe,K); % Frequencies vector [0:Fe/2] (K points)
    
    Mmin = HztoMel(Fmin);
    Mmax = HztoMel(Fmax);
    
    % Cutoff frequencies (MEL) for all filters (M+2)
    Mi = zeros(1,M+2);
    for u=0:M+1
        Mi(u+1) = Mmin + (u*(Mmax-Mmin)/M+1);
    end
    
    % Cutoff frequencies (Hz) for all filters (M+2)
    Hi = zeros(size(Mi));
    for i=1:size(Mi,2)
        Hi(i) = MeltoHz(Mi(i));
    end
    
    H = zeros(M,K);
    for m=1:M
        k = f<Hi(m);
        H(m,k) = 0;
        
        k = f>=Hi(m) & f<=Hi(m+1);
        H(m,k) = (f(k)-Hi(m))/(Hi(m+1)-Hi(m));
        
        k = f>=Hi(m+1) & f<=Hi(m+2);
        H(m,k) = (Hi(m+2)-f(k))/(Hi(m+2)-Hi(m+1));
        
        k = f>Hi(m+2);
        H(m,k) = 0;
    end
    %% END.
end

        
    
    