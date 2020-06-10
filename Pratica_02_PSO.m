close all
clear all
clc, tic

%% PRATICA 2 - CONTROLE INTELIGENTE
% ================ Position Swarm Optimizer - PSO ================

%% Par�metros do algoritmo
imax=100;    % M�ximo de Intera��es
eps=1e-2;    % Crit�rio de parada
C1=0.50;     % Termo cognitivo
C2=0.30;     % Termo de aprendizagem social
W=0.15;      % Termo de in�rcia
N=50;        % N�mero de individuos

%% Meio Ambiente
x_min=-1; x_max=2;
x=x_min:0.001:x_max;
fx=x.*sin(10*pi.*x)+1;

%% 1.Primeira gera��o
x_i=x_min+(x_max-x_min)*rand(N,1);

feval=x_i.*sin(10*pi.*x_i)+1;
enxame = [x_i feval];

V(:,1)=zeros(size(enxame,1),1);
%% Inicializa��o
i=1; k=1; erro=2*eps; % Vetores de acumula��o
%% Processo Interativo
while (k<=imax)&&(erro(1,end)>eps) % Crit�rios de parada
    %% Melhor global
    G_best=evaluation(enxame);

    for i=1:1:size(enxame,1)
        %% Avalia��o da extremidade esquerda
        if i==1
            P_best=evaluation(enxame(i:(i+1),:));
            V(i,k+1)=W*V(i,k)+C1*rand*(P_best-enxame(i,end-1))+C2*rand*(G_best-enxame(i,end-1));
        end
        %% Avalia��o da extremidade direita
        if i==size(enxame,1)
            P_best=evaluation(enxame((i-1):i,:));
            V(i,k+1)=W*V(i,k)+C1*rand*(P_best-enxame(i,end-1))+C2*rand*(G_best-enxame(i,end-1));
        end
        %% Avalia��o do centro
        if (i<=(size(enxame,1)-1))&&(i>=2)
            P_best=evaluation(enxame((i-1):(i+1),:));
            V(i,k+1)=W*V(i,k)+C1*rand*(P_best-enxame(i,end-1))+C2*rand*(G_best-enxame(i,end-1));
        end
    end
    
    %% Atualiza��o do enxame => Movimento
    enxame(:,end-1)=enxame(:,end-1)+V(:,k+1);
    
    %% Next_Interaction
    [enxame, melhor, feval_media]=next_Interaction(enxame, x_min, x_max);
    k=k+1; erro(1,k)=abs(melhor(end)-feval_media);
    clc, [k, erro(1,end)]
    %% Plot Online
    figure(60);
    plot(x, fx, 'k'); hold on; grid on
    plot(enxame(:,end-1), enxame(:,end),'or');
    axis ([-1.0 2.0 -1.0 3.0]); xlabel('x'); ylabel('f(x)');
    if mod(i,2)==0, hold off, end
    pause(0.1)
    
end

%% Resultado final
tempo=toc; If=k-1;

clc,
fprintf('\n ============= PSO =============');
fprintf('\nIntera��es  = %.0f \n', If);
fprintf('      Erro  = %.6s\n', erro(1,end));
fprintf('      Tempo = %.3f s\n\n', tempo);
%% Plot's

figure(2);
mesh(V); hold on
surface(V);
colorbar('AxisLocation','in')
xlabel('Intera��es')
ylabel('N�mero de Indiv�duos')
zlabel('Movimento')

%% Plot's
figure(3);
subplot(2,1,1) % PLOT DA POPULA��O INICIAL
plot(x, fx, 'b'); hold on
plot(x_i, feval,'or'); grid on
legend('Curva f(x)','Popula��o','Location','northwest');
axis ([-1.0 2.0 -1.0 3.0]); xlabel('x'); ylabel('f(x)');
title('Popula��o Inicial');

subplot(2,1,2) % PLOT DA POPULA��O INICIAL
plot(x, fx, 'b'); hold on
plot(enxame(:,end-1), enxame(:,end),'or'); grid on
legend('Curva f(x)','Popula��o','Location','northwest');
axis ([-1.0 2.0 -1.0 3.0]); xlabel('x'); ylabel('f(x)');
title('Popula��o Final');

%% Erro
figure();
plot(1:1:If, erro(1,2:1:end), 'r'); hold on
plot(1:1:If, erro(1,2:1:end), 'kx');
plot(1:1:If, ones(1, size(erro(1,2:1:end),2))*eps, 'k--');
xlim([1 size(erro(1,2:1:end),2)]);grid on
xlabel('Gera��es'); ylabel('Erro');
