close all; clear all;
%parametry
Tp = 0.001;
sigma = 0.8;
N= 2000;
n = 0:N-1;
tn = n*Tp;
%Syngały 
x = sin(2*pi*5*n*Tp)+0.5*sin(2*pi*10*n*Tp)+0.25*sin(2*pi*30*n*Tp);
e = sigma*randn(1, N);
H = tf([0.1], [1 -0.9], Tp);
v = lsim(H, e, tn);

%% KROPKA 1
%WSZYSTKIE sygnały w dziedzinie czasu dyskretnego

figure
subplot(2,2,1);
plot(e);
title('szum e(n)');

subplot(2,2,2);
plot(x);
title('Sygnał x(n)');

subplot(2,2,3);
plot(v);
title('Szum po filtracji v(n)');

%% KROPKA 2
%OBLICZANIE widma amplitudowego sygnału x(n)
x_fft = fft(x);
x_fft = x_fft*Tp;
%%Wektor częstotliwości 
omega = (0:N-1)/(N*Tp);
figure 
plot(omega, abs(x_fft));
grid on;
title("Dyskretne widmo amplitudowe |X_N(j*omega_k)|")
%%%Wysokość prążków widma na wykresie odpowiada składowym amplitud sygnału
%sinusoidlanego wejściowego. Prążki widma pojawiają się w częstotliwościach
%odpowiadających danym sinusom wejściowym

%% KROPKA 3
%WPŁYW liczby próbek sygnału na jakość otrzymanego widma amplitudowego
N_1 = 1000; % 100 próbek na okres
N_2 = 200;  % 20 próbek na okres
N_3 = 100;  % 10 próbek na okres
n_1 = 0:N_1-1;
n_2 = 0:N_2-1;
n_3 = 0:N_3-1;
x_1 = sin(2*pi*5*n_1*Tp)+0.5*sin(2*pi*10*n_1*Tp)+0.25*sin(2*pi*30*n_1*Tp);
x_2 = sin(2*pi*5*n_2*Tp)+0.5*sin(2*pi*10*n_2*Tp)+0.25*sin(2*pi*30*n_2*Tp);
x_3 = sin(2*pi*5*n_3*Tp)+0.5*sin(2*pi*10*n_3*Tp)+0.25*sin(2*pi*30*n_3*Tp);
x1_fft = fft(x_1)*Tp;
x2_fft = fft(x_2)*Tp;
x3_fft = fft(x_3)*Tp;
omega_1 = (0:N_1-1)/(N_1*Tp);
omega_2 = (0:N_2-1)/(N_2*Tp);
omega_3 = (0:N_3-1)/(N_3*Tp);
figure;
plot(omega_2, x_2);
title("dodatkowy plot")

figure
subplot(2,2,1);
plot(omega_1, abs(x1_fft));
title("Dyskretne widmo amplitudowe dla N = 1000");

subplot(2,2,2);
plot(omega_2, abs(x2_fft));
title("Dyskretne widmo amplitudowe dla N = 200");

subplot(2,2,3);
plot(omega_3, abs(x3_fft));
title("Dyskretne widmo amplitudowe dla N = 100");

% Im mniejsza liczba próbek, tym  mniejsza rozdzielczość częstotliwościowa.
% Wyciek widma możemy zaobserwować dla składowych o częstotliwościach 10 i
% 30. Prążek amplitudowy rozmywa się na leżące obok częstotliwości, efekt
% ten jest im większy im mniejsza jest liczba próbek.

%% KROPKA 4
% SPRAWDZENIE twierdzenia Parsevala 
% %Dla czasu:
% parseval_t = sum(x.^2)*Tp;
% parseval_f = sum(abs(x_fft.^2)*1/(N*Tp));
% twierdzenie parsevala mówiące o możliwości obliczenia całkowitej energii
% %niesionej przez sekwencję próbek zarówno w dziedzinie czasu jak i
% dedczęstotliwości jest spełnione.

%% KROPKA 5
%OBLICZYĆ i wykreślić estymatę gęstości widmowej mocy. Sprawdzić jaki wpływ
%ma wartość wariancji na estymatę gęstości.
%%metoda bezpośrednia:
e_fft = fft(e);
ge_fft = Tp/N * abs(e).^2;
ge_f = 2*pi*(0:N-1)/N;
figure
plot(ge_f, ge_fft);
title('Estymacja gęstości widmowej mocy metodą bezpośrednią');

%%metoda korelogramowa 
M_w = N/5;                  % szerokość połowy okna
w_i = 1;                    % można zmienić wartość w_i w celu implementacji innego okna
omega_k = 2*pi*(0:N-1)/N;   % kolejne prążki OMEGA

%obliczenie estymatora funkcji autokorelacji
r_xx = xcorr(e, 'unbiased');
PHI_xx = zeros(N);                % wykres metodą korelogramową
for k = 1:N
    sum = 0;
    for i = N-M_w:N+M_w
        sum = sum + (  w_i*r_xx(i)*exp(-1i*omega_k(k)*i)  );
    end
    PHI_xx(k) = sum*Tp;
end

figure;
plot(omega_k, PHI_xx);
title("Metoda korelogramowa z oknem prostokątnym");
