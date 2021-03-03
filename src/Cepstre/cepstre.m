function C = ceptre( X, Nfft  )
    X_fft = abs(fft(X,Nfft));
    C = ifft(log(X_fft),Nfft);
end

