clc
clear all
close all

fe = 20;
t = 0:1/fe:5;
s = sin(2*pi*t);

figure
plot(t,s)
hold on
stem(t,s)
xlabel('Time (s)')
ylabel('Sampled signal')
grid

