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
        FILTRE = @(s) filtre_chebyshev2(s);
    elseif strcmp(filtre, "fenetre")
        FILTRE = @(s) filtre_fenetre(s);
    elseif strcmp(filtre, "hamming")
        FILTRE = @(s) filtre_hamming(s);
    elseif strcmp(filtre, "hanning")
        FILTRE = @(s) filtre_hanning(s);
    elseif strcmp(filtre, "blackman")
        FILTRE = @(s) filtre_blackman(s);
    elseif strcmp(filtre, "blackman_coff")
        coff = myvarargin{2};
        N = myvarargin{3};
        FILTRE = @(s) filtre_blackman_coff(s,coff,N);
    elseif strcmp(filtre, "blackman_rate")
        rate = myvarargin{2};
        N = myvarargin{3};
        FILTRE = @(s) filtre_blackman_rate(s,rate, N);
    elseif strcmp(filtre, "none")
        FILTRE = @(s) filtre_none(s);
    else
        error(['Wrong filtre name, please instead use : ' newline  ...
            'moyenneur' newline...
            'butterworth' newline...
            'chebyshev1' newline...
            'chebyshev2' newline...
            'fenetre' newline...
            'hamming' newline...
            'hanning' newline...
            'blackman' newline...
        ]);
    end
end