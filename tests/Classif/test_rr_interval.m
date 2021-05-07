addpath('../../src/Classification/');
addpath('../../src/MSE/');

N = 1e4;

i = 2;
FANTANAME_old = ['fantasia/f1o' num2str(i,'%02.f')];
Fe = 250;

[samp]=rdsamp(FANTANAME_old, 2, N);

plot(samp)

%%
pan_tompkins_plt(samp, Fe);