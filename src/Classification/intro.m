clear all; close all; clc
addpath('../../../archive/WFDB')
ECG = load('HR00002.mat');

fe = 500;

axe_temps = 0:1/fe:10;
axe_temps = axe_temps(1:end-1);

figure,
subplot(321)
plot(axe_temps,ECG.val(2,:))

subplot(322)
plot(axe_temps,ECG.val(4,:))

subplot(323)
plot(axe_temps,ECG.val(6,:))

subplot(324)
plot(axe_temps,ECG.val(7,:))

subplot(325)
plot(axe_temps,ECG.val(8,:))

subplot(326)
plot(axe_temps,ECG.val(9,:))
xlabel('Secondes');
ylabel('10e-6 Volt /LSB');