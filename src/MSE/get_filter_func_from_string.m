function [FILTRE] = get_filter_func_from_string(myvarargin)
    if ~length(myvarargin)
        filtre = "moyenneur";
    else
        filtre = myvarargin{1};
    end

    if strcmp(filtre, "moyenneur")
        FILTRE = @(s) filtre_moyenneur(s);
    elseif strcmp(filtre, "butterworth")
        FILTRE = @(s) filtre_butterworth(s);
    elseif strcmp(filtre, "chebyshev1")
        FILTRE = @(s) filtre_chebyshev1(s);
    elseif strcmp(filtre, "chebyshev2")
        FILTRE = @(s) filtre_chebyshev1(s);
    elseif strcmp(filtre, "chebyshev1_nul_phase")
        FILTRE = @(s) filtre_chebyshev1_nul_phase(s);
    elseif strcmp(filtre, "chebyshev2_nul_phase")
        FILTRE = @(s) filtre_chebyshev2_nul_phase(s);
    else
        error(['Wrong filtre name, please instead use : ' newline  ...
            'moyenneur' newline...
            'butterworth' newline...
            'chebyshev1' newline...
            'chebyshev2' newline...
            'chebyshev1_nul_phase' newline...
            'chebyshev2_nul_phase' newline...
        ]);
    end
end