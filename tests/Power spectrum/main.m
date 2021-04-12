clc
close all
clear all



addpath('../../src/Power spectrum/');

N=5000; %nombre d'echantillions
p=4; %ordre du processus AR
sigma=0.5; %variance du BBGC
m=0; %centré
Fe=4;
Te=1/Fe;
% axe des frequences
t=Te*(0:N-1);
% axe des frequences

%n=2^nextpow2(N); % au cas ou on veut faire du padding
%f=-1/2:1/N:1/2-1/N; % freq normalisées
%f= -Fe/2:Fe/n:Fe/2-Fe/n;
f=0:Fe/N:Fe-Fe/N;

%géneration des poles
 theta=[7*pi/9,2*pi/9];
 R=[0.9 0.9 0.98 ];
 p1=R(1)*exp(1j*theta(1));
 p2=R(2)*exp(1j*theta(2));
 P=[p1,p2,conj(p1),conj(p2)];
 % génération du signal
 nom=[1,0,0,0,0];
 denom=poly(P);
 b=m+sigma*randn(1,N);% bruit blanc gaussien
 p_ar=filter(nom,denom,b); % processus AR ( signal à traiter)
 
  figure(1)
  plot(t,p_ar);
  xlabel('Axe des temps');
  ylabel('Amplitudes');
  title('Représentation temporelle du signal');
 
%% approche LPC
 dsp1=LPC(f,p_ar,p,Fe); %ne pas oublier de mettre Fe à  1 si on travaille en frequences normalisées
%Calcul d'air meth des rectangles
  p_LF11=aire_rec(f,dsp1,0.04,0.15);
  p_HF12=aire_rec(f,dsp1,0.15,0.4);
  R1=p_HF12/p_LF11;
%Calcul d'air meth des trapèzes 
  p_LF21=aire_trapeze(f,dsp1,0.04,0.15);
  p_HF22=aire_trapeze(f,dsp1,0.15,0.4);
  R2=p_HF22/p_LF21;
%% approche fft
  dsp2=wiener(f,p_ar,N);
%Calcul d'air meth des rectangles
 p_LF13=aire_rec(f,dsp2,0.04,0.15);
 p_HF14=aire_rec(f,dsp2,0.15,0.4);
 R3=p_HF14/p_LF13;
%Calcul d'air meth des trapèzes 
  p_LF23=aire_trapeze(f,dsp2,0.04,0.15);
  p_HF24=aire_trapeze(f,dsp2,0.15,0.4);
  R4=p_HF24/p_LF23;
% Verification des resultats
PW1=bandpower(abs(p_ar),f,'psd'); % puissance véhiculée dans tout le signal calculé par matlab
PW2=aire_rec(f,abs(dsp1),0,Fe-Fe/N);
PW3=aire_rec(f,abs(dsp2),0,Fe-Fe/N);

fprintf('puissance véhiculée dans tout le signal calculé par matlab: %d \n',PW1);
fprintf('puissance véhiculée dans tout le signal (LPC): %d \n',PW2);
fprintf('puissance véhiculée dans tout le signal (Wiener Khinchin): %d \n',PW3);