close all
clear

N = 512;

f = 0:1/N:1-1/N;

%rand signal
S = randn(1,N);

H_ideal = zeros(1,N); H_ideal(1:N/2) = 1;
h = ifft(H_ideal,2*N);
h2 = fftshift(h)
h2 = abs(h2(N-20: N+20));

y = conv(S,h2);

figure
plot(y)

figure
plot(abs(fft(y)))

figure
plot(abs(fft(S)))