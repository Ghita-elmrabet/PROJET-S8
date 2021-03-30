clc
clear all
close all

N = 13;
L = 22;

x = 0:N-1
y = 1 + 0.5*sin((pi*[0:N-1])/L);

figure
plot(x,y)