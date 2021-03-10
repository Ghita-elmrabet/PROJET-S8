%Variables
 clear all
 clc
 close all
 N = 100; %nombre echantillons
 sigma=0.4;
 n=sqrt(sigma)*randn(1,N);% bruit blanc gaussien
 p_ar=filter(1,poly([1 0.2 -0.5 0.4]),n);% processus AR
 
 f1=-0.5;
 k=5;
 f2=0.5-1/2^k;
 
 [a1,a2,a3]=aire_trapz_rect(k,f1,f2,p_ar);
 fprintf("calul de l'air (approx trapz)  %d \n",a1);
 fprintf("calul de l'air de matlab (fonction trapz) %d \n",abs(a2));
 fprintf("calul de l'air de matlab (approx rectangles) %d \n",a3);

