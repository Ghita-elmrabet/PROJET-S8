function [Hz] = MeltoHz(Mel)
    %% Inputs:
    % Mel: Frequency (MEL)
    
    %% Outputs:
    % Hz: Frequency (Hz)
    
    %% START:
    Hz = 700*exp(Mel/1127) - 700;
    %% END.
end
