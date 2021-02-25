close all
clear all
clc

% Parametres
N = 5000; % nombre d'echantillons
p = 4; % ordre
z = 0:1:N-1;
sigma = 1;

% D?finition des poles 
R1=0.8;
R2=0.7;
theta1=pi/3;
theta2=pi/4;
p1=R1*exp(1i*theta1);
p2=R1*exp(-1i*theta1);
p3=R2*exp(1i*theta2);
p4=R2*exp(-1i*theta2);

% Decompostion en elements simples 
a0=1;
a1= -(p1+p2+p3+p4);
a2=(p1*p2)+(p3*p4)+(p1+p2)*(p3+p4);
a3=(-p1*p2*(p3+p4))+(-p3*p4*(p1+p2));
a4=p1*p2*p3*p4;
Poles=[1 a1 a2 a3 a4];
Zeros=[1 0 0 0 0 ];

%% FILTRE
%Placer ses poles et ses zeros dans le plan complexe
zplane(Zeros,Poles);
title('cercle des poles et des zeros');
xlabel('Partie reelle');
ylabel('Partie imaginaire');


 

 
 %% Parametres alternatifs : paires de raies spectrales
 
% Polynome A
polynom_a_1surz = [a4 a3 a2 a1 a0];
racines_a_1surz = roots(polynom_a_1surz);
for k =1:4
    racines_a(k) = 1/racines_a_1surz(k);
end
 
% Polynome P
polynom_p_1surz = [a0 (a1+a4) (a2+a3) (a2+a3) (a1+a4) a0];
racines_p_1surz = roots(polynom_p_1surz);
for k =1:5
    racines_p(k) = 1/racines_p_1surz(k);
end

% Polynome Q
polynom_q_1surz = [-a0 (a4-a1) (a3-a2) (a2-a3) (a1-a4) a0];
racines_q_1surz = roots(polynom_q_1surz);
for k =1:5
    racines_q(k) = 1/racines_q_1surz(k);
end


blue = [0, 0.4470, 0.7410];
red = [0.8500, 0.3250, 0.0980];
yellow = [0.9290, 0.6940, 0.1250];
black = [0.25, 0.25, 0.25];

figure
plot(racines_a,'*','MarkerSize',7,'Color',blue)
hold on
plot(racines_p,'+','MarkerSize',7,'Color',red)
hold on
plot(racines_q,'o','MarkerSize',7,'Color',yellow)
title('Racines des polynomes A(z), P(z) et Q(z)'); 

hold on
plot (cos([0:0.01:2*pi]),sin([0:0.01:2*pi]),'--','Color',black) % cercle unite

% Trace des rayons
for k = 1:4
    hold on
    plot([0 real(racines_a(k))],[0 imag(racines_a(k))],'Color',blue,'Linewidth',1)
end

for k =1:5
    hold on
    plot([0 real(racines_p(k))],[0 imag(racines_p(k))],'Color',red,'Linewidth',1)
    hold on
    plot([0 real(racines_q(k))],[0 imag(racines_q(k))],'Color',yellow,'Linewidth',1)
end
legend({'A(z)','P(z)','Q(z)'},'Location','eastoutside');
axis equal
ylim([-1.1 1.1])
