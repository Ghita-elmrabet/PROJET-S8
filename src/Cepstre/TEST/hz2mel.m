function [Mel] = HztoMel(f)
    %% Inputs:
    % f: Frequency (Hz)
    
    %% Outputs:
    % Mel: Frequency (MEL)
    
    %% START:
    Mel = 2595*log10(1 + (f/700));
    %% END.
end
