function [dsp]=LPC(f,p_ar,p,Fe)
addpath('../LAR/');
%Mettre Fe à  1 si on travaille en frequences normalisées
[LAR, coefs_ref, thetap] = lar_function(p_ar, p);
r_xx=xcorr(p_ar,'biased');
m=find(r_xx==max(r_xx),1);
AR=[1,thetap];
var=0;
for i=0:p
var=var+AR(i+1)*r_xx(m-i);
end
h=freqz(1,AR,2*pi*f/Fe);
dsp=abs(h).^2*var;
figure(2)
hold on
plot(f,dsp,'DisplayName','Densité spectrale de puissance du processus autoregressif');
xlabel('Axe des fréquences');
ylabel('Amplitudes');

end
