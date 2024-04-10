%LAB 1_2
load('StochasticProcess.mat')

%Estymaty po realizacjach
%%Wartość średnia 
m_po_real = [];
for i = 1:1001
    wn = mean(StochasticProcess(2:501, i));
    m_po_real(i) = wn;
end

%%Wariancja
var_po_real = [];
for i = 1:1001
    wn = var(StochasticProcess(2:501, i));
    var_po_real(i) = wn;
end

%Estymaty po czasie
%%Wartość średnia
m_po_t = [];
for i = 2:501
    wn = mean(StochasticProcess(i,:));
    m_po_t(i-1) = wn; 
end

%%Wariancja
var_po_t = [];
for i = 2:501
    wn = var(StochasticProcess(i,:));
    var_po_t(i-1) = wn; 
end


subplot(3,1,1)
plot(1:500,m_po_t, 'b',1:1001, m_po_real, 'r');
title('Wartość średnia po czasie i po realizacjach');
legend('po czasie', 'po realizacjach');
grid on;

subplot(3,1,2)
plot(1:500,var_po_t, 'b',1:1001, var_po_real, 'r');
title('Wariancja po czasie i po realizacjach');
legend('po czasie', 'po realizacjach');
grid on;

%Wartości średnie 
Sr_m_po_real = mean(m_po_real);
Sr_m_po_t = mean(m_po_t);

Sr_var_po_real = mean(var_po_real);
Sr_var_po_t = mean(var_po_t);

%Czy jest ergodyczny?
%%układ jest ergodyczny, średnie wartości średnich oraz wariancji po czasie i po realizacjach są takie same.

%Czy jest stacjonarny?
%%układ nie jest stacjonarny, wariancje zmiennych losowych nie są takie same.





