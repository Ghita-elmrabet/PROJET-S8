function [ ECG_integrate ] = pan_tompkins( ECG, Fe )

ECG_low = filter( [1,0,0,0,0,0,-2,0,0,0,0,0,1], [1,-2,1], ECG);

ECG_high = filter( [-1/32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1/32], [1,-1], ECG_low);

ECG_deriv = filter( 0.1*[2,1,0,-1,-2], 1, ECG_high);

ECG_squared = ECG_deriv.^2;

N_window = floor(0.15*Fe);

ECG_integrate = filter( 1/N_window*ones(N_window,1), 1, ECG_squared );



end

