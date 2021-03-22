
clear all
clc
close all

addpath('../../src/DFA/');

N=5000; %nombre d'echantillions
Fe=4;
Te=1/Fe;
% axe des temps
x=Te*(0:N-1);

sigma=1; %variance du BBGC
m=0; %centré
BBG=m+sigma*randn(1,N);% bruit blanc gaussien

signal1=dsp.ColoredNoise('brown',N,1); % bruit marron
brown=signal1();

signal2=dsp.ColoredNoise('pink',N,1); % bruit rose
pink=signal2();

alpha1=DFA(x,BBG);
alpha2=DFA(x,pink);
alpha3=DFA(x,brown);
% d'apres la doc si c un bruit blanc alpha doit valoir 0.5
% d'apres la doc si c un bruit rose alpha doit valoir 1
% d'apres la doc si c un bruit marron alpha doit valoir 1.5

fprintf('alpha BBG: %d \n',alpha1);
fprintf('alpha bruit rose: %d \n',alpha2);
fprintf('alpha bruit marron: %d \n',alpha3);