addpath('../../src/Classification/');

clear;


N = 1e6;
Fe = 250;
Nb = 10;

SAMP_OLD = {};
SAMP_YOUNG = {};

for i=1:Nb
    i
    FANTANAME_old = ['fantasia/f1o' num2str(i,'%02.f')];
    FANTANAME_young = ['fantasia/f1y' num2str(i,'%02.f')];
    
    [samp]=rdsamp(FANTANAME_old, 2, N);
    samp = pan_tompkins(samp,Fe);
    SAMP_OLD{i} = samp;
    
    [samp]=rdsamp(FANTANAME_young, 2, N);
    samp = pan_tompkins(samp,Fe);
    SAMP_YOUNG{i} = samp;
end

for i=1:Nb
    i+10
    FANTANAME_old = ['fantasia/f2o' num2str(i,'%02.f')];
    FANTANAME_young = ['fantasia/f2y' num2str(i,'%02.f')];
    
    [samp]=rdsamp(FANTANAME_old, 2, N);
    samp = pan_tompkins(samp,Fe);
    SAMP_OLD{10+i} = samp;
    
    [samp]=rdsamp(FANTANAME_young, 2, N);
    samp = pan_tompkins(samp,Fe);
    SAMP_YOUNG{10+i} = samp;
end

SAMP_YOUNG(20) = [];
SAMP_YOUNG(19) = [];
SAMP_YOUNG(18) = [];
SAMP_YOUNG(15) = [];
SAMP_OLD(20) = [];
SAMP_OLD(15) = [];
SAMP_OLD(12) = [];
SAMP_OLD(8) = [];


save("mat_fix2_fantasia_rr_interval_N_1e6_16");
