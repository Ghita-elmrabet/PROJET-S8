function [rr_int] = ecg_extract_rr(signal, Fe)
    min_peak = Fe/4;
    [peaks,loc] = findpeaks(signal,'MinPeakDistance',min_peak);
    peaks = (peaks - min(peaks)) / (max(peaks) - min(peaks));
    loc = loc(peaks > graythresh(peaks));
    
    loc_s = loc/Fe;
    rr_int = loc_s(2:end) - loc_s(1:end-1);
end