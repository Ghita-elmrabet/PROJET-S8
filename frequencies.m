 clear all;
 close all;
 clc;
 %% Paramètres 
 hzVect=[20:100:20000];%vecteur des fréquences pour la gamme audible pour un humain 
 %% Conversion des échelles 
 
melVect = hz2mel(hzVect); % conversion de HZ en mel
plot(hzVect,melVect)
title('Mel vs Hz')
xlabel('Hz')
ylabel('Mel')
figure;
barkVect=hz2bark(hzVect)  % conversion de hertz en Bark
plot(hzVect,barkVect)
title('Bark vs Hz')
xlabel('Hz')
ylabel('Bark')
grid on