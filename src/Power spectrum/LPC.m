function [dsp]=LPC(f,p_ar,sigma,p,Fe)
addpath('../LAR/');
%Mettre Fe à  1 si on travaille en frequences normalisées
[LAR, coefs_ref, thetap] = lar_function(p_ar, p);
AR=[1,thetap];
h=freqz(1,AR,2*pi*f/Fe);
dsp=abs(h).^2*sigma^2;
figure(2)
hold on
plot(f,dsp,'DisplayName','Densité spectrale de puissance du processus autoregressif');
xlabel('Axe des fréquences');
ylabel('Amplitudes');

end