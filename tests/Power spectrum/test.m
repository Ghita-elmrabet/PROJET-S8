clear all
close all
clc

%Variables

N = 5000; %nombre echantillons
p = 4; %ordre
moy = 0; %moyenne BBG
sigma = 1; %variance BBG
BBG = moy + sigma*(randn(1,N)+1j*randn(1,N));
count = 0;
valide = 0;
Fe = 1;
f = -1/2:1/N:1/2-1/N; %axe frequence

while valide == 0
    coeff_reel = randi([-9.99999*10^5,9.99999*10^5],1,p); %coefficients polynome
    coeff_reel = coeff_reel./10^6; %compris entre -1 et 1
    coeff_img = randi([-9.99999*10^5,9.99999*10^5],1,p);
    coeff_img = coeff_img./10^6;
    pi_coef_img = coeff_reel + 1j*coeff_img
    for i=1:p
        if sqrt(real(pi_coef_img(1,i)).^2 + imag(pi_coef_img(1,i)).^2) > 1 
            valide = 0;
            count = count + 1
            break;
        else
            valide = 1;
        end    
    end
end

%Rapport signal sur bruit
RSB1 = -5;
RSB2 = 0;
RSB3 = 10;
    
%Fonction de transfert
poly_genere_img = poly(pi_coef_img);
H = [[1, 0, 0 ,0 , 0];[poly_genere_img(1,1), poly_genere_img(1,2), poly_genere_img(1,3), poly_genere_img(1,4), poly_genere_img(1,5)]];
h = freqz(H(1,:), H(2,:), 2*pi*f);

%Affichage des poles/zeros
zplane(H(1,:), H(2,:));

% Processus genere (apres filtre)
proc_auto_reg_img = filter(H(1,:), H(2,:), BBG);
par_f = temp_freq_display(Fe, N,proc_auto_reg_img);
pow_spectrum = power_spectrum(Fe, N,proc_auto_reg_img);
zero_number = zero_crossing(proc_auto_reg_img);

Aire_trapeze = aire_trapz_fft(-0.12,0.24,proc_auto_reg_img);
Aire_rectangle = aire_rec(-0.12,0.24,f,proc_auto_reg_img );

Aire_trapeze_total = aire_trapz_fft(-0.5,0.49,proc_auto_reg_img);
Aire_rectangle_total = aire_rec(-0.5,0.49,f,proc_auto_reg_img);

matlab_function=trapz(f,pow_spectrum) %fct de verification sur -O.5 a 0.5

%Affichage

fprintf('Trapeze Method: The spectrum power between f1 and f2 :\n');
disp(Aire_trapeze);
fprintf('Rectangle Method: The spectrum power between f1 and f2 :\n');
disp(Aire_rectangle);

fprintf('Trapeze Method: The spectrum power between -0.5 and 0.49 :\n');
disp(Aire_trapeze_total);
fprintf('Rectangle Method: The spectrum power between -0.5 and 0.49 :\n');
disp(Aire_rectangle_total);

