close all

Nb = 6; % ordre du filtre
t = 2;

[b,a] = butter(Nb,0.5/t);

N = 1000;

S = randn(1,N);

axe_f = (0:1/N:1-1/N)*2*pi;
[h,w] = freqz(b,a,axe_f);

fenetre = zeros(1,N); fenetre(1:20) = 1;

h_tmp = ifft(h);
h_tmp2 = real(h_tmp.*fenetre);

fenetre_fft = fft(fenetre);

figure
[resp,~] = freqz(h_tmp2,1,axe_f);
plot(abs(resp))
figure
[r,w] = freqz(b,a,axe_f);
plot(abs(r))
figure
plot(abs(conv(h,fenetre_fft)))


y1 = filter(b,a,S);
y2 = conv(S,h_tmp2);

figure
plot(S)
figure
plot(y2(1:1000))





% plot(w,abs(h))