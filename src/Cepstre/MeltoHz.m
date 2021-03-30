function [Hz] = MeltoHz(Mel)
    %% Inputs:
    % Mel: Frequency (MEL)
    
    %% Outputs:
    % Hz: Frequency (Hz)
    
    %% START:
    Hz = 700*exp(Mel/2595) - 700;
    %% END.
end
