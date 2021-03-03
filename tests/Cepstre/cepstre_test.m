clear; close all; clc

%% Param

p = 2;
N = 550;
Nfft = 512;
m=0;
sigma2 = 1;

axe_freq = (-Nfft/2):((Nfft/2)-1);
axe_temp = 1:N;

%% Signal de base

X = sin(2*pi*0.1*axe_temp);
Y = sqrt(sigma2)*randn(1,N) + m;

%% Processus AR

A = estimate_ar(X,p);
B = 1;

noise = sqrt(sigma2)*randn(1,N) + m;

y = filter(B,A,noise);

%% Frequentiel

y_fft = fftshift(abs(fft(y,Nfft) ));
X_fft = fftshift(abs(fft(X,Nfft) ));

%% Ceptre

C_1 = cepstre(conv(X,Y),Nfft);

C_Y = cepstre(Y,Nfft);
C_y = cepstre(y,Nfft);
C_X = cepstre(X,Nfft);

%% Representation

figure,
subplot(311)
plot(y), title('Processus AR');
subplot(312)
plot(axe_freq, y_fft), title('Transformée de Fourier'), xlabel('Fréquence');
subplot(313)
plot(axe_freq, C_y), title('Cesptre'), xlabel('Quéfrence');


figure,
subplot(311)
plot(X), title('Signal');
subplot(312)
plot(axe_freq, X_fft), title('Transformée de Fourier'), xlabel('Fréquence');
subplot(313)
plot(axe_freq, C_X), title('Cesptre'), xlabel('Quéfrence');


figure,
subplot(311)
plot(1:512, (C_1)), title('Cepstre des signaux X*Y'), xlabel('Quéfrence');
subplot(312)
plot(1:512, (C_X)), title('Cepstre de X'), xlabel('Quéfrence');
subplot(313)
plot(1:512, (C_Y)), title('Cepstre de Y'), xlabel('Quéfrence');
