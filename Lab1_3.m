%LAB 1_3
clear all; close all;

%Zmienne
std = sqrt(0.64);
Tp = 0.001;
N = 2000;
H = tf([0.1], [1 -0.9], Tp);
tn = [0:N-1]*Tp;

%"Definicja sygnałów
e = std*randn(1, N);
x = sin(2*pi * 5*tn);
y = sin(2*pi * 5*tn) + e;
v = lsim(H, e, tn);

%% KROPKA 1 - wykresy
%Plot
figure
subplot(2,2,1);
plot(e);
title('szum e(n)');

subplot(2,2,2);
plot(x);
title('Sygnał x(n)');
ylabel('Amplituda');


subplot(2,2,3);
plot(y);
title('Zaszumiony sygnal y(n)');

subplot(2,2,4);
plot(v);
title('Syngal po filtracji v(n)');

%% KROPKA 2
%"OBLICZANIE estymatora funkcji autokorelacji - Ocena stopnia korelacji między kolejnymi próbkami w sygnale 
ac_e = xcorr(e, 'unbiased');
ac_x = xcorr(x, 'unbiased');
ac_y = xcorr(y, 'unbiased');
ac_v = xcorr(v, 'unbiased');

%% KROPKA 3
%"Własność W1 - symetria względem przesunięcia zerowego 
%%Estymator obciążony dla całego zakresu 
aco_e = xcorr(e, 'biased');
aco_x = xcorr(x, 'biased');
aco_y = xcorr(y, 'biased');
aco_v = xcorr(v, 'biased');

%%dla i [-(N-1); N-1]
i_val = -(N-1):(N-1);

%ODP:
%%*Estymator funkcji dla każdego z sygnałów jest symetryczny względem 0, co
%potwierdza własność W1.
%%*Spełniona jest własność W2, tzn. wartość sygnału w próbce i = 0 jest
%największa
%%*Spełniona jest własność W3, tzn. wartość estymatora szumu e w próbce i=0
%równa jest wariancji szumu, wartości estymatora funkcji poza argumentem=0
% są zbliżone od 0

%% KROPKA 4
%"RÓŻNICA w przebiegu funkcji autokorelacji przy zastosowaniu estymatora
%obciążonego i nieobciążonego 
figure 
subplot(4, 2, 1);
stem(i_val, aco_e);
title('Estymator obciążony dla e(i)')

subplot(4, 2, 2)
stem(i_val, ac_e);
title('Estymator nieobciążony dla e')

subplot(4, 2, 3);
stem(i_val, aco_x);
title('Estymator obciążony dla x(i)')

subplot(4, 2, 4)
stem(i_val, ac_x);
title('Estymator nieobciążony dla x')

subplot(4, 2, 5);
stem(i_val, aco_y);
title('Estymator obciążony dla y(i)')

subplot(4, 2, 6)
stem(i_val, ac_y);
title('Estymator nieobciążony dla y')

subplot(4, 2, 7);
stem(i_val, aco_v);
title('Estymator obciążony dla v(i)')

subplot(4, 2, 8)
stem(i_val, ac_v);
title('Estymator nieobciążony dla v')
%%ODP: *Estymator nieobciążony daje większe wartości korelacji dla dużych
%przesunięć i

%% KROPKA 5
%"ESTYMATA funkcji autokorelacji sygnału v i e
figure;
plot(i_val, ac_v, 'r');
hold on;
plot(i_val, ac_e, 'b');
hold off;
title('Porównanie estymaty funkcji korelacji')
legend('v(nTp)', 'e(nTp');
%%ODP: Oba estymatory wykazują wzrost wartości wokół tych samych próbek
%%czasu, co świadczy o ich skorelowaniu.w

%% KROPKA 6
%Obliczenie i wykreślenie estymatora funkcji korelacji wzajemnej sygnałów
%y(nTp) i x(nTp).
y_x_corr = xcorr(y, x, 'unbiased');
figure;
plot(i_val, y_x_corr);




