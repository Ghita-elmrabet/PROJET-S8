function [dsp]=LPC(f,p_ar,sigma,p)
addpath('../LAR/');

[LAR, coefs_ref, thetap] = lar_function(p_ar, p);
AR=[1,thetap];
h=freqz(1,AR,2*pi*f);
dsp=abs(h).^2*sigma^2;
%figure(1),
%plot(f,dsp,'DisplayName','Densité spectrale de puissance du processus autoregressif');
%xlabel('Axe des fréquences');
%ylabel('Amplitudes');

end